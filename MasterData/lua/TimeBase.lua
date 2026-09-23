-- 用于计算倒计时的基类
TimeBase = {}
local this = TimeBase

function this.New()
    this.__index = this.__index or this;
    local ins = {};
    setmetatable(ins, this);
    ins:Init()
    return ins;
end

function this:Init()
    self.isRun = false
    self.timer = 0
    self.needTime = 0
    self.endTime = 0
end

function this:Update()
    if (self.isRun) then
        if (Time.time > (self.timer + 0.1)) then
            self.timer = Time.time
            self:SetTime()
        end
    end
end

-- ==============================--
-- desc: 调用运行
-- time:2020-05-13 02:37:23
-- @endTime: 结束时间
-- @cb: 每0.1秒回调一次，参数是剩余时间
-- @return 
-- ==============================--
function this:Run(endTime, cb)
    self.endTime = endTime or 0
    self.cb = cb
    if (self.endTime > 0) then
        self.needTime = self.endTime - TimeUtil:GetTime() + 0.9
        self.needTime = self.needTime > 0 and self.needTime or 0
    else
        self.needTime = 0
    end
    if (self.cb) then
        self.cb(self.needTime)
    end
    self.timer = Time.time
    self.isRun = self.needTime >= 0
end

function this:SetTime()
    self.needTime = self.endTime - TimeUtil:GetTime()
    self.needTime = self.needTime > 0 and self.needTime or 0
    self.isRun = self.needTime > 0
    if (self.cb) then
        self.cb(self.needTime)
    end
end

function this:Stop(_isStop)
    self.isRun = not _isStop
end

return this
