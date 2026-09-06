local CExploreLvUpCfg = BeanManager.GetTableByName("courtyard.cexplorelvup")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local DetailLockCell = class("DetailLockCell", Dialog)
DetailLockCell.AssetBundleName = "ui/layouts.yard"
DetailLockCell.AssetName = "YardExploreTaskCell3"

function DetailLockCell:Ctor(...)
  DetailLockCell.super.Ctor(self, ...)
end

function DetailLockCell:OnCreate()
  self._index = self:GetChild("TopBack/LevelBack/Text")
  self._unlockCondition = self:GetChild("Txt")
end

function DetailLockCell:OnDestroy()
end

function DetailLockCell:RefreshCell(data)
  local index = self._delegate:GetSlotIndexBySlotId(data.slotId)
  self._index:SetText(index)
  local unlockLevel
  local allIds = CExploreLvUpCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CExploreLvUpCfg:GetRecorder(allIds[i])
    if index <= recorder.teamNum then
      unlockLevel = recorder.id
      break
    end
  end
  local str = TextManager.GetText(CStringres:GetRecorder(1124).msgTextID)
  self._unlockCondition:SetText(string.gsub(str, "%$parameter1%$", unlockLevel))
end

return DetailLockCell
