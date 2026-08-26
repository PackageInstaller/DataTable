-- chunkname: @modules/logic/equip/model/EquipTeamAttrListModel.lua

module("modules.logic.equip.model.EquipTeamAttrListModel", package.seeall)

local EquipTeamAttrListModel = class("EquipTeamAttrListModel", ListScrollModel)

function EquipTeamAttrListModel:init()
	return
end

function EquipTeamAttrListModel:SetAttrList()
	local attrList = {}
	local equipList = EquipTeamListModel.instance:getTeamEquip()

	for _, uid in ipairs(equipList) do
		local mo = EquipModel.instance:getEquip(uid)

		if mo then
			local hp, atk, def, mdef, upAttrs = EquipConfig.instance:getEquipStrengthenAttr(mo)

			self:setAttr(attrList, 101, 0, hp)
			self:setAttr(attrList, 102, 0, atk)
			self:setAttr(attrList, 103, 0, def)
			self:setAttr(attrList, 104, 0, mdef)

			for id, config in pairs(lua_character_attribute.configDict) do
				if config.type == 2 or config.type == 3 then
					self:setAttr(attrList, id, config.showType, upAttrs[config.attrType])
				end
			end
		end
	end

	local result = {}

	for id, typeList in pairs(attrList) do
		for type, value in pairs(typeList) do
			table.insert(result, {
				attrId = id,
				showType = type,
				value = value
			})
		end
	end

	table.sort(result, EquipTeamAttrListModel._sort)
	self:setList(result)
end

function EquipTeamAttrListModel._sort(a, b)
	return a.attrId < b.attrId
end

function EquipTeamAttrListModel:setAttr(list, id, type, value)
	if value <= -1 then
		return
	end

	if not list[id] then
		local typeList = {}

		list[id] = typeList

		if not typeList[type] then
			local v = 0

			v = typeList[type] + value
			typeList[type] = typeList[type]
		end
	end
end

EquipTeamAttrListModel.instance = EquipTeamAttrListModel.New()

return EquipTeamAttrListModel
