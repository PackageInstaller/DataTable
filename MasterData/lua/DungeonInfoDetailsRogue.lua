
-- _data :RogueData
function Refresh(_data) 
    data = _data
end

function OnClickEnemy()
    local monsters = data:GetMonsters()
    CSAPI.OpenView("FightEnemyInfo", monsters)
end