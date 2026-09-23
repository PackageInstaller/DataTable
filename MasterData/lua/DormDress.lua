-- 换装
local curIndex = 1

function OnInit()
    UIUtil:AddTop2("DormDress", gameObject, function()
        Reset()
        view:Close()
    end)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Dorm_Change_Clothes, RefreshPanel)
    -- 服装是商品，做物品更新
    eventMgr:AddListener(EventType.Bag_Update, function()
        InitColothesDatas()
        RefreshPanel()
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Dorm/DormDressItem", LayoutCallBack, true)
end

local elseData = {}
function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = clothesDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ClothesItemClickCB)
        local isSelect = SelectIDs[_data.id] == 1
        lua.Refresh(_data, isSelect)
    end
end

-- data {roleModels, cRoleID，cb}
function OnOpen()
    -- roleModels = data[1]
    cRoleID = data[2]
    dressCB = data[3]

    InitLData()
    InitColothesDatas()
    RefreshPanel()
end

function RefreshPanel()
    SetCurSelect()
    SetLeft()
    SetRight()
    ShowModel()
end

-- 展示模型（修改模型层级，生成一个相机单独照射他）
function ShowModel()
    -- 还原前一个
    if (curRoleModel) then
        curRoleModel.SetModelsLayer(false, 21)
    end

    curRoleModel = roleModelsArr[curIndex]
    -- 层级
    curRoleModel.SetModelsLayer(true, 21)
    -- 相机
    if (not camera3) then
        CSAPI.CreateGOAsync("Scenes/Matrix/DormDressCamera", 0, 0, 0, curRoleModel.gameObject, function(go)
            camera3 = ComUtil.GetLuaTable(go)
        end)
    else
        CSAPI.SetParent(camera3.gameObject, curRoleModel.gameObject)
    end
end

-- 还原
function Reset()
    if (dressCB) then
        dressCB()
    end
    if (camera3) then
        CSAPI.RemoveGO(camera3.gameObject)
    end
end

function InitLData()
    roleModelsArr = {}
    local roleModels = data[1]
    local roleIDs = DormMgr:GetCurRoomData():GetRoles() --按这个id排序
    for k, v in ipairs(roleIDs) do
        if (roleModels[v]) then
            table.insert(roleModelsArr, roleModels[v])
        end
        if (v == cRoleID) then
            curIndex = k
        end
    end
end

-- 更新已购买的服装列表
function InitColothesDatas()
    hadDic = BagMgr:GetDataByTypeDic(ITEM_TYPE.CLOTHES)
end

-- 当前选择的 id
function SetCurSelect()
    SelectIDs = {}
    local clothes = roleModelsArr[curIndex].data:GetClothes() or {}
    for i, v in ipairs(clothes) do
        SelectIDs[v] = 1
    end
end

function SetLeft()
    items = items or {}
    ItemUtil.AddItems("Grid/DormDressRole", items, roleModelsArr, lGrids, ItemClickCB, 1, curIndex)
end

function ItemClickCB(index)
    if (curIndex ~= index) then
        curIndex = index
        RefreshPanel()
    end
end

function SetRight()
    clothesDatas = {}
    local roleData = roleModelsArr[curIndex].data
    local curID = roleData:GetID()
    local cfgs = Cfgs.CfgClothes:GetAll()
    for i, v in pairs(cfgs) do
        if (hadDic[v.id] ~= nil and v.sex == nil or v.sex == roleData:GetGender()) then
            if (v.canUses) then
                for k, m in ipairs(v.canUses) do
                    if (curID == m) then
                        table.insert(clothesDatas, v)
                        break
                    end
                end
            elseif (v.notUses) then
                local isIn = false
                for k, m in ipairs(v.notUses) do
                    if (curID == m) then
                        isIn = true
                        break
                    end
                end
                if (not isIn) then
                    table.insert(clothesDatas, v)
                end
            else
                table.insert(clothesDatas, v)
            end
        end
    end
    if (#clothesDatas > 0) then
        table.sort(clothesDatas, function(a, b)
            return a.id < b.id
        end)
    end
    layout:IEShowList(#clothesDatas)
end

-- 使用服装
function ClothesItemClickCB(item)
    local id = item.cfg.id
    if (SelectIDs[id] ~= nil) then
        SelectIDs[id] = nil
    else
        SelectIDs = {} -- 暂时只能穿一件
        SelectIDs[id] = 1
    end
    local arr = {}
    for k, v in pairs(SelectIDs) do
        table.insert(arr, k)
    end
    DormProto:UseClothes(roleModelsArr[curIndex].data:GetID(), arr)
end

-- 服装商店
function OnClickShop()
    -- todo
end
