-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolveplus/view/DivineEvolvePlusDisplayView.lua

module("logic.extensions.divineevolveplus.view.DivineEvolvePlusDisplayView", package.seeall)

local DivineEvolvePlusDisplayView = class("DivineEvolvePlusDisplayView", ViewComponent)

function DivineEvolvePlusDisplayView:ctor()
	DivineEvolvePlusDisplayView.super.ctor(self)
end

function DivineEvolvePlusDisplayView:buildUI()
	DivineEvolvePlusDisplayView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._roleGo = self:getGo("role")
	self._effectGo = self:getGo("effect")
	self._rareGo = self:getGo("left/info/rare")
	self._attrChange = self:getGo("left/info/attr/img"):GetComponent(typeof(UIImageSpriteChange))
	self._career1 = self:getGo("left/info/career/img"):GetComponent(typeof(UIImageSpriteChange))
	self._career2 = self:getGo("left/info/career2/img"):GetComponent(typeof(UIImageSpriteChange))
	self._careerGo2 = self:getGo("left/info/career2")
	self._txtName = self:getTxt("left/info/txtName")
	self._txtDesc = self:getTxt("left/info/txtDesc")
	self._txtOldPower = self:getTxt("right/power/txtOld")
	self._txtNewPower = self:getTxt("right/power/txtNew")
	self._skillIcon = self:getGo("right/skill/icon")
	self._txtSkillName = self:getTxt("right/skill/txtName")
	self._shenweiIcon = self:getGo("right/shenwei/icon")
	self._txtShenweiName = self:getTxt("right/shenwei/txtName")
	self._btnSkill = self:getBtn("right/skill/icon")
	self._power = self:getGo("right/power")
	self._powerNew = self:getGo("right/powerNew")
	self._txtNew2 = self:getTxt("right/powerNew/txtNew")
end

function DivineEvolvePlusDisplayView:bindEvents()
	DivineEvolvePlusDisplayView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnSkill:AddClickListener(self._onClickSkill, self)
end

function DivineEvolvePlusDisplayView:unbindEvents()
	DivineEvolvePlusDisplayView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function DivineEvolvePlusDisplayView:onEnter()
	DivineEvolvePlusDisplayView.super.onEnter(self)

	local param = self:getOpenParam()

	self._shenYaoSkillId = 0
	self._curFaceId = 0

	self:_loadEffect()

	if param then
		self._callback = param[1]

		local newPetMo = param[2]
		local oldPetMo = param[3]

		self:_showPet(newPetMo)
		self:_setPower(newPetMo, oldPetMo)
		self:_setSkillIcon(newPetMo)
	end
end

function DivineEvolvePlusDisplayView:onExit()
	DivineEvolvePlusDisplayView.super.onExit(self)
	self:_resetRoleModel()
	self:_removeSkillIcon()
	self:_removeEffect()
end

function DivineEvolvePlusDisplayView:_onClickClose()
	if self._callback then
		GameUtil.callBack(self._callback)
	end

	self:close()
end

function DivineEvolvePlusDisplayView:_onClickSkill()
	if self._shenYaoSkillId > 0 and self._curFaceId > 0 then
		local skillLv = 1

		CommonTipsMgr.instance:openMaterialTips(self._btnSkill.gameObject, MatType.Skill, self._shenYaoSkillId, self._curFaceId, skillLv)
	end
end

function DivineEvolvePlusDisplayView:_showPet(petMo)
	if not petMo then
		return
	end

	local skinId = petMo.curFaceId
	local petCfg = MaterialMgr.getMatCfg(MatType.Pet, petMo.raceId)

	self._txtName.text = MaterialMgr.getMaterialsName(MatType.PET_SKIN, skinId)

	local petInfoCfg = CharacterConfig.instance:getPetInfoCo(petMo.raceId)

	self._txtDesc.text = string.gsub(petInfoCfg.stragegy, "\n", "，")

	local proxy = MaterialMgr.setCell(MatType.Rare, petMo.raceId, self._rareGo)

	if proxy then
		proxy.binder:setRare(petMo.rare)
	end

	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petMo.curFaceId)

	self._career1:SetState(firstJobIdx - 1)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(petMo.curFaceId)

	GameUtil.SetActive(self._careerGo2, false)

	if secondJobIdx > 20 then
		GameUtil.SetActive(self._careerGo2, true)
		self._career2:SetState(secondJobIdx - 1 - 20)
	end

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = math.fmod(race, 10)

	local targetValue = race - 1

	self._attrChange:SetState(targetValue)
	self:_showRoleModel(skinId)
end

function DivineEvolvePlusDisplayView:_setPower(newPetMo, oldPetMo)
	if oldPetMo and newPetMo then
		goutil.setActive(self._power, true)
		goutil.setActive(self._powerNew, false)

		self._txtOldPower.text = oldPetMo:getFightingPower()
		self._txtNewPower.text = newPetMo:getFightingPower()
	elseif newPetMo then
		goutil.setActive(self._power, false)
		goutil.setActive(self._powerNew, true)

		self._txtNew2.text = newPetMo:getFightingPower()
	end
end

function DivineEvolvePlusDisplayView:_setSkillIcon(newPetMo)
	if not newPetMo then
		return
	end

	local cfg = PetSkinConfig.instance:getPetSkinCfg(newPetMo.curFaceId)

	if not cfg then
		return
	end

	self._shenYaoSkillId = cfg.shenyaoSkillId
	self._curFaceId = newPetMo.curFaceId

	if cfg.shenyaoSkillId > 0 then
		self._txtSkillName.text = MaterialMgr.getSkillTypeName(cfg.shenyaoSkillId, newPetMo.curFaceId)

		MaterialMgr.setSkillByFaceId(cfg.shenyaoSkillId, newPetMo.curFaceId, self._skillIcon)
	end

	local kamuiInfos = newPetMo:getKamuiInfos()

	if kamuiInfos and #kamuiInfos > 0 then
		local id = kamuiInfos[1].kamuiId
		local cfgKamui = DomainCultivateConfig.instance:getDefineCfg(id)

		if cfgKamui then
			uGuiUtil.setSpriteToImage(self._shenweiIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfgKamui.icon))

			self._txtShenweiName.text = cfgKamui.name
		end
	end
end

function DivineEvolvePlusDisplayView:_removeSkillIcon()
	MaterialMgr.resetAll(self._skillIcon)
	MaterialMgr.clearIcon(self._shenweiIcon)
end

function DivineEvolvePlusDisplayView:_showRoleModel(skinId)
	self:_resetRoleModel()

	local offset = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)
	local x, y, scale = 0, 0, 1

	if offset then
		x = checknumber(offset[1])
		y = checknumber(offset[2])
		scale = offset[3] or 1
	end

	self.loader = RoleObjectPool.instance:addRoleToParent(self.loader, skinId, self._roleGo, scale, nil, true, x, y)
end

function DivineEvolvePlusDisplayView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DivineEvolvePlusDisplayView:_loadEffect()
	local path = DivineEvolvePlusDisplayViewPresentor.EffectPath

	self._uiEffect = UIEffectManager.instance:playEffect(self, path, self._effectGo.transform, 0, 0, true, false)

	self._uiEffect:setParent(self._effectGo.transform)
	self._uiEffect:setLocalPos(0, 0, 0)
	self._uiEffect:setScale(1)

	self._uiEffect.hideEffWhileNotOnTop = false
end

function DivineEvolvePlusDisplayView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return DivineEvolvePlusDisplayView
