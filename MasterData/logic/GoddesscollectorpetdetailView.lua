-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscollector/view/GoddesscollectorpetdetailView.lua

module("logic.extensions.goddesscollector.view.GoddesscollectorpetdetailView", package.seeall)

local GoddesscollectorpetdetailView = class("GoddesscollectorpetdetailView", ViewComponent)

function GoddesscollectorpetdetailView:ctor()
	GoddesscollectorpetdetailView.super.ctor(self)
end

function GoddesscollectorpetdetailView:unbindEvents()
	GoddesscollectorpetdetailView.super.unbindEvents(self)
	self._btnJump:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function GoddesscollectorpetdetailView:bindEvents()
	GoddesscollectorpetdetailView.super.bindEvents(self)
	self._btnJump:AddClickListener(self._onClickbtnJump, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function GoddesscollectorpetdetailView:buildUI()
	GoddesscollectorpetdetailView.super.buildUI(self)

	self._btnJump = self:getBtn("btnJump")
	self._btnClose = self:getBtn("btnClose")
	self.itemCon = self:getGo("itemPet")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "txtName")
	self._txtRare = goutil.findChildTextComponent(self.mainGO, "txtRare")
	self._rolePoint = self:getGo("rolePoint")

	local _Nego_Skill = goutil.findChild(self.mainGO, "skills/Viewport/Content")
	local skillCell = goutil.findChild(self.mainGO, "skills/Viewport/Content/cell")

	goutil.setActive(skillCell, false)

	self._skillViewContent = _Nego_Skill.transform
	self._skillView = goutil.findChild(self.mainGO, "skills"):GetComponent(ComponentType.ScrollRect)
	self._Skills = {}

	local sortedKeys = MaterialMgr.getAllSkillsSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local go = goutil.clone(skillCell)

		go.transform:SetParent(_Nego_Skill.transform, false)

		self._Skills[#self._Skills + 1] = go
	end

	self._imgAttr = goutil.findChildComponent(self.mainGO, "attr/icon", "UIImageSpriteChange")
	self._imgJob = goutil.findChildComponent(self.mainGO, "job/icon", "UIImageSpriteChange")
	self._imgJob1 = goutil.findChildComponent(self.mainGO, "job1/icon", "UIImageSpriteChange")
	self._goJob1 = self:getGo("job1")
	self._txtBtnJump = goutil.findChildTextComponent(self.mainGO, "btnJump/text")
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "power/txtPower")
end

function GoddesscollectorpetdetailView:onExit()
	GoddesscollectorpetdetailView.super.onExit(self)
	MaterialMgr.resetAll(self.itemCon)
	RoleObjectPool.instance:removeRole(self._role)

	for i = 1, #self._Skills do
		local go = self._Skills[i]
		local con = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(con)
		GameUtil.asBtn(go):RemoveClickListener()
	end
end

function GoddesscollectorpetdetailView:onEnter()
	GoddesscollectorpetdetailView.super.onEnter(self)

	local params = self:getOpenParam()

	self._cfg = params[1]
	self._viewType = params[2]
	self._raceId = self._cfg.raceId

	local showRaceId = self._raceId

	if self:_isSkin() then
		local pcfg = PetSkinConfig.instance:getPetSkinCfg(self._cfg.skinId)

		self._raceId = pcfg.raceId
		self._skinId = self._cfg.skinId
		showRaceId = self._skinId
	end

	self:_setName()

	local proxy = MaterialMgr.setCellByCfg(string.format("%s:%s", MatType.Pet, showRaceId), self.itemCon)

	if proxy then
		proxy.binder:setAutoTips(false)
	end

	self:_updateRole()
	self:_updateSkill(self._raceId)
	self:_updateRace(self._raceId, self._raceId)
	self:_setIsCollectStatus()
	self:_setPower()
	Framework.TransformUtil.SetAnchoredPos(self._skillViewContent, 0, 0)
end

function GoddesscollectorpetdetailView:_onClickbtnJump()
	if self._isCollet then
		return
	end

	if not string.nilorempty(self._cfg.jumpTo) then
		GotoMgr.gotoByString(self._cfg.jumpTo)
		self:close()
	end
end

function GoddesscollectorpetdetailView:_onClickbtnClose()
	self:close()
end

function GoddesscollectorpetdetailView:_setName()
	local cfg = CharacterConfig.instance:getPetCo(self._raceId)

	self._txtRare.text = ConstString.PetRareLang[cfg.rare]

	local name = ""

	if self:_isSkin() then
		name = PetSkinConfig.instance:getPetSkinName(self._skinId)
		self._txtRare.text = ConstString.PetRareLang[cfg.rare]
	else
		name = cfg.name
	end

	self._txtName.text = name
end

function GoddesscollectorpetdetailView:_updateRole()
	local raceId = self._raceId

	if self:_isSkin() then
		raceId = self._skinId
	end

	local object = CharactorFacade.instance
	local cfg = CharacterConfig.instance:getModelCo(raceId)
	local hasLihui = cfg and not string.nilorempty(cfg.bustName)
	local displayBagOffset = hasLihui and object:getShareLihuiModelUIPosAndScale(raceId) or object:getShareModelUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, raceId, self._rolePoint, scale, nil, true, x, y)
end

function GoddesscollectorpetdetailView:_updateSkill(raceId)
	local petCo = PetSkinConfig.instance:getPetSkinCfg(raceId)
	local sortedKeys = MaterialMgr.getAllSkillsSortedKeys()
	local skillCount = 0

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.getSkillKeyNameByType(skillType)
		local go = self._Skills[index]
		local con = goutil.findChild(go, "icon")
		local txt = goutil.findChildTextComponent(go, "txt_skillname")
		local skillId = petCo[v]
		local txtSkillLv = goutil.findChildTextComponent(go, "txt_skill_lv")
		local txtSkillType = goutil.findChildTextComponent(go, "txt_skill_type")
		local skillCfg = BattleConfig.instance:getSkillCo(skillId, raceId)

		GameUtil.asBtn(go):RemoveClickListener()
		MaterialMgr.resetAll(con)

		if skillId == 0 then
			go:SetActive(false)
		else
			skillCount = skillCount + 1

			go:SetActive(true)

			local proxy = MaterialMgr.setSkillByFaceId(skillId, raceId, con)

			if proxy then
				proxy:setAutoTips(false)
			end

			GameUtil.asBtn(go):AddClickListener(GameUtil.handler(self._OnClickSkill, self, skillType, skillId, go))

			txtSkillType.text = MaterialMgr.getSkillTypeName(skillId, raceId)
			txtSkillLv.text = 1
			txt.text = skillCfg.name
		end
	end

	self:_modifySkillViewPos(skillCount)
end

function GoddesscollectorpetdetailView:_modifySkillViewPos(skillCount)
	if skillCount >= 4 then
		Framework.TransformUtil.SetLocalPos(self._skillView.transform, -342, 39, 0)
	elseif skillCount == 3 then
		Framework.TransformUtil.SetLocalPos(self._skillView.transform, -312, 39, 0)
	elseif skillCount == 2 then
		Framework.TransformUtil.SetLocalPos(self._skillView.transform, -250, 39, 0)
	else
		Framework.TransformUtil.SetLocalPos(self._skillView.transform, -210, 39, 0)
	end

	self._skillView.enabled = skillCount >= 0
end

function GoddesscollectorpetdetailView:_OnClickSkill(skillType, skillId, go)
	local skillLv = 1
	local key = MaterialMgr.SkillLvlKey[skillType]

	if not string.nilorempty(key) then
		local v = MaterialMgr.SkillName[skillType]

		skillLv = 1

		local skillInfocfg = CharacterConfig.instance:getSkillInfoByLvl(self._raceId, 1)

		if skillInfocfg then
			skillId = checknumber(skillInfocfg[v])
		end
	end

	CommonTipsMgr.instance:openMaterialTips(go, MatType.Skill, skillId, self._raceId, skillLv)
end

function GoddesscollectorpetdetailView:_updateRace(raceId, skinId)
	local cfg = CharacterConfig.instance:getPetCo(raceId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

	self._imgJob:SetState(firstJobIdx - 1)

	local race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

	race = race % 10

	self._imgAttr:SetState(race - 1)
	goutil.setActive(self._goJob1, false)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(skinId)

	if secondJobIdx > 20 then
		goutil.setActive(self._goJob1, true)
		self._imgJob1:SetState(secondJobIdx - 1 - 20)
	end
end

function GoddesscollectorpetdetailView:_isSkin()
	return self._viewType == GoddesscollectorpetsView.ViewType.PetSkins
end

function GoddesscollectorpetdetailView:_setIsCollectStatus()
	self._isCollet = false
	self._isCollet = self:_isSkin() and GoddesscollectorModel.instance:isSkinCollect(self._cfg.id) or GoddesscollectorModel.instance:isPetCollect(self._cfg.id)
	self._txtBtnJump.text = self._isCollet and "已收集" or "前往获得"
end

function GoddesscollectorpetdetailView:_setPower()
	local zdl = 0
	local co = MaterialMgr.getMatCfg(MatType.Pet, self._raceId)

	if co then
		local tmpMo = FightingPowerPetMo.createPetByLevel(self._raceId, 1, co.initAwakenLv, self._skinId)

		if tmpMo then
			zdl = tmpMo:getFightingPower()
		end
	end

	self._txtPower.text = zdl
end

return GoddesscollectorpetdetailView
