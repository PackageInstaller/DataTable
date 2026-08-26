-- chunkname: @modules/logic/sodache/view/inside/SodacheEvilUpViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheEvilUpViewContainer", package.seeall)

local SodacheEvilUpViewContainer = class("SodacheEvilUpViewContainer", BaseViewContainer)

function SodacheEvilUpViewContainer:buildViews()
	return {
		SodacheEvilUpView.New()
	}
end

return SodacheEvilUpViewContainer
