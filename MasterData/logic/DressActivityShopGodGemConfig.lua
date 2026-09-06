-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/config/DressActivityShopGodGemConfig.lua

module("logic.extensions.dressactivityshop.config.DressActivityShopGodGemConfig", package.seeall)

local DressActivityShopGodGemConfig = class("DressActivityShopGodGemConfig", BaseConfig)

function DressActivityShopGodGemConfig:onInit()
	DressActivityShopGodGemConfig.super.onInit(self)
	self:onReset()
end

function DressActivityShopGodGemConfig:onReset()
	self._singleCfgs = nil
	self._suitCfgs = nil
	self._pay_truss_god_gem_coalition = nil
end

function DressActivityShopGodGemConfig:getNames()
	return {
		"pay_truss_god_gem_single",
		"pay_truss_god_gem_coalition",
		"pay_truss_god_gem_run"
	}
end

function DressActivityShopGodGemConfig:handleConfig(name, content)
	if name == "pay_truss_god_gem_single" then
		self._singleCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._singleCfgs[v.activityId] = self._singleCfgs[v.activityId] or {}
			self._singleCfgs[v.activityId][v.id] = v
		end
	elseif name == "pay_truss_god_gem_coalition" then
		self._suitCfgs = {}
		self._pay_truss_god_gem_coalition = content

		for _, line in ipairs(content.dataList) do
			self._suitCfgs[line.activityId] = line
		end
	elseif name == "pay_truss_god_gem_run" then
		self._runCfg = content
		self._runDataList = content.dataList
	end
end

function DressActivityShopGodGemConfig:getSingleCfgByActId(actId)
	if actId and self._singleCfgs[actId] then
		return self._singleCfgs[actId]
	end

	return {}
end

function DressActivityShopGodGemConfig:getSuitCfgByActIdAndHasOwnTab(actId, hasOwnTab)
	if hasOwnTab and #hasOwnTab > 0 then
		return nil
	end

	if actId and self._suitCfgs[actId] then
		return self._suitCfgs[actId]
	end

	return nil
end

function DressActivityShopGodGemConfig:getSuitCfgByActId(actId)
	local list = self._pay_truss_god_gem_coalition.dataList

	for i, v in ipairs(list) do
		if v.activityId == actId then
			return v
		end
	end
end

function DressActivityShopGodGemConfig:getHasOwnKeyByTable(hasOwnTab)
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

function DressActivityShopGodGemConfig:getRunDataList()
	return self._runDataList
end

function DressActivityShopGodGemConfig:getRunData(activityId)
	return self._runCfg[activityId]
end

DressActivityShopGodGemConfig.instance = DressActivityShopGodGemConfig.New()

return DressActivityShopGodGemConfig
