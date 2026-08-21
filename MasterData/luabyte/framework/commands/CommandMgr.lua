local CommandMgr = BaseClass("CommandMgr", Singleton)
local M = CommandMgr

function M:CheckReqiures()
    if self._required then
        return
    end
    local CommandConst = require "Config.CommandConst"
    self._allCommands = self._allCommands or {}
    for key, command in pairs(CommandConst.Commands) do
        self._allCommands[key] = require(command).New()
    end
    self._required = true
end

function M:Execute(commandName, ...)
    self:CheckReqiures()
    if not self._allCommands[commandName] then
        if JumpConst[commandName] then
            self._allCommands[commandName] = JumpConst[commandName].New()
        end
        if not self._allCommands[commandName] then
            return
        end
    end
    self._allCommands[commandName]:Execute(...)
end

-- 添加顺序执行器
function M:PushExecute(orderId, commandName, ...)
    self._allOrderExecuter = self._allOrderExecuter or {}
    for _, ex in ipairs(self._allOrderExecuter) do
        if ex.commandName == commandName then
            return
        end
    end
    local executer = {orderId=orderId, commandName=commandName, params={...}}
    table.insert(self._allOrderExecuter, executer)
end

-- 运行执行器
function M:ExcuteOrder()
    if self._allOrderExecuter == nil or #self._allOrderExecuter == 0 then
        return
    end
    table.sort(self._allOrderExecuter, Bind(self, self.SortExecute))
    local idx = 1
    if idx <= #self._allOrderExecuter then
        local excuter = self._allOrderExecuter[1]
        table.remove(self._allOrderExecuter, 1)
        local commandName = excuter.commandName
        local pas = excuter.params
        self:Execute(commandName, table.unpack(pas))
    end
end

function M:FinishExcute()
    coroutine.start(function()
        coroutine.waitforseconds(0.1)
        self:ExcuteOrder()
    end)
end

function M:Interrupt()
    self._allOrderExecuter = {}
end

function M:SortExecute(e1, e2)
    return e2.orderId < e1.orderId
end

function M:Clear()
    self._allCommands = nil
    self._required = false
    self._allOrderExecuter = {}
end

return CommandMgr
