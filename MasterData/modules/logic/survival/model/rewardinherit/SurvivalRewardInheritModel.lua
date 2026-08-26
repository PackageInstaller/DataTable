-- chunkname: @modules/logic/survival/model/rewardinherit/SurvivalRewardInheritModel.lua

module("modules.logic.survival.model.rewardinherit.SurvivalRewardInheritModel", package.seeall)

local SurvivalRewardInheritModel = class("SurvivalRewardInheritModel", BaseModel)

function SurvivalRewardInheritModel:onInit()
	self.amplifierSelectMo = SurvivalRewardInheritSelectMo.New()

	self.amplifierSelectMo:setMaxAmount(1)

	self.npcSelectMo = SurvivalRewardInheritSelectMo.New()

	self.npcSelectMo:setMaxAmount(3)

	self.selectMo = SurvivalPosSelectMo.New()
end

function SurvivalRewardInheritModel:reInit()
	return
end

function SurvivalRewardInheritModel:clear()
	SurvivalRewardInheritModel.super.clear(self)
end

function SurvivalRewardInheritModel:isNeedHandbookSelect()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo and weekInfo.day ~= 1 then
		return true
	end

	return false
end

function SurvivalRewardInheritModel:getExtendScore()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	return weekInfo.extendScore
end

function SurvivalRewardInheritModel:getInheritHandBookDatas(handbookType, subType)
	return SurvivalHandbookModel.instance:getInheritHandBookDatas(handbookType, subType)
end

function SurvivalRewardInheritModel:getInheritId(survivalHandbookMo)
	return survivalHandbookMo:getCellCfgId()
end

function SurvivalRewardInheritModel:getInheritMoByInheritIdId(id)
	return SurvivalHandbookModel.instance:getInheritMoById(id)
end

function SurvivalRewardInheritModel:getCurExtendScore()
	local amount = 0

	for i, id in ipairs(self.selectMo.dataList) do
		local mo = self:getInheritMoByInheritIdId(id)
		local itemMo = mo:getSurvivalBagItemMo()

		amount = amount + itemMo:getExtendCost()
	end

	return amount
end

function SurvivalRewardInheritModel:getSelectMo()
	local list = {}

	for i, id in ipairs(self.selectMo.dataList) do
		local mo = self:getInheritMoByInheritIdId(id)

		table.insert(list, mo)
	end

	return list
end

function SurvivalRewardInheritModel:getSelectNum(handbookType, subType)
	local list = self.selectMo.dataList
	local amount = 0

	for i, id in ipairs(list) do
		local mo = self:getInheritMoByInheritIdId(id)

		if mo:getType() == handbookType and (subType == nil or mo:getSubType() == subType) then
			amount = amount + 1
		end
	end

	return amount
end

function SurvivalRewardInheritModel:getChooseList()
	local amplifier = {}
	local npc = {}
	local list = self.selectMo.dataList

	for i, id in ipairs(list) do
		local mo = self:getInheritMoByInheritIdId(id)

		if mo:getType() == SurvivalEnum.HandBookType.Amplifier then
			table.insert(amplifier, mo:getCellCfgId())
		elseif mo:getType() == SurvivalEnum.HandBookType.Npc then
			table.insert(npc, mo:getCellCfgId())
		end
	end

	return amplifier, npc
end

SurvivalRewardInheritModel.instance = SurvivalRewardInheritModel.New()

return SurvivalRewardInheritModel
