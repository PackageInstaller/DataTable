--SDK支付管理类
local this = MgrRegister("SDKPayMgr")
require "LoginCommFuns"

function this:Init()
    -- sdk未消耗订单查询
    EventMgr.AddListener(EventType.SDK_Pay_CheckOrderRet, this.OnCheckOrderRet)
    -- sdk支付成功处理
    EventMgr.AddListener(EventType.SDK_Pay_Result,this.OnSDKPayResult)
	--sdk待验证订单返回
	EventMgr.AddListener(EventType.SDK_Pay_VerifyOrder,this.OnVerifyOrder)
	EventMgr.AddListener(EventType.SDK_Pay_InitFinish,this.OnSDKInitFinish)
	EventMgr.AddListener(EventType.Client_Init_Finish,this.ClientInitFinish)
	EventMgr.AddListener(EventType.Shop_Buy_Mask,this.OnPayWait)
	this.currPlatform=CSAPI.GetPlatform();
	this.verifyCount=0;
	self:SetIsPaying(false);
	if this.currPlatform==8 then --IOS
        ShopCommFunc.InitPaySDK();--初始化苹果支付SDK
    end
end

--在ClientInitFinishRet回调后调用
function this.ClientInitFinish()
	--检查一次发货信息
	if CSAPI.IsADV() or CSAPI.IsDomestic() then
		--海外和中台SDK 短线重连初始化 不清空
	else
		SDKPayMgr:SetLastPayInfo(nil,nil);
	end
	SDKPayMgr:SearchPayReward(true);
	if CSAPI.GetChannelType()==ChannelType.QOO then
		SDKPayMgr:CheckSDKOrder();--检查SDK订单信息
	elseif this.isSDKInit and this.currPlatform==8 then --IOS
		SDKPayMgr:CheckSDKOrder(); -- 检查SDK订单信息
		EventMgr.Dispatch(EventType.SDK_Pay_VerifyCache,nil,true); -- 检查本地缓存的SDK订单信息
	end
end

function this.OnSDKInitFinish(isOk)
	this.isSDKInit=isOk;
end

--SDK支付回调
function this.OnSDKPayResult(data)
	this:HandleSDKPayResult(data);
end

--检测SDK内是否有未完成的订单
function this:CheckSDKOrder()
	if CSAPI.GetChannelType()==ChannelType.QOO then
		EventMgr.Dispatch(EventType.SDK_Pay_CheckOrder,nil,true);
	elseif this.currPlatform==8 then --IOS
		--LogError("IOS------------------------>CheckOrder");
		EventMgr.Dispatch(EventType.SDK_Pay_CheckOrder,nil,true);
	end
end

--处理SDK支付返回结果
function this:HandleSDKPayResult(data)
	-- LogError("ShopMgr:HandleSDKPayResult______________________>");
	self:SetIsPaying(false);
	if data.Code==200 then --支付成功
        -- LogError("支付成功！");
        -- LogError(data.OrderID)
        -- LogError(tostring(data.Info));
		-- LogError(tostring(data.Msg))
		local record=nil;
		local sdk_order_id=nil;
		local channelType=CSAPI.GetChannelType();
		--如果有订单ID则上传订单ID
		if data.SDKType==PayType.Alipay then --支付宝
			local respone=nil;
			local js=Json.decode(data.Info);
			if type(js)=="string" then
				local jss=Json.decode(js);
				respone=jss.alipay_trade_app_pay_response;
			else
				respone=js.alipay_trade_app_pay_response;
			end
			if respone then
				record={};
				record.sdk_order_id=respone.trade_no;
				sdk_order_id=respone.trade_no;
				record.send_time=TimeUtil.GetTime();
			end
		elseif data.SDKType==PayType.IOS and this.verifyCount>0 then --IOS
			EventMgr.Dispatch(EventType.SDK_Pay_VerifyCache,nil,true);
		end
		--成功则缓存最后一个订单信息
		SDKPayMgr:SetLastPayInfo(data.OrderID,data.SDKType)
		self:SearchPayReward()
		-- LogError("支付成功！sdk订单号："..tostring(sdk_order_id).."\t订单号："..tostring(data.OrderID).."\tGoodsID:"..tostring(data.GoodsID).."\t isPC:"..tostring(CSAPI.IsPCPlatform()))
		if record~=nil then --上传SDK订单号
			if CSAPI.IsADV()==false then
				BuryingPointMgr:TrackEvents("store_pay",record);
			end
		end
		if not CSAPI.IsPCPlatform() then --非PC才上传信息
			local payType=PayTypeName[data.SDKType];
			local moneyType=channelType==ChannelType.QOO and "USD" or "CNY";
			--上传热云事件
			local orderId=GCardCalculator:GetPayOrderStrId(data.OrderID, data.SDKType, channelType);
			if data.GoodsID~=nil then
				local comm=ShopMgr:GetFixedCommodity(tonumber(data.GoodsID));
				if comm~=nil then		
					local priceInfo=comm:GetRealPrice();
					if priceInfo[1].id~=-1 and comm:HasOtherPrice(ShopPriceKey.jCosts1) then
						priceInfo=comm:GetRealPrice(ShopPriceKey.jCosts1);
						if priceInfo[1].id==-1 then
							-- LogError(orderId);
							-- LogError(data.GoodsID);
							--LogError("ReYunSDK:Pay------------------->"..tostring(orderId));
							--ReYunSDK:SetPayEvent(orderId,payType,moneyType,priceInfo[1].num,{channelType=CSAPI.GetChannelName()});--传入价格，单位：元
							JuLiangSDK:Purchase(comm:GetType(),comm:GetName(),comm:GetID(),1,payType,moneyType,true,  math.ceil(priceInfo[1].num)) --传入价格，单位：元,整数且向上取整
						end
					end			
				end
			end
		end
		FuncUtil:Call(function()
			local msg=LanguageMgr:GetTips(15116);
			Tips.ShowTips(msg);
		end,nil,1000);--延迟1秒提示
		-- local msg=LanguageMgr:GetTips(15116);
		-- Tips.ShowTips(msg);
    elseif data.Code==100 then--支付取消
        -- LogError("支付取消！")
		-- LogError(data.Info)
		-- LogError(data.Msg)
		local msg=LanguageMgr:GetTips(15115);
        local dialogdata = {};
        dialogdata.content = msg
        CSAPI.OpenView("Prompt", dialogdata)
		local record={
			order_id=tostring(data.OrderID),--后台订单ID
		    pay_result=msg,--支付状态
		    pay_tips="订单结束",
			sdk_msg=data.Msg,--SDK返回的支付错误信息
			send_time=TimeUtil.GetTime(),
		}
		EventMgr.Dispatch(EventType.Shop_Buy_Mask,false)
		-- LogError("上传数数数据:")
		-- LogError(record)
		if CSAPI.IsADV()==false then
			BuryingPointMgr:TrackEvents("store_pay",record);
		end
    else --支付失败上传数数数据
		-- LogError("支付失败！")
		-- LogError(tostring(data.Info))
		-- LogError(data.Msg)
		local msg=LanguageMgr:GetTips(15114);
		EventMgr.Dispatch(EventType.Shop_Buy_Mask,false)
		local isTips=false;
		if data.SDKType==PayType.WeChat and data.Msg=="-10" then --微信-10表示未安装微信客户端
			LogError("未安装微信客户端...");
			msg=LanguageMgr:GetByID(18309);
		elseif data.SDKType==PayType.IOS and (data.Info=="" or data.Info==nil) and data.Msg=="Unknown" then --IOS无法获取到订单信息且返回unknown，判定为网络不佳
			isTips=true;
			msg="网络状况不佳...";
		end
		if isTips then
			Tips.ShowTips(msg);
		else
			local record={
				order_id=tostring(data.OrderID),--后台订单ID
				pay_result=msg,--支付状态
				pay_tips="订单结束",
				sdk_msg=data.Msg,--SDK返回的支付错误信息
				send_time=TimeUtil.GetTime(),
			}
			local dialogdata = {};
			dialogdata.content = msg;
			CSAPI.OpenView("Prompt", dialogdata)
			-- LogError("上传数数数据:")
			-- LogError(record)
			if CSAPI.IsADV()==false then
				BuryingPointMgr:TrackEvents("store_pay",record);
			end
		end
    end
end

--检查订单状态回调
function this.OnCheckOrderRet(jStr)
    -- LogError("OnCheckOrderRet")
	local result = Json.decode(jStr);
	if CSAPI.GetChannelType()==ChannelType.QOO then--qoo检查订单状态回调
		-- UnityEngine.GUIUtility.systemCopyBuffer=jStr;
		-- LogError(result.data)
		if result.code == SDKResultCode.Success then -- 成功
			if result.data and #result.data > 0 then -- 有未完成的订单,发送订单ID列表给服务器
				local serverId = tostring(ChannelWebUtil.GetServerID());
				local ids = {};
				for k, v in ipairs(result.data) do
					if v.developerPayload then
						local js = Json.decode(v.developerPayload);
						-- LogError(tostring(js.server_id).."\t ServerID:"..serverId)
						if v.cpOrderId and tostring(js.server_id) == serverId then
							table.insert(ids, tostring(v.cpOrderId));
						end
					end
				end
				if #ids > 0 and LoginProto:IsOnline() then --玩家在线才发送
					local data = {
						ids = Json.encode(ids),
						server_id = serverId,
						channel = tostring(CSAPI.GetChannelType())
					};
					-- LogError(data);
					-- --发送给服务器
					ChannelWebUtil.SendToServer2(data, ChannelWebUtil.Extends.CheckOrder, function(json)
						if json then
							for k, v in ipairs(json) do
								if v.isOk ~= true then
									-- LogError("id:" .. tostring(v.id) .. "\t error:" .. tostring(v.error));
								end
							end
						end
					end);
				end
			end
		end
	end
end

--待验证订单返回 return:object[3] 0:ProductData 1:bool 2:count 
function this.OnVerifyOrder(arr)
	if arr==nil then
		LogError("待验证信息不能为nil！");
		do return end;
	end
	local result = Json.decode(arr[0]);
	this.verifyCount=arr[2] or 0;--剩余需要验证的订单数量
	if this.currPlatform==8 then --apple pay 待验证订单
		local data={
			uid=result.uid,
			account=result.account,
			channel=result.channel,
			pay_type=result.pay_type ,
			server_id=result.server_id,
			out_trade_no=result.out_trade_no,
			notify_Data=result.receipt,
		};
		-- LogError(tostring(data.uid))
		if (data.uid==nil or data.uid=="" or string.find(tostring(data.uid),"function:") or data.account==nil or data.account=="" or string.find(tostring(data.account),"function:")) and (data.notify_Data~=nil) then--只有验证信息的情况下补全其它能获取到的信息
			local serverInfo=ChannelWebUtil.GetServerInfo();
			if serverInfo==nil then
				LogError("不全验证信息时获取当前服务器信息失败!终止支付流程...");
				do return end;
			end
			data.uid=tostring(PlayerClient:GetUid());
			data.account=tostring(GetLastAccount());
			data.channel=tostring(CSAPI.GetChannelType());
			data.pay_type=tostring(PayType.IOS);
			data.server_id=tostring(serverInfo.id);
			data.out_trade_no="";
			data.is_lost="1";--是否丢失的订单信息
		end
		-- LogError("IOS发送凭据到服务器");
		-- LogError(tostring(data.out_trade_no).."\t"..tostring(data.uid).."\t"..tostring(data.account).."\t"..tostring(data.channel).."\t"..tostring(data.server_id).."\t islost:"..tostring(data.is_lost));
		-- LogError("是否显示遮罩："..tostring(arr[1]))
		if arr[1]==true then
			EventMgr.Dispatch(EventType.Shop_Buy_Mask,true)
		end
		ChannelWebUtil.SendToServer2(data, ChannelWebUtil.Extends.CheckOrder, function(json)
			if json then
				-- LogError("IOS凭据验证返回！");
				-- LogError(json)
				local eData={
					transaction_id=result.transactionID,
					store_goods_ID=result.store_goods_ID,
					isSuccess=json.isOk,
				}
				EventMgr.Dispatch(EventType.SDK_Pay_Verify,eData,true);--删除订单缓存
			end
		end);
	end
end

--设置最后一次下订单的信息（只用于查询支付下发信息，支付成功后缓存，查询下发信息成功后删除）
function this:SetLastPayInfo(_orderID,_payType)
	self.lastOrderID=_orderID;
	self.lastPayType=_payType;
end

--向服务器查询支付发下信息
function this:SearchPayReward(isFirst)
	self.searchPayCount=0;
	if not isFirst then
		--锁屏商店界面
		EventMgr.Dispatch(EventType.Shop_Buy_Mask,true)
	end
	self.searchPaySuccess=false;
	FuncUtil:Call(self.SendSearchPayReward,self,500,self.lastOrderID,self.lastPayType);
end
function this:SearchPayRewardAtOne()
	if self.lastOrderID~=nil and self.lastPayType~=nil then
		EventMgr.Dispatch(EventType.Shop_Buy_Mask,false)
		PlayerProto:PayReward(self.lastOrderID,self.lastPayType);
	end
end
---停止查询
function this:StopSearchPayReward()
	self:SetIsPaying(false);
	EventMgr.Dispatch(EventType.Shop_Buy_Mask,false)
	self.searchPayCount=0;
	self.searchPaySuccess=true;
	self:SetLastPayInfo(nil,nil); --清理缓存信息
end
--查询，三次未响应则放弃
function this:SendSearchPayReward(_orderID,_payType)
	if not NetMgr.net:IsConnected() or self.searchPayCount>=30 or self.searchPaySuccess==true then --断线也退出发送
		-- LogError("断线退出查询订单————————————————————————————————————>");
		EventMgr.Dispatch(EventType.Shop_Buy_Mask,false)
		do return end
	end
	-- LogError("查询订单————————————————————————————>"..tostring(_orderID).."\t"..tostring(_payType));
	self.searchPayCount=self.searchPayCount or 0;
	local delay=self.searchPayCount>0 and 1000 or 0;
	self.searchPayCount=self.searchPayCount+1;
	PlayerProto:PayReward(_orderID,_payType);
	FuncUtil:Call(self.SendSearchPayReward,self,delay,_orderID,_payType);
end

--收到支付奖励信息
function this:SetPayReward(proto)
	-- LogError(proto)
	if (proto and proto.rewards and #proto.rewards > 0) then
        if (self.payRewards == nil) then
            self.payRewards = proto.rewards
        else
            for i, v in pairs(proto.rewards) do
                table.insert(self.payRewards, v)
            end
        end
        if (proto.is_finish) then
			self:SetIsPaying(false);
			EventMgr.Dispatch(EventType.Shop_Buy_Mask,false)
			self.searchPayCount=0;
			self.searchPaySuccess=true;
			self:SetLastPayInfo(nil,nil); --清理缓存信息
            local rewards = {}
            rewards = self.payRewards
            UIUtil:OpenReward({rewards,closeCallBack=function()
				self.IsMailReward(proto.is_notice);
			end})
            self.payRewards = nil
        end
	elseif (proto and proto.is_finish==true) then --没有任何东西需要展示
		self:SetIsPaying(false);
		EventMgr.Dispatch(EventType.Shop_Buy_Mask,false)
		self.IsMailReward(proto.is_notice);
		self.searchPayCount=0;
		self.searchPaySuccess=true;
		self:SetLastPayInfo(nil,nil); --清理缓存信息
        self.payRewards = nil
    end
end

function this.IsMailReward(is_notice)
	if is_notice then
		--邮件发送的奖励
		local dialogdata = {
			content = LanguageMgr:GetTips(15117),
			okCallBack = function()
				JumpMgr:Jump(90001)
			end
		}
		CSAPI.OpenView("Dialog", dialogdata);
	end
end

--获取订单ID func：回调
function this:GenOrderID(commodity,payType,isInstall,shopPriceKey,func)
	if commodity==nil then
		LogError("传入的道具ID为nil!");
		return;
	end
	local channelType=CSAPI.GetChannelType()
	-- local channelType=ChannelType.BliBli;
	local serverInfo=ChannelWebUtil.GetServerInfo();
	if serverInfo==nil then
		LogError("调用支付时获取当前服务器信息失败!终止支付流程...");
		do return end;
	end
	local amout=commodity:GetRealPrice(shopPriceKey)[1].num;
	if CSAPI.IsADV() or CSAPI.IsDomestic() then
		local data = {}
		local orderUrl = nil
		if CSAPI.IsADV() then
			local Advchannel=6;
			---服务端要求 2026-8-25  如果英俄地区，默认英语 传12，默认俄语传13 ,如果默认其它语言不变
			if CSAPI.RegionalCode()==6 then
				if CSAPI.GetRegionalLanguage()==4 then
					---默认英文
					Advchannel=12;
				elseif CSAPI.GetRegionalLanguage()==6 then
					---默认俄语
					Advchannel=13;
				end
			end
			---海外流程
			data=
			{
				uid=tostring(PlayerClient:GetUid()),---游戏uid
				account=tostring(ShiryuSDK.Serverlogin.open_id), ---游戏账号
				server_id=tostring(serverInfo.id),---服务器id
				product_id=tostring(commodity["cfg"]["id"]),---商品id
				subject=tostring(commodity:GetName()),---商品名称（读配置表）
				amount=tostring(amout),---商品价格 元（读配置表）
				--amount=tostring(6),---商品价格 元（读配置表）
				zi_long_open_id=tostring(ShiryuSDK.ShiryuLogin.channelExts["openId"]),--- 紫龙用户 open_id
				center_web_uid=tostring(ShiryuSDK.ShiryuLogin.uid),---中台 uid
				channel=tostring(Advchannel),---固定值
				pay_type=tostring(9),---固定值
				useJCost=shopPriceKey,
			}
			orderUrl = ChannelWebUtil.Extends.ziLongpayClientGetOrderId;
		else
			-- 国内
			data=
			{
				uid=tostring(PlayerClient:GetUid()),---游戏uid
				account=tostring(ShiryuSDK.Serverlogin.open_id), ---游戏账号
				server_id=tostring(serverInfo.id),---服务器id
				product_id=tostring(commodity["cfg"]["id"]),---商品id
				subject=tostring(commodity:GetName()),---商品名称（读配置表）
				amount=tostring(amout),---商品价格 元（读配置表）
				--amount=tostring(6),---商品价格 元（读配置表）
				thirty_part_id=tostring(ShiryuSDK.ShiryuLogin.channelExts["openId"]),--- 紫龙用户 open_id
				center_web_uid=tostring(ShiryuSDK.ShiryuLogin.uid),---中台 uid
				channel=tostring(6),---固定值
				pay_type=tostring(12),---固定值   国内要求固定 12
				useJCost=shopPriceKey,
			}
			orderUrl = ChannelWebUtil.Extends.clientGetOrderId_gn;
		end
		Log("------------Send GenOrderID--to-SDK------------------")
		---LogError(data)
		print("Send GenOrderID--to-SDK---------------"..table.tostring(data))

		ChannelWebUtil.SendToServer2(data,orderUrl,func);
	else
        ---国内流程
		CSAPI.GetSystemInfo(function(js)
			local accountName = GetLastAccount();
			local deviceid=ReYunSDK:GetDeviceID();
			-- LogError(deviceid)
			-- LogError(js);
			local json=Json.decode(js);
			local data={
				uid=tostring(PlayerClient:GetUid()),
				product_id=tostring(commodity:GetID()),
				server_id=tostring(serverInfo.id),
				pay_type=tostring(payType),
				account=tostring(accountName),
				channel=tostring(channelType),
				web_ip=tostring(serverInfo.webIp),
				web_port=tostring(serverInfo.webPort),
				sdk_url=tostring(serverInfo.sdkUrl),
				subject=tostring(commodity:GetName()),
				deviceid=tostring(deviceid),
				idfa=tostring(deviceid),
				imei=tostring(deviceid),
				androidid=tostring(deviceid),
				oaid=tostring(deviceid),
				mac=tostring(json.netMac),
				ip=tostring(json.ipv4),
				ipv6=tostring(json.ipv6),
				model=tostring(json.deviceName),
				pkgname=tostring(CSAPI.GetPackageName()),
				is_install=isInstall and "1" or "2",
				useJCost=shopPriceKey,
			}
			local realPrice=commodity:GetRealPrice(shopPriceKey);--各渠道传递给服务器的价格单位统一为元，后端处理不同渠道所需的实际单位
			if payType==PayType.Alipay or payType==PayType.WeChat or payType==PayType.AlipayQR or payType==PayType.WeChatQR or payType==PayType.BsAli then
				data.total_amount=tostring(realPrice[1].num);
				data.currency="CNY";
			elseif payType==PayType.BiliBili then
				local userInfo=PlayerClient:GetSDKUserInfo();
				if userInfo==nil then
					LogError("未找到SDK用户信息，支付失败！");
					do return end;
				end
				data.user_id=userInfo.uid;
				data.total_amount=tostring(realPrice[1].num);
				data.game_money="1";
			elseif payType==PayType.IOS then--IOS
				data.total_amount=tostring(realPrice[1].num);
				data.currency="CNY";
			end
			-- LogError("GenOrderID：");
			-- LogError(data)
			-- if this.currPlatform==7 or this.currPlatform==0  then
			-- 	Log("编辑器下无法调用sdk支付！");
			-- 	do return end
			-- end
			ChannelWebUtil.SendToServer2(data,ChannelWebUtil.Extends.GetOrderID,func);
		end);
	end


end

--支付锁屏
function this.OnPayWait(isWait)
	--LogError(tostring(isWait))
	if isWait then
		if this.isWait then --已经在等待中时先取消再启动
			EventMgr.Dispatch(EventType.Net_Msg_Getted,"pay_wait");
		end
		 local PayWaitTime=60000;
		if CSAPI.IsADV() then PayWaitTime=20000; end
		EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="pay_wait",time=PayWaitTime,timeOutCallBack=function()
			this.isWait=false;
			SDKPayMgr:SetIsPaying(false);--超时
		end});
		this.isWait=true;
	else
		EventMgr.Dispatch(EventType.Net_Msg_Getted,"pay_wait");
		this.isWait=false;
	end
end

--设置正在支付中..
function this:SetIsPaying(isPaying)
	--LogError("SetIsPaying:"..tostring(isPaying))
	self.isPaying=isPaying;
end

--返回是否正在支付中
function this:GetIsPaying()
	return self.isPaying;
end

function this:Clear()
	EventMgr.RemoveListener(EventType.Player_Update,this.OnPlayerUpdate)
	EventMgr.RemoveListener(EventType.SDK_Pay_CheckOrderRet, this.OnCheckOrderRet)
	EventMgr.RemoveListener(EventType.SDK_Pay_Result,this.OnSDKPayResult)
	EventMgr.RemoveListener(EventType.SDK_Pay_VerifyOrder,this.OnVerifyOrder)
	EventMgr.RemoveListener(EventType.Main_Enter,this.OnMainEnter)
	EventMgr.RemoveListener(EventType.Shop_Buy_Mask,this.OnPayWait)
	self:SetIsPaying(false);
	self.payRewards = nil
	self.lastOrderID=nil;
	self.lastPayType=nil;
	self.searchPayCount=0;
	self.searchPaySuccess=false;
	this.verifyCount=0;
	this.isWait=false;
end

return this