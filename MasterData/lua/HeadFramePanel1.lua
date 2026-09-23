local selectID = nil
local isUseimg = false
local minEndTime = nil
local minShopTime = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/HeadFrame/HeadFrameItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetClickCB(ItemClickCB)
        lua.Refresh0(_data, selectID)
    end
end

function ItemClickCB(id)
    selectID = id
    RefreshPanel()
end

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Head_Frame_Change, RefreshPanel)
    eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh, Refresh)
    -- eventMgr:AddListener(EventType.Head_Frame_Change, function(proto)
    --     Refresh(scale, proto.icon_frame, iconID)
    -- end)
    -- eventMgr:AddListener(EventType.Head_Icon_Change, function(proto)
    --     Refresh(scale, frameID, proto.icon_id)
    -- end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh()
    SetDatas()
    SetExpiry()
    SetHead()
    SetSelectID()
    SetShopRefreshTime()

    RefreshPanel()
end

function SetDatas()
    curDatas = {}
    local cfgs = Cfgs.AvatarFrame:GetAll()
    for k, v in pairs(cfgs) do
        local data = HeadFrameData.New()
        data:Init(v)
        if (data:CheckNeedShow()) then
            table.insert(curDatas, data)
        end
    end
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            return a:GetSortIndex() < b:GetSortIndex()
        end)
    end
end

-- 最小刷新时间
function SetExpiry()
    minEndTime = nil -- 最小刷新时间
    for k, v in pairs(curDatas) do
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

-- 默认选择
function SetSelectID()
    local isIn = false
    if (selectID) then
        for k, v in ipairs(curDatas) do
            if (v:GetID() == selectID) then
                isIn = true
                break
            end
        end
    end
    if (not isIn) then
        selectID = PlayerClient:GetHeadFrame()
    end
end

-- 商店物品刷新时间
function SetShopRefreshTime()
    minShopTime = HeadFrameMgr:GetMinShopRefreshTime()
end

-- 头像 
function SetHead()
    local modelCfg = Cfgs.character:GetByID(PlayerClient:GetIconId())
    if (modelCfg and modelCfg.icon) then
        ResUtil.RoleCard:Load(icon, modelCfg.icon)
    end
end

function Update()
    -- 头像框状态筛选
    if (minEndTime and TimeUtil:GetTime() > minEndTime) then
        SetExpiry()
        RefreshPanel()
    end
    -- 商店头像框状态刷新
    if (minShopTime and TimeUtil:GetTime() > minShopTime) then
        minShopTime = HeadFrameMgr:GetMinShopRefreshTime()
        Refresh()
    end
end

function RefreshPanel()
    SetRight()
    if (not isFirst) then
        isFirst = true
        layout:IEShowList(#curDatas)
    else
        layout:UpdateList()
    end
end

-- 右边
function SetRight()
    isUseimg = selectID == PlayerClient:GetHeadFrame()

    local _data = nil
    for k, v in ipairs(curDatas) do
        if (v:GetID() == selectID) then
            _data = v
            break
        end
    end
    local isCanUse, expiry = _data:CheckCanUse()
    -- item
    UIUtil:AddHeadFrame(headParent, 0.8, _data:GetID(), PlayerClient:GetIconId(),PlayerClient:GetSex())
    -- if (not rItem) then
    --     ResUtil:CreateUIGOAsync("HeadFrame/HeadFrameItem", headParent, function(go)
    --         rItem = ComUtil.GetLuaTable(go)
    --         rItem.Refresh(_data:GetID(), 1.6)
    --     end)
    -- else
    --     rItem.Refresh(_data:GetID(), 1.6)
    -- end
    -- name 
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

function OnClickS()
    if (not isUseimg) then
        PlayerProto:SetIconFrame(selectID)
    end
end
