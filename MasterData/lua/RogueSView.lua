local nType = 1 -- 普通
local curID = nil
local time, timer = 0, 0
local isFirst = false

function Awake()
    UIUtil:AddTop2("RogueSView", topParent, function()
        view:Close()
    end, nil, {})
    scrollRect = ComUtil.GetCom(sr, "ScrollRect")
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/RogueS/RogueSViewItem", LayoutCallBack, true)
    layoutAnim = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.MoveByType, {"RTL"})

    CSAPI.SetGOActive(AdaptiveScreen, false)

    CSAPI.SetGOActive(mask, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetBtnRed)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, curID)
        if (not isFirst) then
            lua.FirstTween()
        end
    end
end

function ItemClickCB(item)
    curID = item.data:GetID()
    item.Refresh(item.data, curID)
    -- 移动 397
    MoveTo(item.index)
end

function OnOpen()
    nType = openSetting or RogueSMgr:GetCacheNType()
    if (nType == 2 and not RogueSMgr:CheckHardOpen()) then
        nType = 1 -- 困难未开启强制设置为普通难度
    end
    -- 
    if (data ~= nil) then
        layoutAnim.isAnim = false
    end
    -- 请求数据
    RogueSMgr:GetRogueSInfo(function()
        CSAPI.SetGOActive(AdaptiveScreen, true)
        RefreshPanel()
    end)

    -- time 
    SetTime()
end

function SetTime()
    timer = 0
    time = RogueSMgr:GetRogueTime()
    CSAPI.SetGOActive(txtTime, time > 0)
end

-- function Update()
--     if (time > 0 and Time.time > timer) then
--         timer = Time.time + 1
--         time = RogueSMgr:GetRogueSTime()
--         local timeData = TimeUtil:GetTimeTab(time)
--         LanguageMgr:SetText(txtTime, 50001, timeData[1], timeData[2], timeData[3])
--         if (time <= 0) then
--             CSAPI.SetGOActive(txtTime, time > 0)
--         end
--     end
-- end

function RefreshPanel()
    -- bg 
    local bgFloderName = nType == 1 and "bg1" or "bg2"
    ResUtil:LoadBigImg(bg, "UIs/RogueS/" .. bgFloderName .. "/bg", false)
    CSAPI.SetGOActive(easyBG_effect, nType == 1)
    CSAPI.SetGOActive(hardBG_effect, nType == 2)
    -- items
    curDatas = RogueSMgr:GetDatas(nType)
    local curIndex = 1
    if (data) then
        for k, v in ipairs(curDatas) do
            if (v:GetID() == data) then
                curIndex = k
            end
        end
    end
    data = nil
    layout:IEShowList(#curDatas, FirstCB, curIndex)
    -- right 
    SetRight()
    -- red 
    SetBtnRed()
    -- title
    LanguageMgr:SetText(txtTitle, nType == 1 and 65013 or 65014)

    RogueSMgr:SetCacheNType(nType)
end

function SetBtnRed()
    local otherNType = nType == 1 and 2 or 1
    UIUtil:SetRedPoint(btnQH, RogueSMgr:CheckRedByNType(otherNType), 123.5, 18.3, 0)
    UIUtil:SetRedPoint(txtGifts, RogueSMgr:CheckRedByNType(nType), 36.4, 76.7, 0)
end

function FirstCB()
    if (not isFirst) then
        CSAPI.SetGOActive(mask, false)
        isFirst = true
    end
end

function SetRight()
    CSAPI.SetGOActive(right, curID ~= nil)
    if (curID) then
        local curData = RogueSMgr:GetData(curID)
        -- name 
        local index = curData:GetCfg().index
        CSAPI.SetText(txtRTitle, index < 10 and "0" .. index or index .. "")
        -- 增益 
        local _datas = curData:GetCfg().globalBuffs or {}
        buffItems = buffItems or {}
        ItemUtil.AddItems("RogueS/RogueSBuffDetailItem2", buffItems, _datas, Content)
        -- 目标 RogueSTaskItem
        local infos = DungeonUtil.GetStarInfo3(curData:GetCfg().stars, curData:GetStarData())
        targetItems = targetItems or {}
        ItemUtil.AddItems("FightTaskItem/RogueSTaskItem", targetItems, infos, rVert)
    end
end

-- 切换模式
function OnClickQH()
    if (nType == 1) then
        local b, str = RogueSMgr:CheckHardOpen()
        if (not b) then
            Tips.ShowTips(str)
            return
        end
    end
    CSAPI.SetGOActive(mask, true)
    nType = nType == 1 and 2 or 1
    RefreshPanel()
    --
    FuncUtil:Call(function()
        CSAPI.SetGOActive(mask, false)
    end, nil, 500)
end

-- 奖励内容
function OnClickGift()
    CSAPI.OpenView("RogueSGift", curDatas[1]:GetCfg().starIx)
end

-- 编队
function OnClickS()
    CSAPI.OpenView("RogueSTeam", curID)
end

function OnClickRMask()
    curID = nil
    CSAPI.SetGOActive(right, curID ~= nil)
    layout:UpdateList()
    -- 移动 397
    MoveBack()
end

-- loading界面关闭后再播放动画
function OnViewClosed(viewKey)
    if (viewKey == "Loading") then
        local indexs = layout:GetIndexs()
        local len = indexs.Length
        for i = 0, len - 1 do
            local index = indexs[i]
            local lua = layout:GetItemLua(index)
            if (lua and lua.gameObject) then
                lua.CheckUnLock()
            end
        end
    end
end

function MoveTo(index)
    local pos = CSAPI.csGetAnchor(hContent)
    local x2 = 397 - (index - 1) * 397
    oldX = nil
    if (math.abs(pos[0] - x2) > 1) then
        oldX = pos[0]
        scrollRect.enabled = false
        CSAPI.SetGOActive(mask, true)
        UIUtil:SetPObjMove(hContent, pos[0], x2, 0, 0, 0, 0, function()
            CSAPI.SetGOActive(mask, false)
        end, 300, 1)
    end
    SetRight()
end

function MoveBack()
    if (oldX ~= nil) then
        local pos = CSAPI.csGetAnchor(hContent)
        scrollRect.enabled = false
        CSAPI.SetGOActive(mask, true)
        UIUtil:SetPObjMove(hContent, pos[0], oldX, 0, 0, 0, 0, function()
            scrollRect.enabled = true
            CSAPI.SetGOActive(mask, false)
        end, 300, 1)
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    if (oldX ~= nil) then
        MoveBack()
    else
        view:Close()
    end
end
