--自接SDK支付入口
 local currType=PayType.Alipay;
 local confType=PaySelectConf.Default;--配置类型
-- local confType=PaySelectConf.BsAli;--配置类型
local commodity=nil;
local num=1;
local func=nil;
local t_payOverTime=10;
local countTime=0;
local itemDatas=nil;
local currIndex=2;
local currItemData=nil
local items={};
local shopPriceKey=ShopPriceKey.jCosts;

function Awake()
    if CSAPI.IsADV() then
         currType=PayType.ZiLongDeductionvoucher;--紫龙抵扣券
         confType=PaySelectConf.AdvPay;--海外类型local commodity=nil;
    end
    CSAPI.SetText(txt_moneyType,LanguageMgr:GetByID(18013));
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.SDK_Pay_Result,OnSDKPayResult)
    eventMgr:AddListener(EventType.SDK_Pay_QRURL,OnQRResult)
    eventMgr:AddListener(EventType.SDK_QRPay_Over,OnQROver)
    eventMgr:AddListener(EventType.Shop_OpenTime_Ret,OnShopRefresh)
    eventMgr:AddListener(EventType.SDK_Deduction_voucher_paymentcompleted,OnShopRefresh)
    CSAPI.SetSwapleftandright(txt_moneyType,1)

end

function OnShopRefresh()
	Close()
end

function OnDestroy()
    eventMgr:ClearListener();
end

--传入商品数据
function OnOpen()
    commodity=data.commodity;
    num=data.num or 1;
    func=data.func or nil;
    shopPriceKey=data.shopPriceKey or ShopPriceKey.jCosts;
    SetItemData();
    Refresh();
    if CSAPI.IsADV() then
        if AdvDeductionvoucher.SDKvoucherNum>0 then
            Log("商品信息："..table.tostring(data.commodity))
        end
    else
        if not CSAPI.IsPCPlatform() then
            local pName=CSAPI.GetPlatform()==8 and "alipay://" or "com.eg.android.AlipayGphone";
            CSAPI.IsInstallApp("com.eg.android.AlipayGphone");
        end
    end

end
function Refresh()
    SetLayout(false)
    RefreshItems();
    if commodity then
        if CSAPI.IsADV() then
            CSAPI.SetText(txt_name,commodity:GetName());
            local displayCurrency=commodity["data"]["displayCurrency"];
            ---抵扣卷货币不能显示货币符号前缀执行清除
            if displayCurrency==nil then displayCurrency="" end
            CSAPI.SetText(txt_moneyType,displayCurrency);
            local realPrice=commodity["data"]["displayPrice"];
            if realPrice==nil then
                local realPrice1=commodity:GetRealPrice(shopPriceKey);
                realPrice=realPrice1[1].num*num;
            end
            CSAPI.SetText(txt_price,tostring(realPrice));

        else
            CSAPI.SetText(txt_name,commodity:GetName());
            local realPrice=commodity:GetRealPrice(shopPriceKey);
            CSAPI.SetText(txt_moneyType,LanguageMgr:GetByID(18013));
            CSAPI.SetText(txt_price,tostring(realPrice[1].num*num));
        end
    end
end

--生成支付类型
function SetItemData()
    if confType==PaySelectConf.Default then
        itemDatas={
            {icon="img_41_02",tipsID=18303,type=PayType.WeChat,qrType=PayType.WeChatQR,pName="com.tencent.mm",iPName="weixin://",},
            {icon="img_41_01",tipsID=18302,type=PayType.Alipay,qrType=PayType.AlipayQR,pName="com.eg.android.AlipayGphone",iPName="alipay://",isDefault=true},
        };
        currType=PayType.Alipay;
        currIndex=2;
        currItemData=itemDatas[currIndex];
    elseif confType==PaySelectConf.BsAli then
        itemDatas={
            {icon="img_41_02",tipsID=18303,type=PayType.WeChat,qrType=PayType.WeChatQR,pName="com.tencent.mm",iPName="weixin://",},
            {icon="img_41_01",tipsID=18302,type=PayType.BsAli,qrType=PayType.BsAli,pName="com.eg.android.AlipayGphone",iPName="alipay://",isDefault=true},
        };
        currType=PayType.BsAli;
        currIndex=2;
        currItemData=itemDatas[currIndex];
    elseif confType==PaySelectConf.AdvPay then
        itemDatas={
            {icon="img_41_03",tipsID=18314,type=PayType.ZiLongDeductionvoucher,qrType=PayType.ZiLongDeductionvoucher,pName="",iPName="",},
            {icon="img_41_03",tipsID=18315,type=PayType.ZiLong,qrType=PayType.ZiLong,pName="",iPName=""},
        };
        currType=PayType.ZiLong;
        currIndex=2;
        currItemData=itemDatas[currIndex];
    end
end

function RefreshItems()
    --初始化子物体
    ItemUtil.AddItems("SDK/SDKPayItem", items, itemDatas, layout, OnSelectType, 1, {currType=currType});
    if CSAPI.IsADV() then
        if currType==PayType.ZiLong then
            if commodity then
                CSAPI.SetText(txt_name,commodity:GetName());
                local displayCurrency=commodity["data"]["displayCurrency"];
                ---抵扣卷货币不能显示货币符号前缀执行清除
                if displayCurrency==nil then displayCurrency="" end
                CSAPI.SetText(txt_moneyType,displayCurrency);
                local realPrice=commodity["data"]["displayPrice"];
                if realPrice==nil then
                    local realPrice1=commodity:GetRealPrice(shopPriceKey);
                    realPrice=realPrice1[1].num*num;
                end
                CSAPI.SetText(txt_price,tostring(realPrice));
            end
        elseif currType==PayType.ZiLongDeductionvoucher then
            if commodity then
                CSAPI.SetText(txt_name,commodity:GetName());
                local realPrice=commodity["cfg"]["amount"];
                if realPrice then
                    CSAPI.SetText(txt_moneyType,"");
                    CSAPI.SetText(txt_price,tostring(math.floor(realPrice/100)));
                else
                    local realPrice1=commodity:GetRealPrice(shopPriceKey);
                    realPrice=realPrice1[1].num*num;
                    CSAPI.SetText(txt_moneyType,"");
                    CSAPI.SetText(txt_price,tostring(math.floor(realPrice)));
                end
            end
        end
    end
end

function SetLayout(isQRCode)
    CSAPI.SetGOActive(layout,not isQRCode);
    CSAPI.SetGOActive(layout2,isQRCode);
    CSAPI.SetGOActive(btn_ok,not isQRCode);
end

--点击子物体
function OnSelectType(lua)
    if lua then
        currIndex=lua.GetIndex();
        currType=lua.data.type;
        currItemData=lua.data;
        RefreshItems();
    end
end

function OnSDKPayResult(info)
    if info.Code==200 then
        Close();
    end
end

function OnQROver(info)
    Close();
end

function OnClickClose()
    local dialogdata = {
        content = LanguageMgr:GetTips(15113),
        cancelCallBack = function()
            EventMgr.Dispatch(EventType.Shop_Buy_Mask,false)
            Close();
        end
    };
    CSAPI.OpenView("Dialog", dialogdata);
end

function Close()
    view:Close();
end

--eventData:二维码Url
function OnQRResult(eventData)
    if eventData==nil then
        do return end
    end
    SetLayout(true)
    --显示二维码
    -- LogError(eventData)
    CSAPI.SetRTSize(QRCode,256,256);
    CSAPI.CreateQRImg(QRCode,eventData,UnityEngine.Color(0,0,0,255));
    CSAPI.LoadImg(QRIcon,string.format("UIs/SDK/%s.png",currItemData.icon),true,nil,true);
    EventMgr.Dispatch(EventType.Shop_Buy_Mask,false);
end

function OnClickOK()
    local tempType=currType;
    local isInstall=false;
    if  CSAPI.IsADV() and currType==PayType.ZiLongDeductionvoucher then
        ---海外才有紫龙支付
        ShopCommFunc.BuyCommodity(commodity, num, func,nil,tempType,isInstall,nil,shopPriceKey)
    else
        if currItemData then
            if not CSAPI.IsPCPlatform() then
                local pName=CSAPI.GetPlatform()==8 and currItemData.iPName or currItemData.pName;
                isInstall=CSAPI.IsInstallApp(pName);
            end
            if not isInstall then --安装微信/支付宝客户端
                tempType=currItemData.qrType;
            end
        end
        ShopCommFunc.BuyCommodity(commodity, num, func,nil,tempType,isInstall,nil,shopPriceKey)
    end
end