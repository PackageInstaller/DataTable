-- Desc: 科技树
---@class Player
local Player = require "Player"

--获取科技树全量数据
function Player:getTechnologyTree()
    return self.technologyTree
end

--获取科技树等级
---@param type TechnologyTreeType
---@return integer 科技树等级
function Player:getResearchLevel(type)
    local technologyTree = self:getTechnologyTree()
    return technologyTree.researchLevelList[type]
end

--设置科技树等级
---@param value integer 科技树等级
---@param type TechnologyTreeType
function Player:setResearchLevel(value, type)
    if not value or value < 1 then
        value = 1
    end
    self.technologyTree.researchLevelList[type] = value
end

--获取科技树经验
---@param type TechnologyTreeType
---@return integer 科技树经验
function Player:getResearchExp(type)
    local technologyTree = self:getTechnologyTree()
    return technologyTree.researchExpList[type]
end

--设置科技树经验
---@param value integer 科技树经验值
---@param type TechnologyTreeType
function Player:setResearchExp(value, type)
    self.technologyTree.researchExpList[type] = value
end

--获取树节点数据
function Player:getTechTreeNodeMap()
    local technologyTree = self:getTechnologyTree()
    if not technologyTree.treeNodeMap then
        technologyTree.treeNodeMap = {}
    end
    return technologyTree.treeNodeMap
end

--获取科技树节点
---@param groupId number 节点组id
function Player:getTechTreeNode(groupId)
    local treeNodeMap = self:getTechTreeNodeMap()
    if not treeNodeMap[groupId] then
        return 0
    end
    return treeNodeMap[groupId]
end

--科技树节点升级
---@param groupId number 节点id
---@param UserInfo UserInfo 协议数据
---@param isGm boolean? 是否跳过错误码检测, true:跳过, false:不跳过, 默认false
---@return ActionFailReason 错误码
function Player:lightTechTreeNode(groupId, UserInfo, isGm)
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.TechTree)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end
    if not groupId then
        return ActionFailReason.LackParameter
    end

    local maxLv = self:getTechTreeNodeMaxLv(groupId)
    if maxLv == 0 then
        return ActionFailReason.TechTreeNodeNotExist
    end

    local treeNodeMap = self:getTechTreeNodeMap()
    if not treeNodeMap[groupId] then
        treeNodeMap[groupId] = 0
    end

    local level = treeNodeMap[groupId]
    if level >= maxLv then
        return ActionFailReason.TechTreeNodeMaxLevel
    end

    local treeCfg = Config.GetTechnologyTreeListByGroupAndLv(groupId, level + 1)
    if not treeCfg then
        return ActionFailReason.CfgNotFind
    end

    local pointCfg = Config.GetTechnologyTreePointInfo(treeCfg.group)
    if not pointCfg then
        return ActionFailReason.CfgNotFind
    end

    if not isGm and self:getResearchLevel(pointCfg.page) < treeCfg.techLevel then
        return ActionFailReason.TechTreeLevelNotEnough
    end

    local preInfo = self:getTechTreeNodePreInfo(groupId)
    if not isGm and preInfo then
        local preLv = 0
        if treeNodeMap[preInfo.groupId] then
            preLv = treeNodeMap[preInfo.groupId]
        end
        if preLv < preInfo.level then
            return ActionFailReason.TechTreePreNodeNotUnlock
        end
    end

    --消耗判断
    local consumeList = {}
    for _, v in pairs(treeCfg.cost) do
        table.insert(consumeList, v)
    end
    if tablex.size(treeCfg.costResource or {}) > 0 then
        table.insert(consumeList, treeCfg.costResource)
    end
    for _, v in pairs(consumeList) do
        local itemInfo = self:getItemById(v[2])
        if not isGm and (not itemInfo or itemInfo.num < v[3]) then
            return ActionFailReason.ItemNoEnough
        end
    end

    --可以升级
    --消耗物品
    for _, v in pairs(consumeList) do
        self:useItem(v[2], v[3], UserInfo, GE.EventItemType.TechnologyNodeLevelUp, groupId)
    end
    --升级科技树节点
    treeNodeMap[groupId] = treeNodeMap[groupId] + 1
    --增加科技树经验
    self:addTechTreeResearchExp(treeCfg.techExp, pointCfg.page)
    --触发任务：激活科技树节点
    local currentNodeCount = self:getTechTreeActivateNodeCount(pointCfg.page)
    self:missionTrigger(GE.MissionFinishType.TechTreeActivateNodeCount, {currentNodeCount, pointCfg.page}, UserInfo)
    if treeCfg.type == GE.TechnologyTreeType.page4 then
        --更新家园提升数据
        self:updateTechTreeHomeUp()
    end
    UserInfo.technologyTree = self:getTechnologyTree()

    if treeCfg.type == GE.TechTreeNodeEffectType.Reward then
        --道具获取
        for _, v in pairs(treeCfg.reward) do
            self:addItem(v[2], v[3], UserInfo, GE.EventItemType.TechnologyNodeLevelUp, groupId)
        end
    end
    return ActionFailReason.None
end

--科技树经验增加
---@param value integer 增加的经验值
---@param type TechnologyTreeType
function Player:addTechTreeResearchExp(value, type)
    local researchExp = self:getResearchExp(type)
    local researchLevel = self:getResearchLevel(type)
    researchExp = researchExp + value
    self:setResearchExp(researchExp, type)
    local lvCfg = Config.GetLevelconfigInfoByType(GE.LevelDataType.techTree)
    for _, v in pairs(lvCfg) do
        if researchExp >= v.exp_sum then
            researchLevel = v.level
            self:setResearchLevel(researchLevel, type)
        else
            break
        end
    end
end

---@class TechnologyTreeNodeInfo
---@field pageId integer 页码
---@field level integer 当前等级
---@field preGroupId integer 前置节点组id
---@field preLevel integer 前置节点等级
---@field maxLv integer 最大等级
---@field groupId integer 节点组id
---@field cfg TechnologyTreeTable 科技树配置

--获取科技树数据
---@param pageId integer 科技树页码
---@return TechnologyTreeNodeInfo[] 节点信息列表
function Player:getTechnologyTreeNodeInfoByPageId(pageId)
    if not self.techTreeNodeInfoMap then
        self.techTreeNodeInfoMap = {}
    end
    if not self.techTreeNodeInfoMap[pageId] then
        self.techTreeNodeInfoMap[pageId] = self:generateTechTreeNodeInfoByPageId(pageId)
    end
    self:updateTechTreeNodeLvInfo(self.techTreeNodeInfoMap[pageId])
    return self.techTreeNodeInfoMap[pageId]
end

--生成科技树节点信息
---@param pageId integer 科技树页码
---@return TechnologyTreeNodeInfo[] 节点信息列表
function Player:generateTechTreeNodeInfoByPageId(pageId)
    local nodeList = {}
    local pointCfgList = Config.GetTechnologyTreePointInfoByPage(pageId)
    local treeNodeMap = self:getTechTreeNodeMap()
    if not pointCfgList or not treeNodeMap then
        return nodeList
    end
    for _, cfg in pairs(pointCfgList) do
        local preGroupId = 0
        local preLevel = 0
        local preInfo = self:getTechTreeNodePreInfo(cfg.id)
        if preInfo then
            preGroupId = preInfo.groupId
            preLevel = preInfo.level
        end
        local level = 0
        if treeNodeMap[cfg.id] then
            level = treeNodeMap[cfg.id]
        end
        nodeList[cfg.id] = {
            pageId = cfg.page,
            level = level,
            preGroupId = preGroupId,
            preLevel = preLevel,
            maxLv = self:getTechTreeNodeMaxLv(cfg.id),
            groupId = cfg.id,
            cfg = Config.GetTechnologyTreeListByGroupAndLv(cfg.id, level),
        }
    end
    return nodeList
end

function Player:updateTechTreeNodeLvInfo(treeNodeInfo)
    local treeNodeMap = self:getTechTreeNodeMap()
    for _, v in pairs(treeNodeInfo) do
        if treeNodeMap[v.groupId] and v.level ~= treeNodeMap[v.groupId] then
            v.level = treeNodeMap[v.groupId]
            v.cfg = Config.GetTechnologyTreeListByGroupAndLv(v.groupId, v.level)
        end
        v.preLevel = treeNodeMap[v.preGroupId] or 0
    end
end

--节点是否可升级(研究等级和前置节点，不包含消耗判断)
---@param groupId integer 节点id
---@param costJudge boolean 是否检测资源消耗
---@return boolean 是否可以升级
function Player:getTechTreeNodeCanUp(groupId, costJudge)
    local level = 0
    local treeNodeMap = self:getTechTreeNodeMap()
    if treeNodeMap[groupId] then
        level = treeNodeMap[groupId]
    end
    --判断是否已满级
    local maxLv = self:getTechTreeNodeMaxLv(groupId)
    if level >= maxLv then
        return false
    end
    local treeCfg = Config.GetTechnologyTreeListByGroupAndLv(groupId, level + 1)
    if not treeCfg then
        return false
    end
    local pointCfg = Config.GetTechnologyTreePointInfo(treeCfg.group)
    --判断科技树等级是否满足
    --LuaLogger.e(tablex.dump(treeCfg))
    if self:getResearchLevel(pointCfg.page) < treeCfg.techLevel then
        return false
    end
    local preInfo = self:getTechTreeNodePreInfo(groupId)
    if preInfo then
        local preLv = 0
        if treeNodeMap[preInfo.groupId] then
            preLv = treeNodeMap[preInfo.groupId]
        end
        if preLv < preInfo.level then
            return false
        end
    end
    if costJudge then
          --消耗判断
        local consumeList = {}
        for _, v in pairs(treeCfg.cost) do
            table.insert(consumeList, v)
        end
        table.insert(consumeList, treeCfg.costResource)
        for _, v in pairs(consumeList) do
            local itemInfo = self:getItemById(v[2])
            if not itemInfo or itemInfo.num < v[3] then
                return false
            end
        end
    end
    return true
end

--更新科技树数据 前端用
function Player:updateTechnologyTreeData(data)
    for key, value in pairs(data) do
        self.technologyTree[key] = value
    end
end

---@class TechnologyTreeBonus
---@field hp number 生命值加成
---@field bombard number 炮击加成
---@field torpedo number 鱼雷加成
---@field armor number 装甲加成
---@field evade number 闪避加成
---@field airdefense number 防空加成
---@field lucky number 幸运加成

--获取科技树属性加成
---@param heroCfg CharacterTable 英雄配置
---@param NatureList TechnologyTreeBonus 属性列表
---@param effectiveSkill integer[] 有效技能列表
---@return TechnologyTreeBonus 科技树属性加成
function Player:getTechnologyTreeBonus(heroCfg, NatureList, effectiveSkill)
    if not self.techTreeAttrBonus then
        self.techTreeAttrBonus = {}
    end

    ---@type TechnologyTreeBonus
    local bonus = {
        hp = 0, bombard = 0, torpedo = 0, armor = 0, evade = 0, airdefense = 0, lucky = 0
    }
    local pageId = 0
    local shipType = math.floor(heroCfg.attribute / 10)
    if shipType == GE.AttributeType.BB or shipType == GE.AttributeType.CV then
        pageId = 2
    elseif shipType == GE.AttributeType.DD or shipType == GE.AttributeType.CA then
        pageId = 1
    elseif shipType == GE.AttributeType.AO or shipType == GE.AttributeType.SS then
        pageId = 3
    end
    local nodeList = self:getTechnologyTreeNodeInfoByPageId(pageId)
    if tablex.size(nodeList) == 0 then
        return bonus
    end
    for _, v in pairs(nodeList) do
        if v.level > 0 then
            local cfg = Config.GetTechnologyTreeListByGroupAndLv(v.groupId, v.level)
            if cfg and (tablex.find(cfg.effectiveScope[1], shipType) == true or
             tablex.find(cfg.effectiveScope[2], heroCfg.nation) or 
             tablex.find(cfg.effectiveScope[3], heroCfg.attribute))then
                if cfg.type == GE.TechTreeNodeEffectType.Attr then
                    if cfg.bombardPct and cfg.bombardPct ~= 0 then
                        bonus.bombard = bonus.bombard + NatureList["bombard"] * cfg.bombardPct / 100
                    end
                    if cfg.torpedoPct and cfg.torpedoPct ~= 0 then
                        bonus.torpedo = bonus.torpedo + NatureList["torpedo"] * cfg.torpedoPct / 100
                    end
                    if cfg.armorPct and cfg.armorPct ~= 0 then
                        bonus.armor = bonus.armor + NatureList["armor"] * cfg.armorPct / 100
                    end
                    if cfg.evadePct and cfg.evadePct ~= 0 then
                        bonus.evade = bonus.evade + NatureList["evade"] * cfg.evadePct / 100
                    end
                    if cfg.hpPct and cfg.hpPct ~= 0 then
                        bonus.hp = bonus.hp + NatureList["hp"] * cfg.hpPct / 100
                    end
                    if cfg.airdefensePct and cfg.airdefensePct ~= 0 then
                        bonus.airdefense = bonus.airdefense + NatureList["airdefense"] * cfg.airdefensePct / 100
                    end
                    if cfg.luckyPct and cfg.luckyPct ~= 0 then
                        bonus.lucky = bonus.lucky + NatureList["lucky"] * cfg.luckyPct / 100
                    end

                    if cfg.bombardAbs then
                        bonus.bombard = bonus.bombard + cfg.bombardAbs
                    end
                    if cfg.torpedoAbs then
                        bonus.torpedo = bonus.torpedo + cfg.torpedoAbs
                    end
                    if cfg.armorAbs then
                        bonus.armor = bonus.armor + cfg.armorAbs
                    end
                    if cfg.evadeAbs then
                        bonus.evade = bonus.evade + cfg.evadeAbs
                    end
                    if cfg.hpAbs then
                        bonus.hp = bonus.hp + cfg.hpAbs
                    end
                    if cfg.airdefenseAbs then
                        bonus.airdefense = bonus.airdefense + cfg.airdefenseAbs
                    end
                    if cfg.luckyAbs then
                        bonus.lucky = bonus.lucky + cfg.luckyAbs
                    end
                elseif cfg.type == GE.TechTreeNodeEffectType.Skill then
                    for _, skillId in pairs(cfg.getSkill) do
                        table.insert(effectiveSkill, skillId)
                    end
                end
            end

        end
    end
    return bonus
end 


---------------------------------------------------------------------

---获取节点最高等级
---@param groupId number 节点组id
---@return integer 节点最大等级
function Player:getTechTreeNodeMaxLv(groupId)
    local info = Config.GetTechnologyTreeListByGroup(groupId)
    if not info then
        return 0
    end
    return tablex.size(info)
end

---@class TechnologyTreeNodePreInfo
---@field groupId integer 前置节点组id
---@field level integer 前置节点等级

--获取节点前置点位
---@param groupId number 节点组id
---@return TechnologyTreeNodePreInfo 前置点位信息
function Player:getTechTreeNodePreInfo(groupId)
    local info = Config.GetTechnologyTreeListByGroupAndLv(groupId, 1)
    if not info then
        return nil
    end
    local cfg = nil
    local pre = info.prepoint
    if pre and pre > 0 then
        cfg = Config.GetTechnologyTreeInfo(pre)
    end
    if not cfg then
        return nil
    end
    return {
        groupId = cfg.group,
        level = cfg.level,
    }
end

--获取科技树家园提升类型数据
function Player:getTechTreeHomeUp()
    if not self.techTreeHomeUp then
        self:updateTechTreeHomeUp()
    end
    return self.techTreeHomeUp
end

--更新科技树家园提升类型数据
function Player:updateTechTreeHomeUp()
    self.techTreeHomeUp = {}
    local treeNodeDataList = self:getTechnologyTreeNodeInfoByPageId(GE.TechnologyTreeType.page4)
    for _, nodeData in pairs(treeNodeDataList) do
        local nodeCfg = Config.GetTechnologyTreeListByGroupAndLv(nodeData.groupId, nodeData.level)
        if nodeCfg and tablex.size(nodeCfg.homeUp) > 0 then
            for _, up in pairs(nodeCfg.homeUp) do
                table.insert(self.techTreeHomeUp, up)
            end
        end
    end
end


--获取科技树增加的家园散步角色数量 弃用20260309 郭翔宇#1008462<港区>宿舍+指挥中心优化 取消科技树加成

function Player:getTechTreeAddWalkRoleCount()
    return 0 
end

return Player