local M = BaseClass("OtakuRoomByProduceDatalua", require("DataCenter.Otaku.BaseOtakuRoomData"))

-- 位置
function M:Position()
    if self.m_ExtraData == nil then return nil end
    return self.m_ExtraData.Position
end

-- 制造数量
function M:MakeItemNum()
    if self.m_ExtraData == nil then return 0 end
    return self.m_ExtraData.MakeItemNum
end

-- 制造道具Id
function M:MakeItemId()
    if self.m_ExtraData == nil then return 0 end
    return self.m_ExtraData.MakeItemId
end

-- 房间是否正在制造
function M:IsRoomMaking()
    return (self:MakeItemId() > 0) and (self:MakeItemNum() > 0)
end

-- 已经领取数量
function M:AwardNum()
    if self.m_ExtraData == nil then return 0 end
    return self.m_ExtraData.AwardNum
end

-- 剩余制造数量
function M:RemainMakeNum()
    return self:MakeItemNum() - self:AwardNum()
end

-- 上次触发的时间 例如撤下,入驻,刷新
function M:CalculateTick()
    if self.m_ExtraData == nil then return 0 end
    return self.m_ExtraData.CalculateTick
end

-- 生产停止时间(0表示不停止)
function M:TerminalTick()
    if self.m_ExtraData == nil then return 0 end
    return self.m_ExtraData.TerminalTick
end

-- 预计完成时间
function M:EndTick()
    if self.m_ExtraData == nil then return 0 end
    return self.m_ExtraData.EndTick
end

-- 当前生产进度
function M:Progress()
    if self.m_ExtraData == nil then return 0 end
    return self.m_ExtraData.Progress
end

-- { End = buff失效时间戳  Powers = power表数组  }
function M:Buffs()
    if self.m_ExtraData == nil then return {} end
    return self.m_ExtraData.BuffUnits or {}
end

-- 制作剩余时间
function M:ProduceRemainTime()
    return self:EndTick() - GameUtil.GetCurTimeTick()
end

-- 是否完成 名字统一 方便调用
function M:IsEnd()
    return self:ProduceRemainTime() <= 0
end

-- 是否可以领取 名字统一 方便调用
function M:IsFinish()
    if not self:IsRoomMaking() then return false end

    local curTime = TimeUtil.GetNowTimeStamp()
    local nextTime = OtakuHelper.NextGetMakeItemTime(self)
    if (curTime >= nextTime) and (nextTime > 0) then
        local stopTime = self:TerminalTick()
        return (stopTime == 0) or (stopTime >= nextTime)
    end
    return false
end

-- 房间是否停产中 1 无入驻英雄 2 有入驻英雄饱食度为0
function M:IsRoomStop()
    local curTime = TimeUtil.GetNowTimeStamp()
    local endTime = self:TerminalTick()
    if endTime > 0 and curTime > endTime then
        return true
    end
    return false
end

-- 额外附加数据 名字统一 方便调用
function M:ExtraData(data)
    self.m_ExtraData = data
    if self.m_ExtraData and self.m_ExtraData.BuffUnits then
        table.sort(self.m_ExtraData.BuffUnits, function(a, b)
            return a.Final < b.Final
        end)
    end
    EventMgr:Broadcast(UIMessageNames.CREATE_UPDATE_ROOM)
end

-- 当前制造效率加成
function M:CurMakeScale()
    local houseLevel = self.m_LevelConfig[self:Level()]
    return OtakuHelper.GetMakeScale(houseLevel)
end

-- 下一级制造效率加成
function M:NextMakeScale()
    local houseLevel = self.m_LevelConfig[self:NextLevel()]
    return OtakuHelper.GetMakeScale(houseLevel)
end

-- 初始化
function M:OnInit()

end

function M:OnUpdate(netUpdateType)
end

function M:OnDestory()
end

return M
