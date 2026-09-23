-- 奖励格子，根据类型动态创建物品格子或者装备格子
local data = nil;
local elseData = nil;
local grid = nil;
local gridData = nil;
local type = RewardGridType.Goods;
local meta = {};

function Awake()
    meta = getmetatable(this);
end

-- data:GridDataBase 物品信息类
function Refresh(_d, _elseData)
    data = _d;
    elseData = _elseData;
    SetGrid();
end

function SetGrid()
    if grid ~= nil then
        grid.Remove();
        SetMetaTab(true)
        grid = nil;
    end
    if data and data.data ~= nil and data:GetClassType() == "EquipData" then
        local _, it = ResUtil:CreateEquipItem(transform);
        grid = it;
        grid.Refresh(data, elseData)
        -- grid.SetCount(data:GetCount())
        -- grid.SetLockActive(false);
        -- grid.SetEquipped();
        type = RewardGridType.Equip;
    else
        local _, it = ResUtil:CreateGridItem(transform);
        grid = it;
        grid.Refresh(data, elseData)
        --素材芯片特殊处理
        if data and data.data ~= nil then
            grid.SetCount(data:GetCount())
        end
        type = RewardGridType.Goods;
    end
    if grid then
        SetMetaTab(false);
    end
    RegisterCB()
end

-- 设置元表 isSelf：默认的元表
function SetMetaTab(isSelf)
    if this then -- 设置meta元表
        if isSelf and meta then
            setmetatable(this, meta)
        else
            setmetatable(this, {
                __index = function(mytable, key)
                    if grid ~= nil then
                        return grid[key];
                    else
                        return nil
                    end
                end
            })
        end
    end
end

function Remove()
    if grid ~= nil then
        grid.Remove();
        SetMetaTab(true)
        grid = nil;
    end
    CSAPI.RemoveGO(gameObject);
end

function GetType()
    return type;
end

---------------------------------------------------------------------------- 
function SetIndex(_index)
    index = _index
    RegisterIndex()
end
function RegisterIndex()
    if (grid ~= nil and grid.SetIndex) then
        grid.SetIndex(index)
    end
end
function SetClickCB(_cb)
    cb = _cb
    RegisterCB()
end
function RegisterCB()
    if (grid ~= nil and grid.SetClickCB) then
        grid.SetClickCB(cb)
    end
end
-- 隐藏num 
function SetCount(num)
    if (grid ~= nil) then
        num = num or 0
        grid.SetCount(num)
    end
end

function SetDowmCount(str)
    if (grid ~= nil) then
        grid.SetDownCount(str)
    end
end

