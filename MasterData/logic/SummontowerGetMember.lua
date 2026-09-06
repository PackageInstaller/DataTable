-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerGetMember.lua

module("logic.extensions.summontower.view.SummontowerGetMember", package.seeall)

local SummontowerGetMember = class("SummontowerGetMember", ViewComponent)

function SummontowerGetMember:buildUI()
	SummontowerGetMember.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtName = self:getTxt("numbers/txtName")
	self._txtLevel = self:getTxt("numbers/txtLevel")
	self._petImageCon = self:getGo("numbers/pet/con")
	self._contractPet = self:getGo("numbers/contractPet")
	self._jobFirst = self:getGo("numbers/job_1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._jobSecond = self:getGo("numbers/job_2"):GetComponent(ComponentType.UIImageSpriteChange)
	self._attr = self:getGo("numbers/attr"):GetComponent(ComponentType.UIImageSpriteChange)
	self._btnJobFirst = Framework.UIClickTrigger.Get(self._jobFirst.gameObject)
	self._btnJobSecond = Framework.UIClickTrigger.Get(self._jobSecond.gameObject)
	self._btnAttrIcon = Framework.UIClickTrigger.Get(self._attr.gameObject)
	self._btnPetInfo = Framework.UIClickTrigger.Get(self:getGo("numbers/btnPet"))
	self._btnCancel = self:getBtn("btnCancel")
end

function SummontowerGetMember:bindEvents()
	SummontowerGetMember.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnJobFirst:AddClickListener(self._onClickJobFirst, self)
	self._btnJobSecond:AddClickListener(self._onClickJobSecond, self)
	self._btnAttrIcon:AddClickListener(self._onClickAttrIcon, self)
	self._btnPetInfo:AddClickListener(self._onClickPetInfo, self)
	self._btnCancel:AddClickListener(self._onClickQuitAll, self)
end

function SummontowerGetMember:unbindEvents()
	SummontowerGetMember.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnJobFirst:RemoveClickListener()
	self._btnJobSecond:RemoveClickListener()
	self._btnAttrIcon:RemoveClickListener()
	self._btnPetInfo:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
end

function SummontowerGetMember:onEnter()
	SummontowerGetMember.super.onEnter(self)

	self._creepsId = self:getFirstParam()
	self._gridData = self:getOpenParam()[2]

	self:_fillPetInfo()
	self:_fillSummonedPet()
end

function SummontowerGetMember:_fillPetInfo()
	local petCo = SummontowerConfig.instance:getPetCo(self._creepsId)

	self._txtName.text = petCo.creepsName
	self._txtLevel.text = "Lv:" .. tostring(petCo.lv)
	self._curFaceId = checknumber(petCo.faceId)

	if self._curFaceId == 0 then
		self._curFaceId = checknumber(petCo.raceId)
	end

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(self._curFaceId)

	self._jobFirst:SetState(firstJobIdx - 1)
	GameUtil.SetActive(self._btnJobSecond.gameObject, false)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(self._curFaceId)

	if secondJobIdx > 20 then
		GameUtil.SetActive(self._btnJobSecond.gameObject, true)
		self._jobSecond:SetState(secondJobIdx - 1 - 20)
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(self._curFaceId)

	race = race % 10

	local targetValue = race - 1

	self._attr:SetState(targetValue)

	local modelCo = CharacterConfig.instance:getModelCo(self._curFaceId)

	uGuiUtil.setSpriteToImage(self._petImageCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function SummontowerGetMember:_fillSummonedPet(summonedPetId)
	local petCo = SummontowerConfig.instance:getPetCo(self._creepsId)
	local summonedPetId = checknumber(petCo.summonedPetId)

	if summonedPetId == 0 then
		return
	end

	local petCo = SummontowerConfig.instance:getPetCo(summonedPetId)
	local level = petCo.lv
	local item = MatType.Pet .. ":" .. petCo.raceId .. ":" .. level

	MaterialMgr.resetAll(self._contractPet)

	local proxy = MaterialMgr.setCellByCfg(item, self._contractPet)

	if proxy then
		local curFaceId = checknumber(petCo.faceId)

		if curFaceId == 0 then
			curFaceId = checknumber(petCo.raceId)
		end

		proxy.binder:setStars(petCo.awakenLv)
		proxy.binder:setSkin(curFaceId)
		proxy.binder:setAutoTips(false)
		proxy.binder:setCallBack(function()
			local fightingPower = FightingPowerPetMo.New(petCo.raceId, level)

			fightingPower:fromChallengeCreepCo(petCo, cfgs)

			local petMo = {
				contractSkillId = 0,
				raceId = petCo.raceId,
				curFaceId = curFaceId,
				level = level,
				name = petCo.creepsName,
				_curZdl = fightingPower:getFightingPower(),
				awakenLv = petCo.awakenLv
			}

			CommonTipsMgr.instance:showPetTips(petMo)
		end)
	end
end

function SummontowerGetMember:onExit()
	self._gridData = nil

	SummontowerGetMember.super.onExit(self)
	uGuiUtil.clearImage(self._petImageCon)
	MaterialMgr.resetAll(self._contractPet)
end

function SummontowerGetMember:_onClickClose()
	if self._gridData and self._gridData.girdStatus == SummomMapNodeMO.gridStatus.SwapPet then
		if SummontowerPetsModel.instance:isPetNumMax() then
			self:_swapPet()
		else
			local gridId = self._gridData.gridId
			local creepsId = self._creepsId

			self:close()
			SummontowerController.instance:swapPet(gridId, creepsId, 0)
		end
	else
		self:close()
	end
end

function SummontowerGetMember:_swapPet()
	SummontowerController.instance:openSelectSwapPetView(function(petId)
		local gridId = self._gridData.gridId
		local creepsId = self._creepsId

		self:close()
		SummontowerController.instance:swapPet(gridId, creepsId, petId)
	end)
end

function SummontowerGetMember:_onClickJobFirst()
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(self._curFaceId)

	CommonTipsMgr.instance:openMaterialTips(self._jobFirst.gameObject, MatType.Job, firstJobIdx)
end

function SummontowerGetMember:_onClickJobSecond()
	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(self._curFaceId)

	CommonTipsMgr.instance:openMaterialTips(self.mainGO, MatType.Job, secondJobIdx)
end

function SummontowerGetMember:_onClickAttrIcon()
	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(self._curFaceId)

	race = race % 10

	CommonTipsMgr.instance:openMaterialTips(self.mainGO, MatType.Race, race)
end

function SummontowerGetMember:_onClickQuitAll()
	TipsFacade.instance:openPopupWindow(lang("tip"), "确定不选择任何1只精灵成为你的队员吗？", function()
		local gridId = self._gridData.gridId

		self:close()
		SummontowerController.instance:giveupSwapPet(gridId)
	end, function()
		return
	end, "确定", "取消")
end

function SummontowerGetMember:_onClickPetInfo()
	local petCo = SummontowerConfig.instance:getPetCo(self._creepsId)
	local level = petCo.lv
	local fightingPower = FightingPowerPetMo.New(petCo.raceId, level)

	fightingPower:fromChallengeCreepCo(petCo)

	local petMo = {
		contractSkillId = 0,
		raceId = petCo.raceId,
		curFaceId = self._curFaceId,
		level = level,
		name = petCo.creepsName,
		_curZdl = fightingPower:getFightingPower(),
		awakenLv = petCo.awakenLv
	}

	CommonTipsMgr.instance:showPetTips(petMo)
end

return SummontowerGetMember
