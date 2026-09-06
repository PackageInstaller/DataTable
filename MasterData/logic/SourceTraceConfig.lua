-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sourcetrace/config/SourceTraceConfig.lua

module("logic.extensions.sourcetrace.config.SourceTraceConfig", package.seeall)

local SourceTraceConfig = class("SourceTraceConfig", BaseConfig)

function SourceTraceConfig:onInit()
	SourceTraceConfig.super.onInit(self)
end

function SourceTraceConfig:getNames()
	return {
		"source_trace_node",
		"source_trace_effect",
		"source_trace_group_info"
	}
end

function SourceTraceConfig:handleConfig(name, content)
	if name == "source_trace_node" then
		self._source_trace_node = content
	elseif name == "source_trace_effect" then
		self._source_trace_effect = content
	elseif name == "source_trace_group_info" then
		self._source_trace_group_info = content
	end
end

function SourceTraceConfig:getSourceTraceNodeCfgs(groupId)
	return self._source_trace_node[groupId]
end

function SourceTraceConfig:getSourceTraceNodeCfg(groupId, nodeId)
	if self._source_trace_node[groupId] then
		return self._source_trace_node[groupId][nodeId]
	end
end

function SourceTraceConfig:getEffectCfg(effectId)
	return self._source_trace_effect[effectId]
end

function SourceTraceConfig:getGroupInfoCfg(groupId)
	return self._source_trace_group_info[groupId]
end

SourceTraceConfig.instance = SourceTraceConfig.New()

return SourceTraceConfig
