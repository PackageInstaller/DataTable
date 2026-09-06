-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/config/DressActivityShopConfig.lua

module("logic.extensions.dressactivityshop.config.DressActivityShopConfig", package.seeall)

local DressActivityShopConfig = class("DressActivityShopConfig", BaseConfig)

function DressActivityShopConfig:onInit()
	DressActivityShopConfig.super.onInit(self)
	self:onReset()
end

function DressActivityShopConfig:onReset()
	self._singleCfgs = nil
	self._suitCfgs = nil
end

function DressActivityShopConfig:getNames()
	return {
		"pay_truss_single",
		"pay_truss_coalition"
	}
end

function DressActivityShopConfig:handleConfig(name, content)
	if name == "pay_truss_single" then
		self._singleCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._singleCfgs[v.activityId] = self._singleCfgs[v.activityId] or {}
			self._singleCfgs[v.activityId][v.id] = v
		end
	elseif name == "pay_truss_coalition" then
		self._suitCfgs = {}

		for _, line in ipairs(content.dataList) do
			self._suitCfgs[line.activityId] = self._suitCfgs[line.activityId] or {}

			local key = self:getHasOwnKeyByTable(line.purchasedIds)

			self._suitCfgs[line.activityId][key] = line
		end
	end
end

function DressActivityShopConfig:getSingleCfgByActId(actId)
	if actId and self._singleCfgs[actId] then
		return self._singleCfgs[actId]
	end

	return {}
end

function DressActivityShopConfig:getSuitCfgByActIdAndHasOwnTab(actId, hasOwnTab)
	local key = self:getHasOwnKeyByTable(hasOwnTab)

	if actId and self._suitCfgs[actId] then
		return self._suitCfgs[actId][key]
	end

	return nil
end

function DressActivityShopConfig:getHasOwnKeyByTable(hasOwnTab)
	local suitTable = hasOwnTab or {}

	table.sort(suitTable, function(a, b)
		return a < b
	end)

	local key = ""

	for _, id in ipairs(suitTable) do
		key = key .. id
	end

	return key
end

DressActivityShopConfig.instance = DressActivityShopConfig.New()

return DressActivityShopConfig
