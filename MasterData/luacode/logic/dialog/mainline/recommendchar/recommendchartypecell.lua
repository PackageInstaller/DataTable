local CBattleTypeCfg = BeanManager.GetTableByName("role.cbattletypecfg")
local RecommendCharTypeCell = class("RecommendCharTypeCell", Dialog)
RecommendCharTypeCell.AssetBundleName = "ui/layouts.mainline"
RecommendCharTypeCell.AssetName = "RecommendCharTypeCell"

function RecommendCharTypeCell:Ctor(...)
  RecommendCharTypeCell.super.Ctor(self, ...)
end

function RecommendCharTypeCell:OnCreate()
  self._txt = self:GetChild("Back/Txt1")
end

function RecommendCharTypeCell:OnDestroy()
end

function RecommendCharTypeCell:RefreshCell(data)
  local recorder = CBattleTypeCfg:GetRecorder(data)
  if recorder then
    self._txt:SetText(TextManager.GetText(recorder.typenameTextID))
  else
    self._txt:SetText("")
  end
end

return RecommendCharTypeCell
