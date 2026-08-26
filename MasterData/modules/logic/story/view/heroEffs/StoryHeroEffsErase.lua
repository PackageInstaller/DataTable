-- chunkname: @modules/logic/story/view/heroEffs/StoryHeroEffsErase.lua

module("modules.logic.story.view.heroEffs.StoryHeroEffsErase", package.seeall)

local StoryHeroEffsErase = class("StoryHeroEffsErase", StoryHeroEffsBase)

function StoryHeroEffsErase:ctor()
	StoryHeroEffsErase.super.ctor(self)
end

function StoryHeroEffsErase:init(go, heroSpine)
	StoryHeroEffsErase.super.init(self)

	self._heroGo = go
	self._heroSpine = heroSpine
	self._cubctrl = self._heroGo:GetComponent(typeof(ZProj.CubismController))

	if not self._cubctrl then
		self._spinePrefabPath = "ui/viewres/story/v3a5/roleerase_spine.prefab"
		self._spineMatPath = "ui/materials/dynamic/spine_ui_erase.mat"

		table.insert(self._resList, self._spinePrefabPath)
		table.insert(self._resList, self._spineMatPath)
	else
		self._live2dPrefabPath = "ui/viewres/story/v3a5/roleerase_l2d.prefab"

		table.insert(self._resList, self._live2dPrefabPath)
	end
end

function StoryHeroEffsErase:start(eraseParam, callback, callbackObj)
	self._param = eraseParam or 0

	StoryHeroEffsErase.super.start(self)
	self:loadRes()
end

function StoryHeroEffsErase:onLoadFinished()
	StoryHeroEffsErase.super.onLoadFinished(self)
	StoryTool.enablePostProcess(true)

	self._blitEff = StoryViewMgr.instance:getStoryBlitEff()

	if not self._cubctrl then
		self:_setSpineEff()
	else
		self:_setLive2dEff()
	end

	self._anim:SetBool("isOut", false)
	self._anim:SetBool("isEnd", false)
	self._anim:Play("in", 0, 0)
end

function StoryHeroEffsErase:_setSpineEff()
	local prefabAssetItem = self._loader:getAssetItem(self._spinePrefabPath)

	self._effGo = self._effGo or gohelper.clone(prefabAssetItem:GetResource(), self._heroGo.transform.gameObject)

	if not self._waveMat then
		local waveMat = self._loader:getAssetItem(self._spineMatPath):GetResource(self._spineMatPath)

		self._waveMat = UnityEngine.Object.Instantiate(waveMat)
	end

	local sg = self._heroGo:GetComponent(GuiSpine.TypeSkeletonGraphic)

	sg.material = self._waveMat

	sg.material:SetTexture("_SceneMask", self._blitEff.capturedTexture)

	if not self._anim then
		self._anim = gohelper.findChildComponent(self._effGo, "setmatprop", typeof(UnityEngine.Animator))

		local matPropsCtrl = self._anim:GetComponent(typeof(ZProj.MaterialPropsCtrl))

		matPropsCtrl.mas:Clear()
		matPropsCtrl.mas:Add(self._waveMat)

		self._posImg = gohelper.findChildImage(self._effGo, "setrectpos")
		self._posImg.material = self._waveMat
	end
end

function StoryHeroEffsErase:_setLive2dEff()
	local prefabAssetItem = self._loader:getAssetItem(self._live2dPrefabPath)

	self._effGo = self._effGo or gohelper.clone(prefabAssetItem:GetResource(), self._heroGo.transform.gameObject)

	local matPropsCtrl = self._effGo:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	matPropsCtrl.mas:Clear()

	for i = 0, self._cubctrl.InstancedMaterials.Length - 1 do
		local mat = self._cubctrl.InstancedMaterials[i]

		matPropsCtrl.mas:Add(mat)
	end

	self._heroSpine:setSceneTexture(self._blitEff.capturedTexture)

	self._anim = self._anim or gohelper.onceAddComponent(self._effGo, typeof(UnityEngine.Animator))
end

function StoryHeroEffsErase:reset(eraseParam)
	local param = eraseParam or 0

	if param == self._param or param == 0 then
		return
	end

	self._param = eraseParam

	if not self._cubctrl then
		self:_setSpineEff()
	else
		self:_setLive2dEff()
	end

	if self._anim then
		self._anim:SetBool("isOut", true)
	end
end

function StoryHeroEffsErase:destroy()
	if self._anim then
		self._anim:SetBool("isEnd", true)
	end

	if self._effGo then
		gohelper.destroy(self._effGo)

		self._effGo = nil
	end

	StoryHeroEffsErase.super.destroy(self)
end

return StoryHeroEffsErase
