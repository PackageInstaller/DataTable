-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/model/XiaoNuoAssistCostModel.lua

module("logic.extensions.xiaonuoassistant.model.XiaoNuoAssistCostModel", package.seeall)

local XiaoNuoAssistCostModel = class("XiaoNuoAssistCostModel", BaseModel)

function XiaoNuoAssistCostModel:ctor()
	self._tabIndex = 0
	self._coinDataList = {}
end

function XiaoNuoAssistCostModel:onReset()
	return
end

function XiaoNuoAssistCostModel:initData(tabIndex)
	printInfo("test XiaoNuoAssistCostModel:initData", tabIndex)

	self._tabIndex = tabIndex

	self:clearData()
end

function XiaoNuoAssistCostModel:clearData()
	table.clear(self._coinDataList)
end

function XiaoNuoAssistCostModel:getCostData(funcEnum)
	local coinData

	for i, v in ipairs(self._coinDataList) do
		if v.funcEnum == funcEnum then
			return v
		end
	end

	local newMo = XiaoNuoCostMo.New()

	newMo.funcEnum = funcEnum

	table.insert(self._coinDataList, newMo)

	return newMo
end

function XiaoNuoAssistCostModel:addCoin(funcEnum, coinType, coinNum)
	local coinData = self:getCostData(funcEnum)

	coinData:addCoin(coinType, coinNum)
end

function XiaoNuoAssistCostModel:subCoin(funcEnum, coinType, coinNum)
	local coinData = self:getCostData(funcEnum)

	coinData:subCoin(coinType, coinNum)
end

function XiaoNuoAssistCostModel:setCoin(funcEnum, coinType, coinNum)
	local coinData = self:getCostData(funcEnum)

	coinData:setCoin(coinType, coinNum)
end

function XiaoNuoAssistCostModel:getCoin(funcEnum, coinType)
	local coinData = self:getCostData(funcEnum)

	return coinData:getCoin(coinType)
end

function XiaoNuoAssistCostModel:clearCoin(funcEnum, coinType)
	local coinData = self:getCostData(funcEnum)

	coinData:clearCoin(coinType)
end

function XiaoNuoAssistCostModel:clearAllCoin(funcEnum)
	local coinData = self:getCostData(funcEnum)

	coinData:clearAllCoin()
end

function XiaoNuoAssistCostModel:getCoinTotalNum(coinType)
	local num = 0

	for i, v in ipairs(self._coinDataList) do
		num = num + v:getCoin(coinType)
	end

	return num
end

function XiaoNuoAssistCostModel:getCoinNumByOpenItems(coinType)
	local num = 0

	for i, v in ipairs(self._coinDataList) do
		if XiaoNuoAssistLocalDataModel.instance:getOpenData(v.funcEnum) then
			num = num + v:getCoin(coinType)
		end
	end

	return num
end

function XiaoNuoAssistCostModel:getTotalCoin(toFuncEnum, coinType)
	local tabList = XiaoNuoAssistantModel.TabList[self._tabIndex]
	local totalNum = 0

	for i, funcEnum in ipairs(tabList) do
		if XiaoNuoAssistLocalDataModel.instance:getOpenData(funcEnum) then
			totalNum = totalNum + self:getCoin(funcEnum, coinType)
		end

		if funcEnum == toFuncEnum then
			return totalNum
		end
	end

	return totalNum
end

XiaoNuoAssistCostModel.instance = XiaoNuoAssistCostModel.New()

return XiaoNuoAssistCostModel
