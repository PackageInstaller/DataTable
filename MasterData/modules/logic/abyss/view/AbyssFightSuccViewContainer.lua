-- chunkname: @modules/logic/abyss/view/AbyssFightSuccViewContainer.lua

module("modules.logic.abyss.view.AbyssFightSuccViewContainer", package.seeall)

local AbyssFightSuccViewContainer = class("AbyssFightSuccViewContainer", BaseViewContainer)

function AbyssFightSuccViewContainer:buildViews()
	return {
		AbyssFightSuccView.New()
	}
end

return AbyssFightSuccViewContainer
