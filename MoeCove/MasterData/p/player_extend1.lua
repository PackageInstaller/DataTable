-- 不好归类的功能
---@class Player
local Player = require "Player"
local GameGlobal
if GV.IsServer then
    GameGlobal = require "GameGlobal"
end



--请求获得某功能数据
---@param functions string[]
---@param userinfo table
function Player:getFunctionData(functions, userinfo)
    --入参检测
    if not functions then
        return ActionFailReason.ParameterInvalid
    end
    if tablex.size(functions) > 10 or tablex.size(functions) < 1 then
        return ActionFailReason.ParameterInvalid
    end

    --过滤重复
    local tempList = {}
    for i,v in pairs(functions) do
        -- if not self.SerialiseValues[v] then
        --     return ActionFailReason.ParameterInvalid
        -- end
        -- if tempList[v] then
        --     return ActionFailReason.ParameterInvalid
        -- end
        tempList[v] = true
    end

    for k,_ in pairs(tempList) do
        if k == "friendInfo" then
            --向公共组请求再推一次
            if GameGlobal then
                GameGlobal.ReqFriendInfo(self.uid)
            end
        elseif self[k] and Player.SerialiseValues[k] then
            userinfo[k] = self:propToProto(k)
        end
    end

    return ActionFailReason.None
end

--获得分享数据
---@return ShareInfo[]
function Player:getShareData()
    if not self.shareMap then
        self.shareMap = {}
    end
    return self.shareMap
end

--请求游戏分享
---@param shareType int
---@param proto? UserInfo 玩家信息差量更新结构
---@return ActionFailReason
---@return RewardInfo[]?
function Player:gameShare(shareType, proto)
    if not shareType or shareType < GE.ShareType.common or shareType >= GE.ShareType.max then
        return ActionFailReason.ParameterInvalid
    end

    local shareData = self:getShareData()
    local shareInfo = shareData[shareType]
    if not shareInfo then
        shareInfo = {
            count = 0,
            isAlready = false,
        }
        shareData[shareType] = shareInfo
    end
    shareInfo.count = shareInfo.count + 1

    local rewardList
    if shareInfo.count >= 1 and not shareInfo.isAlready then
        shareInfo.isAlready = true
        local shareReward = Config.GetConfigInfo("ShareReward")
        rewardList = self:addRewardList(shareReward, proto, GE.EventItemType.Share, shareType)
    end

    if proto then
        if not proto.shareMap then
            proto.shareMap = {}
        end
        proto.shareMap[shareType] = shareInfo
    end
    return ActionFailReason.None, rewardList
end

--重置分享数据
---@param proto? UserInfo 玩家信息差量更新结构
function Player:resetShareData(proto)
    local shareData = self:getShareData()
    for k,v in pairs(shareData) do
        v.count = 0
        v.isAlready = false
    end
    if proto then
        proto.shareMap = shareData
    end
end

return Player