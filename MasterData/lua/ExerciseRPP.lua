local isFind = false -- 已匹配到
local isFinding = false -- 匹配中
-- local lIsReady = false -- 是否已准备
-- local rIsReady = false
local askData = nil -- 邀请或匹配成功的数据
local teamIndex = 1
local pvpMatchTime = nil -- 匹配时长
local timer = nil
local isStart = false

function Awake()
    timeBase = TimeBase.New()
    canvasGroup = ComUtil.GetCom(btnMiddle, "CanvasGroup")

    cardIconItemL = RoleTool.AddRole(iconLParent, nil, nil, false)
    mulIconItemL = RoleTool.AddMulRole(iconLParent, nil, nil, false)
    cardIconItemR = RoleTool.AddRole(iconRParent, nil, nil, false)
    mulIconItemR = RoleTool.AddMulRole(iconRParent, nil, nil, false)
end

function OnInit()
    eventMgr = ViewEvent.New()
    -- 准备-- 改，开始了
    eventMgr:AddListener(EventType.Exercise_Ready, function()
        isStart = true
    end)
    -- 邀请或匹配成功
    eventMgr:AddListener(EventType.Exercise_Pp_Success, function(_data)
        InitData(_data)
    end)
    -- 对方退出
    eventMgr:AddListener(EventType.Exercise_Army_Out, function()
        view:Close()
    end)
    -- 好友拒绝
    eventMgr:AddListener(EventType.Exercise_Yq_Refuse, function(_data)
        FuncUtil:Call(function()
            LanguageMgr:ShowTips(33022)
        end, nil, 100)
        view:Close()
    end)
    eventMgr:AddListener(EventType.ExerciseR_End, function()
        if(openSetting and openSetting == RealArmyType.Freedom)then 
            view:Close()
        end 
    end)
end

function Update()
    timeBase:Update()
end

function OnDestroy()
    eventMgr:ClearListener()
    -- 开始了
    if (isStart) then
        return
    end
    -- 中断开战
    if (isFind) then
        ArmyProto:QuitArmy()
    end
    -- 取消找
    if (openSetting == RealArmyType.Freedom) then
        ArmyProto:QuitFreeArmy() -- 取消自由匹配
    else
        ExerciseFriendTool:CancelAllInvite() -- 取消对好友的邀请
    end
end

-- data 不为空:被邀请进来的
function OnOpen()
    SetTeamIndex()
    InitData(data)
end

function SetTeamIndex()
    teamIndex = 1
    local _teamIndex = PlayerPrefs.GetInt(PlayerClient:GetID() .. "_exercoserpp_" .. openSetting)
    if (_teamIndex and _teamIndex > 0) then
        teamIndex = _teamIndex
    end
end

function InitData(_data)
    local nType = openSetting == RealArmyType.Freedom and eTeamType.PVP or eTeamType.PVPFriend
    myData = ExerciseFriendTool:GetMyData(nType)
    --
    askData = _data
    if (askData) then
        enemyData = ExerciseFriendTool:GetArmyData(askData.type, askData.uid)
        isFind = true
        isFinding = false
        -- lIsReady = false
    else
        isFind = false
        isFinding = true
        -- lIsReady = false
        -- rIsReady = false
    end
    RefreshPanel()
end

function RefreshPanel()
    SetMy()
    SetEnemy()
    SetMiddle()
end

-- 自己 
function SetMy()
    -- 立绘
    SetIconL()
    -- 
    if (not myRankItem) then
        ResUtil:CreateUIGOAsync("ExerciseR/ExerciseRItem1", detailParentL, function(go)
            myRankItem = ComUtil.GetLuaTable(go)
            myRankItem.RefreshMySelf()
        end)
    end
    --
    SetMyTeams()
end

function SetMyTeams()
    lTeamGrids = lTeamGrids or {}
    ItemUtil.AddItems("ExerciseR/ExerciseRPPTeamList", lTeamGrids, myData.teams, teamGridL, ItemSelectCB, 1,
        {true, teamIndex})
end

function SetIconL()
    local icon_id, live2d = myData.role_panel_id, myData.live2d
    local arr = CSAPI.GetMainCanvasSize()
    local width = arr.x / 4
    CSAPI.SetAnchor(iconLParent, -width, 0, 0)
    if (icon_id < 10000) then
        mulIconItemL.Refresh(icon_id, LoadImgType.Main, nil, live2d)
        mulIconItemL.SetLiveBroadcast()
    else
        cardIconItemL.Refresh(icon_id, LoadImgType.Main, nil, live2d)
        cardIconItemL.SetLiveBroadcast()
    end
    -- RoleTool.LoadImgByID(imgL, icon_id, LoadImgType.Main)
    -- 
    -- mbL
    -- local mbName =  myData.rank < 4 and "img_08_0" ..  data.rank or "img_08_04"
    -- CSAPI.LoadImg(mbL, "UIs/ExerciseR/" .. mbName .. ".png", false, nil, true)
end

function ItemSelectCB(index)
    teamIndex = index
    PlayerPrefs.SetInt(PlayerClient:GetID() .. "_exercoserpp_" .. openSetting, teamIndex)
    SetMyTeams()
end

function SetEnemy()
    CSAPI.SetGOActive(R, isFind)
    if (isFind) then
        -- 立绘
        SetIconR()
        -- 
        if (not enemyRankItem) then
            ResUtil:CreateUIGOAsync("ExerciseR/ExerciseRItem1", detailParentR, function(go)
                enemyRankItem = ComUtil.GetLuaTable(go)
                enemyRankItem.Refresh(enemyData)
            end)
        end
        --
        rTeamGrids = rTeamGrids or {}
        ItemUtil.AddItems("ExerciseR/ExerciseRPPTeamList", rTeamGrids, enemyData.teams, teamGridR, nil, 1, {false})
    end
end

function SetIconR(icon_id)
    local icon_id, live2d = enemyData.role_panel_id, enemyData.live2d
    local arr = CSAPI.GetMainCanvasSize()
    local width = arr.x / 4
    CSAPI.SetAnchor(iconRParent, width, 0, 0)
    if (icon_id < 10000) then
        mulIconItemR.Refresh(icon_id, LoadImgType.Main, nil, live2d)
        mulIconItemR.SetLiveBroadcast()
    else
        cardIconItemR.Refresh(icon_id, LoadImgType.Main, nil, live2d)
        cardIconItemR.SetLiveBroadcast()
    end
    -- RoleTool.LoadImgByID(imgR, icon_id, LoadImgType.Main)
    -- mbR
    -- local mbName =  myData.rank < 4 and "img_08_0" ..  data.rank or "img_08_04"
    -- CSAPI.LoadImg(mbR, "UIs/ExerciseR/" .. mbName .. ".png", false, nil, true)
end

function SetMiddle()
    CSAPI.SetGOActive(tips1, not isFind)
    CSAPI.SetGOActive(tips2, isFind)
    if (isFind) then
        -- 等待开战
        timeBase:Run(askData.auto_start_time, SetTime1)
        CSAPI.SetText(txtTips2, "VS")
    elseif (isFinding) then
        -- 匹配中
        if (not pvpMatchTime) then
            pvpMatchTime = TimeUtil:GetTime() + ExerciseRMgr:GetPPTimer()
        end
        timeBase:Run(pvpMatchTime, SetTime2)
        local lanID = openSetting == RealArmyType.Freedom and 90024 or 90044
        LanguageMgr:SetText(txtTips0, lanID)
    else
        -- 停止倒计时
        if (timeBase) then
            timeBase:Stop(true)
        end
    end
end

function SetTime1(_needTime)
    CSAPI.SetText(txtTips2, _needTime .. "s")
    if (_needTime <= 0) then
        -- isFind = false
        ExerciseRMgr:StartRealArmy(myData.teams[teamIndex])
    end
end

function SetTime2(_needTime)
    CSAPI.SetText(txtTips1, _needTime .. "s")
    if (_needTime <= 0) then
        if (openSetting == RealArmyType.Freedom) then
            LanguageMgr:ShowTips(33019)
        end
        view:Close()
    end
end

-- -- 准备回调或通知
-- function EReady(proto)
--     if (proto.uid == myData.uid) then
--         lIsReady = true
--         SetMy()
--     else
--         rIsReady = true
--         SetEnemy()
--     end
-- end

-- -- 刷新好友列表
-- function OnClickRefresh()
--     FriendMgr:GetFlush({"icon_id", "name", "is_online", "level"})
-- end

function OnClickC()
    view:Close()
end

-- function OnClickStart()
--     ExerciseRMgr:StartRealArmy(myData.team)
-- end

-- function OnClickAddFriend()
--     CSAPI.OpenView("FriendView")
-- end
