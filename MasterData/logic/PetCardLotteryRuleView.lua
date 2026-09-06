-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petcardlottery/view/PetCardLotteryRuleView.lua

module("logic.extensions.petcardlottery.view.PetCardLotteryRuleView", package.seeall)

local PetCardLotteryRuleView = class("PetCardLotteryRuleView", ViewComponent)

function PetCardLotteryRuleView:ctor()
	PetCardLotteryRuleView.super.ctor(self)
end

function PetCardLotteryRuleView:unbindEvents()
	PetCardLotteryRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PetCardLotteryRuleView:bindEvents()
	PetCardLotteryRuleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PetCardLotteryRuleView:buildUI()
	PetCardLotteryRuleView.super.buildUI(self)

	self._prizeView = self:getGo("prizeView")
	self._prizeCell = self:getGo("prizeView/prizeCell")
	self._txtDesc = self:getTxt("ruleDesc/desc/Viewport/Content")
	self._btnClose = self:getBtn("btnClose")
	self._tablewViewList = {}

	for i = 1, 3 do
		local tableviewGo = self:getGo("prizeView/prize_" .. i .. "/tableview")
		local tableView = ScrollerList.create(tableviewGo, self._prizeCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

		table.insert(self._tablewViewList, tableView)
	end
end

function PetCardLotteryRuleView:onExit()
	PetCardLotteryRuleView.super.onExit(self)

	for id = 1, #self._tablewViewList do
		self._tablewViewList[id]:dispose()
	end
end

function PetCardLotteryRuleView:onEnter()
	PetCardLotteryRuleView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.PetCardLottery)
	self._lotteryCfg = PetCardLotteryConfig.instance:getCfgById(self._activityId)

	for id = 1, #self._tablewViewList do
		local cfg = string.split(PetCardLotteryConfig.instance:getPrizeCfgById(self._activityId, id).prize, "#")

		self._tablewViewList[id]:reloadData(cfg)
	end

	self._txtDesc.text = self._lotteryCfg.ruleDesc
end

function PetCardLotteryRuleView:_updateCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function PetCardLotteryRuleView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

return PetCardLotteryRuleView
