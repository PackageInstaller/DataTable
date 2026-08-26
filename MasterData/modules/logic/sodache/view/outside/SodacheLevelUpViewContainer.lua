-- chunkname: @modules/logic/sodache/view/outside/SodacheLevelUpViewContainer.lua

module("modules.logic.sodache.view.outside.SodacheLevelUpViewContainer", package.seeall)

local SodacheLevelUpViewContainer = class("SodacheLevelUpViewContainer", BaseViewContainer)

function SodacheLevelUpViewContainer:buildViews()
	local views = {}

	table.insert(views, SodacheLevelUpView.New())

	return views
end

return SodacheLevelUpViewContainer
