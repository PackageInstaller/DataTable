-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/theater/config/TheaterConfig.lua

module("logic.extensions.theater.config.TheaterConfig", package.seeall)

local TheaterConfig = class("TheaterConfig", BaseConfig)

function TheaterConfig:onInit()
	TheaterConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function TheaterConfig:getNames()
	return {
		"theater_rule",
		"theater_content",
		"theater_action",
		"theater_expression",
		"theater_dialog",
		"dream_theater",
		"theater_config",
		"theater_face"
	}
end

function TheaterConfig:handleConfig(name, content)
	if name == "theater_rule" then
		self._rule = content
	elseif name == "theater_content" then
		self._content = content
	elseif name == "theater_action" then
		self._action = content
	elseif name == "theater_expression" then
		self._expression = content
	elseif name == "theater_dialog" then
		self._dialog = content
	elseif name == "dream_theater" then
		self._dreamTheater = content
	elseif name == "theater_config" then
		self._config = content
	elseif name == "theater_face" then
		self._face = content
	end
end

function TheaterConfig:getRuleById(id)
	return self._rule[id]
end

function TheaterConfig:getRule()
	return self._rule
end

function TheaterConfig:getContentById(id)
	return self._content[id]
end

function TheaterConfig:getContent()
	return self._content
end

function TheaterConfig:getActionById(id)
	return self._action[id]
end

function TheaterConfig:getAction()
	return self._action
end

function TheaterConfig:getExpressionById(id)
	return self._expression[id]
end

function TheaterConfig:getExpression()
	return self._expression
end

function TheaterConfig:getDialogById(id)
	return self._dialog[id]
end

function TheaterConfig:getDialog()
	return self._dialog
end

function TheaterConfig:getDreamTheater()
	return self._dreamTheater
end

function TheaterConfig:getConfigValueByKey(key)
	return self._config[key].value
end

function TheaterConfig:getFaceById(id)
	return self._face[id]
end

function TheaterConfig:getFace()
	return self._face
end

TheaterConfig.instance = TheaterConfig.New()

return TheaterConfig
