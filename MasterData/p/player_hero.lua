-- Desc: 玩家角色相关逻辑

---@class Player
local Player = require "Player"
local utf8util = require "utf8util"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end


--技能槽数量
local skillSlotCount = 3
--装备槽数量
local equipSlotCount = 4
--武器槽数量
local weaponSlotCount = 2

--获取角色列表
function Player:getHeroList()
    return self.heroList
end

--通过id查找角色信息
---@param id integer 角色id
---@return HeroInfo?
function Player:getPlayerHero(id)
    if not self.heroList then
        self.heroList = {}
    end
    return self.heroList[id]
end

--更新角色数据
---@param data HeroInfo
function Player:updateHero(data)
    local heroList = self:getHeroList()
    local hero = self:getPlayerHero(data.id)
    local needSetAttr = false

    if hero then
        -- 仅当传入数据中包含关键字段时才重新计算属性
        local checkKeys = {"level", "exp", "star", "carryEquip", "talentTreeList", "EquippedSkillList", "carryWeapon"}
        for _, key in ipairs(checkKeys) do
            if data[key] ~= nil then
                needSetAttr = true
                break
            end
        end
        for k, v in pairs(data) do
            hero[k] = v
        end
    else
        -- 新增角色，必须初始化属性
        hero = data
        heroList[data.id] = hero
        needSetAttr = true
    end

    if needSetAttr then
        self:setHeroAttribute(hero)
    end
end

--获取角色基础属性
function Player:getHeroBaseAttr(heroId)
    local attr = {
        hp = 0,
        armor = 0,
        evade = 0,
        bombard = 0,
        torpedo = 0,
        lucky = 0,
        airdefense = 0,
    }
    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo then
        LuaLogger.e("getHeroBaseAttr failed, no heroInfo found for heroId:".. heroId)
        return attr
    end
    local heroCfg = Config.GetCharacterInfo(heroId)
    if not heroCfg then
        LuaLogger.e("getHeroBaseAttr failed, no heroCfg found for heroId:".. heroId)
        return attr
    end
    attr.hp = heroCfg.hp
    attr.armor = heroCfg.armor
    attr.evade = heroCfg.evade
    attr.bombard = heroCfg.bombard
    attr.torpedo = heroCfg.torpedo
    attr.lucky = heroCfg.lucky
    attr.airdefense = heroCfg.airdefense
    --等级系数
	local levelCoef = heroInfo.level - 1
    --天赋树属性加成（白值）
    local talentTreeBonus = self:getTalentTreeBonus(heroCfg.talentTree, heroInfo.talentTreeList, heroInfo.talentTreeStage)
    attr.hp = math.floor((attr.hp + heroCfg.hpAddition * levelCoef) * (heroCfg.hpStar[heroInfo.star])) + talentTreeBonus.hp
    attr.armor = math.floor((attr.armor + heroCfg.armAddition * levelCoef) * (heroCfg.armStar[heroInfo.star])) + talentTreeBonus.armor
    attr.evade = math.floor((attr.evade + heroCfg.evaAddition * levelCoef) * (heroCfg.evaStar[heroInfo.star])) + talentTreeBonus.evade
    attr.bombard = math.floor((attr.bombard + heroCfg.bomAddition * levelCoef) * (heroCfg.bomStar[heroInfo.star])) + talentTreeBonus.bombard
    attr.torpedo = math.floor((attr.torpedo + heroCfg.torAddition * levelCoef) * (heroCfg.torStar[heroInfo.star])) + talentTreeBonus.torpedo
    attr.lucky = math.floor((attr.lucky + heroCfg.lukAddition * levelCoef) * (heroCfg.lukStar[heroInfo.star])) + talentTreeBonus.lucky
    attr.airdefense = math.floor((attr.airdefense + heroCfg.adfAddition * levelCoef) * (heroCfg.adfStar[heroInfo.star])) + talentTreeBonus.airdefense
    return attr
end

--设置角色属性
---@param heroInfo HeroInfo
function Player:setHeroAttribute(heroInfo)
    local data = {}
	local heroCfg = Config.GetCharacterInfo(heroInfo.id)
    if not heroCfg then
        LuaLogger.es("配置文件未找到", heroInfo.id)
        return nil
    end
    local heroBaseAttr = self:getHeroBaseAttr(heroInfo.id)
    local NatureList = {
        hp = heroBaseAttr.hp, bombard = heroBaseAttr.bombard, torpedo = heroBaseAttr.torpedo, armor = heroBaseAttr.armor, evade = heroBaseAttr.evade, airdefense = heroBaseAttr.airdefense, lucky = heroBaseAttr.lucky
    }
    data = heroInfo
    data.effectiveSkill = {}

    --装备属性加成
    local equipValue = self:getEquipBonus(data.carryEquip, data.effectiveSkill)

    --武器属性加成
    local weaponRatio, weaponValue = self:getWeaponBonus(data.carryWeapon, NatureList, data.effectiveSkill)

    --科技树加成
    local techTreeBonus = self:getTechnologyTreeBonus(heroCfg, NatureList, data.effectiveSkill)

    weaponRatio = weaponRatio + heroCfg.baseDamageRate

    --好感度提供的属性加成（仅已领取奖励的最高等级生效）
    local affectionCfg = Config.GetAffectionInfo(heroCfg.affection)
    local maxClaimedLevel = 0
    if heroInfo.affectionRewardList then
        for _, claimedLevel in pairs(heroInfo.affectionRewardList) do
            if claimedLevel > maxClaimedLevel then
                maxClaimedLevel = claimedLevel
            end
        end
    end
    local affectionRatio = affectionCfg and affectionCfg.attribute[maxClaimedLevel] or 0

    --基本属性
	data.hp = math.floor((heroBaseAttr.hp + equipValue.hp + weaponValue.hp + techTreeBonus.hp) * (1 + affectionRatio) + 0.5)
	data.armor = math.floor((heroBaseAttr.armor + equipValue.armor + weaponValue.armor + techTreeBonus.armor) * (1 + affectionRatio) + 0.5)
	data.evade = math.floor((heroBaseAttr.evade + equipValue.evade + weaponValue.evade + techTreeBonus.evade) * (1 + affectionRatio) + 0.5)
	data.bombard = math.floor((heroBaseAttr.bombard + equipValue.bombard + weaponValue.bombard + techTreeBonus.bombard) * (1 + affectionRatio) + 0.5)
    data.torpedo = math.floor((heroBaseAttr.torpedo + equipValue.torpedo + weaponValue.torpedo + techTreeBonus.torpedo) * (1 + affectionRatio) + 0.5)
    data.lucky = math.floor((heroBaseAttr.lucky + equipValue.lucky + weaponValue.lucky + techTreeBonus.lucky) * (1 + affectionRatio) + 0.5)
    data.airdefense = math.floor((heroBaseAttr.airdefense + equipValue.airdefense + weaponValue.airdefense + techTreeBonus.airdefense) * (1 + affectionRatio) + 0.5)

    data.weaponRatio = weaponRatio
    data.load = heroCfg.load + self:getWeaponLoadById(data.id)

    local tagList = self:getHeroTagList(data.id)
    data.tagList = tagList
    local tagSkillList = self:getHeroTagSkillList(tagList)
    tablex.mergeArray(data.effectiveSkill, tagSkillList)

    local hpPoint = data.hp * heroCfg.hpScore
    local armorPoint = data.armor * heroCfg.armorScore
    local evadePoint = data.evade * heroCfg.evadeScore
    local bombardPoint = data.bombard * heroCfg.bombardScore
    local torpedoPoint = data.torpedo * heroCfg.torpedoScore
    local luckyPoint = data.lucky * heroCfg.luckyScore
    local airdefensePoint = data.airdefense * heroCfg.airdefenseScore

    local totalPoints = (hpPoint + armorPoint + evadePoint + bombardPoint + torpedoPoint + luckyPoint + airdefensePoint) * weaponRatio
    local twoThirdsPower = totalPoints / 4 --math.pow(totalPoints, 2 / 3)
    --作战能力值
    data.allDmg = math.floor(twoThirdsPower)
end

---获取战斗角色信息
---@param id integer 角色id
---@return BattleHeroInfo? 战斗角色信息
function Player:getBattleHeroInfo(id)
    local heroInfo = self:getPlayerHero(id)
    if not heroInfo then
        return nil
    end

    local battleHeroInfo = {
        id = heroInfo.id,
        level = heroInfo.level,
        exp = heroInfo.exp,
        star = heroInfo.star,
        equipSkin = heroInfo.equipSkin,
        getTime = heroInfo.getTime,
        name = heroInfo.name,
        isInHome = heroInfo.isInHome,
        carryEquip = heroInfo.carryEquip,
        talentTreeList = heroInfo.talentTreeList,
        talentTreeStage = heroInfo.talentTreeStage,
        EquippedSkillList = heroInfo.EquippedSkillList,
        carryWeapon = heroInfo.carryWeapon,
        affectionLevel = heroInfo.affectionLevel,
        affectionExp = heroInfo.affectionExp,
        affectionEvent = heroInfo.affectionEvent,
    }

    local copyData = clone(battleHeroInfo)
    self:setHeroAttribute(copyData)
    return copyData
end

--添加角色
---@param id integer 角色id
---@param proto UserInfo 协议数据
---@param balance_channel_id integer 产出消耗渠道
---@param balance_channel_detail integer 产出消耗渠道详细内容
function Player:addPlayerHero(id, proto, balance_channel_id, balance_channel_detail)
    local heroList = self:getHeroList()
    local hasHero = self:getPlayerHero(id) ~= nil
    local heroCfg = Config.GetCharacterInfo(id)
    if not heroCfg then
        LuaLogger.e("GetCharacterInfo Error:"..id)
        return
    end

    --英雄是否开放,0未开放，1开放
    if heroCfg.isOpen ~= 1 then
        LuaLogger.es("Hero is not open:", id)
        return
    end

    if hasHero then
        self:addRewardList(heroCfg.getPatch, proto, balance_channel_id, balance_channel_detail)
        return GE.ItemPropType.CharToken
    else
        heroList[id] = self:initHeroInfo(heroCfg)
        self:addSkin(heroCfg.baseSkinID, proto, balance_channel_id, balance_channel_detail)
        self:missionTrigger(GE.MissionFinishType.GetRole, {count = 1}, proto)
        if proto then
            if not proto.heroList then
                proto.heroList = {}
            end
            proto.heroList[id] = self:getPlayerHero(id)
        end

        self:missionTrigger(GE.MissionFinishType.GetRoleWithRankCount, {roleId = id}, proto, {})

        --更新社交数据
        self:socialUpdateHeroNum()
        --记录日志
        if DataLogMgr then
            DataLogMgr.LogHeroAdd({
                heroCid = id,
                heroName = heroCfg.name,
                balance_channel_id = balance_channel_id,
                balance_channel_detail = balance_channel_detail,
            }, self)
        end
        return
    end
end

--初始化角色信息
---@param heroCfg table 角色id
---@return HeroInfo
function Player:initHeroInfo(heroCfg)
    local baseSkill = {}
    for i = 1, skillSlotCount do
        if heroCfg.baseSkill[i] then
            baseSkill[i] = heroCfg.baseSkill[i]
        else
            baseSkill[i] = 0
        end
    end

    --初始装备槽
    local baseEquip = {}
    for i = 1, equipSlotCount do
        baseEquip[i] = 0
    end

    --初始武器槽
    local baseWeapon = {}
    for i = 1, weaponSlotCount do
        baseWeapon[i] = 0
    end

    --初始语音
    local baseVoice = self:getUserData().CharInitVoice

    local newHeroData = {
        id = heroCfg.id,
        level = 1,
        exp = 0,
        name = "",
        star = heroCfg.baseStar,
        talentLevel = 1,
        carryEquip = baseEquip,
        talentTreeList = {},
        talentTreeStage = {},
        EquippedSkillList = baseSkill,
        carryWeapon = baseWeapon,
        equipSkin = heroCfg.baseSkinID,
        getTime = DLuaUtil.GetGreenwichTime(),
        affectionLevel = 0,
        affectionExp = 0,
        affectionEvent = 0,
        energy = 100,
        affectionRewardList = {},
        getStarRewardFlag = false,
        attributeValList = {},
        voiceType = baseVoice,
    }
    newHeroData.attributeValList = {}
    ---@type CharacterTable
    local cfg = heroCfg
    for i = 1, #cfg.OutLineAttribute do
        local type = cfg.OutLineAttribute[i][1]
        local val_min = cfg.OutLineAttribute[i][2]
        local val_max = cfg.OutLineAttribute[i][3]
        local val = math.random(val_min, val_max)
        tablex.insertproxy(newHeroData.attributeValList, {
            type = type,
            val = val,
        })
    end
    return newHeroData
end

---获取英雄占用的名称（自定义名 + 配置初始名，均不可与他人重复）
---@param heroInfo HeroInfo
---@return table<string, boolean>
local function getHeroOccupiedNames(heroInfo)
    local names = {}
    local customName = (heroInfo.name or ""):trim()
    if customName ~= "" then
        names[customName] = true
    end
    local heroCfg = Config.GetCharacterInfo(heroInfo.id)
    local initName = heroCfg and heroCfg.name or ""
    if initName ~= "" then
        names[initName] = true
    end
    return names
end

--修改角色名称
---@param heroId integer 角色id
---@param newName string 新名称
---@param ip string IP地址
---@param proto UserInfo? 协议数据
---@return ActionFailReason 错误码
function Player:ChangeHeroName(heroId, newName, ip, proto)
    if not heroId then
        return ActionFailReason.ParameterInvalid
    end

    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo then
        return ActionFailReason.HeroNoFind
    end

    --英雄名允许为空，为空时默认配置名称
    newName = newName or ""
    --去除两端空白
    newName = newName:trim()

    --无效修改
    if heroInfo.name == newName then
        return ActionFailReason.None
    end

    if newName ~= "" then
        local ok, reason = self:CheckUserName(newName, GE.NameChangeType.ChangeHeroName, ip)
        if not ok then
            return reason
        end
    end

    local newDisplayName = newName
    if newDisplayName == "" then
        local heroCfg = Config.GetCharacterInfo(heroInfo.id)
        newDisplayName = heroCfg and heroCfg.name or ""
    end
    for id, otherHero in pairs(self:getHeroList()) do
        if id ~= heroId then
            local occupiedNames = getHeroOccupiedNames(otherHero)
            if occupiedNames[newDisplayName] then
                return ActionFailReason.SameNameCharExists
            end
        end
    end

    heroInfo.name = newName

    if proto then
        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[heroInfo.id] = heroInfo
    end

    return ActionFailReason.None
end


function Player:updateHeroData(userinfo)
    --角色体力恢复
    local dispatchRoleList = self:getInDispatchRole()
    local heroList = self:getHeroList()
    local upCfgList = self:getTechTreeHomeUp()
    local extraAdd = 0
    --科技树家园词条派遣回复加成
    for _, effect in pairs(upCfgList) do
        if effect[1] == GE.TechTreeHomeUpType.DispatchRecover then
            extraAdd = extraAdd + effect[2]
        end
    end
    for _, heroInfo in pairs(heroList) do
        if tablex.find(dispatchRoleList, heroInfo.id) == false and heroInfo.energy < 100 then
            heroInfo.energy = heroInfo.energy + Config.GetConfigInfo("EpRecoverBasic") + extraAdd
            if heroInfo.energy > 100 then
                heroInfo.energy = 100
            end
            userinfo.heroList = {}
            table.insert(userinfo.heroList, heroInfo)
        end
    end
end

-----------------------------天赋树--------------------------------------
--词条获取
---@param heroId integer 角色id
---@return integer[] 词条列表
function Player:getHeroTagList(heroId)
    local roletTagList = {}
    local heroCfg = Config.GetCharacterInfo(heroId)
    if not heroCfg then
        LuaLogger.e("GetCharacterInfo Error:"..heroId)
        return roletTagList
    end

    --初始词条
    roletTagList = clone(heroCfg.signal)

    --获得天赋树影响
    local talentAddTagList, talentReplaceTagList, talentDelTagList = self:getTalentTreeTagList(heroId)

    --添加词条
    for _, value in pairs(talentAddTagList) do
        table.insert(roletTagList, value)
    end

    --替换词条
    for key, value in pairs(talentReplaceTagList) do
        for k, v in pairs(roletTagList) do
            if v == key then
                roletTagList[k] = value
            end
        end
    end

    --删除词条
    for _, value in pairs(talentDelTagList) do
        for k, v in pairs(roletTagList) do
            if v == value then
                table.remove(roletTagList, k)
                break
            end
        end
    end

    return roletTagList
end

---获取标签中所含的技能
---@param tagList integer[] 词条列表
---@return integer[]
function Player:getHeroTagSkillList(tagList)
    local r = {}
    if tablex.next(tagList) == nil then
        return r
    end
    for _, tagId in pairs(tagList) do
        local tagData = Config.SignalInfo(tagId)
        if tagData and tagData.effect and tablex.next(tagData.effect)then
            local effectType = tagData.effect[1]
            local value = tagData.effect[2]
            if effectType == GE.TagEffectType.battleSkill then
                table.insert(r, value)
            end
        end
    end
    return r
end

--获取角色技能列表
---@param heroId integer 角色id
---@return integer[] 技能列表
function Player:getHeroSkillList(heroId)
    local roleSkillList = {}
    local heroCfg = Config.GetCharacterInfo(heroId)
    if not heroCfg then
        LuaLogger.e("GetCharacterInfo Error:"..heroId)
        return roleSkillList
    end

    --初始技能
    roleSkillList = tablex.clone(heroCfg.baseSkill)

    --技能树技能
    local talentAddSkillList = self:getTalentTreeSkillList(heroId)
    for _, v in pairs(talentAddSkillList) do
        table.insert(roleSkillList, v)
    end

    return roleSkillList
end

--获取角色是否拥有某技能
---@param heroId integer 角色id
---@param skillid integer 技能id
---@return boolean 是否拥有
function Player:heroHasSkill(heroId, skillid)
    local roleSkillList = self:getHeroSkillList(heroId)
    if tablex.find(roleSkillList, skillid) then
        return true
    end

    return false
end

--获取技能装备位置
---@param heroId integer 角色id
---@param skillid integer 技能id
---@return integer? 位置
function Player:getEquippedSkillIndex(heroId, skillid)
    local heroInfo = self:getPlayerHero(heroId)
    if heroInfo then
        for key, value in pairs(heroInfo.EquippedSkillList) do
            if skillid == value then
                return key
            end
        end
    end
    return nil
end

--通过角色ID为角色增加经验值
---@param heroId integer 角色id
---@param ExpCount integer 经验值
---@param proto UserInfo? 协议数据
---@return ActionFailReason 错误码
function Player:addExpByHero(heroId, ExpCount, proto)
    --参数检查
    if not heroId or not isnumber(ExpCount) then
        return ActionFailReason.LackParameter
    end

    if ExpCount <= 0 then
        return ActionFailReason.ParameterInvalid
    end

    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo then
        return ActionFailReason.HeroNoFind
    end

    local heroCfg = Config.GetCharacterInfo(heroId)
    if not heroCfg then
        return ActionFailReason.CfgNotFind
    end

    local nowLevel = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.role, heroInfo.level)
    if not nowLevel then
        return ActionFailReason.CfgNotFind
    end

    --等级已满无法获得经验
    if heroInfo.level >= self.level and heroInfo.exp >= nowLevel.exp_sum then
        return ActionFailReason.HeroLevelMax
    end

    local oldLevel = heroInfo.level
    local oldExp = heroInfo.exp

    local levelDataList = Config.GetLevelconfigInfoByType(GE.LevelDataType.role)
    local newLevelCfg = nil
    for _, v in pairs(levelDataList) do
        if (heroInfo.exp + ExpCount) >= v.exp_sum then
            newLevelCfg = v
        end
    end

    if not newLevelCfg or not newLevelCfg.level then
        return ActionFailReason.CfgNotFind
    end

    if heroInfo.level ~= newLevelCfg.level then --等级不一致代表已升级
        self:missionTrigger(GE.MissionFinishType.RoleLevelUp, {count = 1}, proto, {})
    end

    heroInfo.level = newLevelCfg.level
    heroInfo.exp = heroInfo.exp + ExpCount

    self:missionTrigger(GE.MissionFinishType.RoleLevel, {oldLevel, heroInfo.level}, proto, {})
    self:missionTrigger(GE.MissionFinishType.AssignHeroReachLevel, {roleId = heroInfo.id}, proto, {})
    self:missionTrigger(GE.MissionFinishType.AssignHeroReachSpecificLevel, {roleId = heroInfo.id, oldLevel = oldLevel, newLevel = heroInfo.level}, proto)
    if proto then
        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[heroInfo.id] = heroInfo
    end

    --记录日志
    if DataLogMgr then
        DataLogMgr.LogHeroDevelop({
            heroCid = heroId,
            heroName = heroCfg.name,
            heroDevelopType = GE.HeroDevelopType.Exp,
            before = oldExp,
            after = heroInfo.exp,
        }, self)
        if oldLevel ~= heroInfo.level then
            DataLogMgr.LogHeroDevelop({
                heroCid = heroId,
                heroName = heroCfg.name,
                heroDevelopType = GE.HeroDevelopType.Level,
                before = oldLevel,
                after = heroInfo.level,
            }, self)
        end
    end

    return ActionFailReason.None
end

--角色升星
---@param heroId integer 角色id
---@param proto UserInfo? 协议数据
---@return integer 错误码
function Player:heroStarUp(heroId, proto)

    if heroId == nil then
        return ActionFailReason.ParameterInvalid
    end

    local heroInfo = self:getPlayerHero(heroId)
    --没有找到角色信息
    if not heroInfo then
        return ActionFailReason.HeroNoFind
    end

    local heroCfg = Config.GetCharacterInfo(heroId)
    --没有找到角色配置
    if not heroCfg then
        return ActionFailReason.CfgNotFind
    end

    --已经是最高星级
    if heroInfo.star >= #heroCfg.talentId then
        return ActionFailReason.HeroStarMax
    end

    local cost = heroCfg.patchCost[heroInfo.star + 1]
    local itemData = self:getItemById(cost[2])
    --道具不足
    if not itemData or itemData.num < cost[3] then
        return ActionFailReason.ItemNoEnough
    end

    local oldStar = heroInfo.star
    local newStar = heroInfo.star + 1

    --扣除道具
    self:useItem(cost[2], cost[3], proto, GE.EventItemType.HeroStarUp, heroId)

    --升星
    heroInfo.star = newStar

    -- local starAward = heroCfg.StarAward
    -- local awardLevel = starAward[1]
    -- local reward = starAward[2]
    -- local rewardList = {}
    -- if awardLevel == newStar then --如果当前等级是配置中需要发奖励的等级
    --     rewardList = self:addRewardList({reward}, proto, GE.EventItemType.HeroStarUp, heroId)
    -- end

    if proto.heroList == nil then
        proto.heroList = {}
    end
    proto.heroList[heroInfo.id] = heroInfo

    self:missionTrigger(GE.MissionFinishType.SpecifiedRoleCountWithRankReachStar, {roleId = heroId}, proto, {})
    self:missionTrigger(GE.MissionFinishType.AssignHeroReachStar, {roleId = heroId}, proto, {})
    self:missionTrigger(GE.MissionFinishType.RoleCountReachStar, {star = newStar, roleId = heroId}, proto, {})

    --记录日志
    if DataLogMgr then
        DataLogMgr.LogHeroDevelop({
            heroCid = heroId,
            heroName = heroCfg.name,
            heroDevelopType = GE.HeroDevelopType.Star,
            before = oldStar,
            after = newStar,
        }, self)
    end

    return ActionFailReason.None, {}
end

--领取角色星级奖励
function Player:getHeroStarReward(id, proto)
    if id == nil then
        return ActionFailReason.ParameterInvalid
    end

    local heroInfo = self:getPlayerHero(id)
    --没有找到角色信息
    if not heroInfo then
        return ActionFailReason.HeroNoFind
    end

    local heroCfg = Config.GetCharacterInfo(id)
    --没有找到角色配置
    if not heroCfg then
        return ActionFailReason.CfgNotFind
    end

    if heroInfo.getStarRewardFlag then
        return ActionFailReason.HeroStarRewardAlreadyGet
    end

    local starAward = heroCfg.StarAward
    if tablex.next(starAward) == nil then
        return ActionFailReason.HeroStarNull
    end

    local awardLevel = starAward[1]
    local reward = starAward[2]
    if awardLevel > heroInfo.star then
        return ActionFailReason.HeroStarNotReach
    end

    heroInfo.getStarRewardFlag = true

    local rewardList = self:addRewardList({reward}, proto, GE.EventItemType.HeroStarUp, id)

    if proto.heroList == nil then
        proto.heroList = {}
    end
    proto.heroList[heroInfo.id] = heroInfo

    return ActionFailReason.None, rewardList
end


--角色升级
---@param heroId integer 角色id
---@param upLevel integer 升级等级
---@param proto UserInfo? 协议数据
---@return ActionFailReason 错误码
function Player:heroLevelUp(heroId, upLevel, proto)
    if heroId == nil or upLevel == nil then
        return ActionFailReason.LackParameter
    end

    local heroInfo = self:getPlayerHero(heroId)
    --没有找到角色信息
    if not heroInfo then
        return ActionFailReason.HeroNoFind
    end

    --升级等级不合法
    if upLevel <= 0 then
        return ActionFailReason.ParameterInvalid
    end

    --已经是目标等级
    if heroInfo.level >= upLevel then
        return ActionFailReason.HeroAlreadyLevel
    end

    local nowLevel = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.role, upLevel)
    --升级等级不合法
    if not nowLevel then
        return ActionFailReason.CfgNotFind
    end

    local needExp =  nowLevel.exp_sum - heroInfo.exp
    --TODO：110011待替换
    local itemData = self:getItemById(110011)
    local itemCount = itemData and itemData.num or 0

    --道具不足
    if itemCount < needExp then
        return ActionFailReason.ItemNoEnough
    end

    --扣除道具
    self:useItem(itemData.id, needExp, proto, GE.EventItemType.HeroLevelUp, heroId)
    self:ActivateEventTrigger(GE.EventTriggerType.HeroLevelUp,1, proto)
    --升级
    local ret = self:addExpByHero(heroInfo.id, needExp, proto)
    return ret
end

--为英雄装备技能
---@param heroId integer 英雄id
---@param skillList integer[] 技能id
---@param proto UserInfo? 协议数据
---@return ActionFailReason 错误码
function Player:equipHeroSkill(heroId, skillList, proto)
    --入参检测
    if not isnumber(heroId) or not istable(skillList) then
        return ActionFailReason.LackParameter
    end

    local heroInfo = self:getPlayerHero(heroId)
    --没有找到角色信息
    if not heroInfo then
        return ActionFailReason.HeroNoFind
    end

    if tablex.size(skillList) > skillSlotCount then
        return ActionFailReason.SkillSlotMax
    end

    --检查技能是否拥有
    local temp = {}
    for k, v in pairs(skillList) do
        if v ~= 0 then
           --防重复检测
            if not temp[v] then
                temp[v] = v
            else
                return ActionFailReason.ParameterInvalid
            end
            if v > 0 then
                if not self:heroHasSkill(heroId, v) then
                    return ActionFailReason.SkillNotHas
                end
            else
                return ActionFailReason.ParameterInvalid
            end
        end
    end

    --装备技能
    for k, v in pairs(skillList) do
        heroInfo.EquippedSkillList[k] = v
    end

    if proto then
        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[heroInfo.id] = heroInfo
    end

    return ActionFailReason.None
end

--赠送好感度礼物
---@param heroId integer 角色id
---@param giftId integer 礼物id
---@param count integer 数量
---@param proto UserInfo? 协议数据
function Player:giveAffectionGift(heroId, giftId, count, proto)
    --功能开启检测 - 角色好感度是否开启
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.RoleAffectionl)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end

    --入参检测
    if not heroId or not giftId or not count or count <= 0 then
        return ActionFailReason.ParameterInvalid
    end

    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo then
        return ActionFailReason.HeroNoFind
    end

    local heroCfg = Config.GetCharacterInfo(heroId)
    if not heroCfg then
        LuaLogger.ds("CfgNotFind",heroId)
        return ActionFailReason.CfgNotFind
    end

    --特殊R卡不允许赠送礼物
    if heroCfg.isSpecial == 1 then
        return ActionFailReason.AffectionRRoleNotGift
    end

    local itemCfg = Config.GetItemInfo(giftId)
    if not itemCfg then
        LuaLogger.ds("CfgNotFind",giftId)
        return ActionFailReason.CfgNotFind
    end

    local itemInfo = self:getItemById(giftId)
    if not itemInfo or itemInfo.num < count then
        return ActionFailReason.ItemNoEnough
    end

    if itemCfg.effect[1] ~= GE.ItemEffectType.affection then
        return ActionFailReason.AffectionItemNotGift
    end

    local curLevel = heroInfo.affectionLevel
    local curLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, curLevel)
    if not curLevelData then
        LuaLogger.ds("CfgNotFind",GE.LevelDataType.affection, curLevel)
        return ActionFailReason.CfgNotFind
    end

    local maxLevel = Config.GetConfigInfo("AffectionLevelGiftMax")
    local maxExp = curLevelData.exp
    if curLevel >= maxLevel and maxExp >= heroInfo.affectionExp then
        return ActionFailReason.AffectionLevelMax
    end

    local HeroAffectionCfg = Config.GetAffectionInfo(heroCfg.affection)
    if not HeroAffectionCfg then
        LuaLogger.ds("CfgNotFind",heroCfg.affection)
        return ActionFailReason.CfgNotFind
    end

    if not tablex.find(HeroAffectionCfg.Gift, giftId) then
        LuaLogger.ds("CfgNotFind",giftId, tablex.dump(HeroAffectionCfg.Gift))
        return ActionFailReason.AffectionItemNotGift
    end

    local addExp = itemCfg.effect[2] * count
    for _, v in pairs(HeroAffectionCfg.extraGift) do
        if v == giftId then
            addExp = addExp * 2
            break
        end
    end

    local oldExp = heroInfo.affectionExp
    local oldLevel = heroInfo.affectionLevel

    local simExp = math.floor(oldExp + addExp)
    local simLevel = oldLevel
    local simLevelData = curLevelData
    local simMaxExp = simLevelData.exp
    while simExp >= simMaxExp and simLevel < maxLevel do
        simExp = simExp - simMaxExp
        simLevel = simLevel + 1
        simLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, simLevel)
        if not simLevelData then
            LuaLogger.ds("CfgNotFind", GE.LevelDataType.affection, simLevel)
            return ActionFailReason.CfgNotFind
        end
        simMaxExp = simLevelData.exp
    end
    if simLevel >= maxLevel then
        simLevel = maxLevel
        simLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, simLevel)
        if not simLevelData then
            LuaLogger.ds("CfgNotFind", GE.LevelDataType.affection, simLevel)
            return ActionFailReason.CfgNotFind
        end
        simExp = math.min(simExp, simLevelData.exp)
    end

    self:useItem(itemInfo.id, count, proto, GE.EventItemType.AffectionGiveGift, heroId)

    heroInfo.affectionExp = simExp
    heroInfo.affectionLevel = simLevel

    self:missionTrigger(GE.MissionFinishType.SpecifiedRoleCountWithAffectionLevel, {roleId = heroId}, proto, {})
    self:missionTrigger(GE.MissionFinishType.GiveAssignGiftToRoleCount, {roleId = heroId, giftId = giftId, count = count}, proto, {})
    self:missionTrigger(GE.MissionFinishType.GiveGiftToRoleCount, {roleId = heroId, count = count}, proto, {})
    if proto then
        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[heroInfo.id] = heroInfo
    end

    if DataLogMgr then
        DataLogMgr.LogHeroDevelop({
            heroCid = heroId,
            heroName = heroCfg.name,
            heroDevelopType = GE.HeroDevelopType.AffectionExp,
            before = oldExp,
            after = heroInfo.affectionExp,
        }, self)
    end

    if oldLevel ~= heroInfo.affectionLevel then
        if DataLogMgr then
            DataLogMgr.LogHeroDevelop({
                heroCid = heroId,
                heroName = heroCfg.name,
                heroDevelopType = GE.HeroDevelopType.AffectionLevel,
                before = oldLevel,
                after = heroInfo.affectionLevel,
            }, self)
        end
    end

    return ActionFailReason.None
end

--请求领取角色好感度等级奖励
---@param heroId integer 角色id
---@param level integer 好感度等级
---@param proto UserInfo? 协议数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? 奖励列表
function Player:affectionGetReward(heroId, level, proto)
    --功能开启检测 - 角色好感度是否开启
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.RoleAffectionl)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end

    --入参检测
    if not heroId or not level or level < 1 then
        return ActionFailReason.ParameterInvalid
    end

    --判断角色是否存在
    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo then
        return ActionFailReason.HeroNoFind
    end

    local heroCfg = Config.GetCharacterInfo(heroId)
    if not heroCfg then
        return ActionFailReason.CfgNotFind
    end

    local affectionCfg = Config.GetAffectionInfo(heroCfg.affection)
    if not affectionCfg then
        return ActionFailReason.CfgNotFind
    end

    --好感度配置
    local curLevel = heroInfo.affectionLevel
    local curLevelData = Config.GetLevelconfigInfoByTypeLevel(GE.LevelDataType.affection, curLevel)
    if not curLevelData then
        return ActionFailReason.CfgNotFind
    end

    --已领取的最高等级（兼容旧的多等级列表数据）
    local maxClaimedLevel = 0
    local isGetRewardList = heroInfo.affectionRewardList or {}
    for _, claimedLevel in pairs(isGetRewardList) do
        if claimedLevel > maxClaimedLevel then
            maxClaimedLevel = claimedLevel
        end
    end
    if maxClaimedLevel >= curLevel then
        return ActionFailReason.AffectionRewardAlreadyGet
    end

    --批量领取所有可领取的等级奖励，记录为当前好感度等级
    local rewardList = {}
    for claimLevel = maxClaimedLevel + 1, curLevel do
        local reward = affectionCfg.affectionReward[claimLevel]
        if reward and next(reward) and reward[2] then
            local rewards = self:addRewardList({reward}, proto, GE.EventItemType.AffectionLevelUp, heroId)
            if rewards then
                for _, r in ipairs(rewards) do
                    table.insert(rewardList, r)
                end
            end
        end
    end
    heroInfo.affectionRewardList = {curLevel}

    --领取后刷新六维属性
    self:setHeroAttribute(heroInfo)

    self:missionTrigger(GE.MissionFinishType.AssignHeroReachAffectionLevel, {roleId = heroId}, proto, {})

    --返回结果
    if proto then
        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[heroInfo.id] = heroInfo
    end

    return ActionFailReason.None, rewardList
end

---每日检测对话数据
---@param userinfo UserInfo
function Player:checkHeroInteraction(userinfo)
    --当前只有日刷新
    local heros = self:getHeroList()
    for k, v in pairs(heros) do
        if v.interactionInfo ~= 0 then
           v.interactionInfo = 0
            userinfo = userinfo or {}
            userinfo.heroList = userinfo.heroList or {}
            userinfo.heroList[v.id] = userinfo.heroList[v.id] or {}
            userinfo.heroList[v.id].id = v.id
            userinfo.heroList[v.id].interactionInfo = v.interactionInfo
        end
    end
end

---角色交互
---@param heroId integer
---@param talkId integer
---@param proto UserInfo
---@return ActionFailReason
function Player:CoveInteraction(heroId, talkId, proto)
    if not heroId or not talkId then
        return ActionFailReason.ParameterInvalid
    end

    local cfgInfo = Config.GetHomeTouchWordsInfoByPassageId(talkId)
    if not cfgInfo or not cfgInfo[1] then
        return ActionFailReason.CfgNotFind
    end
    local s_id = tostring(cfgInfo[1].id)
    local s_heroId = tostring(heroId)
    if s_id:sub(1, 5) ~= s_heroId then
        return ActionFailReason.ParameterInvalid
    end

    local data = self:getPlayerHero(heroId)
    if data == nil then
        return ActionFailReason.HeroNoFind
    end

    if data.interactionInfo ~= 0 and data.interactionInfo ~= nil then
        return ActionFailReason.None
    end

    data.interactionInfo = talkId

    proto.heroList = proto.heroList or {}
    proto.heroList[heroId] = proto.heroList[heroId] or {}
    proto.heroList[heroId].id = data.id
    proto.heroList[heroId].interactionInfo = data.interactionInfo
    self:missionTrigger(GE.MissionFinishType.ChatWithHomeRole, {count = 1}, proto)
    self:addProsperityByGetType(GE.GetProsperityType.SayHi, proto)

    return ActionFailReason.None
end

--设置角色语种
---@param idList integer[] 角色id列表
---@param voiceType integer 语种
---@param proto UserInfo? 协议数据
---@return ActionFailReason 错误码
function Player:setCharVoiceType(idList, voiceType, proto)
    if not idList or not voiceType then
        return ActionFailReason.ParameterInvalid
    end

    if not tablex.contains(GE.RoleLanguage, voiceType) then
        return ActionFailReason.ParameterInvalid
    end

    local targetHeroList = {}
    if tablex.next(idList) == nil then
        targetHeroList = self:getHeroList()
    else
        for _, id in pairs(idList) do
            local data = self:getPlayerHero(id)
            if data == nil then
                return ActionFailReason.HeroNoFind
            end
            targetHeroList[id] = data
        end
    end

    for id, data in pairs(targetHeroList) do
        local newVoiceType = voiceType
        if voiceType == 0 then
            local heroCfg = Config.GetCharacterInfo(id)
            if not heroCfg then
                return ActionFailReason.CfgNotFind
            end
            newVoiceType = heroCfg.firstLanguage
        end
        data.voiceType = newVoiceType

        if proto then
            proto.heroList = proto.heroList or {}
            proto.heroList[id] = data
        end
    end

    return ActionFailReason.None
end

--设置角色初始语种
function Player:setCharInitVoiceType(voiceType, proto)
    if (not voiceType) or (not tablex.contains(GE.RoleLanguage, voiceType)) then
        return ActionFailReason.ParameterInvalid
    end

    self.userData.CharInitVoice = voiceType
    if proto then
        proto.userData = proto.userData or {}
        proto.userData.CharInitVoice = voiceType
    end

    return ActionFailReason.None
end


return Player