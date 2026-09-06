-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originxiuer/view/OriginXiuErFmtView.lua

module("logic.extensions.originxiuer.view.OriginXiuErFmtView", package.seeall)

local OriginXiuErFmtView = class("OriginXiuErFmtView", ViewComponent)

function OriginXiuErFmtView:ctor()
	OriginXiuErFmtView.super.ctor(self)
end

function OriginXiuErFmtView:unbindEvents()
	OriginXiuErFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnExplain)
end

function OriginXiuErFmtView:bindEvents()
	OriginXiuErFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnExplain, self._onClickBtnExplain, self)
end

function OriginXiuErFmtView:buildUI()
	OriginXiuErFmtView.super.buildUI(self)

	self._btnExplain = self:getGo("btnExplain")
	self._leftImgList = {}
	self._rightImgList = {}

	for i = 1, 9 do
		local leftImg = self:getGo("left/img" .. i)
		local rightImg = self:getGo("right/img" .. i)

		table.insert(self._leftImgList, leftImg)
		table.insert(self._rightImgList, rightImg)
	end
end

function OriginXiuErFmtView:onExit()
	OriginXiuErFmtView.super.onExit(self)
end

function OriginXiuErFmtView:onEnter()
	OriginXiuErFmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.FormationChangeFinish, self._onUpdate, self)

	self._fmtMo = self:getFirstParam()
	self._formationMo = self._fmtMo:getCurFormation()
	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()
	self._curStageCfg = OriginXiuErConfig.instance:getStageCfgById(self._activityId, self._stageId)
	self._creepsMasterId = self._curStageCfg.creepsMasterId
	self._creepsCfg = OriginXiuErConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._info = OriginXiuErModel.instance:getInfo(self._activityId)

	local key = "OriginXiuErFmtView"
	local notFirstOpen = GameUtil.getUserData(key)

	if not notFirstOpen then
		GameUtil.saveUserData(key, true)
		UIStateManager.instance:push(ViewName.OriginXiuErExplainView, self._activityId)
	end

	self:_initUI()
	self:_onUpdate()
end

function OriginXiuErFmtView:_initUI()
	local buffPosition = self._curStageCfg.buffPosition

	for pos, img in ipairs(self._rightImgList) do
		local hasBuff = buffPosition[pos] > 0

		if hasBuff then
			img:SetActive(true)
		else
			img:SetActive(false)
		end
	end
end

function OriginXiuErFmtView:_onUpdate()
	local positions = self._formationMo:GetPositions()
	local maxHealth = 0
	local curMaxHealthPetPos = 0
	local maxAttack = 0
	local curMaxAttackPetPos = 0

	for i = 9, 1, -1 do
		local petId = positions[i]
		local img = self._leftImgList[i]

		if petId > 0 then
			local petMo = BagPetsController.instance:getPet(petId)
			local health = petMo._maxHp
			local attack = petMo._attack

			if maxHealth <= health then
				maxHealth = health
				curMaxHealthPetPos = i
			end

			if maxAttack <= attack then
				maxAttack = attack
				curMaxAttackPetPos = i
			end
		end

		img:SetActive(false)
	end

	if curMaxHealthPetPos == curMaxAttackPetPos and curMaxHealthPetPos > 0 then
		local img = self._leftImgList[curMaxHealthPetPos]
		local imgState1 = goutil.findChild(img, "imgState1")
		local imgState2 = goutil.findChild(img, "imgState2")
		local imgStateComp1 = imgState1:GetComponent(ComponentType.UIImageSpriteChange)
		local imgStateComp2 = imgState2:GetComponent(ComponentType.UIImageSpriteChange)

		img:SetActive(true)
		imgState1:SetActive(true)
		imgState2:SetActive(true)
		imgStateComp1:SetState(OriginXiuErController.XIU_ER_PET_STATE.SUO_LIAN)
		imgStateComp2:SetState(OriginXiuErController.XIU_ER_PET_STATE.LIAN_DAO)
	else
		if curMaxHealthPetPos > 0 then
			local img = self._leftImgList[curMaxHealthPetPos]
			local imgState1 = goutil.findChild(img, "imgState1")
			local imgState2 = goutil.findChild(img, "imgState2")
			local imgStateComp1 = imgState1:GetComponent(ComponentType.UIImageSpriteChange)
			local imgStateComp2 = imgState2:GetComponent(ComponentType.UIImageSpriteChange)

			img:SetActive(true)
			imgState1:SetActive(true)
			imgState2:SetActive(false)
			imgStateComp1:SetState(OriginXiuErController.XIU_ER_PET_STATE.SUO_LIAN)
			imgStateComp2:SetState(OriginXiuErController.XIU_ER_PET_STATE.LIAN_DAO)
		end

		if curMaxAttackPetPos > 0 then
			local img = self._leftImgList[curMaxAttackPetPos]
			local imgState1 = goutil.findChild(img, "imgState1")
			local imgState2 = goutil.findChild(img, "imgState2")
			local imgStateComp1 = imgState1:GetComponent(ComponentType.UIImageSpriteChange)
			local imgStateComp2 = imgState2:GetComponent(ComponentType.UIImageSpriteChange)

			img:SetActive(true)
			imgState1:SetActive(false)
			imgState2:SetActive(true)
			imgStateComp1:SetState(OriginXiuErController.XIU_ER_PET_STATE.SUO_LIAN)
			imgStateComp2:SetState(OriginXiuErController.XIU_ER_PET_STATE.LIAN_DAO)
		end
	end
end

function OriginXiuErFmtView:_onClickBtnExplain()
	UIStateManager.instance:push(ViewName.OriginXiuErExplainView, self._activityId)
end

return OriginXiuErFmtView
