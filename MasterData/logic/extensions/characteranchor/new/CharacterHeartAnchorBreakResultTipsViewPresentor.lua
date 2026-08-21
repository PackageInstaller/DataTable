-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characteranchor/new/CharacterHeartAnchorBreakResultTipsViewPresentor.lua

module("logic.extensions.characteranchor.new.CharacterHeartAnchorBreakResultTipsViewPresentor", package.seeall)

local M = class("CharacterHeartAnchorBreakResultTipsViewPresentor", ViewPresentor)

BlackFadePresentorWrapper.extend(M)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.CharacterSystem_heart_anchor_break_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CharacterHeartAnchorBreakResultTipsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
