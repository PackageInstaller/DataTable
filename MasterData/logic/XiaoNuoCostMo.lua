-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/model/XiaoNuoCostMo.lua

module("logic.extensions.xiaonuoassistant.model.XiaoNuoCostMo", package.seeall)

local XiaoNuoCostMo = class("XiaoNuoCostMo")

function XiaoNuoCostMo:ctor()
	self.funcEnum = 0
	self.coinDataDic = {}
end

function XiaoNuoCostMo:addCoin(coinType, coinNum)
	local num = self.coinDataDic[coinType]

	num = num or 0
	num = num + checknumber(coinNum)
	num = num >= 0 and num or 0
	self.coinDataDic[coinType] = num
end

function XiaoNuoCostMo:subCoin(coinType, coinNum)
	local num = self.coinDataDic[coinType]

	num = num or 0
	num = num - checknumber(coinNum)
	num = num >= 0 and num or 0
	self.coinDataDic[coinType] = num
end

function XiaoNuoCostMo:setCoin(coinType, coinNum)
	local num = self.coinDataDic[coinType]

	num = num or 0
	num = checknumber(coinNum)
	num = num >= 0 and num or 0
	self.coinDataDic[coinType] = num
end

function XiaoNuoCostMo:clearCoin(coinType)
	local num = self.coinDataDic[coinType]

	if num then
		self.coinDataDic[coinType] = 0
	end
end

function XiaoNuoCostMo:clearAllCoin()
	table.clear(self.coinDataDic)
end

function XiaoNuoCostMo:getCoin(coinType)
	local num = self.coinDataDic[coinType]

	return num and num or 0
end

return XiaoNuoCostMo
