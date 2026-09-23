-- 皮肤信息子物体

local needToCheckMove = false
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

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(_index)
    index = _index
end

function Refresh(_data)
    data = _data
    cfgModel = Cfgs.character:GetByID(data:GetSkinID())

    SetIcon()
    SetName(cfgModel.key)
    SetSName(cfgModel.desc)
    -- SetL2dTag(data:GetCfg().l2dName ~= nil)
    -- SetAnimaTag(cfgModel.hadAni ~= nil)
    -- SetModelTag(cfgModel.hadModel ~= nil)
    SetSIcon()
    --SetGetTag()
    SetHas(data:CheckCanUse())
    SetLimitSkin()
end

function SetIcon()
    local iconName = cfgModel.Card_head
    ResUtil.CardIcon:Load(icon, cfgModel.Card_head, true)
end

function SetSIcon()
    local cfg = Cfgs.CfgSkinInfo:GetByID(cfgModel.id)
    local iconName = cfg and cfg.icon
    CSAPI.SetGOActive(setIcon, iconName ~= nil)
    if iconName then
        ResUtil.SkinSetIcon:Load(setIcon, iconName .. "_w", true)
    end
end

function SetSName(str)
    CSAPI.SetText(txt_set, str or "")
end

function SetName(str)
    needToCheckMove = false
    CSAPI.SetText(txt_name,str or "");
    needToCheckMove = true
end

function SetHas(isHas)
    CSAPI.SetGOActive(hasObj, not isHas)
end

function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode, val)
end

-- function SetGetTag()
--     local getType, getTips = GetWayInfo()
--     if getType == SkinGetType.Store then
--         CSAPI.SetGOActive(buyTag, true)
--         CSAPI.SetGOActive(getTag, false)
--     elseif getType == SkinGetType.Archive then
--         CSAPI.SetGOActive(buyTag, false)
--         CSAPI.SetGOActive(getTag, true)
--         ResUtil.Tag:Load(getTag, "img9_03_06", false)
--         CSAPI.SetText(txt_getTag, getTips)
--     elseif getType == SkinGetType.Other then
--         CSAPI.SetGOActive(buyTag, false)
--         CSAPI.SetGOActive(getTag, true)
--         ResUtil.Tag:Load(getTag, "img9_03_05", false)
--         CSAPI.SetText(txt_getTag, getTips)
--     else
--         CSAPI.SetGOActive(buyTag, false)
--         CSAPI.SetGOActive(getTag, false)
--     end
-- end
-- function GetWayInfo()
--     -- 读取跳转表的多语言ID
--     local wayType = nil;
--     local info = cfgModel.getCondition
--     local wayTips = nil;
--     if info ~= nil then
--         local jumpCfg = Cfgs.CfgJump:GetByID(info[1]);
--         if jumpCfg then
--             wayTips = LanguageMgr:GetByID(jumpCfg.tag);
--             if jumpCfg.tag == 18054 then
--                 wayType = SkinGetType.Archive;
--                 wayTips = LanguageMgr:GetByID(18054);
--             elseif jumpCfg.tag == 18053 then
--                 wayType = SkinGetType.Store
--                 wayTips = LanguageMgr:GetByID(18053);
--             elseif jumpCfg.tag == 18055 then
--                 wayType = SkinGetType.Other;
--                 wayTips = LanguageMgr:GetByID(18055);
--             end
--         end
--     else
--         wayType = SkinGetType.None;
--         if isShort then
--             wayTips = LanguageMgr:GetByID(18057)
--         else
--             wayTips = LanguageMgr:GetByID(18056);
--         end
--     end
--     return wayType, wayTips;
-- end

-- function SetL2dTag(isShow)
--     -- CSAPI.SetGOActive(l2dTag, isShow == true) --和谐隐藏
-- end

-- function SetAnimaTag(isShow)
--     -- CSAPI.SetGOActive(animaTag, isShow == true)
-- end

-- function SetModelTag(isShow)
--     -- CSAPI.SetGOActive(modelTag, isShow == true)
-- end

function OnClickSelf()
    if cb then
        cb(index)
    end
end

function GetIndex()
    return index
end

function SetSelect(isSelect)
    CSAPI.SetGOActive(selectObj, isSelect)
    CSAPI.SetGOActive(border, not isSelect)
    SetAlpha(isSelect and 1 or 0.5)
end

function OnClickBuy()

end

function SetSibling(index)
    index = index or 0
    if index == -1 then
        transform:SetAsLastSibling()
    else
        transform:SetSiblingIndex(index)
    end
end

-- 根据X轴距离设置大小
function SetScale(s)
    CSAPI.SetScale(alphaNode, s, s, s)
end

function GetPos()
    local pos = {100000, 100000, 0}
    local x, y, z = CSAPI.GetPos(alphaNode)
    pos = {x, y, z}
    return pos
end


function SetLimitSkin()
    local isLimitSkin = data:IsLimitSkin()
    UIUtil:SetRedPoint2("Common/Red4", alphaNode, isLimitSkin, 88, 204, 0)
end
