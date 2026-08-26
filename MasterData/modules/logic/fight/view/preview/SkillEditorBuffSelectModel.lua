-- chunkname: @modules/logic/fight/view/preview/SkillEditorBuffSelectModel.lua

module("modules.logic.fight.view.preview.SkillEditorBuffSelectModel", package.seeall)

local SkillEditorBuffSelectModel = class("SkillEditorBuffSelectModel", ListScrollModel)

function SkillEditorBuffSelectModel:setSelect(attacker, searchText)
	self.attacker = attacker

	local list = {}

	for i, buffCO in ipairs(lua_skill_buff.configList) do
		if string.find(tostring(buffCO.id), searchText) or string.find(buffCO.name, searchText) then
			table.insert(list, {
				id = i,
				co = buffCO
			})
		end
	end

	self:setList(list)
end

SkillEditorBuffSelectModel.instance = SkillEditorBuffSelectModel.New()

return SkillEditorBuffSelectModel
