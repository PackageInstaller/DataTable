-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseOpenCeremonyViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseOpenCeremonyViewContainer", package.seeall)

local CruiseOpenCeremonyViewContainer = class("CruiseOpenCeremonyViewContainer", BaseViewContainer)

function CruiseOpenCeremonyViewContainer:buildViews()
	local views = {}

	table.insert(views, CruiseOpenCeremonyView.New())

	return views
end

return CruiseOpenCeremonyViewContainer
