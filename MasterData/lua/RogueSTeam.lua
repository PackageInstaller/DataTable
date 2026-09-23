local isReady = false
local len = 1
local teamlist = {}

function Awake()
    UIUtil:AddTop2("RogueSTeam", gameObject, function()
        view:Close()
    end, nil, {})

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/TeamConfirm/RogueSTeamList", LayoutCallBack)

    eventMgr = ViewEvent.New()
    -- eventMgr:AddListener(EventType.TeamView_RogueS_Change, RefreshPanel)
    -- eventMgr:AddListener(EventType.TeamView_Close, RefreshPanel)
    eventMgr:AddListener(EventType.Team_Data_Update, RefreshPanel)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index, len, GetOptionDatas())
        lua.Refresh(_data)
    end
end

function GetOptionDatas()
    if (not optionDatas) then
        optionDatas = {}
        local str = LanguageMgr:GetByID(65021)
        for k = 1, len do
            table.insert(optionDatas, {
                desc = str
            })
        end
    end
    return optionDatas
end

function OnOpen()
    curData = RogueSMgr:GetData(data)

    RefreshPanel()
end

function RefreshPanel()
    -- items
    curDatas = curData:GetMainLines()
    len = #curDatas
    layout:IEShowList(len)
    --
    CheckReady()
    -- btns 
    CSAPI.SetGOAlpha(btnGO, isReady and 1 or 0.3)

end

-- 队伍是否都已经选好
function CheckReady()
    isReady = true
    teamlist = {}
    for k = 1, len do
        local id = eTeamType.RogueS + k
        local teamData = TeamMgr:GetTeamData(id)
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
    CheckReady()
    if (isReady) then
        FightProto:EnterRogueSDuplicate(curData:GetID(), teamlist)
    end
end

function OnClickZY()
    CSAPI.OpenView("RogueSBuffDetail", data)
end


---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    view:Close()
end
