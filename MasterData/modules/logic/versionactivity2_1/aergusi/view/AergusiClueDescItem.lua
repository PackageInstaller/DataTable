-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiClueDescItem.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueDescItem", package.seeall)

local AergusiClueDescItem = class("AergusiClueDescItem", LuaCompBase)

function AergusiClueDescItem:init(go)
	self.go = go
	self._txtDesc = gohelper.findChildText(go, "txt_desc")
end

function AergusiClueDescItem:hide()
	gohelper.setActive(self.go, false)
end

function AergusiClueDescItem:refreshItem(txt)
	gohelper.setActive(self.go, true)

	self._txtDesc.text = txt
end

function AergusiClueDescItem:destroy()
	gohelper.destroy(self.go)
end

return AergusiClueDescItem
