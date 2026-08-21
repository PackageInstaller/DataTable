local DormitoryDressupAreaItemCtrl = BaseClass("DormitoryDressupAreaItemCtrl")
local M = DormitoryDressupAreaItemCtrl

function M:__init(view)
    self._view = view
    self._view.Item.transform:onClick(Bind(self, self.OnClickItem))
    self.updateRedPointCallback = EventMgr:AddListener(UIMessageNames.DORM_FURNITURE_REDPOINT, Bind(self, self.UpdateRedPoint))
end

function M:SetCallback(callback)
    self.callback = callback
end

function M:OnClickItem(go)
    self:SetSelect(true)
    if self.callback then
        self.callback(self.data)
    end
end

function M:UpdataData(data)
    self.data = data
    self._view.label:SetText(data.text)
    self:UpdateRedPoint()
end

function M:UpdateRedPoint()
    self._view.Redpoint:SetParam(0, self.data.type)
    self._view.Redpoint:Check()
end

function M:SetSelect(v)
    self._view.bg.transform.gameObject:SetActive(v)
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.DORM_FURNITURE_REDPOINT, self.updateRedPointCallback)
    self.data = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return DormitoryDressupAreaItemCtrl
