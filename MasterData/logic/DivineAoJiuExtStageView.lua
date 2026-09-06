-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineaojiu/view/DivineAoJiuExtStageView.lua

module("logic.extensions.divineaojiu.view.DivineAoJiuExtStageView", package.seeall)

local DivineAoJiuExtStageView = class("DivineAoJiuExtStageView", ViewComponent)

function DivineAoJiuExtStageView:ctor()
	DivineAoJiuExtStageView.super.ctor(self)
end

function DivineAoJiuExtStageView:unbindEvents()
	DivineAoJiuExtStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
end

function DivineAoJiuExtStageView:bindEvents()
	DivineAoJiuExtStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
end

function DivineAoJiuExtStageView:buildUI()
	DivineAoJiuExtStageView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnTip = self:getGo("btnTip")
	self._passTypeTableView = self:getGo("info/passInfo/passTypeTableView")
	self._passTypeTableCell = self:getGo("info/passInfo/passTypeTableCell")
	self._passTypeTableList = ScrollerList.create(self._passTypeTableView, self._passTypeTableCell, GameUtil.handler(self._updatePassTypeCell, self), GameUtil.handler(self._clearPassTypeCell, self))
	self._txtScore = self:getTxt("info/passInfo/txtScore")
	self._typeTableCell = self:getGo("info/typeInfo/typeTableCell")
	self._typeTableView = self:getGo("info/typeInfo/typeTableView")
	self._typeTableList = ScrollerList.create(self._typeTableView, self._typeTableCell, GameUtil.handler(self._updateTypeCell, self), GameUtil.handler(self._clearTypeCell, self))
	self._stageTableCell = self:getGo("stageTableView/stageTableCell")
	self._stageTableView = self:getGo("stageTableView")
	self._stageTableList = ScrollerList.create(self._stageTableView, self._stageTableCell, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
	self._itemTableCell = self:getGo("info/passPrize/itemTableCell")
	self._itemTableView = self:getGo("info/passPrize/itemTableView")
	self._itemTableList = ScrollerList.create(self._itemTableView, self._itemTableCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

	self._itemTableList:setCenterMode(true)
end

function DivineAoJiuExtStageView:onExit()
	DivineAoJiuExtStageView.super.onExit(self)
end

function DivineAoJiuExtStageView:onEnter()
	DivineAoJiuExtStageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineAoJiuClgGetInfo, self._refreshView, self)

	self._activityId = checknumber(self:getFirstParam())
	self._activityCfg = DivineAoJiuConfig.instance:getActivityCfg(self._activityId)
	self._selectStageId = DivineAoJiuModel.instance:getSaveTempStage()

	self:_refreshView()

	if DivineAoJiuModel.instance:getTempResultData() then
		UIStateManager.instance:push(ViewName.DivineAoJiuExtResultView)
	end
end

function DivineAoJiuExtStageView:_refreshView()
	local stageCfgs = DivineAoJiuConfig.instance:getExtremeStageCfgs(self._activityId)

	if self._selectStageId > #stageCfgs then
		DivineAoJiuModel.instance:resetSaveTempStage()

		self._selectStageId = DivineAoJiuModel.instance:getSaveTempStage()
	end

	self._stageTableList:reloadData(stageCfgs)

	local stageCfg = stageCfgs[self._selectStageId]

	self._typeTableList:reloadData(stageCfg.buffIds)

	local activityCfg = DivineAoJiuConfig.instance:getActivityCfg(self._activityId)
	local passBufflist = {}

	for i, v in ipairs(activityCfg.extremeClgBuffTypeNeed) do
		table.insert(passBufflist, {
			buffType = i,
			needCount = v
		})
	end

	self._passTypeTableList:reloadData(passBufflist)

	local prizeList = string.split(activityCfg.extremeClgFirstPassPrize, "#")

	self._itemTableList:reloadData(prizeList)

	local totalScore = 0

	for i, v in ipairs(stageCfgs) do
		local stageInfo = DivineAoJiuModel.instance:getExtStageInfo(self._activityId, v.stageId)

		totalScore = totalScore + stageInfo.activePetCount
	end

	self._txtScore.text = langPara("存活精灵：<color=#62cf2d>%d</color>/%d", totalScore, self._activityCfg.extremeClgActivePetCount)
end

function DivineAoJiuExtStageView:_updatePassTypeCell(view, cell, data, tag)
	local go = cell.gameObject
	local txt = goutil.findChildTextComponent(go, "txt")
	local imgTypeChange = goutil.findChildComponent(go, "imgType", ComponentType.UIImageSpriteChange)
	local name = DivineAoJiuConfig.instance:getBuffName(self._activityId, data.buffType)
	local curCount = DivineAoJiuModel.instance:getBuffTypeCount(self._activityId, data.buffType)

	txt.text = langPara("%s:<color=#62cf2d>%d</color>/%d", name, curCount, data.needCount)

	imgTypeChange:SetState(data.buffType - 1)
end

function DivineAoJiuExtStageView:_clearPassTypeCell(cell)
	return
end

function DivineAoJiuExtStageView:_updateTypeCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtType = goutil.findChildTextComponent(go, "txtType")
	local buffCfg = DivineAoJiuConfig.instance:getBuffCfg(self._activityId, data)

	txtDesc.text = buffCfg.desc
	txtType.text = DivineAoJiuConfig.instance:getBuffName(self._activityId, buffCfg.buffType)
end

function DivineAoJiuExtStageView:_clearTypeCell(cell)
	return
end

function DivineAoJiuExtStageView:_updateStageCell(view, cell, data, tag)
	local go = cell.gameObject
	local btn = goutil.findChild(go, "btn")
	local select = goutil.findChild(go, "select")
	local empty = goutil.findChild(go, "empty")
	local passInfo = goutil.findChild(go, "passInfo")
	local txtType = goutil.findChildTextComponent(passInfo, "txtType")
	local txtScore = goutil.findChildTextComponent(passInfo, "txtScore")
	local imgTypeChange = goutil.findChildComponent(passInfo, "imgType", ComponentType.UIImageSpriteChange)
	local stageInfo = DivineAoJiuModel.instance:getExtStageInfo(self._activityId, data.stageId)
	local isPass = stageInfo and stageInfo.buffId > 0

	if isPass then
		local buffCfg = DivineAoJiuConfig.instance:getBuffCfg(self._activityId, stageInfo.buffId)

		txtScore.text = langPara("存活精灵：<color=#62cf2d>%d</color>", stageInfo.activePetCount)
		txtType.text = DivineAoJiuConfig.instance:getBuffName(self._activityId, buffCfg.buffType)

		imgTypeChange:SetState(buffCfg.buffType - 1)
	end

	GameUtil.SetActive(select, self._selectStageId == data.stageId)
	GameUtil.SetActive(empty, not isPass)
	GameUtil.SetActive(passInfo, isPass)
	GameUtil.rmClickHandler(btn)
	GameUtil.addClickHandler(btn, function()
		self:_onClickStage(data.stageId)
	end)
end

function DivineAoJiuExtStageView:_clearStageCell(cell)
	return
end

function DivineAoJiuExtStageView:_updateItemCell(view, cell, data, tag)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local receive = goutil.findChild(go, "receive")

	GameUtil.SetActive(receive, DivineAoJiuModel.instance:getIsGainPassPrize(self._activityId))
	MaterialMgr.resetAll(con)
	MaterialMgr.setCellByCfg(data, con)
end

function DivineAoJiuExtStageView:_clearItemCell(cell)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")

	MaterialMgr.resetAll(con)
end

function DivineAoJiuExtStageView:_onClickStage(stageId)
	DivineAoJiuModel.instance:saveTampStage(stageId)
	DivineAoJiuController.instance:openExtraMissionView(self._activityId, stageId)
	self:_refreshView()
end

function DivineAoJiuExtStageView:_onClickTip()
	TipsFacade.instance:openRulesView("divine_ao_jiu_clg_rule")
end

return DivineAoJiuExtStageView
