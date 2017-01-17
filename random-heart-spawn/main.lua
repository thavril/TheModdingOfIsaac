local debug = require('debug');
local xahos = RegisterMod("Random Heart Spawn", 1);
local heart_generator_item = Isaac.GetItemIdByName("heartGenerator")

function xahos:use_heart_generator_item()
  local player = Isaac.GetPlayer(0);
  local pos = Isaac.GetFreeNearPosition(player.Position, 80.0)
  local random = Random() % 100
  if random <= 20 then
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, pos, Vector(0, 0), player)
    local pos2 = Isaac.GetFreeNearPosition(player.Position, 80.0)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_BLACK, pos2, Vector(0, 0), player)
  else
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL, pos, Vector(0, 0), player)
    local pos2 = Isaac.GetFreeNearPosition(player.Position, 80.0)
    Isaac.Spawn(EntityType.ENTITY_PICKUP, PickupVariant.PICKUP_HEART, HeartSubType.HEART_SOUL, pos2, Vector(0, 0), player)
  end
end

xahos:AddCallback(ModCallbacks.MC_USE_ITEM, xahos.use_heart_generator_item, heart_generator_item);









