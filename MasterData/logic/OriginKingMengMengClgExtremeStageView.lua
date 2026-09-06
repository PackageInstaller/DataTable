-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgExtremeStageView.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgExtremeStageView", package.seeall)

local OriginKingMengMengClgExtremeStageView = class("OriginKingMengMengClgExtremeStageView", ViewComponent)

function OriginKingMengMengClgExtremeStageView:buildUI()
	OriginKingMengMengClgExtremeStageView.super.buildUI(self)

	self._stageView = self:getGo("stageCol/stageView")
	self._stageCell = self:getGo("stageCol/stageCell")
	self._bossCell = self:getGo("bossCell")
	self._btnBoss = self:getGo("bossCell/btn")
	self._tagBossPass = self:getGo("bossCell/btn/tagPass")
	self._tagBossLock = self:getGo("bossCell/btn/tagLock")
	self._txtBossScore = self:getTxt("bossCell/score/txt")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
end

function OriginKingMengMengClgExtremeStageView:bindEvents()
	OriginKingMengMengClgExtremeStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnBoss, self._onClickBoss, self)
end

function OriginKingMengMengClgExtremeStageView:unbindEvents()
	OriginKingMengMengClgExtremeStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBoss)
end

function OriginKingMengMengClgExtremeStageView:onEnter()
	OriginKingMengMengClgExtremeStageView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = checknumber(params[1])

	local isInTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._subMo = OriginKingMengMengClgController.instance:getSubMo(self._activityId)
	self._actData = OriginKingMengMengClgConfig.instance:getActivityData(self._activityId)

	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingMengMengClgGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingMengMengClgResetRes, self._onUpdate, self)
	self:_onUpdate()
	OriginKingMengMengClgController.instance:sendPM_OriginKingMengMengClgGetInfoReq(self._activityId)
end

function OriginKingMengMengClgExtremeStageView:onExit()
	OriginKingMengMengClgExtremeStageView.super.onExit(self)
	self:_clearStageCells()
end

function OriginKingMengMengClgExtremeStageView:_onUpdate()
	local stageDatas = OriginKingMengMengClgConfig.instance:getStageDatas(self._activityId)

	GameUtil.updateCellsList(self._stageView, self._stageCell, stageDatas, self._updateStageCell, self)
	self:_updateBossCell()
end

function OriginKingMengMengClgExtremeStageView:_clearStageCells()
	GameUtil.clearCells(self._stageView, self._clearStageCell, self)
end

function OriginKingMengMengClgExtremeStageView:_updateStageCell(mainGo, stageData, index)
	local stageId = stageData.stageId
	local isPass = self._subMo:isExtremeStagePassed(stageId)
	local curValue = self._subMo:getStageValue(stageId)
	local btnGo = goutil.findChild(mainGo, "btn")
	local tagPass = goutil.findChild(mainGo, "btn/tagPass")
	local txtScore = goutil.findChildTextComponent(mainGo, "score/txt")

	GameUtil.SetActive(tagPass, isPass)

	txtScore.text = string.format("星迹共鸣度：%s", curValue)

	GameUtil.addClickHandler(btnGo, GameUtil.handler(self._onClickStageCell, self, stageData))
end

function OriginKingMengMengClgExtremeStageView:_clearStageCell(mainGo)
	local btnGo = goutil.findChild(mainGo, "btn")

	GameUtil.rmClickHandler(btnGo)
end

function OriginKingMengMengClgExtremeStageView:_updateBossCell()
	local unlockNeedValue = self._subMo:getUnlockBossStageValue()
	local curTotalValue = self._subMo:getTotalValue()
	local isUnlocked = self._subMo:isExtremeBossUnlocked()
	local isPass = self._subMo:isExtremeClgPass()
	local supportPetData = OriginKingMengMengClgConfig.instance:getSupportPetData(self._activityId, self._actData.extremeClgSupportPetId)

	GameUtil.SetActive(self._tagBossPass, isPass)
	GameUtil.SetActive(self._tagBossLock, not isUnlocked)

	self._txtBossScore.text = isUnlocked and string.format("星迹共鸣度：%s/%s", curTotalValue, unlockNeedValue) or string.format("星迹共鸣度：<color=#eb4624>%s</color>/%s", curTotalValue, unlockNeedValue)
end

function OriginKingMengMengClgExtremeStageView:_onClickStageCell(stageData)
	if self._subMo:isExtremeStagePassed(stageData.stageId) then
		UIStateManager.instance:push(ViewName.OriginKingMengMengClgExtremeStageInfoPopView, self._activityId, stageData.stageId)
	else
		UIStateManager.instance:push(ViewName.OriginKingMengMengClgExtremeEnterPopView, self._activityId, stageData.stageId)
	end
end

function OriginKingMengMengClgExtremeStageView:_onClickBoss()
	if not self._subMo:isExtremeBossUnlocked() then
		FloatWordMgr.instance:show(string.format("五梦关共鸣度总和达到%s后解锁", self._subMo:getUnlockBossStageValue()))

		return
	end

	OriginKingMengMengClgController.instance:enterBattleBoss(self._activityId)
end

function OriginKingMengMengClgExtremeStageView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return OriginKingMengMengClgExtremeStageView
