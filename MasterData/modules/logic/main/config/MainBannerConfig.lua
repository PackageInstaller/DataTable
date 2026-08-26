-- chunkname: @modules/logic/main/config/MainBannerConfig.lua

module("modules.logic.main.config.MainBannerConfig", package.seeall)

local MainBannerConfig = class("MainBannerConfig", BaseConfig)

function MainBannerConfig:ctor()
	self.bannerconfig = nil
	self.nowbanner = {}
end

function MainBannerConfig:reqConfigNames()
	return {
		"main_banner"
	}
end

function MainBannerConfig:onConfigLoaded(configName, configTable)
	if configName == "main_banner" then
		self.bannerconfig = configTable
	end
end

function MainBannerConfig:getbannerCO(id)
	return self.bannerconfig.configDict[id]
end

function MainBannerConfig:getBannersCo()
	return self.bannerconfig.configDict
end

function MainBannerConfig:getNowBanner(nowtime)
	local nowbanner = {}

	for k, v in pairs(self.bannerconfig.configDict) do
		if v.startEnd ~= "" then
			local times = {}
			local dates = string.split(v.startEnd, "#")

			for x, y in pairs(dates) do
				local time = TimeUtil.stringToTimestamp(y)

				table.insert(times, time)
			end

			if nowtime > times[1] and nowtime < times[2] then
				table.insert(nowbanner, v.id)
			end
		else
			table.insert(nowbanner, v.id)
		end
	end

	nowbanner = self:_cleckCondition(nowbanner)
	nowbanner = self:_checkid(nowbanner)

	table.sort(nowbanner, function(a, b)
		local asort = self.bannerconfig.configDict[a].sortId
		local bsort = self.bannerconfig.configDict[b].sortId

		if asort == bsort then
			return a < b
		else
			return asort < bsort
		end
	end)

	local newbanner = {}

	for k, v in pairs(nowbanner) do
		if k <= 3 then
			table.insert(newbanner, v)
		end
	end

	self.nowbanner = newbanner

	return newbanner
end

function MainBannerConfig:_cleckCondition(banners)
	local nowbanner = {}

	for k, v in pairs(banners) do
		local condition = self.bannerconfig.configDict[v].appearanceRole

		if condition ~= "" then
			local conditions = string.split(condition, "#")

			if conditions[1] == "1" then
				local lastEpisodeId = PlayerModel.instance:getPlayinfo().lastEpisodeId

				if tonumber(lastEpisodeId) > tonumber(conditions[2]) then
					table.insert(nowbanner, v)
				end
			end
		else
			table.insert(nowbanner, v)
		end
	end

	return nowbanner
end

function MainBannerConfig:_checkid(ids)
	local newids = {}

	for k, v in pairs(ids) do
		if not self:_clecknum(v) then
			table.insert(newids, v)
		end
	end

	return newids
end

function MainBannerConfig:_clecknum(num)
	local notShowIds = MainBannerModel.instance:getBannerInfo()

	for _, v in pairs(notShowIds) do
		if v == num then
			return true
		end
	end
end

function MainBannerConfig:getNearTime(time, banners)
	local nexttimes = {}

	for k, v in pairs(banners) do
		if self.bannerconfig.configDict[v].startEnd ~= "" then
			local date = string.split(self.bannerconfig.configDict[v].startEnd, "#")
			local endtime = TimeUtil.stringToTimestamp(date[2])

			if time <= endtime then
				local disapear = {
					time = endtime,
					id = v
				}

				table.insert(nexttimes, disapear)
			end
		end
	end

	table.sort(nexttimes, function(a, b)
		return a.time < b.time
	end)

	return nexttimes[1]
end

MainBannerConfig.instance = MainBannerConfig.New()

return MainBannerConfig
