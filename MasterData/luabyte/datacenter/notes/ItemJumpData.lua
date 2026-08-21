local baseClass = require("DataCenter.Notes.BaseNotesData")
local M = BaseClass("ItemJumpData", baseClass)

function M:Init()
    self.m_type = EnumConst.NotesWorkType.ItemJump
end

-- 是否是跳转记录面板
function M:IsShowJumpNote()
    if not self.m_data then return false end
    local itemNum = self.m_data.itemNum
    if not itemNum or not (itemNum > 0) then return false end

    local topCmd = JumpMgr:GetInstance():GetLastCommandKey()
    return topCmd and (topCmd == "OpenStage") or false
end

function M:IsItemNumDone()
    if not self.m_data then return false end
    local itemId = self.m_data.itemId
    local itemNum = self.m_data.itemNum
    local haveNum = ItemDataMgr:GetInstance():GetItemNumById(itemId)
    return haveNum >= itemNum
end

function M:NoteItemName()
    local itemId = self.m_data and self.m_data.itemId or 0
    return ItemHelper.GetItemNameById(itemId)
end

function M:GetItemId()
    if not self.m_data then return 0 end
    return self.m_data.itemId or 0
end

function M:GetTargetNum()
    if not self.m_data then return 0 end
    return self.m_data.itemNum or 0
end

return M
