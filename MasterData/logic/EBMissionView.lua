-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/view/EBMissionView.lua

module("logic.extensions.mission.view.EBMissionView", package.seeall)

local EBMissionView = class("EBMissionView", MissionView)

function EBMissionView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.SetInfiniteFightFormRes, self._onSetInfiniteFightFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.EndlessBuffSelected, self._onEndlessBuffSelected, self)

	local waveId = EndlessBattleModel.instance:getCurWaveId()
	local stageCfgs = EndlessBattleConfig.instance:getStageCfgsByWaveId(waveId)

	self._curWaveId = waveId

	self:onEnterInherit()

	local titleStr = string.format("无尽试炼第%d波第%d场次", waveId, 1)
	local levelStr = ""
	local ruleDesc = lang("endless_battle_tip")

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	EndlessBattleController.instance:getInfiniteFightFormReq()
	self._videoButton.gameObject:SetActive(true)

	goutil.findChildTextComponent(self._videoButton.gameObject, "Text").text = "通关阵型"

	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return EndlessBattleModel.instance:getAllShowPetList()
	end)
end

function EBMissionView:onExit()
	EBMissionView.super.onExit(self)
	MissionModel.instance:setMaxPetNum(5)
	GlobalDispatcher:removeListener(GlobalNotify.SetInfiniteFightFormRes, self._onSetInfiniteFightFormRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.EndlessBuffSelected, self._onEndlessBuffSelected, self)
	FormationNewModel.instance:RecoverFmtFromServerData()

	self._videoFlag = false

	self:_setMaskBlock(false)
end

function EBMissionView:_onClickClose()
	self:_setSimpleForm()
	self:_saveIndependenceFormation()
	EBMissionView.super._onClickClose(self)
end

function EBMissionView:_onClickVideo()
	local ranKey = BattleRecordRankController.instance:getEndlessRankKey(self._curWaveId)

	print("ranKey = " .. ranKey)
	self:_setSimpleForm()
	self:_saveIndependenceFormation()

	self._videoFlag = true

	BattleSettlementModel.instance:onReset()
	BattleRecordRankController.instance:enterView2(ranKey)
end

function EBMissionView:_maxPetNum()
	return 9
end

function EBMissionView:_saveFormationEx()
	return false
end

function EBMissionView:_setSimpleForm()
	local formInfo = EndlessBattleModel.instance:getOriginalCurFormation()

	self._simpleForm = formInfo:createFormPb()
end

function EBMissionView:_saveIndependenceFormation()
	if self._simpleForm then
		PetHireController.instance:sendSetHrieFormByFormId(PetHireModel.ID_TYPE_ENDLESS)
		EndlessBattleController.instance:setInfiniteFightFormReq(self._simpleForm)
	end
end

function EBMissionView:_enterBattle()
	self:_setMaskBlock(true)
	UIStateManager.instance:open(ViewName.EndlessBuffList)
end

function EBMissionView:_onEndlessBuffSelected()
	BattleSettlementModel.instance:setType(BattleSettlementModel.Enum.Endless, nil)
	self:_setSimpleForm()
	self:_saveIndependenceFormation()
end

function EBMissionView:_setBtnOneKeyActive()
	return false
end

function EBMissionView:_onSetInfiniteFightFormRes()
	if not self._videoFlag then
		UIJumper.instance:pushOneStack(ViewName.EndlessBattle, true)
		EndlessBattleController.instance:startBattle()
	end
end

function EBMissionView:checkFormationEmptyAndPosNumLimit(callback, hasOneKey, onekeyCallBack)
	local formation = self:_getCurFormation()

	return FormationFacade.instance:checkFormationEmptyAndPosNumLimitByFmo(formation, callback, hasOneKey, onekeyCallBack)
end

function EBMissionView:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack)
	local numPos = FormationFacade.instance:curFormationPetNum(self:_getCurFormation(), true)
	local curFormId = FormationModel.instance:getCurFormId()
	local totalPos = MissionModel.instance:getMaxPetNum()
	local petsNum = BagModel.instance:diffRacePetCount()
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
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("上阵的精灵未满%s只（上阵精灵越多，战斗力越强），是否继续挑战？"), tostring(showNum)), posLimitCallback, onekeyCallBack, lang("确定"), lang("一键布阵"))
		else
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), string.format(lang("上阵的精灵未满%s只（上阵精灵越多，战斗力越强），是否继续挑战？"), tostring(showNum)), posLimitCallback)
		end
	end

	return boo
end

function EBMissionView:_getCurFormation()
	return EndlessBattleModel.instance:_getCurFormation()
end

function EBMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), nil, function(posList, petPool)
		local needPets = FastFormation.instance.needPets
		local count = 9 - table.nums(petPool)
		local tem = {}

		for i, petMo in ipairs(needPets) do
			local isHas = false

			for k, v in pairs(petPool) do
				if v == petMo then
					isHas = true

					break
				end
			end

			if isHas == false then
				table.insert(tem, petMo)

				count = count - 1

				if count <= 0 then
					break
				end
			end
		end

		for i = 1, 9 do
			if table.indexof(posList, i) == false then
				table.insert(posList, i)
			end

			if petPool[i] == nil and #tem > 0 then
				petPool[i] = table.remove(tem, 1)
			end
		end

		return posList, petPool
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

return EBMissionView
