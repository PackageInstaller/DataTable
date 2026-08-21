local EncounterEntryTipsCtrl = BaseClass("EncounterEntryTipsCtrl", BaseUICtrl)
local M = EncounterEntryTipsCtrl




function M:Show(title, decs)
    self._view.title:SetText(title)
    self._view.text:SetText(decs)
    self._view:SetActive(true);
end


function M:Hide()
    self._view:SetActive(false);
end


function M:__init(view)
    self._view = view 
    self._view.mask:onClick(Bind(self, self.Hide))
end


return EncounterEntryTipsCtrl



