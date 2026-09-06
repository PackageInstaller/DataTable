-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/view/ItemSeat.lua

module("logic.extensions.formation.view.ItemSeat", package.seeall)

local LuaComponentContainer = Framework.LuaComponentContainer
local ItemSeat = class("ItemSeat")

ItemSeat.OnSeatValueChanged = "ItemSeat.OnSeatValueChanged"

function ItemSeat.AddOnce(go)
	local component = ItemSeat.Get(go)

	component = component or LuaComponentContainer.Add(go, ItemSeat)

	return component
end

function ItemSeat.Get(go)
	return (LuaComponentContainer.Get(go, ItemSeat))
end

function ItemSeat.Remove(go)
	local LuaComponentContainer = Framework.LuaComponentContainer

	LuaComponentContainer.Remove(go, ItemSeat)
end

function ItemSeat:ctor(target)
	NotifyDispatcher.extend(self)

	self.lastRace = -1
	self._character = nil
	self.petId = -1
	self._posId = 0
	self._tempPetId = -1
	self._order = 0
	self._isHiding = false
	self._isForbid = false
	self._target = target

	local Nego_Left = self._target.transform.parent.parent
	local index = string.sub(self._target.name, -1)

	self._index = checknumber(index)

	local pathLayerBg = "layerBg/item" .. index
	local pathLayerUI = "layerUI/item" .. index
	local pathLayerRole = "layerRole/item" .. index
	local layerBgGo = goutil.findChild(Nego_Left, pathLayerBg)
	local layerUIGo = goutil.findChild(Nego_Left, pathLayerUI)
	local layerRoleGo = goutil.findChild(Nego_Left, pathLayerRole)

	self._layerBgGo = layerBgGo
	self._ImgC_Forbid = goutil.findChild(layerBgGo, "ImgC_Forbid"):GetComponent("UIImageSpriteChange")
	self._ImgC_ForbidImage = self._ImgC_Forbid:GetComponent(goutil.Type_UIImage)
	self._necessary = goutil.findChild(layerBgGo, "necessary")
	self._forbid = goutil.findChild(layerBgGo, "forbid")
	self._restrainTxt = goutil.findChildTextComponent(layerBgGo, "Text")
	self._Nego_Character = goutil.findChild(layerRoleGo, "Nego_Character")
	self._layerUI = layerUIGo
	self._imageGo = goutil.findChild(layerUIGo, "bg")
	self._ImgC_Info = goutil.findChild(layerUIGo, "ImgC_Info"):GetComponent("UIImageSpriteChange")
	self._Btn_Summon = goutil.findChild(layerUIGo, "Btn_Summon")
	self._txtLv = goutil.findChild(layerUIGo, "txtLv"):GetComponent(goutil.Type_UIText)
	self._txtAtkType = goutil.findChild(layerUIGo, "txtAtkType"):GetComponent(goutil.Type_UIText)
	self._ImgC_Title = goutil.findChildComponent(layerUIGo, "ImgC_Title", "UIImageSpriteChange")
	self._txtTitle = goutil.findChildComponent(layerUIGo, "txtTitle", goutil.Type_UIText)

	if self._txtTitle then
		self._txtTitle.gameObject:SetActive(false)
	end

	if self._ImgC_Title then
		self._ImgC_Title.gameObject:SetActive(false)
	end
end

function ItemSeat:onExit()
	self.lastRace = -1
	self._isForbid = false
	self.petId = -1
	self._petMo = nil
	self._posId = 0
	self._tempPetId = -1

	self:resetCharactorColor()

	self._loader, self._lastCallBack, self._character = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._character)

	self:removeHeroSkillEff()
	self:_removeDropEffect()
	self:removeChangeHeroSkillEffect()
	self:_removeRecPosItem()
	self:_removeAtkSelfItem()
	self:removeFusionSkillEffect()
	self:removeContractSkillEffect()
	self:removeElementSkillEffect()
	self:removeFixedEffect()
	self:removeYuanLimitEffect()
end

function ItemSeat:OnDestroy()
	return
end

function ItemSeat:GetPosition()
	return self._posId
end

function ItemSeat:getLocalPosition()
	return self._target.transform.localPosition
end

function ItemSeat:SetSeatInfo(posId, petMo, raceRelationMap, isAuto)
	self._posId = posId
	self.curRace = -1

	if petMo == nil then
		self.lastRace = -1
	end

	self._isHiding = false
	self._raceRelationMap = raceRelationMap

	self:updatePetMo(petMo)

	self._isAuto = false

	self:_setUIShow(petMo)
end

function ItemSeat:updatePetMo(petMo)
	self._petMo = petMo
	self._isHasPet = false
	self.petId = 0

	if petMo then
		self.petId = checknumber(petMo.petId)
		self._isHasPet = self.petId > 0
	end
end

function ItemSeat:getPetMo()
	return self._petMo
end

function ItemSeat:_setUIShow(petMo)
	self:_showModel(petMo, self._isAuto)
end

function ItemSeat:_showModel(pet, isAuto)
	self:setRaceType(pet, self._raceRelationMap)

	if pet then
		self:_loadRole(pet.petId, isAuto, pet.curFaceId)
	else
		self:resetCharactorColor()

		self._loader, self._lastCallBack, self._character = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._character)
	end
end

function ItemSeat:_loadRole(petId, isAuto, curFaceId)
	local modelCfg = CharactorFacade.instance:getFormationModelUIPosAndScale(curFaceId)

	if not modelCfg[1] then
		if not modelCfg[2] then
			if not (modelCfg[3] * 0.35) then
				local scale = 0.35

				scale = scale * self:getPerspectiveFactor(self._posId)

				self:resetCharactorColor()

				self._loader, self._lastCallBack, self._character = RoleObjectPool.instance:resetLoader(self._loader, self._lastCallBack, self._character)
				self._loader, self._lastCallBack = RoleObjectPool.instance:getRoleAsset(curFaceId, function(go)
					go:SetActive(true)
					goutil.addChildToParent(go, self._Nego_Character)
					Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
					Framework.TransformUtil.SetLocalScale(go.transform, scale, scale, scale)

					self._character = go

					if not self:_isSelfPetId(petId) then
						self:setCharactorColor()
					end
				end, isAuto)
			end
		end
	end
end

function ItemSeat:_isSelfPetId(petId)
	return petId == self.petId
end

function ItemSeat:resetCharactorColor()
	if self._character then
		if self._initColor then
			local skeletonGraphic = self._character:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

			if skeletonGraphic then
				skeletonGraphic.color = self._initColor
				self._initColor = nil
			end
		end
	else
		self._initColor = nil
	end
end

function ItemSeat:setCharactorColor()
	if self._character then
		local skeletonGraphic = self._character:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))

		if skeletonGraphic then
			self._initColor = Color.New(1, 1, 1)
			skeletonGraphic.color = Color.New(0.5882352941176471, 0.5882352941176471, 0.5882352941176471)
		end
	end
end

function ItemSeat:setRaceType(pet, raceMap)
	self._raceRelationMap = raceMap
	self._isHasPet = false

	self._ImgC_Forbid:SetState(0)

	if pet then
		self._isHasPet = true

		local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
		local skinId = pet.raceId
		local race = 0

		if raceMap and raceMap[pet.petId] ~= nil then
			race = raceMap[pet.petId]
		else
			if checknumber(pet.curFaceId) > 0 then
				skinId = checknumber(pet.curFaceId)
			end

			race = PetSkinConfig.instance:getFisrtEleAttrIdx(skinId)

			if self.lastRace ~= race then
				self.lastRace = -1
			end
		end

		race = race % 10
		self.curRace = race

		self._ImgC_Info:SetState(race - 1)

		local rareNum = CharacterConfig.instance:getInitRare(pet.raceId)

		self._ImgC_Forbid:SetState(rareNum)

		self._txtLv.text = pet:getPetLv()

		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(skinId)

		self._txtAtkType.text = ConstString.AtkTypeByIdx[firstJobIdx]
	end

	local hasPet = self._isHasPet

	self._layerUI:SetActive(hasPet)
	self._imageGo:SetActive(hasPet)
	self._ImgC_Info.gameObject:SetActive(hasPet)
	self._txtLv.gameObject:SetActive(hasPet)
	self._Nego_Character.gameObject:SetActive(hasPet)
	self._txtAtkType.gameObject:SetActive(hasPet)
	self._Btn_Summon.gameObject:SetActive(false)

	if self._txtTitle and self._ImgC_Title then
		local petTitleId = 0

		if pet then
			petTitleId = pet.petTitleId
		end

		local hasPetTitle = petTitleId and petTitleId > 0

		if hasPetTitle then
			local petTitleConf = PetTitleConfig.instance:getPetTitleConfig(petTitleId)

			self._txtTitle.text = petTitleConf.simpleName

			self._ImgC_Title:ChangeSprite(petTitleConf.icon2)
		end

		self._txtTitle.gameObject:SetActive(hasPetTitle)
		self._ImgC_Title.gameObject:SetActive(hasPetTitle)
	end
end

function ItemSeat:recoverRaceType()
	self:setRaceType(self._petMo, self._raceRelationMap)
end

function ItemSeat:previewPetShow(petMo)
	self:_showModel(petMo, false)
end

function ItemSeat:recoverPetShow()
	self:_showModel(self._petMo, false)
end

function ItemSeat:setTempPetId(tempPetId)
	self._tempPetId = tempPetId
end

function ItemSeat:getTempPetId()
	if self._tempPetId >= 0 then
		return self._tempPetId
	end

	return self.petId
end

function ItemSeat:resetTempPetId()
	self._tempPetId = -1
end

function ItemSeat:resetPetShow()
	self:_setUIShow(self._petMo)
end

function ItemSeat:HidePet()
	self._Nego_Character.gameObject:SetActive(false)
	self._layerUI:SetActive(false)

	self._isHiding = true
end

function ItemSeat:ShowPet()
	self._Nego_Character.gameObject:SetActive(true)
	self._layerUI:SetActive(true)

	self._isHiding = false
end

function ItemSeat:IsHiding()
	return self._isHiding
end

function ItemSeat:IsOpen()
	local formId = self:_getCurFormId()
	local list = BattleConfig.instance:getFormationPosKVList(formId)

	return list[self._posId]
end

function ItemSeat:SetSelect(visible)
	if visible then
		self._ImgC_ForbidImage.color = Color.New(0.7372549019607844, 0, 1, 1)

		return
	else
		self._ImgC_ForbidImage.color = Color.New(1, 1, 1, 1)

		return
	end
end

function ItemSeat:getWorldPosition()
	if not self._ImgC_Forbid then
		return Vector3.New(0, 0, 0)
	end

	return self._ImgC_Forbid.transform.position
end

function ItemSeat:_getScale()
	local num = self._posId % 3

	return num == 1 and 0.9 or num == 2 and 1 or 1.1
end

function ItemSeat:SetRestrain(txt, visible)
	if self._restrainTxt then
		self._restrainTxt.gameObject:SetActive(visible)

		self._restrainTxt.text = txt
	end
end

function ItemSeat:GetData()
	return self.petId
end

function ItemSeat:isHasPet()
	return self._isHasPet
end

function ItemSeat:getPerspectiveFactor(posId)
	return 1
end

function ItemSeat:setEffectActive(isActive, isNecessary)
	if not isActive then
		if self._necessary then
			self._necessary:SetActive(false)
		end

		if self._forbid then
			self._forbid:SetActive(false)
		end

		return
	end

	if self._necessary then
		self._necessary:SetActive(isNecessary)
	end

	if self._forbid then
		self._forbid:SetActive(not isNecessary)
	end
end

function ItemSeat:_getEffectScaleFactor(posId)
	local num = posId % 3

	if num == 1 then
		return 10
	elseif num == 2 then
		return 11
	else
		return 12
	end
end

function ItemSeat:_getFusionEffectScaleFactor(posId)
	local num = posId % 3

	if num == 1 then
		return 10, 10, 10
	elseif num == 2 then
		return 11, 11, 11
	else
		return 12, 12, 14
	end
end

function ItemSeat:setHeroSkillEffect(view, buffs, pos)
	local parentGo = self._ImgC_Forbid.gameObject

	self._heroSkillEff = self._heroSkillEff or {}

	if buffs then
		local loadedPaths = {}

		for i, v in ipairs(buffs) do
			if not string.nilorempty(v.effectPath) and loadedPaths[v.effectPath] == nil then
				loadedPaths[v.effectPath] = true

				local effectPath = {
					GameUrl.getFuncIconUrl(v.effectPath)
				}
				local effect = UIEffectManager.instance:playEffect(view, effectPath, parentGo.transform, 0, 0, true, false)

				effect:setParent(parentGo.transform)

				local scale = self:_getEffectScaleFactor(pos)

				effect:setScale(scale)
				effect:setLocalPos(0, 3, 0)
				effect:setLocalEulerAngle(25, 0, 0)
				effect:setSortingOrder(180)

				effect.hideEffWhileNotOnTop = nil

				table.insert(self._heroSkillEff, effect)
			end
		end
	else
		self:removeHeroSkillEff()
	end
end

function ItemSeat:removeHeroSkillEff()
	if self._heroSkillEff then
		for i, v in ipairs(self._heroSkillEff) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._heroSkillEff = nil
	end
end

function ItemSeat:playFusionSkillEffect(skillIds, formulaIds, view)
	self:removeFusionSkillEffect()

	if not skillIds or #skillIds <= 0 or not formulaIds or #formulaIds <= 0 then
		return
	end

	local parentGo = self._ImgC_Forbid.gameObject

	self._fusionSkillEff = self._fusionSkillEff or {}

	local loadedPaths = {}

	for i, v in ipairs(skillIds) do
		local cfg = BattleConfig.instance:getCombinionSkillformulaCo(v, formulaIds[i])

		if not string.nilorempty(cfg.effectPath) and loadedPaths[cfg.effectPath] == nil then
			loadedPaths[cfg.effectPath] = true

			local effectPath = {
				GameUrl.getFuncIconUrl(cfg.effectPath)
			}
			local effect = UIEffectManager.instance:playEffect(view, effectPath, parentGo.transform, 0, 0, true, false)

			effect:setParent(parentGo.transform)

			local scaleX, scaleY, scaleZ = self:_getFusionEffectScaleFactor(self._posId)

			effect:setScaleXYZ(scaleX, scaleY, scaleZ)
			effect:setLocalPos(0, 0, 0)
			effect:setLocalEulerAngle(25, 0, 0)
			effect:setSortingOrder(180)

			effect.hideEffWhileNotOnTop = nil

			table.insert(self._fusionSkillEff, effect)
		end
	end
end

function ItemSeat:removeFusionSkillEffect()
	if self._fusionSkillEff then
		for i, v in ipairs(self._fusionSkillEff) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._fusionSkillEff = nil
	end
end

function ItemSeat:playContractSkillEffect(view, path)
	self:removeContractSkillEffect()

	if not string.nilorempty(path) then
		local effectPath = {
			GameUrl.getFuncIconUrl(path)
		}
		local parentGo = self._ImgC_Forbid.gameObject
		local effect = UIEffectManager.instance:playEffect(view, effectPath, parentGo.transform, 0, 0, true, false)

		effect:setParent(parentGo.transform)

		local scale = self:_getEffectScaleFactor(self._posId)

		effect:setScale(scale)
		effect:setLocalPos(0, 0, 0)
		effect:setLocalEulerAngle(25, 0, 0)
		effect:setSortingOrder(180)

		effect.hideEffWhileNotOnTop = false
		self._contractSkillEff = effect
	end
end

function ItemSeat:removeContractSkillEffect()
	if self._contractSkillEff then
		UIEffectManager.instance:stopEffect(self._contractSkillEff)
	end

	self._contractSkillEff = nil
end

function ItemSeat:playElementSkillEffect(view, path, scale)
	if scale == nil then
		scale = 1
	end

	self:removeElementSkillEffect()

	if self.curRace ~= self.lastRace then
		self.lastRace = self.curRace

		if not string.nilorempty(path) then
			local effectPath = {
				path
			}
			local parentGo = self._ImgC_Info.gameObject
			local effect = UIEffectManager.instance:playEffect(view, effectPath, parentGo.transform, 0, 0, false, false, function()
				if self._elementSkillEff then
					UIEffectManager.instance:stopEffect(self._elementSkillEff)
				end

				self._elementSkillEff = nil
			end)

			effect:setParent(parentGo.transform)
			effect:setScale(scale)
			effect:setSortingOrder(201)

			effect.hideEffWhileNotOnTop = false
			self._elementSkillEff = effect
		end
	end

	local kuang_effect_path

	if self.curRace == GameEnum.RaceType.Cao then
		kuang_effect_path = "20220930/yuansushixitong/fx_ui_yssxt_caok.prefab"
	elseif self.curRace == GameEnum.RaceType.Shui then
		kuang_effect_path = "20220930/yuansushixitong/fx_ui_yssxt_shuik.prefab"
	elseif self.curRace == GameEnum.RaceType.Huo then
		kuang_effect_path = "20220930/yuansushixitong/fx_ui_yssxt_huok.prefab"
	elseif self.curRace == GameEnum.RaceType.Guang then
		kuang_effect_path = "20220930/yuansushixitong/fx_ui_yssxt_guangk.prefab"
	elseif self.curRace == GameEnum.RaceType.An then
		kuang_effect_path = "20220930/yuansushixitong/fx_ui_yssxt_ank.prefab"
	elseif self.curRace == GameEnum.RaceType.Kong then
		kuang_effect_path = "20220930/yuansushixitong/fx_ui_yssxt_kongk.prefab"
	elseif self.curRace == GameEnum.RaceType.Chuang then
		kuang_effect_path = "20220930/yuansushixitong/fx_ui_yssxt_chuangk.prefab"
	elseif self.curRace == GameEnum.RaceType.Yuan then
		kuang_effect_path = "20220930/yuansushixitong/fx_ui_yssxt_shuik.prefab"
	end

	if kuang_effect_path then
		local parentGo = self._imageGo.gameObject
		local effect2 = UIEffectManager.instance:playEffect(view, kuang_effect_path, parentGo.transform, 0, 0, true, false)

		effect2:setParent(parentGo.transform)
		effect2:setScale(scale)
		effect2:setSortingOrder(195)
		effect2:setLocalPos(0, 7, 0)

		effect2.hideEffWhileNotOnTop = false
		self._elementSkillKuangEff = effect2
	end
end

function ItemSeat:removeElementSkillEffect()
	if self._elementSkillEff then
		UIEffectManager.instance:stopEffect(self._elementSkillEff)
	end

	self._elementSkillEff = nil

	if self._elementSkillKuangEff then
		UIEffectManager.instance:stopEffect(self._elementSkillKuangEff)
	end

	self._elementSkillKuangEff = nil
end

function ItemSeat:playFixedEffect(view, path, scale)
	if scale == nil then
		scale = 1
	end

	self:removeFixedEffect()

	if not string.nilorempty(path) then
		local parentGo = self._layerBgGo.gameObject
		local effect = UIEffectManager.instance:playEffect(view, path, parentGo.transform, 0, 0, true, false)

		effect:setParent(parentGo.transform)
		effect:setScale(scale)
		effect:setSortingOrder(195)
		effect:setLocalPos(0, 0, 0)

		effect.hideEffWhileNotOnTop = false
		self._fixedEffect = effect
	end
end

function ItemSeat:removeFixedEffect()
	if self._fixedEffect then
		UIEffectManager.instance:stopEffect(self._fixedEffect)
	end

	self._fixedEffect = nil
end

function ItemSeat:playYuanLimitEffect(view)
	self:removeYuanLimitEffect()

	local parentGo = self._ImgC_Forbid.gameObject
	local effectPath = "fx_ui_jinglinggezi/fx_ui_jinglinggezi_gai.prefab"
	local effect

	effect = UIEffectManager.instance:playEffect(view, effectPath, parentGo.transform, 0, 0, true, false, nil, function(target, eff)
		GoUtil.SetSortingOrder(effect.effGo, 195)
	end)

	effect:setParent(parentGo.transform)
	effect:setScale(0.8)

	effect.hideEffWhileNotOnTop = false
	self._yuanLimitEffect = effect
end

function ItemSeat:removeYuanLimitEffect()
	if self._yuanLimitEffect then
		UIEffectManager.instance:stopEffect(self._yuanLimitEffect)

		self._yuanLimitEffect = nil
	end
end

function ItemSeat:playDropEffect(view)
	self:_removeDropEffect()

	local parentGo = self._ImgC_Forbid.gameObject
	local effectPath = "fx_ui_jinglinggezi/fx_ui_buzhen_03.prefab"

	local function finishHandler()
		self:_removeDropEffect()
	end

	local effect = UIEffectManager.instance:playEffect(view, effectPath, parentGo.transform, 0, 0, true, false)

	effect:setParent(parentGo.transform)
	effect:setScale(1)

	effect.hideEffWhileNotOnTop = false

	TweenUtil.DoDelay(1.5, finishHandler)

	self._dropEffect = effect
end

function ItemSeat:_removeDropEffect()
	if self._dropEffect then
		UIEffectManager.instance:stopEffect(self._dropEffect)

		self._dropEffect = nil
	end
end

function ItemSeat:_getHeroSkillEffctPath(index, raceType)
	local suffixIndexs = {
		"1",
		"2",
		"quan"
	}
	local prefix = "fx_ui_yingxiongji"
	local suffix = "shui"

	if raceType == GameEnum.RaceType.Cao then
		suffix = "cao"
	elseif raceType == GameEnum.RaceType.Shui then
		suffix = "shui"
	elseif raceType == GameEnum.RaceType.Huo then
		suffix = "huo"
	elseif raceType == GameEnum.RaceType.Guang then
		suffix = "guang"
	elseif raceType == GameEnum.RaceType.An then
		suffix = "an"
	elseif raceType == GameEnum.RaceType.Kong then
		suffix = "kong"
	elseif raceType == GameEnum.RaceType.Chuang then
		suffix = "chuang"
	elseif raceType == GameEnum.RaceType.Yuan then
		suffix = "shui"
	end

	local format = "fx_ui_jinglinggezi/%s.prefab"

	return (string.format(format, prefix .. "_" .. suffix .. "_" .. suffixIndexs[index]))
end

function ItemSeat:playChangeHeroSkillEffect(raceId, view, isHaveBuff, raceMap)
	self:removeChangeHeroSkillEffect()

	if self.petId <= 0 then
		return
	end

	local bagPetMo = self:_getPet(self.petId)

	if not bagPetMo then
		return
	end

	local cfgPet = CharacterConfig.instance:getPetCo(raceId)

	if not cfgPet then
		return
	end

	local raceType = 1

	if raceMap and raceMap[bagPetMo.petId] then
		raceType = raceMap[bagPetMo.petId]
	else
		local eleAttr = PetSkinConfig.instance:getAllElementAttrs(bagPetMo.curFaceId) or {}
		local firstEleKey = eleAttr[1]

		raceType = GameEnum.Races[firstEleKey]
	end

	local parentGo = self._ImgC_Forbid.gameObject

	if bagPetMo.raceId == raceId then
		local effectPath1 = self:_getHeroSkillEffctPath(1, raceType)
		local effect1 = UIEffectManager.instance:playEffect(view, effectPath1, parentGo.transform, 0, 0, true, false)

		effect1:setParent(parentGo.transform)
		effect1:setScale(1)

		effect1.hideEffWhileNotOnTop = false
		self._changeHeroSkillEffect1 = effect1

		local effectPath3 = self:_getHeroSkillEffctPath(3, raceType)
		local effect3 = UIEffectManager.instance:playEffect(view, effectPath3, parentGo.transform, 0, 0, true, false)

		effect3:setParent(parentGo.transform)
		effect3:setScale(1)
		effect3:setSortingOrder(191)

		effect3.hideEffWhileNotOnTop = false
		self._changeHeroSkillEffect3 = effect3
	end

	if isHaveBuff then
		local effectPath2 = self:_getHeroSkillEffctPath(2, raceType)
		local effect2 = UIEffectManager.instance:playEffect(view, effectPath2, parentGo.transform, 0, 0, true, false)

		effect2:setParent(parentGo.transform)
		effect2:setScale(1)

		effect2.hideEffWhileNotOnTop = false
		self._changeHeroSkillEffect2 = effect2
	end
end

function ItemSeat:removeChangeHeroSkillEffect()
	if self._changeHeroSkillEffect1 then
		UIEffectManager.instance:stopEffect(self._changeHeroSkillEffect1)

		self._changeHeroSkillEffect1 = nil
	end

	if self._changeHeroSkillEffect2 then
		UIEffectManager.instance:stopEffect(self._changeHeroSkillEffect2)

		self._changeHeroSkillEffect2 = nil
	end

	if self._changeHeroSkillEffect3 then
		UIEffectManager.instance:stopEffect(self._changeHeroSkillEffect3)

		self._changeHeroSkillEffect3 = nil
	end
end

function ItemSeat:initRecPosItem(prefabGo)
	if not self._layerBgGo then
		return
	end

	self._recPosGo = goutil.cloneAndSetParent(prefabGo, self._layerBgGo.transform, prefabGo.name)
	self._recommendPos = goutil.findChild(self._recPosGo, "recommendPos")
	self._otherPos = goutil.findChild(self._recPosGo, "otherPos")
	self._txtRecPos = goutil.findChild(self._recPosGo, "txtRecPos"):GetComponent(goutil.Type_UIText)

	goutil.setActive(self._recPosGo, false)
end

function ItemSeat:_removeRecPosItem()
	goutil.destroy(self._recPosGo)

	self._recPosGo = nil
	self._otherPos = nil
	self._txtRecPos = nil
end

function ItemSeat:setRecPosIsOpen(isOpen)
	if self._recPosGo then
		self._recPosGo:SetActive(isOpen)
	end
end

function ItemSeat:setRecPosState(raceId)
	if not self._recPosGo then
		return
	end

	local cfg = CharacterConfig.instance:getPetInfoCo(raceId)

	if not cfg then
		return
	end

	local posIndex = self._index
	local frontIndex = 3
	local isFront = posIndex <= frontIndex

	if cfg.bestPosition == "前排" then
		goutil.setActive(self._recommendPos, isFront)
		goutil.setActive(self._otherPos, not isFront)

		self._txtRecPos.text = isFront and "推荐站位" or "后排站位"
	else
		goutil.setActive(self._recommendPos, not isFront)
		goutil.setActive(self._otherPos, isFront)

		self._txtRecPos.text = not isFront and "推荐站位" or "前排站位"
	end
end

function ItemSeat:initAtkSelfItem(prefabGo)
	local atkSelfItem = AtkSelfItem.New()

	atkSelfItem:init(self._layerUI, prefabGo)

	self._atkSelfItem = atkSelfItem
end

function ItemSeat:_removeAtkSelfItem()
	if self._atkSelfItem then
		self._atkSelfItem:destroy()

		self._atkSelfItem = nil
	end
end

function ItemSeat:setAtkSelfItemIsOpen(isOpen)
	if self._atkSelfItem then
		self._atkSelfItem:setIsOpen(isOpen)
		goutil.setActive(self._layerUI, self:getTempPetId() > 0 or isOpen)
	end
end

function ItemSeat:_getPet(petId)
	if self._petMo and checknumber(petId) == checknumber(self._petMo.petId) then
		return self._petMo
	end

	return nil
end

function ItemSeat:_getCurFormId()
	return FormationNewModel.instance:GetCurFormId()
end

return ItemSeat
