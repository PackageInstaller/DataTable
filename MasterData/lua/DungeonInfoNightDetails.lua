
local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then

    end
end

function OnClickEnemy()
    local list = {};
    if cfg and cfg.enemyPreview then
        for k, v in ipairs(cfg.enemyPreview) do
            local cfg = Cfgs.CardData:GetByID(v);
            table.insert(list, {
                id = v,
                isBoss = k == 1
            });
        end
    end
    CSAPI.OpenView("FightEnemyInfo", list);
end