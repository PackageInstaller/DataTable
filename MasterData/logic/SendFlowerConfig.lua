-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/config/SendFlowerConfig.lua

module("logic.extensions.sendflower.config.SendFlowerConfig", package.seeall)

local SendFlowerConfig = class("SendFlowerConfig", BaseConfig)

function SendFlowerConfig:onInit()
	SendFlowerConfig.super.onInit(self)

	self._flowerCfgs = nil
	self._commonCfgs = nil
	self._rankCfgs = nil
end

function SendFlowerConfig:getNames()
	return {
		"send_flower_define",
		"send_flower_rank_prize",
		"send_flower_common_config"
	}
end

function SendFlowerConfig:handleConfig(name, content)
	if name == "send_flower_define" then
		self._flowerCfgs = content
	elseif name == "send_flower_rank_prize" then
		self._rankCfgs = {}

		for _, v in ipairs(content.dataList) do
			self._rankCfgs[v.type] = self._rankCfgs[v.type] or {}
			self._rankCfgs[v.type][v.id] = v
		end
	elseif name == "send_flower_common_config" then
		self._commonCfgs = content
	end
end

function SendFlowerConfig:getCommonParamByKey(key)
	return self._commonCfgs[key].value
end

function SendFlowerConfig:getFlowerCfg(flowerId)
	local id = checkint(flowerId)

	if id > 0 then
		return self._flowerCfgs[id]
	else
		return self._flowerCfgs
	end
end

function SendFlowerConfig:getFlowerMatStrById(flowerId)
	local id = checkint(flowerId)

	return self._flowerCfgs[id] and self._flowerCfgs[id].content
end

SendFlowerConfig.RANKTYPE_SEND = "send"
SendFlowerConfig.RANKTYPE_CHARM = "charm"

function SendFlowerConfig:getFlowerPrize(type, randId)
	local prizecfgs = self._rankCfgs[type]
	local id = checkint(randId)

	if prizecfgs and id > 0 then
		for k, v in ipairs(prizecfgs) do
			if id <= v.rank then
				return v.prize
			end
		end
	end
end

SendFlowerConfig.instance = SendFlowerConfig.New()

return SendFlowerConfig
