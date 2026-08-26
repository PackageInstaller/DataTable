-- chunkname: @modules/logic/story/view/heroEffs/StoryHeroEffsWaterWave.lua

module("modules.logic.story.view.heroEffs.StoryHeroEffsWaterWave", package.seeall)

local StoryHeroEffsWaterWave = class("StoryHeroEffsWaterWave", StoryHeroEffsBase)

function StoryHeroEffsWaterWave:ctor()
	StoryHeroEffsWaterWave.super.ctor(self)
end

function StoryHeroEffsWaterWave:init(go)
	StoryHeroEffsWaterWave.super.init(self)

	self._heroGo = go
	self._cubctrl = self._heroGo:GetComponent(typeof(ZProj.CubismController))

	if not self._cubctrl then
		self._spinePrefabPath = "ui/viewres/story/v3a5/rolewave_spine.prefab"
		self._spineMatPath = "ui/materials/dynamic/spine_ui_noise.mat"

		table.insert(self._resList, self._spinePrefabPath)
		table.insert(self._resList, self._spineMatPath)
	else
		self._live2dPrefabPath = "ui/viewres/story/v3a5/rolewave_l2d.prefab"

		table.insert(self._resList, self._live2dPrefabPath)
	end
end

function StoryHeroEffsWaterWave:start(callback, callbackObj)
	StoryHeroEffsWaterWave.super.start(self)
	self:loadRes()
end

function StoryHeroEffsWaterWave:onLoadFinished()
	StoryHeroEffsWaterWave.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	if not self._cubctrl then
		self:_setSpineEff()
	else
		self:_setLive2dEff()
	end
end

function StoryHeroEffsWaterWave:_setSpineEff()
	local prefabAssetItem = self._loader:getAssetItem(self._spinePrefabPath)

	self._effGo = gohelper.clone(prefabAssetItem:GetResource(), self._heroGo.transform.gameObject)

	local wavemat = self._loader:getAssetItem(self._spineMatPath):GetResource(self._spineMatPath)
	local sg = self._heroGo:GetComponent(GuiSpine.TypeSkeletonGraphic)

	sg.material = wavemat
end

function StoryHeroEffsWaterWave:_setLive2dEff()
	local prefabAssetItem = self._loader:getAssetItem(self._live2dPrefabPath)

	self._effGo = gohelper.clone(prefabAssetItem:GetResource(), self._heroGo.transform.gameObject)

	local matPropsCtrl = self._effGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	matPropsCtrl.mas:Clear()

	for i = 0, self._cubctrl.InstancedMaterials.Length - 1 do
		matPropsCtrl.mas:Add(self._cubctrl.InstancedMaterials[i])
	end
end

function StoryHeroEffsWaterWave:destroy()
	if self._effGo then
		gohelper.destroy(self._effGo)

		self._effGo = nil
	end

	StoryHeroEffsWaterWave.super.destroy(self)
end

return StoryHeroEffsWaterWave
