local M = BaseClass("BattleResultCtrl")

function M:__init(view)
    self._view = view
    self._view.btn:onClick(Bind(self, self._OnClick))
end

function M:Update(id)
    local cfg = ConfigHelper.GetCfg("loseGuide", id) or {}
    self.m_jump = cfg.jump
    self._view.text:SetText(cfg.desc)
end

function M:SetActive(b)
    self._view.btn:SetActive(b)
end

function M:_OnClick()
    JumpMgr:GetInstance():Execute(self.m_jump)
end

function M:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return M
