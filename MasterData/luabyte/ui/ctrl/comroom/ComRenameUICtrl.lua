local ComRenameUICtrl = BaseClass("ComRenameUICtrl", require("UI.Ctrl.Common.RenameUICtrl"))
local M = ComRenameUICtrl

function M:Init()
    self:SetTitle(447)
    self:SetContentDefault(347)
    self:SetCharacterLimit(191)
    self:SetContentType(0)
end

function M:OnEnter(chatName)
    self._chatName = chatName
end

function M:OnConfirmInput(inputStr)
    if GameHelper.CheckBlockWord(inputStr) then
        GameHelper.TipsById(666)
        return
    end
    self:_SaveTabName(inputStr)
    EventMgr:Broadcast(UIMessageNames.COM_TAB_NAME_CHANGE)
end

function M:_SaveTabName(inputStr)
    PlayerPrefabHelper.SetString(ComConst.ComRename .. self._chatName, inputStr)
end

function M:OnClose()
    self._chatName = nil
end

return ComRenameUICtrl