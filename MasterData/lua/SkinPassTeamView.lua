
local isReady = false
local len = 1
local teamlist = {}
local layout= nil 
local curData = nil  
local items = {}

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Team_Data_Update, OnTeamDataUpdate)
    eventMgr:AddListener(EventType.Team_Card_Refresh, OnTeamDataUpdate)
end

function OnTeamDataUpdate()
    RefreshPanel()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("SkinPassTeam", topParent, OnClickClose)
end

function OnDisable()
    TeamMgr:DelEditTeam();
end

function OnOpen()
    TeamMgr:ClearAssistTeamIndex();
    if data then
        curData = Cfgs.MainLine:GetByID(data.dungeonId)
        CSAPI.SetGOActive(txt_tips,curData and curData.arrForceTeam ~= nil)
        RefreshPanel()
    end

    -- RefreshPanel()
end

function RefreshPanel()
    -- items
    curDatas = {curData}

    len = #curDatas
    -- if isFirst then
    --     layout:UpdateList()
    -- else
    --     layout:IEShowList(len)
    --     isFirst = true
    -- end  
    SetItems()
    --
    CheckReady()
    -- btns
    if curData.arrForceTeam then
        CSAPI.SetGOAlpha(btnGO, 1)
        isReady = true
    else
        CSAPI.SetGOAlpha(btnGO, isReady and 1 or 0.3)
    end
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
                ResUtil:CreateUIGOAsync("TeamConfirm/SkinPassTeamList",itemParent,function (go)
                    local lua = ComUtil.GetLuaTable(go)
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
        local str = LanguageMgr:GetByID(320020)
        for k = 1, len do
            table.insert(optionDatas, {
                desc = str
            })
        end
    end
    return optionDatas
end

-- 队伍是否都已经选好
function CheckReady()
    isReady = true
    teamlist = {}
    for k = 1, len do
        local id = eTeamType.SkinPass + k - 1
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
    if(curData.arrForceTeam)then
        teamlist = {}
        for k,v in ipairs(items) do
            local duplicateTeam=v.GetDuplicateTeamData();
            if duplicateTeam~=nil then
                table.insert(teamlist, duplicateTeam);
            end
        end
    else
        CheckReady()
    end
    if (isReady) then
        if curData then
            DungeonMgr:SetCurrId(curData.id)
            -- local openInfo = DungeonMgr:GetActiveOpenInfo2(curData.group)
            -- if not openInfo or not openInfo:IsOpen() then
            --     LanguageMgr:ShowTips(24003)
            --     return
            -- end
        end        
        local _data = {
            index = 1, -- 副本类型
            nDuplicateID = data.dungeonId, -- 副本id
            data = eTeamType.SkinPass, -- 队伍id
            list = teamlist -- 编队信息
        }
        DungeonMgr:SetFightTeamId(eTeamType.SkinPass)
        TeamMgr:AddFightTeamData(items[1].GetTeamData())
        FightProto:EnterFightDuplicate(_data)
    end
end

function OnClickClose()
    view:Close()
end


---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
