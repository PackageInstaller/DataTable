-- chunkname: @modules/logic/versionactivity1_2/jiexika/view/Activity114CheckAttrItem.lua

module("modules.logic.versionactivity1_2.jiexika.view.Activity114CheckAttrItem", package.seeall)

local Activity114CheckAttrItem = class("Activity114CheckAttrItem", ListScrollCell)

function Activity114CheckAttrItem:init(go)
	self._txtLevel = gohelper.findChildTextMesh(go, "txt_info")
end

function Activity114CheckAttrItem:onUpdateMO(mo)
	self._txtLevel.text = string.format("%d[%s]", mo.value, mo.name)

	if mo.isAttr then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtLevel, "#e55151")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtLevel, "#9ee091")
	end
end

function Activity114CheckAttrItem:onDestroyView()
	self._txtLevel = nil
end

return Activity114CheckAttrItem
