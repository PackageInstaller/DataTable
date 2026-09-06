-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineciyuan/view/DivineCiYuanExtremeView.lua

module("logic.extensions.divineciyuan.view.DivineCiYuanExtremeView", package.seeall)

local DivineCiYuanExtremeView = class("DivineCiYuanExtremeView", ViewComponent)

function DivineCiYuanExtremeView:ctor()
	DivineCiYuanExtremeView.super.ctor(self)
end

function DivineCiYuanExtremeView:unbindEvents()
	DivineCiYuanExtremeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBuff)
end

function DivineCiYuanExtremeView:bindEvents()
	DivineCiYuanExtremeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBuff, self)
end

function DivineCiYuanExtremeView:buildUI()
	DivineCiYuanExtremeView.super.buildUI(self)

	self._tabViewGo = self:getGo("tabView")
	self._tabCell = self:getGo("tabCell")
	self._stageCell = self:getGo("cell")
	self._buffIcon = self:getGo("info/btnBuff/icon")
	self._buffRd = self:getGo("info/btnBuff/redpoint")
	self._stage = self:getGo("stage")
	self._layout = self:getGo("stage"):GetComponent(ComponentType.UILayoutSingleLine)
	self._slider = self:getSlider("info/level")
	self._timeGo = self:getGo("time")
	self._txtTime = self:getTxt("time/txt")
	self._txtStage = self:getTxt("info/level/Fill Area/info/txtStage")
	self._txtUp = self:getTxt("info/txtUp")
	self._txtDown = self:getTxt("info/txtDown")
	self._txtDesc = self:getTxt("desc/txt")
	self._btnBuff = self:getBtn("info/btnBuff")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._tabView = ScrollerList.create(self._tabViewGo, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))

	self:_recordGoDefaultActive(self._timeGo)
end

function DivineCiYuanExtremeView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function DivineCiYuanExtremeView:_isActiveInDefault(go)
	self._goDefaultActives = self._goDefaultActives or {}

	return self._goDefaultActives[go]
end

function DivineCiYuanExtremeView:_refreshDefaultActive(go)
	GameUtil.SetActive(go, self:_isActiveInDefault(go))
end

function DivineCiYuanExtremeView:onExit()
	DivineCiYuanExtremeView.super.onExit(self)
	self._tabView:dispose()
	self:_clearStageCell()
	uGuiUtil.clearImage(self._buffIcon)
	RedPointController.instance:unregRedPoint(self._buffRd)
end

function DivineCiYuanExtremeView:onEnter()
	DivineCiYuanExtremeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineCiYuanGetInfoRes, self._refresh, self)
	self.addGEvent(self, GlobalNotify.DivineCiYuanExtremeResetRes, self._sendGetInfoReq, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineCiYuan)
	end

	self._activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	RedPointController.instance:regRedPoint(self._buffRd, RedPointModel.ID_O22)

	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	self:_initAoqiGodUI()

	self._selectTabId = DivineCiYuanController.instance:getExtremetTabId(self._activityId)
	self._stageId = DivineCiYuanModel.instance:getExtremeStageIds(self._selectTabId)
	self._tabCfg = DivineCiYuanConfig.instance:getTabCfg(self._activityId)
	self._tabStageCfg = DivineCiYuanConfig.instance:getTabCfgById(self._activityId, self._selectTabId)

	self:_sendGetInfoReq()
end

function DivineCiYuanExtremeView:_initAoqiGodUI()
	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._timeGo, false)
	else
		self:_refreshDefaultActive(self._timeGo)
	end
end

function DivineCiYuanExtremeView:_sendGetInfoReq()
	DivineCiYuanController.instance:sendPM_DivineCiYuanGetInfoReq(self._activityId)
end

function DivineCiYuanExtremeView:_refresh()
	local isAllPass = DivineCiYuanController.instance:isPassExtremeChallenge(self._activityId)

	if isAllPass then
		FloatWordMgr.instance:show("恭喜你,通关所有极限挑战")
		self:close()

		return
	end

	self._selectTabId = DivineCiYuanController.instance:getExtremetTabId(self._activityId)
	self._stageId = DivineCiYuanModel.instance:getExtremeStageIds(self._selectTabId)
	self._isPassNextLock = DivineCiYuanController.instance:isPassNextLock(self._activityId, self._selectTabId)

	self:_onClickTab(self._selectTabId)
	self:_refreshBuff()
	self:_refreshProgress()
end

function DivineCiYuanExtremeView:_refreshChallenge(teamIds)
	local teamCount = table.nums(teamIds)
	local stageChildCount = self._stage.transform.childCount

	if teamCount < stageChildCount then
		for i = teamCount + 1, stageChildCount do
			local child = goutil.findChild(self._stage, "cell_" .. i)

			GameUtil.SetActive(child, false)
		end
	end

	for i = 1, teamCount do
		local child = goutil.findChild(self._stage, "cell_" .. i)

		child = child or goutil.cloneAndSetParent(self._stageCell, self._stage.transform, "cell_" .. i)

		GameUtil.SetActive(child, true)
		self:_updateStageCell(child, teamIds[i], i - 1)
	end

	self._layout:Layout()
end

function DivineCiYuanExtremeView:_updateTabCell(view, cell, data)
	local petIcon = goutil.findChild(cell, "petIcon")
	local pass = goutil.findChild(cell, "pass")
	local lock = goutil.findChild(cell, "lock")
	local select = goutil.findChild(cell, "select")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtLock = goutil.findChildTextComponent(cell, "lock/txt")
	local isUnLock = DivineCiYuanController.instance:isUnLockExtremeTab(self._activityId, data.tabId)
	local isPass = DivineCiYuanController.instance:isPassExtremeTab(self._activityId, data.tabId)
	local iconPath = data.iconPath .. ".png"

	uGuiUtil.setSpriteToImage(petIcon, uGuiUtil.SpriteType.BigBg, iconPath)

	txtName.text = data.name
	txtLock.text = DivineCiYuanController.instance:extremeLockDesc(self._activityId, data.tabId)

	GameUtil.SetActive(lock, not isUnLock)
	GameUtil.SetActive(pass, isPass)
	GameUtil.SetActive(select, data.tabId == self._selectTabId)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickTab, self, data.tabId))
end

function DivineCiYuanExtremeView:_clearTabCell(cell)
	local petIcon = goutil.findChild(cell, "petIcon")

	uGuiUtil.clearImage(petIcon)
	GameUtil.rmClickHandler(cell)
end

function DivineCiYuanExtremeView:_updateStageCell(cell, teamId, teamIndex)
	local pass = goutil.findChild(cell, "pass")
	local btnChallenge = goutil.findChildButtonComponent(cell, "btnChallenge")
	local btnReset = goutil.findChildButtonComponent(cell, "btnReset")
	local txtTip = goutil.findChildTextComponent(cell, "formation/txtTip")
	local isPass = DivineCiYuanController.instance:isPassExtremeTeam(self._activityId, self._selectTabId, self._stageId, teamIndex)

	GameUtil.SetActive(pass, isPass)
	GameUtil.SetActive(btnReset.gameObject, isPass and not self._isPassNextLock)
	GameUtil.SetActive(btnChallenge.gameObject, not isPass and not self._isPassNextLock)

	local stageCfg = DivineCiYuanConfig.instance:getExtremeStageCfgById(self._activityId, self._selectTabId, self._stageId)

	txtTip.text = stageCfg.levelDescription

	for i = 1, 9 do
		local go = goutil.findChild(cell, "formation/cell_" .. i)
		local creepCfg = DivineCiYuanConfig.instance:getCreepCfgByPos(teamId, i)

		if creepCfg then
			MaterialMgr.setIcon(goutil.findChild(go, "con"), MatType.Pet, creepCfg.raceId)
		end

		GameUtil.SetActive(go, creepCfg)
	end

	GameUtil.addClickHandler(btnChallenge, GameUtil.handler(self._onClickChallenge, self, self._selectTabId, self._stageId, teamIndex))
	GameUtil.addClickHandler(btnReset, GameUtil.handler(self._onClickReset, self, self._selectTabId, self._stageId, teamIndex))
end

function DivineCiYuanExtremeView:_clearStageCell()
	local stageChildCount = self._stage.transform.childCount

	if stageChildCount > 0 then
		for i = 1, stageChildCount do
			local child = goutil.findChild(self._stage, "cell_" .. i)

			if child then
				local btnChallenge = goutil.findChildButtonComponent(child, "btnChallenge")
				local btnReset = goutil.findChildButtonComponent(child, "btnReset")

				GameUtil.rmClickHandler(btnChallenge)
				GameUtil.rmClickHandler(btnReset)
			end
		end
	end
end

function DivineCiYuanExtremeView:_refreshBuff()
	local buffId = DivineCiYuanModel.instance:getSelectBuffId(self._selectTabId)

	if buffId > 0 then
		local buffCfg = DivineCiYuanConfig.instance:getBuffCfg(buffId)

		uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(buffCfg.icon))
	end
end

function DivineCiYuanExtremeView:_refreshProgress()
	local stageCfg = DivineCiYuanConfig.instance:getExtremeStageCfg(self._activityId, self._selectTabId)

	self._txtDown.text = stageCfg[1].stageId .. "层"
	self._txtUp.text = stageCfg[#stageCfg].stageId .. "层"
	self._txtStage.text = "当前" .. self._stageId .. "层"

	local curStageCount = Mathf.Clamp(self._stageId - 1, 0, stageCfg[#stageCfg].stageId - 1)
	local totalStageCount = checknumber(stageCfg[#stageCfg].stageId - 1)

	self._slider:SetValue(curStageCount / totalStageCount)
end

function DivineCiYuanExtremeView:_onClickTip()
	local key = DivineCiYuanConfig.instance:getActRuleKey(self._activityId, "ruleKeyExtreme")

	TipsFacade.instance:openRulesView(key)
end

function DivineCiYuanExtremeView:_onClickTab(tabId)
	local isUnLock = DivineCiYuanController.instance:isUnLockExtremeTab(self._activityId, tabId)

	if not isUnLock then
		FloatWordMgr.instance:show("当前关卡未解锁")

		return
	end

	if tabId < self._selectTabId then
		FloatWordMgr.instance:show("当前关卡已通关")

		return
	end

	self._selectTabId = tabId

	self._tabView:reloadData(self._tabCfg)

	local stageCfg = DivineCiYuanConfig.instance:getExtremeStageCfgById(self._activityId, self._selectTabId, self._stageId)

	self:_refreshChallenge(stageCfg.teamIds)

	self._txtDesc.text = self._tabStageCfg.ruleDescription

	GameUtil.SetActive(self._btnBuff.gameObject, self._tabStageCfg.buffSelect)
end

function DivineCiYuanExtremeView:_onClickBuff()
	UIStateManager.instance:push(ViewName.DivineCiYuanBuffView, self._activityId, self._selectTabId)
end

function DivineCiYuanExtremeView:_onClickChallenge(tabId, stageId, teamId)
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	DivineCiYuanController.instance:openDivineCiYuanExtremeForm(self._activityId, tabId, stageId, teamId)
end

function DivineCiYuanExtremeView:_onClickReset(tabId, stageId, teamId)
	local tips = lang("divineciyuan_extreme_reset_tip")

	local function sureChange()
		DivineCiYuanController.instance:sendPM_DivineCiYuanExtremeResetReq(self._activityId, tabId, stageId, teamId)
	end

	TipsFacade.instance:openTipWindow(lang("text_tong_tips"), tips, sureChange, "确定", UnityEngine.TextAnchor.MiddleCenter)
end

return DivineCiYuanExtremeView
