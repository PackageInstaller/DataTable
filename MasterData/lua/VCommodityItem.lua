--商品物体
local eventMgr=nil;
local priceItem=nil;
local func=nil;
local animator=nil; --默认不启用
local tags={};
local orgItem=nil
local isTween=false;
local state=1;
local endTime=0;
local fixedTime=60;
local upTime=0;
local loading=false;
function Awake()
    animator=ComUtil.GetCom(node,"Animator")
    eventMgr = ViewEvent.New();
    -- eventMgr:AddListener(EventType.Shop_MonthCard_DaysChange,OnMonthCardDaysChange)
    -- eventMgr:AddListener(EventType.Shop_NewInfo_Refresh,SetNewInfo)
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs()
end

function Refresh(_d,elseData)
    this.data=_d;
    if this.data==nil then
        do return end
    end
    priceItem=ShopCommFunc.InitPriceItem(_d,priceNode,priceItem,"ShopComm/ShopPriceItem4");
    ResUtil.VCommodity:Load(icon,_d:GetPackageIcon(),true);
    SetName(_d:GetName());
    SetBG(_d:GetBG());
    SetRevIcon(_d:GetBG());
    local count=_d:GetLimitDesc();
    state=this.data:IsOver() and 2 or 1;
    if this.data:GetType()==CommodityItemType.MonthCard then--月卡，显示剩余天数
        local gets=this.data:GetMonthCardInfo();
        if gets then
            SetDays(gets.l_cnt);
        else
            SetDays(0)
        end
        if this.data:GetSubType()==CommodityItemSubType.MonthCard2 then --限时月卡，在有效期内不显示售罄
            if gets and gets.l_cnt>0 then --有效期内不显示剩余数量
                type=1;
                count=nil;
            end
        end
    else
         SetDays(0)
    end
    local isLock=not this.data:GetBuyLimit();
    state=isLock and 3 or state;
    SetOrgCosts();
    SetCount(count);
    SetState(state,this.data:GetBuyLimitDesc())
    SetRedInfo();
    -- SetNewInfo(ShopMgr:GetPageNewInfos());
    endTime=this.data:GetEndBuyTime();
    SetTags();
end

function SetRevIcon(bgName)
    if bgName~="" and bgName~=nil then
        CSAPI.SetGOActive(iconMask,true)
        local size = CSAPI.GetRTSize(icon)
        CSAPI.SetAnchor(iconMask,0,size[1]/2*-1);
        ResUtil.VCommodity:Load(revIcon, this.data:GetPackageIcon(),true);
    else
        CSAPI.SetGOActive(iconMask,false)
    end
end

function SetBG(bgName)
    local bgPath="img_19_01"; 
    if bgName~="" and bgName~=nil then
        bgPath=bgName;
    end
    if bgPath=="img_19_01" then
        CSAPI.LoadImg(bg,string.format("UIs/Shop/%s.png",bgPath),true,nil,true)
    else
        ResUtil.VCommodity:Load(bg,bgPath,true);
    end
end

function SetOrgCosts()
    if this.data==nil then
        do return end
    end
    if orgItem and orgItem.isLoading then
        do return end
    end
    if orgItem and orgItem.tab then
        orgItem.tab.Refresh(this.data);
    else
        orgItem={isLoading="1"}
        ResUtil:CreateUIGOAsync("ShopComm/ShopDiscountItem2", discountNode, function(go)
            orgItem.tab = ComUtil.GetLuaTable(go);
            CSAPI.SetAnchor(go, 0, 0);
            orgItem.tab.Refresh(this.data);
            orgItem.isLoading=nil;
        end);
    end
end

function SetTags(isEntry)
    if loading==true then
        do return end
    end
    local list={};
    if this.data and this.data:IsShowTag() then
        list=this.data and this.data:GetTagsData() or list; 
    end
    loading=#list>0 
    ItemUtil.AddItems("ShopComm/CommodityTag",tags,list,tagNode,nil,1,isEntry,function()
        loading=false;
    end);
end

function SetRedInfo()
    local redInfo=RedPointMgr:GetData(RedPointType.Shop);
    local isRed=ShopCommFunc.IsRed(redInfo,this.data:GetShopID(),this.data:GetID());
    if isRed~=true then
        local redInfo2=RedPointMgr:GetData(RedPointType.RegressionShop);
        isRed = ShopCommFunc.IsRed(redInfo2, this.data:GetShopID(), this.data:GetID());
    end
    CSAPI.SetGOActive(redObj,isRed);
end

function Update()
    if endTime and endTime>0 then
        upTime=upTime+Time.deltaTime;
        if upTime>=fixedTime then
            endTime=endTime-fixedTime;
            SetTags();
            upTime=0;
        end
    end
end

-- function SetNewInfo(infos)
--     local isRed=ShopCommFunc.IsNew(infos,this.data:GetShopID(),this.data:GetTabID(),this.data:GetID());
--     CSAPI.SetGOActive(newObj,isRed);
-- end

function SetDays(days)
    days =days or 0;
    CSAPI.SetGOActive(dayObj,days>0);
    if days>0 then
        CSAPI.SetText(text_day,LanguageMgr:GetByID(18174,days));
    end
end

function SetCount(str)
    if str~=nil and str ~="" then
        CSAPI.SetGOActive(countObj,true);
        CSAPI.SetText(text_num,str);
    else
        CSAPI.SetGOActive(countObj,false);
    end
end

--type:nil/1:普通 2:售罄 3：未解锁
function SetState(type,desc)
    if type==nil or type==1 then
        CSAPI.SetGOActive(stateObj,false)
        do return end
    end
    CSAPI.SetGOActive(stateObj,true)
    CSAPI.SetGOActive(tipsObj,type==3)
    CSAPI.LoadImg(stateImg,string.format("UIs/Shop/%s.png",type==2 and "img_20_08" or "img_20_09"),true,nil,true)
    if type==2 then
        CSAPI.SetText(txt_state,LanguageMgr:GetByID(18186));
    elseif type==3 then
        CSAPI.SetText(txt_tipsDesc,desc);
        CSAPI.SetText(txt_state,LanguageMgr:GetByID(18185));
    end
end

function PlayEntry(delayTime)
    if delayTime>0 then
        ShopCommFunc.PlayAnimation(animator,"Empty");
    end
    ShopCommFunc.PlayAnimation(animator,"VCommodityItem_entry",delayTime);
    SetTags(true);
end

function SetName(str)
    CSAPI.SetText(text_name,str);
end

function SetClickCB(_cb)
    func=_cb;
end

function OnClickSelf()
    if func~=nil then
        func(this)
    end
end

function ReleaseCSComRefs()
    gameObject=nil;
    transform=nil;
    this=nil;  
    bg=nil;
    priceItem=nil;
    orgItem=nil;
    animator=nil;
    func=nil;
    tags=nil;
    endTime=0;
    loading=false;
end