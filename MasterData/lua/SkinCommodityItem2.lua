-- local animator=nil;
local orgItem=nil;
local tags={};
local priceItem=nil;
local func=nil;
local loading=false;
function Awake()
    -- animator=ComUtil.GetCom(node,"Animator");
end

function OnDestroy()
    ReleaseCSComRefs()
end

function Refresh(_comm)
    if _comm==nil then
        do return end
    end
    this.data=_comm;
    local skinInfo = ShopCommFunc.GetSkinInfo(this.data);
    if skinInfo then
        local changeInfo = skinInfo:GetChangeInfo();
        local hasMore = changeInfo ~= nil and true or false;
        local showBg1 = true;
        local cfg=skinInfo:GetSetCfg();
        SetSIcon(cfg.icon);
         SetName(skinInfo:GetRoleName());
        SetSName(skinInfo:GetSkinName());
        if hasMore ~= true then
            ResUtil.CardIcon:Load(icon, skinInfo:GetCardHead(), true);
        else
            if changeInfo[1].cfg.skinType ~= 5 then -- 形切或者同调
                if this.data:GetIcon2() ~= nil then
                    -- LogError(this.data:GetName())
                    -- 加载SpriteRenderer
                    -- ResUtil.CardIcon:Load(Role_A, skinInfo:GetCardHead());
                    -- ResUtil.CardIcon:Load(Role_B, this.data:GetIcon2());
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
    -- SetTags();
    local elseData=_comm:HasOtherPrice(ShopPriceKey.jCosts1) and {m1Color="ffc146"} or nil
    priceItem = ShopCommFunc.InitPriceItem(_comm, priceNode, priceItem, "ShopComm/ShopPriceItem", elseData);
end

function SetSName(str)
    CSAPI.SetText(txt_set,str or "");
end

function SetName(str)
    needToCheckMove = false
    CSAPI.SetText(txt_name,str or "");
    needToCheckMove = true
end


function SetSIcon(iconName)
    CSAPI.SetGOActive(setIcon,iconName~=nil);
    if iconName then
        ResUtil.SkinSetIcon:Load(setIcon,iconName.."_w",true);
    end
end

function SetTags()
    if loading==true then
        do return end
    end
    local list={};
    if this.data and this.data:IsShowTag() then
        list=this.data and this.data:GetTagsData() or list; 
    end
    loading=#list>0
    ItemUtil.AddItems("ShopComm/CommodityTag", tags, list, tagNode, nil, 1, false,function()
        loading=false
    end);
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
    -- animator = nil;
    tags={};
    orgItem=nil;
    func=nil;
    loading=false
end