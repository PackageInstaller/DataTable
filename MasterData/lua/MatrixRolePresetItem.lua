local changeName = ""
local sName = ""

function Awake()
    input = ComUtil.GetCom(inp_teamName, "InputField")
    CSAPI.AddInputFieldCallBack(inp_teamName, OnTeamNameEdit)
    CSAPI.AddInputFieldChange(inp_teamName, OnNameChange)
end

function OnNameChange(str)
    local text = StringUtil:FilterChar(str)
    input.text = text
end
function OnTeamNameEdit(str)
    if not MsgParser:CheckContain(str) then
        changeName = str
        isChange = true
        if (sName ~= changeName) then
            BuildingProto:BuildSetPresetTeamName(roomId, index, changeName)
        end
    else
        Tips.ShowTips(LanguageMgr:GetTips(9003))
        input.text = changeName
    end
end

function OnDestroy()
    CSAPI.RemoveInputFieldCallBack(inp_teamName, OnTeamNameEdit)
    CSAPI.RemoveInputFieldChange(inp_teamName, OnNameChange)
end

function SetIndex(_index)
    index = _index
end

function SetChangeCB(cb)
    ChangeCB = cb
end

-- sPresetRoleTeam
function Refresh(_data, _roomId, useIndex)
    data = _data or {}
    roomId = _roomId

    isOpen = MatrixMgr:GetExtraPresetTeamNum() >= index
    -- lock 
    CSAPI.SetGOActive(objLock, not isOpen)
    if (not isOpen) then
        local iconName = Cfgs.ItemInfo:GetByID(g_BuildPresetTeamBuyCost[1]).icon .. "_1"
        ResUtil.IconGoods:Load(mIcon, iconName)
        CSAPI.SetText(txt_price, g_BuildPresetTeamBuyCost[2] .. "")
    end
    -- name 
    CSAPI.SetGOActive(rename, isOpen)
    input.interactable = isOpen
    sName = data.name or LanguageMgr:GetByID(10455, index)
    input.text = sName
    if (isOpen) then
        local isSame =  useIndex == index
        if(isSame) then 
            local matrixData = MatrixMgr:GetBuildingDataById(roomId)
            isSame = FuncUtil.TableIsSame(data.roleIds,matrixData:GetRoles())
        end 
        CSAPI.SetGOActive(objUse, isSame)
        CSAPI.SetGOActive(btnUse, not isSame)
    else
        CSAPI.SetGOActive(objUse, false)
        CSAPI.SetGOActive(btnUse, false)
    end
    -- grids 
    CSAPI.SetGOActive(grids, isOpen)
    if (isOpen) then
        SetRoleItems()
    end
end

-- 驻员信息
function SetRoleItems()
    matrixRoleItems = matrixRoleItems or {}
    local datas = GetRoleInfos()
    ItemUtil.AddItems("CRoleItem/MatrixRole2", matrixRoleItems, datas, grids, ClickItemCB, 1, false, function()
        for i, v in ipairs(matrixRoleItems) do
            v.HideTxt()
        end
    end)
end
-- 点击空置
function ClickItemCB()
    CSAPI.OpenView("DormSetRoleList", {roomId, index})
end

-- 封装驻员数据，5个位置  {data = ,curLv = ,openLv=}   noNil:剔除不开放的
function GetRoleInfos(noNil)
    local matrixData = MatrixMgr:GetBuildingDataById(roomId)
    noNil = noNil == nil and true or noNil
    local roleInfos = {}
    local roles = data.roleIds or {}
    local rolePos = matrixData:GetRolePos()
    local _curLv = matrixData:GetData().lv
    for i, v in ipairs(rolePos) do
        local _id = i <= #roles and roles[i] or nil
        if (noNil and v == -1) then
            break
        end
        table.insert(roleInfos, {
            data = _id,
            curLv = _curLv,
            openLv = v
        })
    end
    return roleInfos
end

-- 解锁
function OnClickOpen()
    local cfg = Cfgs.ItemInfo:GetByID(g_BuildPresetTeamBuyCost[1])
    local content = string.format(LanguageMgr:GetTips(14019), cfg.name .. "X" .. g_BuildPresetTeamBuyCost[2])
    local dialogdata = {}
    dialogdata.content = content
    dialogdata.okCallBack = function()
        if CSAPI.IsADVRegional(3) then
            CSAPI.ADVJPTitle(g_BuildPresetTeamBuyCost[2],function()   BuildingProto:BuildAddPresetTeam(roomId) end)
        else
            BuildingProto:BuildAddPresetTeam(roomId)
        end
    end
    CSAPI.OpenView("Dialog", dialogdata)
end

-- 使用
function OnClickUse()
    -- local dialogdata = {}
    -- dialogdata.content = string.format(LanguageMgr:GetTips(14034), sName)
    -- dialogdata.okCallBack = function()
    --     ChangePreset()
    -- end
    -- CSAPI.OpenView("Dialog", dialogdata)
    ChangePreset()
    if (ChangeCB) then
        ChangeCB()
    end
end

function ChangePreset()
    local list = {}
    local curRoleIds = {}
    local isMove, isUsable = false, true
    local selectIDS = data.roleIds or {}
    for i, v in pairs(selectIDS) do
        local _data = CRoleMgr:GetData(v)
        local _roomId = _data:GetRoomBuildID()
        if (_roomId and _roomId ~= roomId) then
            if (not list[_roomId]) then
                list[_roomId] = {}
                list[_roomId].id = _roomId
                local roomType = DormMgr:GetRoomTypeByID(_roomId)
                if (roomType == RoomType.building) then
                    list[_roomId].roleIds = MatrixMgr:GetBuildingDataById(_roomId):GetRoles()
                    list[_roomId].teamId = MatrixMgr:GetBuildingDataById(_roomId):GetCurPresetId()
                else
                    list[_roomId].roleIds = DormMgr:GetRoomData(_roomId):GetRoles()
                    list[_roomId].teamId = DormMgr:GetRoomData(_roomId):GetCurPresetId()
                end
            end
            for k, m in ipairs(list[_roomId].roleIds) do
                if (m == v) then
                    table.remove(list[_roomId].roleIds, k)
                    break
                end
            end
        end
        table.insert(curRoleIds, v)
    end
    -- 封装
    local infos = {}
    for i, v in pairs(list) do
        table.insert(infos, v)
    end
    table.insert(infos, {
        id = roomId,
        roleIds = curRoleIds,
        teamId = index
    })
    local showTips, languageID = false, nil
    -- 宿舍、非建筑不提示
    BuildingProto:BuildSetRole(infos)

end
