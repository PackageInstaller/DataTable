-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/global/controller/UIReverseMaskMgr.lua

module("logic.extensions.global.controller.UIReverseMaskMgr", package.seeall)

UIReverseMaskMgr.MaskStyle_Circle = 1
UIReverseMaskMgr.MaskStyle_Custom = -100

local UIReverseMaskMgr = class("UIReverseMaskMgr")

function UIReverseMaskMgr:ctor()
	return
end

function UIReverseMaskMgr:resetMask()
	self._maskGo = nil
	self._maskWidget = nil
	self._maskImgPath = nil
	self._maskWidth = nil
	self._maskHeight = nil
	self._customTransform = nil
	self._gameCam = nil
	self._uiCamera = nil
	self._maskGraphic = nil
	self._performIngDirty = nil
	self._offsetX = nil
	self._offsetY = nil
	self._imageWidth = nil
	self._imageHeight = nil
	self._gameCamera = nil
	self._uiCamera = nil
	self._sortingOrder = nil
	self._maskStyle = nil
end

function UIReverseMaskMgr:setPerformIngDirty(performIngDirty)
	self._performIngDirty = performIngDirty
end

function UIReverseMaskMgr:setDirty()
	GlobalDispatcher:dispatch(GlobalNotify.ReverseMaskUpdate)
end

function UIReverseMaskMgr:setOffset(ofsX, ofxY)
	self._offsetX = ofsX
	self._offsetY = ofxY
end

function UIReverseMaskMgr:setStyle(style)
	self._maskStyle = style
end

function UIReverseMaskMgr:setMaskSize(sizeX, sizeY)
	self._imageWidth = sizeX
	self._imageHeight = sizeY
end

function UIReverseMaskMgr:setMaskTexPath(texPath)
	printInfo("setMaskTexPath:" .. texPath)

	self._maskImgPath = texPath
	self._maskStyle = UIReverseMaskMgr.MaskStyle_Custom
end

function UIReverseMaskMgr:setMaskByGraphic(graphic)
	self._maskStyle = UIReverseMaskMgr.MaskStyle_Custom
	self._maskGraphic = graphic
end

function UIReverseMaskMgr:maskSceneObject(go)
	self._maskGo = go
end

function UIReverseMaskMgr:maskWidget(widget)
	self._maskWidget = widget
end

function UIReverseMaskMgr:setGameCamera(cam)
	self._gameCamera = cam
end

function UIReverseMaskMgr:setUICamera(cam)
	self._uiCamera = cam
end

function UIReverseMaskMgr:setSortingOrder(sortingOrder)
	self._sortingOrder = sortingOrder
end

function UIReverseMaskMgr:start()
	ViewMgr.instance:open(ViewName.ReverseMaskView)
end

function UIReverseMaskMgr:finish()
	ViewMgr.instance:close(ViewName.ReverseMaskView)
	self:resetMask()
end

function UIReverseMaskMgr:isPerformIngDirty()
	return self._performIngDirty
end

function UIReverseMaskMgr:getOffset()
	return self._offsetX, self._offsetY
end

function UIReverseMaskMgr:getMaskSize()
	return self._imageWidth, self._maskHeight
end

function UIReverseMaskMgr:getMaskTexPath()
	return self._maskImgPath
end

function UIReverseMaskMgr:getMaskByGraphic()
	return self._maskGraphic
end

function UIReverseMaskMgr:getMaskSceneObject()
	return self._maskGo
end

function UIReverseMaskMgr:getMaskWidget()
	return self._maskWidget
end

function UIReverseMaskMgr:getGameCamera()
	return self._gameCamera
end

function UIReverseMaskMgr:getUICamera()
	return self._uiCamera
end

function UIReverseMaskMgr:getSortingOrder()
	return self._sortingOrder
end

function UIReverseMaskMgr:getStyle()
	return self._maskStyle
end

UIReverseMaskMgr.instance = UIReverseMaskMgr.New()

return UIReverseMaskMgr
