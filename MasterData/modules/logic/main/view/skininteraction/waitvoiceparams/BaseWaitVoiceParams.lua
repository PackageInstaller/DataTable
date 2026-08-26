-- chunkname: @modules/logic/main/view/skininteraction/waitvoiceparams/BaseWaitVoiceParams.lua

module("modules.logic.main.view.skininteraction.waitvoiceparams.BaseWaitVoiceParams", package.seeall)

local BaseWaitVoiceParams = class("BaseWaitVoiceParams")

function BaseWaitVoiceParams.getWaitVoiceParamsObj(type)
	local clsName = CharacterVoiceEnum.WaitVoiceParamsCls[type]
	local cls = clsName and _G[clsName]

	if cls then
		return cls.New()
	end
end

function BaseWaitVoiceParams:init(list)
	return
end

function BaseWaitVoiceParams:isWaitVoice(audio)
	return
end

function BaseWaitVoiceParams:selectFromGroup(config)
	return config
end

function BaseWaitVoiceParams:onDestroy()
	return
end

return BaseWaitVoiceParams
