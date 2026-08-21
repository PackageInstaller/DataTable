local PowerItemCtrl = BaseClass("PowerItemCtrl")
local M = PowerItemCtrl 

function M:__init(view)
    self._view = view
    self._view.transform:onClick(Bind(self, self._ClickItem))
end

--选择词条
function M:_ClickItem(go)
    EventMgr:Broadcast(UIMessageNames.FAVOR_SELECT_ROOM_STORY, self.nextStepId, self.skip, self.index)
end

function M:UpdateItem(word, nextStepId, index, type, skip)
    self.nextStepId = nextStepId
    self.index = index
    self.type = type
    self.skip = skip
    self._view.DesText:SetText(word)
    self._view.PowerText.transform:SetActive(false)
end

function M:Enable(v)
    self._view:SetActive(v)
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return PowerItemCtrl
