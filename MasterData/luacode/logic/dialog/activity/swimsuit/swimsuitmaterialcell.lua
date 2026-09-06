local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local SwimSuitMaterialCell = class("SwimSuitMaterialCell", Dialog)
SwimSuitMaterialCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitMaterialCell.AssetName = "ActivitySummerMainMaterialCell"

function SwimSuitMaterialCell:Ctor(...)
  SwimSuitMaterialCell.super.Ctor(self, ...)
end

function SwimSuitMaterialCell:OnCreate()
  self._image = self:GetChild("Image")
  self._text = self:GetChild("Text")
end

function SwimSuitMaterialCell:OnDestroy()
end

function SwimSuitMaterialCell:RefreshCell(data)
  local totle = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(data.id)
  local item = Item.Create(data.id)
  self._image:SetSprite(item:GetIconAB())
  local str
  if totle < data.count then
    str = CStringRes:GetRecorder(1617)
  else
    str = CStringRes:GetRecorder(1616)
  end
  str = TextManager.GetText(str.msgTextID)
  str = string.gsub(str, "%$parameter1%$", item:GetName())
  str = string.gsub(str, "%$parameter2%$", data.count)
  self._text:SetText(str)
end

return SwimSuitMaterialCell
