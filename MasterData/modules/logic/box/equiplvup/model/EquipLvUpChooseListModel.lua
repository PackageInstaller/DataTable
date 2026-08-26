-- chunkname: @modules/logic/box/equiplvup/model/EquipLvUpChooseListModel.lua

module("modules.logic.box.equiplvup.model.EquipLvUpChooseListModel", package.seeall)

local EquipLvUpChooseListModel = class("EquipLvUpChooseListModel", BaseModel)

function EquipLvUpChooseListModel:setEquipList(itemId)
	self._canLvUpList = {}
	self._maxLvEquipList = {}

	local items = EquipLvUpModel.instance:getEuipIdsByItemId(itemId)
	local equips = EquipModel.instance:getEquips()

	if items then
		if not items.idList then
			local idList = {}

			if equips then
				for _, mo in ipairs(equips) do
					if idList[mo.equipId] then
						local maxLv = EquipConfig.instance:getMaxLevel(mo.config)

						if maxLv > mo.level then
							table.insert(self._canLvUpList, mo)
						else
							table.insert(self._maxLvEquipList, mo)
						end
					end
				end
			end

			table.sort(self._canLvUpList, EquipLvUpChooseListModel.sort)
			table.sort(self._maxLvEquipList, EquipLvUpChooseListModel.sort)
		end
	end
end

function EquipLvUpChooseListModel.sort(a, b)
	return a.equipId > b.equipId
end

function EquipLvUpChooseListModel:getCanLvUpList()
	return self._canLvUpList
end

function EquipLvUpChooseListModel:getMaxLvEquipList()
	return self._maxLvEquipList
end

EquipLvUpChooseListModel.instance = EquipLvUpChooseListModel.New()

return EquipLvUpChooseListModel
