-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonStoryGridShowView.lua

module("logic.extensions.season.view.SeasonStoryGridShowView", package.seeall)

local SeasonStoryGridShowView = class("SeasonStoryGridShowView", SeasonBaseGridShowView)

function SeasonStoryGridShowView:ctor()
	SeasonStoryGridShowView.super.ctor(self)
end

function SeasonStoryGridShowView:unbindEvents()
	SeasonStoryGridShowView.super.unbindEvents(self)
end

function SeasonStoryGridShowView:bindEvents()
	SeasonStoryGridShowView.super.bindEvents(self)
end

function SeasonStoryGridShowView:buildUI()
	SeasonStoryGridShowView.super.buildUI(self)

	self._puzzleIconGo = self:getGo("puzzle/icon")
	self._txtDesc = self:getTxt("txtDesc/Viewport/Content")
end

function SeasonStoryGridShowView:onExit()
	SeasonStoryGridShowView.super.onExit(self)
	MaterialMgr.resetAll(self._puzzleIconGo)
end

function SeasonStoryGridShowView:onEnter()
	SeasonStoryGridShowView.super.onEnter(self)

	local params = self:getFirstParam()
	local evtDetailConfig = params.evtDetailConfig

	if evtDetailConfig then
		local seasonId = SeasonModel.instance:getSeasonId()
		local fragmentId = evtDetailConfig.fragmentId

		if checknumber(fragmentId) > 0 then
			local cfg = SeasonConfig.instance:getSeasonFragmentConfig(seasonId, fragmentId)

			MaterialMgr.updateItemByStr(self._puzzleIconGo, cfg.fakeItem)
		end
	end
end

return SeasonStoryGridShowView
