-- Desc: 跑片逻辑
---@class Player
local Player = require "Player"

---@return GenRoleFragInfo
function Player:getGenRoleFragData()
    return self.genRoleFragData
end

---获取当日生成跑片角色次数
function Player:getGenRoleFragCount()
    local data = self:getGenRoleFragData()
    return data.availableCount
end

---修改当日可生成跑片角色次数
function Player:changeGenRoleFragAvailableCount(count)
    local data = self:getGenRoleFragData()
    data.availableCount = data.availableCount + count
end

---获取当日已生成过的跑片角色列表
function Player:genGenRoleFragGenRoleList()
    local data = self:getGenRoleFragData()
    return data.genRoleList or {}
end

---检测角色是否已生成过跑片
---@param roleId number 角色id
function Player:getGenRoleFragIsGen(roleId)
    return tablex.find(self:genGenRoleFragGenRoleList(), roleId)
end

function Player:addGenRole(roleId)
    local data = self:getGenRoleFragData()
    tablex.insertproxy(data.genRoleList, roleId)
end

---检测是否可以生成跑片角色
function Player:genRoleCanUse()
    return self:getGenRoleFragCount() < Config.GetConfigInfo("GenRoleFragBasicTimes")
end

--跑片逻辑
---@param roleIdList table 节点id
---@param proto UserInfo 协议数据
---@return ActionFailReason 错误码
---@return RewardInfo[]? 奖励列表
function Player:genRoleFrag(roleIdList, proto)
    local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.GenRoleFrag)
    if isOpen == GE.FunctionOpenState.Lock then
        return ActionFailReason.FunctionOpenNotOpen
    end
    if not roleIdList or tablex.size(roleIdList) == 0 then
        return ActionFailReason.LackParameter
    end
    --availbeleCount judge
    if self:getGenRoleFragCount() >= Config.GetConfigInfo("GenRoleFragBasicTimes") then
        return ActionFailReason.LackOfTimes
    end

    --is genRole Judge
    local genRoleList = self:genGenRoleFragGenRoleList()

    local curRoleIdList = {}
    for _, roleId in ipairs(roleIdList) do
        if roleId ~= 0 then
            --角色是否拥有
            local roleData = self:getPlayerHero(roleId)
            if not roleData then
                return ActionFailReason.HeroNoFind
            end
            --最大星级检测
            local heroCfg = Config.GetCharacterInfo(roleId)
            if not heroCfg then
                return ActionFailReason.HeroNoFind
            end
            if roleData.star >= #heroCfg.talentId then
                return ActionFailReason.HeroStarMax
            end
            --碎片数量检测
            local itemId = heroCfg.patchCost[1][2]
            local itemCount = self:getItemCountById(itemId)
            local maxNeed = 0
            for index = roleData.star + 1, tablex.size(heroCfg.patchCost) do
                maxNeed = maxNeed + heroCfg.patchCost[index][3]
            end
            if itemCount >= maxNeed then
                return ActionFailReason.HeroFragIsFull
            end

            --角色是否重复
            if tablex.find(curRoleIdList, roleId) then
                return ActionFailReason.ParameterInvalid
            end
            if tablex.find(genRoleList, roleId) then
                return ActionFailReason.RoleAlreadyGen
            end
            table.insert(curRoleIdList, roleId)
        end
    end
    --角色数量判断
    local slotCount = self:genRoleFragSlotUnlockCount()
    if tablex.size(curRoleIdList) > slotCount then
        return ActionFailReason.RoleFragSlotNotUnlock
    end
    self:changeGenRoleFragAvailableCount(1)
    --活动加成    
    local addRoleList = {}
    local activityConfig = Config.GetActivityByType(GE.ActivityType.GenRoleFragExtra)[1]
    if activityConfig then
        local activityInfo = self:getActivityInfo(activityConfig.id)
        if activityInfo and activityInfo.state == GE.ActivityState.Open then
            for _, v in pairs(activityConfig.activityPara) do
                addRoleList[v[1]] = v[2]
            end
        end
    end
    local rewardList = {}
    for _, roleId in ipairs(roleIdList) do
        if roleId ~= 0 then
            self:addGenRole(roleId)
            local roleCfg = Config.GetCharacterInfo(roleId)
            if roleCfg then
                --TODO buff add num
                local num = Config.GetConfigInfo("GenRoleFragBasicNum") + self:getGenRoleFragExtraAdd(roleId)
                if addRoleList[roleId] then
                    num = num + addRoleList[roleId]
                end
                local fragItemId = roleCfg.getPatch[1][2]
                table.insert(rewardList, {[1] = GE.RewardType.ItemProp, [2] = fragItemId, [3] = num})
            end
        end
    end

    proto.genRoleFragData = self:getGenRoleFragData()

    -- 触发同步训练次数任务
    self:missionTrigger(GE.MissionFinishType.SyncTrainingCount, {count = 1}, proto)
    self:addProsperityByGetType(GE.GetProsperityType.SyncTraining, proto)

    rewardList = self:addRewardList(rewardList, proto, GE.EventItemType.GenRoleFrag)
    return ActionFailReason.None, rewardList
end

---获得已解锁跑片槽位数量
function Player:genRoleFragSlotUnlockCount()
    local constructData = self:getConstructionDataById(GE.CoustructionEnum.TrainingCenter)
    if not constructData or constructData.level <= 0 then
        return 0
    end

    --建筑一级时默认解锁1个槽位
    local count = 1

    --此建筑效果不是累增，可以直接判断当前等级效果
    local constructLvCfg = Config.GetConstructionLevelInfoByTypeLevel(GE.CoustructionEnum.TrainingCenter, constructData.level)
    if constructLvCfg then
        for _, effect in pairs(constructLvCfg.effect) do
            if effect[1] == GE.HomeBuildEffectType.GenRoleSlot then
                return effect[2]
            else
                return count
            end
        end
    end

    return count
end

---获取角色碎片获取加成
---@param roleId number 角色id
function Player:getGenRoleFragExtraAdd(roleId)
    local totalAdd = 0
    --单角色好感度加成
    totalAdd = totalAdd + self:getGenRoleFragExtraAddByAffect(roleId)
    --科技树家园词条全量加成
    --totalAdd = totalAdd + self:getGenRoleFragExtraAddByTechTree(roleId)
    return totalAdd
end

-- function Player:getGenRoleFragExtraAddByTechTree(roleId)
--     local totalAdd = 0
--     --科技树家园词条全量加成
--     local upCfgList = self:getTechTreeHomeUp()
--     for _, effect in pairs(upCfgList) do
--         if effect[1] == GE.TechTreeHomeUpType.GenRoleFragAdd then
--             totalAdd = totalAdd + effect[2]
--         end
--     end
--     return totalAdd
-- end

function Player:getGenRoleFragExtraAddByAffect(roleId)
    local totalAdd = 0
    --单角色好感度加成
    local roleData = self:getPlayerHero(roleId)
    if roleData then
        local addCfg = Config.GetConfigInfo("AffectionAddFrag")
        if addCfg  then
            local maxClaimedLevel = 0
            if roleData.affectionRewardList then
                for _, level in pairs(roleData.affectionRewardList) do
                    if level > maxClaimedLevel then
                        maxClaimedLevel = level
                    end
                end
            end
            for _, v in pairs(addCfg) do
                if maxClaimedLevel >= v[1] then
                    totalAdd = totalAdd + v[2]
                end
            end
        end
    end
    return totalAdd
end

---重置跑片数据
---@param proto? UserInfo 玩家信息差量更新结构
function Player:reSetGenRoleFragData(proto)
    local data = self:getGenRoleFragData()
    data.availableCount = 0
    data.genRoleList = {}
    if proto then
        proto.genRoleFragData = {
            availableCount = data.availableCount,
            genRoleList = data.genRoleList,
        }
    end
end

return Player