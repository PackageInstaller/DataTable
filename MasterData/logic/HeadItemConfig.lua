-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/headitem/config/HeadItemConfig.lua

module("logic.extensions.headitem.config.HeadItemConfig", package.seeall)

local HeadItemConfig = class("HeadItemConfig", BaseConfig)

function HeadItemConfig:onInit()
	HeadItemConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function HeadItemConfig:getNames()
	return {
		"head_icon",
		"head_frame"
	}
end

function HeadItemConfig:handleConfig(name, content)
	if name == "head_icon" then
		self._head_iconCfg = content
	elseif name == "head_frame" then
		self._head_frameCfg = content
	end
end

function HeadItemConfig:getAllHeadIconList()
	return self._head_iconCfg.dataList
end

function HeadItemConfig:getAllHeadFrameList()
	return self._head_frameCfg.dataList
end

function HeadItemConfig:getHeadIconById(id)
	return self._head_iconCfg[id]
end

function HeadItemConfig:getHeadFrameById(id)
	return self._head_frameCfg[id]
end

HeadItemConfig.instance = HeadItemConfig.New()

return HeadItemConfig
