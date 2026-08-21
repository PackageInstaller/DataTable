local DormClickStoryCtrl = BaseClass("DormClickStoryCtrl", BaseUICtrl)
local M = DormClickStoryCtrl

function M:Init()
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
end

function M:OnEnter(languageID)
    self._view.txt_name:SetAvatarName(self.module.heroId, RoleType.ERT_Hero)
    local dialog = ConfigHelper.GetLocalStringByPlayerName(languageID)
    self._view.txt_dialog:SetDoTweenText(dialog, function ()
        coroutine.start(Bind(self, self.ClosePanel))
    end)
end

function M:ClosePanel()
    coroutine.waitforseconds(1)
    self:Close()
end

function M:OnDispose()
    self.module = nil
    M.super.OnDispose(self)
end

return DormClickStoryCtrl
