-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/view/SummonMasterHopeClgMainView.lua

module("logic.extensions.summonmasterhopeclg.view.SummonMasterHopeClgMainView", package.seeall)

local SummonMasterHopeClgMainView = class("SummonMasterHopeClgMainView", ViewComponent)

function SummonMasterHopeClgMainView:ctor()
	SummonMasterHopeClgMainView.super.ctor(self)
end

function SummonMasterHopeClgMainView:buildUI()
	SummonMasterHopeClgMainView.super.buildUI(self)

	self._btnClg = goutil.findChild(self.mainGO, "btnClg/btn")
	self._time = self:getGo("btnClg/time")
	self._btnClgTime = self:getTxt("btnClg/time/txtTime")
	self._btnJump1 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump1")
	self._btnJump2 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump2")
	self._btnJump3 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump3")
	self._btnJump4 = goutil.findChild(self.mainGO, "jumpBtnCol/btnJump4")
	self._con = goutil.findChild(self.mainGO, "con")
	self._btnSkill = goutil.findChild(self.mainGO, "petInfo/btnSkill")
	self._btnIntroduce = goutil.findChild(self.mainGO, "petInfo/btnIntroduce")
	self._txtPetNameInInfo = goutil.findChildTextComponent(self.mainGO, "petInfo/txtName")
	self._pointRare = goutil.findChild(self.mainGO, "petInfo/pointRare")
	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self.mainGO, "leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
end

function SummonMasterHopeClgMainView:bindEvents()
	SummonMasterHopeClgMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg1, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onJumpBtnClg, self, "jumpStrOne"))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onJumpBtnClg, self, "jumpStrTwo"))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onJumpBtnClg, self, "jumpStrThree"))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onRankBtnClg, self))
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnSkill, self._onBtnSkillClg, self)
	GameUtil.addClickHandler(self._btnIntroduce, self._onBtnIntroduceClg, self)
end

function SummonMasterHopeClgMainView:unbindEvents()
	SummonMasterHopeClgMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnSkill)
	GameUtil.rmClickHandler(self._btnIntroduce)
end

function SummonMasterHopeClgMainView:onEnter()
	SummonMasterHopeClgMainView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = SummonMasterHopeClgController.instance:getActivityId()
	end

	self._activityType = SummonMasterHopeClgController.instance:getActivityType()

	local isInTime = SummonMasterHopeClgController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._actStartTime, self._actEndTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._activityType, self._activityId)

	self:_onSetUI()
end

function SummonMasterHopeClgMainView:onExit()
	SummonMasterHopeClgMainView.super.onExit(self)
	MaterialMgr.resetAll(self._pointRare)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end
end

function SummonMasterHopeClgMainView:_onSetUI()
	if self._txtOpenTime and not self:_isResidentAct() then
		self._txtOpenTime.text = GameUtil.getActTimeDesc(self._activityType, self._activityId)
	end

	if self:_isResidentAct() then
		self._txtOpenTime.text = "常驻"
	end

	local skinId = self:_getSkinId()

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	local skinId = self:_getSkinId()

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(self:_getSkinId())

	local challengeData = SummonMasterHopeClgConfig.instance:getSMHClgData(self._activityId)

	if not challengeData.challengeClosedTimeRange then
		local challengeClosedTimeRange = ""
		local timeArr = {
			"",
			""
		}

		if challengeClosedTimeRange ~= "" then
			local arr = string.split(challengeClosedTimeRange, "-")

			timeArr[1] = arr[1]
			timeArr[2] = arr[2]
		end

		self._canChallengeTimeStr = timeArr[2] .. "-" .. timeArr[1]
		self._btnClgTime.text = "可挑战时间\n" .. self._canChallengeTimeStr
	end
end

function SummonMasterHopeClgMainView:_onUpdate()
	return
end

function SummonMasterHopeClgMainView:_onClickBtnClg1()
	if not self:_isInChallengeTime(self._activityId) then
		self._canChallengeTimeStr = self._canChallengeTimeStr or ""

		FloatWordMgr.instance:show("挑战开启时间：" .. self._canChallengeTimeStr)

		return
	end

	UIStateManager.instance:push(ViewName.SummonMasterHopeClgChallengeView, self._activityId)
end

function SummonMasterHopeClgMainView:_onJumpBtnClg(key)
	local btnStr = SummonMasterHopeClgConfig.instance:getCommonValue(self._activityId, key)

	GotoMgr.gotoByString(btnStr)
end

function SummonMasterHopeClgMainView:_onRankBtnClg()
	if not self:_isInChallengeTime(self._activityId) then
		self._canChallengeTimeStr = self._canChallengeTimeStr or ""

		FloatWordMgr.instance:show("挑战开启时间：" .. self._canChallengeTimeStr)

		return
	end

	UIStateManager.instance:push(ViewName.SummonMasterHopeClgRankTabFrameView, self._activityId)
end

function SummonMasterHopeClgMainView:_onBtnSkillClg()
	local raceId = self:_getRaceId()
	local skinId = self:_getSkinId()

	if raceId > 0 and skinId > 0 then
		PetbookController.instance:previewBattle(raceId, skinId)
	elseif raceId > 0 then
		PetbookController.instance:previewBattle(raceId)
	end
end

function SummonMasterHopeClgMainView:_onBtnIntroduceClg()
	PetbookController.instance:openPetinfoView(self:_getRaceId())
end

function SummonMasterHopeClgMainView:_onClickBtnTip()
	local key = SummonMasterHopeClgConfig.instance:getCommonValue(self._activityId, "ruleKeyMain")

	TipsFacade.instance:openRulesView(key)
end

function SummonMasterHopeClgMainView:_getRaceId()
	return SummonMasterHopeClgController.instance:getRaceId(self._activityId)
end

function SummonMasterHopeClgMainView:_getSkinId()
	return SummonMasterHopeClgController.instance:getSkinId(self._activityId)
end

function SummonMasterHopeClgMainView:_isInChallengeTime(activityId)
	local challengeData = SummonMasterHopeClgConfig.instance:getSMHClgData(activityId)

	if not challengeData.challengeClosedTimeRange then
		local arr = string.split(challengeData.challengeClosedTimeRange, "-") or {}

		return not GameUtil.checkIsInTimePeriod(arr[1], arr[2], true)
	end
end

function SummonMasterHopeClgMainView:_isResidentAct()
	return GameUtil.getDaysByTimestamp(self._actStartTime, self._actEndTime) > 1095
end

return SummonMasterHopeClgMainView
