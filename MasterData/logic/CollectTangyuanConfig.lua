-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collecttangyuan/config/CollectTangyuanConfig.lua

module("logic.extensions.collecttangyuan.config.CollectTangyuanConfig", package.seeall)

local CollectTangyuanConfig = class("CollectTangyuanConfig", BaseConfig)

function CollectTangyuanConfig:onInit()
	CollectTangyuanConfig.super.onInit(self)

	self._ykeActivityCfgs = nil
	self._ykeGroupCfgs = nil
	self._ykePrizeCfgs = nil
	self._ykeTaskCfgs = nil
end

function CollectTangyuanConfig:getNames()
	return {
		"yuanxiao_kings_exchange_activity",
		"yuanxiao_kings_exchange_group",
		"yuanxiao_kings_exchange_prize",
		"yuanxiao_kings_exchange_task"
	}
end

function CollectTangyuanConfig:handleConfig(name, content)
	if name == "yuanxiao_kings_exchange_activity" then
		self._ykeActivityCfgs = content
	elseif name == "yuanxiao_kings_exchange_group" then
		self._ykeGroupCfgs = content
	elseif name == "yuanxiao_kings_exchange_prize" then
		self._ykePrizeCfgs = content
	elseif name == "yuanxiao_kings_exchange_task" then
		self._ykeTaskCfgs = content
	end
end

function CollectTangyuanConfig:getCollectTangyuanActivityId(actId)
	if self._ykeActivityCfgs == nil then
		return nil
	end

	return self._ykeActivityCfgs[actId]
end

function CollectTangyuanConfig:getCollectTangyuanGroups(planId)
	if self._ykeGroupCfgs == nil then
		return nil
	end

	return self._ykeGroupCfgs[planId]
end

function CollectTangyuanConfig:getCollectTangyuanPrizes(planId, prizeId)
	if self._ykePrizeCfgs == nil then
		return nil
	end

	prizeId = checknumber(prizeId)

	local list = self._ykePrizeCfgs[planId]

	if list == nil or list[prizeId] == nil then
		return nil
	end

	return list[prizeId]
end

function CollectTangyuanConfig:getCollectTangyuanTasks(planId)
	if self._ykeTaskCfgs == nil then
		return nil
	end

	return self._ykeTaskCfgs[planId]
end

CollectTangyuanConfig.instance = CollectTangyuanConfig.New()

return CollectTangyuanConfig
