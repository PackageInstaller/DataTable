-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineevolve/view/DivineEvolveDisplayView.lua

module("logic.extensions.divineevolve.view.DivineEvolveDisplayView", package.seeall)

local DivineEvolveDisplayView = class("DivineEvolveDisplayView", ViewComponent)

function DivineEvolveDisplayView:ctor()
	DivineEvolveDisplayView.super.ctor(self)
end

function DivineEvolveDisplayView:buildUI()
	DivineEvolveDisplayView.super.buildUI(self)

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
end

function DivineEvolveDisplayView:bindEvents()
	DivineEvolveDisplayView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function DivineEvolveDisplayView:unbindEvents()
	DivineEvolveDisplayView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineEvolveDisplayView:onEnter()
	DivineEvolveDisplayView.super.onEnter(self)

	local param = self:getOpenParam()

	if param then
		local oldPetMo = param[1]
		local newPetMo = param[2]

		self._callback = param[3]

		self:_showPet(newPetMo)
		self:_setPower(oldPetMo, newPetMo)
		self:_setSkillIcon(newPetMo)
	end

	self:_loadEffect()
end

function DivineEvolveDisplayView:onExit()
	DivineEvolveDisplayView.super.onExit(self)
	self:_resetRoleModel()
	self:_removeSkillIcon()
	self:_removeEffect()
end

function DivineEvolveDisplayView:_onClickClose()
	if self._callback then
		GameUtil.callBack(self._callback)
	end

	self:close()
end

function DivineEvolveDisplayView:_showPet(petMo)
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

function DivineEvolveDisplayView:_setPower(oldPetMo, newPetMo)
	if not oldPetMo or not newPetMo then
		return
	end

	self._txtOldPower.text = oldPetMo:getFightingPower()
	self._txtNewPower.text = newPetMo:getFightingPower()
end

function DivineEvolveDisplayView:_setSkillIcon(newPetMo)
	if not newPetMo then
		return
	end

	local cfg = PetSkinConfig.instance:getPetSkinCfg(newPetMo.curFaceId)

	if not cfg then
		return
	end

	if cfg.domainSkillId > 0 then
		self._txtSkillName.text = MaterialMgr.getSkillTypeName(cfg.domainSkillId, newPetMo.curFaceId)

		MaterialMgr.setSkillByFaceId(cfg.domainSkillId, newPetMo.curFaceId, self._skillIcon)
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

function DivineEvolveDisplayView:_removeSkillIcon()
	MaterialMgr.resetAll(self._skillIcon)
	MaterialMgr.clearIcon(self._shenweiIcon)
end

function DivineEvolveDisplayView:_showRoleModel(skinId)
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

function DivineEvolveDisplayView:_resetRoleModel()
	self.loader = RoleObjectPool.instance:removeRole(self.loader)
end

function DivineEvolveDisplayView:_loadEffect()
	local path = "fx_ui_shenqijinhua/fx_shenqijinhua_tx01.prefab"

	self._uiEffect = UIEffectManager.instance:playEffect(self, path, self._effectGo.transform, 0, 0, true, false)

	self._uiEffect:setParent(self._effectGo.transform)
	self._uiEffect:setLocalPos(0, 0, 0)
	self._uiEffect:setScale(1)

	self._uiEffect.hideEffWhileNotOnTop = false
end

function DivineEvolveDisplayView:_removeEffect()
	if self._uiEffect then
		UIEffectManager.instance:stopEffect(self._uiEffect)

		self._uiEffect = nil
	end
end

return DivineEvolveDisplayView
