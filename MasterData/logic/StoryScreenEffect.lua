-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/effects/StoryScreenEffect.lua

module("logic.extensions.story.view.effects.StoryScreenEffect", package.seeall)

local StoryScreenEffect = class("StoryScreenEffect")

function StoryScreenEffect:ctor(view, node, uiCamera)
	self._view = view
	self.mainGO = node
	self._uiCamera = uiCamera
end

function StoryScreenEffect:onEnter()
	return
end

function StoryScreenEffect:onExit()
	return
end

function StoryScreenEffect:setLoadedCallback(callback, target)
	self._loadedCallback = callback
	self._loadedCallbackTarget = target
end

function StoryScreenEffect:playEffect(path)
	return
end

function StoryScreenEffect:isLoadingRes()
	return
end

function StoryScreenEffect:stopEffect()
	return
end

return StoryScreenEffect
