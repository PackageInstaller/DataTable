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
    local getList = _comm:GetCommodityList();
    local currPic=nil;
    if getList then
        for k, v in ipairs(getList) do
            local type = v.data:GetType();
            if type == ITEM_TYPE.PANEL_IMG then -- 多人插图,特殊处理
                currPic = MulPicMgr:GetData(v.data:GetDyVal1());
                break
            end
        end
    end
    --加载图标
    if currPic then
        ResUtil.MultBoard:Load(icon, currPic:GetIcon())
    end
    SetTags();
    SetOrgCosts();
    priceItem = ShopCommFunc.InitPriceItem(_comm, priceNode, priceItem, "ShopComm/ShopPriceItem2");
    SetSelect(_isSelect)
    if not _isSelect and _comm:IsOver() then
        CSAPI.SetGOActive(priceNode, true)
    end
end

function SetSelect(_isSelect, _isTween)
    if not this.data:IsOver() then
        CSAPI.SetGOActive(priceNode, _isSelect)
    end
    CSAPI.SetGOActive(dicountNode, _isSelect)
    if _isTween then
        animator.enabled=true;
        ShopCommFunc.PlayAnimation(animator, _isSelect and "AtlasItem_sel" or "AtlasItem_Nsel", 0);
    else
        animator.enabled=false;
        CSAPI.SetAnchor(node, 0, _isSelect and 40 or 0);
    end
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
    if this.data==nil then
        do return end
    end
    if orgItem and orgItem.isLoading~=nil then
        do return end
    end
    if orgItem and orgItem.tab then
        orgItem.tab.Refresh(this.data);
    else
        orgItem={isLoading="1"}
        ResUtil:CreateUIGOAsync("ShopComm/ShopDiscountItem", dicountNode, function(go)
            if not IsNil(go) and orgItem~=nil then
                orgItem.tab = ComUtil.GetLuaTable(go);
                CSAPI.SetAnchor(go, 0, 10);
                orgItem.tab.Refresh(this.data);
                orgItem.isLoading=nil
            end
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