-- chunkname: @modules/logic/rouge2/map/view/loading/Rouge2_MapLoadingView.lua

module("modules.logic.rouge2.map.view.loading.Rouge2_MapLoadingView", package.seeall)

local Rouge2_MapLoadingView = class("Rouge2_MapLoadingView", BaseView)

function Rouge2_MapLoadingView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.StartLoading)
end

function Rouge2_MapLoadingView:onClose()
	AudioMgr.instance:trigger(AudioEnum.Rouge2.EndLoading)
end

return Rouge2_MapLoadingView
