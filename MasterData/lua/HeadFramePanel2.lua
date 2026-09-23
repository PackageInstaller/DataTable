-- todo 设置头像；
local selectID = nil
local isUseimg = false
local minEndTime = nil
local minShopTime = nil
local isAll = false

local useIndex = nil
local curIndex = nil
local skins = nil
local effectGO

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/CRoleItem/CRoleSmallItem4", LayoutCallBack)

    layout2 = ComUtil.GetCom(hsv, "UIInfinite")
    layout2:Init("UIs/CRoleItem/CRoleSmallItem3", LayoutCallBack2)
    layout2:AddOnValueChangeFunc(OnValueChange)
    svUtil = SVCenterDrag.New()

    -- 排序
    ResUtil:CreateUIGOAsync("Sort/SortTop", sortParent, function(go)
        local lua = ComUtil.GetLuaTable(go)
        CSAPI.SetGOActive(lua.btnL, false)
        lua.Init(22, Refresh)
    end)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, selectID)
    end
end

function ItemClickCB(id)
    selectID = id
    layout:UpdateList()
    SetRight()
end

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Head_Icon_Change, Refresh)
    eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh, Refresh)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh()
    SetDatas()
    SetExpiry()
    SetSelectID()
    SetShopRefreshTime()

    RefreshPanel()
end

-- 分2部分：角色+头像表
function SetDatas()
    curDatas = {}
    local cfgs = Cfgs.CfgAvatar:GetAll()
    for k, v in pairs(cfgs) do
        local data = HeadIconData.New()
        data:Init(v)
        if (data:CheckNeedShow()) then
            if (isAll or BagMgr:GetData(data:GetItemID())) then
                table.insert(curDatas, data)
            end
        end
    end
    local infos = CRoleMgr:GetDatas()
    for k, v in pairs(infos) do
        local data = HeadIconData.New()
        data:Init2(v)
        table.insert(curDatas, data)
    end

    curDatas = SortMgr:Sort(22, curDatas)
end

-- 最小刷新时间
function SetExpiry()
    minEndTime = nil -- 最小刷新时间
    for k, v in pairs(curDatas) do
        if (not v:IsRoleIcon()) then
            local isCanUse, _expiry = v:CheckCanUse()
            if (isCanUse and _expiry ~= nil) then
                if (minEndTime == nil) then
                    minEndTime = _expiry
                else
                    minEndTime = _expiry < minEndTime and _expiry or minEndTime
                end
            end
        end
    end
end

-- 默认选择
function SetSelectID()
    local isIn = false
    local skinDic = {}
    if (selectID) then
        for k, v in ipairs(curDatas) do
            if (v:IsRoleIcon()) then
                skinDic = v:GetCRoleInfo():GetAllSkins(true)
                if (skinDic[selectID]) then
                    isIn = true
                    break
                end
            elseif (v:GetID() == selectID) then
                isIn = true
                break
            end
        end
    end
    if (not isIn) then
        selectID = PlayerClient:GetIconId()
    end
end

-- 商店物品刷新时间
function SetShopRefreshTime()
    minShopTime = HeadIconMgr:GetMinShopRefreshTime()
end

function Update()
    -- 头像状态筛选
    if (minEndTime and TimeUtil:GetTime() > minEndTime) then
        SetExpiry()
        RefreshPanel()
    end
    -- 商店头像状态刷新
    if (minShopTime and TimeUtil:GetTime() > minShopTime) then
        minShopTime = HeadFrameMgr:GetMinShopRefreshTime()
        Refresh()
    end
end

function RefreshPanel()
    SetRight()
    layout:IEShowList(#curDatas)
    -- all 
    CSAPI.SetGOActive(svOnObj, isAll)
    CSAPI.SetGOActive(svOffObj, not isAll)
end

-- 右边
function SetRight()
    local _data = nil
    for k, v in ipairs(curDatas) do
        if (v:IsMe(selectID)) then
            _data = v
            break
        end
    end
    if (not _data) then
        return
    end
    local isRoleIcon = _data:IsRoleIcon()
    CSAPI.SetGOActive(headParent, not isRoleIcon)
    CSAPI.SetGOActive(hsv, isRoleIcon)

    isUseimg = selectID == PlayerClient:GetIconId()
    if (isRoleIcon) then
        SetRoleIcons(_data)
        return
    end

    local isCanUse, expiry = _data:CheckCanUse()
    -- icon 
    SetIcon(_data)
    -- name 
    CSAPI.SetGOActive(txt_set, false)
    CSAPI.SetText(txtName, _data:GetName())
    -- time 
    CSAPI.SetGOActive(time, isCanUse and expiry ~= nil)
    if (isCanUse and expiry ~= nil) then
        local time = 0
        local num1, num2 = "", ""
        if (expiry and expiry > TimeUtil:GetTime()) then
            time = expiry - TimeUtil:GetTime()
        end
        if ((time / 86400) >= 1) then -- 天
            num1 = math.ceil(time / 86400)
            num2 = LanguageMgr:GetByID(11010)
        elseif (time / 3600 >= 1) then -- 小时
            num1 = math.ceil(time / 3600)
            num2 = LanguageMgr:GetByID(11009)
        else
            num1 = math.ceil(time / 60) -- 分钟
            num2 = LanguageMgr:GetByID(11011)
        end
        num1 = StringUtil:SetByColor(num1, "ff7781")
        local num0 = LanguageMgr:GetByID(46003)
        local str = num0 .. num1 .. num2
        CSAPI.SetText(txtTime, str)
    end
    -- use
    local isShowUse = true
    if (isUseimg) then
        LanguageMgr:SetText(txtDesc, 46004) -- 使用中 
    else
        isShowUse = not isCanUse
        CSAPI.SetText(txtDesc, _data:GetPath())
    end
    CSAPI.SetGOActive(use, isShowUse)
    -- btn 
    CSAPI.SetGOActive(btnS, isCanUse and not isUseimg)
end

function SetIcon(_data)
    CSAPI.SetGOActive(icon, _data:GetCfg().type ~= 2)
    -- 是头像表
    if (_data:GetCfg().type == 2) then
        -- 动态
        if (effectGO) then
            if (effectGO.name == _data:GetCfg().id) then
                CSAPI.SetGOActive(effectGO, true)
                return
            end
            CSAPI.RemoveGO(effectGO)
        end
        ResUtil:CreateEffect(_data:GetCfg().avatareffect, 0, 0, 0, headParent, function(go)
            CSAPI.SetScale(go, 0.86, 0.86, 1)
            effectGO = go
            effectGO.name = _data:GetCfg().id
        end)
    else
        -- 静态
        if (effectGO) then
            CSAPI.SetGOActive(effectGO, false)
        end
        local path = _data:GetCfg().picture
        ResUtil.Head:Load(icon, path, true)
    end
end

-- 卡牌类头像
function SetRoleIcons(_data)
    -- items 
    useIndex = nil
    curIndex = 1
    skins = _data:GetRoleSkins()
    for k, v in ipairs(skins) do
        if (v:GetSkinID() == PlayerClient:GetIconId()) then
            useIndex = k
            curIndex = k
            break
        end
    end
    svUtil:Init(layout2, #skins, {274, 422}, 5, 0.1, 0.5)
    layout2:IEShowList(#skins, OnValueChange, curIndex)

    RefreshRoleIcon()
end

function RefreshRoleIcon()
    curSkin = skins[curIndex]
    -- set
    local isShow = true
    local skinType = curSkin:GetCfg().skinType
    if (skinType and skinType == 5) then
        isShow = false
    end
    CSAPI.SetGOActive(txt_set, isShow)
    CSAPI.SetText(txt_set, curSkin:GetName())
    -- name
    CSAPI.SetText(txtName, curSkin:GetCfg().key)
    -- time 
    CSAPI.SetGOActive(time, false)
    -- use 
    local isUse = false
    if (useIndex and useIndex == curIndex) then
        isUse = true
        LanguageMgr:SetText(txtDesc, 46004) -- 使用中 
    else
        local get_txt = skins[curIndex]:GetTxt() or ""
        CSAPI.SetText(txtDesc, get_txt)
        isUse = not curSkin:CheckCanUse()
    end
    CSAPI.SetGOActive(use, isUse)
    -- btn
    local isCanUse = false
    if ((useIndex == nil or useIndex ~= curIndex) and skins[curIndex]:CheckCanUse()) then
        isCanUse = true
    end
    CSAPI.SetGOActive(btnS, isCanUse)
end

function OnClickS()
    PlayerProto:SetIcon(selectID)
end

function OnClickAll()
    isAll = not isAll
    Refresh()
end

--------------------------------------------------------------
function LayoutCallBack2(index)
    local _data = skins[index]
    local item = layout2:GetItemLua(index)
    item.Refresh(_data)
    item.SetIndex(index)
    item.SetClickCB(OnClickItem)
    item.SetSelect(index == curIndex)
end

function OnValueChange()
    local index = layout2:GetCurIndex()
    if index + 1 ~= curIndex then
        local item = layout2:GetItemLua(curIndex)
        if item then
            item.SetSelect(false)
        end
        curIndex = index + 1
        local item = layout2:GetItemLua(curIndex)
        if (item) then
            item.SetSelect(true);
            selectID = item.skinInfo:GetSkinID()
        end
        SetArrow()
        RefreshRoleIcon()
    end
    svUtil:Update()
end

function OnClickItem(index)
    layout2:MoveToCenter(index)
end

function SetArrow()
    if curIndex <= 1 then
        CSAPI.SetGOAlpha(arrow1, 0.48)
        CSAPI.SetGOAlpha(arrow2, 1)
    elseif curIndex == #curDatas then
        CSAPI.SetGOAlpha(arrow1, 1)
        CSAPI.SetGOAlpha(arrow2, 0.48)
    else
        CSAPI.SetGOAlpha(arrow1, 1)
        CSAPI.SetGOAlpha(arrow2, 1)
    end
end
