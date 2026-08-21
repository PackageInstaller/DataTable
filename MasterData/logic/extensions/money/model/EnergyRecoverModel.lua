-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/money/model/EnergyRecoverModel.lua

module("logic.extensions.money.model.EnergyRecoverModel", package.seeall)

local CurrencyCodeEnum = CommEnum.CurrencyCodeEnum
local M = class("EnergyRecoverModel", BaseModel)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self._constEnergyRecoverTime = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.EnergyRecoverTime)

	self:onReset()
end

function M:onReset()
	self.energyRecoverTime = nil
end

function M:setEnergyRecoverTime(recoverTime)
	if recoverTime then
		if checknumber(recoverTime) then
			local leftTime = recoverTime

			if leftTime >= 0 then
				local constEnergyRecoverTime = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.EnergyRecoverTime)

				leftTime = constEnergyRecoverTime - leftTime
			end

			if self.energyRecoverTime == nil then
				self.energyRecoverTime = -2
			end

			if self.energyRecoverTime ~= leftTime then
				self.energyRecoverTime = leftTime

				GlobalDispatcher:dispatchEvent(MoneyEventType.ENERGY_RECOVER_TIME_SERVER_CHANGE, self.energyRecoverTime)
				self:dispatcherRecoverTime(self:getEnergyRecoverTime())
			end
		else
			printWarn("尝试设置体力恢复时间,checkNumber不通过")
		end
	else
		printWarn("尝试设置体力恢复时间为nil")
	end
end

function M:forceSetEnergyRecoverTime(recoverTime)
	self.energyRecoverTime = recoverTime

	self:dispatcherRecoverTime(self:getEnergyRecoverTime())
end

function M:getEnergyRecoverTime()
	return self.energyRecoverTime
end

function M:getEnergyRecoverTimeAll()
	local leftTime = self:getEnergyRecoverTime()
	local totalLeftTime = 0
	local curEnergyNum = HealthExchangeModel.instance:getCurEnergy()
	local maxValue = PlayerModel.instance:getEnergyLimit()

	totalLeftTime = self._constEnergyRecoverTime * (maxValue - curEnergyNum) - (self._constEnergyRecoverTime - leftTime)

	return leftTime, totalLeftTime
end

function M:getHintTxt(leftTime)
	local hintStr = ""

	if leftTime == nil then
		leftTime = self:getEnergyRecoverTime()
	end

	if leftTime ~= nil then
		if self:isEnergyMaxConfig() then
			hintStr = lang("tip_energy_recover_max")
		else
			hintStr = leftTime >= 0 and string.format(lang("tip_energy_recover_predict"), TextFormatter.formatClockTime(leftTime)) or ""
		end
	end

	return hintStr
end

function M:dispatcherRecoverTime(leftTime)
	local code = CommEnum.CurrencyCodeEnum.TlCode
	local hintStr = self:getHintTxt(leftTime)

	GlobalDispatcher:dispatchEvent(MoneyEventType.MONEY_ITEM_HINT_CHANGE, code, hintStr)
end

function M:isEnergyMaxConfig()
	local itemCount = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.TlCode)
	local maxValue = ConstConfig.instance:getNumValueByKey(ConstConfigKeyEnum.EnergyMax)

	return maxValue <= itemCount
end

function M:isEnergyMaxLimit()
	local itemCount = ItemModel.instance:getItemCountByItemId(CommEnum.CurrencyCodeEnum.TlCode)
	local maxValue = PlayerModel.instance:getEnergyLimit()

	return maxValue <= itemCount
end

M.instance = M.New()

return M
