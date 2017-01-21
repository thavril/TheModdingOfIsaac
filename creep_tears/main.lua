--[[
Item: "Creep Tears"
-xahos-
--]]

local debug = require('debug');
local Afterbrasse = RegisterMod("Creep Tears", 1);
local creep_tears_item = Isaac.GetItemIdByName("Creep Tears");

debug_text = "u has no item"
debug_text_2 = "pouet"
debug_text_3 = "g PAS appuye"
debug_text_4 = "base 100 number"

local frame_count = 0
local spawn_creep = false
local nb_creep_to_spawn = 0
local spawned_creep = 0
local start_creep_position = Vector(0, 0)
local creep_vector_direction = Vector(0, 0)

fired_tears_nb = 0

local function nbCreepForRange(player)
  return 2
end

local function vectorAddition(vector_1, vector_2)
  return Vector(vector_1.X + vector_2.X, vector_1.Y + vector_2.Y)
end

local function luckCalculator(player)
  local luck_for_fifty_fifty = 7 --choose value
  local percentage_per_luck_point = (50 / luck_for_fifty_fifty) --chance to proc effect per luck point (in percentage)
  
  if (player.Luck > 0) then
    return player.Luck * percentage_per_luck_point
  else
    local positive_luck = (player.Luck * -1) + 1 --transform 0 or negative luck to a positive number
    return percentage_per_luck_point / (2 * positive_luck) --each negagive luck puck divide the chance to proc the effect by 2
  end
end

local function spawnCreeps(player, shoot_dir)
  spawn_creep = true
  nb_creep_to_spawn = nbCreepForRange()
  start_creep_position = player.Position
  creep_vector_direction = Vector(shoot_dir.X * 32, shoot_dir.Y * 32)
end

function Afterbrasse:onRender()
  local player = Isaac.GetPlayer(0)
  
  Isaac.RenderText(debug_text, 100, 100, 255, 0, 0, 255)
  Isaac.RenderText(debug_text_2, 100, 110, 255, 0, 0, 255)
  Isaac.RenderText(debug_text_3, 100, 120, 255, 0, 0, 255)
  Isaac.RenderText(debug_text_4, 100, 130, 255, 0, 0, 255)
  
  if (spawn_creep) then
    if (frame_count % 10 == 0) then
      local spawn_position = vectorAddition(start_creep_position, creep_vector_direction)
    
      local creep = Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, spawn_position, Vector(0, 0), player)
      local green_color = Color(0, 255, 0, 255, 0, 0, 0)
      creep:SetColor(green_color, 0, 0, false, false)
      start_creep_position = spawn_position
      spawned_creep = spawned_creep + 1
    end
      
    frame_count = frame_count + 1
      
    if (spawned_creep == nb_creep_to_spawn) then
      spawn_creep = false
      frame_count = 0
      spawned_creep = 0
    end
  end
end

function Afterbrasse:onUpdate(player)
  if player:HasCollectible(creep_tears_item) then
    
    local shoot_dir = player:GetShootingJoystick()
    if (shoot_dir.X ~= 0 or shoot_dir.Y ~= 0) then --Player is firing tears
      if (player.FireDelay == player.MaxFireDelay - 1) then
        fired_tears_nb = fired_tears_nb + 1
        debug_text_2 = tostring(fired_tears_nb)
        local percentage_chance_for_effect_proc = luckCalculator(player)
        debug_text = tostring(percentage_chance_for_effect_proc)
        
        base_100_random = Random() % 100
        debug_text_4 = tostring(base_100_random)
        if (percentage_chance_for_effect_proc >= base_100_random and not spawn_creep) then
          spawnCreeps(player, shoot_dir)
        end
      end
    end
  end
end


Afterbrasse:AddCallback(ModCallbacks.MC_POST_RENDER, Afterbrasse.onRender);
Afterbrasse:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Afterbrasse.onUpdate)