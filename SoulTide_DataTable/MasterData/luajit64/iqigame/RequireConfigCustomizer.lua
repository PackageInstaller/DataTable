-- chunkname: @IQIGame\\RequireConfigCustomizer.lua

local nameCfg = {}

for i, cfg in pairsCfg(CfgUIConfigurationTable) do
	nameCfg[cfg.UIName] = cfg
end

CfgUIConfigurationTable.NameCfgMap = nameCfg

local pathDict = {}

for i, cfg in pairsCfg(CfgSoulOriginalResTable) do
	pathDict[cfg.Path] = 1
end

CfgSoulOriginalResTable.PathDict = pathDict
