-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/view/RoseclgstageView.lua

module("logic.extensions.roseclg.view.RoseclgstageView", package.seeall)

local RoseclgstageView = class("RoseclgstageView", ViewComponent)

function RoseclgstageView:ctor()
	RoseclgstageView.super.ctor(self)
end

function RoseclgstageView:unbindEvents()
	RoseclgstageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	self._btnTip:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnReward:RemoveClickListener()
end

function RoseclgstageView:bindEvents()
	RoseclgstageView.super.bindEvents(self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnReset:AddClickListener(self._onClickbtnReset, self)
	self._btnReward:AddClickListener(self._onClickbtnReward, self)
end

function RoseclgstageView:buildUI()
	RoseclgstageView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txt")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnClose = self:getBtn("leftTop/btnClose")
	self._btnReset = self:getBtn("btnReset")
	self._btnReward = self:getBtn("btnReward")
	self._singleLine = self:getGo("fmtCol/fmtView"):GetComponent(ComponentType.UILayoutSingleLine)
	self._fmtCol_fmtView = goutil.findChild(self.mainGO, "fmtCol/fmtView")
	self._fmtCol_fmtCell = goutil.findChild(self.mainGO, "fmtCol/fmtCell")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function RoseclgstageView:onExit()
	RoseclgstageView.super.onExit(self)
	self._scrollerList:dispose()
end

function RoseclgstageView:onEnter()
	RoseclgstageView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.RoseClgResetRes, self._updateUI, self)

	self._activityId = self:getFirstParam()
	self._actStartTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.RoseClg, self._activityId)

	self:_setActTime()
	self:_updateUI()
end

function RoseclgstageView:_setActTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function RoseclgstageView:_onClickbtnTip()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(195)

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function RoseclgstageView:_onClickbtnClose()
	self:close()
end

function RoseclgstageView:_onClickbtnReset()
	local info = RoseclgModel.instance:getInfo(self._activityId)
	local stageCfgs = RoseclgConfig.instance:getStageCfgs(self._activityId)

	if info.curPassStageId >= #stageCfgs then
		FloatWordMgr.instance:show("已全部通关")

		return
	end

	if info.curPassStageId <= 0 then
		local hasPassTeam = false

		for i, v in ipairs(info.curStageTeamPassInfo or {}) do
			if v then
				hasPassTeam = true

				break
			end
		end

		if not hasPassTeam then
			FloatWordMgr.instance:show("不需要重置")

			return
		end
	end

	local text = "重置后，则从第一关重新挑战，且重置疲劳和受疫疠肆虐状态。请问是否重置挑战?"

	TipsFacade.instance:openPopupWindow("提示", text, function()
		RoseClgAgent.instance:sendPM_RoseClgResetReq(self._activityId)
	end)
end

function RoseclgstageView:_onClickbtnReward()
	UIStateManager.instance:push(ViewName.RoseclgrewardView, self._activityId)
end

function RoseclgstageView:_updateUI()
	local info = RoseclgModel.instance:getInfo(self._activityId)
	local stageCfgs = RoseclgConfig.instance:getStageCfgs(self._activityId)

	self._nextStageId = info.curPassStageId + 1

	if self._nextStageId >= #stageCfgs then
		self._nextStageId = #stageCfgs
	end

	self:_onUpdateFmtColUI()
	self:_updateBottomUI()
end

function RoseclgstageView:_onUpdateFmtColUI()
	self:_prepareFmtColData()

	local parentTran = self._fmtCol_fmtView.transform
	local childGo = self._fmtCol_fmtCell
	local children = GameUtil.getChildren(parentTran)
	local length = #self._fmtColCreepsCfgs

	goutil.setActive(childGo, false)

	for idx, cfg in ipairs(self._fmtColCreepsCfgs) do
		local mainGo = children[idx]

		if mainGo == nil then
			mainGo = goutil.cloneAndSetParent(childGo, parentTran, string.format("%s_%s", childGo.name, idx))
		end

		self:_updateFmtCell(mainGo, cfg)
		goutil.setActive(mainGo, true)
	end

	for idx = 1, parentTran.childCount do
		local mainGo = parentTran:GetChild(idx - 1)

		GameUtil.SetActive(mainGo, idx <= length)
	end

	GameUtil.SetActive(self._btnReset, length > 1)
	self._singleLine:Layout()
end

function RoseclgstageView:_prepareFmtColData()
	local stageCfg = RoseclgConfig.instance:getStageCfg(self._activityId, self._nextStageId)
	local openTime = (stageCfg.openDay - 1) * 86400 + self._actStartTime
	local nowTime = ServerTime.now()

	self._isLock = nowTime < openTime
	self._lockDesc = ""

	if self._isLock then
		local leftTime = openTime - nowTime
		local day, hour = GameUtil.getTimeDDHHMMSS(leftTime)

		self._lockDesc = leftTime > 86400 and string.format("%s天后开启挑战", day) or string.format("%s小时后开启挑战", hour <= 0 and 1 or hour)
	end

	self._fmtColCreepsCfgs = RoseclgConfig.instance:getCreepsMasterCfgs(self._activityId, self._nextStageId)
end

function RoseclgstageView:_getCreepsCfgs(creepsMasterId)
	return RoseclgConfig.instance:getCreepsCfgs(creepsMasterId)
end

function RoseclgstageView:_updateFmtCell(mainGo, masterCfg)
	local imgPass = goutil.findChild(mainGo, "imgPass")
	local btnFormation = goutil.findChild(mainGo, "btnFormation")
	local creepsCfgs = self:_getCreepsCfgs(masterCfg.creepsMasterId)
	local isPass = RoseclgModel.instance:isChallenged(self._activityId, self._nextStageId, masterCfg.creepsMasterId)
	local goLock = goutil.findChild(mainGo, "lock")
	local txtLock = goutil.findChildTextComponent(mainGo, "lock/txtLock")

	for posId = 1, 9 do
		local go = goutil.findChild(mainGo, "cell_" .. posId)
		local icon = goutil.findChild(go, "con")
		local creepsData

		for _, cData in ipairs(creepsCfgs) do
			if cData.posId == posId then
				creepsData = cData

				break
			end
		end

		goutil.setActive(go, creepsData)

		if creepsData then
			local skinId = checknumber(creepsData.faceId)

			if skinId == 0 then
				skinId = creepsData.raceId
			end

			MaterialMgr.setIcon(icon, MatType.Pet, skinId)
		else
			MaterialMgr.resetAll(icon)
		end
	end

	GameUtil.SetActive(imgPass, isPass)
	goutil.setActive(goLock, self._isLock)

	if self._isLock then
		txtLock.text = self._lockDesc
	end

	GameUtil.addClickHandler(btnFormation, GameUtil.handler(self._onClickFmtCellBtnFormation, self, isPass, masterCfg))
end

function RoseclgstageView:_onClickFmtCellBtnFormation(isPass, masterCfg)
	local info = RoseclgModel.instance:getInfo(self._activityId)
	local cfgs = RoseclgConfig.instance:getStageCfgs(self._activityId)

	if info.curPassStageId >= #cfgs then
		FloatWordMgr.instance:show("已通过全部关卡")

		return
	end

	if isPass then
		FloatWordMgr.instance:show("该阵型已通关")

		return
	end

	local stageCfg = RoseclgConfig.instance:getStageCfg(self._activityId, self._nextStageId)

	if (stageCfg.openDay - 1) * 86400 + self._actStartTime > ServerTime.now() then
		FloatWordMgr.instance:show(self._lockDesc)

		return
	end

	local teamIndex = 0

	for i, v in ipairs(stageCfg.teams) do
		if v == masterCfg.creepsMasterId then
			teamIndex = i

			break
		end
	end

	RoseclgController.instance:enterMission(self._activityId, teamIndex, masterCfg.creepsMasterId)
end

function RoseclgstageView:_updateBottomUI()
	local stageCfgs = RoseclgConfig.instance:getStageCfgs(self._activityId)

	self._stageCnt = #stageCfgs

	self._scrollerList:reloadData(stageCfgs)
end

function RoseclgstageView:_updateCell(view, cell, data, tag)
	local goCur = goutil.findChild(cell.gameObject, "goCur")
	local goLine = goutil.findChild(cell.gameObject, "goLine")
	local goPass = goutil.findChild(cell.gameObject, "goPass")
	local info = RoseclgModel.instance:getInfo(self._activityId)
	local isPass = info.curPassStageId >= data.stageId

	goutil.setActive(goCur, not isPass and data.stageId == self._nextStageId)
	goutil.setActive(goLine, data.stageId ~= self._stageCnt)
	goutil.setActive(goPass, isPass)
end

function RoseclgstageView:_clearCell(cell)
	return
end

return RoseclgstageView
