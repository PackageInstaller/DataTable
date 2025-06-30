local EquipInfoMock = BaseClass("EquipInfoMock", Singleton);
local maxId = 0
local mockData = {} -- key: id, value: equip

local EQUIPMENT_PACK_LIMIT = tonumber(Z_Misc["EQUIPMENT_PACK_LIMIT"].Value[1])

local function updateData(removeIds, updateIds)
    ---@type protocol.EquipmentPackUpdatePush
    local ret = {}
    ret.equipment_pack = {}
    ret.removeds = removeIds or {}
    ret.equipment_pack.equipments = {}
    if updateIds ~= nil then
        for key, value in pairs(updateIds) do
            table.insert(ret.equipment_pack.equipments, mockData[value])
        end
    end
    Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.EquipmentPackUpdatePush, ret)
end

local function EquipmentPackReq(reqMsg)
    ---@type protocol.EquipmentPackResp
    local ret = {}
    ret.equipment_pack = {}
    ret.equipment_pack.equipments = {}
    ret.equipment_pack.capacity = EQUIPMENT_PACK_LIMIT * 5
    for key, value in pairs(Z_Equip) do
        ---@type protocol.Equipment
        local equip = {}
        maxId = maxId + 1
        equip.cid = key
        equip.eid = maxId
        equip.level = 1
        equip.lock = false
        equip.character_id = 0
        mockData[maxId] = equip
        table.insert(ret.equipment_pack.equipments, equip)
    end
    return ret
end

---@param reqMsg protocol.EquipmentPackScrapReq
local function EquipmentPackScrapReq(reqMsg)
    ---@type protocol.EquipmentPackScrapResp
    local ret = {}
    ret.reward_details = {}
    for _, eid in pairs(reqMsg.eids) do
        mockData[eid] = nil
        table.insert(ret.reward_details,
        {
            rewards = {},
            reward_results = {}
        }
    )
    end
    updateData(reqMsg.eids)
    return ret
end

---@param reqMsg protocol.EquipmentPackLevelUpReq
local function EquipmentPackLevelUpReq(reqMsg)
    mockData[reqMsg.eid].level = mockData[reqMsg.eid].level + 1
    updateData(nil, {reqMsg.eid})
    return {}
end

---@param reqMsg protocol.EquipmentPackLockReq
local function EquipmentPackLockReq(reqMsg)
    mockData[reqMsg.eid].lock = reqMsg.lock
    updateData(nil, {reqMsg.eid})
    return {}
end

---@param changeEquips {eid:number, characterId:number}[] @ table中每一组数据为 eid, characterId(nil表示未装备)
local function EquipCharacter(changeEquips)
    local updateIds = {}
    for key, value in pairs(changeEquips) do
        table.insert(updateIds, value.eid)
        mockData[value.eid].character_id = value.characterId
    end
    updateData(nil, updateIds)
end

local function __init(self)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.EquipmentPackReq, EquipmentPackReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.EquipmentPackScrapReq, EquipmentPackScrapReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.EquipmentPackLevelUpReq, EquipmentPackLevelUpReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.EquipmentPackLockReq, EquipmentPackLockReq)
end

local function __delete(self)
end

EquipInfoMock.__init = __init
EquipInfoMock.__delete = __delete
EquipInfoMock.EquipCharacter = EquipCharacter

return EquipInfoMock;