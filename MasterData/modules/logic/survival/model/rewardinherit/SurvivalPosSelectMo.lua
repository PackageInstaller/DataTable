-- chunkname: @modules/logic/survival/model/rewardinherit/SurvivalPosSelectMo.lua

module("modules.logic.survival.model.rewardinherit.SurvivalPosSelectMo", package.seeall)

local SurvivalPosSelectMo = pureTable("SurvivalPosSelectMo")

function SurvivalPosSelectMo:ctor()
	self.cache = {}
	self.dataList = {}
end

function SurvivalPosSelectMo:addToEmptyPos(value)
	table.insert(self.dataList, value)
end

function SurvivalPosSelectMo:addToPos(posIndex, value)
	table.insert(self.dataList, posIndex, value)
end

function SurvivalPosSelectMo:removeFromPos(posIndex)
	table.remove(self.dataList, posIndex)
end

function SurvivalPosSelectMo:removeByValue(value)
	tabletool.removeValue(self.dataList, value)
end

function SurvivalPosSelectMo:removeAll()
	tabletool.clear(self.dataList)
end

function SurvivalPosSelectMo:isSelect(value)
	local index = tabletool.indexOf(self.dataList, value)

	return index ~= nil
end

function SurvivalPosSelectMo:Record()
	tabletool.clear(self.cache)

	for i, v in ipairs(self.dataList) do
		self.cache[i] = v
	end
end

function SurvivalPosSelectMo:Revert()
	tabletool.clear(self.dataList)

	for i, v in ipairs(self.cache) do
		self.dataList[i] = v
	end
end

function SurvivalPosSelectMo:clear()
	tabletool.clear(self.dataList)
	tabletool.clear(self.cache)
end

return SurvivalPosSelectMo
