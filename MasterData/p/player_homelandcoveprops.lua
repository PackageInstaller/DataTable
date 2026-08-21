--- Desc: 家园可交互对象类
---@class Player
local Player = require "Player"
local DataLogMgr, GameGlobal
---@diagnostic disable-next-line: GV
if GV.IsServer then
    DataLogMgr = require "DataLogMgr"
    GameGlobal = require "GameGlobal"
end

---过更新点重置
---@param proto UserInfo
function Player:UpdateCovePropsData(proto)
    local coveProps = self:getHomeland().coveProps
    if coveProps == nil then
        return
    end

    local updateCoveProps = {}
    for k, v in pairs(coveProps) do
        if v.getCount ~= 0 then
           v.getCount = 0
           updateCoveProps[v.id] = v
        end
    end
    if tablex.empty(updateCoveProps) then
        return
    end
    proto.homeland = proto.homeland or {}
    proto.homeland.coveProps = proto.homeland.coveProps or {}
    proto.homeland.coveProps = updateCoveProps
end

---@param id integer
---@return CovePropsInfo?
function Player:GetCovePropsInfo(id)
    local homeland = self:getHomeland()
    if homeland == nil then
       return nil
    end
    if homeland.coveProps == nil then
       return nil
    end
    return homeland.coveProps[id]
end

---家园互动道具是否可以添加奖励
---@param id integer
---@return boolean
function Player:CovePropsCanAddReward(id)
    ---@type HomeTouchConstructionTable?
    local cfg = Config.GetHomeTouchConstructionInfo(id)
    if cfg == nil then
       return false 
    end
    local homeland = self:getHomeland()
    if homeland == nil then
       return false
    end
    if homeland.coveProps == nil then
       return true
    end
    local props = homeland.coveProps[id]
    if props == nil then
       return true 
    end
    if props.getCount >= cfg.dailyAwardNum then
        return false
    end
    return true
end

---添加互动道具奖励
---@param id integer
---@param actionIndex integer
---@param userInfo UserInfo
function Player:AddCovePropsReward(id, actionIndex, userInfo)
    if id == nil or actionIndex == nil then
        return ActionFailReason.ParameterInvalid
    end
    ---@type HomeTouchConstructionTable?
    local cfg = Config.GetHomeTouchConstructionInfo(id)
    if not cfg or not cfg.randomDrop then
       return ActionFailReason.CoveUsableItemNotExist
    end

    local actionCfg = cfg.randomDrop[actionIndex]
    if not actionCfg then
       return ActionFailReason.CfgNotFind
    end

    local coveProps = self:GetCovePropsInfo(id)
    if not coveProps then
        coveProps = {
            id = id,
            getCount = 0,
            dropList = {}
        }
        local homeland = self:getHomeland()
        homeland.coveProps = homeland.coveProps or {}
        homeland.coveProps[id] = coveProps
    end

    if coveProps.getCount >= cfg.dailyAwardNum then
       return ActionFailReason.BuildingInteractMax
    end

    local rewards = {}
    for _, dropId in ipairs(actionCfg) do
        tablex.insertproxy(coveProps.dropList, dropId)
        table.insert(rewards, dropId)
    end

    --有奖励 记录次数
    if #rewards > 0 then
        coveProps.getCount = coveProps.getCount + 1
    end

    userInfo.homeland = userInfo.homeland or {}
    userInfo.homeland.coveProps = userInfo.homeland.coveProps or {}
    userInfo.homeland.coveProps[id] = coveProps
    return ActionFailReason.None, rewards
end

---领取互动道具奖励
---@param id integer
---@param userInfo UserInfo
---@return ActionFailReason, RewardInfo[]?
function Player:GetCovePropsReward(id, userInfo)
    if not id then
       return ActionFailReason.ParameterInvalid
    end

    local coveProps = self:GetCovePropsInfo(id)
    if not coveProps then
       return ActionFailReason.CoveUsableItemNotExist
    end

    if not coveProps.dropList or tablex.empty(coveProps.dropList) then
        return ActionFailReason.CoveUsableItemInsufficientAttempts
    end

    local awardList = {}
    for _, dropId in ipairs(coveProps.dropList) do
        awardList = tablex.combine(awardList, self:getRandomAward(dropId))
    end
    local rewardList = self:addRewardList(awardList, userInfo, GE.EventItemType.HomeCoveUsableItem, id)
    rewardList = self:mergeRewardList(rewardList)

    coveProps.dropList = {}
    userInfo.homeland = userInfo.homeland or {}
    userInfo.homeland.coveProps = userInfo.homeland.coveProps or {}
    userInfo.homeland.coveProps[id] = coveProps
    return ActionFailReason.None, rewardList
end

return Player