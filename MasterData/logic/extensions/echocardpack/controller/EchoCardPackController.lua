-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/echocardpack/controller/EchoCardPackController.lua

module("logic.extensions.echocardpack.controller.EchoCardPackController", package.seeall)

local M = class("EchoCardPackController", BaseController)

M.ViewType = {
	Use = 1,
	Buy = 2
}
M.UnpackState = {
	UnpackEnd = 4,
	Unpacking = 3,
	Ordering = 1,
	UnInOrder = 0,
	InOrder = 2
}
M.AutoOpenCardKey = "AutoOpenCardKey"

function M:ctor()
	return
end

function M:onInit()
	return
end

function M:onReset()
	return
end

function M:cacheResult(items)
	self._resultCache = {}
	self._maxQuality = GameEnum.QualityEnum.D

	for i, item in ipairs(items) do
		local code = item.itemCode
		local extraItems = item.extra or {}
		local conversionItem = {}

		for extraIndex, extraItem in ipairs(extraItems) do
			local hasSame = false

			for coverIndex = 1, #conversionItem do
				if conversionItem[coverIndex].code == extraItem.code then
					conversionItem[coverIndex].num = conversionItem[coverIndex].num + extraItem.num
					hasSame = true

					break
				end
			end

			if not hasSame then
				table.insert(conversionItem, {
					code = extraItem.code,
					num = extraItem.num
				})
			end
		end

		local itemData = ItemUtil.createItemData({
			1,
			itemId = code
		})
		local result = {
			itemData = itemData,
			isNew = item.newly,
			conversion = conversionItem
		}

		table.insert(self._resultCache, result)

		if itemData:getQuality() > self._maxQuality then
			self._maxQuality = itemData:getQuality()
		end
	end
end

function M:getMaxQuality()
	return self._maxQuality or GameEnum.QualityEnum.D
end

function M:getCacheResult()
	return self._resultCache
end

function M:setUnpackData(nextGuaranteeA, nextGuaranteeS, isActivity, num, itemId)
	self._nextGuaranteeA = nextGuaranteeA and nextGuaranteeA or -1
	self._nextGuaranteeS = nextGuaranteeS and nextGuaranteeS or -1
	self._isActivity = isActivity
	self._unpackNum = num
	self._echoCardPackId = itemId
end

function M:getGuaranteeData()
	return self._nextGuaranteeA, self._nextGuaranteeS
end

function M:getUnpackNum()
	return self._unpackNum
end

function M:isActivityUnpack()
	return self._isActivity
end

function M:getEchoCardPackId()
	return self._echoCardPackId
end

function M:getEchoPoolConfig(itemId)
	local list = EchoCardPackConfig.instance:getEchoLotteryPoolList()

	for i = 1, #list do
		local cfg = list[i]

		if cfg.cost == itemId then
			return cfg
		end
	end

	return nil
end

function M:setSkipState(value)
	self._skipState = value
end

function M:getSkipState()
	return self._skipState
end

function M:setUnpackState(value)
	self._unpackState = value
end

function M:getUnpackState()
	return self._unpackState
end

function M:setHorizontalState(value)
	self._isHorizontal = value
end

function M:getHorizontalState()
	if self._isHorizontal == nil then
		return true
	end

	return self._isHorizontal
end

function M:setShowCutInState(value)
	self._showCutInState = value
end

function M:getShowCutInState()
	return self._showCutInState
end

function M:setModelInitState(value)
	self._modelInitState = value
end

function M:getModelInitState()
	return self._modelInitState
end

function M:setShowSEchoAnim(value)
	self._showSEchoAnim = value
end

function M:getShowSEchoAnim()
	return self._showSEchoAnim
end

M.instance = M.New()

return M
