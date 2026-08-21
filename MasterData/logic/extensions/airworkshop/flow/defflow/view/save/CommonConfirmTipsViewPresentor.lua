-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/save/CommonConfirmTipsViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.save.CommonConfirmTipsViewPresentor", package.seeall)

local M = class("CommonConfirmTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Dialog_message_tips
	}
end

function M:buildViews()
	local views = {}

	self._mainView = CommonConfirmTipsView.New()

	table.insert(views, self._mainView)
	table.insert(views, BlurBgView.New())

	return views
end

function M:attachToWhichRoot()
	return ViewRootType.Notify
end

function M:onClickOutside()
	return
end

return M
