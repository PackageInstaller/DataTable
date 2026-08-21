--新赛季提示
local EncounterSeasonOpenCtrl = BaseClass("EncounterSeasonOpenCtrl" , BaseUICtrl)
local M = EncounterSeasonOpenCtrl

function M:Init()
    self._view.trans_bg:onClick(Bind(self,self._OnClickBg))
end

function M:_OnClickBg(go)
    if self._closeCallback then 
        self._closeCallback()
    end
    self:Close()
end

function M:OnClose()
    self._closeCallback = nil 
end

function M:OnEnter(diffculty,cycleId,closeCallback)
    local engagementCfg = ConfigHelper.GetCfg("engagement",cycleId)
    self._view.title:SetInfo(diffculty,cycleId)
    self._view.txt_newSeasonTitle:SetText(engagementCfg.seasonName)
    self._view.txt_entryName:SetText(engagementCfg.seasonEntryName)
    self._view.img_entryIcon:SetPic(engagementCfg.seasonicon)
    self._view.txt_entryDesc:SetText(engagementCfg.seasonEntryDes)
    self._closeCallback = closeCallback
end

return EncounterSeasonOpenCtrl