local cfg = nil
local data = nil
local sectionData = nil
local goGoals = {}

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        ShowStarInfo()
    end
end

-- 显示条件信息
function ShowStarInfo()
    if #goGoals > 0 then
        for i, v in ipairs(goGoals) do
            CSAPI.SetGOActive(v.gameObject,false)
        end
    end
    local _cfg = cfg
    if _cfg.teamLimted then
        local condition = TeamCondition.New()
        condition:Init(_cfg.teamLimted)
        local list = condition:GetDesc()
        if _cfg.tacticsSwitch then
            table.insert(list,LanguageMgr:GetByID(49028))
        end
        if list and #list> 0 then
            for i = 1, #list do
                if #goGoals >= i then
                    CSAPI.SetGOActive(goGoals[i].gameObject, true)
                    goGoals[i].Init(list[i]);
                else
                    ResUtil:CreateUIGOAsync("FightTaskItem/FightRogueTTaskItem", goalTitle, function(go)
                        goGoals = goGoals or {};
                        local item = ComUtil.GetLuaTable(go);
                        CSAPI.SetGOActive(item.gameObject, true)
                        item.Init(list[i]);
                        table.insert(goGoals, item);
                    end);
                end
            end
        end
    end
end
