-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/config/VersionGiftConfig.lua

module("logic.extensions.bonus.config.VersionGiftConfig", package.seeall)

local VersionGiftConfig = class("VersionGiftConfig", BaseConfig)

function VersionGiftConfig:onInit()
	VersionGiftConfig.super.onInit(self)

	self._allTableCfgs = nil
	self._allShopCfgs = nil
end

function VersionGiftConfig:getNames()
	return {
		"version_gift_table",
		"version_gift_shop"
	}
end

function VersionGiftConfig:handleConfig(name, content)
	if name == "version_gift_table" then
		self._allTableCfgs = content
	elseif name == "version_gift_shop" then
		self._allShopCfgs = content
	end
end

function VersionGiftConfig:getShowVersionGiftTables()
	if self._allTableCfgs == nil then
		return {}
	end

	local temp = {}

	for _, cfg in pairs(self._allTableCfgs) do
		if cfg and cfg.isShow and GameUtil.checkIsInTimePeriod(cfg.startTime, cfg.endTime) then
			table.insert(temp, cfg)
		end
	end

	if #temp > 1 then
		table.sort(temp, function(a, b)
			return a.tabId < b.tabId
		end)
	end

	return temp
end

function VersionGiftConfig:getVersionGiftTable(tabId)
	if self._allTableCfgs == nil or self._allTableCfgs[tabId] == nil then
		return
	end

	return self._allTableCfgs[tabId]
end

function VersionGiftConfig:getShowVersionGiftShopCfgs(planId)
	local list = self:getVersionGiftShopCfg(planId)
	local temp = {}
	local cfg

	for _, v in pairs(list or {}) do
		if v and v.shopId then
			cfg = PayShopConfig.instance:getPayShopGoodsCfgById(v.shopId)

			if cfg and GameUtil.checkIsInTimePeriod(cfg.onlineTime, cfg.offlineTime) then
				local sellCount = PayShopModel.instance:getMibaoBuyTimesById(v.shopId)
				local isSellOut = cfg.limitType ~= "none" and cfg.limitTimes > 0 and sellCount >= cfg.limitTimes

				isSellOut = isSellOut or PayShopModel.instance:chechShopGoodsSkillHave(cfg)

				table.insert(temp, {
					goodsData = {
						id = v.shopId,
						times = sellCount
					},
					payCfg = cfg,
					index = v.index,
					sellState = isSellOut and 1 or 0
				})
			end
		end
	end

	if temp and #temp > 1 then
		table.sort(temp, function(a, b)
			if a.sellState == b.sellState then
				return a.index < b.index
			end

			return a.sellState < b.sellState
		end)
	end

	return temp
end

function VersionGiftConfig:getVersionGiftShopCfg(planId)
	if self._allShopCfgs == nil or self._allShopCfgs[planId] == nil then
		return
	end

	return self._allShopCfgs[planId]
end

VersionGiftConfig.instance = VersionGiftConfig.New()

return VersionGiftConfig
