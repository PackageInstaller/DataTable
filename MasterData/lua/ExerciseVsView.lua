function Awake()
    cardIconItemL = RoleTool.AddRole(iconLParent, nil, nil, false)
    mulIconItemL = RoleTool.AddMulRole(iconLParent, nil, nil, false)
    cardIconItemR = RoleTool.AddRole(iconRParent, nil, nil, false)
    mulIconItemR = RoleTool.AddMulRole(iconRParent, nil, nil, false)
end

function OnInit()
    UIUtil:AddTop2("ExerciseVsView", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Exercise_End, function()
        view:Close()
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)

end

function OnDestroy()
    eventMgr:ClearListener()
end

-- 演习 data GetPracticeOtherTeamRet  {team,uid,is_robot}
function OnOpen()
    SetLeft()
    SetRight()
    -- 积分
    local zf1 = ExerciseMgr:GetScore()
    local zf2 = lData and lData.score or 0
    local zf = GCalHelp:GetArmyAddScore(zf1, zf2)
    LanguageMgr:SetText(txtZf, 33069, "+" .. zf)
    -- CSAPI.SetText(txtZf, "+" .. zf)
end

-- 自己
function SetLeft()
    -- icon
    SetIconL()
    -- attack
    local teamData = TeamMgr:GetTeamData(eTeamType.PracticeAttack)
    if teamData then
        local haloStrength = teamData:GetHaloStrength()
        CSAPI.SetText(txtFightingL2, tostring(teamData:GetTeamStrength() + haloStrength))
    end
    -- rank
    CSAPI.SetText(txtRankL2, ExerciseMgr:GetRankStr())
    -- lv
    CSAPI.SetText(txtLvL2, PlayerClient:GetLv() .. "")
    -- name
    CSAPI.SetText(txtNameL, PlayerClient:GetName())
    -- team
    SetLTeamItems()
    -- head
    -- UIUtil:AddHeadByID(headL, 1, PlayerClient:GetHeadFrame(), ExerciseMgr:GetRolePanel(), PlayerClient:GetSex())
    UIUtil:AddHeadFrame(headL, 1)
end

function SetIconL()
    local icon_id, live2d = GetLIcon()
    local arr = CSAPI.GetMainCanvasSize()
    local width = arr.x / 4
    -- CSAPI.SetRTSize(iconMaskL, width, 0)
    local opposite, adjacent = GetSideScale(width, 14)
    CSAPI.SetAnchor(iconLParent, -adjacent, -opposite, 0)
    -- RoleTool.LoadImg(iconL, icon_id, LoadImgType.ExerciseLView)
    -- -- 
    -- UIUtil:SetLiveBroadcast(iconL)
    if (icon_id < 10000) then
        mulIconItemL.Refresh(icon_id, LoadImgType.ExerciseLView, nil, live2d)
        mulIconItemL.SetLiveBroadcast()
    else
        cardIconItemL.Refresh(icon_id, LoadImgType.ExerciseLView, nil, live2d)
        cardIconItemL.SetLiveBroadcast()
    end
end

function GetLIcon()
    local icon_id, live2d = nil, false
    if (ExerciseMgr:GetInfo().role_panel_id == nil or ExerciseMgr:GetInfo().role_panel_id == 0) then
        -- 用队长
        local cards = TeamMgr:GetTeamCardDatas(eTeamType.PracticeAttack)
        icon_id = cards[1]:GetSkinID()
        local cfgModel = Cfgs.character:GetByID(icon_id)
        live2d = cfgModel.l2dName ~= nil
    else
        icon_id = ExerciseMgr:GetInfo().role_panel_id
        live2d = ExerciseMgr:GetInfo().live2d == BoolType.Yes
    end
    return icon_id, live2d
end

function SetLTeamItems()
    if (formationViewL) then
        formationViewL.Init(TeamMgr:GetTeamData(eTeamType.PracticeAttack))
    else
        ResUtil:CreateUIGOAsync("Formation/FormationView2DPVP", itemGridL, function(go)
            formationViewL = ComUtil.GetLuaTable(go)
            formationViewL.SetForceMove(nil, nil, nil)
            formationViewL.Init(TeamMgr:GetTeamData(eTeamType.PracticeAttack))
            formationViewL.SetTrims(false)
        end)
    end
end

-- 已知斜边长度和锐角，计算对边和邻边长度
function GetSideScale(hypotenuse, angle)
    -- 将角度转换为弧度
    local radians = angle * math.pi / 180

    -- 计算对边和邻边长度
    local opposite = hypotenuse * math.sin(radians)
    local adjacent = hypotenuse * math.cos(radians)

    -- 返回结果
    return opposite, adjacent
end

-- function SetLTeamItems()
--     local cards = TeamMgr:GetTeamCardDatas(eTeamType.PracticeAttack)
--     -- 封装数据
--     local _newDatas = {}
--     for i = 1, 5 do
--         if (i <= #cards) then
--             table.insert(_newDatas, cards[i])
--         else
--             -- table.insert(_newDatas, {})
--         end
--     end

--     lTeamGrids = lTeamGrids or {}
--     ItemUtil.AddItems("RoleLittleCard/RoleLittleCard", lTeamGrids, _newDatas, itemGridL, nil, 1, {
--         hideFormat = true
--     })

--     --icon 
--     --SetIconL(_newDatas[1]:GetSkinID())
-- end

-- 敌人
function SetRight()
    lData = ExerciseMgr:GetEnemyInfo(data.uid)
    if (not lData) then
        LogError("找不到玩家数据：" .. data.uid)
        return
    end
    -- icon
    local icon_id = lData.icon_id
    if (lData.role_panel_id ~= nil and lData.role_panel_id ~= 0) then
        icon_id = lData.role_panel_id
    end
    SetIconR(icon_id)
    -- attack
    CSAPI.SetText(txtFightingR2, lData.performance .. "")
    -- rank
    CSAPI.SetText(txtRankR2, lData.rank == 0 and "__" or tostring(lData.rank))
    -- lv
    CSAPI.SetText(txtLvR2, lData.level .. "")
    -- name
    CSAPI.SetText(txtNameR, lData.name .. "")
    -- team
    SetRTeamItems()
    -- head 
    UIUtil:AddHeadByID(headR, 1, lData.icon_frame, lData.icon_id, lData.sel_card_ix)
end
function SetIconR(icon_id)
    local arr = CSAPI.GetMainCanvasSize()
    local width = arr.x / 4
    -- CSAPI.SetRTSize(iconMaskR, width, 0)
    local opposite, adjacent = GetSideScale(width, 14)
    CSAPI.SetAnchor(iconRParent, adjacent, opposite, 0)
    -- RoleTool.LoadImg(iconR, icon_id, LoadImgType.ExerciseLView, function()
    --     local x, y = CSAPI.GetAnchor(iconR)
    --     CSAPI.SetAnchor(iconR, -x, y)
    -- end)
    -- -- 
    -- UIUtil:SetLiveBroadcast(iconR)

    if (icon_id < 10000) then
        mulIconItemR.Refresh(icon_id, LoadImgType.ExerciseLView, nil, lData.live2d)
        mulIconItemR.SetLiveBroadcast()
    else
        cardIconItemR.Refresh(icon_id, LoadImgType.ExerciseLView, nil, lData.live2d)
        cardIconItemR.SetLiveBroadcast()
    end
end
function SetRTeamItems()
    local teamData = TeamMgr:CreateTeamData(data.team)
    if (formationViewR) then
        formationViewR.Init(teamData)
    else
        ResUtil:CreateUIGOAsync("Formation/FormationView2DPVPMirror", itemGridR, function(go)
            formationViewR = ComUtil.GetLuaTable(go)
            formationViewR.SetForceMove(nil, nil, nil)
            formationViewR.Init(teamData)
        end)
    end
end
-- function SetRTeamItems()
--     local cardDatas = {}
--     if (data and data.team) then
--         for i, v in ipairs(data.team.data) do
--             local _card = CharacterCardsData(v.card_info)
--             table.insert(cardDatas, _card)
--         end
--     end
--     -- 封装数据
--     local _newDatas = {}
--     for i = 1, 5 do
--         if (i <= #cardDatas) then
--             table.insert(_newDatas, cardDatas[i])
--         else
--             -- table.insert(_newDatas, {})
--         end
--     end
--     rTeamGrids = rTeamGrids or {}
--     ItemUtil.AddItems("RoleLittleCard/RoleLittleCard", rTeamGrids, _newDatas, itemGridR, nil, 1, {
--         hideFormat = true
--     })
-- end

function OnClickTeam()
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.PracticeAttack,
        canEmpty = false,
        is2D = true
    }, TeamOpenSetting.PVP)
end

function OnViewClosed(viewKey)
    if (viewKey == "TeamView") then
        SetLeft()
    end
end

function OnClickStart()
    ArmyProto:Practice(data.uid, data.is_robot)
end

