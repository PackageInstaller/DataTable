-- chunkname: @modules/logic/decorate/view/DecorateMaterialTipViewContainer.lua

module("modules.logic.decorate.view.DecorateMaterialTipViewContainer", package.seeall)

local DecorateMaterialTipViewContainer = class("DecorateMaterialTipViewContainer", BaseViewContainer)

function DecorateMaterialTipViewContainer:buildViews()
	local views = {}

	self._materialTipView = self:getMaterialTipView()
	self._materialTipViewBanner = self:getMaterialTipViewBanner()

	table.insert(views, self._materialTipView)
	table.insert(views, self._materialTipViewBanner)

	return views
end

function DecorateMaterialTipViewContainer:getMaterialTipView()
	self._materialTipView = self._materialTipView or DecorateMaterialTipView.New()

	return self._materialTipView
end

function DecorateMaterialTipViewContainer:getMaterialTipViewBanner()
	self._materialTipViewBanner = self._materialTipViewBanner or DecorateMaterialTipViewBanner.New()

	return self._materialTipViewBanner
end

return DecorateMaterialTipViewContainer
