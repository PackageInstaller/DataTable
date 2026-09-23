local curIndex = nil -- 准备挑战的下标
function Awake()
    UIUtil:AddTop2("RogueTEnemySelect", topParent, function()
        view:Close()
    end, nil, {})
    scrollRect = ComUtil.GetCom(sr, "ScrollRect")
    layout = ComUtil.GetCom(hsv, "UIInfinite")
    layout:Init("UIs/RogueT/RogueTEnemySelectItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Team_Data_Update, SetTeams)
    eventMgr:AddListener(EventType.RogueT_Buff_Upgrade, SetBtn)
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
        lua.Refresh(_data, curIndex)
    end
end

function ItemClickCB()
    MoveTo(curIndex)
    SetRight()
end
function MoveTo(index)
    local pos = CSAPI.csGetAnchor(hContent)
    local x2 = 370.8 - (index - 1) * 370.8
    oldX = nil
    if (math.abs(pos[0] - x2) > 1) then
        oldX = pos[0]
        scrollRect.enabled = false
        CSAPI.SetGOActive(mask, true)
        UIUtil:SetPObjMove(hContent, pos[0], x2, 0, 0, 0, 0, function()
            CSAPI.SetGOActive(mask, false)
        end, 300, 1)
    end
end

function OnOpen()
    curData = RogueTMgr:GetFightData()
    groupCfg = Cfgs.DungeonGroup:GetByID(curData.id)

    -- starRole
    SetStarRoles()
    -- level
    SetLevels()
    -- team
    SetTeams()
    --
    SetBtn()
    --
    CSAPI.SetText(txtJF, curData.score .. "")
    --
    -- SetVlg()
    --
    SetNext()
end

function SetStarRoles()
    local roleIDs = groupCfg.roleid or {}
    local _datas = {}
    for k, v in ipairs(roleIDs) do
        local cfg = Cfgs.MonsterData:GetByID(v)
        local _data = RoleMgr:GetMaxFakeData(cfg.card_id, cfg.level)
        table.insert(_datas, _data)
    end
    items = items or {}
    ItemUtil.AddItems("RoleLittleCard/RoleSmallCard", items, _datas, roleParent, nil, 1, nil, function()
        for k, v in pairs(items) do
            v.ActiveClick(false)
            v.HideLv(false)
        end
    end)
end

function SetLevels()
    local cfgs = Cfgs.MainLine:GetGroup(groupCfg.group)
    curDatas = {}
    for k, v in pairs(cfgs) do
        if (not v.isInfinity and v.dungeonGroup == groupCfg.id) then
            table.insert(curDatas, v)
        end
    end
    if (#curDatas > 1) then
        table.sort(curDatas, function(a, b)
            return a.roundLevel < b.roundLevel
        end)
    end
    --
    curIndex = nil
    -- curData.nDuplicateID为当前要打的关卡
    if (curData.nDuplicateID) then
        for k, v in ipairs(curDatas) do
            if (v.id == curData.nDuplicateID) then
                curIndex = k
                break
            end
        end
    end
    --
    layout:IEShowList(#curDatas, FirstCB, curIndex or 1)
end

function FirstCB()
    if (not isFirst1) then
        isFirst1 = true
        --
        local indexs = layout:GetIndexs()
        local len = indexs.Length
        for i = 0, len - 1 do
            local index = indexs[i]
            local lua = layout:GetItemLua(index)
            lua.PlayIn(i)
        end
    end
end

function SetTeams()
    teamData = TeamMgr:GetTeamData(RogueTMgr:GetTeamIndex(groupCfg.hard))
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
    local _cond = TeamCondition.New()
    _cond:Init(groupCfg.teamLimted)
    CSAPI.OpenView("TeamView", {
        currentIndex = RogueTMgr:GetTeamIndex(groupCfg.hard),
        canEmpty = true,
        is2D = true,
        cond = _cond,
        -- isSkill = false,
        dungeonId = curData.nDuplicateID,
    }, TeamOpenSetting.RogueT)
end

function SetBtn()
    CSAPI.SetText(txtShop, BagMgr:GetCount(g_RogueT_Coin) .. "")
    local cfg = Cfgs.ItemInfo:GetByID(g_RogueT_Coin)
    ResUtil.IconGoods:Load(goodsIcon, cfg.icon .. "_1")
end

function SetVlg()
    local limit = groupCfg.teamLimted
    CSAPI.SetGOActive(vlg, limit ~= nil)
    if limit then
        local condition = TeamCondition.New()
        condition:Init(limit)
        local list = condition:GetDesc()
        if list and #list > 0 then
            local childCount = vlg.transform.childCount
            for i, v in ipairs(list) do
                if (i <= childCount) then
                    local _tran = vlg.transform:GetChild(i - 1)
                    CSAPI.SetGOActive(_tran.gameObject, true)
                    CSAPI.SetText(_tran.gameObject, v)
                else
                    local go = CSAPI.CloneGO(Text0, vlg.transform)
                    CSAPI.SetText(go, v)
                end
            end
            for i = #list + 1, childCount do
                CSAPI.SetGOActive(vlg.transform:GetChild(i - 1).gameObject, false)
            end
        end
    end
end

function SetRight()
    local cfg = Cfgs.MainLine:GetByID(curDatas[curIndex].id)
    local type = DungeonInfoType.RogueT
    if infoPanel == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo6", AdaptiveScreen, function(go)
            infoPanel = ComUtil.GetLuaTable(go)
            infoPanel.SetClickCB(OnClickEnter)
            infoPanel.SetClickMaskCB(OnClickBack)
            infoPanel.Show(cfg, type, function()
                infoPanel.CallFunc("Button5", "SetBtn")
                infoPanel.SetFunc("Details2", "OnClickEnemy", OnClickEnemy)
            end)
        end)
    else
        infoPanel.Show(cfg, type, function()
            infoPanel.CallFunc("Button5", "SetBtn")
        end)
    end
end

function OnClickEnemy()
    local monsters = {}
    local cfg = Cfgs.MainLine:GetByID(curDatas[curIndex].id)
    local monsterGroupCfg = Cfgs.MonsterGroup:GetByID(cfg.enemyPreview[1])
    local _monsters = monsterGroupCfg.monsters or {}
    for k, v in ipairs(monsterGroupCfg.stage) do
        for p, q in ipairs(v.monsters) do
            local monsterCfg = Cfgs.MonsterData:GetByID(q)
            table.insert(monsters, {
                id = q,
                -- level = mainLineCfg.previewLv,
                isBoss = monsterCfg.isboss == 1
            })
        end
    end
    if (#monsters > 1) then
        table.sort(monsters, function(a, b)
            if (a.isBoss ~= b.isBoss) then
                return a.isBoss
            else
                return a.id > b.id
            end
        end)
    end
    CSAPI.OpenView("FightEnemyInfo", monsters)
end

function OnClickEnter()
    local cfg = Cfgs.MainLine:GetByID(curDatas[curIndex].id)
    local dungeonCfg = Cfgs.DungeonGroup:GetByID(cfg.dungeonGroup)
    local teamData = TeamMgr:GetTeamData(RogueTMgr:GetTeamIndex(dungeonCfg.hard))
    if (teamData and teamData:GetCount() > 0) then
        local duplicateTeamDatas = TeamMgr:DuplicateTeamData(1, teamData)
        local indexList = {RogueTMgr:GetTeamIndex(dungeonCfg.hard)}
        DungeonMgr:ApplyEnter(cfg.id, indexList, {duplicateTeamDatas})
    else
        LanguageMgr:ShowTips(48001)
        -- Tips.Show("未编入队伍（策划未配置多语音）")
    end
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

function OnClickBack()
    infoPanel.Show()
    MoveBack()
end

-- 放弃
function OnClickGiveUp()
    local str = LanguageMgr:GetByID(54043, curData.score)
    UIUtil:OpenDialog(str, function()
        FightProto:RogueTQuit(function()
            view:Close()
            CSAPI.OpenView("RogueTView")
        end)
    end)
end

function OnClickBuff()
    CSAPI.OpenView("RogueTCurBuff")
end

function OnClickShop()
    CSAPI.OpenView("RogueTShopBuff")
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    if (oldX ~= nil) then
        MoveBack()
    else
        view:Close()
    end
end

-- 下一档奖励
function SetNext()
    local nextCfg = nil
    local lv2, s2, ms2 = RogueTMgr:GetScore()
    local score = curData.score + s2
    local cfgs = Cfgs.CfgRogueTPeriodReward:GetAll()
    if (score == 0) then
        nextCfg = cfgs[1]
    elseif (score > 0) then
        for k, v in ipairs(cfgs) do
            if (v.points > score) then
                nextCfg = v
                break
            end
        end
    end
    CSAPI.SetGOActive(txtNext, nextCfg ~= nil)
    if (nextCfg ~= nil) then
        local need = nextCfg.points - score
        LanguageMgr:SetText(txtNext, 49305, need)
        local id = nil
        if (nextCfg.reward) then
            id = nextCfg.reward[1][1]
        end
        CSAPI.SetGOActive(imgNext, id ~= nil)
        local goods=BagMgr:GetFakeData(id)
        if goods~=nil then
            goods:GetIconLoader():Load(imgNext, goods:GetIcon())
        end
        -- local goodsCfg = Cfgs.ItemInfo:GetByID(id)
        -- ResUtil.IconGoods:Load(imgNext, goodsCfg.icon)
    end
end
