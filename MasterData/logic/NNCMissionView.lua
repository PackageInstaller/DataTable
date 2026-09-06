-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianchall/view/NNCMissionView.lua

module("logic.extensions.niannianchall.view.lightking.NNCMissionView", package.seeall)

local NNCMissionView = class("NNCMissionView", MissionView)

function NNCMissionView:buildUI()
	NNCMissionView.super.buildUI(self)
end

function NNCMissionView:onExit()
	NNCMissionView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NianNianChallChallRes, self._onFightRes, self)
end

function NNCMissionView:onEnter()
	self:onEnterInherit()
	self._videoButton.gameObject:SetActive(false)
	MissionModel.instance:setForceResetOneKey(true)

	local stageId = NianNianChallModel.instance:getStageId()

	self._stageCfg = NianNianChallConfig.instance:getStageCfg(stageId + 1)

	self:_setDescStr(self._stageCfg.name, nil, self._stageCfg.WinDesc)
	self:_setTitleName()
	self:setRuleDesc()

	local missionDesc = self._stageCfg.missionDesc

	if not string.nilorempty(missionDesc) then
		goutil.setActive(self._topDesc.gameObject, true)
		goutil.setActive(self._txtValidatorDesc.gameObject, true)
		goutil.setActive(self._imgYes, false)
		goutil.setActive(self._imgNo, false)

		self._txtValidatorDesc.text = missionDesc
	end
end

function NNCMissionView:_saveFormationEx()
	return false
end

function NNCMissionView:_maxPetNum()
	return 6
end

function NNCMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)

	local key = MissionModel.instance:getForceResetOneKey()

	NNCFastFormation.instance:setFormation(key)
	MissionModel.instance:setForceResetOneKey(false)
end

function NNCMissionView:_onClickClean()
	NNCFastFormation.instance:clean()
end

function NNCMissionView:_isCurFormationEmpty()
	local numPos = FormationFacade.instance:curFormationPetNum(NianNianChallModel.instance:getFormation())

	return numPos <= (NianNianChallModel.instance:getSupportPet() ~= nil and 1 or 0)
end

function NNCMissionView:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	local numPos = FormationFacade.instance:curFormationPetNum(NianNianChallModel.instance:getFormation())
	local totalPos = MissionModel.instance:getMaxPetNum()
	local petsNum = NianNianChallModel.instance:getDiffRacePetNum()
	local showNum = -1
	local boo = false

	if totalPos <= petsNum and numPos < totalPos then
		boo = true
		showNum = totalPos
	elseif petsNum < totalPos and petsNum > 0 and numPos < petsNum then
		boo = true
		showNum = petsNum
	end

	if showNum > 0 then
		if hasOneKey then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback, onekeyCallBack, lang("确定"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindow(lang("tip"), string.format(lang("fight_fmt_num"), tostring(showNum)), posLimitCallback)
		end
	end

	return boo
end

function NNCMissionView:_enterBattle()
	NianNianChallController.instance:sendChall()
	GlobalDispatcher:addListener(GlobalNotify.NianNianChallChallRes, self._onFightRes, self)
end

function NNCMissionView:_sendFightReq()
	return
end

function NNCMissionView:_onError()
	self:_setMaskBlock(false)
end

function NNCMissionView:_onFightRes()
	GlobalDispatcher:removeListener(GlobalNotify.NianNianChallChallRes, self._onFightRes, self)
	UIJumper.instance:pushOneStack(ViewName.NianNianChallMainView, true)
	UIJumper.instance:pushOneStack(ViewName.NianNianChallView, true)
end

return NNCMissionView
