local M = BaseClass("MainPreheatActivityUIContext", BaseContext)

function M:Open()
    self.m_awardInfo = {}
    ActivityDataMgr:GetInstance():GetActivitysByTypeAsyn(ActivityType.MAIN_ACTIVITY_COPY, function(datas)
        for _, data in ipairs(datas or {}) do
            if data:IsOpen() then
                if data:LockId() == 0 then
                    self:SendChapterActInfo(data:ActivityId(), function()
                        self:_Show(data)
                    end)
                else
                    GameHelper.TipsByLockId(data:LockId())
                end
                return
            end
        end

        GameHelper.TipsById(1055) -- 活动未开放
    end)
end

function M:SendChapterActInfo(activityId, callback)
    if self.m_rsActInfo then return end

    self.m_actInfoCallback = callback
    local msgId = Proto.MessageId.ResponseChapterActInfo
    local infoHandler = Bind(self, self.OnResponseChapterActInfo)
    self.m_rsActInfo = NetPack:RegistResponse(msgId, infoHandler)
    NetPack:SendMessage(Proto.MessageId.RequestChapterActInfo, { EntryId = activityId })
end

function M:OnResponseChapterActInfo(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsActInfo)
    self.m_rsActInfo = nil

    if result ~= 0 then return end
    self.m_awardInfo = {}
    for _, v in ipairs(msg.Info or {}) do
        self.m_awardInfo[v.SubId] = v.AwardFlag
    end

    if self.m_actInfoCallback then
        self.m_actInfoCallback()
        self.m_actInfoCallback = nil
    end
end

function M:SendChapterActAward(request, callback)
    if self.m_rsGetActAward then return end

    self.m_getActAward = callback
    local msgId = Proto.MessageId.ResponseChapterActAward
    local infoHandler = Bind(self, self.OnResponseChapterActAward)
    self.m_rsGetActAward = NetPack:RegistResponse(msgId, infoHandler)
    NetPack:SendMessage(Proto.MessageId.RequestChapterActAward, request)
end

function M:OnResponseChapterActAward(messageId, result, msg)
    NetPack:UnRegistResponse(messageId, self.m_rsGetActAward)
    self.m_rsGetActAward = nil

    if result ~= 0 then return end

    local info = msg.info or {}
    self.m_awardInfo[info.SubId] = info.AwardFlag
    if self.m_getActAward then
        self.m_getActAward(msg.Awards)
        self.m_getActAward = nil
    end
end

-- 是否已领取
function M:IsAward(id, idx)
    local mask = self.m_awardInfo[id] or 0
    return (1 << idx - 1) & mask > 0
end

-- 章节奖励红点
function M:CheckAwardRedPointAsync(chapterId, callback)
    for _, v in ipairs(ActivityDataMgr:GetInstance():GetActivitySimpleByType(ActivityType.MAIN_ACTIVITY_COPY) or {}) do
        if v:IsOpen() and (v:LockId() == 0) then
            local actId = v:ActivityId()
            if not self.m_awardInfo then
                self:SendChapterActInfo(actId, function()
                    callback(self:_CheckRedPoint(actId, chapterId))
                end)
                return
            end
            callback(self:_CheckRedPoint(actId, chapterId))
            return
        end
    end
    callback(false)
end

function M:_CheckRedPoint(activityId, chapterId)
    for _, cfg in ipairs(ConfigHelper.GetCfgsByLua("activityAddMission", { activityId = activityId }) or {}) do
        local id = cfg.id
        for i, cptId in ipairs(cfg.openChapter or {}) do
            if not self:IsAward(id, i) then -- 未领取
                if (chapterId == 0) or (chapterId == cptId) then
                    local isPass = MissionDataMgr:GetInstance():IsPassedChapter(cptId)
                    if isPass then return true end
                end
            end
            if chapterId == cptId then return false end
        end
    end
    return false
end

return M
