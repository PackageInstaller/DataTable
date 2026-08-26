-- chunkname: @modules/logic/fight/view/preview/SkillEditorSceneSelectModel.lua

module("modules.logic.fight.view.preview.SkillEditorSceneSelectModel", package.seeall)

local SkillEditorSceneSelectModel = class("SkillEditorSceneSelectModel", ListScrollModel)

function SkillEditorSceneSelectModel:setSelect(searchText)
	local list = {}
	local coList = lua_scene_level.configList

	for i, co in ipairs(coList) do
		local sceneCO = lua_scene.configDict[co.sceneId]

		if not string.find(tostring(co.id), searchText) then
			if sceneCO then
				if string.find(sceneCO.name or "", searchText) then
					local mo = {
						id = i,
						co = co
					}

					table.insert(list, mo)
				end
			end
		end
	end

	self:setList(list)
end

SkillEditorSceneSelectModel.instance = SkillEditorSceneSelectModel.New()

return SkillEditorSceneSelectModel
