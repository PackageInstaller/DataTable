-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingorderclg/view/DivineKingOrderStageView.lua

module("logic.extensions.divinekingorderclg.view.DivineKingOrderStageView", package.seeall)

local DivineKingOrderStageView = class("DivineKingOrderStageView", ViewComponent)

function DivineKingOrderStageView:ctor()
	DivineKingOrderStageView.super.ctor(self)
end

function DivineKingOrderStageView:buildUI()
	DivineKingOrderStageView.super.buildUI(self)

	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnShow = self:getBtn("btnShow")
	self._btnReset = self:getBtn("btnReset")
	self._txtTips = self:getTxt("tipsCol/txt")

	local cellStage = self:getGo("stage/cell")
	local tabStage = self:getGo("stage/tableview")

	self._tableviewStage = ScrollerList.create(tabStage, cellStage, GameUtil.handler(self._updateStageCell, self), GameUtil.handler(self._clearStageCell, self))
end

function DivineKingOrderStageView:bindEvents()
	DivineKingOrderStageView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnShow:AddClickListener(self._onClickShow, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
end

function DivineKingOrderStageView:unbindEvents()
	DivineKingOrderStageView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnShow:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function DivineKingOrderStageView:onEnter()
	DivineKingOrderStageView.super.onEnter(self)
	self:_getCfgs()
	self:_refreshView()
	self.addGEvent(self, GlobalNotify.DivineKingOrderClgGetInfo, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.DivineKingOrderClgConfirmSave, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.DivineKingOrderClgResetFight, self._refreshView, self)
	DivineKingOrderClgController.instance:showCI()
	DivineKingOrderClgController.instance:checkAoqiGodFinish(self._actId)

	self._txtTips.text = self._actCfg.stageRule
end

function DivineKingOrderStageView:onExit()
	DivineKingOrderStageView.super.onExit(self)
	self._tableviewStage:dispose()
end

function DivineKingOrderStageView:_getCfgs()
	self._actId = DivineKingOrderClgModel.instance:getActivityId()
	self._stageCfgs = DivineKingOrderClgConfig.instance:getStageCfgs(self._actId)
	self._actCfg = DivineKingOrderClgConfig.instance:getActCfg(self._actId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._actId)
end

function DivineKingOrderStageView:_refreshView()
	self._timeStampNow = ServerTime.now()

	self._tableviewStage:reloadData(self._stageCfgs)
	self._tableviewStage:MoveCellInView(DivineKingOrderClgModel.instance:getCurStageId() - 1)
end

function DivineKingOrderStageView:_updateStageCell(view, cellGo, data)
	local cell = self:_clearStageCell(cellGo)

	GameUtil.addClickHandler(cell.btnFight, GameUtil.handler(self._onClickFight, self, data))

	local isFirstPass = DivineKingOrderClgModel.instance:isHistoryPassStage(data.stageId)
	local isPass = DivineKingOrderClgModel.instance:isPassStage(data.stageId)

	goutil.setActive(cell.pass, isPass)
	GameUtil.SetActive(cell.prize, not self._isAoqiGodProcessType)

	if not self._isAoqiGodProcessType then
		MaterialMgr.setCellListByCfg(data.firstPassPrize, cell.prizeCon)
	end

	goutil.setActive(cell.gain, isFirstPass)

	local startTime = GameUtil.string2time(data.openTime)
	local isTimeOpen = startTime <= self._timeStampNow

	if isTimeOpen then
		::label_9_0::

		local isOpen = true
		local isOpen

		if DivineKingOrderClgModel.instance:getCurStageId() < data.stageId then
			isOpen = false
		end

		goutil.setActive(cell.openTip, not isOpen)

		local date = GameUtil.time2date(startTime)

		cell.txtTime.text = isTimeOpen and "" or string.format("%s.%s.%s后开启", date.year, date.month, date.day)
		cell.txtStage.text = string.format("第%s关", GameUtil.getChineseNumber(data.stageId))

		local creepCfgs = DivineKingOrderClgConfig.instance:getCreepCfgs(data.creepsMasterId)

		for _, cfg in pairs(creepCfgs) do
			local fmtCell = cell.fmtCellList[cfg.posId]

			if fmtCell then
				local skinId = checknumber(cfg.faceId)

				if skinId == 0 then
					skinId = cfg.raceId
				end

				MaterialMgr.setCell(MatType.Pet, skinId, fmtCell.icon)
				goutil.setActive(fmtCell.waterBuff, cfg.showOwnBuff == 1)
				goutil.setActive(fmtCell.kongBuff, cfg.showOwnBuff == 2)
			end
		end
	end
end

function DivineKingOrderStageView:_clearStageCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.btnFight = goutil.findChild(cell.go, "btnFight")

	GameUtil.rmClickHandler(cell.btnFight)

	cell.pass = goutil.findChild(cell.go, "pass")
	cell.prize = goutil.findChild(cell.go, "prize")
	cell.prizeCon = goutil.findChild(cell.prize, "con")
	cell.gain = goutil.findChild(cell.prize, "gain")

	if self._isAoqiGodProcessType then
		MaterialMgr.resetAll(cell.prizeCon)
	end

	cell.openTip = goutil.findChild(cell.go, "openTip")
	cell.txtTime = goutil.findChildTextComponent(cell.openTip, "txtTime")
	cell.txtStage = goutil.findChildTextComponent(cell.go, "stage/txt")
	cell.fmtView = goutil.findChild(cell.go, "fmt/fmtView")
	cell.fmtCellList = {}

	for posId = 1, cell.fmtView.transform.childCount do
		local fmtCell = {}

		fmtCell.go = cell.fmtView.transform:GetChild(posId - 1)
		fmtCell.icon = goutil.findChild(fmtCell.go, "icon")
		fmtCell.waterBuff = goutil.findChild(fmtCell.go, "withBuff/water")
		fmtCell.kongBuff = goutil.findChild(fmtCell.go, "withBuff/kong")

		goutil.setActive(fmtCell.waterBuff, false)
		goutil.setActive(fmtCell.kongBuff, false)
		MaterialMgr.resetAll(fmtCell.icon)

		cell.fmtCellList[posId] = fmtCell
	end

	return cell
end

function DivineKingOrderStageView:_onClickClose()
	if self._isAoqiGodProcessType then
		local actType = DivineKingOrderClgController.instance:getActivityType()
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, actType, self._actId)

		if result ~= GameEnum.ResultCode.Success then
			AoqiGodController.instance:doHandleChallengeFinishReady(actType, self._actId)

			return
		end
	end

	self:close()
end

function DivineKingOrderStageView:_onClickShow()
	UIStateManager.instance:push(ViewName.DivineKingOrderBuffView)
end

function DivineKingOrderStageView:_onClickReset()
	DivineKingOrderClgController.instance:checkAoqiGodFinish(self._actId)

	if DivineKingOrderClgModel.instance:isChallengePass(self._actId) then
		FloatWordMgr.instance:show(lang("已全部通关"))

		return
	end

	if DivineKingOrderClgModel.instance:getCurStageId() == 1 then
		FloatWordMgr.instance:show(lang("未有挑战记录"))

		return
	end

	local text = "是否重置所有关卡挑战记录以及龙魂效果，奖励不重置。"

	local function func()
		DivineKingOrderClgController.instance:resetFight(self._actId)
	end

	TipsFacade.instance:openPopupWindowWithX(lang("tip"), text, func, nil, nil, nil, UnityEngine.TextAnchor.MiddleCenter)
end

function DivineKingOrderStageView:_onClickFight(data)
	DivineKingOrderClgController.instance:checkAoqiGodFinish(self._actId)

	local stageId = data.stageId
	local curStage = DivineKingOrderClgModel.instance:getCurStageId()

	if stageId == curStage then
		local startTime = GameUtil.string2time(data.openTime)

		if startTime <= self._timeStampNow then
			local fmtMo = DivineKingOrderClgModel.instance:getFmtMo()

			fmtMo:initParams()
			CustomFmtController.instance:showMissionView(fmtMo)
		else
			local date = GameUtil.time2date(startTime)

			FloatWordMgr.instance:show(string.format("%s.%s.%s后开启", date.year, date.month, date.day))
		end
	elseif stageId < curStage then
		FloatWordMgr.instance:show("已通关")
	else
		FloatWordMgr.instance:show("请通关上一关")
	end
end

return DivineKingOrderStageView
