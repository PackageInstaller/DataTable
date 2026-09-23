local isReady = false
local len = 1
local teamlist = {}
local layout= nil 
local curData = nil  
local items = {}
local currItem = nil

function Awake()
    CSAPI.SetGOActive(teamSelectShowObj,false)
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Team_Data_Update, OnTeamDataUpdate)
    eventMgr:AddListener(EventType.Team_Card_Refresh, OnTeamDataUpdate)
    eventMgr:AddListener(EventType.Trials2_Panel_Refresh, OnTeamDataUpdate)
end

function OnTeamDataUpdate()
    RefreshPanel()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("Trials2Team", topObj, OnClickReturn);
end

function OnDisable()
    TeamMgr:DelEditTeam();
end

function OnOpen()
    TeamMgr:ClearAssistTeamIndex();
    if data then
        curData = DungeonMgr:GetDungeonGroupData(data)
        SetScore()
        SetName()
        RefreshPanel()
    end
end

function SetScore()
    LanguageMgr:SetText(txtScore,37065,TrialsMgr:GetMaxScore())
end

function SetName()
    CSAPI.SetText(txtLevel,LanguageMgr:GetByID(37066)..curData:GetName())
end

function RefreshPanel()
    SetBtnState()
    -- items
    curDatas = curData:GetMainLines()
    len = #curDatas
    SetItems()
    
    CheckReady()
    CSAPI.SetGOAlpha(btnGO, isReady and 1 or 0.5)
end

function SetBtnState()
    CSAPI.SetGOActive(enter,not TrialsMgr:IsFighting())
    CSAPI.SetGOActive(continue,TrialsMgr:IsFighting())
    CSAPI.SetGOActive(btnGiveUp,TrialsMgr:IsFighting())
end

function SetItems()
    if #items > 0 then
        for i, v in ipairs(items) do
            CSAPI.SetGOActive(v.gameObject,false)
        end
    end

    if curDatas then
        for i, v in ipairs(curDatas) do
            if items[i] then
                CSAPI.SetGOActive(items[i].gameObject, true)
                items[i].SetIndex(i, len, GetOptionDatas())
                items[i].Refresh(v)
            else
                ResUtil:CreateUIGOAsync("Trials2/Trials2TeamItem",itemParent,function (go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.SetClickCB(OnItemClickCB,OnItemClickCB2)
                    lua.SetIndex(i, len, GetOptionDatas())
                    lua.Refresh(v)
                    table.insert(items,lua)
                end)
            end
        end
    end
end

function GetOptionDatas()
    if (not optionDatas) then
        optionDatas = {}
        local str = LanguageMgr:GetByID(130025)
        for k = 1, len do
            table.insert(optionDatas, {
                desc = str
            })
        end
    end
    return optionDatas
end

function OnItemClickCB(item)
    currItem = item
    CSAPI.SetGOActive(teamSelectShowObj,true)
    CSAPI.SetGOActive(currItem.teamSelect,true)
    currItem.SetTeamSelectItems()
    currItem.teamSelect.transform.parent = teamSelectShowObj.transform
end

function OnItemClickCB2(item2)
    TryChangeTeam(currItem.index,item2.index)
end

function TryChangeTeam(index1,index2)
    TeamMgr:DelEditTeam()
    local teamIndex1,teamIndex2 = eTeamType.ChainFront + index1 - 1,eTeamType.ChainFront + index2 - 1
    local team1,team2 = TeamMgr:GetTeamData(teamIndex1),TeamMgr:GetTeamData(teamIndex2)
    team1.index = teamIndex2
    team2.index = teamIndex1
    local assistData1,assistData2 = items[index1].GetAssistData(),items[index2].GetAssistData()
    local assistSkill1,assistSkill2 = items[index1].GetAssistSkillId(),items[index2].GetAssistSkillId()
    TeamMgr:SaveDatas({team1, team2}, function()
        items[index1].ReplaceAssistData(assistData2)
        items[index2].ReplaceAssistData(assistData1)
        items[index1].OnCloseCallBack(assistSkill2)
        items[index2].OnCloseCallBack(assistSkill1)
        RefreshPanel()
        OnClickMask()
    end)
end

-- 队伍是否都已经选好
function CheckReady()
    isReady = true
    teamlist = {}
    for k = 1, len do
        local id = eTeamType.ChainFront + k - 1
        local teamData = TeamMgr:GetEditTeam(id)
        if teamData:GetRealCount() <= 0 then
            isReady = false
            return
        else
            local _duplicateTeamData = TeamMgr:DuplicateTeamData(id, teamData)
            table.insert(teamlist, _duplicateTeamData)
        end
    end
end

-- 开始战斗
function OnClickGO()
    if (isReady) then
        local cfgs = curData:GetMainLines()
        if cfgs and cfgs[1] then
            DungeonMgr:SetCurrId(cfgs[1].id)
            local openInfo = DungeonMgr:GetActiveOpenInfo2(cfgs[1].group)
            if not openInfo or not openInfo:IsOpen() then
                LanguageMgr:ShowTips(24003)
                return
            end
        end
        if TrialsMgr:IsFighting() then
            local info = {
                id = curData:GetID(),
                list = teamlist,
                selectBuffs = GetSkills()
            }
            FightProto:UpdateChainFrontTeam(info,OnEnterFight)
        else
            FightProto:EnterChainFrontDuplicate({id = curData:GetID(),list = teamlist,selectBuffs = GetSkills()})
        end
    end
end

function OnEnterFight()
    FightProto:EnterChainFrontFight(TrialsMgr:GetFightRound())
end

function GetSkills()
    local list = {}
    for i, v in ipairs(items) do
        table.insert(list,v.GetAssistSkillId())
    end
    return list
end

function OnClickGiveUp()
    local dialogData  = {}
    dialogData.content = LanguageMgr:GetTips(76002)
    dialogData.okCallBack = function()
        FightProto:GiveUpChainFront(curData:GetID(),OnItemRemoveAssist)
    end
    CSAPI.OpenView("Dialog",dialogData)
end

function OnItemRemoveAssist()
    if #items > 0 then
        for i, v in ipairs(items) do
            v.ReplaceAssistData()
        end
    end
    TeamMgr:DelEditTeam()
    SetScore()
end

function OnClickReturn()
    view:Close()
end

function OnClickMask()
    if currItem then
        currItem.teamSelect.transform.parent = currItem.teamSelectParent.transform
        CSAPI.SetGOActive(currItem.teamSelect,false)
        currItem = nil
    end
    CSAPI.SetGOActive(teamSelectShowObj,false)
end