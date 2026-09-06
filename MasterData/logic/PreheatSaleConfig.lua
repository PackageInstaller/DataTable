-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/preheatsale/config/PreheatSaleConfig.lua

module("logic.extensions.preheatsale.config.PreheatSaleConfig", package.seeall)

local PreheatSaleConfig = class("PreheatSaleConfig", BaseConfig)

function PreheatSaleConfig:onInit()
	PreheatSaleConfig.super.onInit(self)

	self._commonCfgs = nil
end

function PreheatSaleConfig:getNames()
	return {
		"preheat_sale",
		"preheat_sale_emojipack"
	}
end

function PreheatSaleConfig:handleConfig(name, content)
	if name == "preheat_sale" then
		self._commonCfgs = content
	elseif name == "preheat_sale_emojipack" then
		self.preheat_sale_emojipackCfg = content
	end
end

function PreheatSaleConfig:getcommonCfg(actId)
	return self._commonCfgs[actId]
end

function PreheatSaleConfig:getActEmojipackCfg(actId)
	return self.preheat_sale_emojipackCfg[actId]
end

PreheatSaleConfig.instance = PreheatSaleConfig.New()

return PreheatSaleConfig
