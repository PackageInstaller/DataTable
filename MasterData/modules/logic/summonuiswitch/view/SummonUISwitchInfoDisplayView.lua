-- chunkname: @modules/logic/summonuiswitch/view/SummonUISwitchInfoDisplayView.lua

module("modules.logic.summonuiswitch.view.SummonUISwitchInfoDisplayView", package.seeall)

local SummonUISwitchInfoDisplayView = class("SummonUISwitchInfoDisplayView", BaseView)

function SummonUISwitchInfoDisplayView:onInitView()
	self._gobg1 = gohelper.findChild(self.viewGO, "#go_bg1")
	self._gobg2 = gohelper.findChild(self.viewGO, "#go_bg2")
	self._simageFullBG1 = gohelper.findChildSingleImage(self._gobg1, "img")
	self._simageFullBG2 = gohelper.findChildSingleImage(self._gobg2, "img")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonUISwitchInfoDisplayView:addEvents()
	return
end

function SummonUISwitchInfoDisplayView:removeEvents()
	return
end

function SummonUISwitchInfoDisplayView:_editableInitView()
	self._rawImage = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "RawImage"), gohelper.Type_RawImage)

	gohelper.setActive(self._rawImage, false)
	SummonUISwitchCameraController.instance:clear()
	self:_clearPage()
	self.addEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchPreviewSceneUI, self._onShowSceneInfo, self)
end

function SummonUISwitchInfoDisplayView:_onShowSceneInfo(id)
	self:_hideMainScene()

	self._sceneId = id

	SummonUISwitchCameraController.instance:showScene(id, self._showSceneFinished, self)
end

function SummonUISwitchInfoDisplayView.adjustRt(rawImage, rt)
	rawImage.texture = rt

	rawImage:SetNativeSize()

	local width = rt.width
	local root = ViewMgr.instance:getUIRoot().transform
	local containerWidth = recthelper.getWidth(root)
	local scale = containerWidth / width

	transformhelper.setLocalScale(rawImage.transform, scale, scale, 1)
end

function SummonUISwitchInfoDisplayView:_showSceneFinished(rt)
	gohelper.setActive(self._rawImage, true)
	SummonUISwitchInfoDisplayView.adjustRt(self._rawImage, rt)
end

function SummonUISwitchInfoDisplayView:_clearPage()
	gohelper.setActive(self._simageFullBG1, false)
	gohelper.setActive(self._simageFullBG2, false)
end

function SummonUISwitchInfoDisplayView:_hideMainScene()
	self._isPreview = self.viewParam and self.viewParam.isPreview

	if self._isPreview then
		-- block empty
	end
end

function SummonUISwitchInfoDisplayView:onClose()
	SummonUISwitchCameraController.instance:clear()

	if self._isPreview then
		SummonUISkinSwitchDisplayController.instance:showCurScene()
	end
end

function SummonUISwitchInfoDisplayView:onDestroyView()
	self:_clearPage()
	self.removeEventCb(self, SummonUISwitchController.instance, SummonUISwitchEvent.SwitchPreviewSceneUI, self._onShowSceneInfo, self)
end

return SummonUISwitchInfoDisplayView
