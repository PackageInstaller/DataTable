-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/effects/StoryScreenEffectEffect.lua

module("logic.extensions.story.view.background.StoryScreenEffectEffect", package.seeall)

local StoryScreenEffectEffect = class("StoryScreenEffectEffect", StoryScreenEffect)

function StoryScreenEffectEffect:onEnter()
	self.mainGO:SetActive(false)
end

function StoryScreenEffectEffect:onExit()
	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end

	self:stopEffect()
end

function StoryScreenEffectEffect:playEffect(path)
	self.mainGO:SetActive(true)
	self:_showEffect(path)
end

function StoryScreenEffectEffect:stopEffect()
	self.mainGO:SetActive(false)

	self._resPath = nil

	if self._effectIns then
		goutil.destroy(self._effectIns, true)

		self._effectIns = nil
	end
end

function StoryScreenEffectEffect:_showEffect(effPath)
	self._resLoader = self._resLoader or MultiResLoader.New()
	self._isLoading = true

	self:stopEffect()

	self._resPath = StoryConst.StoryPath_Effects .. effPath

	self._resLoader:addResPath(self._resPath)

	self._resLoader.loadedCount = 0

	self._resLoader:load(self._onEffResourcesLoaded, nil, self)
end

function StoryScreenEffectEffect:_onEffResourcesLoaded(loader)
	local res = self._resLoader:getResource(self._resPath)
	local prefab = res:GetMainAsset()

	self._effectIns = goutil.clone(prefab)

	Framework.GameObjectUtil.SetLayerRecursively(self._effectIns, SceneLayer.UI1_Value)

	local x, y, z = UGUIToolHelper.UGUIToUnityPositionInCenter(self._uiCamera, self.mainGO:GetComponent("RectTransform"), nil, ofsX or 0, ofsY or 0, nil, nil, nil)

	Framework.TransformUtil.SetPos(self._effectIns.transform, x, y, self._uiCamera.nearClipPlane + 0.2)

	self._isLoading = nil

	if self._loadedCallback then
		if self._loadedCallbackTarget then
			self._loadedCallback(self._loadedCallbackTarget, self)
		else
			self:_loadedCallback()
		end
	end
end

function StoryScreenEffectEffect:isLoadingRes()
	return self._isLoading
end

return StoryScreenEffectEffect
