-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nuoyasisterclg/view/NuoYaSisterClgMainView.lua

module("logic.extensions.nuoyasisterclg.view.NuoYaSisterClgMainView", package.seeall)

local NuoYaSisterClgMainView = class("NuoYaSisterClgMainView", ViewComponent)

function NuoYaSisterClgMainView:ctor()
	NuoYaSisterClgMainView.super.ctor(self)
end

function NuoYaSisterClgMainView:unbindEvents()
	NuoYaSisterClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnExtChallenge)
	GameUtil.rmClickHandler(self._btnComChallenge)
	GameUtil.rmClickHandler(self._btnClose)
end

function NuoYaSisterClgMainView:bindEvents()
	NuoYaSisterClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnExtChallenge, self._onClickExtChallenge, self)
	GameUtil.addClickHandler(self._btnComChallenge, self._onClickComChallenge, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClickSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClickInfo, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnCall, self._onClickCall, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickPrize, self)
end

function NuoYaSisterClgMainView:buildUI()
	NuoYaSisterClgMainView.super.buildUI(self)

	self._btnExtChallenge = self:getGo("btnExtChallenge")
	self._btnComChallenge = self:getGo("btnComChallenge")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("btnRule")
	self._petCon = self:getGo("petCon")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._imgRare = self:getGo("petInfo/name/imgRare")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._jumpCol = self:getGo("jumpCol")
	self._btnRank = self:getGo("jumpCol/btnRank")
	self._btnCall = self:getGo("jumpCol/btnCall")
	self._btnPrize = self:getGo("jumpCol/btnPrize")
	self._timeGo = self:getGo("time")
	self._txtTime = self:getTxt("time/txtTime")
	self._commonPass = self:getGo("btnComChallenge/pass")
	self._extremePass = self:getGo("btnExtChallenge/pass")

	self:_recordGoDefaultActive(self._jumpCol)
	self:_recordGoDefaultActive(self._timeGo)
	self:_recordGoDefaultActive(self._btnComChallenge)
end

function NuoYaSisterClgMainView:onExit()
	NuoYaSisterClgMainView.super.onExit(self)
	RoleObjectPool.instance:removeRole(self._raceObj)
end

function NuoYaSisterClgMainView:onEnter()
	NuoYaSisterClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_NuoYaSisterExtremeClgInfoRes, self._refreshExtremeView, self)
	self.addGEvent(self, GlobalNotify.PM_NuoYaSisterCommonClgInfoRes, self._refreshCommonView, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = NuoYaSisterClgController.instance:getActivityId()
	end

	local isInTime = NuoYaSisterClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		self:close()

		return
	end

	self._activityType = NuoYaSisterClgController.instance:getActivityType()
	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._activityCfg = NuoYaSisterClgConfig.instance:getActivityCfg(self._activityId)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name
	self._raceObj = RoleObjectPool.instance:addRoleToParent(self._raceObj, self._activityCfg.raceId, self._petCon)
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.NuoYaSisterClg, self._activityId)

	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._imgRare)

	if self._isAoqiGodProcessType then
		GameUtil.SetActive(self._jumpCol, false)
		GameUtil.SetActive(self._timeGo, false)
		GameUtil.SetActive(self._btnComChallenge, false)
	else
		self:_refreshDefaultActive(self._jumpCol)
		self:_refreshDefaultActive(self._timeGo)
		self:_refreshDefaultActive(self._btnComChallenge)
	end

	NuoYaSisterClgAgent.instance:sendPM_NuoYaSisterExtremeClgInfoReq(self._activityId)

	if not self._isAoqiGodProcessType then
		NuoYaSisterClgAgent.instance:sendPM_NuoYaSisterCommonClgInfoReq(self._activityId)
	end
end

function NuoYaSisterClgMainView:_refreshExtremeView()
	local maxStageId = NuoYaSisterClgModel.instance:getMaxStageId(self._activityId)
	local isPass = true

	for i = 1, 2 do
		if NuoYaSisterClgConfig.instance:getStageCfg(self._activityId, i, maxStageId + 1) then
			isPass = false

			break
		end
	end

	GameUtil.SetActive(self._extremePass, isPass)
end

function NuoYaSisterClgMainView:_refreshCommonView()
	local isPass = true
	local rewardCfg = NuoYaSisterClgConfig.instance:getRewardProgressListCfgs(self._activityId)

	for i, v in ipairs(rewardCfg) do
		if not NuoYaSisterClgModel.instance:isGetedProgressReward(self._activityId, v.prizeId) then
			isPass = false

			break
		end
	end

	GameUtil.SetActive(self._commonPass, isPass)
end

function NuoYaSisterClgMainView:_onClickExtChallenge()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, self._activityType, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	local maxStageId = NuoYaSisterClgModel.instance:getMaxStageId(self._activityId)
	local isPass = true

	for i = 1, 2 do
		if NuoYaSisterClgConfig.instance:getStageCfg(self._activityId, i, maxStageId + 1) then
			isPass = false

			break
		end
	end

	if isPass == true then
		FloatWordMgr.instance:show(lang("已通关全部关卡"))

		return
	end

	local isTeam = not NuoYaSisterClgModel.instance:IsInitTeam(self._activityId)

	if isTeam then
		UIStateManager.instance:push(ViewName.NuoYaSisterClgTeamView, self._activityId)
	else
		UIStateManager.instance:push(ViewName.NuoYaSisterClgExtremeView, self._activityId)
	end
end

function NuoYaSisterClgMainView:_onClickComChallenge()
	if self._isAoqiGodProcessType then
		return
	end

	local isPass = true
	local rewardCfg = NuoYaSisterClgConfig.instance:getRewardProgressListCfgs(self._activityId)

	for i, v in ipairs(rewardCfg) do
		if not NuoYaSisterClgModel.instance:isGetedProgressReward(self._activityId, v.prizeId) then
			isPass = false

			break
		end
	end

	if isPass then
		FloatWordMgr.instance:show(lang("已通关"))
	else
		UIStateManager.instance:push(ViewName.NuoYaSisterClgCommonView, self._activityId)
	end
end

function NuoYaSisterClgMainView:_onClickRule()
	TipsFacade.instance:openRulesView("nuo_ya_sister_clg")
end

function NuoYaSisterClgMainView:_onClickSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function NuoYaSisterClgMainView:_onClickInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

function NuoYaSisterClgMainView:_onClickRank()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[1])
end

function NuoYaSisterClgMainView:_onClickCall()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[2])
end

function NuoYaSisterClgMainView:_onClickPrize()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[3])
end

function NuoYaSisterClgMainView:_recordGoDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}
	self._goDefaultActives[go] = GameUtil.GetActive(go)
end

function NuoYaSisterClgMainView:_refreshDefaultActive(go)
	self._goDefaultActives = self._goDefaultActives or {}

	GameUtil.SetActive(go, checkbool(self._goDefaultActives[go]))
end

return NuoYaSisterClgMainView
