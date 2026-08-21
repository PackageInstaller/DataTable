-- Desc: 玩家角色相关逻辑

---@class Player
local Player = require "Player"
local DataLogMgr
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
end


--天赋树属性加成
---@param treeId integer 天赋树id
---@param talentTreeList integer[] 天赋树节点列表
---@param talentTreeStage integer[] 天赋树阶段列表
---@return table<string, integer> 属性加成
function Player:getTalentTreeBonus(treeId, talentTreeList, talentTreeStage)
    local talentTree = {
        hp = 0, bombard = 0, torpedo = 0, armor = 0, evade = 0, airdefense = 0, lucky = 0
    }

    --技能树加成
    for _,v in pairs(talentTreeList) do
        local TreeData = Config.TalentTreeInfo(v)
        if TreeData then
            talentTree.hp = talentTree.hp + TreeData.hp
            talentTree.bombard = talentTree.bombard + TreeData.bombard
            talentTree.torpedo = talentTree.torpedo + TreeData.torpedo
            talentTree.armor = talentTree.armor + TreeData.armor
            talentTree.evade = talentTree.evade + TreeData.evade
            talentTree.airdefense = talentTree.airdefense + TreeData.airdefense
            talentTree.lucky = talentTree.lucky + TreeData.lucky
        end
    end

    --技能树阶段加成
    for _,v in pairs(talentTreeStage) do
        local stageConfig = Config.GetTalentTreeStageInfoByTreeIdStageId(treeId, v)
        if stageConfig then
            talentTree.hp = talentTree.hp + stageConfig.hp
            talentTree.bombard = talentTree.bombard + stageConfig.bombard
            talentTree.torpedo = talentTree.torpedo + stageConfig.torpedo
            talentTree.armor = talentTree.armor + stageConfig.armor
            talentTree.evade = talentTree.evade + stageConfig.evade
            talentTree.airdefense = talentTree.airdefense + stageConfig.airdefense
            talentTree.lucky = talentTree.lucky + stageConfig.lucky
        end
    end

    return talentTree
end

--获得天赋树词条
---@param heroId integer 角色id
---@return integer[] 待增加词条
---@return table<integer, integer> 待替换词条
---@return integer[] 待删除词条
function Player:getTalentTreeTagList(heroId)
    --待增加词条
    local talentAddTagList = {}
    --待替换词条
    local talentReplaceTagList = {}
    --待删除词条
    local talentDelTagList = {}

    --技能树影响
    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo then
        --LuaLogger.e("getPlayerHero Error:"..heroId)
        return talentAddTagList, talentReplaceTagList, talentDelTagList
    end

    for _,v in pairs(heroInfo.talentTreeList) do
        local treeData = Config.TalentTreeInfo(v)
        if treeData then
            if treeData.specialEffect[1] == GE.TalentTypeNew.getTagPoint then
                table.insert(talentAddTagList, treeData.specialEffect[2])
            elseif treeData.specialEffect[1] == GE.TalentTypeNew.changeTagPoint then
                talentReplaceTagList[treeData.specialEffect[2] ] = treeData.specialEffect[3]
            elseif treeData.specialEffect[1] == GE.TalentTypeNew.delTagPoint then
                table.insert(talentDelTagList, treeData.specialEffect[2])
            end
        else
            --LuaLogger.e("TalentTreeInfo Error:"..v)
        end
    end

    return talentAddTagList, talentReplaceTagList, talentDelTagList
end

--获得天赋树技能
---@param heroId integer 角色id
---@return integer[] 待增加技能
function Player:getTalentTreeSkillList(heroId)
    --待增加技能
    local talentAddSkillList = {}

    --技能树影响
    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo then
        --LuaLogger.e("getPlayerHero Error:"..heroId)
        return talentAddSkillList
    end

    for _,v in pairs(heroInfo.talentTreeList) do
        local treeData = Config.TalentTreeInfo(v)
        if treeData then
            if treeData.specialEffect[1] == GE.TalentTypeNew.getSkillPoint then
                table.insert(talentAddSkillList, treeData.specialEffect[2])
            end
        else
            --LuaLogger.e("TalentTreeInfo Error:"..v)
        end
    end

    return talentAddSkillList
end

--根据角色id查找从天赋树中获取的武器负载值
---@param heroId integer 角色id
---@return integer 负载值
function Player:getWeaponLoadById(heroId)
    local loadValue = 0
    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo or not heroInfo.talentTreeList then
        return 0
    end

    for _, value in pairs(heroInfo.talentTreeList) do
        local TalentCfg = Config.TalentTreeInfo(value)
        if not TalentCfg then
            --LuaLogger.e("TalentTreeInfo Error:"..value)
            return 0
        end
        if tablex.next(TalentCfg.specialEffect) then
            if TalentCfg.specialEffect[1] == GE.TalentTypeNew.loadUpPoint
                or TalentCfg.specialEffect[1] == GE.TalentTypeNew.unlockWeaponPoint then
                loadValue = loadValue + TalentCfg.specialEffect[2]
            end
        end
    end

    return loadValue
end

--根据角色id在天赋树中查找第二个武器是否解锁
---@param heroId integer 角色id
---@return boolean 是否解锁
function Player:getWeaponLockStateById(heroId)
    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo or not heroInfo.talentTreeList then
        return false
    end

    for _, value in pairs(heroInfo.talentTreeList) do
        local TalentCfg = Config.TalentTreeInfo(value)
        if not TalentCfg then
            -- LuaLogger.e("TalentTreeInfo Error:"..value)
            return false
        end
        if tablex.next(TalentCfg.specialEffect) then
            if TalentCfg.specialEffect[1] == GE.TalentTypeNew.unlockWeaponPoint then
                return true
            end
        end
    end

    return false
end

--根据角色id和天赋id查找数据
---@param heroId integer 角色id
---@param talentId integer 天赋id
---@return integer?
function Player:getTalentTreeDataById(heroId, talentId)
    local heroInfo = self:getPlayerHero(heroId)
    if heroInfo and heroInfo.talentTreeList then
        if tablex.find(heroInfo.talentTreeList, talentId) then
            return talentId
        end
    end
    return nil
end

--根据角色id和阶段id查找数据
---@param heroId integer 角色id
---@param StageId integer 阶段id
---@return integer?
function Player:getTalentTreeStageDataById(heroId, StageId)
    local heroInfo = self:getPlayerHero(heroId)
    if heroInfo then
        if heroInfo.talentTreeStage and tablex.next(heroInfo.talentTreeStage) then
            for _, value in pairs(heroInfo.talentTreeStage) do
                if value == StageId then
                    return value
                end
            end
        else
            return nil
        end
    end
    return nil
end

--激活天赋树阶段
---@param heroId integer 角色id
---@param stageId integer 阶段id
---@param proto UserInfo 协议数据
---@return ActionFailReason 错误码
function Player:addTalentTreeStageData(heroId, stageId, proto)
    if heroId == nil or stageId == nil then
        return ActionFailReason.ParameterInvalid
    end

    local heroConfig = Config.GetCharacterInfo(heroId)
    if not heroConfig then
        return ActionFailReason.HeroNoFind
    end

    local heroInfo = self:getPlayerHero(heroId)
    if not heroInfo then
        return ActionFailReason.HeroNoFind
    end

    --检测已经解锁的天赋阶段内是否包含当前阶段
    if tablex.find(heroInfo.talentTreeStage, stageId) then
        return ActionFailReason.TalentStageAlreadyHas
    end

    --检测对应节点是否全部解锁
    local stageConfigs = Config.GetTalentTreeInfoByTreeIdStageId(heroConfig.talentTree, stageId)
    if stageConfigs then
        for _, value in pairs(stageConfigs) do
            if not tablex.find(heroInfo.talentTreeList, value.id) then
                return ActionFailReason.LackOfPrecond
            end
        end
    else
        return ActionFailReason.CfgNotFind
    end

    tablex.insertproxy(heroInfo.talentTreeStage, stageId)
    self:missionTrigger(GE.MissionFinishType.RoleCountFinishTalentStage, {stage = stageId}, proto)
    if proto then
        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[heroInfo.id] = heroInfo
    end

    --记录日志
    if DataLogMgr then
        DataLogMgr.LogTalentTree({
            heroCid = heroId,
            heroName = heroConfig.name,
            talentId = stageId,
        }, self)
    end

    return ActionFailReason.None
end

--判断另一个【后方节点】是否已解锁
---@param talentTreeList integer[] 已解锁的天赋树节点列表
---@param talentId integer 当前节点
---@param unlock integer[] 前置节点
---@return boolean 同级节点是否解锁
function Player:isSiblingTalentUnlocked(talentTreeList, talentId, unlock)
    --遍历所有前置节点
    for _, value in pairs(unlock) do
        local talentCfg = Config.TalentTreeInfo(value)
        --如果当前节点在某个前置节点的后方节点中
        if talentCfg and tablex.find(talentCfg.after,talentId) then
            for _, v in pairs(talentCfg.after) do
                --如果找到同级任意一个后方节点已解锁，则返回true
                if tablex.find(talentTreeList, v) then
                    return true
                end
            end
        end
    end
    return false
end

--解锁天赋树节点
---@param heroId integer 角色id
---@param talentId integer 天赋id
---@param proto UserInfo 协议数据
---@param isGm boolean? 是否GM操作
---@return ActionFailReason 错误码
function Player:talentTreeUnLockPoint(heroId, talentId, proto, isGm)
    --参数判空
    if not heroId or not talentId then
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

    local talentCfg = Config.TalentTreeInfo(talentId)
    if not talentCfg then
        return ActionFailReason.CfgNotFind
    end

    --检测角色与天赋是否匹配
    if talentCfg.treeId ~= heroCfg.talentTree then
        return ActionFailReason.TalentNoFind
    end

    --前侧额外条件
    if not isGm and talentCfg.extraUnlock[1] == GE.TreeExtraUnlock.Level then
        --检测等级
        if heroInfo.level < talentCfg.extraUnlock[2] then
            return ActionFailReason.LackOfPrecond
        end
    end

    --检测好感度等级条件
    if not isGm and talentCfg.extraUnlock[1] == GE.TreeExtraUnlock.AffectionLevel then
        --检测等级
        if heroInfo.affectionLevel < talentCfg.extraUnlock[2] then
            return ActionFailReason.LackOfPrecond
        end
    end

    --检测前置条件
    for _, value in pairs(talentCfg.unlock) do
        if not isGm and not tablex.find(heroInfo.talentTreeList, value) then
            return ActionFailReason.LackOfPrecond
        end
    end

    --检测消耗资源
    local cost = talentCfg.cost or {}
    if tablex.next(cost) then
        if not self:checkItemListEnough2(cost) then
            return ActionFailReason.ItemNoEnough
        end
    end

    --检测是否重复获得
    if tablex.find(heroInfo.talentTreeList, talentId) then
        return ActionFailReason.TalentAlreadyHas
    end

    --点亮技能节点时，第一次无消耗，第二次消耗
    --特殊消耗条件：是【后方节点】且另一个【后方节点】已解锁
    local isUnlocked = self:isSiblingTalentUnlocked(heroInfo.talentTreeList, talentId, talentCfg.unlock)

    local specialCost = talentCfg.specialCost or {}
    --检测消耗特殊消耗
    if isUnlocked and tablex.next(specialCost) then
        if not self:checkItemEnough2(specialCost) then
            return ActionFailReason.CurrencyNoEnough
        end
    end

    --增加天赋树节点
    tablex.insertproxy(heroInfo.talentTreeList, talentId)

    --触发任务：统计激活天赋树节点数达到要求的角色数量
    self:missionTrigger(GE.MissionFinishType.RoleSkillTree, {tablex.size(heroInfo.talentTreeList), heroId}, proto)

    --增加对应衍生效果
    local specialEffect = talentCfg.specialEffect or {}
    if specialEffect[1] == GE.TalentTypeNew.skinPoint then
        self:addSkin(specialEffect[2], proto, GE.EventItemType.TalentNodeUnlock, talentId)
        self:equipSkin(heroInfo.id, specialEffect[2], proto)
    elseif specialEffect[1] == GE.TalentTypeNew.getSkillPoint then
        --增加技能
        for k, v in pairs(heroInfo.EquippedSkillList) do
            if v == 0 then
                heroInfo.EquippedSkillList[k] = specialEffect[2]
                break
            end
        end
    end

    --扣除消耗资源
    if tablex.next(cost) then
        self:useItemList(cost, proto, GE.EventItemType.TalentNodeUnlock, talentId)
    end
    if isUnlocked and tablex.next(specialCost) then
        self:useItem(specialCost[1], specialCost[2], proto, GE.EventItemType.TalentNodeUnlock, talentId)
    end

    if proto then
        if not proto.heroList then
            proto.heroList = {}
        end
        proto.heroList[heroInfo.id] = heroInfo
    end

    --记录日志
    if DataLogMgr then
        DataLogMgr.LogTalentTree({
            heroCid = heroId,
            heroName = heroCfg.name,
            talentId = talentId,
        }, self)
    end

    return ActionFailReason.None
end

return Player