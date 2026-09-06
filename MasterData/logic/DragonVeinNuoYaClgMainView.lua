-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonveinnuoyaclg/view/DragonVeinNuoYaClgMainView.lua

module("logic.extensions.dragonveinnuoyaclg.view.DragonVeinNuoYaClgMainView", package.seeall)

local DragonVeinNuoYaClgMainView = class("DragonVeinNuoYaClgMainView", ViewComponent)

function DragonVeinNuoYaClgMainView:ctor()
	DragonVeinNuoYaClgMainView.super.ctor(self)
end

function DragonVeinNuoYaClgMainView:unbindEvents()
	DragonVeinNuoYaClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnRule)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnCall)
	GameUtil.rmClickHandler(self._btnRank)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function DragonVeinNuoYaClgMainView:bindEvents()
	DragonVeinNuoYaClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnRule, self._onClickRule, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickChallenge, self)
	GameUtil.addClickHandler(self._btnCall, self._onClilckCall, self)
	GameUtil.addClickHandler(self._btnRank, self._onClilckRank, self)
	GameUtil.addClickHandler(self._btnSkill, self._onClilckSkill, self)
	GameUtil.addClickHandler(self._btnInfo, self._onClilckInfo, self)
end

function DragonVeinNuoYaClgMainView:buildUI()
	DragonVeinNuoYaClgMainView.super.buildUI(self)

	self._btnChallenge = self:getGo("btnChallenge")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnRule = self:getGo("btnRule")
	self._btnCall = self:getGo("btnCall")
	self._btnRank = self:getGo("btnRank")
	self._txtName = self:getTxt("petInfo/name/txtName")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._imgRare = self:getGo("petInfo/name/imgRare")
	self._petCon = self:getGo("petCon")
	self._time = self:getGo("time")
	self._txtTime = self:getTxt("time/txtTime")
	self._pass = self:getGo("btnChallenge/pass")
end

function DragonVeinNuoYaClgMainView:onExit()
	DragonVeinNuoYaClgMainView.super.onExit(self)
end

function DragonVeinNuoYaClgMainView:onEnter()
	DragonVeinNuoYaClgMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DragonVeinNuoYaClgDigRes, self._PM_DragonVeinNuoYaClgDigRes, self)
	self.addGEvent(self, GlobalNotify.PM_DragonVeinNuoYaClgGetInfoRes, self._PM_DragonVeinNuoYaClgDigRes, self)

	self._activityId = self:getFirstParam() or DragonVeinNuoYaClgModel.instance:getCurrActId()

	self:_checkAoqiGodFinish()

	self._isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)
	self._activityCfg = DragonVeinNuoYaClgConfig.instance:getActivityCfg(self._activityId)

	MaterialMgr.resetAll(self._imgRare)
	MaterialMgr.setCell(MatType.Rare, self._activityCfg.raceId, self._imgRare)

	local petCfg = CharacterConfig.instance:getPetCo(self._activityCfg.raceId)

	self._txtName.text = petCfg.name
	self._roleObj = RoleObjectPool.instance:addRoleToParent(self._roleObj, self._activityCfg.raceId, self._petCon)
	self._txtTime.text = GameUtil.getActTimeDesc(GameEnum.ActivityType.DragonVeinNuoYaClg, self._activityId)

	GameUtil.SetActive(self._time, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnRank, not self._isAoqiGodProcessType)
	GameUtil.SetActive(self._btnCall, not self._isAoqiGodProcessType)
	DragonVeinNuoYaClgAgent.instance:sendPM_DragonVeinNuoYaClgGetInfoReq(self._activityId)
end

function DragonVeinNuoYaClgMainView:_checkAoqiGodFinish()
	local isAoqiGodProcessType = ActivityDefineController.instance:isAoqiGodProcessType(self._activityId)

	if isAoqiGodProcessType then
		local pass = self:_checkIsAllDone()

		if pass then
			AoqiGodController.instance:doHandleChallengeFinishReady(GameEnum.ActivityType.DragonVeinNuoYaClg, self._activityId)
		end
	end
end

function DragonVeinNuoYaClgMainView:_checkIsAllDone()
	local stageId = DragonVeinNuoYaClgModel.instance:getStageId(self._activityId)
	local stageCfg = DragonVeinNuoYaClgConfig.instance:getStageCfg(self._activityId, stageId)
	local gridInfos = DragonVeinNuoYaClgModel.instance:getGridInfoList(self._activityId)
	local isAllDone = #gridInfos >= stageCfg.mapGridCount

	for i, v in ipairs(gridInfos) do
		if not v.done then
			isAllDone = false

			break
		end
	end

	local nextStageCfg = DragonVeinNuoYaClgConfig.instance:getStageCfg(self._activityId, stageId + 1)

	self._isAllDone = isAllDone and not nextStageCfg
end

function DragonVeinNuoYaClgMainView:_onClickChallenge()
	if self._isAoqiGodProcessType then
		local result = AoqiGodController.instance:getTryClgResultAndTipsByAct(true, GameEnum.ActivityType.DragonVeinNuoYaClg, self._activityId)

		if result ~= GameEnum.ResultCode.Success then
			return
		end
	end

	if self._isAllDone then
		FloatWordMgr.instance:show(lang("您已通关全部关卡，无需继续挑战"))
	else
		UIStateManager.instance:push(ViewName.DragonVeinNuoYaClgGameView, self._activityId)
	end
end

function DragonVeinNuoYaClgMainView:_onClilckCall()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[3])
end

function DragonVeinNuoYaClgMainView:_onClilckRank()
	GotoMgr.gotoByString(self._activityCfg.jumpTo[1])
end

function DragonVeinNuoYaClgMainView:_onClilckSkill()
	PetbookController.instance:previewBattle(self._activityCfg.raceId)
end

function DragonVeinNuoYaClgMainView:_onClilckInfo()
	PetbookController.instance:openPetinfoView(self._activityCfg.raceId)
end

function DragonVeinNuoYaClgMainView:_onClickRule()
	local key = self._activityCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function DragonVeinNuoYaClgMainView:_PM_DragonVeinNuoYaClgDigRes()
	self:_checkIsAllDone()
	GameUtil.SetActive(self._pass, self._isAllDone)
end

return DragonVeinNuoYaClgMainView
