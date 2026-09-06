-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/richmanxplan/view/RmxplanshangpueventView.lua

module("logic.extensions.richmanxplan.view.RmxplanshangpueventView", package.seeall)

local RmxplanshangpueventView = class("RmxplanshangpueventView", ViewComponent)

function RmxplanshangpueventView:ctor()
	RmxplanshangpueventView.super.ctor(self)
end

function RmxplanshangpueventView:unbindEvents()
	RmxplanshangpueventView.super.unbindEvents(self)
	self._btnBuy:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
end

function RmxplanshangpueventView:bindEvents()
	RmxplanshangpueventView.super.bindEvents(self)
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
	self._btnCancel:AddClickListener(self._onClickbtnCancel, self)
	self._btnRefresh:AddClickListener(self._onClickbtnRefresh, self)
end

function RmxplanshangpueventView:buildUI()
	RmxplanshangpueventView.super.buildUI(self)

	self._btnBuy = self:getBtn("btns/btnBuy")
	self._btnCancel = self:getBtn("btns/btnCancel")
	self._btnRefresh = self:getBtn("btnRefresh")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtRefreshCost = self:getTxt("txts/txtRefreshCost")
	self._txtHave = self:getTxt("txts/txtHave")
	self._txtCost = self:getTxt("txts/txtCost")
	self._roleGo = self:getGo("role")
	self._txtRefreshTime = self:getTxt("txts/txtRefreshTime")
	self._txtDesc = self:getTxt("txts/txtDesc")
end

function RmxplanshangpueventView:onExit()
	RmxplanshangpueventView.super.onExit(self)
	self._scrollerList:dispose()
	uGuiUtil.clearImage(self._roleGo)
end

function RmxplanshangpueventView:onEnter()
	RmxplanshangpueventView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RichManXPlanEventRes, self._onRichManXPlanEventRes, self)
	self.addGEvent(self, GlobalNotify.NotifyRichManXPlanScoreChangeRes, self._updateUI, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._event = params[2]
	self._params = GameUtil.jsonToTable(self._event.param)
	self._selectItemId = 0
	self._selectItemIndex = 0
	self._refreshTime = self._params.refreshTime
	self._eventCfg = RichmanxplanConfig.instance:getShopEventCfg(self._activityId, self._event.eventId)

	self:_updateUI()
	self:_setRole()
end

function RmxplanshangpueventView:_onClickbtnBuy()
	if self._selectItemIndex <= 0 then
		FloatWordMgr.instance:show("未选择商品")

		return
	end

	local shopItemCfg = RichmanxplanConfig.instance:getShopItemCfg(self._activityId, self._event.eventId, self._selectItemId)
	local cost = shopItemCfg.cost

	if cost > self._score then
		FloatWordMgr.instance:show("货币不足")

		return
	end

	local text = "确定购买此商品吗？"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		local t = {
			itemIndex = self._selectItemIndex,
			itemId = self._selectItemId
		}

		RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false, GameUtil.jsonToString(t))
	end)
end

function RmxplanshangpueventView:_onClickbtnCancel()
	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, true)
end

function RmxplanshangpueventView:_onClickbtnRefresh()
	local shopEventCfg = RichmanxplanConfig.instance:getShopEventCfg(self._activityId, self._event.eventId)

	if self._refreshTime >= shopEventCfg.refreshLimit then
		FloatWordMgr.instance:show("刷新次数不足")

		return
	end

	if self._score < shopEventCfg.refreshCost then
		FloatWordMgr.instance:show("道具不足")

		return
	end

	local t = {
		refresh = true
	}

	RichManXPlanAgent.instance:sendPM_RichManXPlanEventReq(self._activityId, false, GameUtil.jsonToString(t))
end

function RmxplanshangpueventView:_updateUI()
	local shopEventCfg = RichmanxplanConfig.instance:getShopEventCfg(self._activityId, self._event.eventId)

	self._score = RichmanxplanModel.instance:getScore(self._activityId)
	self._txtRefreshCost.text = shopEventCfg.refreshCost
	self._txtHave.text = self._score

	self._scrollerList:reloadData(self._params.shopItem)
	self:_updateCost()
	self:_updateRefreshTime()
end

function RmxplanshangpueventView:_updateCell(view, cell, itemId, tag)
	local btnBg = Framework.ButtonAdapter.GetFrom(cell.gameObject, "bg")
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goSelect = goutil.findChild(cell.gameObject, "select")
	local txtNum = goutil.findChildTextComponent(cell.gameObject, "txtNum")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local shopItemCfg = RichmanxplanConfig.instance:getShopItemCfg(self._activityId, self._event.eventId, itemId)

	if shopItemCfg.type == RichmanxplanController.ShopItemType.Item then
		local matType, matId, num = MaterialMgr.getMatParams(shopItemCfg.param)

		MaterialMgr.setIcon(goIcon, matType, matId)

		txtNum.text = num
		txtName.text = MaterialMgr.getMaterialsName(matType, matId)
	elseif shopItemCfg.type == RichmanxplanController.ShopItemType.Buff then
		local buffCfg = RichmanxplanConfig.instance:getBuffCfg(self._activityId, checknumber(shopItemCfg.param))

		uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(buffCfg.iconRes))

		txtNum.text = 1
		txtName.text = buffCfg.name
	elseif shopItemCfg.type == RichmanxplanController.ShopItemType.Score then
		uGuiUtil.setSpriteToImage(goIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("com_icon_yidiechaopiao"))

		txtNum.text = shopItemCfg.param
		txtName.text = "资金"
	end

	goutil.setActive(goSelect, self._selectItemIndex == cell.data)
	btnBg:AddClickListener(function()
		self._selectItemIndex = self._selectItemIndex == cell.data and -1 or cell.data
		self._selectItemId = itemId

		self._scrollerList:refresh()
		self:_updateCost()
	end)
end

function RmxplanshangpueventView:_clearCell(cell)
	local goIcon = goutil.findChild(cell.gameObject, "icon")

	MaterialMgr.resetAll(goIcon)
	uGuiUtil.clearImage(goIcon)
end

function RmxplanshangpueventView:_updateCost()
	local cost = 0

	if self._selectItemIndex > 0 then
		local shopItemCfg = RichmanxplanConfig.instance:getShopItemCfg(self._activityId, self._event.eventId, self._selectItemId)
		local str = ""

		cost = shopItemCfg.cost

		if shopItemCfg.type == RichmanxplanController.ShopItemType.Item then
			local itemCfg = MaterialMgr.getMatCfgByStr(shopItemCfg.param)

			if string.nilorempty(itemCfg.desc) then
				printError("这个道具要特殊处理下")
			end

			str = itemCfg.desc
		elseif shopItemCfg.type == RichmanxplanController.ShopItemType.Buff then
			local buffCfg = RichmanxplanConfig.instance:getBuffCfg(self._activityId, checknumber(shopItemCfg.param))

			str = buffCfg.effectDesc
		elseif shopItemCfg.type == RichmanxplanController.ShopItemType.Score then
			str = "寻秘探奇活动内进行消费、投资等行为的唯一指定货币"
		end

		self._txtDesc.text = str
	else
		self._txtDesc.text = ""
	end

	self._txtCost.text = cost
end

function RmxplanshangpueventView:_onRichManXPlanEventRes(msg)
	if msg.isEnd then
		self:close()

		return
	end

	if not string.nilorempty(msg.resultParam) then
		self._params = GameUtil.jsonToTable(msg.resultParam)
		self._refreshTime = self._params.refreshTime
		self._selectItemIndex = -1

		self._scrollerList:refresh()
		self:_updateCost()
	end

	self:_updateUI()
end

function RmxplanshangpueventView:_setRole()
	local raceId = RichmanxplanConfig.instance:getShopEventCfg(self._activityId, self._event.eventId).raceId
	local modelCo = CharacterConfig.instance:getModelCo(raceId)

	uGuiUtil.setSpriteToImage(self._roleGo, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function RmxplanshangpueventView:_updateRefreshTime()
	self._txtRefreshTime.text = string.format("剩余刷新次数：%s/%s", self._eventCfg.refreshLimit - self._params.refreshTime, self._eventCfg.refreshLimit)
end

return RmxplanshangpueventView
