---剩余次数
local Remainingtimes=0;
-- 抽次抽卡的缓存界面
function Awake()
    Remainingtimes=0;
    CSAPI.SetGOActive(mask, false)
    -- curItems = {}
    -- for i = 1, 10 do
    --     local go = ResUtil:CreateUIGO("RoleLittleCard/CreateCacheItem", grid1.transform)
    --     local item = ComUtil.GetLuaTable(go)
    --     table.insert(curItems, item)
    -- end
    -- cacheItems = {}
    -- for i = 1, 10 do
    --     local go = ResUtil:CreateUIGO("RoleLittleCard/CreateCacheItem", grid2.transform)
    --     local item = ComUtil.GetLuaTable(go)
    --     table.insert(cacheItems, item)
    -- end

    btnLCanvasGroup = ComUtil.GetCom(btnL, "CanvasGroup")
    btnRCanvasGroup = ComUtil.GetCom(btnR, "CanvasGroup")
    btnAgainCanvasGroup = ComUtil.GetCom(btnAgain, "CanvasGroup")
end

function OnEnable()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Role_Refresh_Logs, RefreshPanel)
end

function OnDisable()
    eventMgr:ClearListener()
end

-- function SetSureCB(_cb)
--     cb = _cb
-- end

function Refresh(_datas)
    datas = _datas
    poolId = datas[3]

    RefreshPanel()
end

function RefreshPanel()
    data = CreateMgr:GetData(poolId)

    logs = data:GetLogs()
    cur, max = data:GetCount()
    isSave = data:GetIsSvale()
    isHad = (logs and #logs > 0) and true or false

    SetCur()
    SetCache()
    SetBtns()

    -- new 
end

function SetCur()
    local list = GridUtil.GetGridObjectDatas(datas[1])
    -- for i, v in ipairs(list) do
    --     curItems[i].Refresh(v)
    -- end
    curItems = curItems or {}
    ItemUtil.AddItems("RoleLittleCard/CreateCacheItem", curItems, list, grid1,nil,1,10)
end

function SetCache()
    CSAPI.SetGOActive(ImageTop, not isHad)
    CSAPI.SetGOActive(grid2, isHad)
    if (isHad) then
        items = items or {}
        local rewards = logs[#logs].rewards
        -- items
        local list = GridUtil.GetGridObjectDatas(rewards)
        -- for i, v in ipairs(list) do
        --     cacheItems[i].Refresh(v)
        -- end
        cacheItems = cacheItems or {}
        ItemUtil.AddItems("RoleLittleCard/CreateCacheItem", cacheItems, list, grid2,nil,1,10)
    end
end

function SetBtns()
    -- count
    local num = max - cur
    LanguageMgr:SetText(txtCount, 17038, num)
    Remainingtimes=num;
    -- CSAPI.SetText(txtCount, cur .. "/" .. max)
    -- 再次构建
    btnAgainCanvasGroup.alpha = cur >= max and 0.3 or 1
    -- LR
    btnLCanvasGroup.alpha = isSave and 0.3 or 1
    btnRCanvasGroup.alpha = isHad and 1 or 0.3
end

-- 替换
function OnClickL()
    if (not data:GetIsSvale()) then
        local str = LanguageMgr:GetTips(10013)
        UIUtil:OpenDialog(str, function()
            CreateMgr:FirstCardCreateAddLog(poolId)
            btnRCanvasGroup.alpha = (ogs and #logs > 0) and 1 or 0.3
            if CSAPI.IsADV() or CSAPI.IsDomestic() then BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_RESTRUCTURE_REPLACE) end
            EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "CheckBuild") 
        end,function ()
            EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "CheckBuild") 
        end)
    end
end

-- 使用
function OnClickR()
    if (isHad) then
        local rewards = logs[#logs].rewards
        CSAPI.OpenView("CreateEnsurePanel", {rewards, SureCB})
        -- local dialogdata = {};
        -- dialogdata.content = LanguageMgr:GetTips(10002)
        -- dialogdata.okCallBack = function()
        -- 	CreateMgr:FirstCardCreateAffirm(poolId, #logs)
        -- 	cb()
        -- end
        -- CSAPI.OpenView("Dialog", dialogdata)
    end
end

function SureCB()
    CreateMgr:FirstCardCreateAffirm(poolId, #logs)
    --cb()
end

-- 重新构建
function OnClickAgain()
    if (cur >= max) then
        LanguageMgr:ShowTips(10003)
        return
    end

    CreateMgr:CardCreate(poolId, 10) -- 继续10连
    -- cb() --由CreataShowView 的打开来关闭 CreateRoleView 
    CSAPI.SetGOActive(mask, true) -- 放置延迟期间玩家继续点击
    if CSAPI.IsADV() or CSAPI.IsDomestic() then
        local Datable= { times=tostring(Remainingtimes), };
        BuryingPointMgr:TrackEvents(ShiryuEventName.MJ_RESTRUCTURE_NEXT,Datable)
    end
end

-- -- 结束构建
-- function OnClickSure()
--     local dialogdata = {};
--     dialogdata.content = LanguageMgr:GetTips(10002)
--     dialogdata.okCallBack = function()
--         CreateMgr:FirstCardCreateAffirm(poolId, data:GetIsSvale() and #logs or nil)
--         cb()
--     end
--     CSAPI.OpenView("Dialog", dialogdata)
-- end
