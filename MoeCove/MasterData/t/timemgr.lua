
---@class TimeMgr
local TimeMgr = class("TimeMgr")

function TimeMgr:ctor(...)

    ---@type table<integer, WaitTimeData>
    self.callBack = {}
end

local id = 0
local idHelp = function()
    id = id + 1
    return id
end

---@param self TimeMgr
---@param func function
---@param obj any
---@param id int
local executeWaitTime = function(self, func, obj, id)
    local callBack = self.callBack[id]
    if callBack ~= nil then
        callBack.timer = nil
        callBack.callback = nil
    end
    self.callBack[id] = nil
    local success, err = pcall(func, obj)
    if not success then
        LuaLogger.ws("===>>> 回调错误 error:" .. err)
    end
end

---@class WaitTimeData
---@field id int
---@field timer table Timer or FrameTimer
---@field callback function BindCallback
---@field obj table? 对象

---添加一个延时执行方法
---@generic V
---@param delay number 延时时间
---@param func fun(obj:V) 延时方法
---@param obj V? caller
---@param use_frame boolean? 是否是帧数 默认false
---@return number 返回id用来取消
function TimeMgr:AddWaitTimeExecute(delay, func, obj, use_frame)
    local id = idHelp()
    -- local callBack = BindCallback(self, executeWaitTime, func, obj, id)
	local callBack = function ()
        executeWaitTime(self, func, obj, id)
    end
    local timer = nil
	if use_frame then
		timer = FrameTimer.New(callBack, delay)
	else
		timer = Timer.New(callBack, delay)
	end
    timer:Start()

    ---@type WaitTimeData
    local wd = {
        id = id,
        timer = timer,
        callback = callBack,
        obj = obj,
    }
    self.callBack[id] = wd
    return id
end

---删除延时执行方法
---@param id number|table 延时执行的ID
function TimeMgr:DeleteWaitTimeExecute(id)
    if id == nil then
        return
    end
    if type(id) == "number" then
        ---@type WaitTimeData
        local callBack = self.callBack[id]
        if callBack ~= nil then
            if callBack.timer ~= nil then
                callBack.timer:Stop()
            end
            callBack.timer = nil
            callBack.callback = nil
        end
        self.callBack[id] = nil
    else
        ---@type int[]
        local delKey = {}
        for k, v in pairs(self.callBack) do
            if v.obj == id then
                table.insert(delKey, v.id)
            end
        end
        for i,v in ipairs(delKey) do
            self:DeleteWaitTimeExecute(v)
        end
    end
end

return TimeMgr