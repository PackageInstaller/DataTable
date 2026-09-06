-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mangtower/view/MangTower3v3MissionView.lua

module("logic.extensions.mangtower.view.MangTower3v3MissionView", package.seeall)

local MangTower3v3MissionView = class("MangTower3v3MissionView", MissionView)

function MangTower3v3MissionView:bindEvents()
	MangTower3v3MissionView.super.bindEvents(self)
end

function MangTower3v3MissionView:unbindEvents()
	MangTower3v3MissionView.super.unbindEvents(self)
end

function MangTower3v3MissionView:buildUI()
	MangTower3v3MissionView.super.buildUI(self)
end

function MangTower3v3MissionView:onExit()
	MangTower3v3MissionView.super.onExit(self)
	FormationNewModel.instance:RecoverFmtFromServerData()
	removetimer(self._onTickRefreshTime, self)
	GlobalDispatcher:removeListener(GlobalNotify.CurFormTabChange, self._onCurFormTabChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
end

function MangTower3v3MissionView:onEnter()
	self:onEnterInherit()
	self:_onCurFormTabChange()
	GlobalDispatcher:addListener(GlobalNotify.FormationPet_POS_FINISH, self.onAllPetSetFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.CurFormTabChange, self._onCurFormTabChange, self)

	local ruleDesc = "击败对方全体精灵"
	local openParams = self._viewPresentor:getFirstParam()
	local titleStr = openParams.name

	self:_setDescStr(titleStr, nil, ruleDesc)
end

function MangTower3v3MissionView:_onCurFormTabChange()
	local curTab = MangTowerModel.instance:getSelectFmtTab()

	self._startBtn.gameObject:SetActive(curTab == 3)
	MissionModel.instance:setForceResetOneKey(true)
end

function MangTower3v3MissionView:_onClickClose()
	self:_saveFormationEx()
	MangTower3v3MissionView.super._onClickClose(self)
end

function MangTower3v3MissionView:_onClickOneKey()
	MangTowerController.instance:setCanClickNext(false)
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	MangTower3v3FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), function(petMo)
		if MangTowerController.instance:isInOtherTab(petMo.raceId) then
			return false
		else
			return true
		end
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function MangTower3v3MissionView:_onClickClean()
	MangTower3v3FastFormation.instance:clean()
end

function MangTower3v3MissionView:onAllPetSetFinish()
	MangTowerController.instance:setCanClickNext(true)
end

function MangTower3v3MissionView:_onClickStart()
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
	local notEnoughIndex = -1

	for i = 1, 3 do
		local fmt = MangTowerModel.instance:getFmt(MangTowerModel.TOWER_TYPE_3V3, i)
		local redState = MangTowerController.instance:checkEmptyFmt(fmt)

		if redState == 0 then
			TipsFacade.instance:openTipWindow("提示", "空阵不能进行挑战，请返回布阵", function()
				GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab, i, true)
			end, "去布阵")

			return
		elseif redState == 1 then
			local str = i .. "号阵型"

			tipTab = string.nilorempty(tipTab) and tipTab .. str or tipTab .. "、" .. str

			if notEnoughIndex < 0 then
				notEnoughIndex = i
			end
		end
	end

	if notEnoughIndex < 0 then
		self:_startClg()
	else
		local text = string.format("当前<color=#d56d08>%s</color>未上满%s只精灵，是否进入战斗？", tipTab, maxPetNumInMission)

		TipsFacade.instance:openPopupWindow("提示", text, function()
			self:_startClg()
		end, function()
			GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab, notEnoughIndex, true)
		end, "进入战斗", "去布阵")
	end
end

function MangTower3v3MissionView:_enterBattle()
	print("MangTower enter battle")
	self:_setMaskBlock(true)

	local openParams = self._viewPresentor:getFirstParam()
	local params = {}

	params.buffIdList = MangTowerConfig.instance:getBuffCfg(openParams.buffPlanId)

	function params.selectCallBack(buffId)
		MangTowerController.instance:sendChallenge(buffId, MangTowerModel.TOWER_TYPE_3V3)
	end

	UIStateManager.instance:open(ViewName.SelectBuffView, params)
end

function MangTower3v3MissionView:_saveFormationEx()
	return MangTowerController.instance:saveCur3v3Formation()
end

return MangTower3v3MissionView
