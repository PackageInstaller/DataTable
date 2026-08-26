-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackageInfoView.lua

module("modules.logic.sceneuipackage.view.SceneUIPackageInfoView", package.seeall)

local SceneUIPackageInfoView = class("SceneUIPackageInfoView", BaseView)

function SceneUIPackageInfoView:onInitView()
	self._gomainUI = gohelper.findChild(self.viewGO, "middle/#go_mainUI")
	self._gooverview = gohelper.findChild(self.viewGO, "middle/#go_overview")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "middle/#go_overview/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SceneUIPackageInfoView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, self._onSwitchUIVisible, self)
end

function SceneUIPackageInfoView:removeEvents()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.PreviewSwitchUIVisible, self._onSwitchUIVisible, self)
end

function SceneUIPackageInfoView:_btncloseOnClick()
	self:closeThis()
end

function SceneUIPackageInfoView:_editableInitView()
	self._root = gohelper.findChild(self.viewGO, "root")
	self._gorawImage = gohelper.findChild(self._root, "RawImage")

	gohelper.setActive(self._gorawImage, false)

	self._rawImage = gohelper.onceAddComponent(self._gorawImage, gohelper.Type_RawImage)
end

function SceneUIPackageInfoView:onUpdateParam()
	return
end

function SceneUIPackageInfoView:_onSwitchUIVisible(visible)
	return
end

function SceneUIPackageInfoView:onOpen()
	if self.viewParam then
		self._sceneId = self.viewParam.sceneId or MainSceneSwitchModel.instance:getCurSceneId()
	end

	self:_onShowSceneInfo()
end

function SceneUIPackageInfoView:_onShowSceneInfo()
	MainSceneSwitchCameraController.instance:showScene(self._sceneId, self._showSceneFinished, self)
end

function SceneUIPackageInfoView:_showSceneFinished(rt)
	MainSceneSwitchInfoDisplayView.adjustRt(self._rawImage, rt)
	gohelper.setActive(self._gorawImage, true)
end

function SceneUIPackageInfoView.adjustRt(rawImage, rt)
	rawImage.texture = rt

	rawImage:SetNativeSize()

	local width = rt.width
	local root = ViewMgr.instance:getUIRoot().transform
	local containerWidth = recthelper.getWidth(root)
	local scale = containerWidth / width

	transformhelper.setLocalScale(rawImage.transform, scale, scale, 1)
end

function SceneUIPackageInfoView:onClose()
	if not self.viewParam.isCloseMoHideScene then
		MainSceneSwitchCameraController.instance:clear()
	end
end

function SceneUIPackageInfoView:onDestroyView()
	return
end

return SceneUIPackageInfoView
