-- chunkname: @modules/logic/rouge2/outside/view/finish/Rouge2_ResultAttributeItem.lua

module("modules.logic.rouge2.outside.view.finish.Rouge2_ResultAttributeItem", package.seeall)

local Rouge2_ResultAttributeItem = class("Rouge2_ResultAttributeItem", LuaCompBase)

function Rouge2_ResultAttributeItem:init(go)
	self.go = go
	self._imageIcon = gohelper.findChildImage(self.go, "#image_Icon")
	self._txtValue = gohelper.findChildText(self.go, "#txt_Value")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_ResultAttributeItem:_editableInitView()
	return
end

function Rouge2_ResultAttributeItem:setInfo(info)
	Rouge2_IconHelper.setAttributeIcon(info.id, self._imageIcon)

	self._txtValue.text = tostring(info.value)
end

function Rouge2_ResultAttributeItem:onDestroy()
	return
end

return Rouge2_ResultAttributeItem
