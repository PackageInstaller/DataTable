-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/paytempt/config/PaytemptConfig.lua

module("logic.extensions.paytempt.config.PaytemptConfig", package.seeall)

local PaytemptConfig = class("PaytemptConfig", BaseConfig)

function PaytemptConfig:onInit()
	PaytemptConfig.super.onInit(self)

	self._pay_temptCfg = nil
end

function PaytemptConfig:getNames()
	return {
		"pay_tempt",
		"pay_tempt_client"
	}
end

function PaytemptConfig:handleConfig(name, content)
	if name == "pay_tempt" then
		self._pay_temptCfg = content
	elseif name == "pay_tempt_client" then
		self._pay_tempt_client = content
	end
end

function PaytemptConfig:getCfgById(id)
	return self._pay_temptCfg[id]
end

function PaytemptConfig:getClientCfgById(id)
	return self._pay_tempt_client[id]
end

function PaytemptConfig:getClientCfgs()
	return self._pay_tempt_client.dataList
end

PaytemptConfig.instance = PaytemptConfig.New()

return PaytemptConfig
