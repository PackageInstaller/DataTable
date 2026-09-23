-- ITEM_ID.Hot
local canvasGroup = nil
local isShowAgain = false
local isTimeOut = false
local isDirll = false

function Awake()
    canvasGroup = ComUtil.GetCom(btnAgain, "CanvasGroup")
end

function Refresh(_data, _elseData)
    data = _data 
    elseData = _elseData 

    isDirll = _elseData and _elseData.isDirll
    -- anim
    CSAPI.SetGOActive(animMask, true)
    FuncUtil:Call(function()
        if gameObject then
            CSAPI.SetGOActive(animMask, false)
        end
    end, nil, 1500)

    sceneType = _data.sceneType

    -- icon
    ResUtil.IconGoods:Load(costIcon, ITEM_ID.Hot .. "_1", true)
    if isDirll then
        CSAPI.LoadImg(titleImg, "UIs/FightOver/img_dirll_lose.png", true, nil, true)
    end

    -- starInfo
    SetStarInfos()

    -- again
    CSAPI.SetGOActive(costObj, false)
    isShowAgain = IsShowAgain()
    canvasGroup.alpha = isShowAgain and 1 or 0.73
end

function SetStarInfos()
    if not DungeonMgr:GetCurrId() then
        CSAPI.SetGOActive(taskObj, false)
        return
    end

    if sceneType == SceneType.BuffBattle then
        CSAPI.SetGOActive(taskObj, false)
        return
    end

    local cfgDungeon = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    if cfgDungeon.type == eDuplicateType.Tower or cfgDungeon.type == eDuplicateType.TaoFa 
    or cfgDungeon.type == eDuplicateType.NewTower or cfgDungeon.type == eDuplicateType.RogueS
    or cfgDungeon.type == eDuplicateType.EternalBattle or cfgDungeon.type == eDuplicateType.SkinPass then
        CSAPI.SetGOActive(taskObj, false)
        return
    end

    if cfgDungeon.diff and cfgDungeon.diff == 3 then
        CSAPI.SetGOActive(taskObj, false)
        return
    end

    local dungeonData = DungeonMgr:GetDungeonData(DungeonMgr:GetCurrId())
    local completeInfo = nil
    if dungeonData and dungeonData.data then
        completeInfo = dungeonData:GetNGrade()
    end
    local starInfos = DungeonUtil.GetStarInfo2(DungeonMgr:GetCurrId(), completeInfo);
    for i = 1, 3 do
        -- task  
        local taskGO = taskObj.transform:GetChild(i - 1).gameObject
        if starInfos[i] then
            local img = ComUtil.GetComInChildren(taskGO, "Image")
            CSAPI.SetImgColor(img.gameObject, 255, 255, 255, starInfos[i].isComplete and 255 or 178)

            local text = ComUtil.GetComInChildren(taskGO, "Text")
            text.text = starInfos[i].tips
            local color = starInfos[i].isComplete and {255, 193, 70, 255} or {255, 255, 255, 255}
            CSAPI.SetTextColor(text.gameObject, color[1], color[2], color[3], color[4])
        else
            CSAPI.SetGOActive(taskGO, false)
        end
    end
end

-- 显示再次挑战按钮
function IsShowAgain()
    if sceneType == SceneType.Rogue or sceneType == SceneType.RogueS then
        return true
    end 
    if not DungeonMgr:GetCurrId() then
        return false
    end

    local cfgDungeon = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    if cfgDungeon == nil then
        LogError("找不到关卡表数据！id：" .. DungeonMgr:GetCurrId())
        return false
    end

    local dungeonType = cfgDungeon.type
    if sceneType == SceneType.PVE then
        if not DungeonMgr:IsCurrDungeonComplete() then
            return false
        end
        if dungeonType == eDuplicateType.Tower then
            CSAPI.SetGOActive(costObj, true)
            CSAPI.SetText(txtCost, "0")
            return true
        elseif dungeonType == eDuplicateType.StoryActive or dungeonType == eDuplicateType.TaoFa then --检测副本开启时间是否过了
            local sectionData = DungeonMgr:GetSectionData(cfgDungeon.group)
            if sectionData == nil then
                LogError("找不到关卡表章节数据！id：" .. cfgDungeon.group)
                return false
            end
            local openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
            if openInfo and not openInfo:IsDungeonOpen() then
                isTimeOut = true
                return false               
            end
        end
        CSAPI.SetGOActive(costObj, true)

        -- icon
        local _cost = DungeonUtil.GetCost(cfgDungeon)
        if _cost~=nil then
            ResUtil.IconGoods:Load(costIcon, _cost[1] .. "_1")
            CSAPI.SetText(txtCost,"" .. _cost[2])
        else
            ResUtil.IconGoods:Load(costIcon, ITEM_ID.Hot .. "_1", true)
            local costNum = DungeonUtil.GetHot(cfgDungeon)
            CSAPI.SetText(txtCost, costNum .. "")
        end
        return true
    end

    return false
end

function OnClickAgain()
    if isTimeOut then
        LanguageMgr:ShowTips(24003)
        return
    end

    if not isShowAgain then
        return
    end

    -- if sceneType == SceneType.Rogue then
    --     RogueMgr:FightToBack(false,elseData.group)
    --     return 
    -- end 
    local num = isDirll and 6 or 5
    if sceneType == SceneType.Rogue or sceneType == SceneType.RogueS then
        num = nil 
    end
    ApplyQuit(num)
end

-- 等级提升
function OnClickFail1()
    ApplyQuit(1)
end
-- 技能提升
function OnClickFail2()
    ApplyQuit(2)
end
-- 角色突破
function OnClickFail3()
    ApplyQuit(3)
end
-- 装备强化
function OnClickFail4()
    ApplyQuit(4)
end

function OnClickReturn()
    ApplyQuit()
end

function ApplyQuit(jumpType)
    FightClient:Clean()
    if sceneType == SceneType.PVE or sceneType == SceneType.PVEBuild then -- 清理PVE的数据
        local dungeonId = DungeonMgr:GetCurrId();
        local isOver = DungeonMgr:IsCurrDungeonComplete();
        if isOver then
            -- 副本结束
            if sceneType == SceneType.PVE and BattleMgr:GetAIMoveState() and DungeonMgr:CurrSectionIsMainLine() and
                hasCallFunc ~= true then
                -- 记录战斗队伍信息、关卡ID
                local teams = TeamMgr:GetAutoDuplicateTeamData();
                DungeonMgr:AddAutoDungeonInfo(dungeonId, teams);
                MenuMgr:AddOpenFunc("Dungeon", function()
                    local eventMgr = ViewEvent.New();
                    eventMgr:AddListener(EventType.Loading_Complete, function()
                        if bIsWin then -- 胜利
                            CSAPI.OpenView("FightNaviReward");
                        else -- 失败
                            local dialogdata = {};
                            dialogdata.content = LanguageMgr:GetByID(25006);
                            dialogdata.okCallBack = function()
                                CSAPI.OpenView("FightNaviReward");
                            end
                            CSAPI.OpenView("Prompt", dialogdata)
                        end
                        eventMgr:ClearListener();
                    end)
                end);
                hasCallFunc = true;
            end
            ClearTeamData()
            UIUtil:AddFightTeamState(2, "FightOverResult:ApplyQuit()")
        elseif dungeonId ~= nil and dungeonId ~= "" then -- 未结束
            LanguageMgr:ShowTips(8009)
            -- DungeonMgr:ApplyEnter(dungeonId);
            return;
        end
    elseif sceneType == SceneType.Rogue or sceneType == SceneType.RogueS or sceneType == SceneType.BuffBattle then 
        ClearTeamData()
    end
    if jumpType then
        local jumpID = nil;
        if jumpType == 1 then
            jumpID = 40001;
        elseif jumpType == 2 then
            jumpID = 40001;
        elseif jumpType == 3 then
            jumpID = 40001;
        elseif jumpType == 4 then
            jumpID = 80002;
        end
        --if sceneType == SceneType.PVE then
            DungeonMgr:Quit(false, jumpType)
        --else
            --JumpMgr:Jump(jumpID);
        --end
        return
    end

    -- 基地突袭
    if (sceneType == SceneType.PVEBuild) then
        if (data.elseData and data.elseData == RealArmyType.Matrix) then
            MatrixMgr:InScene()
        else
            -- 测试用
            SceneLoader:Load("MajorCity")
        end
    elseif (IsPvpSceneType(sceneType)) then
        ExerciseRMgr:Quit(data.elseData)
    elseif (sceneType == SceneType.PVPMirror) then
        ExerciseMgr:Quit(data.elseData)
    elseif (sceneType == SceneType.BOSS) then
        BattleFieldMgr:Quit()
    elseif sceneType == SceneType.PVE then
        DungeonMgr:Quit(not bIsWin);
    elseif (sceneType == SceneType.GuildBOSS) then
        GuildFightMgr:FightQuit();
    elseif (sceneType == SceneType.Rogue) then
        RogueMgr:FightToBack(false,elseData.group)
    elseif (sceneType == SceneType.RogueS) then
        RogueSMgr:Quit(elseData.group,data.elseData.group)
    elseif (sceneType == SceneType.BuffBattle) then
        DungeonMgr:Quit(not bIsWin);
    end
end

function ClearTeamData()
    FriendMgr:ClearAssistData();
    TeamMgr:ClearAssistTeamIndex();
    TeamMgr:ClearFightTeamData();
end

