-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yunjiedragonclg/view/YunJieDragonClgLevelView.lua

module("logic.extensions.yunjiedragonclg.view.YunJieDragonClgLevelView", package.seeall)

local YunJieDragonClgLevelView = class("YunJieDragonClgLevelView", ViewComponent)

function YunJieDragonClgLevelView:ctor()
	YunJieDragonClgLevelView.super.ctor(self)
end

function YunJieDragonClgLevelView:unbindEvents()
	YunJieDragonClgLevelView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCollect)
end

function YunJieDragonClgLevelView:bindEvents()
	YunJieDragonClgLevelView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnCollect, self._onClickBtnCollect, self)
end

function YunJieDragonClgLevelView:buildUI()
	YunJieDragonClgLevelView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnCollect = self:getGo("btnCollect")
	self._txtTip = self:getTxt("tip/scrView/Viewport/Content")
	self._tableviewLevel = self:getGo("tableviewLevel")
	self._tablecellLevel = self:getGo("tableviewLevel/tablecell")
	self._scrollListLevel = ScrollerList.create(self._tableviewLevel, self._tablecellLevel, GameUtil.handler(self._updateLevelCell, self), GameUtil.handler(self._clearLevelCell, self))
	self._tableviewFmt = self:getGo("tableviewFmt")
	self._tablecellFmt = self:getGo("tableviewFmt/tablecell")
	self._scrollListFmt = ScrollerList.create(self._tableviewFmt, self._tablecellFmt, GameUtil.handler(self._updateFmtCell, self), GameUtil.handler(self._clearFmtCell, self))
end

function YunJieDragonClgLevelView:onExit()
	YunJieDragonClgLevelView.super.onExit(self)
	self._scrollListFmt:dispose()
	self._scrollListLevel:dispose()
end

function YunJieDragonClgLevelView:onEnter()
	YunJieDragonClgLevelView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_YunJieDragonClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_YunJieDragonClgOneKeyPassRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 572001
	end

	self._actCfg = YunJieDragonClgConfig.instance:getActCfg(self._activityId)
	self._phaseCfgs = YunJieDragonClgConfig.instance:getPhaseCfgs(self._activityId)
	self._startTime, self._endTime = ActivityDefineController.instance:getStartTimeAndEndTime(572, self._activityId)
	self._curSelectPhase = 0

	YunJieDragonClgController.instance:sendPM_YunJieDragonClgGetInfoReq(self._activityId)
end

function YunJieDragonClgLevelView:_onUpdate()
	self._curTime = ServerTime.now()
	self._info = YunJieDragonClgModel.instance:getInfo(self._activityId)

	local hasOneKeyPass = self._info.oneKeyPass

	if not self._info.passedStageIds then
		self._curStage = hasOneKeyPass and #self._phaseCfgs or math.max(#self._info.passedStageIds, 1)
		self._curPhase = YunJieDragonClgController.instance:getCurPhaseId(self._activityId)

		if self._curSelectPhase == 0 then
			self._curSelectPhase = self._curPhase
		end

		local curPhaseCfg = self._phaseCfgs[self._curSelectPhase]

		self._txtTip.text = curPhaseCfg.ruleDesc
		self._curStageCfgs = YunJieDragonClgConfig.instance:getStageCfgsByPhaseId(self._activityId, self._curSelectPhase)

		self._scrollListLevel:reloadData(self._phaseCfgs)
		self._scrollListFmt:reloadData(self._curStageCfgs)
	end
end

function YunJieDragonClgLevelView:_updateLevelCell(view, cell, data)
	local lock = goutil.findChild(cell, "lock")
	local pass = goutil.findChild(cell, "pass")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local bgChangeComp = goutil.findChild(cell, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
	local oneKeyPass = self._info.oneKeyPass
	local curPhaseHasAllPass = YunJieDragonClgController.instance:phaseHasAllPass(self._activityId, data.phaseId)
	local unLockTime = self._startTime + (data.openDay - 1) * 86400
	local isLock = unLockTime > self._curTime
	local hasPass = oneKeyPass or curPhaseHasAllPass
	local isSelect = self._curSelectPhase == data.phaseId
	local bgIdx = isSelect and 1 or 0

	bgChangeComp:SetState(bgIdx)

	txtName.text = data.name

	GameUtil.SetActive(lock, isLock)
	GameUtil.SetActive(pass, hasPass)
	GameUtil.addClickHandler(cell, function()
		if isLock then
			local timeStr = GameUtil.formatTimeStamp("%Y-%m-%d %H:%M:%S", unLockTime)
			local desc = string.format("%s后开放", timeStr)

			FloatWordMgr.instance:show(desc)

			return
		end

		if data.phaseId > self._curPhase then
			FloatWordMgr.instance:show("请先通关上一个关卡")

			return
		end

		self._curSelectPhase = data.phaseId

		self:_onUpdate()
	end, self)
end

function YunJieDragonClgLevelView:_clearLevelCell(cell)
	GameUtil.rmClickHandler(cell)
end

function YunJieDragonClgLevelView:_updateFmtCell(view, cell, data)
	local pass = goutil.findChild(cell, "pass")
	local item = goutil.findChild(cell, "reward/item")
	local gainReward = goutil.findChild(cell, "reward/gainReward")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local matStr = data.badgeMatStr

	if not self._info.passedStageIds then
		local passedStageIds = {}
		local hasPass = table.indexof(passedStageIds, data.stageId)

		if self._info.oneKeyPass then
			hasPass = true
		end

		txtName.text = string.format("第%s关", data.stageId)

		GameUtil.SetActive(pass, hasPass)
		GameUtil.SetActive(gainReward, hasPass)
		MaterialMgr.setCellByCfg(matStr, item)
		GameUtil.addClickHandler(cell, function()
			if hasPass then
				FloatWordMgr.instance:show("已通关，无需重复挑战")

				return
			end

			YunJieDragonClgController.instance:enterBattleClg(self._activityId, data.stageId)
		end, self)
	end
end

function YunJieDragonClgLevelView:_clearFmtCell(cell)
	local item = goutil.findChild(cell, "reward/item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(cell)
end

function YunJieDragonClgLevelView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function YunJieDragonClgLevelView:_onClickBtnCollect()
	UIStateManager.instance:push(ViewName.YunJieDragonClgCollectView, self._activityId)
end

return YunJieDragonClgLevelView
