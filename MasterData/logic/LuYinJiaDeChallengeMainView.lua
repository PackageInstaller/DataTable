-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luyinjiade/view/LuYinJiaDeChallengeMainView.lua

module("logic.extensions.luyinjiade.view.LuYinJiaDeChallengeMainView", package.seeall)

local LuYinJiaDeChallengeMainView = class("LuYinJiaDeChallengeMainView", ViewComponent)

function LuYinJiaDeChallengeMainView:buildUI()
	LuYinJiaDeChallengeMainView.super.buildUI(self)

	self._con = self:getGo("petCon")
	self._btnSkill = self:getGo("petInfo/btnSkill")
	self._btnInfo = self:getGo("petInfo/btnInfo")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._pointRare = self:getGo("petInfo/pointRare")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("time/txt")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnEnter = self:getGo("btnEnter")
end

function LuYinJiaDeChallengeMainView:bindEvents()
	LuYinJiaDeChallengeMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, "One"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, "Two"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, "Three"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, "Four"))
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnInfo, self._onBtnIntroduceClg, self)
end

function LuYinJiaDeChallengeMainView:unbindEvents()
	LuYinJiaDeChallengeMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnEnter)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnInfo)
end

function LuYinJiaDeChallengeMainView:onEnter()
	LuYinJiaDeChallengeMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_LuYinJiaDeClgGetInfoRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 465001
	end

	self._activityType = 465
	self._actCfg = LuYinJiaDeConfig.instance:getActData(self._activityId)
	self._info = LuYinJiaDeModel.instance:getInfo(self._activityId)

	self:_onSetUI()
	LuYinJiaDeController.instance:sendPM_LuYinJiaDeClgGetInfoReq(self._activityId)

	if LuYinJiaDeController.instance:canShowDailyRank(self._activityId) then
		LuYinJiaDeController.instance:sendPM_LuYinJiaDeClgDailyRankViewReq(self._activityId)
	end

	if self:_isInChallengeTime() then
		LuYinJiaDeController.instance:sendPM_LuYinJiaDeClgGodRankViewReq(self._activityId)
	end
end

function LuYinJiaDeChallengeMainView:onExit()
	LuYinJiaDeChallengeMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function LuYinJiaDeChallengeMainView:_onSetUI()
	self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)

	local skinId = self._actCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self._actCfg.skinId)
end

function LuYinJiaDeChallengeMainView:_onUpdate()
	self._info = LuYinJiaDeModel.instance:getInfo(self._activityId)

	self:_onSetUI()
end

function LuYinJiaDeChallengeMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function LuYinJiaDeChallengeMainView:_onClickBtnJump(jumpStr)
	if jumpStr == "Two" and not self:_isInChallengeTime() then
		local limitTimes = self._actCfg.challengeClosedTimeRange
		local arr = string.split(limitTimes, "-")

		FloatWordMgr.instance:show("排行榜开启时间为：" .. arr[2] .. "-" .. arr[1])

		return
	end

	local btnStr = self._actCfg["jumpStr" .. jumpStr]

	GotoMgr.gotoByString(btnStr)
end

function LuYinJiaDeChallengeMainView:_onClickBtnEnter()
	local isInTime = self:_isInChallengeTime()
	local limitTimes = self._actCfg.challengeClosedTimeRange
	local arr = string.split(limitTimes, "-")

	if not isInTime then
		FloatWordMgr.instance:show("挑战开启时间为：" .. arr[2] .. "-" .. arr[1])

		return
	end

	UIStateManager.instance:push(ViewName.LuYinJiaDeChallengeLevelView, self._activityId)
end

function LuYinJiaDeChallengeMainView:_getRaceId()
	return PetSkinConfig.instance:getPetSkinRaceId(self._actCfg.skinId)
end

function LuYinJiaDeChallengeMainView:_onBtnSkillClg()
	local raceId = self:_getRaceId()
	local skinId = self._actCfg.skinId

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function LuYinJiaDeChallengeMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function LuYinJiaDeChallengeMainView:_isInChallengeTime()
	local challengeClosedTimeRange = self._actCfg.challengeClosedTimeRange
	local arr = string.split(challengeClosedTimeRange, "-")

	return not GameUtil.checkIsInTimePeriod(arr[1], arr[2], true)
end

return LuYinJiaDeChallengeMainView
