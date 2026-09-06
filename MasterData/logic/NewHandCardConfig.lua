-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandcard/config/NewHandCardConfig.lua

module("logic.extensions.newhandcard.config.NewHandCardConfig", package.seeall)

local NewHandCardConfig = class("NewHandCardConfig", BaseConfig)

function NewHandCardConfig:onInit()
	NewHandCardConfig.super.onInit(self)
end

function NewHandCardConfig:getNames()
	return {
		"new_hand_card"
	}
end

function NewHandCardConfig:handleConfig(name, content)
	if name == "new_hand_card" then
		self._new_hand_cardCfg = content
	end
end

function NewHandCardConfig:getCfgById(id)
	return self._new_hand_cardCfg[id]
end

function NewHandCardConfig:getLeftTime()
	return math.ceil(RoleModel.instance:getActiveTimeSec()) + self:_getOpenHours() * 3600 - ServerTime.now()
end

function NewHandCardConfig:_getOpenHours()
	if not self._openHours then
		local cfg = self:getCfgById(1)

		self._openHours = checknumber(cfg.openHours)
	end

	return self._openHours
end

function NewHandCardConfig:getOpenAndCloseTime()
	local openTime = RoleModel.instance:getActiveTimeSec()

	return openTime, openTime + self:_getOpenHours() * 3600
end

function NewHandCardConfig:getDuration()
	local cfg = self:getCfgById(1)

	return cfg.duration
end

NewHandCardConfig.instance = NewHandCardConfig.New()

return NewHandCardConfig
