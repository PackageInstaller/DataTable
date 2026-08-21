local OfficalBriefItemCtrl = BaseClass("OfficalBriefItemCtrl")
local M = OfficalBriefItemCtrl

function M:__init(view)
    self._view = view
    self._isOpen = false
    self._view.txtContent:SetText("")

    self._view.rectOfficalBriefItem:onClick(Bind(self, self.OnEnterClick))
end

--data:heroStory
function M:UpdateItem(data)
    if data == nil then
        return
    end

    self._data = data

    self:_SetTitle(data)
    -- self:_UpdateLayout()
end

function M:OnShowOfficalBrief()
    self._view.rectOfficalBriefItem:SetActive(true)
end

function M:OnEnterClick()
    if self._isOpen then
        self._view.txtContent:SetText("")
    else
        if not table.isNullOrEmpty(self._data.words) then
            self._view.txtContent:SetText(self._data.words[2])
        end
    end
    self._isOpen = not self._isOpen
end

function M:_SetTitle(data)
    if not table.isNullOrEmpty(self._data.words) then
        self._view.txtTitle:SetText(data.words[1])
    end
end

-- function M:_UpdateLayout()
--     self._view.fitterContent:SetLayoutVertical()
--     local height = self._view.txtContent.rectTransform.sizeDelta.y
--     self._view.rectOfficalBriefItem:SetSizeWithCurrentAnchors(1, height + 148)
-- end

function M:Dispose()
    self._view.rectOfficalBriefItem:onClick(nil)
    self._data = nil
    self._isOpen = nil
    self:OnDispose()
end

function M:OnDispose()
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return OfficalBriefItemCtrl