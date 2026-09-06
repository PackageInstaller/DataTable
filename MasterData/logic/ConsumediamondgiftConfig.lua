-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/consumediamondgift/config/ConsumediamondgiftConfig.lua

module("logic.extensions.consumediamondgift.config.ConsumediamondgiftConfig", package.seeall)

local ConsumediamondgiftConfig = class("ConsumediamondgiftConfig", BaseConfig)

function ConsumediamondgiftConfig:onInit()
	return
end

function ConsumediamondgiftConfig:getNames()
	return {
		"consume_diamond_gift",
		"consume_diamond_gift_common"
	}
end

function ConsumediamondgiftConfig:handleConfig(name, content)
	if name == "consume_diamond_gift" then
		self._consume_diamond_giftCfg = content
	elseif name == "consume_diamond_gift_common" then
		self._consume_diamond_gift_commonCfg = content
	end
end

function ConsumediamondgiftConfig:getActCfg(actId)
	return self._consume_diamond_giftCfg[actId]
end

function ConsumediamondgiftConfig:getConsumeSource()
	return self._consume_diamond_gift_commonCfg.consumeSource.value
end

ConsumediamondgiftConfig.instance = ConsumediamondgiftConfig.New()

return ConsumediamondgiftConfig
