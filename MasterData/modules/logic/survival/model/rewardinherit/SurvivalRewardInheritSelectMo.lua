-- chunkname: @modules/logic/survival/model/rewardinherit/SurvivalRewardInheritSelectMo.lua

module("modules.logic.survival.model.rewardinherit.SurvivalRewardInheritSelectMo", package.seeall)

local SurvivalRewardInheritSelectMo = pureTable("SurvivalRewardInheritSelectMo")

function SurvivalRewardInheritSelectMo:ctor()
	self.maxAmount = nil
	self.selectIdDic = {}
end

function SurvivalRewardInheritSelectMo:clear()
	tabletool.clear(self.selectIdDic)
end

function SurvivalRewardInheritSelectMo:replaceSelectIdDic(dic)
	tabletool.clear(self.selectIdDic)
	LuaUtil.insertDict(self.selectIdDic, dic)
end

function SurvivalRewardInheritSelectMo:copySelectIdDic()
	return tabletool.copy(self.selectIdDic)
end

function SurvivalRewardInheritSelectMo:setMaxAmount(maxAmount)
	self.maxAmount = maxAmount
end

function SurvivalRewardInheritSelectMo:isSelect(id)
	return LuaUtil.tableContains(self.selectIdDic, id)
end

function SurvivalRewardInheritSelectMo:replaceOne(posIndex, id)
	self.selectIdDic[posIndex] = id
end

function SurvivalRewardInheritSelectMo:removeOne(id)
	local index = LuaUtil.indexOfElement(self.selectIdDic, id)

	if index > 0 then
		self.selectIdDic[index] = nil
	end
end

function SurvivalRewardInheritSelectMo:removeOneByPos(pos)
	self.selectIdDic[pos] = nil
end

function SurvivalRewardInheritSelectMo:haveSelect()
	return #self.selectIdDic > 0
end

function SurvivalRewardInheritSelectMo:getSelect(index)
	return self.selectIdDic[index]
end

function SurvivalRewardInheritSelectMo:getSelectCellCfgId(index)
	local selectId = self:getSelect(index)

	if selectId then
		local mo = SurvivalHandbookModel.instance:getMoById(selectId)

		return mo:getCellCfgId()
	end
end

function SurvivalRewardInheritSelectMo:haveEmpty()
	for i = 1, self.maxAmount do
		if self.selectIdDic[i] == nil then
			return true, i
		end
	end
end

function SurvivalRewardInheritSelectMo:getLastPos()
	local pos = self.maxAmount

	for i = 1, self.maxAmount do
		if self.selectIdDic[i] == nil then
			pos = i

			break
		end
	end

	return pos
end

function SurvivalRewardInheritSelectMo:getSelectList()
	local list = {}

	for i, handbookId in pairs(self.selectIdDic) do
		local mo = SurvivalHandbookModel.instance:getMoById(handbookId)

		table.insert(list, mo:getCellCfgId())
	end

	return list
end

return SurvivalRewardInheritSelectMo
