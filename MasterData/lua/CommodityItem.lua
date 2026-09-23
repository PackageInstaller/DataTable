local eventMgr = nil;
local needToCheckMove = false
local animator = nil;
local priceItem = nil;
local iconItem = nil;
local tags={};
local luaTextMove=nil;
local effectItem=nil;
local orgItem=nil;
local state=1
local endTime=0;
local fixedTime=60;
local upTime=0;
local loading=false;
function Awake()
    animator = ComUtil.GetCom(node, "Animator")
    eventMgr = ViewEvent.New();
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(text_name)
    -- eventMgr:AddListener(EventType.Shop_NewInfo_Refresh,SetNewInfo)
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs()
end

function Refresh(_d, _elseData)
    this.data = _d;
    this.elseData = _elseData;
    if this.data == nil then
        return;
    end
    -- 加载图标
    LoadIcon();
    -- 舒适度
    local dromStr = nil
    local getList = this.data:GetCommodityList();
    local good = getList and getList[1] or nil;
    local num = 0;
    local isShowPlay=false;
    if good then
        num = good.num;
        local dyVal1 = good.data:GetDyVal1();
        if this.data:GetType() == CommodityItemType.THEME then
            local cfg = Cfgs.CfgFurnitureTheme:GetByID(dyVal1);
            dromStr = cfg.comfort;
        elseif this.data:GetType() == CommodityItemType.FORNITURE then
            local cfg = Cfgs.CfgFurniture:GetByID(dyVal1);
            dromStr = cfg.comfort;
            if cfg.inteActionId~=nil then
                isShowPlay=true;    
            end
        end
        SetDayObj(good.data:GetIconDayTips());
    else
        SetDayObj();
    end
    CSAPI.SetGOActive(playTag,isShowPlay)
    SetName(num>1 and _d:GetName()..("x"..num) or _d:GetName());
    SetDorm(dromStr);
    -- 设置状态
    state = this.data:IsOver() and 2 or 1;
    local isLock = not this.data:GetBuyLimit();
    state = isLock and 3 or state;
    -- 加载标签
    endTime=this.data:GetEndBuyTime();
    SetTags();
    SetState(state, this.data:GetBuyLimitDesc())
    SetRedInfo();
    -- SetNewInfo(ShopMgr:GetPageNewInfos());
    SetOrgCosts()
    LoadQuailty(this.data:GetQuality());
    --设置数量
    SetCount(this.data:GetLimitDesc());
    --设置价格
    priceItem = ShopCommFunc.InitPriceItem(_d, priceNode, priceItem, "ShopComm/ShopPriceItem");
end

function SetOrgCosts()
    if this.data==nil  then
        do return end
    end
    if orgItem and orgItem.isLoading~=nil then
        do return end
    end
    if orgItem and orgItem.tab then
        orgItem.tab.Refresh(this.data);
    else
        orgItem={isLoading="1"}
        ResUtil:CreateUIGOAsync("ShopComm/ShopDiscountItem", iconNode, function(go)
            orgItem.tab = ComUtil.GetLuaTable(go);
            orgItem.tab.Refresh(this.data);
            orgItem.isLoading=nil;
        end);
    end
end

function LoadQuailty(quality)
    if effectItem~=nil then
        CSAPI.RemoveGO(effectItem);
    end
    if quality==nil or (quality and quality<=1) then
        do return end
    end
    effectItem=ResUtil:CreateUIGO("Shop/"..ShopCommFunc.itemQualitys[quality],qNode.transform);
end

--设置有效天数
function SetDayObj(txt)
	CSAPI.SetGOActive(dayObj,txt~=nil)
	CSAPI.SetText(txt_day,txt);
end


function SetCount(num)
    if num~=nil and num~="" then
        CSAPI.SetGOActive(countObj,true);
        CSAPI.SetText(text_limitVal,num);
    else
        CSAPI.SetGOActive(countObj,false);
    end
end

function LoadIcon()
    if iconItem and iconItem.isLoading~=nil then
        do return end
    end
    if iconItem and iconItem.tab then
        iconItem.tab.Refresh(this.data, this.elseData.commodityType);
    else
        iconItem={tab=nil,isLoading="1"}
        ResUtil:CreateUIGOAsync("ShopComm/CommodityIcon", iconNode, function(go)
            if not IsNil(go) and iconItem~=nil then
                iconItem.tab= ComUtil.GetLuaTable(go);
                iconItem.tab.Refresh(this.data, this.elseData.commodityType);
                iconItem.isLoading=nil;
            end
        end);
    end
end

-- 舒适度
function SetDorm(txt)
    CSAPI.SetGOActive(dormTag, txt ~= nil)
    CSAPI.SetText(txtDorm, tostring(txt));
end

-- type:nil/1:普通 2:售罄 3：未解锁
function SetState(type, desc)
    if type == nil or type == 1 then
        CSAPI.SetGOActive(stateObj, false)
        do
            return
        end
    end
    CSAPI.SetGOActive(stateObj, true)
    CSAPI.SetGOActive(tipsObj, type == 3)
    CSAPI.LoadImg(stateImg,string.format("UIs/Shop/%s.png",type==2 and "img_20_08" or "img_20_09"),true,nil,true)
    if type == 2 then
        CSAPI.SetText(txt_state, LanguageMgr:GetByID(18186));
    elseif type == 3 then
        CSAPI.SetText(txt_tipsDesc, desc);
        CSAPI.SetText(txt_state, LanguageMgr:GetByID(18185));
    end
end

function PlayEntry(delayTime)
    if delayTime > 0 then
        ShopCommFunc.PlayAnimation(animator, "Empty");
    end
    ShopCommFunc.PlayAnimation(animator, "VCommodityItem_entry", delayTime);
    SetTags(true);
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
    ItemUtil.AddItems("ShopComm/CommodityTag", tags, list, tagNode, nil, 1, isEntry,function()
        loading=false;
    end);
end

-- 检测红点数据
function SetRedInfo()
    local redInfo=RedPointMgr:GetData(RedPointType.Shop);
    local isRed = ShopCommFunc.IsRed(redInfo, this.data:GetShopID(), this.data:GetID());
    if isRed~=true then
        local redInfo2=RedPointMgr:GetData(RedPointType.RegressionShop);
        isRed = ShopCommFunc.IsRed(redInfo2, this.data:GetShopID(), this.data:GetID());
    end
    CSAPI.SetGOActive(redObj, isRed);
end

-- function SetNewInfo(infos)
--     local isRed=ShopCommFunc.IsNew(infos,this.data:GetShopID(),this.data:GetTabID(),this.data:GetID());
--     CSAPI.SetGOActive(newObj,isRed);
-- end

function Update()
    if (needToCheckMove) then
        luaTextMove:CheckMove(text_name)
        needToCheckMove = false
    end
    if endTime and endTime>0 then
        upTime=upTime+Time.deltaTime;
        if upTime>=fixedTime then
            endTime=endTime-fixedTime;
            SetTags();
            upTime=0;
        end
    end
end

function SetName(str)
    needToCheckMove = false
    CSAPI.SetText(text_name, str);
    needToCheckMove = true
end

function SetClickCB(cb)
    this.cb=cb;
end

function OnClickSelf()
    if this.cb then
        this.cb(this);
    end
end

function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    bg = nil;
    priceItem = nil;
    animator = nil;
    func = nil;
    iconItem=nil;
    tags={};
    luaTextMove=nil;   
    effectItem=nil;
    orgItem=nil;
    endTime=0;
    loading=false;
end
