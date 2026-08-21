-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/preinstall/toolnotice/ToolNoticeViewPresentor.lua

module("logic.extensions.charactersystem.view.preinstall.toolnotice.ToolNoticeViewPresentor", package.seeall)

local M = class("ToolNoticeViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.CharacterSystem_Character_PreinstallNotic
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolNoticeView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
