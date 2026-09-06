-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendiamondcard/config/GoldenDiamondCardConfig.lua

module("logic.extensions.goldendiamondcard.config.GoldenDiamondCardConfig", package.seeall)

local GoldenDiamondCardConfig = class("GoldenDiamondCardConfig", BaseConfig)

function GoldenDiamondCardConfig:getNames()
	return {
		"golden_diamond_card_params",
		"golden_diamond_privilege",
		"golden_diamond_timed_buy"
	}
end

function GoldenDiamondCardConfig:handleConfig(name, content)
	if name == "golden_diamond_card_params" then
		self._commonCfg = content
	elseif name == "golden_diamond_privilege" then
		self._privilegeCfg = content
	elseif name == "golden_diamond_timed_buy" then
		self._giftCfgs = content
	end
end

function GoldenDiamondCardConfig:getCommonValue(key)
	if self._commonCfg[key] then
		return self._commonCfg[key].value
	end
end

function GoldenDiamondCardConfig:getPrivilegeDefaultValue(type)
	if self._privilegeCfg[type] then
		return checkint(self._privilegeCfg[type].param)
	end
end

function GoldenDiamondCardConfig:getCurGiftCfgByServerTime()
	local time = ServerTime.now()

	for k, v in pairs(self._giftCfgs) do
		if GameUtil.checkIsInTimePeriod(v.startTime, v.endTime) then
			return v
		end
	end
end

GoldenDiamondCardConfig.instance = GoldenDiamondCardConfig.New()

return GoldenDiamondCardConfig
