-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dialogue/config/DialogueConfig.lua

module("logic.extensions.dialogue.config.DialogueConfig", package.seeall)

local DialogueConfig = class("DialogueConfig", BaseConfig)

function DialogueConfig:onInit()
	DialogueConfig.super.onInit(self)
end

function DialogueConfig:getNames()
	return {
		"dialog"
	}
end

function DialogueConfig:handleConfig(name, content)
	if name == "dialog" then
		self._dialog = content
	end
end

function DialogueConfig:getDialogById(id)
	return self._dialog[id]
end

DialogueConfig.instance = DialogueConfig.New()

return DialogueConfig
