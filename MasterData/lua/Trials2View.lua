local layout = nil
local leftDatas = nil
local curDatas = nil
local sectionData = nil
local openInfo = nil
local currDanger = 1
local curGroupCfg = nil
local itemInfo = nil
local time, timer, homeTime = 0, 0, 0

function Awake()
    layout = ComUtil.GetCom(vsv, "UISV");
    layout:Init("UIs/Trials2/Trials2Item", LayoutCallBack, true);

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Dungeon_InfoPanel_Update, OnPanelUpdate)
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetRed)
    eventMgr:AddListener(EventType.Trials2_Panel_Refresh, RefreshPanel)

    CSAPI.SetGOActive(animMask, false)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = leftDatas[index]
        lua.SetClickCB(OnItemClickCB)
        lua.Refresh(_data)
    end
end

function OnItemClickCB(item)
    local monsters = item.GetMonsters()
    CSAPI.OpenView("FightEnemyInfo", monsters)
end

function OnPanelUpdate(_cfg)
    if curDatas and _cfg then
        for i, v in ipairs(curDatas) do
            if _cfg.id == v.id then
                currDanger = i
                curGroupCfg = v
                break
            end
        end
    end
    curGroupCfg = curDatas[currDanger]
    SetButtonLock()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("Trials2", topObj, OnClickReturn);
end

function Update()
    if timer < Time.time then
        timer = Time.time + 1
        if time > 0 then
            time = TrialsMgr:GetMissionEndTime() - TimeUtil:GetTime()
            if time <= 0 then
                SetMissionTime()
            end
        end
        if homeTime > 0 then
            homeTime = TrialsMgr:GetEndTime() - TimeUtil:GetTime()
            if homeTime <= 0 then
                UIUtil:ToHome()
            end
        end
    end
end

function OnOpen()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        openInfo = sectionData:GetOpenInfo()
        RefreshPanel()
        homeTime = TrialsMgr:GetEndTime() - TimeUtil:GetTime()
        if homeTime <= 0 then
            UIUtil:ToHome()
        end
    end
end

function RefreshPanel()
    SetLeft()
    SetRight()
end

function SetLeft()
    SetDatas()
    SetItems()
    SetMissionTime()
    SetRed()
    SetTopScore()
end

function SetRed()
    local info = sectionData:GetInfo()
    UIUtil:SetRedPoint(redParent, MissionMgr:CheckRed2(info.taskType, sectionData:GetID()))
end

function SetDatas()
    curDatas = {}
    local cfgGroups = Cfgs.DungeonGroup:GetGroup(sectionData:GetID())
    if cfgGroups then
        for k, cfg in pairs(cfgGroups) do
            table.insert(curDatas, cfg)
        end
    end
    if #curDatas > 0 then
        table.sort(curDatas, function(a, b)
            return a.id < b.id
        end)
    end
    curGroupCfg = curDatas[currDanger]

    leftDatas = {}
    if curDatas and curDatas[1] and curDatas[1].dungeonGroups then
        for k, v in ipairs(curDatas[1].dungeonGroups) do
            table.insert(leftDatas, Cfgs.MainLine:GetByID(v))
        end
    end

    local jumpID = TrialsMgr:IsFighting() and TrialsMgr:GetFightId() or data.groupId
    if jumpID then
        for i, v in ipairs(curDatas) do
            if v.id == jumpID then
                jumpID = nil
                currDanger = i
                break
            end
        end
    end
    data.groupId = nil
end

function SetItems()
    layout:IEShowList(#leftDatas)
end

function SetMissionTime()
    time = TrialsMgr:GetMissionEndTime() - TimeUtil:GetTime()
    CSAPI.SetGOActive(limit, time > 0)
    CSAPI.LoadImg(btnMission, "UIs/Trials2/" .. (time > 0 and "btn_02_02" or "btn_02_03") .. ".png", true, nil, true)
end

function SetTopScore()
    CSAPI.SetText(txtTopScore, TrialsMgr:GetMaxScore() .. "")
end

function SetRight()
    ShowInfo()
end

function ShowInfo()
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("Trials2/DungeonItemInfo", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.Show(1, DungeonInfoType.Trials2, OnLoadCallBack)
        end)
    else
        itemInfo.Show(1, DungeonInfoType.Trials2, OnLoadCallBack)
    end
end

function OnLoadCallBack()
    if curGroupCfg then
        itemInfo.CallFunc("Title", "SetName", curGroupCfg.name)
        itemInfo.CallFunc("Score", "SetScore", LanguageMgr:GetByID(37074, LanguageMgr:GetByID(curGroupCfg.scoreBonus)),
            curGroupCfg.point)
        itemInfo.CallFunc("Buff", "SetItems", GetIconDatas("iconHead", true), OnBuffClick)
        itemInfo.SetFunc("Details", "OnClickEnemy", OnEnemyClick)
        itemInfo.SetFunc("Button", "OnClickEnter", OnBattleEnter)
    end
    itemInfo.CallFunc("Danger", "ShowDangeLevel", true, curDatas, currDanger)
    itemInfo.SetGOActive("Danger", "node", not TrialsMgr:IsFighting())
    itemInfo.SetGOActive("Danger", "empty", TrialsMgr:IsFighting())
    if TrialsMgr:IsFighting() then
        itemInfo.CallFunc("Danger", "SetEmptyStr", LanguageMgr:GetByID(37096))
    end
    SetInfoItemPos()
end

function GetIconDatas(headName, add)
    local _datas = {}
    if curGroupCfg.dungeonGroups then
        local cfgDungeon = nil
        for i, v in ipairs(curGroupCfg.dungeonGroups) do
            cfgDungeon = Cfgs.MainLine:GetByID(v)
            if cfgDungeon and cfgDungeon[headName] and cfgDungeon.entry then
                for k, m in ipairs(cfgDungeon.entry) do
                    local cfgBuff = Cfgs.CfgBossBuffChain:GetByID(m)
                    if cfgBuff and cfgBuff.icon then
                        table.insert(_datas, {
                            icon1 = cfgBuff.icon,
                            icon2 = cfgDungeon[headName] .. (add and "_N" or ""),
                            buffId = m,
                            dungeonId = cfgDungeon.id
                        })
                    end
                end
            end
        end
    end
    return _datas
end

function OnBuffClick()
    local datas = GetIconDatas("icon")
    if #datas > 0 then
        CSAPI.OpenView("Trials2BossBuff", datas)
    end
end

function OnEnemyClick()
    if curGroupCfg then
        local cfgDungeons = {}
        if curGroupCfg.dungeonGroups then
            for i, v in ipairs(curGroupCfg.dungeonGroups) do
                table.insert(cfgDungeons, Cfgs.MainLine:GetByID(v))
            end
        end
        if #cfgDungeons > 0 then
            table.sort(cfgDungeons, function(a, b)
                return a.id < b.id
            end)
        end
        local list = {};
        if #cfgDungeons > 0 then
            local cfgCard = nil
            for _, _cfg in ipairs(cfgDungeons) do
                if _cfg.enemyPreview then
                    for k, v in ipairs(_cfg.enemyPreview) do
                        table.insert(list, {
                            id = v,
                            isBoss = k == 1
                        });
                    end
                end
            end
        end
        CSAPI.OpenView("FightEnemyInfo", list);
    end
end

function OnBattleEnter()
    if not openInfo or not openInfo:IsOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    if curGroupCfg then
        CSAPI.OpenView("Trials2Team", curGroupCfg.id)
    end
end

function SetInfoItemPos()
    itemInfo.SetPanelPos("Title", 0, 412)
    itemInfo.SetPanelPos("Buff", 0, 209)
    itemInfo.SetPanelPos("Score", 0, -55)
    itemInfo.SetPanelPos("Danger", 0, -80)
    itemInfo.SetPanelPos("Details", 0, -258)
    itemInfo.SetPanelPos("Button", -17, -432)
end

function SetButtonLock()
    if itemInfo then
        local isOpen = (curGroupCfg.lockScore or 0) <= TrialsMgr:GetMaxScore()
        itemInfo.SetGOActive("Button", "btnEnter", isOpen)
        itemInfo.SetGOActive("Button", "lockObj", not isOpen)
        if not isOpen then
            LanguageMgr:SetText(itemInfo.GetPanelObj("Button", "txt_lock").gameObject, 37090,
                (curGroupCfg.lockScore or 0))
        end
        LanguageMgr:SetText(itemInfo.GetPanelObj("Button", "txt_enter").gameObject,
            TrialsMgr:IsFighting() and 37097 or 15003)
    end
end

function OnClickRank()
    if sectionData then
        UIUtil:OpenRankView(sectionData:GetRankView(), sectionData:GetRankListInfo())
    end
end

function OnClickMission()
    if time <= 0 then
        LanguageMgr:ShowTips(76001)
        return
    end
    local info = sectionData:GetInfo()
    CSAPI.OpenView("MissionScore", {
        type = info.taskType,
        group = sectionData:GetID(),
        time = TrialsMgr:GetMissionEndTime(),
        isGetAll = true
    })
end

function OnClickShop()
    JumpMgr:Jump(openInfo:GetJumpID())
end

function OnClickReturn()
    view:Close()
end
