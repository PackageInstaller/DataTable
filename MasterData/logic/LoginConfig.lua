-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/login/config/LoginConfig.lua

module("logic.extensions.login.config.LoginConfig", package.seeall)

local LoginConfig = class("LoginConfig", BaseConfig)

function LoginConfig:onInit()
	LoginConfig.super.onInit(self)

	self._loginCfg = nil
end

function LoginConfig:getNames()
	return {
		"random_name",
		"name_rules",
		"user_close"
	}
end

function LoginConfig:handleConfig(name, content)
	if name == "random_name" then
		self._loginCfg = content
	elseif name == "name_rules" then
		self._rulesCfg = content
	elseif name == "user_close" then
		self._user_close = content
	end
end

function LoginConfig:getUserColseCfgList()
	return self._user_close.dataList
end

function LoginConfig:getUserCloseCfgById(platformId)
	return self._user_close[platformId]
end

function LoginConfig:getRule(id)
	if self._rulesCfg then
		return self._rulesCfg[id]
	end

	return nil
end

function LoginConfig:getCfgsByGroup(group)
	return self._loginCfg[group]
end

function LoginConfig:getRandomName()
	local name = ""

	for i = 1, 3 do
		local t = LoginConfig.instance:getCfgsByGroup(i)

		if t and #t > 0 then
			name = name .. t[math.random(#t)].content
		end
	end

	local realLen = self:getNameRealLen(name)

	if realLen > 14 then
		return self:getRandomName()
	else
		return name
	end
end

function LoginConfig:getNameRealLen(content)
	local result = StringUtil.utf8split(content)
	local isAllNum, isAllUnderLine = true, true

	for _, v in ipairs(result) do
		isAllNum = isAllNum and v >= "0" and v <= "9"
		isAllUnderLine = isAllUnderLine and v == "_"
	end

	return #result, isAllNum, isAllUnderLine
end

local errorCodeMsg = {
	"验证失败，请尝试重新登录",
	[-2] = "请输入激活码进行游戏体验",
	[500] = "系统异常，请稍等片刻重新登录，若相同情况仍然发生，请联系客服",
	[-1] = "参数错误",
	[-3] = "根据您的账号信息，您已被识别为未成年人。根据《关于进一步严格管理切实防止未成年人沉迷网络游戏的通知》，18岁以下未成年人只可以在周五、周六、周日和法定节假日的20时至21时体验游戏。请您在指定的时间回来体验游戏吧。",
	[403] = "签名错误"
}
local commonErrorMsg = "服务器调用第三方服务发送错误，请稍后重试。\n(3_%s)"

function LoginConfig:getThirdPartErrorMsg(code)
	code = checknumber(code)

	local content = errorCodeMsg[code]

	if content == nil then
		return string.format(commonErrorMsg, code)
	end

	return content
end

LoginConfig.instance = LoginConfig.New()

return LoginConfig
