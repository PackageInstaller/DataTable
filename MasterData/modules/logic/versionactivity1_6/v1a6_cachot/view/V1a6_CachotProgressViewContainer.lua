-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotProgressViewContainer.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotProgressViewContainer", package.seeall)

local V1a6_CachotProgressViewContainer = class("V1a6_CachotProgressViewContainer", BaseViewContainer)

function V1a6_CachotProgressViewContainer:buildViews()
	self._scrollParam = self:getMixContentParam()
	self._scrollView = LuaMixScrollView.New(V1a6_CachotProgressListModel.instance, self._scrollParam)

	return {
		V1a6_CachotProgressView.New(),
		self._scrollView
	}
end

function V1a6_CachotProgressViewContainer:buildTabViews(tabContainerId)
	return
end

function V1a6_CachotProgressViewContainer:getMixContentParam()
	local scrollParam = MixScrollParam.New()

	scrollParam.scrollGOPath = "Left/#go_progress/#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = self._viewSetting.otherRes[1]
	scrollParam.cellClass = V1a6_CachotProgressItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.startSpace = 2.5
	scrollParam.endSpace = 50

	return scrollParam
end

return V1a6_CachotProgressViewContainer
