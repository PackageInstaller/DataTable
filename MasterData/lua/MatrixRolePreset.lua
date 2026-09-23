function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Matrix/MatrixRolePresetItem", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Matrix_Add_PresetTeam, RefreshPanel)
    eventMgr:AddListener(EventType.Matrix_Building_Update, RefreshPanel)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetChangeCB(ChangeCB)
        lua.Refresh(_data, roomId, useIndex)
    end
end

function OnOpen()
    roomId = data -- 建筑id
    buildData = MatrixMgr:GetBuildingDataById(roomId)
    RefreshPanel()
end

function RefreshPanel()
    useIndex = buildData:GetCurPresetId()
    curDatas = buildData:GetPresetRoles()
    layout:IEShowList(g_BuildMaxPresetTeamCnt)
end

function OnClickMask()
    view:Close()
end

function OnViewOpened(key)
    if (key == "DormSetRoleList") then
        CSAPI.SetLocalPos(gameObject, 0, 10000, 0)
    end
end
function OnViewClosed(key)
    if (key == "DormSetRoleList") then
        CSAPI.SetLocalPos(gameObject, 0, 0, 0)
    end
end

function ChangeCB()
    view:Close()
end

