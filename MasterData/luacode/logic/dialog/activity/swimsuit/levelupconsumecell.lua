local Item = require("logic.manager.experimental.types.item")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local LevelUpConsumeCell = class("LevelUpConsumeCell", Dialog)
LevelUpConsumeCell.AssetBundleName = "ui/layouts.activitysummer"
LevelUpConsumeCell.AssetName = "ActivitySummerLevelUpConfirmCell"

function LevelUpConsumeCell:Ctor(...)
  LevelUpConsumeCell.super.Ctor(self, ...)
end

function LevelUpConsumeCell:OnCreate()
  self._icon = self:GetChild("Icon")
  self._num = self:GetChild("Num")
end

function LevelUpConsumeCell:OnDestroy()
end

function LevelUpConsumeCell:RefreshCell(data)
  local item = Item.Create(data.itemID)
  local imageRecord = item:GetIcon()
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local hadNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(data.itemID)
  if hadNum >= data.itemNum then
    self._num:SetText(TextManager.GetText(CStringRes:GetRecorder(1590).msgTextID, data.itemNum))
  else
    self._num:SetText(TextManager.GetText(CStringRes:GetRecorder(1591).msgTextID, data.itemNum))
    self._delegate._canLevelUp = false
  end
end

return LevelUpConsumeCell
