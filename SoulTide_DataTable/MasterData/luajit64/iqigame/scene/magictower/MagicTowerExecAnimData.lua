-- chunkname: @IQIGame\\Scene\\MagicTower\\MagicTowerExecAnimData.lua

local m = {}

function m.New()
	return Clone(m)
end

function m.CreateDataGroup(executionItem)
	local dataList = {}
	local data1 = m.New()

	data1.ExecutionType = executionItem.executionType
	data1.ExecutionParam = executionItem.params

	table.insert(dataList, data1)

	if executionItem.getItems ~= nil and #executionItem.getItems > 0 then
		local data2 = m.New()

		data2.DropItemList = executionItem.getItems

		table.insert(dataList, data2)
	end

	if executionItem.role ~= nil then
		local data3 = m.New()

		data3.RoleUpdate = executionItem.role

		table.insert(dataList, data3)
	end

	return dataList
end

function m:GetChangedAttrMap(curRoleData)
	local deltaHp = self.RoleUpdate.hp - curRoleData.hp
	local deltaAtk = self.RoleUpdate.atk - curRoleData.atk
	local deltaDef = self.RoleUpdate.def - curRoleData.def

	if deltaHp == 0 and deltaAtk == 0 and deltaDef == 0 then
		return nil
	end

	local changeMap = {}

	if deltaHp ~= 0 then
		changeMap[MagicTowerRoleAttrID.HP] = deltaHp
	end

	if deltaAtk ~= 0 then
		changeMap[MagicTowerRoleAttrID.ATK] = deltaAtk
	end

	if deltaDef ~= 0 then
		changeMap[MagicTowerRoleAttrID.DEF] = deltaDef
	end

	return changeMap
end

function m:GetChangedEquip(curRoleData)
	local changedEquip

	for i = 1, #self.RoleUpdate.equipments do
		local newEquipId = self.RoleUpdate.equipments[i]
		local curEquipId = curRoleData.equipments[i]

		if newEquipId ~= curEquipId then
			changedEquip = changedEquip or {}

			table.insert(changedEquip, newEquipId)
		end
	end

	return changedEquip
end

function m:GetChangedKeyMap(curRoleData)
	local deltaKey1 = self.RoleUpdate.key1 - curRoleData.key1
	local deltaKey2 = self.RoleUpdate.key2 - curRoleData.key2
	local deltaKey3 = self.RoleUpdate.key3 - curRoleData.key3

	if deltaKey1 == 0 and deltaKey2 == 0 and deltaKey3 == 0 then
		return nil
	end

	local changeMap = {}

	if deltaKey1 ~= 0 then
		changeMap[1] = deltaKey1
	end

	if deltaKey2 ~= 0 then
		changeMap[2] = deltaKey2
	end

	if deltaKey3 ~= 0 then
		changeMap[3] = deltaKey3
	end

	return changeMap
end

return m
