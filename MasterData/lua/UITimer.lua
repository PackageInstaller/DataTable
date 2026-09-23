local this = {}
this.__index = this

function this.New(id, duration, onComplete, isLoop)
	local self = setmetatable({}, this)
	self.id = id-- 唯一标识符
    self.duration = duration -- 总时长
    self.remainingTime = duration -- 剩余时间
    self.isLoop = isLoop or false
    self.isPaused = false
    self.isFinished = false -- 是否已完成
    self.onComplete = onComplete -- 完成时的回调
    return self;
end

function this:Update(deltaTime)
    if self.isFinished or self.isPaused then return end
    self.remainingTime = self.remainingTime - deltaTime
    if self.remainingTime <= 0 then
        if self.onComplete then self.onComplete(self.id) end
        if self.isLoop then
            self.remainingTime = self.duration + self.remainingTime
        else
            self.isFinished = true
        end
    end
end

return this;