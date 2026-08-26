-- chunkname: @modules/logic/teach/view/TeachNoteDescItem.lua

module("modules.logic.teach.view.TeachNoteDescItem", package.seeall)

local TeachNoteDescItem = class("TeachNoteDescItem", LuaCompBase)

function TeachNoteDescItem:init(go, index, id)
	self.go = go
	self.index = index
	self.id = id
	self._txtdesccn = gohelper.findChildText(go, "desccn")
	self._txtdescen = gohelper.findChildText(go, "descen")

	self:_refreshItem()
end

function TeachNoteDescItem:_refreshItem()
	local desccnCos = string.split(TeachNoteConfig.instance:getInstructionLevelCO(self.id).desc, "#")
	local descenCos = string.split(TeachNoteConfig.instance:getInstructionLevelCO(self.id).desc_en, "#")

	self._txtdesccn.text = string.gsub(desccnCos[self.index], "<i>(.-)</i>", "<i><size=24>%1</size></i>")
	self._txtdescen.text = descenCos[self.index]
end

function TeachNoteDescItem:onDestroyView()
	gohelper.destroy(self.go)
end

return TeachNoteDescItem
