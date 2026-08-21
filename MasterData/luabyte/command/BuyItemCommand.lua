--购买道具命令
local BuyItemCommand = BaseClass("BuyItemCommand", BaseCommand)
local M = BuyItemCommand

function M:Execute(shopItemId, Num)
    ShopDataMgr:RequestBuyItem(shopItemId, Num)
end

return BuyItemCommand
