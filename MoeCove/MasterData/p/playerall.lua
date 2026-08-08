local _mt = {}
if GV.IsServer and GF.checkNeedInitHotfixModule("PlayerAllReload") then
    require "PlayerAllReload"
end

--扩展方法
function _mt.loadAllModules(isHotfix)
    local Player = require "Player"
    --扩展列表
    local extend_list = {
        "Player_dataConvert",
        "Player_ticket",
        "Player_hero",
        "Player_itemProp",
        "Player_equip",
        "Player_level",
        "Player_homeland",
        "Player_genRoleFrag",
        "Player_technologyTree",
        "Player_weapon",
        "Player_task",
        "Player_handbook",
        "Player_dataLoader",
        "Player_skin",
        "Player_gacha",
        "Player_battle",
        "Player_talentTree",
        "Player_saveDBResp",
        "Player_cosLog",
        "Player_friend",
        "Player_mail",
        "Player_sign",
        "Player_affection",
        "Player_pay",
        "Player_shop",
        "Player_KJshop",
        "Player_trigger",
        "Player_dispatch",
        "Player_simulated",
        "Player_extraRewards",
        "Player_homelandAction",
        "Player_homelandStorageAction",
        "Player_HomelandCoveProps",
        "Player_homelandBattle",
        "Player_weatherForecast",
        "Player_qnaire",
        "Player_activity",
        "Player_pass",
        "Player_cycleCardAction",
        "Player_bossActivity",
        "Player_combatIntelligence",
        "Player_extend1",
        "Player_funcOpen",
    }

    for _, name in pairs(extend_list) do
        if isHotfix and GV.IsServer then
            GF.HotfixModule(name)
        else
            ReloadModule(name)
        end
    end

    return Player
end

return _mt