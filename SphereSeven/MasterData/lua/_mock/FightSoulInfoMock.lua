local FightSoulInfoMock = BaseClass("FightSoulInfoMock", Singleton);

local _newestId = 0
local fightSouls = {}
local FIGHT_SOUL_MERGE_COUNT_LIMIT = tonumber(Z_Misc["FIGHT_SOUL_MERGE_COUNT_LIMIT"].Value[1])

local function UpdatePush(updateFightSoulIds, removedIds, bagCapacity)
    ---@type protocol.FightSoulUpdatePush
    local ret = {}
    ret.bag_capacity = bagCapacity
    ret.fight_souls = {}
    ret.removeds = removedIds or {}

    if updateFightSoulIds ~= nil then
        for _, id in pairs(updateFightSoulIds) do
            table.insert(ret.fight_souls, fightSouls[id])
        end
    end

    Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.FightSoulUpdatePush, ret)
end


---@param reqMsg protocol.FightSoulReq
local function FightSoulReq(reqMsg)
    ---@type protocol.FightSoulResp
    local rspMsg = {}
    rspMsg.bag_capacity = tonumber(Z_Misc["FIGHT_SOUL_DEFAULT_BAG_CAPACITY"].Value[1])
    rspMsg.fight_souls = {}
    for key, value in pairs(Z_FightSoul) do
        _newestId = _newestId + 1
        local mergeLevel = Mathf.Random(1,FIGHT_SOUL_MERGE_COUNT_LIMIT)
        local fightSoul = {
            uid = _newestId,
            cid = key,
            exp = 0, -- 当前经验值
            level = 1, -- Mathf.Random(1, tonumber(Z_Misc["FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE"].Value[mergeLevel]))
            merge_level = mergeLevel,
            locked = Mathf.Random(1,2) == 2
        }
        table.insert(rspMsg.fight_souls, fightSoul)
        fightSouls[_newestId] = fightSoul
    end
    for key, value in pairs(Z_FightSoul) do
        _newestId = _newestId + 1
        local mergeLevel = Mathf.Random(1,FIGHT_SOUL_MERGE_COUNT_LIMIT)
        local fightSoul = {
            uid = _newestId,
            cid = key,
            exp = 0, -- 当前经验值
            level = 2, -- Mathf.Random(1, tonumber(Z_Misc["FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE"].Value[mergeLevel]))
            merge_level = mergeLevel,
            locked = Mathf.Random(1,2) == 2
        }
        table.insert(rspMsg.fight_souls, fightSoul)
        fightSouls[_newestId] = fightSoul
    end
    for key, value in pairs(Z_FightSoul) do
        _newestId = _newestId + 1
        local mergeLevel = Mathf.Random(1,FIGHT_SOUL_MERGE_COUNT_LIMIT)
        local fightSoul = {
            uid = _newestId,
            cid = key,
            exp = 0, -- 当前经验值
            level = 1, -- Mathf.Random(1, tonumber(Z_Misc["FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE"].Value[mergeLevel]))
            merge_level = mergeLevel,
            locked = false
        }
        table.insert(rspMsg.fight_souls, fightSoul)
        fightSouls[_newestId] = fightSoul
    end
    for key, value in pairs(Z_FightSoul) do
        _newestId = _newestId + 1
        local mergeLevel = Mathf.Random(1,FIGHT_SOUL_MERGE_COUNT_LIMIT)
        local fightSoul = {
            uid = _newestId,
            cid = key,
            exp = 0, -- 当前经验值
            level = 2, -- Mathf.Random(1, tonumber(Z_Misc["FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE"].Value[mergeLevel]))
            merge_level = mergeLevel,
            locked = false
        }
        table.insert(rspMsg.fight_souls, fightSoul)
        fightSouls[_newestId] = fightSoul
    end
    for key, value in pairs(Z_FightSoul) do
        _newestId = _newestId + 1
        local mergeLevel = Mathf.Random(1,FIGHT_SOUL_MERGE_COUNT_LIMIT)
        local fightSoul = {
            uid = _newestId,
            cid = key,
            exp = 0, -- 当前经验值
            level = 1, -- Mathf.Random(1, tonumber(Z_Misc["FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE"].Value[mergeLevel]))
            merge_level = mergeLevel,
            locked = false
        }
        table.insert(rspMsg.fight_souls, fightSoul)
        fightSouls[_newestId] = fightSoul
    end

    return rspMsg
end

---@param msg protocol.FightSoulExpStrengthenReq
local function FightSoulExpStrengthenReq(msg)
    local fightSoul = fightSouls[msg.uid]
    local level = fightSoul.level
    local exp = fightSoul.exp
    for key, value in pairs(msg.materials) do
        if Z_Item[value.uid].UseType == ItemUseType.ItemUseTypeFightSoulLevelUp then
            exp = exp + Z_Item[value.uid].UseParams[1] * value.count
        end
    end

    local maxLevel = tonumber(Z_Misc["FIGHT_SOUL_LEVEL_LIMIT_BY_MERGE"].Value[fightSoul.merge_level])
    local rare = Z_FightSoul[fightSoul.cid].Rare
    for i = fightSoul.level, maxLevel - 1 do
        local needExp = Z_FightSoulLevelUpExp[i][RarityName[rare]]
        if exp >= needExp then
            exp = exp - needExp
            level = i + 1
        else
            break
        end
    end
    -- 最后剩余经验 exp, 等级 level
    fightSouls[msg.uid].exp = exp
    fightSouls[msg.uid].level = level

    UpdatePush({msg.uid})

    local ret = {}
    return ret
end

---@param msg protocol.FightSoulMergeReq
local function FightSoulMergeReq(msg)
    local fightSoul = fightSouls[msg.uid]

    local removeIds = {}
    for key, value in pairs(msg.materials) do
        table.insert(removeIds, value)
        fightSoul.merge_level = fightSoul.merge_level + fightSouls[value].merge_level
        fightSouls[value] = nil
    end
    if fightSoul.merge_level > FIGHT_SOUL_MERGE_COUNT_LIMIT then
        fightSoul.merge_level = FIGHT_SOUL_MERGE_COUNT_LIMIT
    end

    UpdatePush({msg.uid}, removeIds)

    local ret = {}
    return ret
end

---@param msg protocol.FightSoulDecomposeReq
local function FightSoulDecomposeReq(msg)
    ---@type protocol.FightSoulDecomposeResp
    local req = {}
    req.reward_results = {}
    local removedIds = {}
    for _, uid in ipairs(msg.uids) do
        table.insert(removedIds, uid)
        local zFightSoul = Z_FightSoul[fightSouls[uid].cid]
        local rare = zFightSoul.Rare
        local rewardId = Z_FightSoulDecompose[rare].RewardId
        local rewardList = Z_Reward[rewardId]
        for _, value in pairs(rewardList) do
            local rewardResult = {
                type = value.Type,
                id = value.ObjId,
                count = value.Count
            }
            table.insert(req.reward_results, rewardResult)
        end
        -- MockManager:GetInstance():GetMock("ItemMock"):ChangeItemCount()
        
    end

    UpdatePush({}, removedIds, nil)
    return req
end

---@param msg protocol.FightSoulSetLockingReq
local function FightSoulSetLockingReq(msg)
    local req = {}
    fightSouls[msg.uid].locked = msg.lock
    UpdatePush({msg.uid}, {}, nil)

    return req
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.FightSoulReq, FightSoulReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.FightSoulExpStrengthenReq, FightSoulExpStrengthenReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.FightSoulMergeReq, FightSoulMergeReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.FightSoulDecomposeReq, FightSoulDecomposeReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.FightSoulSetLockingReq, FightSoulSetLockingReq)
end

local function __delete(self)
end

FightSoulInfoMock.__init = __init
FightSoulInfoMock.__delete = __delete


return FightSoulInfoMock