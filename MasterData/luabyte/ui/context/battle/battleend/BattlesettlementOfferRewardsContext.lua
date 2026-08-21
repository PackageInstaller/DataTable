local M = BaseClass("BattlesettlementOfferRewardsContext", BaseContext)

function M:Open(wantedId, isWin, wordsMask, curLevel, totalExp)
    local wanted = ConfigHelper.GetCfgByLua("wanted", wantedId)
    local listData = {}
    if wanted then
        for i, id in ipairs(wanted.mapConditionId) do
            local isDone = (1 << (i - 1)) & wordsMask ~= 0
            table.insert(listData, {
                IsWin = isDone,
                EntryId = id --mcrandom
            })
        end
    else
        Logger.LogError("wanted is nil, 检查配置, id = " .. wantedId)
    end
    local mission = IBattle.context.missionData
    self:_Show(mission, listData, curLevel, totalExp)
end

return M
