-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/view/OriginKingMengMengClgNormalStageView.lua

module("logic.extensions.originkingmengmengclg.view.OriginKingMengMengClgNormalStageView", package.seeall)

local OriginKingMengMengClgNormalStageView = class("OriginKingMengMengClgNormalStageView", ViewComponent)

function OriginKingMengMengClgNormalStageView:buildUI()
	OriginKingMengMengClgNormalStageView.super.buildUI(self)

	self._stageView = self:getGo("stageCol/stageView")
	self._stageCell = self:getGo("stageCol/stageCell")
	self._bossCell = self:getGo("bossCell")
	self._btnBoss = self:getGo("bossCell/btn")
	self._tagBossPass = self:getGo("bossCell/btn/tagPass")
	self._tagBossLock = self:getGo("bossCell/btn/tagLock")
	self._itemBoss = self:getGo("bossCell/bubble/item")
	self._tagBossHasGain = self:getGo("bossCell/bubble/tagHasGain")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
end

function OriginKingMengMengClgNormalStageView:bindEvents()
	OriginKingMengMengClgNormalStageView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTips, self)
	GameUtil.addClickHandler(self._btnBoss, self._onClickBoss, self)
end

function OriginKingMengMengClgNormalStageView:unbindEvents()
	OriginKingMengMengClgNormalStageView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnBoss)
end

function OriginKingMengMengClgNormalStageView:onEnter()
	OriginKingMengMengClgNormalStageView.super.onEnter(self)

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
	self.addGEvent(self, GlobalNotify.HandlePM_OriginKingMengMengClgNormalFightNotifyRes, self._onUpdate, self)
	self:_onUpdate()
	OriginKingMengMengClgController.instance:sendPM_OriginKingMengMengClgGetInfoReq(self._activityId)
end

function OriginKingMengMengClgNormalStageView:onExit()
	OriginKingMengMengClgNormalStageView.super.onExit(self)
	self:_clearStageCells()
	MaterialMgr.resetAll(self._itemBoss)
end

function OriginKingMengMengClgNormalStageView:_onUpdate()
	local stageDatas = OriginKingMengMengClgConfig.instance:getStageDatas(self._activityId)

	GameUtil.updateCellsList(self._stageView, self._stageCell, stageDatas, self._updateStageCell, self)
	self:_updateBossCell()
end

function OriginKingMengMengClgNormalStageView:_clearStageCells()
	GameUtil.clearCells(self._stageView, self._clearStageCell, self)
end

function OriginKingMengMengClgNormalStageView:_updateStageCell(mainGo, stageData, index)
	local stageId = stageData.stageId
	local isPass = self._subMo:isNormalStagePassed(stageId)
	local btnGo = goutil.findChild(mainGo, "btn")
	local tagPass = goutil.findChild(mainGo, "btn/tagPass")
	local item = goutil.findChild(mainGo, "bubble/item")
	local tagHasGain = goutil.findChild(mainGo, "bubble/tagHasGain")

	GameUtil.SetActive(tagPass, isPass)
	GameUtil.SetActive(tagHasGain, isPass)
	MaterialMgr.setCellByCfg(stageData.passPrize, item)
	GameUtil.addClickHandler(btnGo, GameUtil.handler(self._onClickStageCell, self, stageData))
end

function OriginKingMengMengClgNormalStageView:_clearStageCell(mainGo)
	local btnGo = goutil.findChild(mainGo, "btn")
	local item = goutil.findChild(mainGo, "bubble/item")

	GameUtil.rmClickHandler(btnGo)
	MaterialMgr.resetAll(item)
end

function OriginKingMengMengClgNormalStageView:_onClickStageCell(stageData)
	local stageId = stageData.stageId

	if self._subMo:isNormalStagePassed(stageId) then
		FloatWordMgr.instance:show("已通关")

		return
	end

	OriginKingMengMengClgController.instance:enterBattleNormal(self._activityId, stageId)
end

function OriginKingMengMengClgNormalStageView:_updateBossCell()
	local isPass = self._subMo:isNormalClgPass()

	GameUtil.SetActive(self._tagBossPass, isPass)
	GameUtil.SetActive(self._tagBossLock, false)
	GameUtil.SetActive(self._tagBossHasGain, isPass)
	MaterialMgr.setCellByCfg(self._actData.normalClgPrize, self._itemBoss)
end

function OriginKingMengMengClgNormalStageView:_onClickBoss()
	if self._subMo:isNormalClgPass() then
		FloatWordMgr.instance:show("已通关")

		return
	end

	OriginKingMengMengClgController.instance:enterBattleNormalBoss(self._activityId)
end

function OriginKingMengMengClgNormalStageView:_onClickBtnTips()
	local key = self._actData.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

return OriginKingMengMengClgNormalStageView
