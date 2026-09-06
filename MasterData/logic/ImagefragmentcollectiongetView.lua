-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/imagefragmentcollection/view/ImagefragmentcollectiongetView.lua

module("logic.extensions.imagefragmentcollection.view.ImagefragmentcollectiongetView", package.seeall)

local ImagefragmentcollectiongetView = class("ImagefragmentcollectiongetView", ViewComponent)

function ImagefragmentcollectiongetView:ctor()
	ImagefragmentcollectiongetView.super.ctor(self)
end

function ImagefragmentcollectiongetView:unbindEvents()
	ImagefragmentcollectiongetView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ImagefragmentcollectiongetView:bindEvents()
	ImagefragmentcollectiongetView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function ImagefragmentcollectiongetView:buildUI()
	ImagefragmentcollectiongetView.super.buildUI(self)

	self._btnClose = self:getBtn("container/btnClose")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "container/txtDesc")
	self._uiChange = {}
	self._uiChange[1] = self:getGo("container/activeBg1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._uiChange[2] = self:getGo("container/activeBg2"):GetComponent(ComponentType.UIImageSpriteChange)
end

function ImagefragmentcollectiongetView:onExit()
	ImagefragmentcollectiongetView.super.onExit(self)
	FuncOpenController.instance:openFunc(338)
end

function ImagefragmentcollectiongetView:onEnter()
	ImagefragmentcollectiongetView.super.onEnter(self)

	local params = self:getOpenParam()
	local imgId, fragmentId = params[1], params[2]

	for k, v in pairs(self._uiChange) do
		goutil.setActive(v.gameObject, k == imgId)
	end

	self._uiChange[imgId]:SetState(fragmentId - 1)

	self._txtDesc.text = "获得碎片" .. fragmentId
end

function ImagefragmentcollectiongetView:_onClickbtnClose()
	self:close()
end

return ImagefragmentcollectiongetView
