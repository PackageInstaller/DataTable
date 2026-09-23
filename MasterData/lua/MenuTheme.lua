-- MenuThemeItem,MenuTheme_Change,Menu_Theme_HideKB,商品过期,通用MenuRD
local MenuThemeData = require("MenuThemeData")
local needGet = false
local ud = true
local curEndTime = nil
local minEndTime = nil
local useID, selectID
local isHide = false

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/MenuTheme/MenuThemeItem", LayoutCallBack, true)
end

function OnDisable()
    -- 去掉红点
    MenuThemeMgr:RefreshDatas()
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
    if (id == selectID) then
        return
    end
    selectID = id
    layout:UpdateList()
    SetBtns()
    MenuThemeMgr:SetTempMenuThemeID(id)
    EventMgr.Dispatch(EventType.MenuTheme_Change)
end

function OnDestroy()
    SetUI(false)
    MenuThemeMgr:SetTempMenuThemeID(nil)
    if (useID ~= selectID) then
        EventMgr.Dispatch(EventType.MenuTheme_Change)
    end
    if (isHide) then
        EventMgr.Dispatch(EventType.Menu_Theme_HideKB, false)
    end
end

function Update()
    if (curEndTime) then
        local timer = curEndTime - TimeUtil:GetTime()
        timer = timer <= 0 and 0 or timer
        CSAPI.SetText(txtTime, TimeUtil:GetTimeStr10(timer))
        if (timer <= 0) then
            curEndTime = nil
            layout:UpdateList()
            SetBtns()
        end
    end
    if (minEndTime and TimeUtil:GetTime() > minEndTime) then
        minEndTime = nil
        CheckEnd()
    end
end

-- 检查是否过期
function CheckEnd()
    local _useID = MenuThemeMgr:GetTempMenuThemeID()
    for k, v in pairs(baseDatas) do
        if (v:GetID() == _useID) then
            local isCanUse = v:CheckCanUse()
            if (not isCanUse) then
                PlayerProto:MainUIChangeTheme(1, function()
                    EventMgr.Dispatch(EventType.MenuTheme_Change)
                    LanguageMgr:ShowTips(78001)
                    RefreshPanel()
                end)
                return
            end
            break
        end
    end
    RefreshPanel()
end

function OnOpen()
    SetUI(true)
    SetBaseData()
    CheckEnd()
end

function SetUI(open)
    local menuGO = CSAPI.GetView("Menu")
    if (menuGO) then
        menu = ComUtil.GetLuaTable(menuGO)
        if (open) then
            CSAPI.SetParent(menu.ltParent, uis)
            CSAPI.SetParent(menu.ldParent, uis)
            CSAPI.SetAnchor(menu.movePoint, 360, 0, 0)
            menu.ZK()
        else
            CSAPI.SetParent(menu.ltParent, menu.ltParentNode)
            CSAPI.SetParent(menu.ldParent, menu.LD)
            CSAPI.SetAnchor(menu.movePoint, 0, 0, 0)
        end
        menu.Anim_centerCR(not open, true)
    end
end

function SetBaseData()
    baseDatas = {}
    local cfgs = Cfgs.CfgUiTheme:GetAll()
    for k, v in pairs(cfgs) do
        local data = MenuThemeData.New()
        data:Init(v)
        if (data:CheckNeedShow()) then
            table.insert(baseDatas, data)
        end
    end
end

function RefreshPanel()
    useID = MenuThemeMgr:GetMenuThemeID()
    selectID = MenuThemeMgr:GetTempMenuThemeID()
    SetDatas()
    SetBtns()
    --
    CSAPI.SetGOActive(tick, isHide)
    CSAPI.SetGOActive(imgGet, needGet)
    SetUD()
end

function SetUD()
    local imgUDName = ud and "img_10_01.png" or "img_10_02.png"
    CSAPI.LoadImg(imgUD, "UIs/MenuTheme/" .. imgUDName, true, nil, true)
end

function SetDatas()
    curDatas = {}
    -- 是否已获取
    for k, v in pairs(baseDatas) do
        if (not needGet or v:CheckCanUse()) then
            table.insert(curDatas, v)
        end
    end
    -- 排序
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            if (a:CheckCanUse() == b:CheckCanUse()) then
                return a:GetSortIndex() < b:GetSortIndex()
            else
                return a:CheckCanUse()
            end
        end)
    end
    -- 倒序
    if (not ud) then
        local reversedDatas = {}
        for i = #curDatas, 1, -1 do
            table.insert(reversedDatas, curDatas[i])
        end
        curDatas = reversedDatas
    end
    layout:IEShowList(#curDatas)
    -- 
    CSAPI.SetGOActive(objGet1, not needGet)
    CSAPI.SetGOActive(objGet2, needGet)
end

function SetBtns()
    local curData = GetCurData()
    local isCanUse, expiry = curData:CheckCanUse()
    local isUse = curData:GetID() == useID
    local hadPath = curData:GetPath()
    CSAPI.SetGOActive(objNone, not isCanUse and not hadPath)
    CSAPI.SetGOActive(objCur, isUse)
    local b = false 
    if(not isUse and not isCanUse and hadPath)then 
        b =  true
    end
    CSAPI.SetGOActive(btnC, b)
    CSAPI.SetGOActive(btnS, not isUse and isCanUse)

    -- down 
    curEndTime = expiry
    CSAPI.SetGOActive(objTime, curEndTime ~= nil)
    CSAPI.SetText(txtName, curData:GetName())
    CSAPI.SetText(txtDesc, curData:GetDesc())
    -- 时间
    minEndTime = MenuThemeMgr:GetMinExpiry()
end

function GetCurData()
    for k, v in pairs(curDatas) do
        if (v:GetID() == selectID) then
            return v
        end
    end
    return nil
end

-- 隐藏看板
function OnClickHide()
    isHide = not isHide
    CSAPI.SetGOActive(tick, isHide)
    EventMgr.Dispatch(EventType.Menu_Theme_HideKB, isHide)
end

-- 上下排序
function OnClickUD()
    ud = not ud
    SetUD()
    SetDatas()
end

-- 是否已获取
function OnClickGet()
    needGet = not needGet
    SetDatas()
end

-- 跳转
function OnClickC()
    local curData = GetCurData()
    local jumpID = curData:GetPath()
    if jumpID then
        JumpMgr:Jump(jumpID)
    end
end

-- 设置
function OnClickS()
    PlayerProto:MainUIChangeTheme(selectID, function()
        useID = MenuThemeMgr:GetMenuThemeID()
        RefreshPanel()
    end)
end

function OnClickExit()
    view:Close()
end

function OnClickMask()
    -- view:Close()
end
