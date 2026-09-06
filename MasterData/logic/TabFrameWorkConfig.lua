-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tabframework/config/TabFrameWorkConfig.lua

module("logic.extensions.tabframework.config.TabFrameWorkConfig", package.seeall)

local TabFrameWorkConfig = class("TabFrameWorkConfig", BaseConfig)

function TabFrameWorkConfig:onInit()
	TabFrameWorkConfig.super.onInit(self)
end

function TabFrameWorkConfig:getNames()
	return {
		"tab_frame_work_base",
		"tab_frame_work_tab",
		"tab_frame_work_sec_tab"
	}
end

function TabFrameWorkConfig:handleConfig(name, content)
	if name == "tab_frame_work_base" then
		self._fwBaseCfg = content
		self._fwBaseDataList = content.dataList
	elseif name == "tab_frame_work_tab" then
		self._fwTabCfgs = content
	elseif name == "tab_frame_work_sec_tab" then
		self._fwSecTabCfgs = content
	end
end

function TabFrameWorkConfig:getFwBaseDataList()
	return self._fwBaseDataList
end

function TabFrameWorkConfig:getFwBaseData(frameId)
	return self._fwBaseCfg[frameId]
end

function TabFrameWorkConfig:getFwTotalRedId(frameId)
	return self:getFwBaseData(frameId).totalRedId
end

function TabFrameWorkConfig:getFwTabCfg(frameId)
	local baseData = self:getFwBaseData(frameId) or {}

	return self._fwTabCfgs[baseData.tabPlanId]
end

function TabFrameWorkConfig:getFwTabData(frameId, headTabId)
	return self:getFwTabCfg(frameId)[headTabId]
end

function TabFrameWorkConfig:getFwSecTabCfg(frameId, headTabId)
	local cfg
	local tabPlanId = self:getFwBaseData(frameId).tabPlanId

	return (self._fwSecTabCfgs[tabPlanId] or nil) and self._fwSecTabCfgs[tabPlanId][headTabId]
end

function TabFrameWorkConfig:getFwSecTabData(frameId, headTabId, secTabId)
	local cfg = self:getFwSecTabCfg(frameId, headTabId)

	return cfg and cfg[secTabId]
end

TabFrameWorkConfig.instance = TabFrameWorkConfig.New()

return TabFrameWorkConfig
