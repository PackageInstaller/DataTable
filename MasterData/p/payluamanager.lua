--PayLuaManager

---@class PayLuaManager
local PayLuaManager = class("PayLuaManager")
-- local lx_json_decode = lx.json_decode
-- local lx_json_encode = lx.json_encode
local cjson = require "cjson"
local PayDataUtil = require("PayDataUtil")

function PayLuaManager:ctor()
	self.orderString = nil
	self.game_trade_no = nil --游戏内订单
	self._successCB = nil	--支付成功回调
end

--支付初始化
function PayLuaManager:Init()
	PayMgr:Init()
	-- PayMgr:BindPayCallBack(function (token, result)
	-- 	LuaLogger.ds("支付回调", tablex.dump(result))
	-- 	if result and result.result == true then
	-- 		self:PayFinished(result.game_trade_no)
	-- 	else
	-- 		UICommonUtils.PopToast("支付失败")
	-- 		self:EndLoader()
	-- 	end
	-- end)
	GameNetHandler:SendWaitMessage("user.payInitializeReq", { 
		identify = NativeInfo.GetBundleIdentifier(),
		device = NativeInfoLua.GetDeviceID(),
		deviceType = UnityEngine.Application.platform:ToInt(),
	}, function (data)

	end)
end

--取消loading
function PayLuaManager:EndLoader()
	if self.loaderId then
		UIMgr:endLoad(self.loaderId)
		self.loaderId = nil
	end
end

--支付
--@param {int}	id	商品id
--@param {func} SuccessCB 支付完成回调
function PayLuaManager:Pay(id, SuccessCB)
	--loading 3s
	if not self.loaderId then
		self.loaderId = UIMgr:startLoad(0)
		EngineUtil.DelayCallback(3, function()
            if self then
				self:EndLoader()
			end
        end)
	end
	local channel = SDKMgr:getChannel()
	--渠道对应支付渠道
	local channelTopayChannel = {
		[GE.PayChannel.TestPay] = {
			GE.Channel.Editor,
			GE.Channel.InternalTest
		},
		[GE.PayChannel.Alipay] = {
			GE.Channel.Formal_Official,
			-- GE.Channel.InternalTest
		},
	}
	local payChannel = nil
	for payC, Clist in pairs(channelTopayChannel) do
		if tablex.contains(Clist, channel) then
			payChannel = payC
			break
		end
	end
	LuaLogger.ds("渠道为 ", channel)
	LuaLogger.ds("支付渠道为 ", payChannel)
	-- payChannel = GE.PayChannel.XipuMiniSDK --测试代码
	--业务逻辑支付请求
	local temp = {
		itemid = id,
		identify = NativeInfo.GetBundleIdentifier(),
		device = NativeInfoLua.GetDeviceID(),
		deviceType = UnityEngine.Application.platform:ToInt(),
		-- extra = nil,
		pay_channel = payChannel
	}
	LuaLogger.ds("Pay数据", tablex.dump(temp))
	--屏蔽相关
	if SDKMgr:getLoginType() == GE.LoginType.XipuMiniWrap then
		local IsH5Audit = GV.GlobalConfig.IsH5Audit	--ios审核屏蔽支付
		if IsH5Audit then
			local jsonStr = WXManager.GetDeviceInfo()
			local result = cjson.decode(jsonStr)
			LuaLogger.ds("WX system数据   ", tablex.dump(result))
			if string.find(string.lower(result.system), "ios") then
				return
			end
		end
	end

	GameNetHandler:SendWaitMessage("user.payReq", temp,
		--业务逻辑支付请求成功回调
		function (data)
			if data.ret == 0 then
				self.orderString = data.orderString
				self.game_trade_no = data.game_trade_no
				--编译器下测试流程
				self._successCB = SuccessCB
				if payChannel == GE.PayChannel.TestPay then
					GameNetHandler:SendWaitMessage("user.payResultReq", {
						game_trade_no = data.game_trade_no,
						identify = NativeInfo.GetBundleIdentifier(),
						-- receipt = "",
						success = true,
						pay_channel = payChannel,
						device = NativeInfoLua.GetDeviceID(),
						deviceType = UnityEngine.Application.platform:ToInt(),
						orderString = data.orderString,
						-- purchaseToken = data.game_trade_no,
						-- result_msg = data.game_trade_no,
					}, function (data)
						LuaLogger.ds("payResultResp: ", tablex.dump(data))
					end)
					return
				end
				--sdk拉起支付请求
				LuaLogger.ds("self.orderString", self.orderString)
				local result = PayDataUtil.decryptPayData(self.orderString)
				LuaLogger.ds("result", result)
				-- goodsName = "物品1003",
				-- cpOrderID = "12015000004-1100110",
				-- amount = 3000,
				-- notifyUrl = "http://43.137.7.160:30000/xipuminisdknotify",
				-- goodsID = "com.hm.mby.gift3",
				LuaLogger.ds("self.game_trade_no", self.game_trade_no)
				-- local uid = Me.uid
				-- local serverid = tonumber(tostring(uid)[1])
				-- local serverName = tostring(serverid)
				-- local name = Me.name
				-- local level = Me:getCurrLevelId()
				local callback = function(success)
					GameNetHandler:SendWaitMessage("user.payResultReq", {
						game_trade_no = data.game_trade_no,
						identify = NativeInfo.GetBundleIdentifier(),
						-- receipt = "",
						success = success,
						pay_channel = payChannel,
						device = NativeInfoLua.GetDeviceID(),
						deviceType = UnityEngine.Application.platform:ToInt(),
						orderString = data.orderString,
						-- purchaseToken = data.game_trade_no,
						-- result_msg = data.game_trade_no,
					}, function (data)
						LuaLogger.ds("payResultResp: ", tablex.dump(data))
					end)
				end
				--xipu
				if payChannel == GE.PayChannel.XipuMiniSDK then
					-- local vip_level = 0
					-- --支付拉起成功回调
					-- WXManager.payShowSuccCallBack = function()
					-- 	LuaLogger.ds("支付成功！")
					-- 	-- self._successCB = SuccessCB
					-- 	callback(true)
					-- end
					-- --支付拉起失败回调
					-- WXManager.payShowFailCallBack = function(str)
					-- 	LuaLogger.ds("支付失败！", str)
					-- 	UICommonUtils.PopToast("支付失败")
					-- 	callback(false)
					-- 	self:EndLoader()
					-- end
					-- -- --拉起支付
					-- -- WXManager.Pay(
					-- -- 	serverid,
					-- -- 	serverName,
					-- -- 	uid,
					-- -- 	name,
					-- -- 	level,
					-- -- 	vip_level,
					-- -- 	result.amount,
					-- -- 	result.goodsID,
					-- -- 	result.cpOrderID,
					-- -- 	result.notifyUrl
					-- -- )
					-- --日志输出
					-- LuaLogger.ds("Xipu传参： ",tablex.dump({
					-- 	serverid = serverid,
					-- 	serverName = serverName,
					-- 	uid = uid,
					-- 	name = name,
					-- 	level = level,
					-- 	vip_level = vip_level,
					-- 	amount = result.amount,
					-- 	notifyUrl = result.notifyUrl,
					-- 	cpOrderID = result.cpOrderID,
					-- 	goodsID = result.goodsID
					-- }))
				elseif payChannel == GE.PayChannel.Alipay then
					PayMgr:BindPayCallBack(function (receipt, result)
						LuaLogger.ds("支付回调result", tablex.dump(result))
						LuaLogger.ds("支付回调receipt", receipt)
						LuaLogger.ds("支付回调receipt", tablex.dump(receipt))
						if result == "9000" then
							self:EndLoader()
						else
							UICommonUtils.PopToast("支付失败")
							self:EndLoader()
						end
					end)
					PayMgr:Pay(result, PayType.AliPay)
				end
			end
		end)
end

function PayLuaManager:DoSuccessCB()
	if self._successCB then
		self._successCB()
		self._successCB = nil
	end
end

function PayLuaManager:PayFinished(gameTradeNo)
	local curGameTradeNo = gameTradeNo
	--如果当前传入的不存在 ，则使用当前记录的gameTradeNo
	if curGameTradeNo == nil or curGameTradeNo == "" then
		curGameTradeNo = self.game_trade_no
	end
	GameNetHandler:SendWaitMessage("user.payClientCheckReq", {
		game_trade_no = curGameTradeNo,
	}, function (data)
		LuaLogger.ds("payClientCheckResp: ", tablex.dump(data))
	end)
	self.game_trade_no = nil
	self.orderString = nil
	self:EndLoader()
end

-- --角色升级
-- function PayLuaManager:RoleUpgrade()
-- 	LuaLogger.ds("xipuRoleUpgrade")
-- 	local uid = Me.uid
-- 	local serverid = tonumber(tostring(uid)[1])
-- 	local serverName = tostring(serverid)
-- 	local name = Me.name
-- 	local level = Me:getCurrLevelId()
-- 	local vip_level = 0
-- 	WXManager.RoleUpgrade(
-- 		serverid,
-- 		serverName,
-- 		uid,
-- 		name,
-- 		level,
-- 		vip_level
-- 	)
-- end

return PayLuaManager
