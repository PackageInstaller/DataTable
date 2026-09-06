-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/saintknightrui/controller/SaintKnightRuiController.lua

module("logic.extensions.saintknightrui.controller.SaintKnightRuiController", package.seeall)

local SaintKnightRuiController = class("SaintKnightRuiController", BaseController)

function SaintKnightRuiController:ctor()
	return
end

function SaintKnightRuiController:onInit()
	return
end

function SaintKnightRuiController:playAnim(path)
	local key = SaintKnightRuiModel.KeyAnim1

	GameUtil.getUserData(key, function(value)
		if checknumber(value) == 0 then
			ViewBlockMgr.instance:blockClick(true, self)
			AnimationPlayer.play(path, function()
				ViewBlockMgr.instance:blockClick(false, self)
			end)
			GameUtil.saveUserData(key, 1)
		end
	end)
end

function SaintKnightRuiController:playStoryInChallengeView(storyId)
	local key = SaintKnightRuiModel.KeyStory1

	GameUtil.getUserData(key, function(value)
		if checknumber(value) == 0 then
			if storyId > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
			end

			GameUtil.saveUserData(key, 1)
		end
	end)
end

function SaintKnightRuiController:playStoryInGameView(storyId)
	local key = SaintKnightRuiModel.KeyStory2

	GameUtil.getUserData(key, function(value)
		if checknumber(value) == 0 then
			if storyId > 0 then
				GlobalDispatcher:dispatch(GlobalNotify.StartStory, storyId)
			end

			GameUtil.saveUserData(key, 1)
		end
	end)
end

SaintKnightRuiController.instance = SaintKnightRuiController.New()

return SaintKnightRuiController
