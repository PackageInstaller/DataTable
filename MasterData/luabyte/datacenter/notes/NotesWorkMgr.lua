local M = BaseClass("NotesWorkMgr", Singleton)

function M:__init()
    self.m_dataDic = nil
end

function M:Cleanup()
end

function M:Dispose()
    if self.m_dataDic then
        for _, v in pairs(self.m_dataDic) do v:Dispose() end
        self.m_dataDic = nil
    end
end

function M:UpdateNote(eType, data)
    local note = self:GetDataByType(eType)
    if note then
        note:UpdateData(data)
    else
        Logger.LogError("Notes Type is Empty, Type = " .. tostring(eType))
    end
end

function M:GetDataByType(eType)
    self:_InitCustomData()
    return self.m_dataDic[eType]
end

function M:_InitCustomData()
    if not self.m_dataDic then
        self.m_dataDic = {}
        self:_AddCustomData(require("DataCenter.Notes.ItemJumpData").New())
    end
end

function M:_AddCustomData(data)
    self.m_dataDic[data:GetType()] = data
end

return M
