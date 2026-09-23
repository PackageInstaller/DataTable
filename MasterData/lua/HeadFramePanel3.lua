local HeadTitleData = require("HeadTitleData")
local selectID = nil
local isUseimg = false
local minEndTime = nil
local minShopTime = nil

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/HeadFrame/HeadFrameItem3", LayoutCallBack, true)
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
    eventMgr:AddListener(EventType.Head_Title_Change, RefreshPanel)
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

function SetDatas()
    curDatas = {}
    local cfgs = Cfgs.CfgIconTitle:GetAll()
    for k, v in pairs(cfgs) do
        local data = HeadTitleData.New()
        data:Init(v)
        if (data:CheckNeedShow()) then
            table.insert(curDatas, data)
        end
    end
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            if (a:CheckCanUse() == b:CheckCanUse()) then
                return a:GetSortIndex() < b:GetSortIndex()
            else
                return a:CheckCanUse()
            end
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
        selectID = PlayerClient:GetIconTitle()
    end
end

-- 商店物品刷新时间
function SetShopRefreshTime()
    minShopTime = HeadTitleMgr:GetMinShopRefreshTime()
end

function Update()
    -- 头像框状态筛选
    if (minEndTime and TimeUtil:GetTime() > minEndTime) then
        SetExpiry()
        RefreshPanel()
    end
    -- 商店头像框状态刷新
    if (minShopTime and TimeUtil:GetTime() > minShopTime) then
        minShopTime = HeadTitleMgr:GetMinShopRefreshTime()
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
    isUseimg = selectID == PlayerClient:GetIconTitle()

    local _data = nil
    for k, v in ipairs(curDatas) do
        if (v:GetID() == selectID) then
            _data = v
            break
        end
    end
    local isCanUse, expiry = _data:CheckCanUse()
    -- item
    if (not rItem) then
        ResUtil:CreateUIGOAsync("HeadFrame/HeadFrameItem3", headParent, function(go)
            rItem = ComUtil.GetLuaTable(go)
            rItem.Refresh(_data:GetID())
        end)
    else
        rItem.Refresh(_data:GetID())
    end
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
        PlayerProto:SetIconTitle(selectID)
    end
end
