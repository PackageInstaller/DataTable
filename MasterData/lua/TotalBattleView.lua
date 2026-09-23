local layout =nil
local sectionDatas =nil
local timer = 0
local resetTime = -1
local currIndex = 1
local selIndex= 0
local itemInfo = nil
local isCreate = false
local currItem = nil
local currDanger = 1
local effectGos = nil
local currGroupData = nil
local openInfo = nil
local info = nil
local lastBGM = nil
local isLoading = false
local currId = 0
local jumpId = 0
local moveAction1,moveAction2
local isSectionOpen = false
local timeSectionData = nil

function Awake()
    layout=ComUtil.GetCom(vsv,"UISV");
    layout:Init("UIs/TotalBattle/TotalBattleItem",LayoutCallBack,true);

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Dungeon_InfoPanel_Update,OnInfoRefresh)
    eventMgr:AddListener(EventType.Activity_Open_Refresh,OnOpenInfoRefresh)
    eventMgr:AddListener(EventType.TotalBattle_Rank_Update,OnPanelRefresh)
    eventMgr:AddListener(EventType.Scene_Load_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.Mission_List, function ()
        SetRed(MissionMgr:CheckRed({eTaskType.StarPalace}))
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed)

    CSAPI.SetGOActive(timeObj,false)
    InitAnim()
end

function OnInfoRefresh(_cfg)
    SetState(_cfg)
    if itemInfo then
        local cfg = GetCfg()
        if cfg then
            local _,score = TotalBattleMgr:GetScore(cfg.group,cfg.id)
            score = score > 1 and score or "--"
            itemInfo.CallFunc("Level","SetText",score .."")
        end
    end
end

function OnOpenInfoRefresh(_id)
    if _id and openInfo and _id == openInfo:GetID() then
        RefreshPanel()
    end
end

function OnPanelRefresh()
    EventMgr.Dispatch(EventType.Net_Msg_Getted,"totalBattle_giveUp");
    RefreshPanel()
end

function OnLoadComplete()
    if openSetting and openSetting.isDungeonOver then
        if jumpId and DungeonMgr:GetCurrDungeonIsFirst() then
            DungeonMgr:SetCurrDungeonNoFirst()
            local cfg =Cfgs.MainLine:GetByID(jumpId)
            if cfg and cfg.lasChapterID and cfg.lasChapterID[1] 
            and DungeonMgr:IsDungeonOpen(cfg.lasChapterID[1]) then
                local lasCfg = Cfgs.MainLine:GetByID(cfg.lasChapterID[1])
                if lasCfg then
                    local _sectionData = DungeonMgr:GetSectionData(lasCfg.group)
                    if _sectionData then
                        LanguageMgr:ShowTips(41001,_sectionData:GetName(),cfg.chapterID)
                    end
                end
            end
        end
    end
    if isLoading then
        FuncUtil:Call(function ()
            if gameObject and info then
                lastBGM = CSAPI.PlayBGM(info.bgm, 1)
            end
        end,nil,200)
    end
end

function OnViewClosed(viewKey)
    if viewKey == "Plot" or viewKey == "ShopView" then
        FuncUtil:Call(function ()
            if gameObject and info then
                CSAPI.PlayBGM(info.bgm, 1)
            end
        end,this,200)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
    if not FightClient:IsFightting() then --不在战斗中关闭界面时重播bgm
        FuncUtil:Call(function ()
            if lastBGM ~= nil then
                CSAPI.ReplayBGM(lastBGM)
            else
                EventMgr.Dispatch(EventType.Replay_BGM, 50);
            end
        end,this,300)
    end
end

function OnInit()
    UIUtil:AddTop2("TotalBattle", topParent, OnClickBack);
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = sectionDatas[index]
        lua.SetClickCB(OnClickItemCB)
        lua.SetIndex(index)
        lua.Refresh(_data,openInfo)
        lua.SetSelect(currIndex == index)
    end
end

function OnClickItemCB(item)
    if item.index == selIndex then
        return
    end
    local lastItem = layout:GetItemLua(currIndex)
    if lastItem then
        lastItem.SetSelect(false)
    end

    item.SetSelect(true)
    currIndex = item.index
    selIndex = currIndex
    currItem = item

    SetRankTime()
    SetRank()
    SetRight()

    if currGroupData and currGroupData:GetTargetJson() then
        local info = currGroupData:GetTargetJson()[1]
        if info and info.pos and  info.scale and info.time then
            MoveToTarget(1,info.pos[1],info.pos[2],info.scale,info.time)
        end
    else
        MoveToTarget(1,0,0,1,0.5)
    end
end

function Update()
    if openInfo and not openInfo:IsOpen() then
        openInfo = nil
        LanguageMgr:ShowTips(24001)
        UIUtil:ToHome()   
    end
    if (resetTime > 0 and Time.time > timer) then
        timer = Time.time + 1
        resetTime = TotalBattleMgr:GetRankTime()
        local timeTab = TimeUtil:GetTimeTab(resetTime)
        local hour = timeTab[2] < 10 and "0" .. timeTab[2] or timeTab[2]
        local min = timeTab[3] < 10 and "0" .. timeTab[3] or timeTab[3]
        local second = timeTab[4] < 10 and "0" .. timeTab[4] or timeTab[4]
        CSAPI.SetText(txtTime,hour..":"..min..":"..second)
        if resetTime <= 0 then
            CSAPI.SetGOActive(timeObj, false)
            local isOpen = CSAPI.IsViewOpen("TotalBattleRank") 
            if not isOpen then --排行榜会推协议
                PlayerProto:GetStarPalaceInfo()
            end
        end
    end
end

function OnOpen()
    SetDatas()  
    SetDefaultBG()
    CheckTime()
    CheckOpenSection()  
    InitJumpState()
    if not isFirst then
        isFirst = true
        layout:IEShowList(#sectionDatas,OnLoadSuccess,currIndex)
    else    
        layout:UpdateList()
    end
    SetRed(MissionMgr:CheckRed({eTaskType.StarPalace}))

    if openSetting and openSetting.isDungeonOver then --战斗完返回
        isLoading = true
    end
    local sectionData = sectionDatas[currIndex]
    if sectionData then
        info = sectionData:GetInfo()
        lastBGM = CSAPI.PlayBGM(info.bgm, 1000)    
    end
end

function SetDatas()
    sectionDatas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.TotalBattle,true)
    if #sectionDatas > 0 then
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionDatas[1]:GetID())
        table.sort(sectionDatas,function (a,b)
            local isOpen1 = openInfo:IsSectionOpen(a:GetID())
            local isOpen2 = openInfo:IsSectionOpen(b:GetID())
            if isOpen1 == isOpen2 then
                return a:GetID() < b:GetID()
            else
                return isOpen1
            end
        end)    
    end
end

function SetDefaultBG()
    local cfg = openInfo:GetCfg()
    if cfg and cfg.icon then
        CSAPI.LoadImg(bg, ResUtil.bigImg .. "/UIs/DungeonActivity/TaoFa/" .. cfg.icon .. "/bg.jpg", false);
    end
end

function InitJumpState()
    if #sectionDatas > 0 and ((data and data.id) or TotalBattleMgr:IsFighting()) then
        for i, v in ipairs(sectionDatas) do
            if data and data.id then
                if v:GetID() == data.id then
                    if openInfo then --章节活动已关闭
                        local isOpen = openInfo:IsSectionOpen(v:GetID())
                        if not isOpen then
                            break
                        end
                    end
                    currIndex = i
                    if data.itemId then --具体id跳转
                        jumpId = data.itemId
                        local dungeonGroups = DungeonMgr:GetDungeonGroupDatas(v:GetID())
                        if dungeonGroups and #dungeonGroups> 0 then
                            for k, m in ipairs(dungeonGroups) do
                                local ids = m:GetDungeonGroups()
                                if ids and ids[1] and ids[1] == data.itemId then
                                    currDanger = k
                                    data.itemId = nil
                                    break
                                end
                            end
                        end
                    end
                end
            else --正在战斗中
                local groupDatas = DungeonMgr:GetDungeonGroupDatas(v:GetID())
                local fightInfo = TotalBattleMgr:GetFightInfo()
                if groupDatas and #groupDatas > 0 and fightInfo then
                    for k, m in ipairs(groupDatas) do
                        local _cfgs = m:GetDungeonCfgs()
                        if _cfgs and _cfgs[1] and fightInfo.id == _cfgs[1].id then
                            currIndex = i
                            break
                        end
                    end
                end
            end
        end
    end
end

function OnLoadSuccess()
    local lua = layout:GetItemLua(currIndex)
    if lua then
        if lua.IsOpen() then
            lua.OnClick()
        end
    end
end

function SetRed(b)
    UIUtil:SetRedPoint(redParent,b)
end

function RefreshPanel()
    SetDatas()    
    CheckOpenSection()
    layout:UpdateList()
    SetLeft()
    SetRight()
end

function CheckOpenSection()
    isSectionOpen = false
    if #sectionDatas > 0 then
        for i, v in ipairs(sectionDatas) do
            if openInfo:IsSectionOpen(v:GetID()) then
                isSectionOpen = true
                if currIndex == 0 then
                    currIndex = i
                end
                break
            end
        end
    end
    if isSectionOpen == false then
        if currItem then
            currItem.SetSelect(false)
            currItem = nil
        end
        currIndex = 0
        CSAPI.SetGOActive(before,false)
    end
    CSAPI.SetGOActive(rankObj,isSectionOpen)
    CSAPI.SetGOActive(mask,isSectionOpen)
    CSAPI.SetGOActive(infoParent,isSectionOpen)
    SetTime()
end

function CheckTime()
    local rankTime = TotalBattleMgr:GetRankTime()
    if rankTime<= 0 then
        PlayerProto:GetStarPalaceInfo()
    elseif TotalBattleMgr:IsFighting() then
        local fightTime = TotalBattleMgr:GetFightTime()
        if fightTime <= 0 then
            PlayerProto:GetStarPalaceInfo()
        end
    end
    if data and data.id then
        timeSectionData = DungeonMgr:GetSectionData(data.id)
    elseif sectionDatas and #sectionDatas> 0 then
        timeSectionData = DungeonMgr:GetSectionData(sectionDatas[1]:GetID())
    end
end

-----------------------------------------------left-----------------------------------------------
function SetLeft()
    SetRankTime()
    SetRank()
end

function SetRankTime()
    resetTime = TotalBattleMgr:GetRankTime()
    CSAPI.SetGOActive(timeObj,resetTime>0 and isSectionOpen)
end

function SetRank()
    local sectionData = sectionDatas[currIndex]
    if sectionData then
        local rank = TotalBattleMgr:GetRankInfo(sectionData:GetID())
        local score = TotalBattleMgr:GetSectionScore(sectionData:GetID())
        if rank and rank>0 and score and score > 0 then
            CSAPI.SetText(txtPoints,score .."")
            CSAPI.SetText(txtRank,rank .."")     
        else
            CSAPI.SetText(txtPoints,"--")
            CSAPI.SetText(txtRank,"--") 
        end
    end
end
-----------------------------------------------iteminfo-----------------------------------------------
function SetRight()
    if itemInfo == nil then
        if isCreate then
            return
        end
        isCreate = true
        ResUtil:CreateUIGOAsync("DungeonInfo/DungeonItemInfo4", infoParent, function(go)
            itemInfo = ComUtil.GetLuaTable(go)
            CSAPI.SetGOActive(itemInfo.gameObject, true)
            itemInfo.SetPos(true)
            itemInfo.Refresh(nil,DungeonInfoType.TotalBattle,OnLoadCallBack)
        end)
    else
        itemInfo.Refresh(nil,DungeonInfoType.TotalBattle,OnLoadCallBack)
    end
end

function OnLoadCallBack()
    itemInfo.SetFunc("Button3","OnClickEnter",OnBattleEnter)
    itemInfo.SetFunc("Button3","OnClickGiveUp",OnGiveUpClick)
    itemInfo.SetFunc("Button3","OnClickDirll",OnDirllClick)
    itemInfo.SetFunc("Button3","OnClickSweep",OnSweepClick)
    if currItem then
        currDanger = GetCurrDanger()
        itemInfo.CallFunc("Danger2","ShowDangeLevel",true,currItem.GetCfgs(),currDanger)
        local cfg = GetCfg()
        if cfg then
            local _,score = TotalBattleMgr:GetScore(cfg.group,cfg.id)
            score = score > 1 and score or "--"
            itemInfo.CallFunc("Level","SetText",score .."")
        end
    end
    itemInfo.CallFunc("Title2","SetName",LanguageMgr:GetByID(51005))
    itemInfo.CallFunc("Level","SetTitle",LanguageMgr:GetByID(51015))
end

function OnBattleEnter()
    if not IsCanEnter() then
        return
    end
    local openInfo = DungeonMgr:GetActiveOpenInfo2(sectionDatas[currIndex]:GetID())
    if openInfo and not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    local currCfgs = currItem.GetCfgs()
    currDanger = itemInfo.CallFunc("Danger2","GetCurrDanger")
    local cfg = currCfgs and currCfgs[currDanger] or nil
    if not TotalBattleMgr:IsFighting() then
        local isEnough, tipsStr = DungeonUtil.IsEnough(cfg)
        if not isEnough then
            Tips.ShowTips(tipsStr)
            return 
        end
    end
    if cfg and DungeonMgr:IsDungeonOpen(cfg.id) then
        CSAPI.OpenView("TeamConfirm", { -- 正常上阵
            dungeonId = cfg.id,
            teamNum = cfg.teamNum or 1,
            disChoosie = true,
            isNotAssist = g_ExploringIsHelp ~= true,
        }, TeamConfirmOpenType.TotalBattle)
    else
        if currDanger == #currCfgs then
            LanguageMgr:ShowTips(24008)
        else
            LanguageMgr:ShowTips(24002)
        end
    end
end

function OnSweepClick()
    if not IsCanEnter() then
        return
    end
    local openInfo = DungeonMgr:GetActiveOpenInfo2(sectionDatas[currIndex]:GetID())
    if openInfo and not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    local isSweepOpen = itemInfo.CallFunc("Button3","IsSweepOpen")
    local currCfgs = currItem.GetCfgs()
    currDanger = itemInfo.CallFunc("Danger2","GetCurrDanger")
    local cfg = currCfgs and currCfgs[currDanger] or nil
    if isSweepOpen then
        CSAPI.OpenView("SweepView",{id = cfg.id})
    else
        local sweepData = SweepMgr:GetData(cfg.id)
        if sweepData then
            Tips.ShowTips(sweepData:GetLockStr())
        else
            local _cfg = Cfgs.CfgModUpOpenType:GetByID(cfg.modUpOpenId)
            if _cfg then
                Tips.ShowTips(_cfg.sDescription)
            end
        end
    end
end

function OnDirllClick()
    local currCfgs = currItem.GetCfgs()
    currDanger = itemInfo.CallFunc("Danger2","GetCurrDanger")
    local cfg = currCfgs and currCfgs[currDanger] or nil
    if cfg and DungeonMgr:IsDungeonOpen(cfg.id) then
        currId = cfg.id
        CSAPI.OpenView("TeamConfirm", { -- 正常上阵
            dungeonId = cfg.id,
            teamNum = cfg.teamNum or 1,
            disChoosie = true,
            isNotAssist = g_ExploringIsHelp ~= true,
            isDirll = true,
            overCB = OnFightOverCB,
        }, TeamConfirmOpenType.TotalBattle)
    else
        if currDanger == #currCfgs then
            LanguageMgr:ShowTips(24008)
        else
            LanguageMgr:ShowTips(24002)
        end
    end
end

function OnFightOverCB(stage, winer, nDamage)
    if currId and currId> 0 then
        DungeonMgr:SetCurrId1(currId)
    end
    FightOverTool.OnDirllOver(stage, winer)
end

function OnGiveUpClick()
    local dialogData = {}
    dialogData.content = LanguageMgr:GetByID(51010)
    dialogData.okCallBack = function()
        EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="totalBattle_giveUp",time=1500,
        timeOutCallBack=function ()
            -- LanguageMgr:ShowTips(1014)
            Tips.ShowTips("放弃当前副本失败！！！")
        end});

        PlayerProto:GiveUpStarPalaceChallenge()
    end
    CSAPI.OpenView("Dialog", dialogData)
end

function IsCanEnter()
    if TotalBattleMgr:IsFighting() then
        local isCurrDungeonFight = itemInfo.CallFunc("Button3","IsCurrFight")
        if not isCurrDungeonFight then
            local dialogData = {}
            dialogData.content = LanguageMgr:GetByID(51010)
            dialogData.okCallBack = function()
                EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="totalBattle_giveUp",time=1500,
                timeOutCallBack=function ()
                    -- LanguageMgr:ShowTips(1014)
                    Tips.ShowTips("放弃当前副本失败！！！")
                end});

                PlayerProto:GiveUpStarPalaceChallenge()
            end
            CSAPI.OpenView("Dialog",dialogData)
            return false
        end
    end
    return true
end

function GetCurrDanger()
    if data and data.itemId then
        return currDanger
    end

    local cfgs = currItem.GetCfgs()
    if cfgs and #cfgs > 0 then
        for i, v in ipairs(cfgs) do
            if TotalBattleMgr:IsFighting() then
                local fightInfo = TotalBattleMgr:GetFightInfo()
                if fightInfo and fightInfo.id == v.id then
                    return i
                end
            elseif not DungeonMgr:IsDungeonOpen(v.id) then                
                return i>1 and i-1 or 1
            end
        end
        return #cfgs
    end
    return 1
end

function GetCfg()
    local currCfgs = currItem.GetCfgs()
    currDanger = itemInfo.CallFunc("Danger2","GetCurrDanger")
    local cfg = currCfgs and currCfgs[currDanger] or nil
    return cfg
end

-----------------------------------------------panel-----------------------------------------------

function SetState(_cfg)
    currGroupData = currItem.GetGroupData(_cfg)
    if currGroupData then
        SetBg()
        SetEffect()
        SetEffectScale()
    end
end

-- 背景
function SetBg()
    local bgPath = currGroupData:GetBGPath()
    if bgPath ~= nil and bgPath ~= "" then
        ResUtil:LoadBigImg2(bg, bgPath,false)
    end
    local imgPath = currGroupData:GetImgPath()
    if imgPath ~= nil and imgPath ~= "" then
        ResUtil:LoadBigImg(before, imgPath, false)
    end
    CSAPI.SetGOActive(bg,currGroupData:GetShowType() ~= 3 and currGroupData:GetShowType() ~= 2)
    CSAPI.SetGOActive(before,currGroupData:GetShowType() > 2 and currGroupData:GetShowType() ~= 4)

    -- local iconName = currGroupData:GetIcon()
    -- if iconName~=nil and iconName~="" then
    --     ResUtil.DungeonTaoFa:Load(icon,iconName)
    -- end
end

function SetTime()
    if timeSectionData then
        local timeStr =""
        local openInfo = DungeonMgr:GetActiveOpenInfo2(timeSectionData:GetID())
        if openInfo then
            if openInfo:IsDungeonOpen() then
                local strs = openInfo:GetTimeStrs()
                timeStr =LanguageMgr:GetByID(22046) .. strs[1] .. " " .. strs[2] .. " - " .. strs[3] .. " " .. strs[4]
            else    
                timeStr = openInfo:GetCloseTimeStr()
            end
        end
        CSAPI.SetText(txtTime2,timeStr)
    end
end

function SetEffect()
    effectGos = effectGos or {}
    for i, v in pairs(effectGos) do
        CSAPI.SetGOActive(v, false)
    end
    if currGroupData:GetShowType() < 3 or not currGroupData:GetEffectName() then
        return
    end

    local name = currGroupData:GetEffectName()
    local goEffect = effectGos[name]
    if not goEffect then
        ResUtil:CreateBGEffect(name, 0,0,0,effectParent,function (go)
            effectGos[name] = go
        end);
    else
        CSAPI.SetGOActive(goEffect, true)
    end
end

function SetEffectScale()
    local size = CSAPI.GetMainCanvasSize()
    local offset1,offset2 = size[0] / 1920,size[1] / 1080
    local offset = offset1>offset2 and offset1 or offset2
    CSAPI.SetScale(effectParent,offset,offset,offset)
end

function OnClickRank()
    local ids = {}
    if sectionDatas and #sectionDatas > 0 then
        for i, v in ipairs(sectionDatas) do
            table.insert(ids, v:GetID())
        end
    end
    UIUtil:OpenRankView2(ids,currIndex)
end

function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.StarPalace,
        title = LanguageMgr:GetByID(6021)
    })
end

function OnClickShop()
    CSAPI.OpenView("ShopView",openInfo:GetShopID())
end

function OnClickBack()
    view:Close()
end

-----------------------------------------------anim-----------------------------------------------
function InitAnim()
    moveAction1 = ComUtil.GetCom(bgMove1, "ActionMoveByCurve")
    moveAction2 = ComUtil.GetCom(bgMove2, "ActionMoveByCurve")

    CSAPI.SetGOActive(animMask,false)
end

function PlayAnim(time)
    time = time or 0
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(animMask, false)
    end, this, time)
end

function MoveToTarget(index, x, y, scale, time, callBack)
    PlayAnim(time * 1000)
    x = x or 0
    y = y or 0
    CSAPI.SetAnchor(localObj, x, y)
    x, y = CSAPI.GetLocalPos(localObj)
    scale = scale or 1
    time = time or 0.2
    -- CSAPI.SetScale(bgObj,scale,scale)
    ScaleTo(scale, time)
    MoveToTargetByAnim(index, x, y, time, callBack)
end

function ScaleTo(scale, time)
    CSAPI.SetUIScaleTo(bgObj, nil, scale, scale, scale, nil, time)
end

function MoveToTargetByAnim(index, x, y, time, callBack)
    local moveAction = index == 1 and moveAction1 or moveAction2
    local _x, _y = CSAPI.GetLocalPos(bgObj)
    moveAction.startPos = UnityEngine.Vector3(_x, _y, 0)
    moveAction.targetPos = UnityEngine.Vector3(x, y, 0)
    moveAction.time = time * 1000
    moveAction:Play(callBack)
end