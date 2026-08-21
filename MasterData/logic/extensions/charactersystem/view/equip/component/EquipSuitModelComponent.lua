-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/component/EquipSuitModelComponent.lua

module("logic.extensions.charactersystem.view.equip.component.EquipSuitModelComponent", package.seeall)

local M = class("EquipSuitModelComponent")

function M:ctor(imageContainer)
	self._compContainer = imageContainer
	self._loadedRefreshed = false
	self.modelScale = 0.3
	self.defaultYRotation = 220
	self._modelX = 0
	self._modelY = 0
	self._modelZ = 0

	self:build()
end

function M:build()
	self._equipModel = Astral.LuaComponentContainer.Add(self._compContainer.gameObject, EquipPhotoModel)

	self._equipModel:setModelLoadCallback(self._onModelLoaded, self)
	self._equipModel:setAttachEffectCallback(self._onAttachEffect, self)
	self._equipModel:updateResWithSize(ResName.Equip_model, nil, PhotoCacheMgr.SIZE_H_BLOCK, PhotoCacheMgr.SIZE_H_BLOCK, UnityEngine.RenderTextureFormat.ARGBHalf)
	self._equipModel:setCameraPosition(0, 0, -5.07)
	self._equipModel:setNeedAutoRotate(false, false)
	self._equipModel:setCameraPostProcessing(true, SceneLayer.UI3D_Value)
	self._equipModel:setCameraCullingLayer(SceneLayer.UI3D_Value)
	self._equipModel:setCameraTag("RTCamera")
end

function M:refreshView()
	if not self._heroData or not self._isLoaded then
		return
	end

	local equipHeroData = self._heroData:getHeroEquipData()
	local aniName = self._loadedRefreshed and self._aniNameOnIdle or self._aniNameOnLoad
	local loop = self._loadedRefreshed

	for index = 1, EquipEnum.MaxPartType do
		local equipMo = equipHeroData:getEquipByPart(EquipEnum.PartTypeList[index])

		self:_refreshOneEquip(index, equipMo, aniName, loop)
	end

	self._equipModel:setTargetRotationY(self.defaultYRotation)

	self._loadedRefreshed = true
end

function M:_refreshOneEquip(index, equipMo, aniName, loop)
	self._equipModel:clearAttachEffect(index)

	if not equipMo then
		return
	end

	local name = GameUrl.getEquipMeshModelUrl(equipMo:getModelId())

	self._equipModel:attachEffect(index, name, aniName, loop)
end

function M:setHeroData(heroData)
	self._heroData = heroData

	self:refreshView()
end

function M:_onModelLoaded()
	self._isLoaded = true

	self:refreshView()
	self._equipModel:setLocalScale(self.modelScale)
	self._equipModel:setTargetPos(self._modelX, self._modelY, self._modelZ)
end

function M:_onAttachEffect(inst, aniName, loop, index)
	if not inst then
		return
	end

	if aniName then
		local aniPlayer = AnimationPlayer.Get(inst)

		if aniPlayer then
			if aniName == "merge" and self.onMergeAniEnd then
				settimer(0.6, self.onMergeAniEnd, self, false)
			end

			aniPlayer:PlayAnimation(aniName, loop, true)

			if self._aniNameOnLoad and aniName == self._aniNameOnLoad then
				aniPlayer:SetListener(function(self)
					aniPlayer:RemoveListener()
					aniPlayer:PlayAnimation(self._aniNameOnIdle, true, true)
				end, self)
			end
		end
	end

	goutil.setActive(inst, true)
end

function M:onEnter()
	LightMgr.instance:turnOn(LightName.UIEquip)
	VolumeMgr.instance:turnOn(VolumeName.UIJiaoshiqi)
	VolumeMgr.instance:setPosition(VolumeName.UIJiaoshiqi, self._equipModel:getCameraPosition())
end

function M:onExit()
	self._loadedRefreshed = false

	if not ViewMgr.instance:isOpen(ViewName.ChangeEquip) and not ViewMgr.instance:isOpen(ViewName.EquipIntensifyAndDetailView) then
		LightMgr.instance:turnOff(LightName.UIEquip)
		VolumeMgr.instance:turnOff(VolumeName.UIJiaoshiqi)
	end
end

function M:setEquipAniName(loadName, idelName)
	self._aniNameOnLoad = loadName
	self._aniNameOnIdle = idelName
end

return M
