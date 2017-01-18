StartDebug()
local debug = require('debug');
local xahos = RegisterMod("The one Shoe to rule them all", 1);
local brave_shoe_item = Isaac.GetItemIdByName("Brave Shoe");

debug_text = "pas ditems frerot"

function xahos:item_effect(current_player)
  player = Isaac.GetPlayer(0)
  
  if player:HasCollectible(brave_shoe_item) then
    room = Game():GetRoom();
    grid_size = room:GetGridSize();
    
    debug_text = "jai la size"
    for i = 0, grid_size-1 do
      grid_entity = room:GetGridEntity(i);
      if (grid_entity ~= nil) then
        is_spike = grid_entity:ToSpikes();
        if (is_spike) then
          room:DestroyGrid(i, true)
        end
      end
    end
  end
end

function xahos:cacheUpdate(player, cacheFlag)
  if player:HasCollectible(brave_shoe_item) then
    if (cacheFlag == CacheFlag.CACHE_SPEED) then
      player.MoveSpeed = player.MoveSpeed + 0.2;
    end
  end
end

function xahos:debug_text()
  Isaac.RenderText(debug_text, 100, 100, 255, 0, 0, 255)
end

xahos:AddCallback(ModCallbacks.MC_POST_UPDATE, xahos.item_effect, EntityType.ENTITY_PLAYER)
xahos:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, xahos.cacheUpdate)
xahos:AddCallback(ModCallbacks.MC_POST_RENDER, xahos.debug_text);