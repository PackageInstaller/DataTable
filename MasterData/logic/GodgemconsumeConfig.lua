-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/config/GodgemconsumeConfig.lua

module("logic.extensions.godgemconsume.config.GodgemconsumeConfig", package.seeall)

local GodgemconsumeConfig = class("GodgemconsumeConfig", BaseConfig)

function GodgemconsumeConfig:onInit()
	return
end

function GodgemconsumeConfig:getNames()
	return {
		"god_gem_acc_consume_prize",
		"god_gem_acc_consume",
		"god_gem_acc_consume_picture",
		"god_gem_acc_consume_common",
		"god_gem_acc_consume_payshop"
	}
end

function GodgemconsumeConfig:handleConfig(name, content)
	if name == "god_gem_acc_consume_prize" then
		self._god_gem_acc_consume_prize = content
	elseif name == "god_gem_acc_consume" then
		self._god_gem_acc_consume = content
	elseif name == "god_gem_acc_consume_picture" then
		self._god_gem_acc_consume_picture = content
	elseif name == "god_gem_acc_consume_common" then
		self._god_gem_acc_consume_common = content
	elseif name == "god_gem_acc_consume_payshop" then
		self._god_gem_acc_consume_payshop = content
	end
end

function GodgemconsumeConfig:getPrizeCfgs(activityId)
	return self._god_gem_acc_consume_prize[activityId]
end

function GodgemconsumeConfig:getPrizeCfg(activityId, prizeId)
	return self._god_gem_acc_consume_prize[activityId][prizeId]
end

function GodgemconsumeConfig:getActCfg(activityId)
	return self._god_gem_acc_consume[activityId]
end

function GodgemconsumeConfig:getPictureCfgs()
	return self._god_gem_acc_consume_picture.dataList
end

function GodgemconsumeConfig:getCommonValue(key)
	return self._god_gem_acc_consume_common[key].value
end

function GodgemconsumeConfig:getPayShopCfg(activityId)
	return self._god_gem_acc_consume_payshop[activityId]
end

GodgemconsumeConfig.instance = GodgemconsumeConfig.New()

return GodgemconsumeConfig
