-- chunkname: @modules/logic/versionactivity2_5/decoratestore/view/V2a5_DecorateStoreViewContainer.lua

module("modules.logic.versionactivity2_5.decoratestore.view.V2a5_DecorateStoreViewContainer", package.seeall)

local V2a5_DecorateStoreViewContainer = class("V2a5_DecorateStoreViewContainer", BaseViewContainer)

function V2a5_DecorateStoreViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a5_DecorateStoreView.New())

	return views
end

function V2a5_DecorateStoreViewContainer:onContainerClickModalMask()
	self:closeThis()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

return V2a5_DecorateStoreViewContainer
