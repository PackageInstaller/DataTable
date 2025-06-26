
---@class BossraidComponent
---@field bossraides Bossraid[]
local BossraidComponent = BaseClass("BossraidComponent", Component)
local base = Component
local this = BossraidComponent

function this:Awake()
    base.Awake(self)
    self.bossraides = {}
end

function this:Dispose()
    base.Dispose(self)
end

function this:RequestBossraidInfos()
    for k, v in pairs(Z_Bossraid) do
        local currentTime = TimeUtil.GetServerTime()
        if currentTime > TimeUtil.ParseDateTime(v.StartTime) 
            and currentTime < TimeUtil.ParseDateTime(v.EndTime) 
        then
            self:RequestBossraidInfo(v.Id)
        end
    end
end

function this:RequestBossraidInfo(bossraidId)
    -- local response = {
    --     info = {
    --         bossraid_id = bossraidId,
    --         received_reward = {},
    --         record = {
    --             level_id = 101,
    --             formations = {},
    --             score = 0,
    --             battle_time = os.time(),
    --         },
    --         level_status = {
    --             {
    --                 level_id = 102,
    --                 passed = true,
    --                 highest_score = 999,
    --             },
    --             {
    --                 level_id = 103,
    --                 passed = false,
    --                 highest_score = 0,
    --             },
    --         },
    --         rank = 9999,
    --         remain_battle = {
    --             level_id = 102,
    --             used_role = {
    --                 1001, 1002
    --             },
    --             used_support = false,
    --             is_simulate = false,
    --             battle_start_time = TimeUtil.GetServerTime() - 1200,
    --             monsters = {},
    --         },
    --     }
    -- }
    -- self:AddOrUpdateBossraid(response)

    PublicRequest.SendRequest(
        PROTOCOL.BossraidInfoReq,
        {
            bossraid_id = bossraidId
        },
        function(response, errorCode)
            if errorCode == 0 or errorCode == nil then
                self:AddOrUpdateBossraid(response.info)
            end
        end
    )
end

---@param msg protocol.BossraidInfo
function this:AddOrUpdateBossraid(msg)
    if self.bossraides[msg.bossraid_id] == nil then
        self.bossraides[msg.bossraid_id] = Game.Registry:NewObject("Bossraid", msg)
    else
        self.bossraides[msg.bossraid_id]:UpdateData(msg)
    end
end

local function getTestData()
    return nil
    --     return {
    --         bossraidId = 1,
    --         receivedReward = {1, 2},
    --         record = {
    --             levelId = 101,
    --             score = 2,
    --             battleTime = 0,
    --             formations = {},
    --             levelConfig = Z_BossraidLevel[101],
    --         },
    -- levelStatus = {},
    -- rank = 1,
    -- config = Z_Bossraid[1],
    -- remainBattle= {},
    --     }
end
                                                                                                                                                                                                                                                                                                                         
---@return Bossraid
function this:GetFirstBossraid(id)
    local ret
    if id ~= nil then
        ret = self.bossraides[id]
    else
        for _, bossraid in pairs(self.bossraides) do
            if ret == nil or bossraid.bossraidId < ret then
                ret = bossraid
            end
        end
    end

    if ret == nil then
        ret = getTestData()
    end
    return ret
end

---@return Bossraid
function this:GetBossraidById(id)
    local ret = self.bossraides[id]
    if ret == nil then
        ret = getTestData()
    end
    return self.bossraides[id]
end

function this:GetBossraid(id)
    if id ~= nil then
        return self.bossraides[id]
    else
        return self.bossraides
    end
end

function this:GetLeaderboard(bossraidId, startRank, endRank, callback)
--     Logger.Log("GetLeaderboard " ..  startRank .. " " .. endRank)
--     local portraits = {}
--     for k, v in pairs(Z_HeadPortrait) do
--         table.insert(portraits, k)
--     end
--     local tab = {}
--     for i = startRank, endRank + 1 do
--         local portrait = portraits[i // table.count(portraits)]
--         table.insert(tab, {
--             role_id = i + 100000,
--             username = i,
--             level = i // 100,
--             portrait = portrait,
--             rank = i,
--             record = {
--                 level_id = 101,
--                 score = 10000 - i,
--                 battle_time = TimeUtil.GetServerTime(),
--                 formations = {
--                     {
--                         units = {},
--                         support_unit = {
--                             character_id = 0
--                         },
--                         encyclopedia_enhance = {
--                             hp_enhance = 1,
--                             atk_enhance = 2,
--                             def_enhance = 3,
--                             mdef_enhance = 4,
--                             speed_enhance = 5,
--                         }
--                     }
--                 }
--             }
--         })
--     end
-- for _, record in ipairs(tab) do
--     self.bossraides[bossraidId]:SetLeader(record)
-- end
--                 if callback ~= nil then
--                     callback()
--                 end
    ---@param response protocol.BossraidLeaderboardResp
    PublicRequest.SendRequest(
        PROTOCOL.BossraidLeaderboardReq,
        {
            bossraid_id = bossraidId,
            start_rank = startRank,
            end_rank = endRank
        },
        function(response, errorCode)
            if errorCode == 0 or errorCode == nil then
                if response.records ~= nil then
                    for _, record in ipairs(response.records) do
                        self.bossraides[response.bossraid_id]:SetLeader(record)
                    end
                end
                if callback ~= nil then
                    callback()
                end
            else
                if callback ~= nil then
                    callback()
                end
            end
        end
    )
end

function this:RemoveBossraid(id)
    self.bossraides[id] = nil
end

return this




