-- Desc: 签到数据处理
---@class Player
local Player = require "Player"


-- 获取所有签到数据
---@return table<integer, SignInfo>
function Player:getSignData()
    return self.signData
end

-- 获取指定签到数据
---@param signId integer 签到id
---@return SignInfo?
function Player:getSignDataById(signId)
    local signData = self:getSignData()
    return signData[signId]
end

--检查签到是否已完成
---@param signId integer 签到id
---@return boolean
function Player:checkSignIsCompleted(signId)
    local signData = self:getSignDataById(signId)
    if not signData then
        LuaLogger.es("signData is nil", signId)
        return false
    end

    local signCfg = Config.GetsignInInfo(signId)
    if not signCfg then
        LuaLogger.es("signCfg is nil", signId)
        return false
    end

    --常驻签到，不会完成
    if signCfg.type == GE.SignType.normalSign then
        return false
    end

    --获取签到对应的奖励天数
    local awardCfgs = Config.GetSignAwardInfoByGroup(signCfg.awardGroud)
    if not awardCfgs then
        LuaLogger.es("awardCfg is nil", signId)
        return false
    end
    if tablex.size(awardCfgs) > tablex.size(signData.alreadyAwards) then
        return false
    end

    return true
end

--开启签到
---@param signId integer 签到id
---@param proto? UserInfo 玩家信息差量更新结构
function Player:signOpen(signId, proto)
    if not signId then
        LuaLogger.es("signId is nil")
        return
    end

    local signCfg = Config.GetsignInInfo(signId)
    if not signCfg then
        LuaLogger.es("signCfg is nil", signId)
        return
    end

    local signData = self:getSignData()
    if not signData then
        LuaLogger.es("signData is nil")
        return
    end

    if signData[signId] then
        LuaLogger.es("signData[signId] is not nil", signId)
        return
    end

    signData[signId] = {
        signIndex = 1,     --默认第一天
        alreadyAwards = {},
    }

    if proto then
        proto.signData = signData
    end
end

--关闭签到
---@param signId integer 签到id
---@param proto? UserInfo 玩家信息差量更新结构
function Player:signClose(signId, proto)
    if not signId then
        LuaLogger.es("signId is nil")
        return
    end

    --关闭签到不需要判断签到配置
    -- local signCfg = Config.GetsignInInfo(signId)
    -- if not signCfg then
    --     LuaLogger.es("signCfg is nil", signId)
    --     return
    -- end

    local signData = self:getSignData()
    if not signData then
        LuaLogger.es("signData is nil")
        return
    end

    if not signData[signId] then
        LuaLogger.es("signData[signId] is nil", signId)
        return
    end

    --删除签到数据
    signData[signId] = nil
    if proto then
        proto.signData = signData
    end
end

--每日签到数据更新
---@param proto? UserInfo 玩家信息差量更新结构
function Player:updateSignData(proto)
    local signData = self:getSignData()
    if not signData then
        LuaLogger.es("signData is nil")
        return
    end

    for signId, signInfo in pairs(signData) do
        local signCfg = Config.GetsignInInfo(signId)
        if not signCfg then
            LuaLogger.es("signCfg is nil", signId)
            goto continue
        end
        local awardCfgs = Config.GetSignAwardInfoByGroup(signCfg.awardGroud)
        if not awardCfgs then
            LuaLogger.es("awardCfg is nil", signId)
            goto continue
        end

        --常驻签到，一直轮询
        if signCfg.type == GE.SignType.normalSign then
            signInfo.signIndex = signInfo.signIndex + 1
            if signInfo.signIndex > tablex.size(awardCfgs) then
                signInfo.signIndex = 1
            end
        --活动签到，只有一轮
        elseif signCfg.type == GE.SignType.activitySign then
            if signInfo.signIndex < tablex.size(awardCfgs) then
                signInfo.signIndex = signInfo.signIndex + 1
            else
                --签到已满
                LuaLogger.ds("signIndex is max", signId)
            end
        end

        ::continue::
    end
    if proto then
        proto.signData = signData
    end
end

--获取签到奖励
---@param signId integer 签到id
---@param signIndex integer 签到index
---@param proto UserInfo 用户信息
---@return ActionFailReason 错误码
---@return RewardInfo[]? 奖励列表
function Player:getSignReward(signId, signIndex, proto)
    if not signId or not signIndex then
        return ActionFailReason.ParameterInvalid
    end

    local signInfo = self:getSignDataById(signId)
    if not signInfo then
        -- LuaLogger.es("signInfo is nil", signId)
        return ActionFailReason.SignInNoFind
    end

    if signIndex > signInfo.signIndex or signIndex < 1 then
        -- LuaLogger.es("signIndex is out of range", signId, signInfo.signIndex)
        return ActionFailReason.ParameterInvalid
    end

    local signCfg = Config.GetsignInInfo(signId)
    if not signCfg then
        LuaLogger.es("signCfg is nil", signId)
        return ActionFailReason.CfgNotFind
    end
    if signCfg.type == GE.SignType.normalSign then
        local isOpen = self:getFunctionOpenStateById(GE.FunctionOpenModule.SignPop)
        if isOpen == GE.FunctionOpenState.Lock then
            return ActionFailReason.FunctionOpenNotOpen
        end
    end

    local awardCfgs = Config.GetSignAwardInfoByGroup(signCfg.awardGroud)
    if not awardCfgs then
        LuaLogger.es("awardCfg is nil", signId)
        return ActionFailReason.CfgNotFind
    end

    if signIndex > tablex.size(awardCfgs) then
        LuaLogger.es("signIndex is out of range", signId, signIndex)
        return ActionFailReason.CfgNotFind
    end

    --签到奖励已领取
    if tablex.find(signInfo.alreadyAwards, signIndex) then
        return ActionFailReason.SignAlreadyGet
    end

    local rewardList = {}
    tablex.insertproxy(signInfo.alreadyAwards, signIndex)
    rewardList = self:addRewardList(awardCfgs[signIndex].award, proto, GE.EventItemType.SignIn, signId)

    if proto then
        proto.signData = self:getSignData()
    end

    return ActionFailReason.None, rewardList
end

return Player