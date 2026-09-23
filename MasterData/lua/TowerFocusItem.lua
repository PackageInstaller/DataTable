local data = nil
local cfgCard = nil --cardData
local isPass = false
local gridInfos = {}
local gridPos = {}

function SetClickCB(_cb)
    cb = _cb
end

function SetIndex(idx)
    index= idx
end

function Refresh(_data,_elseData)
    data = _data
    isPass = _elseData and _elseData.isPass
    if data then
        cfgCard = data.cfg
        SetIcon()
        SetHP()
        SetSP()
        SetState()
    end
end

function SetIcon()
    local cfgModel = Cfgs.character:GetByID(cfgCard.model);
    local customIcon = cfgModel and cfgModel.ai_icon;
    if(customIcon)then
        ResUtil.RoleCardCustom:Load(icon, customIcon,true,UpdateSize);
    else
        ResUtil.RoleCard:Load(icon, cfgModel.icon,true,UpdateSize);
    end
end

function UpdateSize()
    local size = CSAPI.GetRTSize(icon);
    if(not size)then
        return;
    end
    local x = size[0] * 0.81 or 174;
    local y = size[1] * 0.81 or 174;
    CSAPI.SetRTSize(gameObject,x,y)
    CSAPI.SetScale(hpObj,x / 174,1,1);
    CSAPI.SetScale(spImg,x / 174,1,1);
end

function SetHP()
    CSAPI.SetRTSize(hpObj,174 * data.hp,10)
end

function SetSP()
    CSAPI.SetRTSize(spImg,173 * data.sp,4)
end

function SetState()
    CSAPI.SetGOActive(killObj, isPass or data.hp <= 0)
    CSAPI.SetGOActive(hpObj,not (isPass or data.hp <= 0))
    CSAPI.SetGOActive(spImg,not (isPass or data.hp <= 0))
end

function SetPos(p)
    UpdatePlace(p)
end

--更新占位
function UpdatePlace(p)
    CSAPI.SetAnchor(gameObject,(p[1] - 1) * 192,-(p[2] - 1) * 192,0);

    local cfg = Cfgs.MonsterFormation:GetByID(cfgCard.grids)
    gridInfos = cfg and cfg.coordinate;
    --log

    -- LogError("绝对坐标：第" ..p[1].."列,第" .. p[2].."行")
    -- if gridInfos then
    --     local str = ""
    --     for i, v in ipairs(gridInfos) do
    --         str = str .. v[1] .."," ..v[2]
    --         if i ~= #gridInfos then
    --             str = str .. "|"
    --         end
    --     end
    --     LogError("相对坐标：" .. str)
    -- end

    local minRow,maxRow,minCol,maxCol;

    gridPos = {}
    table.insert(gridPos,p)
    if(gridInfos)then 
        for _,grid in ipairs(gridInfos)do
            local currRow = grid[1];
            local currCol = grid[2];
            
            minRow = minRow and math.min(minRow,currRow) or currRow;
            maxRow = maxRow and math.max(maxRow,currRow) or currRow;

            minCol = minCol and math.min(minCol,currCol) or currCol;
            maxCol = maxCol and math.max(maxCol,currCol) or currCol;
            if currRow ~= 0 or currCol ~= 0 then
                table.insert(gridPos,{currRow +p[1], currCol + p[2]})
            end
        end

        minRow = minRow or 0;
        maxRow = maxRow or 0;
        minCol = minCol or 0;
        maxCol = maxCol or 0;

        local x = (maxRow + minRow) / 2;
        x =(p[1] - 1) * 192 + x * 192;
        local y = (maxCol + minCol) / 2;
        y = -(p[2] - 1) * 192 - y * 192;

        CSAPI.SetAnchor(gameObject,x,y,0);
    end
end

function GetGridPos()
    return gridPos
end

function GetID()
    return cfgCard.id
end

function IsDead()
    return isPass or data.hp <= 0
end

function OnClick()
    if cb then
        cb(this)
    end
end

