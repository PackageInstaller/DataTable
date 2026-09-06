-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/ExpeditionMissionView.lua

module(..., package.seeall)

local ExpeditionMissionView = class("ExpeditionMissionView", MissionView)
local moveOffset = 15

function ExpeditionMissionView:buildUI()
	ExpeditionMissionView.super.buildUI(self)

	local Nego_Pet = self:getGo("Nego_Right/SrlC_Pet/Nego_Viewport/Nego_Pet")
	local posx, posy, _ = Framework.TransformUtil.GetLocalPos(Nego_Pet.transform, nil, nil, nil)

	posy = posy + moveOffset

	Framework.TransformUtil.SetLocalPos(Nego_Pet.transform, posx, posy, 0)

	local Nego_Viewport = self:getGo("Nego_Right/SrlC_Pet/Nego_Viewport").transform
	local sizeDeltaViewport = Nego_Viewport.sizeDelta

	sizeDeltaViewport.y = sizeDeltaViewport.y + moveOffset
	Nego_Viewport.sizeDelta = sizeDeltaViewport
end

function ExpeditionMissionView:onEnter()
	ExpeditionFmtModel.instance:checkPetsDead()
	self:onEnterInherit()

	self._gridData = self._viewPresentor._openParam[1]

	self:_setMaskBlock(false)

	self._fmtChanged = false
	self._loader, self._lastCallBack, self._mdlObj = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._mdlObj)

	self._videoButton.gameObject:SetActive(false)
	self:_setMissionCfgInfo()
	self:_onSpClassLoad()
	MissionModel.instance:setForceResetOneKey(true)
end

function ExpeditionMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	ExpeditionFastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey())
	MissionModel.instance:setForceResetOneKey(false)
end

function ExpeditionMissionView:_onClickClean()
	printInfo("_onClickClean")
	ExpeditionFastFormation.instance:clean()
end

function ExpeditionMissionView:_onClickStart()
	if not ExpeditionModel.instance:isInfoValid() then
		TipsFacade.instance:openTipWindowNoX(lang("tip"), lang("expedition_reset"), function()
			UIStateManager.instance:clear(true)
		end)

		return
	end

	local hasOneKey = GameUtil.GetActive(self._btnOneKey)

	if ExpeditionFmtModel.instance:isCurFormationEmpty() then
		if hasOneKey then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), lang("fight_unformation"), function()
				return
			end, function()
				self:_onClickOneKey()
			end, lang("fight_goto_fmt"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), lang("fight_unformation"), function()
				return
			end, nil, lang("fight_goto_fmt"))
		end

		return
	end

	if self:_checkFormationPosNumber(function()
		self:_startClg()
	end) then
		return
	end

	self:_startClg()
end

function ExpeditionMissionView:_checkFormationPosNumber(posLimitCallback)
	local formation = ExpeditionFmtModel.instance:getFormation()
	local numPos = formation:getCurExistPetNumber()
	local totalPos = 5
	local petsNum = ExpeditionFmtModel.instance:alivePetsCount()

	if totalPos <= petsNum and numPos < totalPos then
		local hasOneKey = GameUtil.GetActive(self._btnOneKey)

		if hasOneKey then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("fight_fmt_num"), tostring(totalPos)), posLimitCallback, function()
				self:_onClickOneKey()
			end, lang("确定"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("fight_fmt_num"), tostring(totalPos)), posLimitCallback)
		end

		return true
	end
end

function ExpeditionMissionView:_startClg()
	self:_setMaskBlock(true)
	GlobalDispatcher:addListener(GlobalNotify.FormationRefresh, self._startNow, self)
	ExpeditionFmtModel.instance:saveCurrFormation()
end

function ExpeditionMissionView:_setMissionCfgInfo()
	local titleStr = ""
	local levelStr = "失落遗迹"
	local ruleDesc = "击败敌方所有精灵即可获胜"

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_setTitleName()
end

function ExpeditionMissionView:onEnterFinished()
	ExpeditionMissionView.super.onEnterFinished(self)
end

function ExpeditionMissionView:_setBattleResultTxtTitle()
	ExpeditionMissionView.super._setBattleResultTxtTitle(self)
	BattleModel.instance:setBattleName(self:_getLevelStr())
end

function ExpeditionMissionView:_getSpClassCo()
	return nil
end

function ExpeditionMissionView:_enterBattle()
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.MainUI, true)

	if ExpeditionController.instance.canPlay then
		UIJumper.instance:pushOneStack(ViewName.ExpMap, true)
	end

	BattleFacade.instance:startExpedition()
	ExpeditionModel.instance:setRunBattleGridData(self._gridData)

	local evtParams = ExpeditionExtension_pb.PM_ExpeditionEventParam()

	ExpeditionAgent.instance:sendPM_ExpeditionDoGridEventReq(self._gridData.eventIndex, evtParams)
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Expedition)
end

return ExpeditionMissionView
