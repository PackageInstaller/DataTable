-- chunkname: @modules/logic/sodache/view/inside/SodacheMapSelectTimeViewContainer.lua

module("modules.logic.sodache.view.inside.SodacheMapSelectTimeViewContainer", package.seeall)

local SodacheMapSelectTimeViewContainer = class("SodacheMapSelectTimeViewContainer", BaseViewContainer)

function SodacheMapSelectTimeViewContainer:buildViews()
	return {
		SodacheMapSelectTimeView.New()
	}
end

function SodacheMapSelectTimeViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

return SodacheMapSelectTimeViewContainer
