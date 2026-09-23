local items = nil
local layout = nil
local curDatas = nil
local assistSkills = {}
local dups = {}

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Rank/RankTeamItem2", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if lua then
        local _data = curDatas[index]
        lua.Refresh(_data,{type = data.rankType,skillId = assistSkills[index],dupId = dups[index]})
    end
end

function OnViewOpened(viewKey)
    if viewKey == "RoleInfo" then
        CSAPI.SetGOActive(node, false)
    end
end

function OnViewClosed(viewKey)
    if viewKey == "RoleInfo" then
        CSAPI.SetGOActive(node, true)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    if data then
        curDatas = data.data or {}
        assistSkills = data.assistSkillList or {}
        dups = data.dupList or {}
        RefreshPanel()
    end
end

function RefreshPanel()
    SetTitle()
    SetItems()
end

function SetTitle()
    LanguageMgr:SetText(txtTitle, 22064, data.name)
end

function SetItems()
    layout:IEShowList(#curDatas)
end

function OnClickClose()
    view:Close()
end