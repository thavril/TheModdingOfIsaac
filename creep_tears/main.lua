--[[
Item: "Creep Tears"
-xahos-
--]]

local debug = require('debug');
local Afterbrasse = RegisterMod("Creep Tears", 1);
local creep_tears_item = Isaac.GetItemIdByName("Creep Tears");

debug_text = "u has no item"

function Afterbrasse:onRender()
  Isaac.RenderText(debug_text, 100, 100, 255, 0, 0, 255)
end

function Afterbrasse:onUpdate(player)
  if player:HasCollectible(creep_tears_item) then
    --debug_text = tostring(player.FireDelay)
    
    shoot_dir = player:GetShootingJoystick()
    if (shoot_dir.X ~= 0 or shoot_dir.Y ~= 0) then
      if (player.FireDelay <= 0) then
        fired_tears_nb = fired_tears_nb + 1
        debug_text = tostring(fired_tears_nb)
        if (fired_tears_nb % 5 == 0) then
          random_pos = Isaac.GetRandomPosition()
          Isaac.Spawn(EntityType.ENTITY_EFFECT, EffectVariant.PLAYER_CREEP_RED, 0, random_pos, Vector(0, 0), player)
        end
      end
    end
  end
end


Afterbrasse:AddCallback(ModCallbacks.MC_POST_RENDER, Afterbrasse.onRender);
Afterbrasse:AddCallback(ModCallbacks.MC_POST_PEFFECT_UPDATE, Afterbrasse.onUpdate)