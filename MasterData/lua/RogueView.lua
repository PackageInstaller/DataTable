curIndex1, curIndex2 = 1, 1 -- 父index,子index
local panel1LinesPos = {{155, 0, -28}, {155, 0, -21}, {155, 0, 65}, {-151, 180, 231}, {-151, 180, 231}}
local panel2LinesPos = {{155, 0, -28}, {155, 0, -28}, {155, 0, 65}, {155, 0, 79}, {-151, 180, 231}, {-151, 180, 231},
                        {-151, 180, 253}}
local monsters = {}
local isChallenge = false
local timer = 0
local time = 0
local selectID
-- 完成状态+界面动画
function Awake()
    UIUtil:AddTop2("RogueView", gameObject, function()
        if (right.activeInHierarchy) then
            OnClickRight()
        else
            view:Close()
        end
    end, nil, {})

    layout = ComUtil.GetCom(enemyHsv, "UIInfinite")
    layout:Init("UIs/Rogue/RogueEnemyItem", LayoutCallBack, true)

    CSAPI.SetGOActive(AdaptiveScreen, false)
    CSAPI.SetGOActive(right, false)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Rogue_CancelBack, function()
        if (selectItem) then
            selectItem.Select(true)
            CSAPI.SetGOActive(right, false)
            SetRight(selectItem.data:GetID())
        end
    end)
    -- 红点刷新
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = monsters[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB1)
        lua.Refresh(_data)
    end
end
function ItemClickCB1()
    CSAPI.OpenView("FightEnemyInfo", monsters)
end

function OnOpen()
    InitIndex()
    InitLeftPanel()
    -- 请求数据
    RogueMgr:ClearCurData()
    RogueMgr:GetRogueInfo(function()
        CSAPI.SetGOActive(AdaptiveScreen, true)
        RefreshPanel()
        -- 胜利的话跳到buff选择界面
        if (RogueMgr:CheckNeedToBuffView()) then
            OnClickS()
        end
    end)
end

function InitIndex()
    if (openSetting) then
        if (openSetting < 3) then
            curIndex1 = openSetting
            openSetting = nil
        else
            local cfg = Cfgs.DungeonGroup:GetByID(openSetting)
            curIndex1 = cfg.nType
        end
    end
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftPoint.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {{50027, "Rogue/img_02_01"}, {50026, "Rogue/img_02_02"}}
    local leftChildDatas = {}
    leftPanel.Init(this, leftDatas, leftChildDatas)
end

function RefreshPanel()
    -- 跳进来的  --关卡是否已开启
    if(openSetting) then  
        local _data = RogueMgr:GetData(openSetting)
        if(_data:IsLock()) then 
            if (_data:GetCfg().perLevel) then
                local cfg = Cfgs.DungeonGroup:GetByID(_data:GetCfg().perLevel)
                LanguageMgr:ShowTips(39002, cfg.name)
            end
            openSetting = nil 
        end 
    end 

    selectID = openSetting

    selectItem = nil -- 换页
    -- items 
    SetItems()
    -- time
    timer = 0
    time = RogueMgr:GetRogueTime()
    CSAPI.SetGOActive(txtTime, time > 0)
    -- right 
    SetRight(selectID, openSetting ~= nil)
    if(openSetting ~= nil and selectItem~=nil) then --跳进来应该有个动画
        SetSelect(selectItem,true)
    end
    -- 侧边动画
    leftPanel.Anim()
    -- 
    CSAPI.SetGOActive(BG_effectNormal, curIndex1 == 1)
    CSAPI.SetGOActive(BG_effectHrad, curIndex1 == 2)
    -- red 
    SetRed()
    -- bg 
    local bgName = curIndex1 == 1 and "UIs/Rogue/bg1/bg" or "UIs/Rogue/bg2/bg"
    ResUtil:LoadBigImg(bg, bgName, false)
    openSetting = nil
end

function SetRed()
    UIUtil:SetRedPoint(txtGifts, RogueMgr:IsRed(), 35.9, 75.7, 0)
end

function Update()
    if (time > 0 and Time.time > timer) then
        timer = Time.time + 1
        time = RogueMgr:GetRogueTime()
        local timeData = TimeUtil:GetTimeTab(time)
        LanguageMgr:SetText(txtTime, 50001, timeData[1], timeData[2], timeData[3]) 
        if(time<=0) then 
            CSAPI.SetGOActive(txtTime, time > 0)
        end 
    end
end

function SetItems()
    local inAnim = false
    if (oldCurIndex == nil or oldCurIndex ~= curIndex1) then
        inAnim = true
    end
    oldCurIndex = curIndex1

    CSAPI.SetGOActive(panel1, curIndex1 == 1)
    CSAPI.SetGOActive(panel2, curIndex1 == 2)
    local datas = RogueMgr:GetDatas(curIndex1)
    local btnName = curIndex1 == 1 and "btn" or "btnT"
    local items = GetItems(curIndex1)
    for k, v in ipairs(datas) do
        local parent = this[btnName .. k]
        local item = items[k]
        local lineDetail = curIndex1 == 1 and panel1LinesPos[k] or panel2LinesPos[k]
        if (not item) then
            CSAPI.CreateGOAsync("UIs/Rogue/RogueItem", 0, 0, 0, parent, function(go)
                local lua = ComUtil.GetLuaTable(go)
                lua.Init(lineDetail)
                lua.SetClickCB(ItemClickCB2)
                lua.Refresh(v, selectID, inAnim)
                if (selectID == v:GetID()) then
                    selectItem = lua
                end
                table.insert(items, lua)
            end)
        else
            item.Refresh(v, selectID, inAnim)
            if (selectID == v:GetID()) then
                selectItem = item
            end
        end
    end
end
function ItemClickCB2(item)
    SetSelect(item, true)

    if (selectItem) then
        selectItem.Select(false)
    else
        selectItem = item
        selectItem.Select(true)
    end
    SetRight(selectItem.data:GetID(), true)
end

function SetRight(_selectID, _anim)
    selectID = _selectID
    if (not selectID) then
        return
    end
    CSAPI.SetGOActive(right, true)
    local data = RogueMgr:GetData(_selectID)
    isChallenge = RogueMgr:CheckIsChallenge(data:GetID())
    -- top
    local iconBgName = data:GetCfg().nType == 1 and "img_16_01.png" or "img_16_02.png"
    CSAPI.LoadImg(iconBg, "UIs/Rogue/" .. iconBgName, true, nil, true)
    ResUtil.RogueIcon:Load(icon, data:GetIcon(true))
    CSAPI.SetText(txtName1, data:GetCfg().name)
    CSAPI.SetText(txtName2, data:GetCfg().enName)
    -- midle
    monsters = data:GetMonsters()
    layout:IEShowList(#monsters)
    -- down
    SetDown(data, isChallenge, _anim)
    -- btns 
    CSAPI.SetGOActive(btnC, isChallenge)
    local lanID = isChallenge and 50008 or 10412
    LanguageMgr:SetText(txtS1, lanID)
    LanguageMgr:SetEnText(txtS2, lanID)
    -- _anim
    if (_anim and objDetail.activeInHierarchy) then
        if (objDetail1.activeInHierarchy) then
            UIUtil:SetObjScale(ImgDetail1, 1.5, 1, 1.5, 1, 1, 1, nil, 300, 300)
            UIUtil:SetObjFade2(ImgDetail1, 0, 1, nil, 100, 300)
        elseif (objDetail2.activeInHierarchy) then
            UIUtil:SetObjScale(ImgDetail2, 1.5, 1, 1.5, 1, 1, 1, nil, 300, 300)
            UIUtil:SetObjFade2(ImgDetail2, 0, 1, nil, 100, 300)
        end
        UIUtil:SetPObjMove(rightAnim, 900, 0, 0, 0, 0, 0, nil, 400, 1)
        UIUtil:SetObjFade(rightAnim, 0, 1, nil, 200, 1, 0)
    end
    -- 最小步数 
    LanguageMgr:SetText(txtMinSteps, 50031, data:GetMinSteps())
end

function SetDown(data, isChallenge, _anim)
    local limit = data:GetLimitRound()
    local index = data:GetRNum(isChallenge)

    CSAPI.SetGOActive(objDetail, not isChallenge)
    CSAPI.SetGOActive(objGo, isChallenge)
    -- item
    posItems = posItems or {}
    local datas = {}
    for k = 1, limit do
        table.insert(datas, k)
    end
    local num = nil
    if (_anim) then
        num = 1
    end
    ItemUtil.AddItems("Rogue/RoguePosItem", posItems, datas, Content, nil, 1, {index, num})
    --
    if (not isChallenge) then
        local _index = data:GetNum()
        CSAPI.SetGOActive(objDetail1, _index < limit)
        CSAPI.SetGOActive(objDetail2, _index >= limit)
        CSAPI.SetText(txtDetail1, _index .. "")
    end
end

function GetItems(index)
    this["items" .. index] = this["items" .. index] or {}
    return this["items" .. index]
end

function OnClickRight()
    SetSelect(selectItem, false)

    selectItem.Select(false)
    selectItem = nil
    selectID = nil
    CSAPI.SetGOActive(right, false)
end

function SetSelect(selectItem, b)
    -- selectItem 移动 
    if (not selectItem.CheckIsLeft()) then
        local x1 = b and 0 or -900
        local x2 = b and -900 or 0
        UIUtil:SetPObjMove(selectItem.gameObject, x1, x2, 0, 0, 0, 0, nil, 600, 1)
    end

    -- else item 
    local items = GetItems(curIndex1)
    local num1 = b and 1 or 1.15
    local num2 = b and 1.15 or 1
    local alpha1 = b and 1 or 0
    local alpha2 = b and 0 or 1
    local delay = 1
    if (not b and not selectItem.CheckIsLeft()) then
        delay = 400
    end
    UIUtil:SetObjScale(bg, num1, num2, num1, num2, 1, 1, nil, 400, 1)
    UIUtil:SetObjFade2(selectItem.line1, alpha1, alpha2, nil, 200, delay)
    for k, v in pairs(items) do
        if (selectItem.data:GetID() ~= v.data:GetID()) then
            UIUtil:SetObjFade2(v.gameObject, alpha1, alpha2, nil, 200, delay)
        end
    end
end

function OnClickMission()
    CSAPI.OpenView("RogueMission")
end

-- 放弃
function OnClickC()
    UIUtil:OpenDialog(LanguageMgr:GetByID(50010), function()
        FightProto:QuitRogueFight(false, 1, function()
            RogueMgr:ClearCurData()
            selectItem.Select(true)
            CSAPI.SetGOActive(right, false)
            SetRight(selectItem.data:GetID())
        end)
    end)
end

function OnClickS()
    local data = RogueMgr:GetData(selectID)
    local curData = RogueMgr:GetCurData()
    if (isChallenge) then
        local round = curData.round
        if (curData.selectBuffs == nil or not curData.selectBuffs[round]) then
            -- 未选buff，进入选buff 
            CSAPI.OpenView("RogueBuffSelect", data)
        elseif (curData.selectPos == nil or #curData.selectPos < round) then
            -- 未选怪物，进入选怪物
            CSAPI.OpenView("RogueEnemySelect", data)
        else
            -- 进入战斗
            FightProto:EnterRogueFight()
        end
    else
        -- 开始 
        if (curData) then
            -- 有其它在进行中
            LanguageMgr:ShowTips(39001)
        else
            -- 清除编队缓存
            TeamMgr:ClearFightTeamData()
            -- 进入编队 
            CSAPI.OpenView("TeamConfirm", {
                dungeonId = selectID,
                teamNum = 1,
                isNotAssist = true,
                disChoosie = true,
                rogueData = data
            }, TeamConfirmOpenType.Rogue)
        end
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    if (right.activeInHierarchy) then
        OnClickRight()
    else
        view:Close()
    end
end
