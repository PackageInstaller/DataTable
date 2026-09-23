local eventMgr=nil;
local data=nil;
local priceItem=nil;--价格物体
local animator=nil;
function Awake()
    animator = ComUtil.GetCom(node, "Animator");
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Shop_MonthCard_DaysChange,OnMonthCardDaysChange)
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
    eventMgr:AddListener(EventType.Shop_NewInfo_Refresh,SetNewInfo)
end

function OnDestroy()
    eventMgr:ClearListener();
    animator=nil;
    priceItem=nil;
end

function Refresh(comm)
    data=comm;
    if comm==nil then
        do return end;
    end
    -- CSAPI.SetText();
    -- rmbIcon=data:GetCurrencySymbols();
    CSAPI.SetText(text_name,comm:GetName());
    ResUtil.Commodity:Load(bg,"img_01_07")
    local gets=data:GetMonthCardInfo();
    if gets then
        SetDays(gets.l_cnt);
    else
        SetDays(0)
    end
    SetPrice()
end

function PlayEntry(delay)
    ShopCommFunc.PlayAnimation(animator,"item_entry",delay);
end

function OnMonthCardDaysChange(days)
	local info=data:GetMonthCardInfo();
	if info then
		SetDays(info.l_cnt);--刷新剩余时间
	end
end

function SetDays(days)
    days =days or 0;
    CSAPI.SetGOActive(dayObj,days>0);
    if days>0 then
        CSAPI.SetText(text_day,LanguageMgr:GetByID(18174,days));
    end
end

--检测红点数据
function SetRedInfo()
    local rd=RedPointMgr:GetData(RedPointType.Shop);
    local isShowRed=false;
    if rd and data then
        isShowRed=ShopCommFunc.IsNew(rd,data:GetShopID(),data:GetID());
    end
    UIUtil:SetRedPoint(alphaNode,isShowRed,100,-280);
 end

 function SetNewInfo(infos)
    local hasThis=false;
    if data then
        local pageID=data:GetShopID();
        local tabID=data:GetTabID();
        local hasThis=ShopCommFunc.IsNew(infos,pageID,tabID,data:GetID());
    end
    CSAPI.SetGOActive(newObj,hasThis);
end

function OnClickSelf()
    ShopCommFunc.OpenPayView(data);
end

function SetPrice()
    if priceItem and priceItem.isLoading~=nil then
        do return end
    end
    if priceItem~=nil and priceItem.tab~=nil then
        priceItem.tab.Refresh(data);
    else
        priceItem={isLoading="1"}
        ResUtil:CreateUIGOAsync("ShopComm/ShopPriceItem3",priceNode,function(go)
            priceItem.tab=ComUtil.GetLuaTable(go);
            CSAPI.SetAnchor(go,0,0)
            priceItem.tab.Refresh(data);
            priceItem.isLoading=nil;
        end)
    end
end