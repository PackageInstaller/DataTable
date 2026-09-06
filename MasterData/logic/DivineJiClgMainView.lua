-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinejiclg/view/DivineJiClgMainView.lua

module("logic.extensions.divinejiclg.view.DivineJiClgMainView", package.seeall)

local DivineJiClgMainView = class("DivineJiClgMainView", ViewComponent)

function DivineJiClgMainView:ctor()
	DivineJiClgMainView.super.ctor(self)
end

function DivineJiClgMainView:buildUI()
	DivineJiClgMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtTime = self:getTxt("txtTime/txt")
	self._txtTimeGo = self:getGo("txtTime")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnPetSkill = self:getGo("petInfo/btnSkill")
	self._btnPetIntro = self:getGo("petInfo/btnIntroduce")
	self._txtPetName = self:getTxt("petInfo/txtName")
	self._con = self:getGo("con")
	self._jumpBtnCol = self:getGo("jumpBtnCol")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._redJump1 = self:getGo("jumpBtnCol/btnJump1/redPoint")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._redJump2 = self:getGo("jumpBtnCol/btnJump2/redPoint")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump4")
	self._redJump3 = self:getGo("jumpBtnCol/btnJump4/redPoint")
	self._bubble = self:getGo("clgBtnCol/bubble")
	self._itemcellGo = self:getGo("clgBtnCol/bubble/itemcell")
	self._imgHasGainGo = self:getGo("clgBtnCol/bubble/imgHasGain")
	self._btnClg1 = self:getGo("clgBtnCol/btnClg1/btn")
	self._rpBtnClg1 = self:getGo("clgBtnCol/btnClg1/btn/redPoint")
	self._passBtnClg1 = self:getGo("clgBtnCol/btnClg1/imgPass")
	self._btnClg2 = self:getGo("clgBtnCol/btnClg2/btn")
	self._rpBtnClg2 = self:getGo("clgBtnCol/btnClg2/btn/redPoint")
	self._passBtnClg2 = self:getGo("clgBtnCol/btnClg2/imgPass")
end

function DivineJiClgMainView:bindEvents()
	DivineJiClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTipBtn, self)
	GameUtil.addClickHandler(self._btnPetSkill, self._onClickPetSkillBtn, self)
	GameUtil.addClickHandler(self._btnPetIntro, self._onClickPetIntroBtn, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickJumpBtn1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickJumpBtn2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickJumpBtn3, self)
	GameUtil.addClickHandler(self._btnClg1, self._onClickClgBtn1, self)
	GameUtil.addClickHandler(self._btnClg2, self._onClickClgBtn2, self)
end

function DivineJiClgMainView:unbindEvents()
	DivineJiClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPetSkill)
	GameUtil.rmClickHandler(self._btnPetIntro)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnClg1)
	GameUtil.rmClickHandler(self._btnClg2)
end

function DivineJiClgMainView:onExit()
	DivineJiClgMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._rpBtnClg2)
end

function DivineJiClgMainView:onEnter()
	DivineJiClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.DivineJiClgGetInfoRes, self._refresh, self)
	self:_initActivityId()
	self:_checkAoqiGodFinish()

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	self:_initAoqiGodUI()
	self:_initActivityTime()
	self:_getViewConfig()
	self:_loadPetInfo()
	RedPointController.instance:regRedPoint(self._rpBtnClg2, self._activityCfg.redPointId)
	DivineJiClgAgent.instance:sendPM_DivineJiClgGetInfoReq(self._activityId)
end

function DivineJiClgMainView:_initAoqiGodUI()
	GameUtil.SetActive(self._bubble, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnClg2, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._jumpBtnCol, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._txtTimeGo, not self._isAoqiGodProcessType)
end

function DivineJiClgMainView:_checkAoqiGodFinish()
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if isAoqiGodProcessType then
		self._activityInfo = DivineJiClgModel.instance:getActivityInfo(self._activityId)

		if not self._activityInfo then
			return
		end

		local hasPassedExtremeClg = checkbool(self._activityInfo.hasPassedExtremeClg)

		if hasPassedExtremeClg then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.KingJiChallenge, self._activityId)
		end
	end
end

function DivineJiClgMainView:_initActivityId()
	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.DivineJiClg)
	end
end

function DivineJiClgMainView:_initActivityTime()
	self._txtTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function DivineJiClgMainView:_getViewConfig()
	self._activityCfg = DivineJiClgConfig.instance:getActivityCfgByActId(self._activityId)
end

function DivineJiClgMainView:_loadPetInfo()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetName.text = PetSkinConfig.instance:getPetSkinName(skinId)
end

function DivineJiClgMainView:_onClickTipBtn()
	local challengeCfg = TimeLimitedConfig.instance:getCfgById(198)

	TipsFacade.instance:openRulesView(challengeCfg.ruleKey)
end

function DivineJiClgMainView:_onClickJumpBtn1()
	local gotoStr = self._activityCfg.jumpStrOne

	if string.nilorempty(gotoStr) then
		printError("未配置跳转指令")

		return
	end

	GotoMgr.gotoByString(gotoStr)
end

function DivineJiClgMainView:_onClickJumpBtn2()
	local gotoStr = self._activityCfg.jumpStrTwo

	if string.nilorempty(gotoStr) then
		printError("未配置跳转指令")

		return
	end

	GotoMgr.gotoByString(gotoStr)
end

function DivineJiClgMainView:_onClickJumpBtn3()
	local gotoStr = self._activityCfg.jumpStrThree

	if string.nilorempty(gotoStr) then
		printError("未配置跳转指令")

		return
	end

	GotoMgr.gotoByString(gotoStr)
end

function DivineJiClgMainView:_onClickPetIntroBtn()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineJiClgMainView:_onClickPetSkillBtn()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineJiClgMainView:_onClickClgBtn1()
	if not self._activityInfo then
		return
	end

	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DivineJiClg, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local hasPassedExtremeClg = checkbool(self._activityInfo.hasPassedExtremeClg)

	if hasPassedExtremeClg then
		TipsFacade.instance:openCommonTips("已通关")
	else
		UIStateManager.instance:push(ViewName.DivineJiExtremeClgView, self._activityId)
	end
end

function DivineJiClgMainView:_onClickClgBtn2()
	if self._hasPassedNormalClg then
		FloatWordMgr.instance:show("已通关")

		return
	end

	UIStateManager.instance:push(ViewName.DivineJiNormalClgView, self._activityId)
end

function DivineJiClgMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DivineJiClgMainView:_getSkinId()
	return checknumber(self._activityCfg.skinId)
end

function DivineJiClgMainView:_refresh()
	self._activityInfo = DivineJiClgModel.instance:getActivityInfo(self._activityId)

	if not self._activityInfo then
		return
	end

	local hasPassedExtremeClg = checkbool(self._activityInfo.hasPassedExtremeClg)
	local extremeClgPrize = self._activityCfg.extremeClgPrize
	local normalClgPrzCfg = DivineJiClgConfig.instance:getNormalProgressCfgByActId(self._activityId)

	if not self._activityInfo.normalClgPrizeGainedBitId then
		local normalClgPrizeGainedBitId = {}

		self._hasPassedNormalClg = #normalClgPrizeGainedBitId >= #normalClgPrzCfg

		goutil.setActive(self._passBtnClg1, hasPassedExtremeClg)
		goutil.setActive(self._passBtnClg2, self._hasPassedNormalClg)
		MaterialMgr.resetAll(self._itemcellGo)
		MaterialMgr.setCellByCfg(extremeClgPrize, self._itemcellGo)
		goutil.setActive(self._imgHasGainGo, hasPassedExtremeClg)
	end
end

return DivineJiClgMainView
