-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewmain/BattleLeftRoleView.lua

module("logic.extensions.battle.viewmain.BattleLeftRoleView", package.seeall)

local M = class("BattleLeftRoleView", ViewComponent)
local kMaterialDefaultKey = "leftRole"
local kShadowModelCode = -99
local kShadowResourceUrl = "effect3d/prefab/terrain/scene_humanshadow_1.prefab"

function M:buildUI()
	self._photoPanelGo = goutil.findChild(self.mainGO, "CharacterPanel")
	self._inVisibleState = GameObjectVisibleState.New()
	self.mainGO = goutil.findChild(self.mainGO, "CharacterPanel/CharacterImg")
	self._canvasGroup = self.mainGO:GetComponent(ComponentType.CanvasGroup)
	self._rawImg = self.mainGO:GetComponent(UIComponentType.RawImage)
	self._photoUnit = Astral.LuaComponentContainer.Add(self._rawImg.gameObject, BattlePhotoModel)

	self._photoUnit:setModelsLoadedCallback(self._onModelsLoaded, self)
	self._photoUnit:setPhotoCreateCallBack(self._onPhotoCreate, self)
	self._photoUnit:turnOnCamera()

	self._lightGo = self:getResInstance(BattleResourceName.HeroUI3dLight)

	SceneUtil.moveGameObjectToBaseScene(self._lightGo)

	self._isRtInMainView = true
	self._animation = self.mainGO:GetComponent(ComponentType.Animation)
end

function M:_setEvents(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.SCREEN_ADAPTER_UPDATE, self._updateRtAdapter, self)
		BattleDispatcher:addEventListener(BattleEventType.OnPosEditorUpdate, self._onEditorUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SCREEN_ADAPTER_UPDATE, self._updateRtAdapter, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnPosEditorUpdate, self._onEditorUpdate, self)
	end
end

function M:onEnter()
	self._materialUrl = false
	self._modelLoaded = false

	self:_setEvents(true)
	self:_updateRtAdapter()
end

function M:_updateRtAdapter()
	local offset = MainSettingModel.instance:getAdaptationOffsetWidth()

	Astral.TransformUtil.SetAnchoredPos(self.mainGO.transform, -offset, 0)
end

function M:setVisible(status, key)
	local preStatus = self._inVisibleState:isEnable()

	self._inVisibleState:setEnable(key, not status)

	local playAnim = self._inVisibleState:isEnable() ~= preStatus

	self:_updateVisible(playAnim)
end

function M:_updateVisible(playAnim)
	local unActive = self._inVisibleState:isEnable()

	goutil.setActive(self.mainGO, not unActive)
	goutil.setActive(self._lightGo, not unActive)
	self._animation:Stop()

	if playAnim then
		self._animation:Play("characterlmg_anim")
	elseif not unActive then
		self._canvasGroup.alpha = 1
	end

	if not unActive then
		self:_forceUpdate()
	end

	BattleDispatcher:dispatchEvent(BattleEventType.MaterialVisibleUpdate, not unActive, kMaterialDefaultKey)
end

function M:_tryPlayAn_imation()
	return
end

function M:_forceUpdate()
	self._photoUnit:forceUpdate()
end

function M:_checkSameUnit(modelCode, unit)
	if self._modelCode ~= modelCode then
		return false
	end

	if self._unit ~= unit then
		return false
	end

	return true
end

function M:showUnit(modelCode, unit, key, isCompare)
	local isShadow = false
	local isCompareChanged = self._isCompare ~= isCompare

	self._isCompare = isCompare

	self:_checkRtParent()

	local modelCO = ModelConfig.instance:getModelConfig(modelCode)

	if not modelCO.showModelInBattleUI then
		modelCode = kShadowModelCode
		isShadow = true
	end

	if self:_checkSameUnit(modelCode, unit) then
		local unActive = self._inVisibleState:isEnable()

		self._inVisibleState:setEnable(key, false)

		if isCompareChanged then
			self:_setHeroPos(unActive)
		elseif unActive then
			self:_playAnimation(self._currentAnimation)
		end

		self:_updateVisible()

		return
	end

	self:_clearModel()

	self._unit = unit
	self._modelCode = modelCode

	self._inVisibleState:setEnable(key, false)

	local url = isShadow and kShadowResourceUrl or ModelCOUtil.getHighModelUrl(modelCO)
	local animations = BattleTableUtil.getTempList()

	self:_getPreloadAnimations(self._modelCode, animations)
	self._photoUnit:showModel(url, animations)
	BattleTableUtil.releaseTempList(animations)
end

function M:_checkUpdateAnimation()
	local unActive = self._inVisibleState:isEnable()

	return unActive
end

function M:_checkRtParent()
	local model = BattleMgr.instance:getModel()

	if model:getPhase() == BattleEnum.Phase.READY and self._isRtInMainView then
		local adjustPhotoGo = BattleCampAdjustmentViewFacade.instance:getHeroPhotoPanelGo()

		if adjustPhotoGo then
			self._isRtInMainView = false

			self:_addRtToParent(adjustPhotoGo)
		end
	elseif model:getPhase() == BattleEnum.Phase.NORMAL and not self._isRtInMainView then
		self._isRtInMainView = true

		self:_addRtToParent(self._photoPanelGo)
	end

	self:_updateMaterial()
end

function M:_onModelsLoaded()
	self._modelLoaded = true

	self:_addMaterialAndEffect()

	local modelGo = self._photoUnit:getModelInst()

	Astral.GameObjectUtil.SetLayerRecursively(modelGo, SceneLayer.UI3D_Value)
	self:_setHeroPos(true)
	self:_updateVisible(true)
end

function M:_addMaterialAndEffect()
	if not self._unit then
		return
	end

	local modelGo = self._photoUnit:getModelInst()
	local materialUrl = BattleUnitUtil.getAddMaterialUrl(self._unit)

	if materialUrl then
		local materialSwitcher = MaterialSwitcher.Get(modelGo)

		materialSwitcher:SetGameObject(modelGo)
		materialSwitcher:AddSharedMaterialByUrl(materialUrl)
	end

	local effectCode

	if self._unit.property:getMonsterType() == BattleEnum.MonsterType.ELITE then
		effectCode = BattleConst.ELITE_ENEMY_EFFECT
	end

	local entityCode = self._unit.property:getEntityCode()

	if BattleUnitUtil.isMonster(self._unit) then
		local monsterCO = MonsterConfig.instance:getMonsterCO(entityCode)

		if monsterCO.bodyEffect == "ma_common_body_40002_red" then
			effectCode = BattleConst.BOSS_COVERED_BURN_EFFECT
		end
	end

	if effectCode then
		self._effectUnit = EffectUtil.playEffectWithClass(effectCode, EffectUnit, self:getModelContainer())

		local effectCO = EffectConfig.instance:getEffectCO(effectCode)

		if effectCO and effectCO.attachToMesh == 1 then
			local effectGo = self._effectUnit.loader:getInst()

			if effectGo then
				self:_onAttachEffectResLoaded(effectGo)
			else
				self._effectUnit.loader:setListener(self._onAttachEffectResLoaded, self)
			end
		end
	end
end

function M:_onAttachEffectResLoaded(effectGo)
	local bodyGo = GameObjectUtils.FindGameObjectWithTag(self._photoUnit:getModelInst(), SceneTag.CommonGamePlay)

	if bodyGo then
		local bodyMesh = bodyGo:GetComponent("SkinnedMeshRenderer")

		if bodyMesh then
			SpaceX.ParticleUtils.BindShapeSkinMeshRender(effectGo, bodyMesh)
		end
	end
end

function M:_onPhotoCreate()
	self._photoUnit:setCameraPosition(0, 0, -4)

	local photo = self._photoUnit:getPhoto()

	PhotoBaseExtension.SetCameraFOV(photo, 20)
	self._photoUnit:setCameraCullingMask(Astral.LayerUtil.GetLayerMask(SceneLayer.UI3D))
	self._photoUnit:setCameraTag(SceneTag.RendererFeatureCamera)
	self._photoUnit:setCameraPostProcessing(true, SceneLayer.Default_Value)
end

function M:_setHeroPos(forceSet)
	if not self._modelLoaded then
		return
	end

	local modelContainerTrans = self:getModelContainer()
	local animation = "idle2"
	local coId = self._modelCode * 100 + (self._isCompare and 2 or 1)
	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.BattlePerformanceHeroPos, coId, true)

	if not cfg and self._isCompare then
		cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.BattlePerformanceHeroPos, self._modelCode * 100 + 1, true)
	end

	if cfg then
		local posInfo = cfg.posData
		local px, py, pz, rx, ry, rz, scale, scaleZ = posInfo[1], posInfo[2], posInfo[3], posInfo[4], posInfo[5], posInfo[6], posInfo[7], posInfo[8]
		local action = cfg.animation

		Astral.TransformUtil.SetLocalPos(modelContainerTrans, px, py, pz)
		Astral.TransformUtil.SetLocalRotation(modelContainerTrans, rx, ry, rz)
		TransformUtils.SetLocalScale(modelContainerTrans, scale, scale, scaleZ)

		animation = action
	else
		Astral.TransformUtil.SetLocalPos(modelContainerTrans, -0.425, -1.33, 0)
		Astral.TransformUtil.SetLocalRotation(modelContainerTrans, 0, 135, 0)
		TransformUtils.SetLocalScale(modelContainerTrans, 1, 1, 1)
	end

	if forceSet or self._currentAnimation ~= animation then
		self:_playAnimation(animation)
	end
end

function M:_getPreloadAnimations(modelCode, animations)
	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.BattlePerformanceHeroPos, modelCode * 100 + 1, true)

	if cfg then
		table.insert(animations, cfg.animation)
	end

	cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.BattlePerformanceHeroPos, modelCode * 100 + 2, true)

	if cfg then
		table.insert(animations, cfg.animation)
	end
end

function M:_playAnimation(anim)
	if self._modelCode == kShadowModelCode then
		return
	end

	self._currentAnimation = anim

	self._photoUnit:playAnimation(anim)
end

function M:updateRtForNormal()
	self:setVisible(false, "AdjustOperatorUnitInfo")
	self:_addRtToParent(self._photoPanelGo)
	self:_clearModel()
	self:_updateMaterial()
end

function M:_clearModel()
	if self._effectUnit then
		EffectUtil.destroyEffect(self._effectUnit)

		self._effectUnit = false
	end

	self._unit = false
	self._modelCode = false

	self._photoUnit:clearResource()

	self._modelLoaded = false
end

function M:_addRtToParent(parentGo)
	goutil.addChildToParent(self.mainGO, parentGo)
end

function M:_updateMaterial()
	local materialUrl

	if self._isRtInMainView then
		if self._isCompare then
			materialUrl = BattleResourceName.CharacterCompareMaskMaterial
		else
			materialUrl = BattleResourceName.CharacterMaskMaterial
		end
	else
		materialUrl = BattleResourceName.CharacterPreMaskMaterial
	end

	if self._materialUrl ~= materialUrl then
		self._materialUrl = materialUrl

		local resMgr = BattleMgr.instance:getResourceMgr()
		local material = resMgr:getMainAsset(materialUrl)

		self._rawImg.material = material
	end
end

function M:onExit()
	self:_clearModel()
	self:_setEvents(false)
end

function M:destroyUI()
	goutil.destroy(self._lightGo)
	self._photoUnit:destroy()
end

function M:_onEditorUpdate(_, key, param)
	if key == "switch" then
		self:showUnit(param)
	elseif key == "init" then
		self:_clearModel()
	elseif key == "anim" then
		self:_updateCurRolePos(param)
		self:_playAnimation(param)
	elseif key == "posIdx" then
		self:showUnit(self._modelCode, nil, param)
	end
end

function M:_updateCurRolePos(aniName)
	local isCompare = string.find(aniName, "react") ~= nil
	local modelContainerTrans = self:getModelContainer()
	local coId = self._modelCode * 100 + (isCompare and 2 or 1)
	local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.BattlePerformanceHeroPos, coId, true)

	if not cfg and isCompare then
		cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.BattlePerformanceHeroPos, self._modelCode * 100 + 1, true)
	end

	if cfg then
		local posInfo = cfg.posData
		local px, py, pz, rx, ry, rz, scale, scaleZ = posInfo[1], posInfo[2], posInfo[3], posInfo[4], posInfo[5], posInfo[6], posInfo[7], posInfo[8]

		Astral.TransformUtil.SetLocalPos(modelContainerTrans, px, py, pz)
		Astral.TransformUtil.SetLocalRotation(modelContainerTrans, rx, ry, rz)
		TransformUtils.SetLocalScale(modelContainerTrans, scale, scale, scaleZ)
	else
		Astral.TransformUtil.SetLocalPos(modelContainerTrans, -0.425, -1.33, 0)
		Astral.TransformUtil.SetLocalRotation(modelContainerTrans, 0, 135, 0)
		TransformUtils.SetLocalScale(modelContainerTrans, 1, 1, 1)
	end

	local materialUrl

	if self._isRtInMainView then
		if isCompare then
			materialUrl = BattleResourceName.CharacterCompareMaskMaterial
		else
			materialUrl = BattleResourceName.CharacterMaskMaterial
		end
	else
		materialUrl = BattleResourceName.CharacterPreMaskMaterial
	end

	if self._materialUrl ~= materialUrl then
		self._materialUrl = materialUrl

		local resMgr = BattleMgr.instance:getResourceMgr()
		local material = resMgr:getMainAsset(materialUrl)

		self._rawImg.material = material
	end
end

function M:getModelContainer()
	return self._photoUnit:getModelContainer()
end

return M
