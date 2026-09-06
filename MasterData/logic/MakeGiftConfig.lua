-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/celebratebirthday/config/MakeGiftConfig.lua

module("logic.extensions.celebratebirthday.config.MakeGiftConfig", package.seeall)

local MakeGiftConfig = class("MakeGiftConfig", BaseConfig)

function MakeGiftConfig:onInit()
	MakeGiftConfig.super.onInit(self)

	self._cofignameCfg = nil
end

function MakeGiftConfig:getNames()
	return {
		"make_gift",
		"make_gift_make_plan",
		"make_gift_prize_plan",
		"make_gift_bubble"
	}
end

function MakeGiftConfig:handleConfig(name, content)
	if name == "make_gift" then
		self._cfg = content
	elseif name == "make_gift_make_plan" then
		self._make = content
	elseif name == "make_gift_prize_plan" then
		self._prize = content
	elseif name == "make_gift_bubble" then
		self._bubbleCfgs = content
	end
end

function MakeGiftConfig:getCfgById(id)
	return self._cfg[id]
end

function MakeGiftConfig:getMakeByPlan(plan)
	return self._make[plan]
end

function MakeGiftConfig:getPrizeByPlan(plan)
	return self._prize[plan]
end

function MakeGiftConfig:getBubbleCfgs(planId)
	return self._bubbleCfgs[planId]
end

MakeGiftConfig.instance = MakeGiftConfig.New()

return MakeGiftConfig
