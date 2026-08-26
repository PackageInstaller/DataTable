-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackageGoodsTipViewContainer.lua

module("modules.logic.sceneuipackage.view.SceneUIPackageGoodsTipViewContainer", package.seeall)

local SceneUIPackageGoodsTipViewContainer = class("SceneUIPackageGoodsTipViewContainer", BaseViewContainer)

function SceneUIPackageGoodsTipViewContainer:buildViews()
	local views = {}

	self._bannerView = SceneUIPackageGoodsTipViewBanner.New()

	table.insert(views, SceneUIPackageGoodsTipView.New())
	table.insert(views, self._bannerView)

	return views
end

function SceneUIPackageGoodsTipViewContainer:setGoodsTab(tabIndex)
	self._bannerView:setGoodsTab(tabIndex)
end

return SceneUIPackageGoodsTipViewContainer
