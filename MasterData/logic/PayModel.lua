-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pay/model/PayModel.lua

module("logic.extensions.pay.model.PayModel", package.seeall)

local PayModel = class("PayModel", BaseModel)
local json = require("cjson")

PayModel.GenOrderNoRes = "PayModel.GenOrderNoRes"
PayModel.RMB_UNIT = 0.01

function PayModel:ctor()
	return
end

function PayModel:onInit()
	return
end

function PayModel:onReset()
	return
end

local lastOrderNo = false

function PayModel:handlerGenOrderNoRes(msg, subGoodsType, subGoodsId)
	local money = 0
	local goodsId = ""
	local callBackStrList = string.split(msg.callBackStr, "#")
	local payGoodsId = callBackStrList[1]
	local subGoodsType = checknumber(callBackStrList[2])
	local extParamJsonStr = callBackStrList[3]
	local payCfg = PayConfig.instance:getPayGoodsCfg(payGoodsId)

	if not payCfg then
		return
	end

	money = payCfg.payMoney

	local productName = self:_getProductName(subGoodsType, subGoodsId, payGoodsId, extParamJsonStr)

	goodsId = tostring(payCfg.goodsId)

	local role = RoleModel.instance:GetRole()
	local roleInfo = RoleModel.instance.myRoleMo

	lastOrderNo = msg.orderNo

	local paymentInfo = {}

	paymentInfo.roleId = tostring(role.userId)
	paymentInfo.roleName = role.userName
	paymentInfo.roleLevel = MofangModel.instance:getCurLv()
	paymentInfo.serverId = tostring(roleInfo.zoneId)
	paymentInfo.serverName = roleInfo.zoneName
	paymentInfo.callBackStr = msg.callBackStr
	paymentInfo.money = money * 0.01
	paymentInfo.payType = 0
	paymentInfo.moreCharge = 0
	paymentInfo.productName = productName
	paymentInfo.rate = 10
	paymentInfo.gameGold = "钻石"
	paymentInfo.goodsId = goodsId
	paymentInfo.outOrderNo = msg.orderNo
	paymentInfo.coinsAmount = 1

	local urlType = CSGameUtil.GetGameConfigUrlType()

	if urlType == 0 then
		paymentInfo.zoneId = "103"
	elseif urlType == 3 then
		paymentInfo.zoneId = "102"
	elseif urlType == 1 then
		paymentInfo.zoneId = "100001"
	elseif urlType == 2 then
		paymentInfo.zoneId = Framework.OSDef.RunOS == Framework.OSDef.IOS and (BootstrapPjaqGameConfigMgr.isReview and "3" or "4") or BootstrapPjaqGameConfigMgr.isReview and "2" or "1"
	elseif urlType == 11 then
		paymentInfo.zoneId = "11"
	end

	paymentInfo.sign = msg.sign
	paymentInfo.roleCTime = RoleModel.instance:getActiveTime()

	local loginTime = RoleModel.instance:getLoginTime() / 1000
	local date1 = GameUtil.time2date(loginTime)

	paymentInfo.loginTime = string.format("%d-%d-%d %d:%d:%d", date1.year, date1.month, date1.day, date1.hour, date1.min, date1.sec)

	local lastLogoutTime = RoleModel.instance:getLoginOutTime()
	local lastLogoutTimeStr = ""

	if lastLogoutTime and lastLogoutTime > 0 then
		lastLogoutTime = lastLogoutTime / 1000

		local date2 = GameUtil.time2date(lastLogoutTime)

		lastLogoutTimeStr = string.format("%d-%d-%d %d:%d:%d", date2.year, date2.month, date2.day, date2.hour, date2.min, date2.sec)
	end

	paymentInfo.lastLogoutTime = lastLogoutTimeStr
	paymentInfo.registerTime = RoleModel.instance:getActiveTime()

	self:_setPlatformGoodsId(paymentInfo, payCfg.appleGoodsId)

	local checkableOrderNo = lastOrderNo
	local urlType = CSGameUtil.GetGameConfigUrlType()

	if urlType == 0 or urlType == 1 or urlType == 3 or Framework.OSDef.isEditor then
		local content = string.format("模拟消费<color=red>%s元</color>", paymentInfo.money)

		TipsFacade.instance:openTipWindowNoX("提示", content, function()
			GMAgent.instance:sendPM_FakeFinishPayOrderReq(checkableOrderNo)
		end)
	else
		SDKManager.registerPayListener(function(statusCode, statusDesc)
			self:OnSDKPayHandler(statusCode, statusDesc, checkableOrderNo)
		end)
		SDKManager.pay(paymentInfo)
	end
end

function PayModel:OnSDKPayHandler(statusCode, statusDesc, checkableOrderNo)
	if checkableOrderNo ~= lastOrderNo then
		return
	end

	SDKManager.unregisterPayListener()

	if statusCode ~= 0 then
		if not string.nilorempty(statusDesc) then
			FloatWordMgr.instance:show(string.format("%s %s", statusDesc, statusCode))
		else
			FloatWordMgr.instance:show("支付取消 " .. statusCode)
		end

		return
	end
end

function PayModel:_setPlatformGoodsId(paymentInfo, platformGoodsId)
	local platFormId = BootstrapUtil.getPlatformId()

	if Framework.OSDef.RunOS == Framework.OSDef.IOS or SDKManager.isHuawei() or platFormId == 303 then
		paymentInfo.platformGoodsId = platformGoodsId
	end
end

function PayModel:_getProductName(subGoodsType, subGoodsId, payGoodsId, extParamJsonStr)
	local productName = string.format("%s元礼包", PayConfig.instance:getPayMoneyYuan(payGoodsId))

	if subGoodsType == GameEnum.PaySubGoodsType.PASS_PORT then
		local data = json.decode(extParamJsonStr)
		local funcCfg = PassportConfig.instance:getPassportBaseCfgById(checknumber(data.funcId))

		if funcCfg then
			return funcCfg.name
		else
			return lang("通行证")
		end
	end

	return productName
end

function PayModel:_checkIsShowGoodsNameWithMatPattern(content, matTypePattern, matIdPattern)
	local pattern1 = string.format("^%s:%s:", matTypePattern, matIdPattern)
	local pattern2 = string.format("#%s:%s:", matTypePattern, matIdPattern)

	return string.find(content, pattern1) or string.find(content, pattern2)
end

PayModel.instance = PayModel.New()

return PayModel
