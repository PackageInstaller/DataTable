-- chunkname: @modules/logic/mainuiswitch/view/MainUISwitchInfoDisplayView.lua

module("modules.logic.mainuiswitch.view.MainUISwitchInfoDisplayView", package.seeall)

local MainUISwitchInfoDisplayView = class("MainUISwitchInfoDisplayView", MainSceneSwitchInfoDisplayView)

function MainUISwitchInfoDisplayView:_editableInitView()
	MainUISwitchInfoDisplayView.super._editableInitView(self)
	gohelper.setActive(self._gobg1, false)
	gohelper.setActive(self._gobg2, false)
	gohelper.setActive(self._rawImage.gameObject, false)
end

function MainUISwitchInfoDisplayView:_onShowSceneInfo(id)
	self._sceneId = id
end

return MainUISwitchInfoDisplayView
