-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survivalking/view/SurvivalKingBuffView.lua

module("logic.extensions.survivalking.view.SurvivalKingBuffView", package.seeall)

local SurvivalKingBuffView = class("SurvivalKingBuffView", ViewComponent)

function SurvivalKingBuffView:ctor()
	SurvivalKingBuffView.super.ctor(self)
end

function SurvivalKingBuffView:unbindEvents()
	SurvivalKingBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function SurvivalKingBuffView:bindEvents()
	SurvivalKingBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function SurvivalKingBuffView:buildUI()
	SurvivalKingBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")

	local goTab = self:getGo("tableView")
	local goCell = self:getGo("tableView/cell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function SurvivalKingBuffView:onExit()
	SurvivalKingBuffView.super.onExit(self)
	self._tableView:dispose()
end

function SurvivalKingBuffView:onEnter()
	SurvivalKingBuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.SurvivalKingUpdatePresetInfo, self._updateUIByInfo, self)
	self.addGEvent(self, GlobalNotify.SurvivalKingBuyBuff, self._updateUIByInfo, self)

	self._activityId = 529001
	self._curRound = 1

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
		self._curRound = checknumber(params[2]) or 1
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	SurvivalKingController.instance:sendGetPresetInfo(self._activityId)
end

function SurvivalKingBuffView:_updateUIByCfg()
	self._buffCfgs = SurvivalKingConfig.instance:getAllBuffCfgs(self._activityId) or {}
	self._roundCfg = SurvivalKingConfig.instance:getRoundCfgByRoundId(self._activityId, self._curRound)
end

function SurvivalKingBuffView:_updateUIByInfo()
	self._curBuffId = 0

	local defBuffsMap = SurvivalKingModel.instance:getDefBuffs(self._activityId)

	if defBuffsMap then
		self._curBuffId = defBuffsMap[self._curRound] or 0
	end

	self._tableView:reloadData(self._buffCfgs)
end

function SurvivalKingBuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

	txtName.text = data.name
	txtDesc.text = data.desc

	local mark = goutil.findChild(go, "mark")

	goutil.setActive(mark, self._curBuffId == data.buffId)

	local btnBuy = goutil.findChild(go, "btnBuy")
	local btnSelect = goutil.findChild(go, "btnSelect")
	local txtHaveCount = goutil.findChildTextComponent(go, "txtHaveCount")

	txtHaveCount.text = string.format("拥有：%d", SurvivalKingModel.instance:getBuffNum(self._activityId, data.buffId))

	GameUtil.addClickHandler(btnBuy, GameUtil.handler(self._onClickBuy, self, data))
	GameUtil.addClickHandler(btnSelect, GameUtil.handler(self._onClickSelect, self, data))

	local item = goutil.findChild(go, "item")
	local iconPath = string.format("%s.png", data.iconUrl)

	uGuiUtil.setSpriteToImage(item, uGuiUtil.SpriteType.BigBg, iconPath)
end

function SurvivalKingBuffView:_onClickSelect(data)
	self._curBuffId = self._curBuffId == data.buffId and 0 or data.buffId

	self._tableView:reloadData(self._buffCfgs)
end

function SurvivalKingBuffView:_clearCell(cell)
	local btnBuy = goutil.findChild(cell.gameObject, "btnBuy")

	GameUtil.rmClickHandler(btnBuy)
	GameUtil.rmClickHandler(cell.gameObject)

	local item = goutil.findChild(cell.gameObject, "item")

	uGuiUtil.clearImage(item)
end

function SurvivalKingBuffView:_onClickBuy(data)
	local buffCost = data.cost
	local costType, costId, costNum = MaterialMgr.getMatParams(buffCost)
	local costName = MaterialMgr.getMaterialsName(costType, costId)
	local content = string.format("确定消耗%d%s购买%d个%s吗？", costNum, costName, 1, data.name)

	TipsFacade.instance:openPopupCostAdjustBySingleNumView(costType, costId, costNum, 1, content, function(num)
		local timeStatus = SurvivalKingController.instance:getCurStatusByTime(self._activityId)

		if timeStatus ~= SurvivalKingController.TimeStatus.SignUp then
			TipsFacade.instance:openCommonTips("仅可在报名时间内购买，请在场次结束后购买！")
		else
			SurvivalKingController.instance:buyBuffs(self._activityId, data.buffId, num)
		end
	end, nil, UnityEngine.TextAnchor.MiddleCenter, function(type, selectTime)
		if type == TipsFacade.STATE_NUM_CHANGE then
			return (string.format("确定消耗%d%s购买%d个%s吗？", costNum * selectTime, costName, selectTime, data.name))
		end

		return nil
	end)
end

function SurvivalKingBuffView:_onClickSure()
	SurvivalKingController.instance:saveBuffId(self._activityId, self._curBuffId, self._curRound)
	self:close()
end

return SurvivalKingBuffView
