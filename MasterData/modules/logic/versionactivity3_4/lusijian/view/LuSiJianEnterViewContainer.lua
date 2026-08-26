-- chunkname: @modules/logic/versionactivity3_4/lusijian/view/LuSiJianEnterViewContainer.lua

module("modules.logic.versionactivity3_4.lusijian.view.LuSiJianEnterViewContainer", package.seeall)

local LuSiJianEnterViewContainer = class("LuSiJianEnterViewContainer", BaseViewContainer)

function LuSiJianEnterViewContainer:buildViews()
	local views = {}

	table.insert(views, LuSiJianEnterView.New())

	return views
end

return LuSiJianEnterViewContainer
