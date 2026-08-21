local ConfirmByRecordContext = BaseClass("ConfirmByRecordContext", BaseContext)
local M = ConfirmByRecordContext

function M:Init()
    self.recordTable = {} --记录了不显示的key
end

function M:Open(content,action,recordKey)
    if self:checkRecord(recordKey) then
        action(true)
        self:_Close()
        return
    end

    self:_Show(content,action,recordKey)
end

function M:OnClose()
    M.super.OnClose(self)
end

function M:checkRecord(recordKey)
    if table.contains(self.recordTable,recordKey) then
       return true
    else
       return false
    end
end

function M:SaveRecord(recordKey)
    if not table.contains(self.recordTable,recordKey) then
        table.insert(self.recordTable,recordKey)
    end
end

function M:OnDispose()
    self.recordTable = {} --记录了不显示的key
    M.super.OnDispose(self)
    
    
end

return ConfirmByRecordContext