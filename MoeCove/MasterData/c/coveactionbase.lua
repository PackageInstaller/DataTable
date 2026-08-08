

---@class CoveActionBase:BaseClass
local CoveActionBase = class("CoveActionBase")


---@param data CoveBase
function CoveActionBase:ctor(data)
    self.covebase = data
    self.isInit = false
    ---@type fun()
    self.callback = nil
    self.isRuning = false
end

function CoveActionBase:Init()


end

function CoveActionBase:OnInit()
    self.isInit = true
end


function CoveActionBase:Begin(...)
    self.isRuning = true
end

function CoveActionBase:Pause()
    
end

---是否运行中
---@return boolean
function CoveActionBase:IsRuning()
    return self.isRuning
end


function CoveActionBase:Stop()
    if self.callback ~= nil then
        self.callback()
    end
    self.callback = nil
    self.isRuning = false
end

function CoveActionBase:Exit()
    self.callback = nil
    self.isRuning = false
end

---设置完成回调
---@param cb fun()
function CoveActionBase:SetCompleteCallback(cb)
    self.callback = cb
end


---删回调
function CoveActionBase:Destroy()
    self.callback = nil
    self.isRuning = false
    self.isInit = false
    self.covebase = nil
    self:DeleteAllWaitTime()
end



---@param duration number
---@param callBack function
function CoveActionBase:AddTimeWait(duration, callBack)
	return TimeMgr:AddWaitTimeExecute(duration, callBack, self, false)
end

---@param timeId number
function CoveActionBase:DeleteWaitTimeExecute(timeId)
	return TimeMgr:DeleteWaitTimeExecute(timeId)
end


function CoveActionBase:DeleteAllWaitTime()
	return TimeMgr:DeleteWaitTimeExecute(self)
end




return CoveActionBase

