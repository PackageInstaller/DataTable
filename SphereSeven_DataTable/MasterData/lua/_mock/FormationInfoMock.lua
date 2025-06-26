---@class TeamInfoMock
---@field formationsList table<number, protocol.Formations> @ key: FormationsType, value: type/formations(每个编队的内容)
local TeamInfoMock = BaseClass("TeamInfoMock", Singleton)
local this = TeamInfoMock
local FORMATIONS_COUNT = tonumber(Z_Misc["FORMATIONS_COUNT"].Value[1])
local FORMATION_CHARACTER_COUNT = tonumber(Z_Misc["FORMATION_CHARACTER_COUNT"].Value[1])

---@param changedIds table<number, number[]> @ key: FormationsType, value: id的数组
local function updateData(changedIds)
    ---@type protocol.FormationUpdatePush
    local msg = {}
    msg.formations_list = {}
    msg.formations_list.formations_list = {}

    for type, ids in pairs(changedIds) do
        local updateType = {}
        updateType.type = type
        updateType.formations = {}
        for _, id in pairs(ids) do
            table.insert(updateType.formations, this.formationsList[type][id])
        end
        table.insert(msg.formations_list.formations_list, updateType)
    end

    Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.FormationUpdatePush, msg)
end

local function TeamInfo(reqMsg)
    ---@type protocol.FormationsListInfoResp
    local rspMsg = {}
    rspMsg.formations_list = {}
    rspMsg.formations_list.formations_list = {} -- FormationsList, 是一个formations的数组
    rspMsg.formations_list.formations_list[FormationsType.FormationsTypeSystem] = { -- formations (type 和 每个编队)
        type = FormationsType.FormationsTypeSystem,
        formations = {}
    }

    this.formationsList[FormationsType.FormationsTypeSystem] = {}

    -- 这部分是system编队
    local characters = MockManager:GetInstance().GetMock("CardInfo"):GetCharacters()
    for i = 1, FORMATIONS_COUNT do
        local formation = {}
        formation.id = i
        formation.id_list = {}
        formation.fight_soul_list = {}
        for j = 1, FORMATION_CHARACTER_COUNT do
            if characters[j+i-1] == nil or (j+i-1) %2 == 0 then
                table.insert(formation.id_list, 0)
            else
                table.insert(formation.id_list, characters[j+i-1].id)
            end
            table.insert(formation.fight_soul_list, 0)
        end
        this.formationsList[FormationsType.FormationsTypeSystem][formation.id] = formation
        table.insert(rspMsg.formations_list.formations_list[FormationsType.FormationsTypeSystem].formations, formation)
    end

    rspMsg.formations_list.formations_list[FormationsType.FormationsTypeArena] = { -- formations (type 和 每个编队)
        type = FormationsType.FormationsTypeArena,
        formations = {
            {
                id = 1,
                id_list = {},
                fight_soul_list = {},
            }
        }
    }
    this.formationsList[FormationsType.FormationsTypeArena] = {
        rspMsg.formations_list.formations_list[FormationsType.FormationsTypeArena].formations[1]
    }

    return rspMsg
end

---@param msg protocol.FormationModifyReq
local function FormationModifyReq(msg)

    if this.formationsList[msg.type] == nil then
        Logger.LogError("FormationModifyReq error, type不存在 : "..msg.type)
        return
    end

    this.formationsList[msg.type][msg.formation.id] = msg.formation

    updateData({
        [msg.type] = {msg.formation.id}
    })

    local reqMsg = {}
    return reqMsg
end

local function __init(self)
    this.formationsList = {}
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.FormationsListInfoReq, TeamInfo)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.FormationModifyReq, FormationModifyReq)
end

local function __delete(self)
end

this.__init = __init
this.__delete = __delete


return this