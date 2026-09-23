local currItemL = nil
local sectionDatas = nil
local groupDatas = nil
local videoGOs = nil
local effectGos = nil
local layout1 = nil
local layout2 = nil
local currIndexL = 1
local selIndexL = 0
local currIndexR = 1
local selIndexR = 0
local currDanger = 1
local itemInfo = nil
local isRefresh = false
-- rank
local timer = 0
local resetTime = -1
local nextRefreshTime = 0
local nextTime = 0
local nextTimer = 0
local nextTimes = nil

function Awake()
    layout1 = ComUtil.GetCom(vsv, "UISV");
    layout1:Init("UIs/Trials/TrialsListItem", LayoutCallBack1, true);

    layout2 = ComUtil.GetCom(hsv, "UISV");
    layout2:Init("UIs/Trials/TrialsLevelItem", LayoutCallBack2, true);

    CSAPI.SetGOActive(animMask, false)
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Trials_List_Refresh, RefreshPanel)
    eventMgr:AddListener(EventType.Dungeon_Activity_RankInfo, OnRankInfoRet)
    eventMgr:AddListener(EventType.Mission_List, function()
        SetRed(MissionMgr:CheckRed2(sectionDatas[currIndexR]:GetTaskType(), sectionDatas[currIndexR]:GetID()))
    end)
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = sectionDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnClickItemCB1)
        lua.Refresh(_data)
        lua.SetSelect(selIndexL == index)
    end
end

function OnClickItemCB1(item)
    if selIndexL == item.index then
        return
    end
    if currItemL then
        currItemL.SetSelect(false)
    end
    currItemL = item
    currItemL.SetSelect(true)
    selIndexL = item.index
    currIndexL = item.index
    SetRItems()
    SetRight()
    SetRankInfo()
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = groupDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(OnClickItemCB2)
        lua.Refresh(_data)
        lua.SetSelect(selIndexR == index)
    end
end

function OnClickItemCB2(item)
    if selIndexR == item.index then
        return
    end
    local lua = layout2:GetItemLua(selIndexR)
    if lua then
        lua.SetSelect(false)
    end
    item.SetSelect(true)
    selIndexR = item.index
    currIndexR = item.index
    if isFirst then
        SetRight()
    end
    isFirst = true
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("TrialsListView", topObj, OnClickReturn);
end

function Update()
    UpdateTime()
end

function OnOpen()
    if data then
        InitPanel()
    end
end

function InitPanel()
    SetBGScale()
    SetDatas()
    SetJumpState()
    CheckOpenDungeon()
    SetLItems()
    SetRankInfo()
end

function RefreshPanel()
    if isRefresh then -- 防止反复刷新
        return
    end
    isRefresh = true
    SetLItems()
    FuncUtil:Call(function()
        isRefresh = false
    end, this, 50)
end

function SetDatas()
    sectionDatas = {}
    local datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.Trials, true)
    if datas and #datas > 0 then
        for i, v in ipairs(datas) do
            if v:GetCfg() and not v:GetCfg().isChain then
                table.insert(sectionDatas, v)
            end
        end
    end
    if sectionDatas and #sectionDatas > 0 then
        table.sort(sectionDatas, function(a, b)
            local isUp1, isUp2 = false, false
            local info1 = a:GetOpenInfo()
            if info1 and info1:GetUpTime(a:GetID()) > 0 then
                isUp1 = true
            end
            local info2 = b:GetOpenInfo()
            if info2 and info2:GetUpTime(b:GetID()) > 0 then
                isUp2 = true
            end
            if isUp1 == isUp2 then
                return a:GetID() < b:GetID()
            else
                return isUp1
            end
        end)
    end
end

function SetJumpState()
    if data.id and #sectionDatas > 0 then
        for i, v in ipairs(sectionDatas) do
            if data.id == v:GetID() then
                currIndexL = i
                break
            end
        end
    end
    if data.itemId then
        local groupDatas = DungeonMgr:GetDungeonGroupDatas(data.id)
        if groupDatas and #groupDatas > 0 then
            for i, v in ipairs(groupDatas) do
                local ids = v:GetDungeonGroups()
                if ids and #ids > 0 then
                    for k, id in ipairs(ids) do
                        if id == data.itemId then
                            currIndexR = i
                            if #ids > 1 then
                                currDanger = k
                            end
                            break
                        end
                    end
                end
            end
        end
    end
end

-- 检测当前最新开启的关卡
function CheckOpenDungeon()
    if data.id then
        local groupDatas = DungeonMgr:GetDungeonGroupDatas(data.id) or {}
        local currGroupData = nil
        if groupDatas and #groupDatas > 0 then
            for i, v in ipairs(groupDatas) do
                if v:IsOpen() and not v:IsPass() then
                    if openSetting and openSetting.isDungeonOver then -- 战斗结束
                        if DungeonMgr:GetCurrDungeonIsFirst() then -- 首次通关
                            DungeonMgr:SetCurrDungeonNoFirst()
                            currIndexR = i
                            break
                        end
                    elseif not data.itemId then -- 正常进入
                        currIndexR = i
                        local ids = v:GetDungeonGroups()
                        if ids and #ids > 1 then
                            for k, id in ipairs(ids) do
                                if DungeonMgr:IsDungeonOpen(id) then
                                    currDanger = k
                                end
                            end
                        end
                        break
                    end
                end
            end
        end
    end
end

function SetNextTime()
    if nextTimes == nil then
        nextTimes = {}
        if sectionDatas and sectionDatas[1] then
            local openInfo = sectionDatas[1]:GetOpenInfo()
            if openInfo and openInfo:GetCfg() then
                local infos = openInfo:GetCfg().infos
                if infos and #infos > 0 then
                    for i, v in ipairs(infos) do
                        if v.upStartTime then
                            local sTime = TimeUtil:GetTimeStampBySplit(v.upStartTime)
                            if sTime > TimeUtil:GetTime() then
                                table.insert(nextTimes, sTime)
                            end
                        end
                    end
                end
            end
            if #nextTimes > 0 then
                table.sort(nextTimes, function(a, b)
                    return a < b
                end)
            end
        end
        if #nextTimes > 0 then
            nextTime = table.remove(nextTimes, 1)
        else
            nextTime = 0
        end
    end
end

function UpdateNextTime()
    if nextTime <= 0 then
        return
    end

    if nextTimer < Time.time then
        nextTimer = Time.time + 1
        if TimeUtil:GetTime() >= nextTime then
            SetNextTime()
            RefreshPanel()
        end
    end
end

function SetRed(b)
    UIUtil:SetRedPoint(redParent, b)
end
-----------------------------------------------left-----------------------------------------------
function SetLItems()
    layout1:IEShowList(#sectionDatas, function()
        local lua = layout1:GetItemLua(currIndexL)
        if lua then
            lua.OnClick()
        end
    end, currIndexL)
end

function SetRankInfo()
    local sectionData = sectionDatas[currIndexL]
    CSAPI.SetGOActive(timeObj, false)
    resetTime = 0
    nextRefreshTime = 0
    CSAPI.SetText(txtPoints, "--")
    CSAPI.SetText(txtRank, "--")
    CSAPI.SetGOActive(rankObj, true)
    PlayerProto:GetMineRankInfo(sectionData:GetRankType())
    local openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
    CSAPI.SetGOActive(btnMission,openInfo and openInfo:GetUpTime(sectionData:GetID()) > 0)
    SetRed(MissionMgr:CheckRed2(sectionData:GetTaskType(), sectionData:GetID()))
end

function OnRankInfoRet(proto)
    if proto then
        local sectionData = sectionDatas[currIndexL]
        if not sectionData then
            return
        end
        if proto.rank_type ~= sectionData:GetRankType() then
            return
        end
        nextRefreshTime = proto.next_refresh_time
        resetTime = nextRefreshTime - TimeUtil:GetTime()
        if resetTime < 0 then -- 协议收的慢
            PlayerProto:GetMineRankInfo(sectionData:GetRankType())
            return
        end
        CSAPI.SetGOActive(timeObj, true)
        local rank = proto.rank or 0
        local score = proto.score or 0
        if rank > 0 and score > 0 then
            CSAPI.SetText(txtPoints, score .. "")
            CSAPI.SetText(txtRank, rank .. "")
        end
    end
end

function UpdateTime()
    if (resetTime > 0 and Time.time > timer) then
        timer = Time.time + 1
        resetTime = nextRefreshTime - TimeUtil:GetTime()
        local timeTab = TimeUtil:GetTimeTab(resetTime)
        local hour = timeTab[2] < 10 and "0" .. timeTab[2] or timeTab[2]
        local min = timeTab[3] < 10 and "0" .. timeTab[3] or timeTab[3]
        local second = timeTab[4] < 10 and "0" .. timeTab[4] or timeTab[4]
        CSAPI.SetText(txtTime, hour .. ":" .. min .. ":" .. second)
        if resetTime <= 0 and sectionDatas[currIndexL] then
            CSAPI.SetGOActive(timeObj, false)
            PlayerProto:GetMineRankInfo(sectionDatas[currIndexL]:GetRankType())
        end
    end
end

function OnClickRank()
    local ids = {}
    if sectionDatas and #sectionDatas > 0 then
        for i, v in ipairs(sectionDatas) do
            table.insert(ids, v:GetID())
        end
    end
    UIUtil:OpenRankView2(ids,currIndexL)
end

function OnClickMission()
    local sectionData = sectionDatas[currIndexL]
    local info = sectionData and sectionData:GetInfo() or nil
    if info and info.taskType then
        CSAPI.OpenView("MissionActivity", {
            type = info.taskType,
            group = sectionData:GetID(),
            title = LanguageMgr:GetByID(6021)
        })
    else
        LogError("章节info字段未填写taskType字段!!!" .. (sectionData and sectionData:GetID() or 0))
    end
end
-----------------------------------------------right-----------------------------------------------
function SetRItems()
    local sectionData = currItemL:GetData()
    if sectionData then
        groupDatas = DungeonMgr:GetDungeonGroupDatas(sectionData:GetID())
        if not groupDatas or #groupDatas < 1 then
            LogError("没有相关的关卡组数据！！！" .. sectionData:GetID())
            return
        end
        CheckItemOpen()
        layout2:IEShowList(#groupDatas, function()
            local lua = layout2:GetItemLua(currIndexR)
            if lua then
                lua.OnClick()
            end
        end, currIndexR)
    end
end

function CheckItemOpen()
    if #groupDatas < currIndexR then
        currIndexR = #groupDatas
    end
    if not groupDatas[currIndexR]:IsOpen() and currIndexR > 1 then
        for i = currIndexR - 1, 1, -1 do
            if groupDatas[i]:IsOpen() then
                currIndexR = i
                break
            end
        end
    end
end

function SetRight()
    SetBg()
    PlayVideo()
    PlayEffect()
    local itemR = layout2:GetItemLua(selIndexR)
    if itemR then
        ShowInfo(itemR)
    end
end

-- 背景
function SetBg()
    local groupData = groupDatas[currIndexR]
    local bgPath = groupData:GetBGPath()
    if bgPath ~= nil and bgPath ~= "" then
        ResUtil:LoadBigImg2(bg, bgPath, false)
    end
    local imgPath = groupData:GetImgPath()
    if imgPath ~= nil and imgPath ~= "" then
        ResUtil:LoadBigImg(before, imgPath, false)
    end
    CSAPI.SetGOActive(bg, groupData:GetShowType() ~= 3)
    CSAPI.SetGOActive(before, groupData:GetShowType() > 2)
end

function SetBGScale()
    local size = CSAPI.GetMainCanvasSize()
    local offset1, offset2 = size[0] / 1920, size[1] / 1080
    local offset = offset1 > offset2 and offset1 or offset2
    local child = bg.transform:GetChild(0)
    if child then
        CSAPI.SetScale(child.gameObject, offset, offset, offset)
    end
end

-- 播放背景视频
function PlayVideo()
    videoGOs = videoGOs or {}
    for i, v in pairs(videoGOs) do
        CSAPI.SetGOActive(v, false)
    end
    if not groupDatas[currIndexR] or groupDatas[currIndexR]:GetShowType() < 2 or
        not groupDatas[currIndexR]:GetVideoName() then
        return
    end

    local name = groupDatas[currIndexR]:GetVideoName()
    local goVideo = videoGOs[name]
    if not goVideo then
        goVideo = ResUtil:PlayVideo(name, videoParent);
        videoGOs[name] = goVideo.gameObject
    else
        CSAPI.SetGOActive(goVideo, true)
    end
end

function PlayEffect()
    effectGos = effectGos or {}
    for i, v in pairs(effectGos) do

        CSAPI.SetGOActive(v, false)
    end
    if groupDatas[currIndexR]:GetShowType() < 3 or not groupDatas[currIndexR]:GetEffectName() then
        return
    end

    local name = groupDatas[currIndexR]:GetEffectName()
    local goEffect = effectGos[name]
    if not goEffect then
        CSAPI.SetGOActive(animMask, true)
        ResUtil:CreateBGEffect(name, 0, 0, 0, effectObj, function(go)
            CSAPI.SetGOActive(animMask, false)
            effectGos[name] = go
        end);
    else
        CSAPI.SetGOActive(goEffect, true)
    end
end

function ShowInfo(item)
    isActive = item ~= nil;
    local cfg, type = nil, DungeonInfoType.Trials
    if item then
        cfg, type = GetCurrCfg()
    end
    if itemInfo == nil then
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo4", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            itemInfo.SetLayoutPos({-333, 440})
            CSAPI.SetRTSize(itemInfo.layout, 579, 933)
            itemInfo.Show(cfg, type, OnLoadSuccess)
        end)
    else
        itemInfo.Show(cfg, type, OnLoadSuccess)
    end
end

function OnLoadSuccess()
    local sectionData = sectionDatas[currIndexL]
    if sectionData then
        local openInfo = sectionData:GetOpenInfo()
        if openInfo and openInfo:GetUpTime(sectionData:GetID()) > 0 then
            itemInfo.SetGOActive("Title", "btnMission", true)
        else
            itemInfo.SetGOActive("Title", "btnMission", false)
        end
    else
        itemInfo.SetGOActive("Title", "btnMission", false)
    end
    itemInfo.SetFunc("Button", "OnClickEnter", OnBattleEnter)
    local itemR = layout2:GetItemLua(selIndexR)
    if itemR then
        itemInfo.CallFunc("Danger4", "ShowDangeLevel", itemR.IsDanger(), itemR.GetCfgs(), currDanger)
        itemInfo.CallFunc("Buff", "SetItems", GetIconDatas("iconHead", true), OnBuffClick)
        itemInfo.AddTeamReplace(true, OnBattleEnter)
    end
end

function OnBattleEnter()
    local openInfo = currItemL.GetData():GetOpenInfo()
    if openInfo and not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    local cfg = GetCurrCfg()
    local itemR = layout2:GetItemLua(selIndexR)
    local cfgs = itemR and itemR.GetCfgs()
    local teamOpenSetting = TeamConfirmOpenType.Dungeon
    if cfgs and #cfgs > 1 then
        cfg = cfgs[itemInfo.CallFunc("Danger4", "GetCurrDanger")]
        teamOpenSetting = TeamConfirmOpenType.Trials
    end
    if cfg and DungeonMgr:IsDungeonOpen(cfg.id) then
        CSAPI.OpenView("TeamConfirm", { -- 正常上阵
            dungeonId = cfg.id,
            teamNum = cfg.teamNum
        }, teamOpenSetting)
    else
        if currIndexR == #groupDatas then
            LanguageMgr:ShowTips(24008)
        else
            LanguageMgr:ShowTips(24002)
        end
    end
end

function GetCurrCfg(_index)
    local cfg, type = nil, nil
    local index = _index or currIndexR
    if groupDatas and groupDatas[index] then
        local ids = groupDatas[index]:GetDungeonGroups()
        if ids and #ids > 0 then
            type = #ids > 1 and DungeonInfoType.TrialsSpecial or DungeonInfoType.Trials
            cfg = Cfgs.MainLine:GetByID(ids[1])
        end
    end
    return cfg, type
end

function GetIconDatas(headName, add)
    local _datas = {}
    local cfgDungeon = GetCurrCfg()
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
    return _datas
end

function OnBuffClick()
    local datas = GetIconDatas("icon")
    if #datas > 0 then
        CSAPI.OpenView("Trials2BossBuff", datas)
    end
end

function OnClickReturn()
    view:Close()
end
---------------------------------------------anim
function PlayAnim(delay, cb)
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
        if cb then
            cb()
        end
    end, this, delay)
end

function ShowEnterAnim()
    PlayAnim(700)
    if sectionDatas and #sectionDatas > 0 then
        local index = 0
        for i, v in ipairs(sectionDatas) do
            local lua = layout1:GetItemLua(i)
            if lua then
                lua.ShowRefreshAction(index * 48)
                index = index + 1
            end
        end
    end
end
