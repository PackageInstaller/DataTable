-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/view/DivineKingCiYuanMainView.lua

module("logic.extensions.divinekingciyuan.view.DivineKingCiYuanMainView", package.seeall)

local DivineKingCiYuanMainView = class("DivineKingCiYuanMainView", ViewComponent)

function DivineKingCiYuanMainView:ctor()
	DivineKingCiYuanMainView.super.ctor(self)
end

function DivineKingCiYuanMainView:buildUI()
	DivineKingCiYuanMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._timeGo = self:getGo("txtTime")
	self._txtTime = self:getTxt("txtTime/txt")
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
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._redJump3 = self:getGo("jumpBtnCol/btnJump3/redPoint")
	self._bubbleGo = self:getGo("clgBtnCol/bubble")
	self._itemcellGo = self:getGo("clgBtnCol/bubble/itemcell")
	self._imgHasGainGo = self:getGo("clgBtnCol/bubble/imgHasGain")
	self._btnClg1 = self:getGo("clgBtnCol/btnClg1/btn")
	self._rpBtnClg1 = self:getGo("clgBtnCol/btnClg1/btn/redPoint")
	self._passBtnClg1 = self:getGo("clgBtnCol/btnClg1/imgPass")
	self._imgAttr = self:getGo("btnAttr/img")

	self:_recordGoDefaultActive(self._jumpBtnCol)
	self:_recordGoDefaultActive(self._timeGo)
	self:_recordGoDefaultActive(self._bubbleGo)
end

function DivineKingCiYuanMainView:bindEvents()
	DivineKingCiYuanMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTipBtn, self)
	GameUtil.addClickHandler(self._btnPetSkill, self._onClickPetSkillBtn, self)
	GameUtil.addClickHandler(self._btnPetIntro, self._onClickPetIntroBtn, self)
	GameUtil.addClickHandler(self._btnJump1, self._onClickJumpBtn1, self)
	GameUtil.addClickHandler(self._btnJump2, self._onClickJumpBtn2, self)
	GameUtil.addClickHandler(self._btnJump3, self._onClickJumpBtn3, self)
	GameUtil.addClickHandler(self._btnClg1, self._onClickClgBtn1, self)
end

function DivineKingCiYuanMainView:unbindEvents()
	DivineKingCiYuanMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnPetSkill)
	GameUtil.rmClickHandler(self._btnPetIntro)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnClg1)
end

function DivineKingCiYuanMainView:onExit()
	DivineKingCiYuanMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
	MaterialMgr.resetAll(self._itemcellGo)
	MaterialMgr.clearIcon(self._imgAttr)
end

function DivineKingCiYuanMainView:onEnter()
	DivineKingCiYuanMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = DivineKingCiYuanController.instance:getActivityId()
	end

	local isInActivityTime = ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId)

	if not isInActivityTime then
		self:close()

		return
	end

	self._activityType = DivineKingCiYuanController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._actCfg = DivineKingCiYuanConfig.instance:getDefineCfgByActId(self._activityId)

	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._jumpBtnCol, false)
		GameUtil.SetActive(self._timeGo, false)
		GameUtil.SetActive(self._bubbleGo, false)
	else
		self:_refreshDefaultActive(self._jumpBtnCol)
		self:_refreshDefaultActive(self._timeGo)
		self:_refreshDefaultActive(self._bubbleGo)
	end

	self:_initActivityTime()
	self:_loadPetInfo()
	self:_refreshViewUI()
	self.addGEvent(self, GlobalNotify.DivineKingCiYuanGetInfoRes, self._refreshViewUI, self)
	DivineKingCiYuanAgent.instance:sendPM_DivineKingCiYuanGetInfoReq(self._activityId)
end

function DivineKingCiYuanMainView:_initActivityTime()
	local startTimeStemp, endTimeStemp = ActivityDefineController:getStartTimeAndEndTime(GameEnum.ActivityType.DivineKingCiYuan, self._activityId)
	local startTime = GameUtil.time2date(startTimeStemp)
	local endTime = GameUtil.time2date(endTimeStemp)

	self._txtTime.text = langPara("活动时间：%d.%d %d:%02d -%d.%d %d:%02d", startTime.month, startTime.day, startTime.hour, startTime.min, endTime.month, endTime.day, endTime.hour, endTime.min)
end

function DivineKingCiYuanMainView:_loadPetInfo()
	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetName.text = PetSkinConfig.instance:getPetSkinName(skinId)

	MaterialMgr.setIcon(self._imgAttr, MatType.PET_SKIN, skinId)
end

function DivineKingCiYuanMainView:_onClickTipBtn()
	TipsFacade.instance:openRulesView("divinekingciyuanmainview_rule")
end

function DivineKingCiYuanMainView:_onClickJumpBtn1()
	local gotoStr = self._actCfg.jumpStrOne

	if string.nilorempty(gotoStr) then
		return
	end

	GotoMgr.gotoByString(gotoStr)
end

function DivineKingCiYuanMainView:_onClickJumpBtn2()
	local gotoStr = self._actCfg.jumpStrTwo

	if string.nilorempty(gotoStr) then
		return
	end

	GotoMgr.gotoByString(gotoStr)
end

function DivineKingCiYuanMainView:_onClickJumpBtn3()
	local gotoStr = self._actCfg.jumpStrThree

	if string.nilorempty(gotoStr) then
		return
	end

	GotoMgr.gotoByString(gotoStr)
end

function DivineKingCiYuanMainView:_onClickPetIntroBtn()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function DivineKingCiYuanMainView:_onClickPetSkillBtn()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function DivineKingCiYuanMainView:_onClickClgBtn1()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local curPhaseId = DivineKingCiYuanModel.instance:getCurPhaseId(self._activityId)
	local list = DivineKingCiYuanConfig.instance:getPhaseCfgsByActId(self._activityId) or {}

	if curPhaseId > #list then
		TipsFacade.instance:openCommonTips("已经全部通关")
	else
		UIStateManager.instance:push(ViewName.DivineKingCiYuanClgView, self._activityId)
	end
end

function DivineKingCiYuanMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self:_getSkinId())
end

function DivineKingCiYuanMainView:_getSkinId()
	return checknumber(self._actCfg.skinId)
end

function DivineKingCiYuanMainView:_refreshViewUI()
	self._info = DivineKingCiYuanModel.instance:getInfo(self._activityId) or {}

	local curPhaseId = DivineKingCiYuanModel.instance:getCurPhaseId(self._activityId) or 1
	local list = DivineKingCiYuanConfig.instance:getPhaseCfgsByActId(self._activityId) or {}
	local isPassAll = curPhaseId > #list

	goutil.setActive(self._passBtnClg1, isPassAll)
	goutil.setActive(self._imgHasGainGo, isPassAll)

	curPhaseId = isPassAll and #list or curPhaseId

	local phaseCfg = DivineKingCiYuanConfig.instance:getPhaseCfg(self._activityId, curPhaseId)

	MaterialMgr.resetAll(self._itemcellGo)
	MaterialMgr.setCellByCfg(phaseCfg.prize, self._itemcellGo)
end

function DivineKingCiYuanMainView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function DivineKingCiYuanMainView:_refreshDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}

	GameUtil.SetActive(go, checkbool(self._goDefaultActives[go]))
end

return DivineKingCiYuanMainView
