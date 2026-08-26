-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionListTagItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionListTagItem", package.seeall)

local Rouge2_CollectionListTagItem = class("Rouge2_CollectionListTagItem", LuaCompBase)

function Rouge2_CollectionListTagItem:init(go)
	self.go = go
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "#btn_click")
	self._imageTagIcon = gohelper.findChildImage(self.go, "image_tagicon")
	self._txttagitem = gohelper.findChildTextMesh(self.go, "#txt_tagitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CollectionListTagItem:_editableInitView()
	gohelper.setActive(self._btnclick, false)
end

function Rouge2_CollectionListTagItem:setInfo(attributeConfig)
	Rouge2_IconHelper.setAttributeIcon(attributeConfig.id, self._imageTagIcon)

	self._txttagitem.text = attributeConfig.name
end

function Rouge2_CollectionListTagItem:onDestroy()
	return
end

return Rouge2_CollectionListTagItem
