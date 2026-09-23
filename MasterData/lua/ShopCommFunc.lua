-- 商店公用方法
local this = {};
local normalSize = 1;
local iconSize = 1.3;
local roleSize = 0.75
this.itemQualitys = {nil, "effectNode4", "effectNode5", "effectNode3", "effectNode2", "effectNode1"};
local channelType = CSAPI.GetChannelType();
this.fixedSkinID = 50025;
this.fixedHideTab = 1006;
-- 标签数组的公用内容
this.TagsSort = {
    [1] = 1,
    [2] = 7,
    [3] = 3,
    [4] = 2,
    [5] = 5,
    [6] = 4,
    [7] = 6,
};
this.TagsImgName = {"img_31_1", "img_31_3","img_31_2",  "img_31_3","img_31_3","img_31_4","img_31_5"}
this.TagsColor = {"ffffff","35ffa7", "ffffff",  "fef73a", "ff4473", "ffffff", "ffffff"}
this.TagsColor2 = {"ffc248","35ffa7", "ff793d",  "fef73a", "ff4473", "b7fe3a","f55699"}
this.TagsIconName = {"img_30_01", "img_30_03","img_30_02",  "img_30_05","img_30_04","img_30_06","img_30_10"}
this.TagsIconName2 = {"img_30_01", "img_30_03","img_30_02",  "img_30_05","img_30_04","img_30_06","img_30_09"}
this.TagsTxtIds = {18173, 18175, 18170,  18176,nil,nil,18211}

-- shopPriceKey:消耗货币类型
function this.GetPriceTips(commodity, currNum, shopPriceKey)
    local str = "";
    if commodity == nil then
        return str;
    end
    local priceInfo = commodity:GetRealPrice(shopPriceKey);
    if priceInfo then
        local currPrice = priceInfo[1].num * currNum;
        if priceInfo[1].id == -1 then
            str = LanguageMgr:GetByID(18013) .. currPrice;
        else
            local goldInfo = GoodsData();
            goldInfo:InitCfg(priceInfo[1].id);
            str = currPrice .. goldInfo:GetName();
        end
    end
    return str;
end

-- 设置价格图标 pIconTips:货币的文字符号
function this.SetPriceIcon(moneyIcon, cost,extend)
    if moneyIcon == nil or cost == nil then
        LogError("设置价格图标出错！" .. tostring(moneyIcon == nil) .. "\t" .. tostring(cost == nil));
        return;
    end
    if cost.id == -1 then
        CSAPI.SetGOActive(moneyIcon, false);
    else
        CSAPI.SetGOActive(moneyIcon, true);
        local cfg = Cfgs.ItemInfo:GetByID(cost.id);
        if cfg and cfg.icon then
            local iconName=extend and cfg.icon..extend or cfg.icon .. "_1"
            ResUtil.IconGoods:Load(moneyIcon, iconName);
        else
            LogError("道具商店：读取物品的价格Icon出错！CostInfo:");
            LogError(cost)
        end
    end
end

-- 是否有足够的货币进行支付 shopPriceKey：不传默认判断第一个支付方式是否支持支付
function this.CheckCanPay(commodity, currNum, voucherList, shopPriceKey)
    local canPay = false;
    if commodity == nil then
        return canPay;
    end
    local priceInfo = commodity:GetRealPrice(shopPriceKey);
    if priceInfo then
        local currPrice = priceInfo[1].num * currNum;
        if voucherList ~= nil then -- 计算扣除折扣券之后的值
            local isOk, tips, res = GLogicCheck:IsCanUseVoucher(commodity:GetCfg(), voucherList, TimeUtil:GetTime(), 1,
                PlayerClient:GetLv(), nil, shopPriceKey);
            if isOk and res ~= nil then
                currPrice = res[1][2];
            end
        end
        if priceInfo[1].id == ITEM_ID.GOLD or priceInfo[1].id == ITEM_ID.DIAMOND or priceInfo[1].id == g_AbilityCoinId or
            priceInfo[1].id == g_ArmyCoinId then
            canPay = PlayerClient:GetCoin(priceInfo[1].id) >= currPrice;
        elseif priceInfo[1].id == -1 then
            canPay = true;
        else
            local count = BagMgr:GetCount(priceInfo[1].id);
            canPay = count >= currPrice;
        end
    else -- 没有价格等于免费
        return true;
    end
    return canPay;
end

-- 购买道具 --useCost:扣费方式price_1/price_2:用于家具商店判断支付道具 payType:对应payType枚举 isIntall:是否安装对应的app客户端 shopPriceKey:普通道具的价格枚举
function this.BuyCommodity(commodity, currNum, callBack, useCost, payType, isInstall, voucherList, shopPriceKey)
    if commodity == nil then
        do
            return
        end
    end
    local canPay = this.CheckCanPay(commodity, currNum, voucherList, shopPriceKey);
    if commodity:GetType() == CommodityItemType.MonthCard then -- 月卡,判断剩余时间是否可以续费
        local curDays = 0;
        if commodity:GetSubType() == CommodityItemSubType.MonthCard then
            curDays = ShopMgr:GetMonthCardDays();
        else
            local info = commodity:GetMonthCardInfo();
            curDays = info and info.l_cnt or 0;
        end
        local limitDays = commodity:GetResetValue();
        if curDays > limitDays then -- 月卡大于限制天数则无法购买
            local langId = commodity:GetSubType() == CommodityItemSubType.MonthCard and 15108 or 15128;
            Tips.ShowTips(LanguageMgr:GetTips(langId));
            do
                return
            end
        end
    end
    local useCost=nil;
    if commodity:GetType() == CommodityItemType.THEME or commodity:GetType() == CommodityItemType.FORNITURE then
        useCost=shopPriceKey==ShopPriceKey.jCosts1 and "price_2" or "price_1"
    end
    if canPay then
        if CSAPI.IsDomestic() then
            -- 添加弹窗
            local priceInfo = commodity:GetRealPrice(shopPriceKey);
            if priceInfo and priceInfo[1].id == ITEM_ID.DIAMOND then -- 弹窗确认
                local good = BagMgr:GetFakeData(priceInfo[1].id);
                local rNum = priceInfo[1].num;
                if commodity:GetType() ~= CommodityItemType.SUIT and voucherList~=nil then
                    local isOk, tips, res = GLogicCheck:IsCanUseVoucher(commodity:GetCfg(), voucherList,
                        TimeUtil:GetTime(), currNum, PlayerClient:GetLv(), nil, shopPriceKey);
                    if isOk and res then
                        rNum = res[1][2];
                    end
                end
                local dialogData = {
                    content = LanguageMgr:GetTips(15123, good:GetName(), rNum * currNum),
                    okCallBack = function()
                        this.BuyCommodity_Domestic(commodity, currNum, callBack, useCost, payType, isInstall,
                            voucherList, shopPriceKey)
                    end
                }
                CSAPI.OpenView("Dialog", dialogData);
            else
                this.BuyCommodity_Domestic(commodity, currNum, callBack, useCost, payType, isInstall, voucherList,
                    shopPriceKey)
            end
            -- this.BuyCommodity_Domestic(commodity, currNum, callBack, useCost, payType, isInstall, voucherList,shopPriceKey)
        elseif CSAPI.IsADV() then
            ---海外------------------------
            local priceInfo = commodity:GetRealPrice(shopPriceKey);
            Log("-------------------canPay------------priceInfo--------" .. table.tostring(priceInfo))
            if priceInfo and priceInfo[1].id == -1 then -- 使用SDK调用支付
                SDKPayMgr:SetLastPayInfo(nil, nil);
                if SDKPayMgr:GetIsPaying() then -- 目前只针对IOS进行拦截
                    Log("正在处理支付中...");
                    do
                        return
                    end
                end
                local priceInfo2 = commodity:GetPrice(shopPriceKey);
                if CSAPI.Currentplatform == CSAPI.Android or CSAPI.Currentplatform == CSAPI.IPhonePlayer then
                    EventMgr.Dispatch(EventType.Shop_Buy_Mask, true);
                else
                    print("-----PC-----IsGetIsMobileplatform")
                end

                -- LogError(commodity)
                print("commodity---------------------" .. table.tostring(commodity))
                local AdvpriceInfo = commodity:GetPrice(shopPriceKey);
                local Advcommodityprice=0;
                if CSAPI.RegionalCode()==6 then
                    Advcommodityprice = AdvpriceInfo[1].num; ---单位分，配置表也修改成了分
                else
                    Advcommodityprice = AdvpriceInfo[1].num * 100; ---单位元
                end
                local SDKamount = commodity["cfg"]["amount"]; ---单位分
                ---如果没有这个字段，那么传表数据给服务端
                if SDKamount == nil then
                    SDKamount = Advcommodityprice;
                elseif tostring(SDKamount) == tostring(0) and tostring(SDKamount) ~= tostring(Advcommodityprice) then
                    SDKamount = Advcommodityprice;
                    LogError("存在定价表数据异常：" .. table.tostring(commodity, true))
                elseif tostring(SDKamount) ~= tostring(Advcommodityprice) then
                    SDKamount = Advcommodityprice;
                    LogError("配置表和SDK存在定价表数据异常：" .. table.tostring(commodity, true))
                end
                Log("商品价格分：" .. Advcommodityprice)
                ClientProto:QueryPrePay(commodity:GetID(), SDKamount, function(proto)
                    if tostring(proto["productId"]) == tostring(commodity:GetID()) then
                        SDKPayMgr:GenOrderID(commodity, payType, isInstall, shopPriceKey, function(Backresult)
                            Log("GenOrderID data back：" .. table.tostring(Backresult));
                            local result = {};
                            -- LogError(Backresult)
                            print("GenOrderID  Backresult---------------------" .. table.tostring(commodity))
                            result.is_ok = Backresult["is_ok"];
                            result.msg = Backresult["msg"];
                            result.id = Backresult["id"];
                            result.inc_id = Backresult["inc_id"];
                            result.key_id = Backresult["key_id"];
                            result.rand_key = Backresult["rand_key"];
                            -- LogError(result)
                            if result and (result.msg ~= nil and result.is_ok == false) then
                                LogError("获取订单ID时出现错误！信息：" .. tostring(result.msg))
                                if payType and payType == PayType.ZiLongGitPay and tostring(commodity:GetID()) ==
                                    tostring(30033) then
                                    if commodity:GetName() then
                                        LanguageMgr:ShowTips(1046, commodity:GetName())
                                    end
                                else
                                    Tips.ShowTips(LanguageMgr:GetTips(1011));
                                end
                                EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                                do
                                    return
                                end
                            elseif result == nil or (result and (result.id == nil or result.id == "")) then
                                LogError("获取订单ID返回为nil！")
                                if payType and payType == PayType.ZiLongGitPay and tostring(commodity:GetID()) ==
                                    tostring(30033) then
                                    if commodity:GetName() then
                                        LanguageMgr:ShowTips(1046, commodity:GetName())
                                    end
                                else
                                    Tips.ShowTips(LanguageMgr:GetTips(1011));
                                end
                                EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                                do
                                    return
                                end
                            end
                            -- LogError("result.id:"..result.id)
                            SDKPayMgr:SetLastPayInfo(result.inc_id, PayType.ZiLong);
                            ---is_ok
                            ---id  游戏订单
                            ---key_id
                            ---rand_key
                            ---msg
                            local payData = {
                                skuCode = tostring(commodity:GetID()), ---商品id
                                gameOrderId = result.id, ---游戏订单号
                                -- amount=commodity["cfg"]["amount"],---定价价格（单位分）      ------
                                -- amount=commodity["cfg"]["amount"] or AdvpriceInfo[1].num*100;---定价价格（单位分）      ------
                                amount = Advcommodityprice, ---定价价格（单位分）      ------
                                currency = commodity["cfg"]["displayCurrency"], ---定价币种   -----
                                productName = commodity:GetName(), ---商品名称
                                productDesc = commodity["data"]["sDesc"], ---商品描述         -----
                                --- gameExt=commodity["cfg"]["goodsId"],---游戏传入自定义参数
                                gameExt = Json.encode(Backresult) ---游戏传入自定义参数
                            }
                            if payData.productDesc == nil then
                                payData.productDesc = "";
                            end

                            if CSAPI.RegionalCode()==6 then
                                ---海外如果是英俄地区--中台给什么 返回什么给他们验证
                                if commodity["cfg"]==nil or commodity["cfg"]["currency"]==nil then
                                    LogError("中台支付没有这个字段数据currency："..table.tostring(commodity))
                                else
                                    payData.currency =  commodity["cfg"]["currency"];
                                end
                            else
                                ---海外定价表货币符号，策划/中台提供，写死
                                payData.currency = RegionalSet.RegionalCurrencyType();
                            end

                            print("GenOrderID  Backresult-----payData---------------" .. table.tostring(payData))
                            if payType ~= nil and payType == 10 then
                                Log("--------------抵扣券抵扣--------------")
                                if CSAPI.RegionalCode() == 3 then
                                    ShiryuSDK.SetPayLimitLevel(CSAPI.JPGetTypelimit());
                                end
                                ---抵扣券接口
                                ShiryuSDK.PayPoints(payData, function(success, voucherNum)
                                    Log("---------------ShiryuSDK.PayPoints Back---------------")
                                    EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                                    if success then
                                        AdvDeductionvoucher.SDKvoucherNum = voucherNum;
                                        AdvDeductionvoucher.QueryPoints(function()
                                            CSAPI.DispatchEvent(EventType.Shop_View_Refresh)
                                        end);
                                        CSAPI.DispatchEvent(EventType.SDK_Deduction_voucher_paymentcompleted)
                                        SDKPayMgr:SearchPayReward(true);
                                        if callBack then
                                            callBack();
                                        end
                                    else
                                        Tips.ShowTips(LanguageMgr:GetTips(1011));
                                    end
                                end)
                            elseif payType ~= nil and payType == 11 then
                                ShiryuSDK.ClaimGift(payData, function(success, BackJson)
                                    Log("---------------ShiryuSDK.ClaimGift Back---------------:")
                                    EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                                    if success then
                                        Log("---------------ShiryuSDK.ClaimGift successful---------------:")
                                        SDKPayMgr:SearchPayReward(true);
                                        if callBack then
                                            callBack();
                                        end
                                    else
                                        Tips.ShowTips(LanguageMgr:GetTips(1011));
                                    end
                                end)
                            else
                                ---正常支付接口
                                if CSAPI.RegionalCode() == 3 then
                                    ShiryuSDK.SetPayLimitLevel(CSAPI.JPGetTypelimit());
                                end
                                CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Pay, payData)
                            end
                        end);
                    else
                        LogError("返回订单号异常：" .. table.tostring(proto))
                    end
                end);
            else -- 正常购买
                Log("-------------------canPay--------正常购买------------")
                if CSAPI.IsADVRegional(3) then
                    if priceInfo and priceInfo[1].id == ITEM_ID.DIAMOND then -- 弹窗确认
                        print("--------------------BuyCommodity----------------------------")
                        CSAPI.ADVJPTitle(priceInfo[1].num * currNum, function()
                            ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum, useCost, voucherList,
                                shopPriceKey, callBack, commodity:GetGrid1(), commodity:GetGrid2());
                        end)
                    else
                        ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum, useCost, voucherList,
                            shopPriceKey, callBack, commodity:GetGrid1(), commodity:GetGrid2());
                    end
                else
                    ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum, useCost, voucherList, shopPriceKey,
                        callBack, commodity:GetGrid1(), commodity:GetGrid2());
                end
            end
        else
            ---国内--------------------------
            -- 判断支付类型
            local priceInfo = commodity:GetRealPrice(shopPriceKey);
            if priceInfo and priceInfo[1].id == -1 then -- 使用SDK调用支付
                if payType == nil then
                    payType = this.GetChannelPayType();
                end
                -- LogError("PayType:"..tostring(payType))
                local priceInfo2 = commodity:GetPrice(shopPriceKey);
                if SDKPayMgr:GetIsPaying() and payType == PayType.IOS then -- 目前只针对IOS进行拦截
                    LogError("正在处理支付中...");
                    do
                        return
                    end
                end
                EventMgr.Dispatch(EventType.Shop_Buy_Mask, true);
                SDKPayMgr:GenOrderID(commodity, payType, isInstall, shopPriceKey, function(result)
                    -- local result={
                    --     isOk=true,
                    --     id="1",
                    -- };
                    if result and (result.err ~= nil or result.isOk ~= true) then
                        LogError("获取订单ID时出现错误！信息：" .. tostring(result.err))
                        Tips.ShowTips(LanguageMgr:GetTips(1011));
                        EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                        do
                            return
                        end
                    elseif result == nil or (result and (result.id == nil or result.id == "")) then
                        LogError("获取订单ID返回为nil！")
                        Tips.ShowTips(LanguageMgr:GetTips(1011));
                        EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                        do
                            return
                        end
                    end
                    local data = ShopCommFunc.GetChannelData(commodity, result, payType, shopPriceKey);
                    -- LogError("申请订单ID数据：")
                    -- LogError(result);
                    -- LogError("下单数据：")
                    -- LogError(data)
                    if data == nil then
                        LogError("下单数据错误，停止下单：")
                        LogError(data)
                        EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                        do
                            return
                        end
                    end
                    -- 发送数据，状态为未支付
                    local record = {
                        goods_id = tostring(commodity:GetID()), -- 商品ID
                        goods_name = commodity:GetName(), -- 商品名
                        channel_name = CSAPI.GetChannelName(), -- 渠道名
                        pay_result = "未支付", -- 支付状态
                        pay_tips = "已下单", -- 付费流程
                        goods_num = currNum, -- 数量
                        cost_type = "人民币", -- 币种
                        price = priceInfo2[1].num, -- 原价格
                        pay_price = priceInfo[1].num, -- 实付价格
                        pay_channel = PayTypeName[payType], -- 支付渠道
                        create_time = TimeUtil.GetTime(), -- 创建时间
                        order_id = GCardCalculator:GetPayOrderStrId(result.id, payType, channelType), -- 后台订单ID
                        sdk_order_id = data.out_trade_no or "", -- sdk交易订单ID
                        send_time = TimeUtil.GetTime()
                    }
                    -- LogError("上传数数内容：")
                    -- LogError(record)
                    BuryingPointMgr:TrackEvents("store_pay", record);
                    if payType == PayType.AlipayQR or payType == PayType.WeChatQR then
                        EventMgr.Dispatch(EventType.SDK_Pay_QRURL, data.code_url)
                    elseif payType == PayType.BsAli then
                        if data.is_install and data.is_install == "1" then -- H5
                            -- 打开浏览器页面
                            CSAPI.JumpUri(data.code_url);
                        else -- 二维码
                            EventMgr.Dispatch(EventType.SDK_Pay_QRURL, data.code_url)
                        end
                    else
                        SDKPayMgr:SetIsPaying(true);
                        EventMgr.Dispatch(EventType.SDK_Pay, data, true);
                    end
                end);
            else -- 正常购买
                if priceInfo and priceInfo[1].id == ITEM_ID.DIAMOND then -- 弹窗确认
                    local good = BagMgr:GetFakeData(priceInfo[1].id);
                    local rNum = priceInfo[1].num;
                    if commodity:GetType() ~= CommodityItemType.SUIT and voucherList ~= nil then
                        local isOk, tips, res = GLogicCheck:IsCanUseVoucher(commodity:GetCfg(), voucherList,
                            TimeUtil:GetTime(), currNum, PlayerClient:GetLv(), nil, shopPriceKey);
                        if isOk and res then
                            rNum = res[1][2];
                        end
                    end
                    local dialogData = {
                        content = LanguageMgr:GetTips(15123, good:GetName(), rNum * currNum),
                        okCallBack = function()
                            ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum, useCost, voucherList,
                                shopPriceKey, callBack, commodity:GetGrid1(), commodity:GetGrid2());
                        end
                    }
                    CSAPI.OpenView("Dialog", dialogData);
                else
                    ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum, useCost, voucherList, shopPriceKey,
                        callBack, commodity:GetGrid1(), commodity:GetGrid2());
                end
            end
        end
    else
        local goods = GoodsData();
        local price = commodity:GetRealPrice(shopPriceKey)[1];
        goods:InitCfg(price.id);
        --查找是否有跳转提示，没有则弹飘字
        local jumpId=goods:GetMoneyJumpID();
        if jumpId then
            local dialogData={
                content=LanguageMgr:GetTips(15129),
                okCallBack = function()
                    EventMgr.Dispatch(EventType.Shop_Buy_NoMoneyJump)
                    JumpMgr:Jump(jumpId);
                end
            }
            CSAPI.OpenView("Dialog", dialogData);
        else
            Tips.ShowTips(string.format(LanguageMgr:GetTips(15000), goods:GetName()));
        end
    end
end

function this.BuyCommodity_Domestic(commodity, currNum, callBack, useCost, payType, isInstall, voucherList, shopPriceKey)

    ---海外------------------------
    local priceInfo = commodity:GetRealPrice(shopPriceKey);
    Log("-------------------canPay------------priceInfo--------" .. table.tostring(priceInfo))
    if priceInfo and priceInfo[1].id == -1 then -- 使用SDK调用支付
        SDKPayMgr:SetLastPayInfo(nil, nil);
        if SDKPayMgr:GetIsPaying() then -- 目前只针对IOS进行拦截
            Log("正在处理支付中...");
            do
                return
            end
        end
        local priceInfo2 = commodity:GetPrice(shopPriceKey);
        ---2024-09-14 中台SDK 重合 要求去掉游戏加载圈
        if CSAPI.Currentplatform == CSAPI.Android or CSAPI.Currentplatform == CSAPI.IPhonePlayer then
            EventMgr.Dispatch(EventType.Shop_Buy_Mask, true);
        else
            print("-----PC-----IsGetIsMobileplatform")
        end

        print("commodity---------------------" .. table.tostring(commodity))

        local AdvpriceInfo = commodity:GetPrice(shopPriceKey);
        local Advcommodityprice = AdvpriceInfo[1].num * 100; ---单位元
        local SDKamount = commodity["cfg"]["amount"]; ---单位分
        ---如果没有这个字段，那么传表数据给服务端
        if SDKamount == nil then
            SDKamount = Advcommodityprice;
        elseif tostring(SDKamount) == tostring(0) and tostring(SDKamount) ~= tostring(Advcommodityprice) then
            SDKamount = Advcommodityprice;
            LogError("存在定价表数据异常：" .. table.tostring(commodity, true))
        elseif tostring(SDKamount) ~= tostring(Advcommodityprice) then
            SDKamount = Advcommodityprice;
            LogError("配置表和SDK存在定价表数据异常：" .. table.tostring(commodity, true))
        end
        Log("商品价格分：" .. Advcommodityprice)
        ClientProto:QueryPrePay(commodity:GetID(), SDKamount, function(proto)
            if tostring(proto["productId"]) == tostring(commodity:GetID()) then
                SDKPayMgr:GenOrderID(commodity, payType, isInstall, shopPriceKey, function(Backresult)
                    Log("GenOrderID data back：" .. table.tostring(Backresult));
                    local result = {};
                    print("GenOrderID  Backresult---------------------" .. table.tostring(commodity))
                    result.is_ok = Backresult["is_ok"];
                    result.msg = Backresult["msg"];
                    result.id = Backresult["id"];
                    -- 订单ID
                    result.inc_id = Backresult["inc_id"];
                    result.key_id = Backresult["key_id"];
                    result.rand_key = Backresult["rand_key"];
                    -- LogError(result)
                    if result and (result.msg ~= nil and result.is_ok == false) then
                        LogError("获取订单ID时出现错误！信息：" .. tostring(result.msg))
                        Tips.ShowTips(LanguageMgr:GetTips(1011));
                        EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                        do
                            return
                        end
                    elseif result == nil or (result and (result.id == nil or result.id == "")) then
                        LogError("获取订单ID返回为nil！")
                        Tips.ShowTips(LanguageMgr:GetTips(1011));
                        EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                        do
                            return
                        end
                    end
                    -- LogError("result.id:"..result.id)
                    SDKPayMgr:SetLastPayInfo(result.inc_id, PayType.CenterWeb);

                    local AdvpriceInfo = commodity:GetPrice(shopPriceKey);
                    local payData = {
                        skuCode = tostring(commodity:GetID()), ---商品id
                        gameOrderId = result.id, ---游戏订单号
                        -- amount=commodity["cfg"]["amount"],---定价价格（单位分）      ------
                        amount = Advcommodityprice, ---定价价格（单位分）      ------
                        currency = commodity["cfg"]["displayCurrency"], ---定价币种   -----
                        productName = commodity:GetName(), ---商品名称
                        productDesc = commodity["data"]["sDesc"], ---商品描述         -----
                        --- gameExt=commodity["cfg"]["goodsId"],---游戏传入自定义参数
                        gameExt = Json.encode(Backresult) ---游戏传入自定义参数
                    }
                    if payData.productDesc == nil then
                        payData.productDesc = "";
                    end
                    -- 中台要求此处写死
                    payData.currency = "CNY";
                    print("GenOrderID  Backresult-----payData---------------" .. table.tostring(payData))
                    ---正常支付接口
                    CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Pay, payData)
                end);
            else
                LogError("返回订单号异常：" .. table.tostring(proto))
            end
        end);
    else -- 正常购买
        Log("-------------------canPay--------正常购买------------")
        ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum, useCost, voucherList, shopPriceKey, callBack,
            commodity:GetGrid1(), commodity:GetGrid2());
    end
end

-- 返回非官方渠道的支付类型
function this.GetChannelPayType()
    if channelType == ChannelType.QOO then
        return PayType.Qoo;
    elseif channelType == ChannelType.BliBli then
        return PayType.BiliBili;
    end
end

-- 返回支付的数据
function this.GetChannelData(commodity, result, payType, shopPriceKey)
    local t = nil;
    if payType == PayType.BiliBili then
        local userInfo = PlayerClient:GetSDKUserInfo();
        local total_fee = commodity:GetRealPrice(shopPriceKey)[1].num * 100;
        local item = commodity:GetCommodityList()[1];
        local game_money = "1";
        local out_trade_no = result.out_trade_no;
        local subject = tostring(commodity:GetName());
        -- local body = commodity:GetDesc();
        local body = "";
        local serverInfo = ChannelWebUtil.GetServerInfo();
        local extension_info = string.format("server_id=%s", serverInfo.id);
        t = {
            uid = userInfo.uid,
            username = userInfo.name,
            role = PlayerClient:GetName(),
            serverId = result.serverId,
            total_fee = tonumber(total_fee),
            game_money = game_money,
            out_trade_no = out_trade_no,
            subject = subject,
            body = body,
            extension_info = extension_info,
            notify_url = result.notify_url,
            order_sign = result.order_sign,
            productId = commodity:GetID(),
            orderId = result.id
        };
    elseif payType == PayType.Qoo then
        t = {
            productId = commodity:GetID(),
            cpOrderId = result.id,
            developerPayload = Json.encode({
                uid = PlayerClient:GetID(),
                account = PlayerClient:GetAccount(),
                server_id = tostring(ChannelWebUtil.GetServerID()),
                channel = tostring(channelType)
            })
        };
    elseif payType == PayType.Alipay then
        t = {
            sdkType = payType,
            cpOrderId = result.id,
            orderInfo = result.orderStr
        };
    elseif payType == PayType.WeChat then
        t = {
            sdkType = payType,
            cpOrderId = result.id,
            packageValue = "Sign=WXPay",
            perpayId = result.prepay_id,
            nonceStr = result.nonceStr,
            timeStamp = result.timeStamp,
            out_trade_no = result.out_trade_no,
            sign = result.sign
        };
    elseif payType == PayType.IOS then
        t = {
            productId = tostring(commodity:GetID()),
            cpOrderId = tostring(result.id),
            storeProductId = tostring(commodity:GetChargeID()),
            out_trade_no = tostring(result.out_trade_no),
            uid = PlayerClient:GetID(),
            account = PlayerClient:GetAccount(),
            server_id = tostring(ChannelWebUtil.GetServerID()),
            channel = tostring(channelType),
            pay_type = tostring(PayType.IOS),
            create_time = TimeUtil.GetTime() -- 创建时间
        };
    elseif payType == PayType.AlipayQR or payType == PayType.WeChatQR then
        t = {
            code_url = result.code_url,
            payType = tostring(payType)
        }
    elseif payType == PayType.BsAli then -- 聚合正扫
        t = {
            code_url = result.code_url,
            payType = tostring(payType),
            is_install = result.is_install
        }
    end
    return t;
end

-- 兑换道具
function this.ExchangeCommodity(commodity, currNum, callBack)
    if commodity == nil then
        return
    end
    local canPay = this.CheckCanPay(commodity, currNum);
    if canPay then
        if CSAPI.IsADVRegional(3) then
            -- 兑换商店的ID
            local priceInfo = commodity:GetRealPrice();
            if priceInfo and priceInfo[1].id == ITEM_ID.DIAMOND then -- 弹窗确认
                print("--------------------ExchangeCommodity----------------------------")
                CSAPI.ADVJPTitle(priceInfo[1].num * currNum, function()
                    ShopProto:Exchange(commodity:GetPoolID(), commodity:GetExchangeIndex(), commodity:GetID(), currNum,
                        callBack);
                end)
            else
                ShopProto:Exchange(commodity:GetPoolID(), commodity:GetExchangeIndex(), commodity:GetID(), currNum,
                    callBack);
            end
        else
            -- 兑换商店的ID
            local priceInfo = commodity:GetRealPrice();
            if priceInfo and priceInfo[1].id == ITEM_ID.DIAMOND then -- 弹窗确认
                local good = BagMgr:GetFakeData(priceInfo[1].id);
                local dialogData = {
                    content = LanguageMgr:GetTips(15123, good:GetName(), priceInfo[1].num * currNum),
                    okCallBack = function()
                        ShopProto:Exchange(commodity:GetPoolID(), commodity:GetExchangeIndex(), commodity:GetID(),
                            currNum, callBack);
                    end
                }
                CSAPI.OpenView("Dialog", dialogData);
            else
                ShopProto:Exchange(commodity:GetPoolID(), commodity:GetExchangeIndex(), commodity:GetID(), currNum,
                    callBack);
            end
        end
    else
        local goods = GoodsData();
        local price = commodity:GetRealPrice()[1];
        goods:InitCfg(price.id);
        local jumpId=goods:GetMoneyJumpID();
        if jumpId then
            local dialogData={
                content=LanguageMgr:GetTips(15129),
                okCallBack = function()
                    EventMgr.Dispatch(EventType.Shop_Buy_NoMoneyJump)
                    JumpMgr:Jump(jumpId);
                end
            }
            CSAPI.OpenView("Dialog", dialogData);
        else
            Tips.ShowTips(string.format(LanguageMgr:GetTips(15000), goods:GetName()));
        end
    end
end

-- 显示奖励面板
function this.ShowRewardPanel(commodity, currentNum)
    local rewards = {};
    currentNum = currentNum or 1;
    -- 奖励列表中剔除物品类型为10的道具信息
    local goods = commodity:GetCommodityList();
    for k, v in ipairs(goods) do
        local rewardInfo = {};
        rewardInfo.id = v.cid;
        rewardInfo.num = currentNum * v.num;
        local type = v.type == nil and 2 or v.type; -- 不填或者为空默认为道具类型
        rewardInfo.type = type;
        if v.type == 2 then
            local cfg = Cfgs.ItemInfo:GetByID(v.cid);
            if cfg and cfg.type == ITEM_TYPE.PROP then
            else
                table.insert(rewards, rewardInfo);
            end
        else
            table.insert(rewards, rewardInfo);
        end
    end
    if rewards and #rewards > 0 then
        UIUtil:OpenReward({rewards})
    end
end

-- 是否需要记录第一次打开时的刷新信息
function this.IsRecordRefreshInfo(shopId)
    this.firstRecord = this.firstRecord or {};
    if this.firstRecord[shopId] ~= nil then
        return false
    else
        this.firstRecord[shopId] = shopId
    end
    return true
end

-- 检查固定商品页面是否需要刷新 isUpdate:是否重置列表，isRefresh：某个商品是否需要刷新
function this.IsRefreshCommodityInfos(datas, nowTime)
    local isUpdate = false
    local isRefresh = false;
    this.starBuyList = this.starBuyList or {};
    this.endBuyList = this.endBuyList or {};
    local resetKey=nil;
    local refreshKey=nil;
    if datas and nowTime then
        for k, v in ipairs(datas) do
            -- local beginTime=this.beginTime or 0;
            -- local endTime=this.endTime or 0;
            local beginTime = v:GetBuyStartTime();
            local endTime = v:GetBuyEndTime();
            -- if (nowTime >= v:GetResetTime() and v:GetResetTime() ~= 0) or
            --     (endTime > 0 and beginTime > 0 and nowTime >= beginTime and nowTime <= endTime) or
            --     (endTime == 0 and beginTime > 0 and nowTime >= beginTime) or (endTime > 0 and nowTime >= endTime) then 
            -- 检查商品重置
            if (v:GetResetType() ~= 0 and nowTime >= v:GetResetTime() and v:GetResetTime() ~= 0) then -- 检查商品重置
                -- Log( "道具重置啦！")
                -- LogError(v:GetResetTime().."\t"..v:GetID().."\t"..v:GetName().."\t"..v:GetResetType().."\t"..nowTime);
                isUpdate = true
                resetKey=tostring(v:GetID()).."_"..tostring(v:GetResetTime())
                break
            elseif (endTime == 0 or nowTime < endTime) and (beginTime > 0 and nowTime >= beginTime and
                (this.starBuyList[v:GetID()] == nil or
                    (this.starBuyList[v:GetID()] and beginTime ~= this.starBuyList[v:GetID()]))) then -- 检查是否可以购买
                -- LogError(endTime.."\t"..v:GetID().."\t"..v:GetName().."\t"..v:GetResetType().."\t"..nowTime);
                this.starBuyList[v:GetID()] = beginTime;
                isRefresh = true;
                refreshKey=tostring(v:GetID()).."_begin_"..tostring(beginTime)
            elseif (endTime > 0 and nowTime >= endTime and
                (this.endBuyList[v:GetID()] == nil or
                    (this.endBuyList[v:GetID()] and endTime ~= this.endBuyList[v:GetID()]))) then
                this.endBuyList[v:GetID()] = endTime;
                isRefresh = true;
                refreshKey=tostring(v:GetID()).."_end_"..tostring(endTime)
            end
            -- if v:GetID()==50003 or v:GetID()==50005 then
            --     LogError(v:GetName().."\t"..tostring(isRefresh).."\t开始时间："..beginTime.."\t当前时间："..nowTime.."\t是否大于购买时间："..tostring(nowTime>=beginTime).."\t停止购买时间："..tostring(endTime).."\t是否小于停止购买时间："..tostring(nowTime<endTime).."\t是否大于停止购买时间："..tostring(nowTime>=endTime));
            -- end
        end
    end
    return isUpdate, isRefresh,resetKey,refreshKey;
end

-- 打开商品购买窗口，commodityID必须为固定商品ID isForce：强制开启
function this.OpenPayView2(commodityID, callBack, isForce)
    local commodity = ShopMgr:GetFixedCommodity(commodityID);
    if commodity then
        local pageData = ShopMgr:GetPageByID(commodity:GetShopID());
        if pageData == nil then
            LogError("未找到对应商品页信息!");
            do
                return
            end
        end
        this.OpenPayView(commodity, callBack, isForce);
    end
end

-- 打开购买窗口
function this.OpenPayView(commodityData, callBack, isForce,shopPriceKey)
    local isSubMonthCard=false;
    if (commodityData:GetType()==CommodityItemType.MonthCard and commodityData:GetSubType()==CommodityItemSubType.MonthCard2) then
        isSubMonthCard=true;
    end
    if ((commodityData:GetNum() <1 and commodityData:GetNum() ~= -1) or commodityData:IsOver())  and isForce ~= true and not isSubMonthCard  then
        do return end; --已售罄
    end
    --if CSAPI.IsADV() and CSAPI.RegionalCode()==3 then --日服年龄限制提示
    --    local priceInfo=commodityData:GetRealPrice();
    --    if CSAPI.PayAgeTitle() and priceInfo and priceInfo[1].id==-1 then
    --        CSAPI.OpenView("SDKPayJPlimitLevel",{  ExitMain=function() this.OpenPayView(commodityData);  end})
    --        do return end;
    --    end
    --end
    if commodityData:GetType() == CommodityItemType.Deposit then -- 充值
        if commodityData:GetType() == CommodityItemType.MonthCard then -- 月卡
            CSAPI.OpenView("ShopPayView", {
                commodity = commodityData,
                callBack = callBack
            });
        else -- 其它，直接调用支付
            local commodityType = ShopMgr:GetCommodityTypeByData(commodityData);
            this.HandlePayLogic(commodityData, 1, nil, callBack);
        end
    elseif commodityData:GetType() == CommodityItemType.Skin then
        CSAPI.OpenView("ShopSkinBuy", {
            commodity = commodityData,
            callBack = callBack
        },shopPriceKey);
    else
        CSAPI.OpenView("ShopPayView", {
            commodity = commodityData,
            callBack = callBack
        },shopPriceKey);
    end
end

-- 处理购买/兑换逻辑
function this.HandlePayLogic(commodity, num, voucherList, func, shopPriceKey,payType,Isdisplay)
    if commodity and commodity:GetType() == CommodityItemType.MonthCard and commodity:GetMonthCardCanBuy(true)==false then -- 月卡,判断剩余时间是否可以续费
        do return end
    end
    local commodityType=ShopMgr:GetCommodityTypeByData(commodity);
    local priceInfo = commodity:GetRealPrice(shopPriceKey);

    local PayMain=function()
        -- 调用支付渠道选择
        if priceInfo and priceInfo[1].id == -1 and CSAPI.IsDomestic() then
            if commodityType == 1 then -- 购买道具
                ShopCommFunc.BuyCommodity(commodity, num, func, nil, nil, nil, nil, shopPriceKey);
            elseif commodityType == 2 then -- 兑换随机物品
                ShopCommFunc.ExchangeCommodity(commodity, num, func, nil);
            end
        elseif priceInfo and priceInfo[1].id == -1 and
                (channelType == ChannelType.Normal or channelType == ChannelType.TapTap) then
            if CSAPI.GetPlatform() == 8 then -- IOS
                if commodityType == 1 then -- 购买道具
                    ShopCommFunc.BuyCommodity(commodity, num, func, nil, PayType.IOS, nil, nil, shopPriceKey);
                elseif commodityType == 2 then -- 兑换随机物品
                    ShopCommFunc.ExchangeCommodity(commodity, num, func, nil, PayType.IOS);
                end
            else
                CSAPI.OpenView("SDKPaySelect", { commodity = commodity, num = num, shopPriceKey = shopPriceKey, func = func });
            end
        elseif priceInfo and priceInfo[1].id == -1 and CSAPI.IsADV() and AdvDeductionvoucher.SDKvoucherNum >= priceInfo[1].num and not Isdisplay then
            CSAPI.OpenView("SDKPaySelect", { commodity = commodity, num = num, shopPriceKey = shopPriceKey, func = func });
        else
            if commodityType == 1 then -- 购买道具
                ShopCommFunc.BuyCommodity(commodity, num, func,nil, payType, nil, voucherList, shopPriceKey);
            elseif commodityType == 2 then -- 兑换随机物品
                ShopCommFunc.ExchangeCommodity(commodity, num, func);
            end
        end
    end


    ---需要花钱的
    if priceInfo and priceInfo[1].id == -1  and CSAPI.IsADVRegional(3) and CSAPI.PayAgeTitle() then
        CSAPI.OpenView("SDKPayJPlimitLevel",{  ExitMain=function()
            PayMain();
        end})
    else
        PayMain();
    end


end
-- 是否在时间范围内
function this.TimeIsBetween(startTime, endTime, currentTime)
    if currentTime == nil then
        currentTime = TimeUtil:GetTime();
    end
    local sTime = startTime == nil and 0 or TimeUtil:GetTimeStampBySplit(startTime);
    local eTime = endTime == nil and 0 or TimeUtil:GetTimeStampBySplit(endTime);
    if (sTime == 0 or currentTime >= sTime) and (eTime == 0 or currentTime < eTime) then
        return true;
    end
    return false;
end

-- 是否在时间范围内
function this.TimeIsBetween2(startTime, endTime, currentTime)
    if currentTime == nil then
        currentTime = TimeUtil:GetTime();
    end
    if (startTime == 0 or currentTime >= startTime) and (endTime == 0 or currentTime < endTime) then
        return true;
    end
    return false;
end

-- 返回商品中包含的皮肤信息
function this.GetSkinInfo(commodity, key)
    local skinInfo = nil;
    if commodity then
        local list = key == nil and commodity:GetCommodityList() or commodity:GetCommodityList2(key);
        local skinId = nil;
        if list == nil then
            return skinInfo;
        end
        for k, v in ipairs(list) do
            if v.type == RandRewardType.ITEM and v.data and v.data:GetItemType() == ITEM_TYPE.SKIN then
                skinId = v.data:GetDyVal2();
                break
            end
        end
        if skinId ~= nil then
            skinInfo = ShopSkinInfo.New();
            skinInfo:InitCfg(skinId);
        end
    end
    return skinInfo;
end

-- 根据皮肤表ID获取商店配置表中对应的商品信息
function this.GetSkinCommodity(modelID)
    if modelID then
        local modelCfg = Cfgs.character:GetByID(modelID);
        if modelCfg ~= nil and modelCfg.shopId then
            -- 判断是否在商品上架期限
            return ShopMgr:GetFixedCommodity(modelCfg.shopId);
        end
    end
    return nil;
end

function this.SortRandComm(a, b)
    local index1 = a:GetSort();
    local index2 = b:GetSort();
    local over1 = a:IsOver() and 1 or 0;
    local over2 = b:IsOver() and 1 or 0;
    if over1 ~= over2 then
        return over1 < over2;
    elseif index1 == index2 then
        return a:GetID() < b:GetID();
    else
        return index1 < index2;
    end

end

-- 皮肤商品排序
function this.SortSkinComm(a, b)
    local skinInfo = this.GetSkinInfo(a)
    local skinInfo2 = this.GetSkinInfo(b)
    local getType1 = skinInfo:GetWayInfo();
    local getType2 = skinInfo2:GetWayInfo();
    local rSkinInfo1 = RoleSkinMgr:GetRoleSkinInfo(skinInfo:GetModelCfg().role_id, skinInfo:GetModelCfg().id);
    local rSkinInfo2 = RoleSkinMgr:GetRoleSkinInfo(skinInfo2:GetModelCfg().role_id, skinInfo2:GetModelCfg().id);
    local r1 = 0;
    local r2 = 0;
    if rSkinInfo1 ~= nil and rSkinInfo1:CheckCanUse() and rSkinInfo1:IsLimitSkin() ~= true then
        r1 = 1;
    end
    if rSkinInfo2 ~= nil and rSkinInfo2:CheckCanUse() and rSkinInfo2:IsLimitSkin() ~= true then
        r2 = 1;
    end
    -- Log(skinInfo:GetSkinName().."\t"..r1.."\t"..r2.."\t"..getType1.."\t"..getType2.."\t"..a:GetSort().."\t"..b:GetSort())
    if r1 == r2 then
        if getType1 == getType2 then
            return a:GetSort() < b:GetSort();
        else
            return getType1 < getType2
        end
    else
        return r1 < r2
    end
end

function this.SortComm(a, b)
    local over1 = a:IsOver() and 1 or 0;
    local over2 = b:IsOver() and 1 or 0;
    if a:GetType() == CommodityItemType.MonthCard and a:GetSubType() == CommodityItemSubType.MonthCard2 and over1 == 1 then
        -- local gets=a:GetMonthCardInfo();
        -- if gets and gets.l_cnt>0 then
        over1 = 0;
        -- end
    end
    if b:GetType() == CommodityItemType.MonthCard and b:GetSubType() == CommodityItemSubType.MonthCard2 and over2 == 1 then
        -- local gets=b:GetMonthCardInfo();
        -- if gets and gets.l_cnt>0 then
        over2 = 0;
        -- end
    end
    if over1 ~= over2 then
        return over1 < over2;
    elseif a:GetSort() == b:GetSort() then
        return a:GetID() < b:GetID();
    else
        return a:GetSort() < b:GetSort();
    end
end

-- 返回后台商店商品列表
function this.InitPaySDK()
    -- 正式
    local comms = {};
    local cfgs = Cfgs.CfgRecharge:GetGroup(1); -- IOS
    if cfgs then
        for k, v in ipairs(cfgs) do
            comms[v.iosID] = v.appleShopType;
        end
    end
    local eventData = {
        comms = comms,
        bjTime = TimeUtil:GetBJTime()
    }
    -- LogError(eventData)
    -- 临时
    -- local eventData={comms={PayRecharge_40001=0,PayMonthly_30001=0}}--苹果商店数据，0=消耗型，1=不可销毁的，2=订阅的。
    EventMgr.Dispatch(EventType.SDK_Pay_Init, eventData, true)
end

-- 打开指定商品的购买界面
function this.OpenBuyConfrim(shopId, topId, commID)
    if shopId == nil or commID == nil then
        return;
    end
    local pageData = ShopMgr:GetPageByID(shopId);
    if pageData and pageData:IsOpen() then
        local list = pageData:GetCommodityInfos(true, topId);
        local commData = nil;
        if list then
            local idx = -1;
            for k, v in ipairs(list) do
                if v:GetID() == commID then
                    commData = v;
                    idx = k;
                    break
                end
            end
            if commData == nil then
                return;
            end
            if commData:GetType() == CommodityItemType.Skin and idx ~= -1 then -- 皮肤界面
                local list2 = {};
                for k, v in ipairs(list) do
                    table.insert(list2, ShopCommFunc.GetSkinInfo(v));
                end
                ShopCommFunc.OpenPayView(commData);
            elseif commData:GetType() ~= CommodityItemType.Skin then
                ShopCommFunc.OpenPayView(commData);
            end
        end
    end
end

-- 通过商品信息获取当前可用的折扣券列表
function this.MatchVouchers(commodity, num, shopPriceKey)
    if commodity and commodity:GetUseVoucherTypes() ~= nil then
        local list = BagMgr:GetDataByType(ITEM_TYPE.VOUCHER);
        if list then
            local vs = nil;
            for k, v in ipairs(list) do
                local info = VoucherInfo.New();
                info:SetCfg(v:GetDyVal1());
                if info:CheckCanUse(commodity, num, shopPriceKey) and v:GetCount()>0 then
                    vs = vs or {};
                    table.insert(vs, {
                        good = v,
                        info = info
                    });
                end
            end
            return vs;
        end
    end
    return nil;
end

-- 返回主题是否售罄
function this.GetThemeInfo(themeId)
    local counts = DormMgr:GetCfgFurnitureCount(themeId)
    local totalNum = 0;
    local buyNum = 0;
    for k, v in pairs(counts) do
        local buyCount = DormMgr:GetBuyCount(k)
        local num = v > buyCount and (v - buyCount) or 0
        local _cfg = Cfgs.CfgFurniture:GetByID(k)
        if _cfg and not _cfg.special then
            totalNum = totalNum + v;
            buyNum = buyNum + buyCount;
        end
    end
    local isSoldout = false;
    if totalNum ~= 0 and totalNum <= buyNum then
        isSoldout = true;
    end
    return isSoldout
end

-- 判断商店ID是否为红点或者商品是否为红点
function this.IsRed(redInfo, shopId, commId)
    local isShowRed = false;
    if redInfo and shopId then
        local list = redInfo[shopId];
        if list ~= nil then
            if commId ~= nil then
                isShowRed = list[commId] ~= nil;
            else
                isShowRed = true
            end
        end
    end
    return isShowRed;
end

-- 判断商店ID是否为New或者商品是否为New
function this.IsNew(infos, shopId, tabID, commID)
    local isShowRed = false;
    if infos and shopId then
        local list = infos[shopId];
        if list ~= nil then
            if tabID ~= nil and infos[shopId][tabID]~=nil then
                if commID ~= nil then
                    for k, v in ipairs(infos[shopId][tabID]) do
                        if v == commID then
                            isShowRed = true;
                            break
                        end
                    end
                else
                    isShowRed = list[tabID] ~= nil;
                end
            else
                isShowRed = true
            end
        end
    end
    return isShowRed;
end

-- 加载价格物体 comm:商品数据，parent:父节点 lua：缓存lua对象，path:指定名称
function this.InitPriceItem(comm, parent, lua, path,elseData)
    path = path ~= nil and path or "ShopComm/ShopPriceItem3"
    if comm == nil or IsNil(parent) then
        LogError("加载价格物体是参数不得为空！comm:" .. tostring(comm == nil) .. "\tparent:" ..
                     tostring(IsNil(parent)));
        do
            return
        end
    end
    if lua and lua.isLoading~=nil then
        do return end;
    end
    if lua ~= nil and lua.tab~=nil then
        lua.tab.Refresh(comm,nil,elseData);
    elseif lua==nil then
        lua={tab=nil,isLoading="1"}
        ResUtil:CreateUIGOAsync(path, parent, function(go)
            local t = ComUtil.GetLuaTable(go);
            CSAPI.SetAnchor(go, 0, 0)
            t.Refresh(comm,nil,elseData);
            lua.tab = t;
            lua.isLoading=nil;
        end)
    end
    return lua;
end

-- 播放Animator delay：延迟播放,默认为0  overDelay:播放完成执行回调的时间
function this.PlayAnimation(animator, tweenName, delay, overDelay, func)
    if animator and animator.enabled~=true then
        animator.enabled=true;
    end
    if delay ~= nil and delay > 0 then
        FuncUtil:Call(function()
            if IsNil(animator) ~= true and tweenName ~= nil then
                animator:Play(tweenName, -1, 0);
                if overDelay ~= nil and func ~= nil then
                    FuncUtil:Call(func, nil, overDelay);
                end
            end
        end, nil, delay);
    else
        if IsNil(animator) ~= true and tweenName ~= nil then
            animator:Play(tweenName, -1, 0);
            if overDelay ~= nil and func ~= nil then
                FuncUtil:Call(func, nil, overDelay);
            end
        end
    end
end

-- 添加二级菜单
function this.AddHeadPage(data, topTabID, isJump, topItem, parent, path, func)
    if topItem == nil then
        path = path or "Shop/ShopHeadPage"
        ResUtil:CreateUIGOAsync(path, parent, function(go)
            topItem = ComUtil.GetLuaTable(go);
            if func ~= nil then
                func(topItem)
            elseif topItem.Refresh then
                topItem.Refresh(data, topTabID, isJump);
            end
            CSAPI.SetAnchor(go, 0, 0);
        end)
    else
        if func ~= nil then
            func(topItem)
        elseif topItem.Refresh then
            topItem.Refresh(data, topTabID, isJump);
        end
    end
    return topItem;
end

-- 添加下方工具栏
function this.AddBottomPage(data, topTabID, bottomItem, parent, path, func)
    if bottomItem == nil then
        path = path or "Shop/ShopBottomPage"
        ResUtil:CreateUIGOAsync(path, parent, function(go)
            bottomItem = ComUtil.GetLuaTable(go);
            if func ~= nil then
                func(bottomItem)
            end
            CSAPI.SetAnchor(go, 0, 0);
        end)
    else
        if func ~= nil then
            func(bottomItem)
        end
    end
    return bottomItem;
end

return this;
