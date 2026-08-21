local M = BaseClass("EncounterSeasonItemCtrl")

function M:__init(view)
    self._view = view
    self.m_zoneData = nil
end

function M:SetData(data)
    self.m_zoneData = data
    self._view:SetActive(true)
    self._view.img_icon:SetPic(self.m_zoneData:IconPath())
    self._view.txt_zoneCnName:SetText(self.m_zoneData:ZoneNameId())
    self:_InitEntrys()
end

function M:Dispose()
    self.m_zoneData = nil
    if self._view then
        self._view:OnDispose()
    end
    self._view = nil
end

function M:_InitEntrys()
    local nameIds, _ = self.m_zoneData:ZoneHardEntryNames()
    for i = 1, 3, 1 do
        local nameId = nameIds[i]
        if nameId then
            self._view["node_entry" .. i]:SetActive(true)
            self._view["txt_entryCnName" .. i]:SetText(nameId)
        else
            self._view["node_entry" .. i]:SetActive(false)
        end
    end
end

return M
