-- Desc: 支付
---@class Player
local Player = require "Player"
local cjson = require "cjson"
local GameGlobal, DataLogMgr
if GV.IsServer then
    GameGlobal = require "GameGlobal"
	DataLogMgr = require "DataLogMgr"
end

--系统重置时间
local DailyResetTime = Config.GetConfigInfo("DailyResetTime") * 3600


--------------------------------------------------------------------------------
function Player:getDefaultIdentify(identify)
    if not identify or identify == "" then
        identify = string.format("default.bfg.channel%s", tostring(self.channel))
    end
    return identify
end

--支付初始化
---@param payload payInitializeReq
---@return ActionFailReason
function Player:payInitialize(payload)
    if not GV.IsServer then
        return ActionFailReason.None
    end

    local identify = self:getDefaultIdentify(payload.identify)
    local device = payload.device
    local deviceType = payload.deviceType

    local pay_channels, gold_channel, pay_sdk = self:getPlatform_()
    if not pay_channels then
        return ActionFailReason.payChannelError
    end

    local pay_data = {
        channel = self.channel,
        user_id = self.uid,
        pay_channels = pay_channels,
        platform = gold_channel,
        pay_sdk = pay_sdk,
        device = device,
    }

    local ok, reason = GameGlobal.PayInitial(self.uid, pay_data)
    if not ok then
        if reason and type(reason) == "number" then
            return reason
        end
        return ActionFailReason.PayInitialFail
    end

    --GameGlobal.PayCheckException(self.uid, {user_id = self.uid})
    ----看payment那边的逻辑，需要传game_trade_no才会处理数据
    ----此处没有game_trade_no，所以消息发过去无效，故屏蔽
    -- local pay_data = {}
    -- pay_data.user_id = uid

    -- local ok, code, db  = GameGlobal.PayClientCheck(uid, pay_data)
    -- if ok and db then
    --     return pb_encode("user.payInitializeResp", { res = {ret = ActionFailReason.None}, item = db.pay_id, game_trade_no = db.game_trade_no})
    -- end

    return ActionFailReason.None
end

--客户端验证支付
---@param payload payClientCheckReq
function Player:payClientCheck(payload)
	local pay_data = {
		user_id = self.uid,
		user_aid = self.aid,
		game_trade_no = payload.game_trade_no,
	}

	local ok, code, db  = GameGlobal.PayClientCheck(self.uid, pay_data)

    if ok then
		local success = db.result == GE.PayResult.Success
		return ActionFailReason.None, success, db.pay_id
    end

	return code
end

--支付请求
---@param payload payReq
function Player:pay(payload)
	local itemid = payload.itemid
	local identify = self:getDefaultIdentify(payload.identify)
	local device = payload.device
	local deviceType = payload.deviceType
	local pay_channel = payload.pay_channel
	local extra = payload.extra

	-- 配置未找到
	local cfg = Config.GetGiftInfo(itemid)
    if not cfg then
        return ActionFailReason.CfgNotFind
    end

	--不是充值商品
    if cfg.Cost_type ~= GE.ShopCostType.recharge then
        return ActionFailReason.ShopNotRechargeGoods
    end

	--检测商品是否能购买
    local ret = self:checkKJGoodsBuy(itemid)
    if ret ~= ActionFailReason.None then
        return ret
    end

	--价格配置错误
    local price = GF.getPayDiscountChannel(self.channel, cfg)
    if not price or price <= 0 then
        return ActionFailReason.ShopGoodsPriceError
    end

	--渠道检测
	if (GF.isReleaseVersions ~= nil and GF.isReleaseVersions()) and pay_channel == GE.PayChannel.TestPay then
        return ActionFailReason.payChannelError
    end

	local item_identify = identify .. "." .. cfg.storeSpecificId
    local pay_channels, gold_channel, pay_sdk = self:getPlatform_()
    if not pay_channels then
        return ActionFailReason.payChannelError
    end

	--支付渠道没有权限
    if not luautil.elementInArray(pay_channel, pay_channels) then
        return ActionFailReason.payChannelPermissionDenied
    end

	local pay_data = {
    	channel = self.channel,
    	user_id = self.uid,
    	user_aid = self.aid,
    	pay_channel = pay_channel,
    	platform = gold_channel,
    	pay_sdk = pay_sdk,
    	device = device,
    	pay_id = itemid,
    	pay_id_identify = item_identify,
    	money = price,
    	identify = identify,
    	extra = extra,
	}

	local ok, order = GameGlobal.CreatPayOrder(self.uid, pay_data)
    LuaLogger.ds("payReq CreatPayOrder", ok, tostring(order))
    if not ok then
        if order and type(order) == "number" then
            local reason = order
            return reason
        end
        return ActionFailReason.CreatePayOrderFailed
    end

	local request_pay_data = order.request_pay_data
    if request_pay_data then
        local PayDataUtil = require("PayDataUtil")
        request_pay_data = PayDataUtil.encryptPayData(request_pay_data)
    end

	local game_trade_no = order.game_trade_no
    local orderString = request_pay_data or order.game_trade_no
    local pay_use_pay_id_identify = order.pay_use_pay_id_identify
    if pay_use_pay_id_identify then
        local channel = self.channel
        if self._first_pay then
            local recordWaitOrderInfo = self.recordWaitOrderInfo
            if recordWaitOrderInfo and recordWaitOrderInfo[channel] and recordWaitOrderInfo[channel][1] then
                return ActionFailReason.HavePayOrderNotDone
            end
        end
        local recordWaitOrderInfo
        if not self._first_pay then
            recordWaitOrderInfo = {}
        else
            recordWaitOrderInfo = self.recordWaitOrderInfo or {}
        end
        local info = recordWaitOrderInfo[channel]
        if not info then
            recordWaitOrderInfo[channel] = {}
            info = recordWaitOrderInfo[channel]
        end
        tablex.insertproxy(info, {pay_id_identify = item_identify, pay_id = itemid})
        self.recordWaitOrderInfo = recordWaitOrderInfo
    end

	self._first_pay = true
    LuaLogger.ds("payReq createOrder suc", game_trade_no, orderString)

    pay_data.game_trade_no = game_trade_no
    self:AddBeBuyGoods(pay_data)

	return ActionFailReason.None, orderString, game_trade_no, order.trade_no_uuid
end

--支付结果
---@param payload payResultReq
function Player:payResult(payload)
    local game_trade_no = payload.game_trade_no
    local receipt = payload.receipt
    local purchaseToken = payload.purchaseToken
    local success = payload.success
    local pay_channel = payload.pay_channel
    local device = payload.device
    local deviceType = payload.deviceType
    local orderString = payload.orderString
    local result_msg = payload.result_msg
    local identify = self:getDefaultIdentify(payload.identify)

	LuaLogger.ds("payResultReq payload", tablex.dump(payload))

	local pay_channels, gold_channel, pay_sdk = self:getPlatform_()
    if not pay_channels then
        return ActionFailReason.payChannelError
    end
    if not luautil.elementInArray(pay_channel, pay_channels) then
        return ActionFailReason.payChannelPermissionDenied
    end

	local pay_data = {
    	channel = self.channel,
    	user_id = self.uid,
    	user_aid = self.aid,
    	pay_channel = pay_channel,
    	platform = gold_channel,
    	pay_sdk = pay_sdk,
    	device = device,
    	clientresult = success,
    	channel_pay_receipt = receipt,
    	token = purchaseToken,
    	identify = identify,
    	result_msg = result_msg,
    	game_trade_no = game_trade_no,
	}

	local ok, code  = GameGlobal.PayResult_Client(self.uid, pay_data)
    if not ok then
        if code and type(code) == "number" then
            return code
        end
        return ActionFailReason.PayMentError
    end

	--取消支付或支付失败
    if success == false then
        self:clearBeBuyGoods(game_trade_no)
    end

    local receipt_order
    if receipt then
        local md5Lua = require "md5Lua"
        receipt_order = md5Lua.sumhexa(receipt)
    end

	return ActionFailReason.None, receipt_order
end

function Player:clearRecordWaitOrderInfo(pay_use_pay_id_identify, user_channel)
    if pay_use_pay_id_identify then
        if user_channel and self.recordWaitOrderInfo then
            self.recordWaitOrderInfo[user_channel] = nil
        else
            self.recordWaitOrderInfo = {}
        end
    end
end

--支付成功处理
---@param data RequestData
---@param success boolean
function Player:paySuccess(data, success)
	---支付结果
    LuaLogger.ds("paySuccess!!!!!!!!!!!!!!!!!!!!", success, tablex.dump(data))

    local user_channel = self.channel

    local pay_channel = data.pay_channel
    local user_id = data.user_id
    local user_aid = data.user_aid
    local pay_id = data.pay_id
    local identify = data.identify
    local pay_id_identify = data.pay_id_identify
    local server_refund = data.server_refund
    local channel_pay_receipt = data.channel_pay_receipt
    local game_trade_no = data.game_trade_no
    local channel_trade_no = data.channel_trade_no
    local pay_use_pay_id_identify = data.pay_use_pay_id_identify
    local payement_code = data.code
    local multiOrder = data.multiOrder

    assert(game_trade_no, "paySuccess game_trade_no nil")
    assert(user_id, "paySuccess user_id nil")

    self:clearBeBuyGoods(game_trade_no)
    if self:isFinishPay(game_trade_no) then
        self:clearRecordWaitOrderInfo(pay_use_pay_id_identify, user_channel)
        return
    end

    local payCfg = Config.GetGiftInfo(pay_id)
	if not payCfg then
		LuaLogger.ds("not GiftInfo, storeID", tostring(pay_id))
        self:clearRecordWaitOrderInfo(pay_use_pay_id_identify, user_channel)
		return false
	end

	local shopInfo = self:getKJGoodsInfo(pay_id)
	if not shopInfo then
		LuaLogger.ds("not shopInfo, storeID", tostring(pay_id))
        self:clearRecordWaitOrderInfo(pay_use_pay_id_identify, user_channel)
		return false
	end

    --限购物品达到上限不发货
    if success and payCfg.LimitType ~= 0 and shopInfo.buyTimes >= payCfg.Limit then
        DataLogMgr.LogPayLimitLog(
            {
                gifgt_id = pay_id,
                amount = GF.getPayDiscountChannel(self.channel, payCfg),
                game_trade_no = game_trade_no,
                channel_trade_no = channel_trade_no,
                success = success and 0 or 1,
            },
            self
        )

        local pay_order = {}
        pay_order.user_id = user_id
        pay_order.user_aid = user_aid
        pay_order.game_trade_no = game_trade_no
        local ok, reason = GameGlobal.Pay_SuccessLimitNoReward(user_id, pay_order)
        if not ok then
            LuaLogger.es("Pay_SuccessLimitNoReward failed", tostring(reason))
        end
        self:clearRecordWaitOrderInfo(pay_use_pay_id_identify, user_channel)
        return
    end


    local receipt_order
    if channel_pay_receipt then
        local md5Lua = require "md5Lua"
        receipt_order = md5Lua.sumhexa(channel_pay_receipt)
    end
    LuaLogger.ds("receipt_order", receipt_order)

    if not success then
        self:clearRecordWaitOrderInfo(pay_use_pay_id_identify, user_channel)
        local code = payement_code or ((server_refund == 1) and ActionFailReason.PayRefund_Currency or ActionFailReason.PayValidateFailed)
        self:notifyDirect({"user.paySuccessNtf", {pay_channel = pay_channel, success = success, reason = code, game_trade_no = game_trade_no, receipt_order = receipt_order}})
        return
    end

    local payItemID = pay_id
    if pay_use_pay_id_identify then
        if payItemID and pay_id_identify then
            local cfg = Config.GetGiftInfo(payItemID)
            local _identify = identify
            -- if not _identify then
            --     if GV.GlobalConfig.IsInternalFormal() then
            --         --_identify = "com.dragonfistx.ndjh"
            --     elseif GV.GlobalConfig.IsAbroadRelease() then
            --         --_identify = "com.mudwx.kyjh"
            --     end
            -- end

            if _identify then
                if (_identify .. "." .. cfg.storeSpecificId) ~= pay_id_identify then
                    DataLogMgr.LogWarnInfo({
                        warn_id = GE.WarnInfoType.PayCheat,
                        info = cjson.encode({game_trade_no = game_trade_no, pay_id = payItemID, pay_id_identify = pay_id_identify})
                    }, self)
                    payItemID = 2001
                end
            end
        end
    end

    --local pay_id_identify_fail = false
    if not payItemID and pay_use_pay_id_identify then
        local recordWaitOrderInfo = self.recordWaitOrderInfo
        if recordWaitOrderInfo and recordWaitOrderInfo[user_channel] then
            for k, v in pairs(recordWaitOrderInfo[user_channel]) do
                if v.pay_id_identify == pay_id_identify then
                    payItemID = v.pay_id
                    break
                end
            end
        end
        -- if not payItemID then
        --     pay_id_identify_fail = true
        -- end
    end
    local code
    local pay_order = {}
    pay_order.user_id = user_id
    pay_order.user_aid = user_aid
    pay_order.game_trade_no = game_trade_no

    local get_items
    if payItemID and payItemID > 0 then
        -- local ok,reason = user:CheckBuyGoldStoreItem(payItemID, 1)
        -- LuaLogger.ds("CheckBuyGoldStoreItem", ok,reason)
        -- local extra = 0
        -- if not ok then
        --     code = ActionFailReason.PayValidateFailed_CheckError
        --     pay_order.extra = 1
        -- end
        pay_order.pay_id = payItemID
        local cfg = Config.GetGiftInfo(payItemID)
        pay_order.money = GF.getPayDiscountChannel(self.channel, cfg)
        local items, hasFirstAward = self:getPayGoldStoreItems(payItemID)
        get_items = items
        pay_order.items = cjson.encode(items)
        pay_order.first_award = hasFirstAward and 1 or 0
    end

    if code then
        self:notifyDirect({"user.paySuccessNtf", {pay_channel = pay_channel, success = success, reason = code, game_trade_no = game_trade_no, receipt_order = receipt_order}})
        return
    end

    if not payItemID then
        local ok,reason = GameGlobal.Pay_IdentifyToPayIDFail( user_id, pay_order)
        if not ok then
            if type(reason) == "number" then
                self:notifyDirect({"user.paySuccessNtf", {pay_channel = pay_channel, success = success, reason = reason, game_trade_no = game_trade_no, receipt_order = receipt_order}})
            else
                self:notifyDirect({"user.paySuccessNtf", {pay_channel = pay_channel, success = success, reason = ActionFailReason.PayMentError, game_trade_no = game_trade_no, receipt_order = receipt_order}})
            end
            return
        end
        self:notifyDirect({"user.paySuccessNtf", {pay_channel = pay_channel, success = success, reason = ActionFailReason.PayIdentifyToPayIDFailed, game_trade_no = game_trade_no, receipt_order = receipt_order}})
        return
    end

    --完成订单记录等待保存
    self:recordFinishPayWaitSave(pay_order)

    --下发充值奖励
    local userinfo = {}
    local rewards
    LuaLogger.ds("pay Success", payItemID)
    --增加充值的奖励
    if get_items then
        rewards = self:addRewardList(get_items, userinfo, GE.EventItemType.MoneyPay, payItemID)
    end

    --记录充值金钱
    self:recodePayMoney(pay_order.money, userinfo)
    --记录充值次数(限购)
    self:setKJGoodsBuyTimes(payItemID, 1, userinfo)

    if userinfo and not tablex.empty(userinfo) then
        self:notifyDirect({ "user.UserInfoUpdate", { userinfo = userinfo } })
    end

    self:clearRecordWaitOrderInfo(pay_use_pay_id_identify, user_channel)

    if multiOrder then
        code = ActionFailReason.PayValidate_Pending
    end

    self:notifyDirect({"user.paySuccessNtf", {
        pay_channel = pay_channel,
        success = success,
        item = payItemID,
        game_trade_no = game_trade_no,
        rewards = rewards,
        reason = code,
        receipt_order = receipt_order
        }}
    )
end

--退款成功处理
---@param data RequestData
---@param success boolean
function Player:refundSuccess(data, success)
	---支付结果
    LuaLogger.ds("refundSuccess!!!!!!!!!!!!!!!!!!!!", success)

    if not success then
        return
    end

    local pay_channel = data.pay_channel
    local channel = data.channel
    local user_id = data.user_id
    local platform = data.platform
    local pay_sdk = data.pay_sdk
    local device = data.device
    local clientresult = data.clientresult
    local client_result = data.client_result
    local server_validate = data.server_validate
    local channel_trade_no = data.channel_trade_no
    local pay_id = data.pay_id
    local server_refund = data.server_refund
    local client_result = data.client_result
    local server_check = data.server_check
    local channel_pay_receipt = data.channel_pay_receipt
    local game_trade_no = data.game_trade_no

    server_check = 1

    assert(game_trade_no, "refundSuccess game_trade_no nil")
    assert(user_id, "refundSuccess user_id nil")


    local payItemID = pay_id
    local code
    local pay_order = {}
    pay_order.user_id = user_id
    pay_order.game_trade_no = game_trade_no


    local ok,reason,refundOrder = GameGlobal.Refund_ServerCheck( user_id, pay_order)
    if not ok then
        self:notifyDirect({"user.refundSuccessNtf", {pay_channel = pay_channel, reason = reason}})
        return
    end

    if server_check and server_check == 1 then
        if refundOrder.items then
            refundOrder.items = cjson.decode(refundOrder.items)
        end

        LuaLogger.ds("refundOrder", tablex.dump(refundOrder))
        self:RefundConfig(refundOrder)

        local userinfo = {}

        self:beginCheckItemChange()
        self:DealRefund(refundOrder, userinfo, GameGlobal)
        local itemChange = self:retrieveItemChange()

        GMServer.CheckItemChangeAndLog(self, GE.EventItemType.MoneyRefund, itemChange)

        if userinfo and not tablex.empty(userinfo) then
            self:notifyDirect({ "user.UserInfoUpdate", { userinfo = userinfo } })
        end
    end

    -- LuaLogger.ds("RefundData uid:[%d]", self.uid)

    if refundOrder.extra ~= 1 then
        local payID = refundOrder.pay_id
        ---发邮件
        local tmpItems = {}
        if server_check and server_check == 1 then
            if refundOrder.items then
                for i, v in pairs(refundOrder.items) do
                    if not tmpItems[v.id] then
                        tmpItems[v.id] = 0
                    end
                    tmpItems[v.id] = tmpItems[v.id] + v.num
                end
            end
        end
        local _items = {}
        for id, num in pairs(tmpItems) do
            table.insert(_items, {id = id, num = num})
        end
        local title, content = Config.GetPayRefundEmail(payID, server_check, _items, refundOrder.monthCardOver)
        self:createNewMail({
            title = title,
            content = content,
        })
    end

    LuaLogger.ds("RefundMail uid:[%d]", self.uid)
    DataLogMgr.LogEvent(GE.LogEventType.MoneyRefund, {
        payID = refundOrder.pay_id,
        platform = refundOrder.platform,
        platformOrder = refundOrder.channel_trade_no,
        money = refundOrder.money,
        items= refundOrder.items or {},
        refundTime = string.format("'%s'", refundOrder.time),
    }, self)


    self:notifyDirect({"user.refundSuccessNtf", {pay_channel = pay_channel, item = payItemID, game_trade_no = game_trade_no, reason = code}})
end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

--初始化正在购买的支付商品
function Player:InitBeBuyGoodsInfo()
	self:getUserData().beBuyPayGoods = 
	{
		PayGoodsTab = {},
		tradeNoTab = {},
	}
end

--获取正在购买的支付商品
function Player:GetBeBuyGoodsInfo()
    local userData = self:getUserData()
	if not userData.beBuyPayGoods then
		self:InitBeBuyGoodsInfo()
	end

	return userData.beBuyPayGoods
end

--是否正在购买中
function Player:BeBuyingGoods(id)
	local beBuyPayGoods = self:GetBeBuyGoodsInfo()
	if beBuyPayGoods.PayGoodsTab[id] then
		return true
	end

	return false
end

--增加正在购买的商品
--@param {table} pay_data
--					{
--						pay_id
--						game_trade_no
--						...
--					}
function Player:AddBeBuyGoods(pay_data)
	local id = pay_data.pay_id
	local tradeNo = pay_data.game_trade_no
	--限购支付商品记录
	local config = Config.GetGiftInfo(id)
	if not config or config.LimitType == 0 then
		return
	end

	local beBuyPayGoods = self:GetBeBuyGoodsInfo()
	if beBuyPayGoods.PayGoodsTab[id] then
		return
	end

	local info = 
	{
		payId = id,
		tradeNo = tradeNo,
		reTime = luautil.getGmtStamp(),
		pay_data = pay_data,
	}
	beBuyPayGoods.PayGoodsTab[id] = info

	if tradeNo then
		beBuyPayGoods.tradeNoTab[tradeNo] = id
	end

end

--清理正在购买商品
function Player:clearBeBuyGoods(idOrTradeNo)
	local beBuyPayGoods = self:GetBeBuyGoodsInfo()
	local ttype = type(idOrTradeNo)
	if ttype == "string" then
		local payid = beBuyPayGoods.tradeNoTab[idOrTradeNo]
		if payid then
			beBuyPayGoods.tradeNoTab[idOrTradeNo] = nil
			beBuyPayGoods.PayGoodsTab[payid] = nil
		end

	elseif ttype == "number" then
		local info = beBuyPayGoods.PayGoodsTab[idOrTradeNo]
		if info then
			beBuyPayGoods.PayGoodsTab[idOrTradeNo] = nil
			if info.tradeNo then
				beBuyPayGoods.tradeNoTab[info.tradeNo] = nil
			end
		end
	end
end

--获取首次奖励
function Player:getPayGoldStoreItems(storeID)
	local config = Config.GetGiftInfo(storeID)
	local items = clone(config.Items_get)
	local shopInfo = self:getKJGoodsInfo(storeID)
	local hasFirstAward = false

	if shopInfo.buyTimes == 0 and config.First_Award then
		hasFirstAward = true
	end
	--增加首次奖励
	if hasFirstAward then
		for k,v in pairs (config.First_Award) do
			tablex.insertproxy(items,v)
		end
	end

	return items, hasFirstAward
end

--获取完成支付订单等待数据保存
function Player:getFinishPayOrderData()
    local userData = self:getUserData()
    if not userData.finishPayOrder then
        userData.finishPayOrder = {}
    end

    return userData.finishPayOrder
end

--记录完成支付订单等待数据保存
function Player:recordFinishPayWaitSave(payOrder)
    if not GV.IsServer then
        return
    end

    if not payOrder or not payOrder.game_trade_no then
        return
    end

    local finishPayOrder = self:getFinishPayOrderData()
    finishPayOrder[payOrder.game_trade_no] = payOrder
end

--订单是否已经完成下发道具
function Player:isFinishPay(game_trade_no)
    local finishPayOrder = self:getFinishPayOrderData()
    return finishPayOrder[game_trade_no] ~= nil
end

--过期直接销毁记录（有些SDK没有失败、取消支付回调，所以过期销毁）
function Player:CheckBeBuyGoodsTimeOut()
	local curTime = luautil.getGmtStamp()
	local clearlist = {}
	local beBuyPayGoods = self:GetBeBuyGoodsInfo()
	for id, v in pairs(beBuyPayGoods.PayGoodsTab) do
		if curTime > v.reTime + 60 * 10 then
			--取消支付处理
			local pay_data = v.pay_data
			pay_data.clientresult = false
			local ok, code = GameGlobal.PayResult_Client(pay_data.user_id, pay_data)
			if ok then
				table.insert(clearlist, id)
			else
				LuaLogger.es("CheckBeBuyGoodsTimeOut code", tostring(code), pay_data.game_trade_no)
			end
		end
	end

	for _, v in pairs(clearlist) do
		self:clearBeBuyGoods(v)
	end
end


-----------------------------------------------------------------------------------------------
--充值的钻石
-----------------------------------------------------------------------------------------------
--获取全部钻石
function Player:getTotalDiamond()
    local payDiamond = self:getPayDiamond()

    local num = payDiamond.num + self:getItemNumById(GE.ResourceType.PayDiamond)
    return num
end

--获取充值的钻石
function Player:getPayDiamond()
    local _, gold_channel, _ = self:getPlatform_()
    if not gold_channel then
        return ActionFailReason.payChannelError
    end
    if not self.payDiamond[gold_channel] then
        self.payDiamond[gold_channel] = 
        {
            type = gold_channel,
            num = 0,
            recharge = 0,       --总的充值数量
            rechargeMonth = 0,  --当前月充值数量
            rechargeCount = 0,  --总充值次数
            nextMonthTimestamp = DLuaUtil.GetNextMonthTime(luautil.getGmtStamp(), DailyResetTime),  --下个月重置时间戳
        }
    end

    local info = self.payDiamond[gold_channel]
    self:checkMonthRecharge(info)
    return info, gold_channel
end

--检测月充值数量
function Player:checkMonthRecharge(payDiamond)
    local curTime = luautil.getGmtStamp()
    if not payDiamond.nextMonthTimestamp or curTime >= payDiamond.nextMonthTimestamp then
        payDiamond.rechargeMonth = 0
        payDiamond.nextMonthTimestamp = DLuaUtil.GetNextMonthTime(curTime, DailyResetTime)
    end
end

--增加充值的钻石
function Player:addPayDiamond(add, proto, balance_channel_id, balance_channel_detail)
    if add <= 0 then
        LuaLogger.es("addPayDiamond error. add value:", tostring(add))
        return false
    end

    local payDiamond, gold_channel = self:getPayDiamond()
    local leftAll = self:getPayAllDiamond()
    local leftDiamond = payDiamond.num
    payDiamond.num = leftDiamond + add

    proto.payDiamond = self:propToProto("payDiamond")

    --日志
    if DataLogMgr then
        DataLogMgr.LogMoneyResource(
            {
                all_channel_before = leftAll,
                channel_type = gold_channel,
                channel_change_before = leftDiamond,
                channel_change_count = add,
                balance_channel_id = balance_channel_id,
                balance_channel_detail = balance_channel_detail,
            },
            self
        )

        DataLogMgr.LogItemProduce({
            itemId = GE.ResourceType.PayDiamond,
            itemName = "烬海结晶",
            beforeCount = leftDiamond,
            changeCount = add,
            afterCount = payDiamond.num,
            balance_channel_id = balance_channel_id,
            balance_channel_detail = balance_channel_detail,
        },self)
    end

    return true
end

--扣除充值的钻石
function Player:costPayDiamond(cost, proto, balance_channel_id, balance_channel_detail, force)
    if cost <= 0 then
        LuaLogger.es("costPayDiamond error. cost value:", tostring(cost))
        return false
    end

    local itemCount = self:getItemNumById(GE.ResourceType.PayDiamond)
    local payDiamond, gold_channel = self:getPayDiamond()
    local dimondCount = payDiamond.num

    local allCount = itemCount + dimondCount

    if not force and allCount < cost then
        return false
    end


    local delItemCount = math.min(itemCount, cost)
    local delDiamond = cost - delItemCount  

    ---扣除道具
    if delItemCount > 0 then
        local ret = self:useItem(GE.ResourceType.PayDiamond, delItemCount, proto, GE.EventItemType.BuyGoods, GE.ResourceType.PayDiamond, true)
        if ret ~= ActionFailReason.None then
            return false
        end
    end

    local leftAll = self:getPayAllDiamond()
    local leftDiamond = payDiamond.num
    payDiamond.num = leftDiamond - delDiamond
    if payDiamond.num < 0 then
        payDiamond.num = 0
        cost = leftDiamond
    end


    proto.payDiamond = self:propToProto("payDiamond")
    --日志
    if DataLogMgr then
        DataLogMgr.LogMoneyResource(
            {
                all_channel_before = leftAll,
                channel_type = gold_channel,
                channel_change_before = leftDiamond,
                channel_change_count = -cost,
                balance_channel_id = balance_channel_id,
                balance_channel_detail = balance_channel_detail,
            },
            self
        )

        DataLogMgr.LogItemConsume({
            itemId = GE.ResourceType.PayDiamond,
            itemName = "烬海结晶",
            beforeCount = leftDiamond,
            changeCount = cost,
            afterCount = payDiamond.num,
            balance_channel_id = balance_channel_id,
            balance_channel_detail = balance_channel_detail,
        },self)
    end

    return true
end

--获取总的充值资源
function Player:getPayAllDiamond()
    local count = 0
    for k, v in pairs(self.payDiamond) do
        count = count + v.num
    end
    return count
end

--记录充值的金额
function Player:recodePayMoney(add, proto)
    if add <= 0 then
        return false
    end

    --任务触发
    self:missionTrigger(GE.MissionFinishType.FirstCharge, {count = add}, proto)

    local payDiamond = self:getPayDiamond()
    payDiamond.recharge = payDiamond.recharge + add
    payDiamond.rechargeMonth = payDiamond.rechargeMonth + add
    payDiamond.rechargeCount = payDiamond.rechargeCount + 1

    proto.payDiamond = self:propToProto("payDiamond")
end

--获取总的充值金额
function Player:getPayAllMoney()
    local count = 0
    for k, v in pairs(self.payDiamond) do
        count = count + v.recharge
    end
    return count
end

--获取这个月充值金额
function Player:getPayMoneyInMon()
    local count = 0
    for k, v in pairs(self.payDiamond) do
        self:checkMonthRecharge(v)
        count = count + v.rechargeMonth
    end
    return count
end

--未成年充值判断
--param {number} price 当次充值金额
--return {boolean} canPay
function Player:checkUnder18AgeRecharge(price)
    local age = self.yearsOld
    if not age or age >= 18 then
        return ActionFailReason.None
    end

    --未满8岁无法支付；
    --8周岁以上未满16周岁的未成年人用户单次充值金额不得超过50元人民币，每月累计充值不得超过200元人民币；
    --16周岁以上未成年人用户，单次充值金额不超过100元人民币，每月累计充值不超过400元人民币
    local cfg = {50, 200, 100, 400}

    local curMonNum = self:getPayMoneyInMon()
    if age >= 8 and age < 16 then
        if price > cfg[1] then
            return ActionFailReason.ShopRechargeOneceLimit
        end
        if curMonNum + price > cfg[2] then
            return ActionFailReason.ShopRechargeLimit
        end
    elseif age >= 16 and age < 18 then
        if price > cfg[3] then
            return ActionFailReason.ShopRechargeOneceLimit
        end
        if curMonNum + price > cfg[4] then
            return ActionFailReason.ShopRechargeLimit
        end
    else
        --小于8周岁
        return ActionFailReason.ShopRechargeLimit
    end

    return ActionFailReason.None
end

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------
--获取平台信息
---@return number[]? channels GE.PayChannel
---@return number? gold_channel Config.ChannelGold
---@return number? pay_sdk GE.PaySDK
function Player:getPlatform_(pay_channel)
    if GV.IsServer then
        local channel = self.channel
        local setting = Config.ChannelSetting[channel]
        if not setting then
            LuaLogger.es("not config channel", tostring(channel))
            return
        end
        -- if channel > GE.Channel.Quick_Origin and setting == nil then
        --  setting = Config.ChannelSetting[GE.Channel.Quick_Origin]
        -- end
    
        -- if setting == nil and channel == GE.Channel.Channel_Xipu then
        --  setting = Config.ChannelSetting[GE.Channel.Formal_Official]
        -- end
    
        local paysetting = setting.pay[self.deviceType] or setting.pay[GE.DeviceType.Editor]
        local gold_channel = paysetting.gold
        local channels = paysetting.channels
        local pay_sdk = setting.pay_sdk
    
        if not channels or not gold_channel or not pay_sdk then
            LuaLogger.es("not config channel", tostring(channel))
            return
        end
        return channels, gold_channel, pay_sdk
    end

	local channel = SDKMgr:getChannel()
    local deviceType = UnityEngine.Application.platform:ToInt()
	local setting = Config.ChannelSetting[channel]
	if channel > GE.Channel.Quick_Origin and setting == nil then
		setting = Config.ChannelSetting[GE.Channel.Quick_Origin]
	end
	
	if setting == nil and channel == GE.Channel.Channel_Xipu then
		setting = Config.ChannelSetting[GE.Channel.Formal_Official]
	end
	
	local paysetting = setting.pay[deviceType] or setting.pay[GE.DeviceType.Editor]
	local gold = paysetting.gold
--[[	while Config.ChannelGoldTo[gold] ~= gold do
		gold = Config.ChannelGoldTo[gold]
	end]]
	local channels = paysetting.channels
	local pay_sdk = setting.pay_sdk
	return pay_channel or channels, gold, pay_sdk
end


return Player