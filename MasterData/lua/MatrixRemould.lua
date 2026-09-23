local selectDatas = {}
local isDontClose = false

function Awake()
    AdaptiveConfiguration.SetLuaObjUIFit("MatrixRemould", gameObject)

    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Matrix/MatrixRemouldItem", LayoutCallBack, true)

    UIUtil:AddQuestionItem("MatrixRemould", gameObject)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        if (_data.lockID) then
            lua.SetEmpty(_data)
        else
            lua.Refresh(index, _data, data, AddEquipCB)
        end
    end
end

-- 改造列表
function OnInit()
    UIUtil:AddTop2("MatrixRemould", gameObject, function()
        if (isDontClose) then
            CSAPI.SetGOActive(gameObject, false)
        else
            view:Close()
        end
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Matrix_Building_Update, function(ids)
        if (gameObject.activeSelf and data and ids and ids[data:GetId()]) then
            RefreshPanel()
        end
    end)
    eventMgr:AddListener(EventType.Equip_Remould_Select, SetAddEquipCB)

    -- 物品更新
    eventMgr:AddListener(EventType.Bag_Update, function()
        RefreshPanel()
    end)
end

function OnDestroy()
    AdaptiveConfiguration.LuaView_Lua_Closed("MatrixRemould")
    eventMgr:ClearListener()
end

function OnOpen()
    -- SetName()
    RefreshPanel()
end

-- 由基地内部进入，不关闭界面
function Refresh(_data)
    isDontClose = true
    data = _data
    RefreshPanel()
end

-- function SetName()
-- 	local cfg = Cfgs.CfgMatrixAttribute:GetByID(1)
-- 	CSAPI.SetText(txtName, cfg.sName)  --改造槽
-- end
function RefreshPanel()
    -- items 
    InitData()

    -- count
    CSAPI.SetText(txtCount, string.format("%s/%s", #arrGifts, taskNumLimit))
end

function InitData()
    curDatas = {}
    arrGifts = data:GetMaterials()
    taskNumLimit = data:GetCfg().taskNumLimit or 0
    for i = 1, taskNumLimit do
        local isRun = false
        for k, v in ipairs(arrGifts) do
            if (v.slot == i) then
                table.insert(curDatas, v)
                isRun = true
                break
            end
        end
        if (not isRun) then
            table.insert(curDatas, {}) -- 添加空位
        end
    end
    --
    local lockDatasDic = {}
    local lockDatas = {}
    local cfgs = Cfgs.CfgBRemouldLvl:GetAll()
    for i, v in ipairs(cfgs) do
        if (not lockDatasDic[v.taskNumLimit]) then
            lockDatasDic[v.taskNumLimit] = v.id
            table.insert(lockDatas, {
                lockID = v.id
            })
        end
    end
    local len = #curDatas
    for i = len + 1, #lockDatas do
        table.insert(curDatas, lockDatas[i]) -- 添加锁位
    end

    if (not isFirst) then
        isFirst = 1
        layout:IEShowList(#curDatas)
    else
        layout:UpdateList() -- 防止把items重置了
    end
end

-- 选择装备
function AddEquipCB(_index, _isRemove)
    if (_isRemove) then
        selectDatas[_index] = nil
    else
        curIndex = _index
        CSAPI.OpenView("Bag", {
            bagType = EquipBagType.Remould,
            selDatas = selectDatas
        }, 2, nil, nil, false) -- cb=SetAddEquipCB
    end
end
function SetAddEquipCB(data)
    for i, v in pairs(selectDatas) do
        if (v:GetID() == data:GetID()) then
            local lua1 = layout:GetItemLua(i)
            lua1.SetSelectData(nil)
            selectDatas[i] = nil
            break
        end
    end
    local lua = layout:GetItemLua(curIndex)
    lua.SetSelectData(data)
    selectDatas[curIndex] = data
end

