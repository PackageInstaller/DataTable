-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fbbchallenge/view/mission/FBBFmtLeftView.lua

module("logic.extensions.fbbchallenge.view.mission.FBBFmtLeftView", package.seeall)

local FBBFmtLeftView = class("FBBFmtLeftView", FormationLeftView)

function FBBFmtLeftView:onExit()
	FBBFmtLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(FbbchallengeController.PM_FengBaoBaoChallengeGetFormRes, self._onGetFormRes, self)

	self._supportPet = nil

	local formationMo = self:_getCurFormation()

	formationMo:setExtGetPetFunc(nil)
end

function FBBFmtLeftView:buildUI()
	FBBFmtLeftView.super.buildUI(self)
end

function FBBFmtLeftView:onEnter()
	local planId = FbbchallengeModel.instance:getCurrSupportPlanId()

	self._supportCfg = FbbchallengeConfig.instance:getSupportCfg(planId) or {}

	self:_getCurFormation():ResetPosition()
	FBBFmtLeftView.super.onEnter(self)
	self:_isSkipFirstHeroSkillEffect(true)
	self._Btn_Formation.gameObject:SetActive(false)
	self:_setActiveBtnFormationUse(false)
	GlobalDispatcher:addListener(FbbchallengeController.PM_FengBaoBaoChallengeGetFormRes, self._onGetFormRes, self)
	FengBaoBaoChallengeAgent.instance:sendPM_FengBaoBaoChallengeGetFormReq()
end

function FBBFmtLeftView:_saveCurrFmt()
	return
end

function FBBFmtLeftView:_initSelfFormation()
	return
end

function FBBFmtLeftView:_onGetFormRes(status, msg)
	if status ~= 0 then
		return
	end

	local simpleForm = msg.simpleForm

	local function func(id)
		return self:_getPet(id)
	end

	local formationMo = self:_getCurFormation()

	formationMo:setExtGetPetFunc(func)

	local pos = simpleForm.pos
	local fixedPos = {}

	for _, v in pairs(self._supportCfg) do
		if v.isFixedPos then
			local posId = v.posId

			pos[posId] = v.creepsId

			table.insert(fixedPos, posId)
		end
	end

	self:_setFixedPos(fixedPos)
	self:_isShowNewActBonds(false)

	if simpleForm.extParams and simpleForm.extParams.heroSkillId then
		self:_getCurFormation():SetHeroSkillId(simpleForm.extParams.heroSkillId)
	end

	self:_setPositionForce(pos, true)
	self:_isShowNewActBonds(true)
end

function FBBFmtLeftView:_getItemSeatCls()
	return FBBItemSeat
end

function FBBFmtLeftView:_getPet(petId)
	return FbbchallengeModel.instance:getPetMo(petId)
end

function FBBFmtLeftView:_OnClickSeat(go, eventData)
	if self._dragSeat then
		self._dragSeat:ShowPet()
	end

	local ItemSeatCls = self:_getItemSeatCls()
	local itemSeat = ItemSeatCls.Get(go)

	if not itemSeat or not itemSeat:IsOpen() then
		return
	end

	if not itemSeat:isHasPet() then
		printInfo("当前位置没有精灵")

		return
	end

	local petId = itemSeat:GetData()
	local petMo = self:_getPet(petId)
	local bagPetMo = BagPetsController.instance:getPet(petId)

	if not bagPetMo then
		petMo = clone(petMo)
		petMo.hideZdl = true
	end

	CommonTipsMgr.instance:showPetTips(petMo)
end

function FBBFmtLeftView:_getCurFormation()
	return FbbchallengeModel.instance:getCurFormation()
end

return FBBFmtLeftView
