-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterNpcMonsterListModel.lua

module("modules.logic.survival.model.shelter.SurvivalShelterNpcMonsterListModel", package.seeall)

local SurvivalShelterNpcMonsterListModel = class("SurvivalShelterNpcMonsterListModel", ListScrollModel)
local selectMaxCount = 4

function SurvivalShelterNpcMonsterListModel:initViewParam()
	self.selectNpcIds = {}
end

function SurvivalShelterNpcMonsterListModel:setSelectNpcId(npcId)
	if self:isSelectNpc(npcId) then
		return false
	end

	self.selectNpcIds[#self.selectNpcIds + 1] = npcId

	return true
end

function SurvivalShelterNpcMonsterListModel:setSelectNpcByList(npcIdList)
	self.selectNpcIds = {}

	if npcIdList == nil then
		return
	end

	for i = 1, #npcIdList do
		local npcId = npcIdList[i]

		self:setSelectNpcId(npcId)
	end
end

function SurvivalShelterNpcMonsterListModel:cancelSelect(npcId)
	if not self:isSelectNpc(npcId) then
		return false
	end

	local needDeleteIndex = -1

	for i = 1, #self.selectNpcIds do
		local id = self.selectNpcIds[i]

		if id == npcId then
			needDeleteIndex = i

			break
		end
	end

	if needDeleteIndex == -1 then
		return false
	end

	for i = #self.selectNpcIds, 1, -1 do
		if i == needDeleteIndex then
			table.remove(self.selectNpcIds, i)

			break
		end
	end

	return true
end

function SurvivalShelterNpcMonsterListModel:canSelect()
	return self:getSelectCount() < selectMaxCount
end

function SurvivalShelterNpcMonsterListModel:getSelectCount()
	return #self.selectNpcIds
end

function SurvivalShelterNpcMonsterListModel:isSelectNpc(npcId)
	for i = 1, #self.selectNpcIds do
		local id = self.selectNpcIds[i]

		if id == npcId then
			return true
		end
	end

	return false
end

function SurvivalShelterNpcMonsterListModel:getSelectList()
	return self.selectNpcIds
end

function SurvivalShelterNpcMonsterListModel.sort(a, b)
	local recommendNumA = SurvivalShelterMonsterModel.instance:calRecommendNum(a.id)
	local recommendNumB = SurvivalShelterMonsterModel.instance:calRecommendNum(b.id)

	if recommendNumA == recommendNumB then
		return a.id < b.id
	end

	return recommendNumB < recommendNumA
end

function SurvivalShelterNpcMonsterListModel:refreshList()
	local normalList = {}
	local inDestroyBuildList = {}
	local notInBuildList = {}
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local npcDict = weekInfo.npcDict

	if npcDict then
		for _, v in pairs(npcDict) do
			local status = v:getShelterNpcStatus()

			if status == SurvivalEnum.ShelterNpcStatus.InBuild then
				normalList[#normalList + 1] = v
			elseif status == SurvivalEnum.ShelterNpcStatus.InDestoryBuild then
				inDestroyBuildList[#inDestroyBuildList + 1] = v
			end
		end
	end

	if #normalList > 1 then
		table.sort(normalList, SurvivalShelterNpcMonsterListModel.sort)
	end

	if #inDestroyBuildList > 1 then
		table.sort(inDestroyBuildList, SurvivalShelterNpcMonsterListModel.sort)
	end

	if #notInBuildList > 1 then
		table.sort(notInBuildList, SurvivalShelterNpcMonsterListModel.sort)
	end

	tabletool.addValues(normalList, inDestroyBuildList)
	tabletool.addValues(normalList, notInBuildList)

	local dataList = {}
	local lineCount = 2

	for i, v in ipairs(normalList) do
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

	self:setList(dataList)
end

SurvivalShelterNpcMonsterListModel.instance = SurvivalShelterNpcMonsterListModel.New()

return SurvivalShelterNpcMonsterListModel
