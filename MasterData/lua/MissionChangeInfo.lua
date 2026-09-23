-- 任务变动的推送列表数据
--[[ 
eTaskType = {}
eTaskType.Main = 1 -- 主线
eTaskType.Sub = 2 -- 支线
eTaskType.Daily = 3 -- 日常
eTaskType.Weekly = 4 -- 每周
eTaskType.Activity = 5 -- 活动
eTaskType.DupTower = 6 -- 长期副本爬塔
eTaskType.TmpDupTower = 7 -- 短期副本爬塔
eTaskType.DupTaoFa = 8 -- 讨伐
eTaskType.Story = 9 -- 剧情
eTaskType.DupFight = 10 -- 战场
]] local this = {
    -- 小的排前面
    typeSort = {
        [1] = 4,
        [2] = 5,
        [3] = 2,
        [4] = 3,
        [5] = 1
    }
}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(sTaskInfo)
    self.id = sTaskInfo.id
    self.cfgid = sTaskInfo.cfgid
    self.type = sTaskInfo.type
    self.finish_ids = sTaskInfo.finish_ids
    self.state = sTaskInfo.state
    self.cfg = MissionMgr:GetCfg(self:GetType(), self:GetCfgID())
end

function this:GetState()
    return self.state
end

function this:GetCfgID()
    return self.cfgid
end

function this:GetType()
    return self.type or 1
end

-- 排序用
function this:GetTypeCount()
    local index = self.typeSort[self:GetType()]
    if (index == nil) then
        index = self:GetType()
    end
    return index
end

function this:GetDesc()
    return self.cfg and self.cfg.sDescription or ""
end

function this:GetCnt()
    if (self.cnt) then
        return self.cnt
    end
    if (self.finish_ids) then
        if (#self.finish_ids > 1) then
            for i, v in ipairs(self.finish_ids) do
                local cfg = Cfgs.CfgTaskFinishVal:GetByID(v.id)
                if (cfg and v.num < cfg.nVal1) then
                    self.cnt = 0
                    return self.cnt
                end
            end
            self.cnt = 1
            return self.cnt
        else
            return self.finish_ids[1].num
        end
    else
        self.cnt = 1
        return self.cnt
    end
end

function this:GetFinishIDs()
    return self.finish_ids
end

function this:GetMaxCnt()
    if (self.max) then
        return self.max
    end
    local finish_ids = self:GetFinishIDs()
    if (finish_ids and #finish_ids == 1) then
        local finishCfg = Cfgs.CfgTaskFinishVal:GetByID(finish_ids[1].id)
        if (finishCfg) then
            self.max = finishCfg.nVal1
            return self.max
        end
    end
    self.max = 1
    return self.max
end

function this:GetCount()
    return self:GetCnt(), self:GetMaxCnt()
end

-- success cnt   达成 0 未当初 1 
function this:GetSuccessNum()
    if (self.successNum) then
        return self.successNum
    end
    local cnt, max = self:GetCount()
    self.successNum = cnt >= max and 0 or 1
    return self.successNum
end

function this:IsFinish()
    local cur, max = self:GetCount()
    return cur >= max
end

return this
