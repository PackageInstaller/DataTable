local this = {}
this.__index = this

function this.New(idCounter)
	local self = setmetatable({}, this)
	self.timers = {}
    self.pendingAdd = {}      -- 待添加缓冲
    self.pendingRemove = {}   -- 待移除标记
    self.idCounter = idCounter or 0 --起始ID
    self.isUpdating = false   -- 锁标志：是否正在遍历中
    return self;
end

-- 添加计时器
function this:AddTimer(duration, onComplete, isLoop)
    self.idCounter = self.idCounter + 1
    local id = self.idCounter
    local timer = UITimer.New(id, duration, onComplete, isLoop)
    
    -- 如果正在更新，先放缓冲池；否则直接加入
    if self.isUpdating then
        self.pendingAdd[id] = timer
    else
        self.timers[id] = timer
    end
    return id
end

-- 移除计时器
function this:RemoveTimer(id)
    if self.isUpdating then
        self.pendingRemove[id] = true
    else
        self.timers[id] = nil
    end
end

--在UI脚本中调用
function this:Update(deltaTime)
    self.isUpdating = true
    -- 遍历当前活跃的计时器
    for id, timer in pairs(self.timers) do
        -- 检查是否在这一帧被标记移除
        if not self.pendingRemove[id] then
            timer:Update(deltaTime)
            if timer.isFinished then
                self.pendingRemove[id] = true
            end
        end
    end
    
    self.isUpdating = false

    -- 处理缓冲：移除标记过的
    for id, _ in pairs(self.pendingRemove) do
        self.timers[id] = nil
        self.pendingRemove[id] = nil
    end

    -- 处理缓冲：加入新生成的
    for id, timer in pairs(self.pendingAdd) do
        self.timers[id] = timer
        self.pendingAdd[id] = nil
    end
end

-- 暂停/恢复
function this:PauseTimer(id)
    local t = self.timers[id] or self.pendingAdd[id]
    if t then t.isPaused = true end
end

function this:ResumeTimer(id)
    local t = self.timers[id] or self.pendingAdd[id]
    if t then t.isPaused = false end
end

function this:Clear()
    if self.timers then
        for id,val in pairs(self.timers) do
            self:RemoveTimer(id)
        end
    end
    self.pendingAdd = {}      -- 待添加缓冲
    self.pendingRemove = {}   -- 待移除标记
    self.idCounter = idCounter or 0 --起始ID
    self.isUpdating = false   -- 锁标志：是否正在遍历中
end

return this