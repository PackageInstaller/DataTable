--周期结算界面
local EncounterCycleSettlementCtrl = BaseClass("EncounterCycleSettlementCtrl",BaseUICtrl)
local M = EncounterCycleSettlementCtrl

local diffcultyNameLables = {"简单","普通","困难"}

function M:Init()
    self._allItems = {}
    self._allPools = {}
    self._view.clickBg:onClick(Bind(self,self._OnClickClose))
    self._closeCallback = nil
end

function M:_OnClickClose(go)
    if self._closeCallback then 
        self._closeCallback()
    end
    self:Close()
    
end

-- 选区的战况、赛季、周期、难度
function M:OnEnter( fromCycleId,fromDiffculty,toCycleId ,toDiffculty,closeCallback)
    self._view.fromEncounterTitle:SetInfo(fromDiffculty,fromCycleId)
    self._view.toEncounterTitle:SetInfo(toDiffculty,toCycleId)
    self._view.state_bg:SetState(fromDiffculty+1)
    local engagementCfg = ConfigHelper.GetCfg("engagement",toCycleId)
    --self._view.txt_name:SetText(engagementCfg.seasonName)
    self._closeCallback = closeCallback
end


function M:OnDispose()
   M.super.OnDispose(self)
    self._closeCallback = nil 
end

return EncounterCycleSettlementCtrl