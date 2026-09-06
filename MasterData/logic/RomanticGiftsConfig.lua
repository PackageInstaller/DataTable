-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/romanticgifts/config/RomanticGiftsConfig.lua

module("logic.extensions.romanticgifts.config.RomanticGiftsConfig", package.seeall)

local RomanticGiftsConfig = class("RomanticGiftsConfig", BaseConfig)

function RomanticGiftsConfig:onInit()
	RomanticGiftsConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function RomanticGiftsConfig:getNames()
	return {
		"qixi_send_gift_zone",
		"qixi_send_gift_item",
		"qixi_send_gift_activity",
		"qixi_send_gift_sugar_rank",
		"qixi_send_gift_ramance_rank"
	}
end

function RomanticGiftsConfig:handleConfig(name, content)
	if name == "qixi_send_gift_zone" then
		self._qixi_send_gift_zone = content
	elseif name == "qixi_send_gift_item" then
		self._qixi_send_gift_item = content
	elseif name == "qixi_send_gift_activity" then
		self._qixi_send_gift_activity = content
	elseif name == "qixi_send_gift_sugar_rank" then
		self._qixi_send_gift_sugar_rank = content
	elseif name == "qixi_send_gift_ramance_rank" then
		self._qixi_send_gift_ramance_rank = content
	end
end

function RomanticGiftsConfig:getCfgById(id)
	return self._qixi_send_gift_activity[id]
end

function RomanticGiftsConfig:getZoneCfg()
	return self._qixi_send_gift_zone
end

function RomanticGiftsConfig:getFlowerCfg(actId, flowerId)
	local actCfg = self:getCfgById(actId)
	local id = checknumber(flowerId)
	local cfg = self._qixi_send_gift_item[actCfg.itemPlanId]

	if id > 0 then
		return cfg[id]
	else
		return cfg
	end
end

function RomanticGiftsConfig:getRomanRankPrize(id)
	local cfg = self:getCfgById(id)

	if cfg and self._qixi_send_gift_ramance_rank then
		return self._qixi_send_gift_ramance_rank[cfg.romancePlanId]
	end

	return nil
end

function RomanticGiftsConfig:getSweetRankPrize(id)
	local cfg = self:getCfgById(id)

	if cfg and self._qixi_send_gift_sugar_rank then
		return self._qixi_send_gift_sugar_rank[cfg.sugarPlanId]
	end

	return nil
end

RomanticGiftsConfig.instance = RomanticGiftsConfig.New()

return RomanticGiftsConfig
