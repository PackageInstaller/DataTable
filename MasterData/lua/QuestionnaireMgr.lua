local this = MgrRegister("QuestionnaireMgr")

function this:Init()
    self:Clear()
    QuestionnaireProto:GetInfo()
end

function this:Clear()
    self.datas = {}
    self.refreshTime = nil
end

function this:GetInfoRet(infos)
    self.datas = {}
    self.refreshTime = nil
    local curTime = TimeUtil:GetTime()
    local properties = ShiryuSDK.SdkProperties()
    local platform = properties["os"]
    local channel = properties["cid"]
    for k, v in pairs(infos) do
        for p, q in pairs(v.system) do
            if (tostring(q) == platform) then
                for n, m in pairs(v.channel) do
                    if (tostring(m) == channel) then
                        if (curTime >= v.openTime and curTime <= v.closeTime) then
                            table.insert(self.datas, v)
                        end
                        -- 最近的刷新时间
                        if (curTime >= v.openTime) then
                            -- 已开始未结束
                            if (curTime < v.closeTime and (self.refreshTime == nil or v.closeTime < self.refreshTime)) then
                                self.refreshTime = v.closeTime
                            end
                        else
                            -- 未开始
                            if (self.refreshTime == nil or v.openTime < self.refreshTime) then
                                self.refreshTime = v.openTime
                            end
                        end
                    end
                end
            end
        end
    end
    -- 红点计算
    self:CheckRed()
    EventMgr.Dispatch(EventType.Menu_Questionnaire)
end

function this:GetDatas()
    if (#self.datas > 1) then
        table.sort(self.datas, function(a, b)
            local index1 = a.getStatus == 1 and -1 or a.getStatus
            local index2 = b.getStatus == 1 and -1 or b.getStatus
            if (index1 == index2) then
                return a.id < b.id
            else
                return index1 < index2
            end
        end)
    end
    return self.datas
end

function this:GetDicDatas()
    local dic = {}
    for k, v in ipairs(self.datas) do
        dic[v.id] = v
    end
    return dic
end

-- 最近的刷新时间
function this:GetRefreshTime()
    return self.refreshTime
end

-- 是否显示入口
function this:IsShowEnter()
    return #self.datas > 0
end

-- 入口的红点
-- 未领取有红点
-- 收到新的有红点，不点入口就一直显示，点了后仅在3天内显示(如果已答并且领了就不显示)
-- 报错本地的数据：{[“id”]=time,[“id”]=time}
-- isClick点击入口
function this:CheckRed(isClick)
    local redNum = nil
    local newDatas = {}
    local oldDatas = FileUtil.LoadByPath(PlayerClient:GetID() .. "_questionnaire.txt") or {} -- 读取本地
    local dic = self:GetDicDatas()
    local curTime = TimeUtil:GetTime()
    for k, v in pairs(dic) do
        local num = oldDatas[v.id] or 0
        if (num == 0) then
            num = isClick and curTime or 0
        end
        newDatas[v.id] = num
    end

    FileUtil.SaveToFile(PlayerClient:GetID() .. "_questionnaire.txt", newDatas) -- 重新保存
    for k, v in pairs(newDatas) do
        if (dic[k].getStatus == 1) then
            redNum = 1
            break
        end
        if ((v == 0 or v > curTime) and dic[k].getStatus ~= 2) then
            redNum = 1
            break
        end
    end
    local oldRedNum = RedPointMgr:GetData(RedPointType.Questionnaire)
    if (oldRedNum ~= redNum) then
        RedPointMgr:UpdateData(RedPointType.Questionnaire, redNum)
    end
end

function this:GetRewardRet(id)
    for k, v in ipairs(self.datas) do
        if (v.id == id) then
            v.getStatus = 2 -- 已领取
        end
    end
    self:CheckRed()
end

function this:JumpRet(id)
    for k, v in ipairs(self.datas) do
        if (v.id == id) then
            v.getStatus = 1 -- 已点击
        end
    end
    self:CheckRed()
end

return this
