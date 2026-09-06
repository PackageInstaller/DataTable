-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sevendays/config/TreasureBoxConfig.lua

module("logic.extensions.sevendays.config.TreasureBoxConfig", package.seeall)

local TreasureBoxConfig = class("TreasureBoxConfig", BaseConfig)

function TreasureBoxConfig:onInit()
	TreasureBoxConfig.super.onInit(self)

	self.consumeCfgs = nil
	self.baodiCfgs = nil
	self.shopBuyCfgs = nil
	self.zhouqiCfgs = nil
	self.jiangliCfgs = nil
end

function TreasureBoxConfig:getNames()
	return {
		"wishing_well",
		"wishing_well_security",
		"wishing_well_shop",
		"wishing_well_cycle",
		"wishing_well_prize_plan"
	}
end

function TreasureBoxConfig:handleConfig(name, content)
	if name == "wishing_well" then
		self.consumeCfgs = content
	elseif name == "wishing_well_security" then
		self:SetBaodiCfgs(content)
	elseif name == "wishing_well_shop" then
		self.shopBuyCfgs = content
	elseif name == "wishing_well_cycle" then
		self:SetZhouqiAllPlan(content)
	elseif name == "wishing_well_prize_plan" then
		self:SetJiangliAllGoods(content)
	end
end

function TreasureBoxConfig:GetConsumeCfg(activityId)
	return self.consumeCfgs[activityId]
end

function TreasureBoxConfig:SetBaodiCfgs(content)
	self.baodiCfgs = {}

	for planId, list in pairs(content or {}) do
		if checknumber(planId) > 0 then
			if self.baodiCfgs[planId] == nil then
				self.baodiCfgs[planId] = {}
			end

			for _, cfg in pairs(list or {}) do
				if cfg and checknumber(cfg.planId) > 0 then
					table.insert(self.baodiCfgs[planId], cfg)
				end
			end
		end
	end

	for _, list in pairs(self.baodiCfgs) do
		if list and #list > 1 then
			table.sort(list, function(a, b)
				return a.times < b.times
			end)
		end
	end
end

function TreasureBoxConfig:GetBaodiCfg(planId)
	return self.baodiCfgs[planId]
end

function TreasureBoxConfig:GetShopBuyCfg(planId, boxId)
	local list = self.shopBuyCfgs[planId]

	if list == nil or checknumber(boxId) <= 0 then
		return list
	end

	return list[checknumber(boxId)]
end

function TreasureBoxConfig:SetJiangliAllGoods(data)
	if data == nil then
		return
	end

	self.jiangliCfgs = {}

	for planId, list in pairs(data) do
		if planId and list then
			self.jiangliCfgs[planId] = self.jiangliCfgs[planId] or {}

			for _, cfg in pairs(list) do
				if cfg and not string.nilorempty(cfg.prize) then
					self.jiangliCfgs[planId][cfg.prize] = cfg.prize
				end
			end
		end
	end
end

function TreasureBoxConfig:SetZhouqiAllPlan(data)
	if data == nil then
		return
	end

	self.zhouqiCfgs = {}

	for planId, list in pairs(data) do
		if planId and list then
			self.zhouqiCfgs[planId] = self.zhouqiCfgs[planId] or {}

			for _, cfg in pairs(list) do
				if cfg and cfg.prizePlanId then
					table.insert(self.zhouqiCfgs[planId], cfg.prizePlanId)
				end
			end
		end
	end
end

function TreasureBoxConfig:GetZhouqiJiangliList(planId, isMerge)
	if checknumber(planId) < 1 then
		return
	end

	local zhouqis = self.zhouqiCfgs[planId]

	if zhouqis == nil or #zhouqis == 0 then
		return
	end

	local list = {}

	for i = 1, #zhouqis do
		if zhouqis[i] and zhouqis[i] > 0 then
			local jianglis = self.jiangliCfgs[zhouqis[i]]

			if jianglis and next(jianglis) then
				table.insert(list, jianglis)
			end
		end
	end

	if not isMerge or #list < 1 then
		return list
	end

	local merges = {}

	for i = 1, #list do
		for _, str in pairs(list[i] or {}) do
			if not string.nilorempty(str) then
				merges[str] = str
			end
		end
	end

	return merges
end

TreasureBoxConfig.instance = TreasureBoxConfig.New()

return TreasureBoxConfig
