local layout1 = nil
local layout2 = nil
local cfgDungeon = nil
local curDatas = nil
local teamNum = 1
local isCheckCard = false -- 检测有无对应卡牌
local enterViewFunc = nil
local isShowFormation = false
local defaultDatas = nil
local teamPreset = nil
local isShowPreset = false
local curData = nil
local currIndex = 1
local co = nil

function Awake()
    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/DungeonTeamReplace/DungeonTeamReplaceItem1", LayoutCallBack1, true)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/DungeonTeamReplace/DungeonTeamReplaceItem2", LayoutCallBack2, true)

    CSAPI.SetGOActive(formationObj, false)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.Dungeon_TeamReplace_View_Refresh, RefreshPanel)
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.SetClickCB2(OnItemClickCB2)
        lua.Refresh(_data, isCheckCard)
    end
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnItemClickCB)
        lua.SetClickCB2(OnItemClickCB2)
        lua.Refresh(_data, isCheckCard)
    end
end

function OnItemClickCB(item)
    curData = item.data
    local isReplaceAll = true
    if curData then
        for i, teamData in ipairs(curData) do
            for k, teamItemData in ipairs(teamData.data) do
                -- 检测玩家是否拥有对应卡牌
                if not RoleMgr:IsLeader(teamItemData:GetCardCfgID()) and not RoleMgr:IsExtraLeader(teamItemData:GetCardCfgID()) and RoleMgr:GetData(teamItemData:GetCardCfgID()) ==
                    nil then
                    isReplaceAll = false
                    break
                end
            end
            if isReplaceAll then -- 检测有没有对应战术
                if not teamData.skillGroupID or teamData.skillGroupID == 0 then
                    isReplaceAll = false
                else
                    local _data = TacticsMgr:GetDataByID(teamData.skillGroupID)
                    if _data == nil then
                        isReplaceAll = false
                    end
                end
            end
        end
    end
    local saveFunc = function()
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(61002)
        dialogData.okCallBack = ShowPrefab
        dialogData.cancelCallBack = OnBattleEnter
        CSAPI.OpenView("Dialog", dialogData)
    end
    local dialogData = {}
    dialogData.content = teamNum > 1 and LanguageMgr:GetTips(61004) or LanguageMgr:GetTips(61001)
    if not isReplaceAll then
        dialogData.content = LanguageMgr:GetTips(61003)
    end
    dialogData.okCallBack = teamNum > 1 and OnBattleEnter or saveFunc
    CSAPI.OpenView("Dialog", dialogData)
end

function ShowPrefab()
    local info = FileUtil.LoadByPath("config" .. cfgDungeon.id .. ".txt")
    if info and info[1] and info[1].order and info[1].order ~= -1 then
        TeamMgr.currentIndex = info[1].order
    else
        TeamMgr.currentIndex = 1
    end
    if teamPreset == nil then
        ResUtil:CreateUIGOAsync("FormatPreset/TeamPreset", gameObject, function(go)
            teamPreset = ComUtil.GetLuaTable(go);
            teamPreset.SetCloseCB(OnBattleEnter)
            teamPreset.SetButtonState(true)
        end);
    else
        CSAPI.SetGOActive(teamPreset.gameObject, true);
    end
end

function OnBattleEnter()
    if not curData then
        return
    end
    local localCfg = FileUtil.LoadByPath("config" .. cfgDungeon.id .. ".txt");
    local teamIndex1 = 1
    local teamIndex2 = 2
    if localCfg then
        teamIndex1 = (localCfg[1] and localCfg[1].order and localCfg[1].order ~= -1) and localCfg[1].order or 1
        teamIndex2 = (localCfg[2] and localCfg[2].order and localCfg[2].order ~= -1) and localCfg[2].order or 2
    end

    if teamNum > 1 then
        ReplaceTeamData(teamIndex2, curData[2])
        TeamMgr:SaveEditTeam()
    end
    ReplaceTeamData(teamIndex1, curData[1])
    TeamMgr:SaveEditTeam(enterViewFunc)
    view:Close()
end

function ReplaceTeamData(teamIndex, teamData)
    local editTeamData = TeamMgr:GetEditTeam(teamIndex)
    editTeamData:ClearCard()
    if teamData and teamData.data then
        local cardInfos = {}
        for i, v in ipairs(teamData.data) do
            if v.index ~= 6 then -- 助战不替换
                if RoleMgr:IsLeader(v.card_info.cfgid) then -- 总队长特殊处理
                    local myLeaderCard = RoleMgr:GetLeader2()
                    if myLeaderCard:GetCfgID() ~= v.card_info.cfgid then
                        v.cid = myLeaderCard:GetID()
                    end
                    local new = GetNewInfo(v)
                    new.card_info = nil -- 剔除卡牌信息
                    table.insert(cardInfos, new)
                    -- editTeamData:AddCard(new)
                elseif RoleMgr:IsExtraLeader(v.card_info.cfgid) then
                    local myLeaderCard = RoleMgr:GetExtraLeader()
                    if myLeaderCard:GetCfgID() ~= v.card_info.cfgid then
                        v.cid = myLeaderCard:GetID()
                    end
                    local new = GetNewInfo(v)
                    new.card_info = nil -- 剔除卡牌信息
                    table.insert(cardInfos, new)
                else
                    local _card = RoleMgr:GetData(v.card_info.cfgid)
                    if _card ~= nil then -- 不存则直接剔除数据
                        local new = GetNewInfo(v)
                        new.card_info = nil -- 剔除卡牌信息
                        table.insert(cardInfos, new)
                        -- editTeamData:AddCard(new)
                    end
                end
            end
        end
        if #cardInfos > 0 then
            for i, v in ipairs(cardInfos) do
                if i == 1 and v.index ~= 1 then
                    v.index = 1
                end
                editTeamData:AddCard(v)
            end
        end

        local tacticsData = TacticsMgr:GetDataByID(teamData.skillGroupID)
        if tacticsData ~= nil then
            editTeamData.skillGroupID = teamData.skillGroupID
        else
            editTeamData.skillGroupID = 0
        end
    end
end

function GetNewInfo(info)
    local newInfo = {}
    for k, v in pairs(info) do
        newInfo[k] = v
    end
    return newInfo
end

function OnItemClickCB2(teamData)
    isShowFormation = true
    CSAPI.SetGOActive(formationObj, true)
    local isAddtive = false -- 光环加成
    local isTween = true -- 入场动画
    local isShowInfos = false -- 是否显示卡牌hp/sp信息
    if formationView then
        formationView.CleanCard();
        formationView.Init(teamData, false, false, nil, isAddtive, infoNode, isShowInfos);
        formationView.SetLock(true);
    else
        ResUtil:CreateUIGOAsync("Formation/FormationView2DTeamReplace", formationParent, function(go)
            formationView = ComUtil.GetLuaTable(go);
            -- CSAPI.SetLocalPos(formationView.gameObject,-400,-20);
            formationView.SetForceMove(nil, nil, nil);
            formationView.SetHaloEnable(false); -- 光环
            formationView.Init(teamData, false, isTween, nil, isAddtive, infoNode, isShowInfos);
            formationView.SetLock(true);
        end)
    end
end

function OnViewOpened(key)
    if key == "RoleInfo" then
        CSAPI.SetAnchor(gameObject, 10000, 0)
    end
end

function OnViewClosed(key)
    if key == "RoleInfo" then
        CSAPI.SetAnchor(gameObject, 0, 0)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
    -- co
    if co and coroutine.status(co) ~= "dead" and coroutine.close then
        coroutine.close(co)
        co = nil
    end
end

function OnOpen()
    cfgDungeon = Cfgs.MainLine:GetByID(openSetting and openSetting.id)
    enterViewFunc = openSetting and openSetting.callBack
    local info = FileUtil.LoadByPath("teamReplaceCardCheck.txt") or {}
    isCheckCard = info.isCheckCard == 1
    if cfgDungeon then
        InitPanel()
    end
end

function InitPanel()
    teamNum = cfgDungeon.teamNum or 1
    SetName()
    defaultDatas = DungeonUtil.GetTeamReplaceInfos(openSetting and openSetting.id)
    curDatas = DungeonTeamReplaceMgr:GetTeamDatas(cfgDungeon.id)
    if curDatas == nil then
        curDatas = {}
        PushDefaultData()
        RefreshPanel()
        InitData()
    else
        Play()
    end
    -- Log(string.format("=============显示阵容数据（共有%s条，其中默认配置%s条）=============",#curDatas,(num > #defaultDatas and #defaultDatas or num)))
    -- for i, v in ipairs(curDatas) do
    --     Log(table.tostring(v))
    -- end
    -- Log("=============显示阵容数据结束=============")
end

function InitData()
    local json = DungeonTeamReplaceMgr:GetTeamReplaceInfo(cfgDungeon.id)
    local func = nil
    if json == nil then
        local url = DungeonTeamReplaceMgr:GetTeamReplaceUrl(cfgDungeon.id)
        DungeonTeamReplaceMgr:RequestData(url, function(_json)
            if _json then
                DungeonTeamReplaceMgr:SetTeamReplaceInfo(cfgDungeon.id, _json)
                curDatas = GetTeamDatas(_json)
                Play()
            end
        end)
    else
        curDatas = GetTeamDatas(json)
        Play()
    end
end

function Play()
    -- co = coroutine.create(function ()
    SetData()
    EventMgr.Dispatch(EventType.Dungeon_TeamReplace_View_Refresh)
    -- end)
    -- coroutine.resume(co)
end

function SetData()
    PushDefaultData()
    if #curDatas > 0 then
        table.sort(curDatas, function(a, b)
            local power1, power2 = 0, 0
            if teamNum > 1 then
                for i = 1, 2 do
                    -- power1 = a[i] and power1 + a[i]:GetTeamStrength() + a[i]:GetHaloStrength() or power1
                    -- power2 = b[i] and power2 + b[i]:GetTeamStrength() + b[i]:GetHaloStrength() or power2
                    power1 = a[i] and power1 + a[i]:GetTeamStrength() or power1
                    power2 = b[i] and power2 + b[i]:GetTeamStrength() or power2
                end
            else
                -- power1 = a[1]:GetTeamStrength() + a[1]:GetHaloStrength()
                -- power2 = b[1]:GetTeamStrength() + b[1]:GetHaloStrength()
                power1 = a[1]:GetTeamStrength()
                power2 = b[1]:GetTeamStrength()
            end
            return power1 < power2
        end)
    end
    if #curDatas > 0 then
        DungeonTeamReplaceMgr:SaveTeamDatas(cfgDungeon.id, curDatas)
    end
end

function PushDefaultData()
    local num = 10 - #curDatas
    if #curDatas < 10 and #defaultDatas > 0 then -- 填充
        local uids = {}
        for i, v in ipairs(curDatas) do
            if v[1].uid then
                uids[v[1].uid] = 1
            end
        end
        for i = 1, 10 - #curDatas do
            -- 已有uid不填充
            if defaultDatas[i] and defaultDatas[i][1].uid and uids[defaultDatas[i][1].uid] == nil then
                table.insert(curDatas, defaultDatas[i])
            end
        end
    end
end

function SetName()
    CSAPI.SetText(txtName, cfgDungeon.name)
end

function RefreshPanel()
    SetItems()
    SetCheck()
end

function SetItems()
    CSAPI.SetGOActive(vsv1, teamNum == 1)
    CSAPI.SetGOActive(vsv2, teamNum ~= 1)
    if teamNum == 1 then
        layout1:IEShowList(#curDatas)
    else
        layout2:IEShowList(#curDatas)
    end
end

function SetCheck()
    CSAPI.SetGOActive(check1, not isCheckCard)
    CSAPI.SetGOActive(check2, isCheckCard)
end

function OnClickCheck()
    isCheckCard = not isCheckCard
    RefreshPanel()
    FileUtil.SaveToFile("teamReplaceCardCheck.txt", {
        isCheckCard = isCheckCard and 1 or 0
    })
end

function OnClickClose()
    if isShowFormation then
        CSAPI.SetGOActive(formationObj, false)
        isShowFormation = false
        return
    end
    view:Close()
end

function GetTeamDatas(json)
    local datas = {}
    if json and type(json) == "table" then
        local strList = {}
        for i, str in pairs(json) do
            if type(str) == "string" then
                local _json = Json.decode(tostring(str))
                if type(_json) == "table" then
                    local _datas = {}
                    for _, m in ipairs(_json) do
                        if m.data then
                            local teamData = DungeonUtil.GetTeamData(m)
                            teamData.uid = m.uid
                            table.insert(_datas, teamData)
                        end
                    end
                    if #_datas > 0 then
                        table.insert(datas, _datas)
                    end
                end
            end
        end
    end
    return datas
end
