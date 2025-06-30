-- chunkname: @IQIGame\\Module\\Shop\\MazeShopModule.lua

MazeShopModule = {}
MazeShopModule.AllShopsArr = {}

function MazeShopModule.AddEventListeners()
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.OpenShopCommandEventId, MazeShopModule.OpenMazeShop)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ShopUpdateCommandEventId, MazeShopModule.UpdateMazeShop)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ShopBuyCommandEventId, MazeShopModule.MazeShopBuyGoodsHandler)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ShopRefreshCommandEventId, MazeShopModule.MazeShopUpdateBtnHandler)
end

function MazeShopModule.RemoveEventListeners()
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.OpenShopCommandEventId, MazeShopModule.OpenMazeShop)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ShopUpdateCommandEventId, MazeShopModule.UpdateMazeShop)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ShopBuyCommandEventId, MazeShopModule.MazeShopBuyGoodsHandler)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ShopRefreshCommandEventId, MazeShopModule.MazeShopUpdateBtnHandler)
end

function MazeShopModule.OpenMazeShop(sender, command)
	local MazeShopArg = command:ToLuaTable()

	if MazeShopArg ~= nil and MazeShopArg.ShopData ~= nil then
		MazeShopModule.InsertMazeShopData(MazeShopArg.ShopData)
		UIModule.Open(Constant.UIControllerName.MazeShopUI, Constant.UILayer.UI, MazeShopArg.ShopData.ID)
	end
end

function MazeShopModule.InsertMazeShopData(shopData)
	local hasShopData = false

	for i = 1, #MazeShopModule.AllShopsArr do
		if MazeShopModule.AllShopsArr[i].id == shopData.ID then
			MazeShopModule.AllShopsArr[i].goodsList = shopData.GoodsList
			MazeShopModule.AllShopsArr[i].buyGoodsList = shopData.BuyGoodsList
			MazeShopModule.AllShopsArr[i].freeRefreshCnt = shopData.FreeRefreshCnt
			MazeShopModule.AllShopsArr[i].itemRefreshCnt = shopData.ItemRefreshCnt
			MazeShopModule.AllShopsArr[i].payRefreshCnt = shopData.PayRefreshCnt
			MazeShopModule.AllShopsArr[i].cid = shopData.CID
			hasShopData = true
		end
	end

	if hasShopData == false then
		local mazeShopData = ShopItemData.NewMazeShopData(shopData)

		table.insert(MazeShopModule.AllShopsArr, mazeShopData)
	end
end

function MazeShopModule.UpdateMazeShop(sender, command)
	local MazeShopArg = command:ToLuaTable()

	for i = 1, #MazeShopModule.AllShopsArr do
		if MazeShopModule.AllShopsArr[i].id == MazeShopArg.ShopData.ID then
			MazeShopModule.AllShopsArr[i] = ShopItemData.NewMazeShopData(MazeShopArg.ShopData)

			EventDispatcher.Dispatch(EventID.MazeShopUpdate, MazeShopModule.AllShopsArr[i].id)

			break
		end
	end
end

function MazeShopModule.GetShopDataByShopId(shopId)
	for i = 1, #MazeShopModule.AllShopsArr do
		if MazeShopModule.AllShopsArr[i].id == shopId then
			return MazeShopModule.AllShopsArr[i]
		end
	end

	return nil
end

function MazeShopModule.SendBuyMsg(shopid, goodsIndex)
	local buyData = {}

	buyData.ShopID = shopid
	buyData.Index = goodsIndex

	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SHOP_BUY, buyData)
end

function MazeShopModule.MazeShopBuyGoodsHandler(sender, command)
	local MazeShopBuyGoodsArg = command:ToLuaTable()

	if MazeShopBuyGoodsArg.Code == 0 then
		NoticeModule.ShowNotice(21040017)
		EventDispatcher.Dispatch(EventID.BuyShopItemEvent)
	end
end

function MazeShopModule.SendRefreshMsg(shopid, refreshType)
	local updateData = {}

	updateData.ShopID = shopid
	updateData.Type = refreshType

	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_SHOP_REFRESH, updateData)
end

function MazeShopModule.MazeShopUpdateBtnHandler(sender, command)
	local MazeShopUpdateArg = command:ToLuaTable()

	if MazeShopUpdateArg.Code ~= 0 then
		-- block empty
	end
end
