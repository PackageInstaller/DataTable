local M = BaseClass("DormPersonalTipsCtrl")

local eventId = UIMessageNames.DORM_PERSONALCOPY_ENDBATTLE

function M:__init(view)
    self._view = view
    self.m_personalData = nil
    self._view.btn_mask:onClick(Bind(self, self.OnClickEnter))
    --self.m_endBattle = EventMgr:AddListener(eventId, Bind(self, self.OnEndBattle))
end

function M:SetData(data, action)
    self.m_callback = action
    self.m_personalData = data
    if self.m_personalData then
        self:Enable(true)
    else
        self:Enable(false)
    end
end

function M:OnDispose()
    --EventMgr:RemoveListener(eventId, self.m_endBattle)
    self.m_personalData = nil
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

function M:OnClickEnter(go)
    DormDataMgr:EnterPersonalCopy(self.m_personalData, function(data)
        UIContextMgr:GetInstance():Show("Dorm", data)
    end)
    if self.m_callback then self.m_callback() end
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnEndBattle(heroId)
    local data = DormDataMgr:GetActivePersonalCopy(heroId)
    self:SetData(data)
end

return M
