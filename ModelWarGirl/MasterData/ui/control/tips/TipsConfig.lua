-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Tips\\TipsConfig.lua

local strClassName = "TipsConfig"
local TipsConfig = Class(strClassName)

function TipsConfig:ctor()
	self.mInfoMap = {}
end

function TipsConfig:addConfig(funcUI, funcName, funcUse, funcVisible, funcEnable, btnIdx)
	if funcUI == nil or funcName == nil or funcUse == nil then
		return
	end

	for i, info in ipairs(self.mInfoMap) do
		if info.name == funcName then
			table.remove(self.mInfoMap, i)

			break
		end
	end

	local info = {
		ui = funcUI,
		name = funcName,
		use = funcUse,
		visible = funcVisible,
		enable = funcEnable,
		idx = btnIdx
	}

	table.insert(self.mInfoMap, info)
end

function TipsConfig:delConfig(funcName)
	for i, info in ipairs(self.mInfoMap) do
		if info.name == funcName then
			table.remove(self.mInfoMap, i)
		end
	end
end

function TipsConfig:clear()
	self.mInfoMap = {}
end

function TipsConfig:getConfigs(sender)
	local configs = {}

	for i, info in ipairs(self.mInfoMap) do
		if info.use ~= nil then
			table.insert(configs, info)
		end
	end

	return configs
end

return TipsConfig
