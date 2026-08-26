-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterNpcListModel.lua

module("modules.logic.survival.model.shelter.SurvivalShelterNpcListModel", package.seeall)

local SurvivalShelterNpcListModel = class("SurvivalShelterNpcListModel", ListScrollModel)

function SurvivalShelterNpcListModel:initViewParam()
	self.selectNpcId = 0
end

function SurvivalShelterNpcListModel:setSelectNpcId(npcId)
	if self.selectNpcId == npcId then
		return
	end

	self.selectNpcId = npcId

	return true
end

function SurvivalShelterNpcListModel:isSelectNpc(npcId)
	return self.selectNpcId == npcId
end

function SurvivalShelterNpcListModel:getSelectNpc()
	return self.selectNpcId
end

function SurvivalShelterNpcListModel:refreshList(filterList)
	local list = {}
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local npcDict = weekInfo.npcDict

	if npcDict then
		for _, v in pairs(npcDict) do
			if SurvivalBagSortHelper.filterNpc(filterList, v) and v.co.takeOut == 0 then
				table.insert(list, v)
			end
		end
	end

	if #list > 1 then
		table.sort(list, SurvivalShelterNpcMo.sort)
	end

	local dataList = {}
	local lineCount = 4

	for i, v in ipairs(list) do
		local index = math.floor((i - 1) / lineCount) + 1
		local item = dataList[index]

		if not item then
			item = {
				id = i,
				dataList = {}
			}
			dataList[index] = item
		end

		table.insert(item.dataList, v)
	end

	if self.selectNpcId == nil or self.selectNpcId == 0 then
		self.selectNpcId = list[1] and list[1].id
	end

	self:setList(dataList)
end

SurvivalShelterNpcListModel.instance = SurvivalShelterNpcListModel.New()

return SurvivalShelterNpcListModel
