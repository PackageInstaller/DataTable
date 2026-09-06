-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/view/PetDetailItem.lua

module("logic.extensions.petshandbook.view.PetDetailItem", package.seeall)

local PetDetailItem = class("PetDetailItem")

function PetDetailItem:ctor(go)
	self.mainGo = go
	self._txtName = goutil.findChildComponent(self.mainGo, "name/txtName", "Text")
	self._txtPower = goutil.findChildComponent(self.mainGo, "power/txtPower", "UITextImage")
	self._txtDesc = goutil.findChildComponent(self.mainGo, "description/ScrollView/txtDesc", "Text")
	self._txtStrategy = goutil.findChildComponent(self.mainGo, "strategy/ScrollView/txtStrategy", "Text")
	self._txtPosition = goutil.findChildComponent(self.mainGo, "strategy/txtPosition", "Text")
	self._ImgC_Gender = goutil.findChildComponent(self.mainGo, "name/ImgC_Gender", "UIImageSpriteChange")
	self._PetContainer = goutil.findChild(self.mainGo, "PetContainer")
	self._Attr_Master = goutil.findChildComponent(self.mainGo, "attribute/imgAttrBg/imgAttr", "UIImageSpriteChange")
	self._Job_Master = goutil.findChildComponent(self.mainGo, "attribute/imgJobBg/imgJob", "UIImageSpriteChange")
	self._imgJob1 = goutil.findChildComponent(self.mainGo, "attribute/imgJob1Bg/imgJob1", "UIImageSpriteChange")
	self._goJob1 = goutil.findChild(self.mainGo, "attribute/imgJob1Bg")
	self._Skill_Container = goutil.findChild(self.mainGo, "skill/Container")
	self._Skills = {}

	local skillCell = goutil.findChild(self._Skill_Container, "item_skill")
	local go
	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		go = go == nil and skillCell or goutil.cloneAndSetParent(skillCell, self._Skill_Container.transform)

		print("go == nil " .. tostring(go == nil))
		goutil.setActive(go, false)

		self._Skills[#self._Skills + 1] = go
	end

	self._goMagic = goutil.findChild(self.mainGo, "magic")
	self._imgReceived = goutil.findChild(self._goMagic, "imgReceived")
	self._txtMagicPower = goutil.findChildComponent(self._goMagic, "txtMagicPower", "Text")
	self._imgMagic = goutil.findChildComponent(self.mainGo, "magic/imgMagic", "Image")

	uGuiUtil.setSpriteToImage(self._imgMagic.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl("icon_mofang"))

	self._btnGet = Framework.ButtonAdapter.GetFrom(self.mainGo, "btnGet")

	self._btnGet:RemoveClickListener()
	self._btnGet:AddClickListener(self._onClickGoTo, self)

	self._starBg = goutil.findChildComponent(self.mainGo, "imgdi", "RectTransform")
	self._starContainer = goutil.findChild(self.mainGo, "star")
	self._stars = {}

	for i = 1, 6 do
		self._stars[i] = self._starContainer.transform:GetChild(i - 1).gameObject

		goutil.setActive(self._stars[i], false)
	end
end

function PetDetailItem:refresh(raceId)
	if checknumber(raceId) <= 0 then
		print("invalid raceId")

		return
	end

	self.raceId = raceId

	local petCfg = CharacterConfig.instance:getPetCo(raceId)
	local isHasPet = PetsHandBookModel.instance:isHasPet(raceId)

	self._txtName.text = petCfg.name
	self._initMat = nil
	self._tempMat = nil
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, tonumber(petCfg.faceIds), self._PetContainer, 1, function(go)
		local r = goutil.findChildComponent(go, "skeleton", "SkeletonGraphic")

		if r then
			self._initMat = r.material

			if not isHasPet then
				self._tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphicFill"))
				self._tempMat.mainTexture = r.material.mainTexture
				r.material = self._tempMat

				self._tempMat:SetFloat("_FillPhase", 1)
				GoUtil.SetMatColor(self._tempMat, "_Color", 0.596078431372549, 0.7137254901960784, 0.807843137254902, 1)
			else
				self._tempMat = UnityEngine.Material.New(Framework.ShaderCache.Find("Spine/SkeletonGraphic (Premultiply Alpha)"))
				self._tempMat.mainTexture = r.material.mainTexture
				r.material = self._tempMat

				GoUtil.SetMatColor(r.material, "_Color", 1, 1, 1, 1)
			end

			self._roleGo = go
		end

		local modelCfg = CharactorFacade.instance:getHandbookModelUIPosAndScale(tonumber(petCfg.faceIds))

		if not modelCfg[1] then
			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1

					Framework.TransformUtil.SetLocalPos(go.transform, modelCfg[1], y, 0)
					Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)
				end
			end
		end
	end)

	local petCo = PetSkinConfig.instance:getPetSkinCfg(raceId)
	local sortedKeys = MaterialMgr.getSkillSortedKeys()

	for index, skillType in ipairs(sortedKeys) do
		local v = MaterialMgr.SkillName[skillType]
		local go = self._Skills[index]
		local skillId = petCo[v]

		if skillId == 0 or skillType == GameEnum.SkillRaceType.Summon then
			go:SetActive(false)
		else
			go:SetActive(true)

			local component = ItemSkill.Get(go)

			component:SetValue(skillType, skillId)
			component:addListener(ItemSkill.Events.OnClick, function(type, skillId)
				self:_OnClickSkill(type, skillId)
			end)
		end
	end

	local cfg = CharacterConfig.instance:getPetCo(raceId)
	local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(raceId)

	self._Job_Master:SetState(firstJobIdx - 1)

	local races = GameUtil.splitRaceTypes(cfg.raceTypes)

	self._Attr_Master:SetState(GameEnum.Races[races[1]] - 1)
	self._ImgC_Gender:SetState(petCfg.gender - 1)
	goutil.setActive(self._goJob1, false)

	local secondJobIdx = PetSkinConfig.instance:getSecondJobIdx(raceId)

	if secondJobIdx > 20 then
		goutil.setActive(self._goJob1, true)
		self._imgJob1:SetState(secondJobIdx - 1 - 20)
	end

	self._txtPower:SetNum(PetsHandBookModel.instance:getPetMaxPower(raceId))

	local petInfo = CharacterConfig.instance:getPetInfoCo(raceId)

	self._txtDesc.text = petInfo.introduce
	self._txtStrategy.text = petInfo.stragegy
	self._txtPosition.text = string.format(ConstString.BestPosition, petInfo.bestPosition)

	local cubeExpCfg = HandBookConfig.instance:getCubeExpById(raceId)

	goutil.setActive(self._goMagic, cubeExpCfg ~= nil)

	if cubeExpCfg then
		self._txtMagicPower.text = cubeExpCfg.cubeExp

		goutil.setActive(self._imgReceived, PetsHandBookModel.instance:isHasPet(raceId))
	end

	goutil.setActive(self._btnGet.gameObject, not PetsHandBookModel.instance:isHasPet(raceId))

	if not petCfg.starCount then
		local starCount = 1

		for i = 1, 6 do
			goutil.setActive(self._stars[i], i <= starCount)
			Framework.TransformUtil.SetLocalPos(self._stars[i].transform, (i - starCount / 2 - 0.5) * 37.5, 0, 0)
		end

		self._starBg.sizeDelta = Vector2.New(starCount <= 3 and 165 or 330, 31)
	end
end

function PetDetailItem:onDispose()
	if self._role ~= nil and self._initMat ~= nil and not goutil.isNil(self._roleGo) then
		local r = goutil.findChildComponent(self._roleGo, "skeleton", "SkeletonGraphic")

		r.material = self._initMat

		RoleObjectPool.instance:removeRole(self._role)
	end

	if self._tempMat ~= nil then
		UnityEngine.GameObject.Destroy(self._tempMat)

		self._tempMat = nil
	end
end

function PetDetailItem:_OnClickSkill(type, skillId)
	CommonTipsMgr.instance:openMaterialTips(self._Skill_Container, MatType.Skill, skillId)
end

function PetDetailItem:_onClickGoTo()
	local isExist = PetsHandbookFacade.instance:getDefaultWays(self.raceId, nil, "petDetailView")

	if isExist then
		-- block empty
	else
		FloatWordMgr.instance:show("该精灵配置不存在")
	end
end

return PetDetailItem
