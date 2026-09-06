-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/config/XiaoNuoAssistantConfig.lua

module("logic.extensions.xiaonuoassistant.config.XiaoNuoAssistantConfig", package.seeall)

local XiaoNuoAssistantConfig = class("XiaoNuoAssistantConfig", BaseConfig)

function XiaoNuoAssistantConfig:onInit()
	XiaoNuoAssistantConfig.super.onInit(self)

	self.xiaonuo_assistant_tab = nil
	self.xiaonuo_assistant_str = nil
end

function XiaoNuoAssistantConfig:getNames()
	return {
		"xiaonuo_assistant_tab",
		"xiaonuo_assistant_str",
		"xiaonuo_assistant_sign_in_buff"
	}
end

function XiaoNuoAssistantConfig:handleConfig(name, content)
	if name == "xiaonuo_assistant_tab" then
		self.xiaonuo_assistant_tab = content
	elseif name == "xiaonuo_assistant_str" then
		self.xiaonuo_assistant_str = content
		self.strDic = self:_handleStrDic(content)
	elseif name == "xiaonuo_assistant_sign_in_buff" then
		self._xiaonuo_assistant_sign_in_buff = content
	end
end

function XiaoNuoAssistantConfig:getTabCfg(id)
	return self.xiaonuo_assistant_tab[id]
end

function XiaoNuoAssistantConfig:getSignInBuffList()
	return self._xiaonuo_assistant_sign_in_buff.dataList
end

function XiaoNuoAssistantConfig:getStrCfg(funcId)
	return self.strDic[funcId]
end

function XiaoNuoAssistantConfig:_handleStrDic(content)
	local dic = {}

	for i, v in ipairs(content.dataList) do
		dic[v.funcId] = v
	end

	return dic
end

XiaoNuoAssistantConfig.instance = XiaoNuoAssistantConfig.New()

return XiaoNuoAssistantConfig
