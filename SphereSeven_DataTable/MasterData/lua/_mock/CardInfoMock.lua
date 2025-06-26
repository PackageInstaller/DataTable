local CardInfoMock = BaseClass("CardInfoMock", Singleton);

local cardInfo = {}
local characterSkills = {}
local characters = {}

local function CharacterPackUpdatePush(characterInfo)
    local currentCharacter = {}
    for _, value in ipairs(characters) do
        if value.id == characterInfo.id then
            currentCharacter = value
        end
    end

    currentCharacter.level = 10
    
    Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.CharacterPackUpdatePush, currentCharacter)
end

local function CardInfo(reqMsg)
    local rspMsg = 
    {
        RpcId = reqMsg.RpcId,
        Error = 0,
        CardInfoList = 
        {
            {
                AdornEquip = 0,
                BodyEquip = 0,
                CardId = -7798582108887973866,
                CloseDegree = 0,
                ConstelLevel = 0,
                Exp = 0,
                FightSoul1 = -7792444549082382314,
                FightSoul2 = 0,
                FightSoul3 = 0,
                FootEquip = 0,
                Hand1Equip = -7798292421928812522,
                Hand2Equip = -7798292421931171818,
                HeadEquip = 0,
                JadePearlLevel = 0,
                Level = 1,
                LevelLimit = 40,
                Lock = 0,
                PlayedNum = 0,
                SkinId = 4,
                Stage = 1,
                Star = 1,
                Support = 0,
                TemplateId = 1001
            }
        }
    }

    cardInfo = rspMsg

    local updateMsg = {
        id = 1,
		level = 2,
		exp = 3,
		intimacy = 4,
		bead = 5,
		constellation = 6,
		evolution = 7,
		skin = 8,
		skills = 9,
    }

    Game.Scene:GetComponent("MessageDispatcherComponent"):Handle(PROTOCOL.CharacterPackUpdatePush, updateMsg)
    return rspMsg
end

local function CharacterPackInfoReq(reqMsg)
    local rspMsg = {}
    
    local character_pack = {}
    local skins = {}
    
    for _, characterInfo in pairs(Z_Character) do
        if characterInfo.Enable == 1 then
            skills = {}
            if Z_CharacterEvolution[characterInfo.Id] ~= nil then
                for _, value in ipairs(Z_CharacterEvolution[characterInfo.Id]) do
                    if value.PassiveSkill ~= 0 then
                        skills.PassiveSkill = value.PassiveSkill
                    end
                    if value.Attack ~= 0 then
                        skills.Attack = value.Attack
                    end
                    if value.Skill ~= 0 then
                        skills.Skill = value.Skill
                    end
                    if value.Ultimate ~= 0 then
                        skills.Ultimate = value.Ultimate
                    end
                end
            end
            table.insert(characters, 
            {
                id = characterInfo.Id,
		        level = 1,
		        exp = 0,
		        intimacy = 3,
		        bead = 3,
		        constellation = 5,
		        star = 3,
                evolution = 4,
		        skin = characterInfo.Id * 100 + 1 ,
                skills = skills,
                equipments = {
                    {
                        eid = 21022,
                        slot = 1
                    }
                }
            })
            table.insert(skins, characterInfo.Id * 100 + 1)
        end
    end
    character_pack.characters = characters
    character_pack.skins = skins

    rspMsg.character_pack = character_pack
    return rspMsg
end

local function CharacterPackLevelUpReq(reqMsg)
    local items = reqMsg.items
    local characterId = reqMsg.id

    local currentCharacter = {}
    for _, value in ipairs(characters) do
        if value.id == characterId then
            currentCharacter = value
        end
    end

    local exp = currentCharacter.exp
    local level = currentCharacter.level

    CharacterPackUpdatePush(currentCharacter)
end

local function CharacterPackBeadReq(reqMsg)
    local id = reqMsg.id

    local currentCharacter = {}
    

    CharacterPackUpdatePush(currentCharacter)
end

local function CharacterPackEvolveReq(reqMsg)
    local id = reqMsg.id
    
    local currentCharacter = {}
    
    for _, value in ipairs(characters) do
        if value.id == id then
            currentCharacter = value
        end
    end

    currentCharacter.constellation = currentCharacter.constellation + 1

    CharacterPackUpdatePush(currentCharacter)
end

local function CharacterPackIntimacyReq(reqMsg)
    local id = reqMsg.id
    
    local currentCharacter = {}
    

    CharacterPackUpdatePush(currentCharacter)
end

local function CharacterPackConstellationReq(reqMsg)
    local id = reqMsg.id
    local items = reqMsg.items
    
    local currentCharacter = {}

    for _, value in ipairs(characters) do
        if value.id == id then
            currentCharacter = value
        end
    end

    currentCharacter.evolution = currentCharacter.evolution + 1
    

    CharacterPackUpdatePush(currentCharacter)
end

local function GetCharacters(self)
    return characters
end

local function __init(self) 
    MockManager:GetInstance():RegisterMsgHandler(OuterOpcode.Name2Code.ETModel_C2M_CardInfo, CardInfo)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.CharacterPackInfoReq, CharacterPackInfoReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.CharacterPackLevelUpReq, CharacterPackLevelUpReq)
    -- MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.CharacterPackBeadReq, CharacterPackBeadReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.CharacterPackEvolutionReq, CharacterPackEvolveReq)
    -- MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.CharacterPackIntimacyReq, CharacterPackIntimacyReq)
    MockManager:GetInstance():RegisterMsgHandler(PROTOCOL.CharacterPackConstellationReq, CharacterPackConstellationReq)
end

local function __delete(self)
end

CardInfoMock.__init = __init
CardInfoMock.__delete = __delete
CardInfoMock.GetCharacters = GetCharacters

return CardInfoMock;