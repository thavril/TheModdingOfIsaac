local debug = require('debug');
local xahos = RegisterMod("The one Shoe to rule them all", 1);
local brave_shoe_item = Isaac.GetItemIdByName("Brave Shoe");

debug_text = "u has no item"

function xahos:cacheUpdate(player, cacheFlag)
  if player:HasCollectible(brave_shoe_item) then
    if (cacheFlag == CacheFlag.CACHE_SPEED) then
      debug_text = "speed up";
      player.MoveSpeed = player.MoveSpeed + 2;
    end
  end
end

function xahos:debug_text()
  Isaac.RenderText(debug_text, 100, 100, 255, 0, 0, 255)
end

xahos:AddCallback(ModCallbacks.MC_EVALUATE_CACHE, xahos.cacheUpdate)
xahos:AddCallback(ModCallbacks.MC_POST_RENDER, xahos.debug_text);