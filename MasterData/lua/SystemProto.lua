SystemProto = {};

--查询账号
function SystemProto:ServerError(msg)
    
    DebugLog(table.tostring(msg, true));
    --LogWarning("服务器报错\n"..table.tostring(msg), "ff0000");
    -- LogError("ff9977服务器报错\n"..table.tostring(msg));
    -- LogError(msg,"ff9977");
    --assert(nil, "服务器报错\n"..table.tostring(msg))
    -- ServerLogError("服务器报错,截图下一行");
    ServerLogError("服务器报错\n"..table.tostring(msg, true));
end

function SystemProto:ServerWarning(msg)
    -- LogWarning("服务器报错\n"..table.tostring(msg));
    ServerLogError("服务器警告\n"..table.tostring(msg, true));
end

function SystemProto:Tips(msg)
    if(msg) then
        TipsMgr:HandleMsg(msg); 
    end 
end

function SystemProto:TestMap(msg)
    DebugLog("====================TestMap=========================","ff0000");
    LogWarning(msg);
end

---------------------------------------------仅每日到点更新一次--------------------------
function SystemProto:ActiveZeroNotice(proto)
    Log("每日到点更新")

    --体能购买次数
    if (proto.datas and proto.datas.hot_buy_cnt) then
        PlayerClient:HotBuyCnt(proto.datas.hot_buy_cnt)
        EventMgr.Dispatch(EventType.Player_HotChange)
    end
    --催眠次数
    if (proto.datas and proto.datas.phy_game_cnt) then
        FavourMgr:DailyData(proto.datas.phy_game_cnt)
    end
    --抽卡相关
    if (proto.datas and proto.datas.card_pool_daily_use_cnt) then
        CreateMgr:SetDailyUseCnt(proto.datas.card_pool_daily_use_cnt)
    end
    if (proto.datas and proto.datas.card_pool_free_cnt) then
        CreateMgr:SetFreeCnt(proto.datas.card_pool_free_cnt)
    end
    --刷新活动时间
	ActivityMgr:RefreshOpenState()

    -- 每日刷新
    EventMgr.Dispatch(EventType.Update_Everyday)

    --签到刷新
    -- SignInMgr:CheckAll()
end
----1058---俄地区千禧充值累计打点--满足要求，
---服务端推送给客户端-客户端传入SDK
function SystemProto:QianXiLogEvent(proto)
    if CSAPI.RegionalCode()~=6 then
        LogError("接收到1058协议,正常只有英俄地区能接收该协议，其它地区接收到视为服务器异常，发送错误")
        return;
    end
    ---LogError("接收到1058协议："..table.tostring(proto))
    if proto then
        for i, v in pairs(proto.logTypeArr) do
            --- LogError("i"..i.." v:"..v)
            if v=="firstpurchase" then
                --- LogError("进入了首冲")
                BuryingPointMgr:TrackEvents(ShiryuEventName.QIANXI_Client_firstpurchase,{eventValue="firstpurchase",isRepeatReport="false"})
            elseif v=="pay_9.99" then
                --- LogError("进入了9.99")
                BuryingPointMgr:TrackEvents(ShiryuEventName.QIANXI_Client_pay_999,{eventValue="pay_9.99",isRepeatReport="false"})
            elseif v=="pay_19.99" then
                --- LogError("进入了19.99")
                BuryingPointMgr:TrackEvents(ShiryuEventName.QIANXI_Client_pay_1999,{eventValue="pay_19.99",isRepeatReport="false"})
            elseif v=="pay_49.99" then
                --- LogError("进入了49.99")
                BuryingPointMgr:TrackEvents(ShiryuEventName.QIANXI_Client_pay_4999,{eventValue="pay_49.99",isRepeatReport="false"})
            elseif v=="pay_99.99" then
                ---  LogError("进入了99.99")
                BuryingPointMgr:TrackEvents(ShiryuEventName.QIANXI_Client_pay_9999,{eventValue="pay_99.99",isRepeatReport="false"})
            end
        end

    else
        LogError("服务端传入的打点数据为空值");
    end
end