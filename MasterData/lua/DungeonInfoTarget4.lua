local cfg = nil
local data = nil
local sectionData = nil
local goGoals = {}
local recordCreates = {}
local values = {}

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        
    end
end

function ShowGoals(infos,color1,color2,imgName1,imgName2)
    if infos == nil then
        return
    end
    values.color1 = color1 or values.color1
    values.color2 = color2 or values.color2
    values.imgName1 = imgName1 or values.imgName1
    values.imgName2 = imgName2 or values.imgName2

    if #goGoals > 0 then
        for i, v in ipairs(goGoals) do
            CSAPI.SetGOActive(v.gameObject,false)
        end
    end

    if #infos > 0 then
        for i = 1, #infos do
            if #goGoals >= i then
                CSAPI.SetGOActive(goGoals[i].gameObject, true)
                goGoals[i].Refresh(infos[i].tips, infos[i].isComplete);
            elseif recordCreates[i] == nil then
                recordCreates[i] = 1
                ResUtil:CreateUIGOAsync("FightTaskItem/FightActivityTaskItem", goalTitle, function(go)
                    local item = ComUtil.GetLuaTable(go);
                    item.Init(values.color1,values.color2,values.imgName1,values.imgName2)
                    item.Refresh(infos[i].tips, infos[i].isComplete);
                    table.insert(goGoals, item);
                end);
            end
        end
    end
end