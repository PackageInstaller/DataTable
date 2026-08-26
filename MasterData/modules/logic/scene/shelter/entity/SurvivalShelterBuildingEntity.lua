-- chunkname: @modules/logic/scene/shelter/entity/SurvivalShelterBuildingEntity.lua

module("modules.logic.scene.shelter.entity.SurvivalShelterBuildingEntity", package.seeall)

local SurvivalShelterBuildingEntity = class("SurvivalShelterBuildingEntity", SurvivalShelterUnitEntity)

function SurvivalShelterBuildingEntity.Create(unitType, unitId, root)
	local mapCo = SurvivalConfig.instance:getShelterMapCo()
	local buildingCo = mapCo:getBuildingById(unitId)
	local go = gohelper.create3d(root, tostring(buildingCo.pos))
	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(buildingCo.pos.q, buildingCo.pos.r)
	local rootTrans = go.transform

	transformhelper.setLocalPos(rootTrans, x, y, z)
	transformhelper.setLocalRotation(rootTrans, 0, buildingCo.dir * 60, 0)

	local param = {
		unitType = unitType,
		unitId = unitId,
		buildingCo = buildingCo
	}

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalShelterBuildingEntity, param)
end

function SurvivalShelterBuildingEntity:onCtor(param)
	self.buildingCo = param.buildingCo
	self.pos = self.buildingCo.pos
end

function SurvivalShelterBuildingEntity:onStart()
	self.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function SurvivalShelterBuildingEntity:onInit()
	self:showModel()
end

function SurvivalShelterBuildingEntity:showModel()
	if not gohelper.isNil(self.goModel) then
		return
	end

	if self._loader then
		return
	end

	self._loader = MultiAbLoader.New()

	local path, ruinsPath = self:getResPath()

	self._loader:addPath(path)

	if ruinsPath then
		self._loader:addPath(ruinsPath)
	end

	self._loader:startLoad(self._onResLoadEnd, self)
end

function SurvivalShelterBuildingEntity:getResPath()
	local buildingConfig = SurvivalConfig.instance:getBuildingConfig(self.buildingCo.cfgId, 1)

	return self.buildingCo.assetPath, not string.nilorempty(buildingConfig.ruins) and string.format("survival/buiding/v2a8/%s.prefab", buildingConfig.ruins)
end

function SurvivalShelterBuildingEntity:_onResLoadEnd()
	local path, ruinsPath = self:getResPath()
	local assetItem = self._loader:getAssetItem(path)

	if assetItem then
		local obj = assetItem:GetResource(path)

		self.goModel = gohelper.clone(obj, self.go, "model")

		self:initTrans(self.goModel.transform)
	end

	if ruinsPath then
		assetItem = self._loader:getAssetItem(ruinsPath)

		if assetItem then
			local obj = assetItem:GetResource(ruinsPath)

			self.goRuins = gohelper.clone(obj, self.go, "ruins")

			self:initTrans(self.goRuins.transform)
		end
	end

	if self.buildingCo:isCollection() then
		local scene = SurvivalMapHelper.instance:getScene()
		local mo = SurvivalHandbookModel.instance:getHandbookByCollectionBuild(self.buildingCo.cfgId)
		local itemMo = mo:getSurvivalBagItemMo()
		local iconPath = ResUrl.getSurvivalItemIcon(itemMo.co.icon)
		local texture = scene.preloader:getRes(iconPath)
		local materialGO = gohelper.findChild(self.goModel, "anim/survival_icon_a")

		if materialGO and texture then
			local renderer = materialGO:GetComponent(typeof(UnityEngine.MeshRenderer))

			if renderer then
				renderer.material:SetTexture("_MainTex", texture)
			end
		end
	end

	self:onLoadedEnd()
end

function SurvivalShelterBuildingEntity:initTrans(trans)
	transformhelper.setLocalRotation(trans, 0, 0, 0)
	transformhelper.setLocalScale(trans, 1, 1, 1)
end

function SurvivalShelterBuildingEntity:canShow()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfo(self.unitId)

	if not buildingInfo then
		return true
	end

	return buildingInfo and buildingInfo:isBuild() or false
end

function SurvivalShelterBuildingEntity:setVisible(isVisible, force)
	if self._isVisible == isVisible and not force then
		return
	end

	self._isVisible = isVisible

	gohelper.setActive(self.goModel, self._isVisible)
	gohelper.setActive(self.goRuins, not self._isVisible)
	self:onChangeEntity()
end

function SurvivalShelterBuildingEntity:checkClick(hexPoint)
	return self.buildingCo:isInRange(hexPoint)
end

function SurvivalShelterBuildingEntity:needUI()
	return true
end

function SurvivalShelterBuildingEntity:getCenterPos()
	local ponitRange = self.buildingCo.ponitRange
	local sumX, sumY, sumZ = 0, 0, 0
	local count = 0

	for q, vv in pairs(ponitRange) do
		for r, ponit in pairs(vv) do
			local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(ponit.q, ponit.r)

			sumX = sumX + x
			sumY = sumY + y
			sumZ = sumZ + z
			count = count + 1
		end
	end

	if count > 0 then
		local averageX = sumX / count
		local averageY = sumY / count
		local averageZ = sumZ / count

		return averageX, averageY, averageZ
	end

	return 0, 0, 0
end

function SurvivalShelterBuildingEntity:showBuildEffect()
	ViewMgr.instance:closeAllPopupViews()

	local x, y, z = self:getCenterPos()

	SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, Vector3(x, y, z), 0.5, self._showBuildEffect, self)
end

function SurvivalShelterBuildingEntity:_showBuildEffect()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfo(self.unitId)

	if not buildingInfo then
		return
	end

	local isLevup = buildingInfo.level > 1

	self._effectDelayTime = 1

	if isLevup then
		self._effectAudioId = AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_transmit or AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_build
	end

	if isLevup then
		if not SurvivalConst.UnitEffectPath.Transfer2 then
			local effectPath = SurvivalConst.UnitEffectPath.CreateUnit

			self:loadEffect(effectPath)
		end
	end
end

function SurvivalShelterBuildingEntity:loadEffect(effectPath)
	if not self.buildEffect then
		local x, y, z = self:getCenterPos()
		local go = gohelper.create3d(self.go, "effect")

		transformhelper.setPos(go.transform, x, 0, z)
		transformhelper.setEulerAngles(go.transform, 0, 0, 0)

		self.buildEffect = PrefabInstantiate.Create(go)
	else
		self.buildEffect:dispose()
	end

	self.buildEffect:startLoad(effectPath, self._onBuildEffectLoaded, self)
end

function SurvivalShelterBuildingEntity:_onBuildEffectLoaded()
	if self._effectAudioId then
		AudioMgr.instance:trigger(self._effectAudioId)
	end

	if self._effectDelayTime then
		TaskDispatcher.runDelay(self._onBuildEffectPlayFinish, self, self._effectDelayTime)
	else
		self:_onBuildEffectPlayFinish()
	end
end

function SurvivalShelterBuildingEntity:_onBuildEffectPlayFinish()
	self._effectDelayTime = nil

	if self.buildEffect then
		self.buildEffect:dispose()
	end

	self:updateEntity(true)
end

function SurvivalShelterBuildingEntity:updateEntity(updateAll)
	if self._effectDelayTime then
		return
	end

	SurvivalShelterBuildingEntity.super.updateEntity(self, updateAll)
end

function SurvivalShelterBuildingEntity:onDestroy()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._effectDelayTime = nil

	TaskDispatcher.cancelTask(self._onBuildEffectPlayFinish, self)
	SurvivalShelterBuildingEntity.super.onDestroy(self)
end

return SurvivalShelterBuildingEntity
