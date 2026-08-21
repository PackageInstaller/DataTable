---聚合sdk
--[[local Pay_QuickSDK = class("Pay_QuickSDK", function (...)
    return QuickSDKPayManager.Instance
end)]]

local Pay_QuickSDK = class("Pay_QuickSDK")

local PayChannel = require("Pay_Channel")

function Pay_QuickSDK:ctor(...)
end

function Pay_QuickSDK:IsPayInit(channel)
	local quickSdkHandler = GameMain.Instance.gameObject:GetComponent(typeof(QuickSdkHandler))
	if quickSdkHandler then
		return quickSdkHandler.sdkInitSuccess
	end
	return false
end

function Pay_QuickSDK:hasClientReturn()
	return true
end

function Pay_QuickSDK:register_payresult()
	local quickSdkHandler = GameMain.Instance.gameObject:GetComponent(typeof(QuickSdkHandler))
	if quickSdkHandler then
		quickSdkHandler.OnPaySuccess = function(payresult)
			print("pay success################lua!!!!")
			print(payresult)
			PayChannel.ProcessPurchase(self, payresult, true)
		end
		quickSdkHandler.OnPayCancel = function(payresult)
			print("pay cancel################lua!!!!")
			print(payresult)
			PayChannel.ProcessPurchase(self, payresult, false)
		end
		quickSdkHandler.OnPayFailed = function(payresult)
			print("pay failed################lua!!!!")
			print(payresult)
			PayChannel.ProcessPurchase(self, payresult, false)
		end
	end

end

function Pay_QuickSDK:register_initialStart()

end

function Pay_QuickSDK:register_initialEnd()

end


function Pay_QuickSDK:Init()
	PayChannel.PayInitial()
end

local function getQuickSDKGameInfo()
	local me = Me
	local zone = GlobalInfo.CurrZone

	local gameRoleInfo = {}
	gameRoleInfo.gameRoleBalance = me:getPayGold()		--角色用户余额
	gameRoleInfo.gameRoleID = "" .. me.uid				--角色ID
	gameRoleInfo.gameRoleLevel = "" .. me:getLeaderLevel() 	--角色等级
	gameRoleInfo.gameRoleName = me.name						--角色名称
	gameRoleInfo.partyName = "无" .. me.guildName				--公会社团
	gameRoleInfo.serverID = zone and ("" .. zone.id) or "0"
	gameRoleInfo.serverName = zone and zone.name or "火星服务器"
	gameRoleInfo.vipLevel = "0"
	gameRoleInfo.roleCreateTime = "" .. me.borntime							--UC，当乐与1881渠道必传，值为10位数时间戳
	gameRoleInfo.gameRoleGender = (me.sex == SexType.Male) and "男" or "女" --360渠道参数
	gameRoleInfo.gameRolePower ="0"										--360渠道参数，设置角色战力，必须为整型字符串
	gameRoleInfo.partyId ="0"											--360渠道参数，设置帮派id，必须为整型字符串
	gameRoleInfo.professionId = "0"									--360渠道参数，设置角色职业id，必须为整型字符串
	gameRoleInfo.profession = "侠客"									--360渠道参数，设置角色职业名称
	gameRoleInfo.partyRoleId = "0"									--360渠道参数，设置角色在帮派中的id
	gameRoleInfo.partyRoleName = "无"								--360渠道参数，设置角色在帮派中的名称
	gameRoleInfo.friendlist = "无"									--360渠道参数，设置好友关系列表，格式请参考：http://open.quicksdk.net/help/detail/aid/190

	return gameRoleInfo
end

function Pay_QuickSDK:DoPay(pay_channel, id)
	--if Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer or Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or Application.platform == UnityEngine.RuntimePlatform.OSXEditor then
	if false then
	else
		local orderString = Me.__orderString

		print("orderString1", orderString)

		local PayDataUtil = require("PayDataUtil")
		orderString = PayDataUtil.decryptPayData(orderString)

		print("orderString2", orderString)

		local json = require "cjson"
		local requestData = json.decode(orderString)
		local goodsID = requestData.goodsID
		local goodsName = requestData.goodsName
		local goodsDesc = requestData.goodsDesc
		local quantifier = requestData.quantifier
		local extrasParams = requestData.extrasParams
		local count = requestData.count
		local amount = requestData.amount
		local price = requestData.price
		local callbackUrl = requestData.callbackUrl
		local cpOrderID = requestData.cpOrderID

		local orderinfo = quicksdk.OrderInfo.New()
		orderinfo.goodsID = goodsID
		orderinfo.goodsName = goodsName
		orderinfo.goodsDesc = goodsDesc
		orderinfo.quantifier = quantifier
		orderinfo.extrasParams = extrasParams
		orderinfo.count = count
		orderinfo.amount = amount
		orderinfo.price = price
		orderinfo.callbackUrl = callbackUrl
		orderinfo.cpOrderID = cpOrderID

		local gameinfo = getQuickSDKGameInfo()
		local gameRoleBalance = gameinfo.gameRoleBalance
		local gameRoleID = gameinfo.gameRoleID
		local gameRoleLevel = gameinfo.gameRoleLevel
		local gameRoleName = gameinfo.gameRoleName
		local partyName = gameinfo.partyName
		local serverID = gameinfo.serverID
		local serverName = gameinfo.serverName
		local vipLevel = gameinfo.vipLevel
		local roleCreateTime = gameinfo.roleCreateTime

		local gameRoleInfo = quicksdk.GameRoleInfo.New()
		gameRoleInfo.gameRoleBalance = gameRoleBalance
		gameRoleInfo.gameRoleID = gameRoleID
		gameRoleInfo.gameRoleLevel = gameRoleLevel
		gameRoleInfo.gameRoleName = gameRoleName
		gameRoleInfo.partyName = partyName
		gameRoleInfo.serverID = serverID
		gameRoleInfo.serverName = serverName
		gameRoleInfo.vipLevel = vipLevel
		gameRoleInfo.roleCreateTime = roleCreateTime

		quicksdk.QuickSDK.getInstance():pay(orderinfo, gameRoleInfo)
	end
end

function Pay_QuickSDK:ProcessPurchase(payresult, result)
	local rt_receipt, rt_token, rt_success, rt_pay_channel, rt_msg

	if payresult then
		local orderId = payresult.orderId
		local cpOrderId = payresult.cpOrderId
		local extraParam = payresult.extraParam
		print("quicksdk payresult orderId", orderId)
		print("quicksdk payresult cpOrderId", cpOrderId)
		print("quicksdk payresult extraParam", extraParam)
	end

	rt_receipt = nil
	rt_token = nil
	rt_pay_channel = GE.PayChannel.QuickSDK
	if result then
		print("#################ProcessPurchase quicksdk success")
		rt_success = true
	else
		print("#################ProcessPurchase quicksdk failed")
		rt_success = false
		if payresult then
			rt_msg = payresult.extraParam
		end
		local channel = SDKMgr:getChannel()
		if channel == GE.Channel.Quick_HuaWei then
			if rt_msg then
				if rt_msg == "请检查是否存在未发货商品" then
					UICommonUtils.PopToast("正在处理中，请稍后")
				else
					UICommonUtils.PopToast("支付处理中，请稍后")
				end
			end
		end
	end
	return rt_receipt, rt_token, rt_success, rt_pay_channel, rt_msg
end

function Pay_QuickSDK:DoConfirmPurchases(receipt)

end


function Pay_QuickSDK:Clear()
	--self:clear()
end


return Pay_QuickSDK