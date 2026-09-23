local timer2 = nil -- 开放时间

function Awake()
    UIUtil:AddTop2("ExerciseRMain", gameObject, function()
        view:Close()
    end, nil, {})
    CSAPI.SetGOActive(AdaptiveScreen, false)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.ExerciseR_End, RefreshPanel) -- 赛季结束或者开放时间结束
end
function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if (timer2 and TimeUtil:GetTime() >= timer2) then
        timer2 = nil
        RefreshPanel()
    end
end

-- data : RealArmyType
function OnOpen()
    ArmyProto:FreeMatchInfo(RefreshPanel)
end

function RefreshPanel()
    CSAPI.SetGOActive(AdaptiveScreen, true)
    --
    proto = ExerciseRMgr:GetProto()
    mainCfg = ExerciseRMgr:GetMainCfg()
    curCfg = ExerciseRMgr:GetCurCfg()
    --
    SetTime()
    SetL()
    -- 打开下一级界面
    if (data) then
        if (data == RealArmyType.Freedom) then
            OnClickL()
        else
            OnClickR()
        end
        data = nil
    end
end

function SetTime()
    timer2 = nil
    b1 = ExerciseRMgr:CheckTime1()
    b2 = ExerciseRMgr:CheckTime2()
    timer2 = ExerciseRMgr:CheckEerciseRTime()
end

function SetL()
    --
    SetLMask()
    -- 次数
    --local cnt = proto.can_join_cnt or "0"
    -- local max = mainCfg and mainCfg.pvpPlayCnt or "~"
    --LanguageMgr:SetText(txtCnt, 90016, cnt)
    -- rankIcon 
    -- local rank = GCalHelp:CalFreeMatchRankLv(proto.score or 0)
    -- local rankCfg = Cfgs.CfgPvpRankLevelReward:GetByID(rank)
    -- ResUtil.ExerciseGrade:Load(grade, rankCfg.icon)
    -- sort
    local rankStr = proto.rank .. ""
    CSAPI.SetText(txtSort, rankStr)
    -- score
    local score = proto.score and proto.score .. "" or "0"
    CSAPI.SetText(txtScore, score)
    --
    SetMy()
    -- time
    local timeStr = ""
    if (b1) then
        timeStr = curCfg.showTime
    end
    CSAPI.SetText(txtTime, timeStr)
end

function SetMy()
    if (not myItem) then
        ResUtil:CreateUIGOAsync("ExerciseR/ExerciseRItem1", headParent, function(go)
            myItem = ComUtil.GetLuaTable(go)
            myItem.RefreshMySelf()
        end)
    else
        myItem.RefreshMySelf()
    end
end

function SetLMask()
    local b, str2 = false, ""
    if (b1 and b2) then
        b = true
    else
        if (b1 and not b2) then
            str2 = curCfg.battleTime
        end
        CSAPI.SetGOActive(lMask, not b)
        CSAPI.SetText(txtLMask2, str2)
        CSAPI.SetGOActive(txtLMask1, not b1)
        CSAPI.SetGOActive(txtLMask2, not b2)
    end
    CSAPI.SetGOActive(lMask, not b)
end

function OnClickL()
    if (b1 and b2) then
        CSAPI.OpenView("ExerciseRView", nil, 1)
    end
end

function OnClickR()
    CSAPI.OpenView("ExerciseRView", nil, 2)
end
