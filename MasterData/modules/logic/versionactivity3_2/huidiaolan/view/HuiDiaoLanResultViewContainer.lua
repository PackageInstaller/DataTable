-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanResultViewContainer.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanResultViewContainer", package.seeall)

local HuiDiaoLanResultViewContainer = class("HuiDiaoLanResultViewContainer", BaseViewContainer)

function HuiDiaoLanResultViewContainer:buildViews()
	local views = {}

	table.insert(views, HuiDiaoLanResultView.New())

	return views
end

return HuiDiaoLanResultViewContainer
