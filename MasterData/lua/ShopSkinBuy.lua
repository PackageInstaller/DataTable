local eventMgr = nil;
local voucherItem = nil;
local voucherList = nil;
local roleItem = nil;
local currNum = 1;
local comm = nil;
local voucherPrice = nil;
local currSkinInfo = nil;
local curModelCfg=nil;
local shopPriceKey=nil
local isOpening=false;
local tab=nil;
local costIdx=1;
function Awake()
    tab = ComUtil.GetCom(tabs, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Shop_PayVoucher_Change, OnVoucherChange);
    eventMgr:AddListener(EventType.Shop_Buy_NoMoneyJump,Close)
    eventMgr:AddListener(EventType.SDK_Pay_Result,OnSDKResult);
	eventMgr:AddListener(EventType.SDK_QRPay_Over,OnQROver)
end

function OnTabChanged(_index)
	costIdx=_index==0 and 1 or 2;
    shopPriceKey=_index==0 and ShopPriceKey.jCosts or ShopPriceKey.jCosts1
    voucherPrice=nil;
    voucherList=nil;
    InitContent()
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnOpen()
    comm = data.commodity;
    if comm then
        currSkinInfo = ShopCommFunc.GetSkinInfo(comm);
        curModelCfg=currSkinInfo:GetModelCfg();
    end
    shopPriceKey=openSetting==ShopPriceKey.jCosts1 and ShopPriceKey.jCosts1 or ShopPriceKey.jCosts
    InitContent();
    tab.selIndex = shopPriceKey == ShopPriceKey.jCosts and 0 or 1;
    voucherPrice=nil;
    PlayEnter();
end

function InitTab()
    local hasOther= comm and comm:HasOtherPrice(ShopPriceKey.jCosts1) or false;
    CSAPI.SetGOActive(tabs,hasOther)
    if comm and hasOther then
        local cost1=comm:GetPrice(ShopPriceKey.jCosts);
        local cost2=comm:GetPrice(ShopPriceKey.jCosts1);
        if cost1[1].id~=-1 then
            local _cfg1 = Cfgs.ItemInfo:GetByID(cost1[1].id)
            ShopCommFunc.SetPriceIcon(tIcon1,cost1[1]);
            ShopCommFunc.SetPriceIcon(tsIcon1,cost1[1]);
            LanguageMgr:SetText(txtNormal1, 18111, _cfg1.name)
            LanguageMgr:SetText(txtSel1, 18111, _cfg1.name)
        else
            CSAPI.SetText(txtNormal1,LanguageMgr:GetByID(18124));
            CSAPI.LoadImg(tIcon1,"UIs/ShopComm/img_29_01.png",true,nil,true);
            CSAPI.LoadImg(tsIcon1,"UIs/ShopComm/img_29_01.png",true,nil,true);
            LanguageMgr:SetText(txtSel1, 18124)
        end
        if cost2[1].id~=-1 then
            local _cfg1 = Cfgs.ItemInfo:GetByID(cost2[1].id)
            ShopCommFunc.SetPriceIcon(tIcon2,cost2[1]);
            ShopCommFunc.SetPriceIcon(tsIcon2,cost2[1]);
            LanguageMgr:SetText(txtNormal2, 18111, _cfg1.name)
            LanguageMgr:SetText(txtSel2, 18111, _cfg1.name)
        else
            CSAPI.SetText(txtNormal2,LanguageMgr:GetByID(18124));
            CSAPI.LoadImg(tIcon2,"UIs/ShopComm/img_29_01.png",true,nil,true);
            CSAPI.LoadImg(tsIcon2,"UIs/ShopComm/img_29_01.png",true,nil,true);
            LanguageMgr:SetText(txtSel2, 18124)
        end
    end
end

function PlayEnter()
    if isOpening then
        do return end
    end
    isOpening=true;
    CSAPI.SetAnchor(node,0,-500)
    CSAPI.ApplyAction(node, "View_Open_Fade");
    UIUtil:DoLocalMove(node, {0,0,0},function()
        isOpening=false;
    end)
end

function PlayOut(func)
    if isOpening then
        do return end
    end
    isOpening=true;
    CSAPI.ApplyAction(node, "View_Close_Fade2");
    UIUtil:DoLocalMove(node, {0,-500,0},func)
end

function InitContent()
    InitTab()
    if roleItem then
        roleItem.Refresh(comm);
    else
        ResUtil:CreateUIGOAsync("ShopSkinPage/SkinCommodityItem2", roleNode, function(go)
            roleItem = ComUtil.GetLuaTable(go);
            roleItem.Refresh(comm);
            -- CSAPI.SetAnchor(go, 20, -20);
        end);
    end
    local changeInfo = currSkinInfo:GetChangeInfo();
    if changeInfo then
        local type = changeInfo[1].cfg.skinType;
        local langID = 18099;
        if type == 3 then
            langID = 18100;
        elseif type == 4 then
            langID = 18103;
        elseif type == 5 then
            langID = 18099;
        end
        local cardName = changeInfo[1].cfg.key;
        CSAPI.SetText(txt_tips3, LanguageMgr:GetByID(langID, cardName, changeInfo[1].cfg.desc));
    end
    CSAPI.SetGOActive(txt_tips3, changeInfo ~= nil);
    local hasL2d = currSkinInfo:HasL2D();
    if hasL2d ~= true then
        CSAPI.SetText(txt_tips5, LanguageMgr:GetByID(18132));
    end
    CSAPI.SetGOActive(L2dTips, hasL2d ~= true)
    -- CSAPI.SetAnchor(layout,-5,hasL2d and 103 or 16);
    RefreshPrice()
    RefreshVoucherItem()
end

function RefreshPrice()
    if comm == nil then
        do
            return
        end
    end
    local tips2 = LanguageMgr:GetByID(18086, curModelCfg.key);
    tips2 = string.format("%s<color=\'#ffc146\'>%s</color>", tips2, curModelCfg.desc)
    CSAPI.SetText(txt_tips2, tips2);
    local priceInfo = comm:GetRealPrice(shopPriceKey);
    local money = 0;
    local moneyName = "";
    local currMoney = nil;
    local cfg = Cfgs.ItemInfo:GetByID(ITEM_ID.DIAMOND);
    moneyName = cfg.name;
    local tp1, tp2, tg1, tg2 = txt_price, txt_disPrice, txt_goodsName, txt_disGoodsName;
    local isNilList = voucherList == nil
    if isNilList ~= true then
        tp1 = txt_disPrice;
        tp2 = txt_price;
        tg1 = txt_disGoodsName;
        tg2 = txt_goodsName;
        currMoney = voucherPrice;
    end
    CSAPI.SetGOActive(txt_disGoodsName, isNilList ~= true);
    CSAPI.SetGOActive(txt_disPrice, isNilList ~= true);
    if priceInfo then
        currMoney = currMoney or priceInfo[1].num;
        local moneyStr=tostring(math.floor(priceInfo[1].num + 0.5));
        local voucherPriceStr=tostring(voucherPrice or 0);
        if priceInfo[1].id == ITEM_ID.GOLD then -- 金币
            money = PlayerClient:GetGold();
            local cfg = Cfgs.ItemInfo:GetByID(ITEM_ID.GOLD);
            moneyName = cfg.name;
        elseif priceInfo[1].id == ITEM_ID.DIAMOND then -- 钻石
            money = PlayerClient:GetDiamond();
        elseif priceInfo[1].id == -1 then 
            moneyName="";
            if CSAPI.IsSwapleftandright() then
                moneyStr=tostring(math.floor(priceInfo[1].num + 0.5))..comm:GetCurrencySymbols();
                voucherPriceStr=tostring(math.floor(voucherPrice and (voucherPrice + 0.5) or 0))..comm:GetCurrencySymbols();
            else
                moneyStr=comm:GetCurrencySymbols()..tostring(math.floor(priceInfo[1].num + 0.5));
                voucherPriceStr=comm:GetCurrencySymbols()..tostring(math.floor(voucherPrice and (voucherPrice + 0.5) or 0));
            end
        end
        if money >= currMoney then
            CSAPI.SetTextColorByCode(txt_price, "ffc146");
            CSAPI.SetTextColorByCode(txt_goodsName, "ffc146");
        else
            CSAPI.SetTextColorByCode(txt_price, "ffc146");
            CSAPI.SetTextColorByCode(txt_goodsName, "ffc146");
        end
        CSAPI.SetText(tp1, moneyStr);
        CSAPI.SetText(tg1, moneyName);
        if not isNilList then
            CSAPI.SetText(tp2, voucherPriceStr);
            CSAPI.SetText(tg2, moneyName);
        end
    else
        CSAPI.SetTextColorByCode(txt_price, "ffc146");
        CSAPI.SetTextColorByCode(txt_goodsName, "ffc146");
        CSAPI.SetText(tp1, tostring(0));
        CSAPI.SetText(tg1, moneyName);
        CSAPI.SetText(tp2, tostring(0));
        CSAPI.SetText(tg2, moneyName);
    end
    if comm and comm:GetBundlingType() == ShopCommBindType.Bindling and comm:GetBundlingID() ~= nil then
        CSAPI.SetGOActive(txt_tips4, true);
        local bindComm = ShopMgr:GetFixedCommodity(comm:GetBundlingID());
        local str = LanguageMgr:GetByID(18125, bindComm:GetName());
        CSAPI.SetText(txt_tips4, str);
    else
        CSAPI.SetGOActive(txt_tips4, false);
    end
end

function OnVoucherChange(ls)
    voucherList=ls;
    RefreshVoucherPrice();
    RefreshPrice();
end

function RefreshVoucherItem()
    local isShow = false;
    if comm and comm:GetUseVoucherTypes() ~= nil then
        if voucherItem == nil then
            ResUtil:CreateUIGOAsync("ShopComm/VoucherDropItem2", vObj, function(go)
                voucherItem = ComUtil.GetLuaTable(go);
                voucherItem.Init(comm, currNum, true,shopPriceKey);
                if voucherItem.GetOptionsLength() > 0 then
                    isShow = true;
                end
            end);
        else
            voucherItem.Init(comm, currNum, true,shopPriceKey);
            if voucherItem.GetOptionsLength() > 0 then
                isShow = true;
            end
        end
    end
    CSAPI.SetGOActive(vObj, isShow);
end

function RefreshVoucherPrice()
    if voucherList and comm then
        local isOk, tips, res = GLogicCheck:IsCanUseVoucher(comm:GetCfg(), voucherList, TimeUtil:GetTime(), currNum, PlayerClient:GetLv(),nil,shopPriceKey);
        if isOk and res then
            voucherPrice = res[1][2];
        end
    else
        voucherPrice=nil;
    end
    RefreshPrice();
end

function OnClickBuy()
    if comm then
        ShopCommFunc.HandlePayLogic(comm,currNum,voucherList,OnSuccess,shopPriceKey);
    end
end


--SDK支付结果
function OnSDKResult(_d)
	if _d~=nil and _d.Code==200 then
		Close();
	end
end

function OnQROver()
	--判定是否能再次购买 带spType时不再做判定
	Close();
end

function OnSuccess(proto)
    Close();
    if currSkinInfo and proto and next(proto.gets) then
        CSAPI.OpenView("SkinShowView",currSkinInfo)
    end
end

function OnClickCancel()
    Close()
end

function OnClickAnyway()
    Close()
end

function OnClickClose()
    Close()
end

function Close()
    if isOpening then
        do return end
    end
    if data and data.callBack then
        data.callBack();
    end
    PlayOut(function()
        isOpening=false;
        if gameObject~=nil and view~=nil then
            view:Close();
        end
    end)
end