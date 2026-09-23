--皮肤信息子物体

local needToCheckMove = false
local tags={};
local spTags={};
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txt_name)
end 
function Update()
    if (needToCheckMove) then
        luaTextMove:CheckMove(txt_name)
        needToCheckMove = false
    end
end

--data:this.data
local modelCfg=nil
function Refresh(_data,_elseData)
    this.data=_data;
    this.elseData=_elseData;
    if this.data then
        modelCfg=this.data:GetModelCfg();
        ResUtil.CardIcon:Load(icon,modelCfg.Card_head,true);
        SetName(this.data:GetRoleName());
        SetSName(this.data:GetSkinName());
        --特殊标签
        local icons,lIds=this.data:GetTagIcons(true);
        SetSPTag(icons);
        local cfg=this.data:GetSetCfg();
        SetSIcon(cfg.icon);
        local isHas=true;
        if this.elseData then
            local rInfo=RoleSkinMgr:GetRoleSkinInfo(modelCfg.role_id,modelCfg.id)
            if this.elseData.flag and rInfo then
                isHas=rInfo:CheckCanUse()
                SetHas(isHas);
            elseif rInfo==nil then
                isHas=false;
                SetHas(false);
            else
                SetHas(true);--隐藏未持有的标签
            end
        else
            SetHas(true);--隐藏未持有的标签
        end
        local comm=ShopCommFunc.GetSkinCommodity(this.data:GetModelID());
        --加载标签
        -- local list ={};
        -- if comm  then
        --     local state = comm:IsOver() and 2 or 1;
        --     local isLock = not comm:GetBuyLimit();
        --     state = isLock and 3 or state;
        --     if state==1 and isHas==true then
        --         list= comm:GetTagsData();
        --     end
        -- end
        local list={};
        if comm and comm:IsShowTag() then
            list=comm and comm:GetTagsData() or list; 
        end
        SetTags(list)
    else
        LogError("未找到对应的模型Id");
    end
end

function SetSPTag(list)
   ItemUtil.AddItems("ShopComm/SkinTagSmall", spTags, list or {}, tagNode2, nil, 1, list and #list or 0);
end

function SetTags(list)
    ItemUtil.AddItems("ShopComm/CommodityTag", tags, list or {}, tagNode, nil, 1, false);
end

function SetSIcon(iconName)
    CSAPI.SetGOActive(setIcon,iconName~=nil);
    if iconName then
        ResUtil.SkinSetIcon:Load(setIcon,iconName.."_w",true);
    end
end

function SetSName(str)
    CSAPI.SetText(txt_set,str or "");
end

function SetName(str)
    needToCheckMove = false
    CSAPI.SetText(txt_name,str or "");
    needToCheckMove = true
end

function SetHas(isHas)
    CSAPI.SetGOActive(hasObj,not isHas);
end

function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode,val);
end

function SetClickCB(cb)
    this.cb=cb;
end

function OnClickSelf()
    if this.cb then
        this.cb(this);
    end
end

function SetIndex(index)
    this.index=index;
end

function GetIndex()
    return this.index;
end

function SetSelect(isSelect)
    CSAPI.SetGOActive(selectObj,isSelect);
    CSAPI.SetGOActive(border,not isSelect);
    SetAlpha(isSelect and 1 or 0.5);
end

function SetSibling(index)
    index=index or 0;
    if index==-1 then
        transform:SetAsLastSibling();
    else
        transform:SetSiblingIndex(index);
    end
end

--根据X轴距离设置大小
function SetScale(s)
    CSAPI.SetScale(alphaNode,s,s,s);
end

function GetPos()
    local pos={100000,100000,0};
    local x,y,z=CSAPI.GetPos(alphaNode);
    pos={x,y,z}
    return pos;
end