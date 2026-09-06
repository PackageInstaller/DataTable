-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recastglory/view/RecastGloryGameBase.lua

module("logic.extensions.recastglory.view.RecastGloryGameBase", package.seeall)

local RecastGloryGameBase = class("RecastGloryGameBase")

function RecastGloryGameBase:ctor(go)
	self._gameGo = go
	self._gameGoTran = go.transform
end

function RecastGloryGameBase:onEnter()
	self._collider = goutil.findChild(self._gameGo.gameObject, "collider")
	self._colliderTran = goutil.findChild(self._gameGo.gameObject, "collider").transform
	self._colliderRect = goutil.findChild(self._gameGo.gameObject, "collider"):GetComponent(goutil.Type_RectTransform)
	self._boundingBox = BoundingBox2D.New()
end

function RecastGloryGameBase:onExit()
	self._boundingBox = nil
end

function RecastGloryGameBase:getBoundingBox()
	self._x, self._y = Framework.TransformUtil.GetLocalPos(self._gameGoTran, nil, nil, nil)
	self._cx, self._cy = Framework.TransformUtil.GetLocalPos(self._colliderRect, nil, nil, nil)

	self._boundingBox:setSize(self._colliderRect.rect.width, self._colliderRect.rect.height)
	self._boundingBox:setCenter(self._x + self._cx, self._y + self._cy)

	return self._boundingBox
end

return RecastGloryGameBase
