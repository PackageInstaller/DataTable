-- 房间舒适度
local curIndex = nil
function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Dorm/DormComfortItem2", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function OnOpen()
    furnitureDatas = DormMgr:GetCurRoomCopyDatas() -- DormMgr:GetCurRoomData() --使用即时布局的数据
    -- furnitureDatas = curRoomData:GetFurnitureDatas()
    -- num
    local cur, max = DormMgr:GetCurRoomCopyNum() -- curRoomData:GetFurnitureNum()
    CSAPI.SetText(txtNum2, cur .. "/" .. max)
    -- comfort
    local comfort = DormMgr:GetCopyDatasComfort() -- curRoomData:GetComfort()
    local maxComfort = DormMgr:GetCurRoomData():GetLvCfg().maxComfort
    -- local _comfort = comfort>maxComfort and maxComfort or comfort
    -- CSAPI.SetText(txtComfort2, maxComfort ~= nil and (_comfort .. "/" .. maxComfort) or (_comfort .. ""))
    -- 
    local petComforts = DormPetMgr:GetComforts(DormMgr:GetCurRoomData():GetID())
    comfort = comfort + petComforts
    -- 
    CSAPI.SetText(txtComfort2, comfort .. "")
    -- effect
    local num = GCalHelp:DormTiredAddPerent(comfort)
    LanguageMgr:SetText(txtEffect3, 32015, "+" .. num .. "%")
    -- grids
    Grids()
    -- obj
    local isMax = false
    if (maxComfort and comfort >= maxComfort) then
        isMax = true
    end
    -- CSAPI.SetGOActive(objMaxComfort, isMax)
end

function Grids()
    items = items or {}
    local datas = table.copy(CfgFurnitureEnum)
    table.insert(datas, 1, {
        id = -1,
        sName = LanguageMgr:GetByID(3025)
    })
    -- 日服先不开启宠物
    --if (not CSAPI.IsADVRegional(3)) then
        table.insert(datas, 2, {
            id = 0,
            sName = LanguageMgr:GetByID(32088)
        })
    --end
    ItemUtil.AddItems("Dorm/DormComfortItem1", items, datas, grids, ItemClickCB, 1, nil, function()
        ItemClickCB(items[1])
    end)
end

function ItemClickCB(item)
    if (curIndex and curIndex == item.index) then
        return
    end
    if (curIndex ~= nil) then
        items[curIndex].Select(false)
    end
    curIndex = item.index
    items[curIndex].Select(true)
    curDatas = {}
    if (curIndex == 2) then
        local arr = DormPetMgr:GetArr(DormMgr:GetCurRoomData():GetID())
        for k, v in ipairs(arr) do
            table.insert(curDatas, {
                sName = v:GetCfg().name,
                comfort = v:GetCfg().comfort
            })
        end
    else
        if (curIndex == 1) then
            local arr = DormPetMgr:GetArr(DormMgr:GetCurRoomData():GetID())
            for k, v in ipairs(arr) do
                table.insert(curDatas, {
                    sName = v:GetCfg().name,
                    comfort = v:GetCfg().comfort
                })
            end
        end
        --
        for i, v in pairs(furnitureDatas) do
            if (curIndex == 1 or v:GetCfg().sType == (item.data.id - 1)) then
                table.insert(curDatas, v:GetCfg())
            end
        end
    end
    if (#curDatas > 0) then
        table.sort(curDatas, function(a, b)
            if (a.comfort == b.comfort) then
                return a.id < b.id
            else
                return a.comfort > b.comfort
            end
        end)
    end
    layout:IEShowList(#curDatas)
end

function OnClickMask()
    view:Close()
end
function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    txtTitle = nil;
    txtComfort = nil;
    txtEffect = nil;
    txtNum = nil;
    grids = nil;
    vsv = nil;
    view = nil;
end
----#End#----
