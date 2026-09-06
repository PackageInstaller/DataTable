-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/story/view/story/StoryViewBattle.lua

module("logic.extensions.story.view.story.StoryViewBattle", package.seeall)

local StoryViewBattle = class("StoryViewBattle", StoryViewComponent)

function StoryViewBattle:_buildUI()
	StoryViewAnimation.super._buildUI(self)
	self.mainGO:SetActive(false)
end

function StoryViewBattle:onEnter()
	StoryViewBattle.super.onEnter(self)
end

function StoryViewBattle:prepareStory(currStory, finishCallback, finishCallbackTarget)
	TaskFacade.instance:requestEvEBattle(currStory.battle[1] or 0, currStory.battle[2] or 0)
	StoryModel.instance:setBattleStory(StoryModel.instance:getCurStory())
end

function StoryViewBattle:startFadeIn()
	return
end

function StoryViewBattle:startFadeOut()
	return
end

return StoryViewBattle
