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
    if cfg and isFirst then
        SetGoal()
    end
end

function SetGoal(color1,color2,imgName1,imgName2)
    isFirst = true
    values.color1 = color1 or values.color1
    values.color2 = color2 or values.color2
    values.imgName1 = imgName1 or values.imgName1
    values.imgName2 = imgName2 or values.imgName2
    local completeInfo = nil
    if data and data.data then
        completeInfo = data:GetNGrade()
    end
    local starInfos = DungeonUtil.GetStarInfo2(cfg.id, completeInfo);
    for i = 1, #goGoals do
        CSAPI.SetGOActive(goGoals[i].gameObject, false)
    end
    if #starInfos > 0 then
        local Len = IsHide() and 1 or 3
        for i = 1, Len do
            if #goGoals >= i then
                CSAPI.SetGOActive(goGoals[i].gameObject, true)
                goGoals[i].Refresh(starInfos[i].tips, starInfos[i].isComplete);
            elseif recordCreates[i] == nil then
                recordCreates[i] = 1
                ResUtil:CreateUIGOAsync("FightTaskItem/FightActivityTaskItem", goalTitle, function(go)
                    goGoals = goGoals or {};
                    local item = ComUtil.GetLuaTable(go);
                    CSAPI.SetGOActive(item.gameObject, true)
                    item.Init(values.color1,values.color2,values.imgName1,values.imgName2)
                    item.Refresh(starInfos[i].tips, starInfos[i].isComplete);
                    table.insert(goGoals, item);
                end);
            end
        end
    end
end

function IsHide()
    local isHide = false
    if cfg.type == eDuplicateType.Tower or cfg.type == eDuplicateType.TaoFa or cfg.diff and cfg.diff == 3 then
        isHide = true
    end
    return isHide
end