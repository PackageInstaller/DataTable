-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/effects/StoryScreenEffectRed.lua

module("logic.extensions.story.view.effects.StoryScreenEffectRed", package.seeall)

local StoryScreenEffectRed = class("StoryScreenEffectRed", StoryScreenEffect)

function StoryScreenEffectRed:onEnter()
	self.mainGO:SetActive(false)
end

function StoryScreenEffectRed:onExit()
	return
end

function StoryScreenEffectRed:playEffect(path)
	self.mainGO:SetActive(true)
end

function StoryScreenEffectRed:stopEffect()
	self.mainGO:SetActive(false)
end

return StoryScreenEffectRed
