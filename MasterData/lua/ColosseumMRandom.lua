local ColosseumSJData = require("ColosseumSJData")
local ColosseumZXData = require("ColosseumZXData")
local chidItem = nil
local isSelect = false
local closeType = 1
local selectType = 1 -- 1:自选 2：随机

function Awake()
    UIUtil:AddTop2("ColosseumMRandom", gameObject, Close1, Close2, {})
    scrollRect = ComUtil.GetCom(sv, "ScrollRect")
    star_fill = ComUtil.GetCom(starFill, "Image")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Team_Data_Update, function()
        SetTeams()
        if (infoPanel and infoPanel.gameObject.activeSelf) then
            infoPanel.CallFunc("Button4", "SetBtn")
        end
    end)
    eventMgr:AddListener(EventType.Colosseum_RandomReward, Close1)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function OnDestroy()
    eventMgr:ClearListener()
end

-- data : id 战斗后的id
function OnOpen()
    selectType = openSetting or 1
    RefreshPanel()

    data = nil
end

function RefreshPanel()
    InitDatas()
    -- 选人界面
    CheckSelectCard()
    -- left 
    SetLeft()
    -- midle 
    SetMiddle()
    -- right
    SetRight()
    -- down
    SetDown()
    -- btnqq
    SetBtnQQ()
end

function InitDatas()
    curDatas = {}
    if (selectType == 1) then
        local group = ColosseumMgr:GetSectionData():GetCfg().id
        local cfgs = Cfgs.MainLine:GetGroup(group)
        local allDatas = {}
        for k, v in pairs(cfgs) do
            if (v.modeType == 1 and v.season == ColosseumMgr:GetRealSeasonID()) then
                if (not allDatas[v.turn]) then
                    allDatas[v.turn] = {}
                end
                table.insert(allDatas[v.turn], v)
            end
        end
        if (#allDatas > 1) then
            for k, v in pairs(allDatas) do
                if (#v > 1) then
                    table.sort(allDatas[k], function(a, b)
                        return a.id < b.id
                    end)
                end
            end
        end
        max = #allDatas or 0
        -- 
        curDatas = {}
        for k, v in ipairs(allDatas) do
            local _data = ColosseumZXData.New()
            _data:Init(k, v)
            table.insert(curDatas, _data)
        end
    else
        randModData = ColosseumMgr:GetRandModData()
        local randLvs = randModData.randLvs or {}
        for k = 1, 9 do
            local _data = ColosseumSJData.New()
            local _d = k <= #randLvs and randLvs[k] or nil
            _data:Init(k, _d)
            table.insert(curDatas, _data)
        end
    end
end

--------
-- 检测选人
function CheckSelectCard()
    if (selectType == 2) then
        if (ColosseumMgr:IsNeedToSelect()) then
            CSAPI.OpenView("ColosseumTeam", {
                closeCB = SelectViewCloseCB
            })
        end
    end
end
function SelectViewCloseCB()
    view:Close()
    ToGuid()
end
function ToGuid()
    EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "ColosseumMain")
end
--------
function SetLeft()
    local lanID = selectType == 1 and 64002 or 64003
    LanguageMgr:SetText(txtTitle1, lanID)
    LanguageMgr:SetEnText(txtTitle2, lanID)
end

--------
function SetMiddle()
    items = items or {}
    local toID = data
    ItemUtil.AddItems("Colosseum/ColosseumMItem1", items, curDatas, mContent, ItemClickCB, 1, toID, function()
        SetCorrectPos(toID)
        SetMiddleAnim(toID)
    end)
end
function SetCorrectPos(toID)
    if (toID) then
        -- 设置到合适的位置
        local contentRT = 40 + (#curDatas - 1) * 422 + 250
        local realWidth = CSAPI.GetMainCanvasSize()[0] - 380
        local limitX = contentRT - realWidth
        local cfg = Cfgs.MainLine:GetByID(toID)
        local x = (cfg.turn - 1) * 422
        x = x > limitX and limitX or x
        CSAPI.SetAnchor(mContent, -x, 0, 0)
    end
end

function SetMiddleAnim(toID)
    local cfg = toID and Cfgs.MainLine:GetByID(toID) or nil
    local turn = cfg and cfg.turn or 1
    for k, v in ipairs(items) do
        if (k > turn) then
            -- itemsParent
            local delay = 60 * (k - turn - 1) + 1
            UIUtil:SetObjFade(v.itemsParent, 0, 1, nil, 300, delay, 0)
            UIUtil:SetPObjMove(v.itemsParent, -80, 0, 0, 0, 0, 0, nil, 300, delay)
            -- lines
            delay = 60 * (k - turn - 1) + 1
            UIUtil:SetObjFade(v.lines1, 0, 1, nil, 300, delay, 0)
            UIUtil:SetPObjMove(v.lines1, -132, 0, 0, 0, 0, 0, nil, 300, delay)
            UIUtil:SetObjFade(v.lines2, 0, 1, nil, 300, delay, 0)
            UIUtil:SetPObjMove(v.lines2, -132, 0, 0, 0, 0, 0, nil, 300, delay)
        end
    end
end

function ItemClickCB(item)
    if (chidItem) then
        chidItem.Select(false)
    end
    chidItem = item
    chidItem.Select(true)
    SetRight()
    -- 
    ItemMove(chidItem.cfg.turn)
end

--------
function SetRight()
    local cfg = chidItem and chidItem.cfg or nil
    local type = DungeonInfoType.Colosseum
    if infoPanel == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo", AdaptiveScreen, function(go)
            infoPanel = ComUtil.GetLuaTable(go)
            -- CSAPI.SetLocalPos(infoPanel.childNode, 0, 0, 0)
            -- infoPanel.PlayInfoMove = PlayInfoMove
            infoPanel.Show(cfg, type)
        end)
    else
        infoPanel.Show(cfg, type)
    end
end

function PanelCloseCB()
    chidItem.Select(false)
    chidItem = nil
    -- 
    ItemMove()
    SetRight()
end

function ItemMove(turn)
    local realWidth = CSAPI.GetMainCanvasSize()[0]
    local offset = math.floor(realWidth / 2) - 700
    if (turn) then
        scrollRect.enabled = false
        -- 选中 
        local pos = CSAPI.csGetAnchor(mContent)
        local x2 = -555 * (turn - 1) + offset
        oldX = nil
        if (math.abs(pos[0] - x2) > 1) then
            oldX = pos[0]
            CSAPI.SetGOActive(mask, true)
            UIUtil:SetPObjMove(mContent, pos[0], x2, 0, 0, 0, 0, function()
                CSAPI.SetGOActive(mask, false)
            end, 200, 1)
        end
    else
        -- 还原 
        if (oldX ~= nil) then
            local pos = CSAPI.csGetAnchor(mContent)
            scrollRect.enabled = false
            CSAPI.SetGOActive(mask, true)
            UIUtil:SetPObjMove(mContent, pos[0], oldX, 0, 0, 0, 0, function()
                scrollRect.enabled = true
                CSAPI.SetGOActive(mask, false)
            end, 200, 1)
        else
            scrollRect.enabled = true
        end
    end
    CSAPI.SetGOActive(middleMasks, turn)

    isSelect = turn ~= nil
end

--------------
function SetDown()
    SetTeams()
    --
    SetReward()
end

function SetTeams()
    teamData = TeamMgr:GetTeamData(ColosseumMgr:GetTeamIndex(selectType))
    local itemDatas = {}
    for k = 1, 5 do
        local _data = teamData:GetItemByIndex(k)
        table.insert(itemDatas, _data ~= nil and _data:GetCard() or {})
    end
    teamItems = teamItems or {}
    ItemUtil.AddItems("RoleLittleCard/RoleSmallCard", teamItems, itemDatas, dGrid, DItemClickCB, 1, nil, function()
        for k, v in pairs(teamItems) do
            v.ActiveClick(true)
        end
    end)
end

function DItemClickCB(item)
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.Colosseum + (selectType - 1),
        canEmpty = true,
        is2D = true
    }, TeamOpenSetting.Colosseum)
end

function SetReward()
    local cur, max = 0, 0
    if (selectType == 1) then
        for k, v in ipairs(curDatas) do
            cur = cur + v:GetStars()[4]
        end
        max = 81
    else
        for k, v in ipairs(curDatas) do
            cur = cur + v:GetStar(1) + v:GetStar(2) + v:GetStar(3)
        end
        max = 27
    end
    CSAPI.SetText(txtStar1, cur .. "")
    CSAPI.SetText(txtStar2, "/" .. max)
    star_fill.fillAmount = max == 0 and 0 or cur / max
    -- red
    isRed = false
    if (selectType == 2) then
        isRed = ColosseumMgr:IsRewardRed()
    end
    UIUtil:SetRedPoint(btnStar, isRed, -160, 35, 0)
    CSAPI.SetGOActive(Btn3_effect, isRed)
end

-----------------------------------------------------------------------------------------------------

function SetBtnQQ()
    CSAPI.SetGOActive(btnQQ, selectType == 2)
    if (selectType == 2) then
        CSAPI.SetGOAlpha(btnQQ, randModData.isOver and 0.5 or 1)
        local imgName = randModData.isOver and "btn_01_04.png" or "btn_01_03.png"
        CSAPI.LoadImg(imgQQ, "UIs/Colosseum/" .. imgName, true, nil, true)
    end
end

-----------------------------------------------------------------------------------------------------

function OnViewClosed(viewKey)
    if (gameObject ~= nil and viewKey == "TeamView") then
        EventMgr.Dispatch(EventType.Guide_Trigger_Flag, "ColosseumMRandom")
    elseif (gameObject ~= nil and viewKey == "Loading") then
        -- 自动弹出奖励界面
        if (isRed) then
            OnClickStar()
        end
    end
end

function OnClickStar()
    if (selectType == 2) then
        CSAPI.OpenView("ColosseumReward")
    end
end

function OnClickTeam()
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.Colosseum + 1,
        canEmpty = true,
        is2D = true
    }, TeamOpenSetting.Colosseum)
end
-- 触发保存路线
function Close1()
    closeType = 1
    ViewClose()
end

function Close2()
    closeType = 2
    ViewClose()
end

-- 触发保存路线
function ViewClose()
    if (isSelect) then
        PanelCloseCB()
        return
    end
    if (selectType == 2 and randModData.isOver) then
        if (randModData.isGet) then
            local b = ColosseumMgr:IsNeedSaveRoute()
            if (b) then
                UIUtil:OpenDialog(LanguageMgr:GetByID(64029), ToSave1, ToSave2)
            else
                ToSave2()
            end
            return
        end
    end
    if (closeType == 1) then
        view:Close()
        ToGuid()
    else
        UIUtil:ToHome()
    end
end

function ToSave1()
    ToSave(true)
end
function ToSave2()
    ToSave(false)
end

function ToSave(b)
    CSAPI.SetGOActive(mask, true)
    AbattoirProto:SaveRoute(b, function()
        if (closeType == 1) then
            view:Close()
            CSAPI.OpenView("ColosseumView") -- 触发打开界面，重新请求数据
        else
            UIUtil:ToHome()
        end
    end)
end

-- 弃权
function OnClickQQ()
    if (selectType == 2 and not randModData.isOver) then
        UIUtil:OpenDialog(LanguageMgr:GetByID(64030), function()
            AbattoirProto:RandModQuit(function()
                RefreshPanel()
                if (isRed) then
                    CSAPI.OpenView("ColosseumReward")
                end
            end)
        end)
    end
end

function OnClickBG()
    if (isSelect) then
        PanelCloseCB()
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    if (infoPanel and infoPanel.gameObject.activeSelf) then
        CSAPI.SetGOActive(infoPanel.gameObject, false)
    else
        Close1()
    end
end
