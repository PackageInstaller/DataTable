-- chunkname: @modules/logic/act189/view/ShortenAct_PanelViewContainer.lua

module("modules.logic.act189.view.ShortenAct_PanelViewContainer", package.seeall)

local ShortenAct_PanelViewContainer = class("ShortenAct_PanelViewContainer", ShortenActViewContainer_impl)

function ShortenAct_PanelViewContainer:buildViews()
	return {
		self:taskScrollView(),
		ShortenAct_PanelView.New()
	}
end

return ShortenAct_PanelViewContainer
