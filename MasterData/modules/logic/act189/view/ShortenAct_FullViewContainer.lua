-- chunkname: @modules/logic/act189/view/ShortenAct_FullViewContainer.lua

module("modules.logic.act189.view.ShortenAct_FullViewContainer", package.seeall)

local ShortenAct_FullViewContainer = class("ShortenAct_FullViewContainer", ShortenActViewContainer_impl)

function ShortenAct_FullViewContainer:buildViews()
	return {
		self:taskScrollView(),
		ShortenAct_FullView.New()
	}
end

return ShortenAct_FullViewContainer
