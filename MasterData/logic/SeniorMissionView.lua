-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/SeniorMissionView.lua

module("logic.extensions.mission.view.SeniorMissionView", package.seeall)

local SeniorMissionView = class("SeniorMissionView", MissionView)

function SeniorMissionView:bindEvents()
	SeniorMissionView.super.bindEvents(self)
	self._btnAllForms:AddClickListener(self._onClickAllForms, self)
end

function SeniorMissionView:unbindEvents()
	SeniorMissionView.super.unbindEvents(self)
	self._btnAllForms:RemoveClickListener()
end

function SeniorMissionView:buildUI()
	SeniorMissionView.super.buildUI(self)

	self._titleBg = self:getGo("Titlebg")
	self._otherPlayer = self:getGo("otherPlayer")
	self._txtUserName = goutil.findChildTextComponent(self._otherPlayer, "txtUserName")
	self._pointHead = goutil.findChild(self._otherPlayer, "pointHead")
	self._txtRanking = goutil.findChildTextComponent(self._otherPlayer, "txtRanking")
	self._btnAllForms = self:getBtn("btnAllForms")

	goutil.setActive(self._btnAllForms.gameObject, true)

	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
end

function SeniorMissionView:onExit()
	SeniorMissionView.super.onExit(self)
	FormationNewModel.instance:RecoverFmtFromServerData()
	removetimer(self._onTickRefreshTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.CurFormTabChange, self._onCurFormTabChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
	SeniorArenaController.instance:setCanClickNext(false)
end

function SeniorMissionView:onEnter()
	self:onEnterInherit()
	self:_updateOtherPlayer()
	self:_onCurFormTabChange()
	SeniorArenaController.instance:setCanClickNext(true)
	GlobalDispatcher:addListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.CurFormTabChange, self._onCurFormTabChange, self)
	self:_onTickRefreshTime()
	settimer(0.2, self._onTickRefreshTime, self, true)
	goutil.setActive(self._txtLeftTime.gameObject, true)

	local ruleDesc = "击败对方全体精灵"

	self:_setDescStr(nil, nil, ruleDesc)
end

function SeniorMissionView:_onTickRefreshTime()
	local leftTime = math.ceil(SeniorArenaModel.instance:getNextRefreshTime() - ServerTime.now())

	leftTime = math.max(leftTime, 0)

	if leftTime > 0 then
		local min = math.floor(leftTime / 60)
		local sec = leftTime - min * 60

		self._txtLeftTime.text = string.format("倒计时：%02d：%02d", min, sec)
	else
		FloatWordMgr.instance:show("挑战目标已过期")
		UIStateManager.instance:popByName(ViewName.SeniorAllFormsView)
		self:close()
	end
end

function SeniorMissionView:_onCurFormTabChange()
	local curTab = SeniorArenaController.instance:getCurFormTab()

	self._startBtn.gameObject:SetActive(curTab == 3)
	MissionModel.instance:setForceResetOneKey(true)
end

function SeniorMissionView:_updateOtherPlayer()
	goutil.setActive(self._btnRule.gameObject, false)
	goutil.setActive(self._titleBg, false)
	goutil.setActive(self._otherPlayer, false)

	local playerInfo = SeniorArenaController.instance:getCurOpponentInfo()

	if playerInfo then
		self._txtUserName.text = playerInfo.headInfo.userName
		self._txtRanking.text = "排名：" .. playerInfo.rank

		HeadItemController.instance:setHeadCellByInfo(self._pointHead, playerInfo.headInfo)
	end
end

function SeniorMissionView:_onClickClose()
	self:_saveAndReqSetForm()
	SeniorMissionView.super._onClickClose(self)
end

function SeniorMissionView:_onClickAllForms()
	SeniorArenaController.instance:openAllFormsView()
end

function SeniorMissionView:_onClickOneKey()
	SeniorArenaController.instance:setCanClickNext(false)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), function(petMo)
		if SeniorArenaController.instance:isInOtherTab(petMo.petId) then
			return false
		else
			return true
		end
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function SeniorMissionView:onAllPetSetFinish()
	SeniorArenaController.instance:setCanClickNext(true)
end

function SeniorMissionView:_saveFormationEx()
	return false
end

function SeniorMissionView:_saveAndReqSetForm(handler, handlerTarget)
	SeniorArenaController.instance:reqSaveMyForm(true, handler, handlerTarget)
end

function SeniorMissionView:_onClickStart()
	if EscortModel.instance:IsPickupEscort() and self._viewPresentor.viewName ~= ViewName.EscortMission then
		FloatWordMgr.instance:show("护送期间不能进行其他战斗!")

		return
	end

	if self._extParams and self._extParams.battleConditionId then
		local id = checknumber(self._extParams.battleConditionId)
		local condition = EnterBattleCondition.New()

		condition:init(id)

		if not condition:isCanPass() then
			return
		end
	end

	local totalPetNumsInBag = BagModel.instance:diffRacePetCount()
	local maxPetNumInMission = MissionModel.instance:getMaxPetNum()
	local tipTab = ""
	local firstIdx = -1

	for i = 1, 3 do
		local redState = SeniorArenaController.instance:getCacheTabRedPointState(i)

		if redState == 1 then
			TipsFacade.instance:openTipWindow("提示", "空阵不能进行挑战，请返回布阵", function()
				GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab, i, true)
			end, "去布阵")

			return
		elseif redState == 2 then
			local str = i .. "号阵型"

			tipTab = string.nilorempty(tipTab) and tipTab .. str or tipTab .. "、" .. str

			if firstIdx < 0 then
				firstIdx = i
			end
		end
	end

	if firstIdx < 0 then
		self:_startClg()
	else
		local text = string.format("当前<color=#d56d08>%s</color>未上满%s只精灵，是否进入战斗？", tipTab, maxPetNumInMission)

		TipsFacade.instance:openPopupWindow("提示", text, function()
			self:_startClg()
		end, function()
			GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab, firstIdx, true)
		end, "进入战斗", "去布阵")
	end
end

function SeniorMissionView:_enterBattle()
	print("senior enter battle")
	self:_saveAndReqSetForm(function()
		SeniorArenaController.instance:reqChallenge()
	end)
end

return SeniorMissionView
