-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinebounty/config/DivineBountyConfig.lua

module("logic.extensions.divinebounty.config.DivineBountyConfig", package.seeall)

local DivineBountyConfig = class("DivineBountyConfig", BaseConfig)

function DivineBountyConfig:getNames()
	DivineBountyConfig.super.getNames(self)

	return {
		"divine_bounty_common_vars",
		"divine_bounty_lottery_prize",
		"divine_bounty_lottery_progress_prize",
		"divine_bounty_lottery_shop_item"
	}
end

function DivineBountyConfig:handleConfig(name, content)
	if name == "divine_bounty_common_vars" then
		self.commonCfg = content
	elseif name == "divine_bounty_lottery_prize" then
		self.lotteryPrizeCfgs = content
	elseif name == "divine_bounty_lottery_progress_prize" then
		self.progressPrizeCfgs = content
	elseif name == "divine_bounty_lottery_shop_item" then
		self.shopCfg = content

		self:_sortShopMapByTabId()
	end
end

function DivineBountyConfig:getCommonCfg(key)
	return self.commonCfg[key].value
end

function DivineBountyConfig:getLotteryPrizeCfgs()
	return self.lotteryPrizeCfgs
end

function DivineBountyConfig:getProgressPrizeCfgs()
	return self.progressPrizeCfgs
end

function DivineBountyConfig:getShopCfg()
	local cfg = {}

	for i, v in ipairs(self.shopCfg) do
		local timeEnough = false

		if not v.offlineTime then
			local onlineTime = GameUtil.string2time(v.onlineTime)
			local curTime = ServerTime.now()

			if onlineTime <= curTime then
				timeEnough = true
			end
		else
			timeEnough = GameUtil.checkIsInTimePeriod(v.onlineTime, v.offlineTime)
		end

		if timeEnough then
			table.insert(cfg, v)
		end
	end

	return cfg
end

function DivineBountyConfig:_sortShopMapByTabId()
	local shopMap = {}
	local shopCfg = self:getShopCfg()

	self._shopTabIdList = {}
	self._maxTabId = 0

	for i, v in ipairs(shopCfg) do
		local tabId = v.tabId

		self._maxTabId = math.max(self._maxTabId, tabId)

		if shopMap[tabId] == nil then
			table.insert(self._shopTabIdList, tabId)
		end

		shopMap[tabId] = shopMap[tabId] or {}

		table.insert(shopMap[tabId], v)
	end

	table.sort(self._shopTabIdList, function(a, b)
		return b < a
	end)

	self._shopMap = shopMap
end

function DivineBountyConfig:getShopCfgsByTabId(tabId)
	return self._shopMap[tabId]
end

function DivineBountyConfig:getShopCfgsMap()
	self:_sortShopMapByTabId()

	return self._shopMap
end

function DivineBountyConfig:getShopTabIdList()
	return self._shopTabIdList
end

function DivineBountyConfig:getMaxShopTabId()
	return self._maxTabId
end

function DivineBountyConfig:getShopItemCfg(itemId)
	local cfg = self:getShopCfg()

	return self.shopCfg[itemId]
end

DivineBountyConfig.instance = DivineBountyConfig.New()

return DivineBountyConfig
