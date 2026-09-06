-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingFmtLeftView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingFmtLeftView", package.seeall)

local LightKingFmtLeftView = class("LightKingFmtLeftView", FormationLeftView)

function LightKingFmtLeftView:onExit()
	LightKingFmtLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.LightKingGetFormRes, self._onGetFormRes, self)

	self._supportPet = nil

	local formationMo = self:_getCurFormation()

	formationMo:setExtGetPetFunc(nil)
end

function LightKingFmtLeftView:buildUI()
	LightKingFmtLeftView.super.buildUI(self)
end

function LightKingFmtLeftView:onEnter()
	self._challengeType = LightKingModel.instance:getCurChallengeType()
	self._stageCfg = LightKingModel.instance:getCurStageCfg()

	local planId = self._stageCfg.supportPlanId

	self._supportCfg = LightKingConfig.instance:getSupportCfg(planId)

	self:_getCurFormation():ResetPosition()
	print("planId = " .. tostring(planId) .. "stage Id = " .. self._stageCfg.stage .. "_supportCfg == nil = " .. tostring(self._supportCfg == nil))
	LightKingFmtLeftView.super.onEnter(self)
	self:_isSkipFirstHeroSkillEffect(true)
	GlobalDispatcher:addListener(GlobalNotify.LightKingGetFormRes, self._onGetFormRes, self)
	LightKingController.instance:sendGetFormReq(self._challengeType, self._stageCfg.stage)
	self._Btn_Formation.gameObject:SetActive(false)
	self:_setActiveBtnFormationUse(false)
end

function LightKingFmtLeftView:_saveCurrFmt()
	return
end

function LightKingFmtLeftView:_initSelfFormation()
	return
end

function LightKingFmtLeftView:_onGetFormRes(simpleForm)
	local function func(id)
		return self:_getPet(id)
	end

	local formationMo = self:_getCurFormation()

	formationMo:setExtGetPetFunc(func)
	formationMo:SetData(simpleForm)

	local pos = simpleForm.pos

	if self._challengeType == GameEnum.LightKingChallengeType.SHENGGUANG then
		local fixedPos = {}

		for _, v in pairs(self._supportCfg) do
			local posId = v.posId

			pos[posId] = v.creepsId

			table.insert(fixedPos, posId)
		end

		self:_setFixedPos(fixedPos)
	end

	self:_isShowNewActBonds(false)
	self:_setPositionForce(pos, true)
	self:_isShowNewActBonds(true)
end

function LightKingFmtLeftView:_getItemSeatCls()
	return LightKingItemSeat
end

function LightKingFmtLeftView:_getPet(petId)
	return LightKingModel.instance:getPetMo(petId)
end

function LightKingFmtLeftView:_OnClickSeat(go, eventData)
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

	print("click petId = " .. petId)

	local bagPetMo = BagPetsController.instance:getPet(petId)

	if not bagPetMo then
		petMo = clone(petMo)
		petMo.hideZdl = true
	end

	CommonTipsMgr.instance:showPetTips(petMo)
end

return LightKingFmtLeftView
