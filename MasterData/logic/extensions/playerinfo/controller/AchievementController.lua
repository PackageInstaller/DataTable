-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/controller/AchievementController.lua

module("logic.extensions.playerinfo.controller.AchievementController", package.seeall)

local M = class("AchievementController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._refreshedOnEnterPlayInfoMainView = false

	GlobalDispatcher:addEventListener(EventType.PLAYER_INFO_MAIN_OPEN, self._onEnterPlayInfoMainView, self)
	GlobalDispatcher:addEventListener(EventType.PLAYER_INFO_MAIN_DESTROY, self._onQuitPlayInfoMainView, self)
end

function M:_onEnterPlayInfoMainView()
	if not self._refreshedOnEnterPlayInfoMainView then
		self._refreshedOnEnterPlayInfoMainView = true

		AchievementAgent.instance:sendGetAllAchievementRequest()
	end
end

function M:_onQuitPlayInfoMainView()
	self._refreshedOnEnterPlayInfoMainView = false
end

function M:setAchievementTabMo(achievementLabelMo)
	self._achievementTabMo = achievementLabelMo

	GlobalDispatcher:dispatchEvent(EventType.CHANGE_ACHIEVEMENT_TAB, self._achievementTabMo)

	local ids = achievementLabelMo:getAchievements()

	GlobalDispatcher:dispatchEvent(EventType.CHANGE_ACHIEVEMENTS_EVENT, ids)
end

M.instance = M.New()

return M
