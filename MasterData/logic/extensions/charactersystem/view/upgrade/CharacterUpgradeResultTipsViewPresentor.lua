-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/upgrade/CharacterUpgradeResultTipsViewPresentor.lua

module("logic.extensions.charactersystem.view.upgrade.CharacterUpgradeResultTipsViewPresentor", package.seeall)

local M = class("CharacterUpgradeResultTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Characterdetail_character_upgrade_view_copy
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterUpgradeResultTipsView.New())

	self._timelineGadget = GuiTimelineGadgetView.New()

	table.insert(views, self._timelineGadget)

	return views
end

function M:onClickOutside()
	if self._timelineGadget:getOpenAniFinish() then
		ViewMgr.instance:close(self:getViewName())
	end
end

return M
