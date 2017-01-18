--[[
Item: "Brave Shoe"
-xahos-
--]]

local Afterbrasse = RegisterMod("Brave Shoe", 1);
local brave_shoe_item = Isaac.GetItemIdByName("Brave Shoe");

function Afterbrasse:take_damage(entity, dmg_amount, dmg_flag, dmg_src, dmg_countdown)
  player = Isaac.GetPlayer(0)
  
  if player:HasCollectible(brave_shoe_item) then
    if (dmg_flag == DamageFlag.DAMAGE_SPIKES) then
      return false
    end
  end
  return true
end

function Afterbrasse:cacheUpdate(player, cacheFlag)
  if player:HasCollectible(brave_shoe_item) then
    if (cacheFlag == CacheFlag.CACHE_SPEED) then
      player.MoveSpeed = player.MoveSpeed + 0.2;
    end
  end
end

Afterbrasse:AddCallback(ModCallbacks.MC_ENTITY_TAKE_DMG, Afterbrasse.take_damage, EntityType.ENTITY_PLAYER)
Afterbrasse:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, Afterbrasse.cacheUpdate)