-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerreturn/view/PlayerReturnShopView.lua

module("logic.extensions.playerreturn.view.PlayerReturnShopView", package.seeall)

local PlayerReturnShopView = class("PlayerReturnShopView", TableViewComponent)

function PlayerReturnShopView:ctor()
	PlayerReturnShopView.super.ctor(self)
end

function PlayerReturnShopView:bindEvents()
	PlayerReturnShopView.super.bindEvents(self)
end

function PlayerReturnShopView:unbindEvents()
	PlayerReturnShopView.super.unbindEvents(self)
end

function PlayerReturnShopView:onExit()
	PlayerReturnShopView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PR_UpdataShopInfo, self.updataShopItemShow, self)

	self._curViewDatas = nil
end

function PlayerReturnShopView:destroyUI()
	PlayerReturnShopView.super.destroyUI(self)
end

function PlayerReturnShopView:buildUI()
	PlayerReturnShopView.super.buildUI(self)
end

function PlayerReturnShopView:onEnter()
	PlayerReturnShopView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PR_UpdataShopInfo, self.updataShopItemShow, self)
	PlayerReturnController.instance:csRegressGetShopInfoReq()

	self._actiInfo = PlayerReturnModel.instance:getOpenActivityInfo()
	self._mainCfg = self:getFirstParam()

	if self._mainCfg == nil then
		self._mainCfg = PlayerReturnConfig.instance:getReturnMainViewCfgs(self._actiInfo.actId, 4)
	end

	self:updataShopItemShow()

	local effPath = "fx_ui_qirirenwu/fx_qirirenwu_pingmu.prefab"

	self.pmEff = UIEffectManager.instance:playEffect(self, effPath, self.mainGO, 0, 0, true, nil, nil, nil, self)

	self.pmEff:setParent(self.mainGO.transform)
	self.pmEff:setLocalPos(0, 0, 0)
	self.pmEff:setScale(1)
end

function PlayerReturnShopView:updataShopItemShow()
	self._curViewDatas = PlayerReturnModel.instance:getShopInfoList(self._mainCfg.planId)

	self._tableview:ReloadData()
end

function PlayerReturnShopView:_getPath()
	return {
		cellPath = "cellItem",
		viewPath = "itemListSR"
	}
end

function PlayerReturnShopView:_cellSize()
	return 240, 300
end

function PlayerReturnShopView:_updateCell(view, cell, data)
	local iconImaGo = goutil.findChild(cell, "iconIma")
	local limitTxt = goutil.findChildTextComponent(cell, "limitTxt")
	local matPosList = {
		goutil.findChild(cell, "matPos_1"),
		goutil.findChild(cell, "matPos_2"),
		goutil.findChild(cell, "matPos_3")
	}
	local zhekouTxt = goutil.findChildTextComponent(cell, "zhekouGo/zhekouTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local consumeGo = goutil.findChild(cell, "consumeGo")
	local oldNumTxt = goutil.findChildTextComponent(consumeGo, "oldNumTxt")
	local oldIconIma = goutil.findChild(consumeGo, "oldNumTxt/oldIconIma"):GetComponent("UIImageSpriteChange")
	local nowNumTxt = goutil.findChildTextComponent(consumeGo, "oldNumTxt/nowNumTxt")
	local nowIconIma = goutil.findChild(consumeGo, "oldNumTxt/nowNumTxt/nowIconIma"):GetComponent("UIImageSpriteChange")

	if matPosList and #matPosList > 0 then
		for i = 1, #matPosList do
			if matPosList[i] then
				MaterialMgr.resetAll(matPosList[i])
			end
		end
	end

	GameUtil.asBtn(cell):RemoveClickListener()
	uGuiUtil.setSpriteToImage(iconImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(data.itemIcon))

	limitTxt.text = string.format("永久限购%s/%s", data.limitCount - checknumber(data.buyCount), data.limitCount)
	nameTxt.text = data.itemName

	local count = 1

	if not string.nilorempty(data.price) then
		local list = string.split(data.price, ":")

		count = checknumber(list[3])

		if checknumber(list[1]) == MatType.Diamond_Consume then
			count = GoodsConfig.instance:getCfgPrice(checknumber(list[2])) * count
		end

		MaterialMgr.setIcon(oldIconIma.gameObject, list[1], list[2])
		MaterialMgr.setIcon(nowIconIma.gameObject, list[1], list[2])
	else
		local payCfg = PayConfig.instance:getPayGoodsCfg(data.rmbId)

		count = payCfg and payCfg.payMoney or 100
		count = count * PayModel.RMB_UNIT

		oldIconIma:SetState(1)
		nowIconIma:SetState(1)
		oldIconIma:SetState(0)
		nowIconIma:SetState(0)
	end

	oldNumTxt.text = tostring(math.ceil(count * 1000 / data.discount))
	nowNumTxt.text = tostring(math.ceil(count))
	zhekouTxt.text = data.discount / 100 .. "折"

	local subCount = 0

	if data.contents and #data.contents > 0 then
		subCount = #data.contents
	end

	if subCount > #matPosList then
		subCount = #matPosList
	end

	local posX = -38 * (subCount - 1)

	for i = 1, subCount do
		local list = string.split(data.contents[i], ":")
		local goodsType = checknumber(list[1])
		local goodsId = checknumber(list[2])
		local subLua = MaterialMgr.setCell(goodsType, goodsId, matPosList[i])

		Framework.TransformUtil.SetLocalPos(matPosList[i].transform, posX + 76 * (i - 1), -67, 0)
		subLua.binder:setNum(checknumber(list[3]))
		GameUtil.setLocalScale(subLua.view, 1, 1, 1)
		Framework.TransformUtil.SetLocalPos(subLua.view.transform, 0, 0, 0)
	end

	GameUtil.asBtn(cell):AddClickListener(function()
		if PlayerReturnModel.instance._isActiEnd then
			FloatWordMgr.instance:show("活动已结束，无法购买礼包！")

			return
		end

		if data.limitCount <= data.buyCount then
			FloatWordMgr.instance:show("购买已达上限，不可购买！")

			return
		end

		ViewMgr.instance:open(ViewName.PlayerReturnBuy, self._mainCfg.planId, data.id)
	end, self)
end

function PlayerReturnShopView:_clearTableview(cell)
	local consumeGo = goutil.findChild(cell.gameObject, "consumeGo")
	local oldIconIma = goutil.findChild(consumeGo, "oldNumTxt/oldIconIma")
	local nowIconIma = goutil.findChild(consumeGo, "oldNumTxt/nowNumTxt/nowIconIma")

	MaterialMgr.resetAll(oldIconIma)
	MaterialMgr.resetAll(nowIconIma)
end

return PlayerReturnShopView
