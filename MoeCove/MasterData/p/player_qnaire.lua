-- 调查问卷
---@class Player
local Player = require "Player"
local json, DataLogMgr
if GV.IsServer then
    json = require "json"
    DataLogMgr = require "DataLogMgr"
end


-- 获取问卷调查信息
---@return QnaireInfo[]
function Player:getQnaireData()
    if not self.qnaireMap then
        self.qnaireMap = {}
    end
    return self.qnaireMap
end

--获得某个问卷调查信息
---@param qnaireId integer
---@return QnaireInfo?
function Player:getOneQnaireInfo(qnaireId)
    local qnaireMap = self:getQnaireData()
    if not qnaireMap[qnaireId] then
        qnaireMap[qnaireId] = self:qnaireInit(qnaireId)
    end
    return qnaireMap[qnaireId]
end

-- 初始化问卷调查信息
---@param qnaireId integer
---@return QnaireInfo?
function Player:qnaireInit(qnaireId)
    local cfg = Config.GetQuestionnaireInfoByCodeid(qnaireId)
    if not cfg then
        return nil
    end

    local info = {
        qnaireId = qnaireId,
        isCompleted = false,
        isRewarded = false,
    }

    return info
end

-- 设置问卷调查完成状态
---@param data table
--      {
--          survey_id
--          answers
--      }
---@proto UserInfo?
---@return ActionFailReason
function Player.setQnaireCompleted(self, data, proto)
    local qnaireId = tonumber(data.survey_id)
    if not qnaireId or qnaireId < 1 then
        return ActionFailReason.ParameterInvalid
    end
    local cfg = Config.GetQuestionnaireInfoByCodeid(qnaireId)
    if not cfg then
        return ActionFailReason.CfgNotFind
    end

    --检查开启条件
    if not Player.canOpenFunctionByCfg2(self, cfg.unlock) then
        return ActionFailReason.LackOfPrecond
    end

    --检测结束条件
    if Player.canOpenFunctionByCfg2(self, cfg.endCondition) then
        return ActionFailReason.LackOfPrecond
    end

    local qnaireInfo = self.qnaireMap[qnaireId]
    if not qnaireInfo then
        qnaireInfo = {
            qnaireId = qnaireId,
            isCompleted = false,
            isRewarded = false,
        }
        self.qnaireMap[qnaireId] = qnaireInfo
    end

    local escapedAnswers = json.encode(data.answers, true)
    if DataLogMgr then
        DataLogMgr.LogQnaire(
            {
                qnaire_id = qnaireId,
                answers = escapedAnswers,
            }, self)
    end

    if qnaireInfo.isCompleted then
        return ActionFailReason.None
    end

    qnaireInfo.isCompleted = true
    if proto then
        proto.qnaireMap = self:propToProto("qnaireMap")
    end
    return ActionFailReason.None
end

--领取调查问卷奖励
---@param qnaireId integer
---@param proto UserInfo?
---@return ActionFailReason
---@return RewardInfo[]?
function Player:GetQnaireReward(qnaireId, proto)
    if not qnaireId or qnaireId < 1 then
        return ActionFailReason.ParameterInvalid
    end

    local qnaireCfg = Config.GetQuestionnaireInfoByCodeid(qnaireId)
    if not qnaireCfg then
        return ActionFailReason.CfgNotFind
    end

    local qnaireInfo = self:getOneQnaireInfo(qnaireId)
    if not qnaireInfo then
        return ActionFailReason.QnaireNotExist
    end

    if not qnaireInfo.isCompleted then
        return ActionFailReason.QnaireNotCompleted
    end

    if qnaireInfo.isRewarded then
        return ActionFailReason.QnaireAlreadyRewarded
    end

    --发放奖励
    local rewardList = self:addRewardList(qnaireCfg.Reward, proto, GE.EventItemType.Qnaire, qnaireId)

    --标记已领奖
    qnaireInfo.isRewarded = true

    if proto then
        proto.qnaireMap = self:propToProto("qnaireMap")
    end

    return ActionFailReason.None, rewardList
end


return Player