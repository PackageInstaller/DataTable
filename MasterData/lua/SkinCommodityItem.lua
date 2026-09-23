local eventMgr=nil;
local animator=nil;
local isTween=false
local isSelect=false;
local orgItem=nil;
local tags={};
local priceItem=nil;
local func=nil;
local loading=false;
function Awake()
    animator=ComUtil.GetCom(node,"Animator");
    eventMgr = ViewEvent.New();
end

function OnDestroy()
    eventMgr:ClearListener();
    ReleaseCSComRefs()
end

function Refresh(_comm,_isSelect)
    if _comm==nil then
        do return end
    end
    this.data=_comm;
    local skinInfo = ShopCommFunc.GetSkinInfo(this.data);
    if skinInfo then
        local changeInfo = skinInfo:GetChangeInfo();
        local hasMore = changeInfo ~= nil and true or false;
        local showBg1 = true;
        if hasMore ~= true then
            ResUtil.CardIcon:Load(icon, skinInfo:GetCardHead(), true);
        else
            if changeInfo[1].cfg.skinType ~= 5 then -- 形切或者同调
                if this.data:GetIcon2() ~= nil then
                    -- 加载SpriteRenderer
                    ResUtil.CardIcon:Load(icon1, skinInfo:GetCardHead(),true);
                    ResUtil.CardIcon:Load(icon2, changeInfo[1].cfg.Card_head,true);
                    ResUtil.CardIcon:Load(icon3, changeInfo[1].cfg.Card_head,true);
                    showBg1 = false
                end
            else
                ResUtil.CardIcon:Load(icon, skinInfo:GetCardHead(), true);
                -- 加载机神icon
                showBg1 = true
            end
        end
        CSAPI.SetGOActive(icon, showBg1);
        CSAPI.SetGOActive(iconObj2, not showBg1);
    end
    -- 加载标签 改完表再启用
    SetTags();
    SetOrgCosts();
    priceItem = ShopCommFunc.InitPriceItem(_comm, priceNode, priceItem, "ShopComm/ShopPriceItem2");
    SetSelect(_isSelect)
end

function SetSelect(_isSelect, _isTween)
    local isShow=_isSelect;
    if this.data and this.data:IsOver() then
        isShow=true
    end
    CSAPI.SetGOActive(priceObj, isShow) -- 不选中不显示价格
    CSAPI.SetGOActive(dicountNode, _isSelect)
    if _isTween then
        animator.enabled=true;
        ShopCommFunc.PlayAnimation(animator, _isSelect and "SkinItem_sel" or "SkinItem_Nsel", 0);
    else
        animator.enabled=false;
        CSAPI.SetAnchor(node, 0, _isSelect and 40 or 0);
    end
    CSAPI.SetGOActive(effectNode6,_isSelect);
    isSelect = _isSelect;
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
    ItemUtil.AddItems("ShopComm/CommodityMiniTag", tags, list, tagNode, nil, 1, isEntry,function()
        loading=false;        
    end);
end

function SetOrgCosts()
    if this.data == nil then
        do
            return
        end
    end
    if orgItem and orgItem.isLoading~=nil then
        do return end
    end
    if orgItem and orgItem.tab then
        orgItem.tab.Refresh(this.data);
    else
        orgItem={isLoading="1"}
        ResUtil:CreateUIGOAsync("ShopComm/ShopDiscountItem", dicountNode, function(go)
            orgItem.tab = ComUtil.GetLuaTable(go);
            CSAPI.SetAnchor(go, 0, 10);
            orgItem.tab.Refresh(this.data);
            orgItem.isLoading=nil;
        end);
    end
end


function PlayEntry(delayTime)
    animator.enabled=true;
    if delayTime > 0 then
        ShopCommFunc.PlayAnimation(animator, "Empty");
    end
    ShopCommFunc.PlayAnimation(animator, "SkinItem_entry", delayTime,500,function()
        if IsNil(gameObject)~=true then
            SetSelect(isSelect,isSelect);
        end
    end);
    SetTags(true);
end

function SetIndex(_i)
    this.index=_i;
end

function SetClickCB(_func)
    func=_func
end

function OnClickSelf()
    if func~=nil then
        func(this)
    end
end

function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    priceItem = nil;
    animator = nil;
    tags={};
    orgItem=nil;
    isTween=false
    isSelect=false;
    func=nil;
    loading=false;
end