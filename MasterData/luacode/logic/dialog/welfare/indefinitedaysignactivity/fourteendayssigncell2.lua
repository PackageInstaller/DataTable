local IndefiniteDaysSignCellHelper = require("logic.dialog.welfare.indefinitedaysignactivity.indefinitedayssigncellhelper")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local FourteenDaysSignCell2 = class("FourteenDaysSignCell2", Dialog)
FourteenDaysSignCell2.AssetBundleName = "ui/layouts.welfare"
FourteenDaysSignCell2.AssetName = "WelfareMain14DaySkinCell"

function FourteenDaysSignCell2:Ctor(...)
  FourteenDaysSignCell2.super.Ctor(self, ...)
end

function FourteenDaysSignCell2:OnCreate()
  self._rootElement = self:GetRootWindow()
  self._indefiniteDaysSignCellHelper = IndefiniteDaysSignCellHelper.Create(self._rootElement)
  self._imageput = self:GetChild("Imageput")
end

function FourteenDaysSignCell2:OnDestroy()
  if self._indefiniteDaysSignCellHelper then
    self._indefiniteDaysSignCellHelper:OnDestroy()
  end
end

function FourteenDaysSignCell2:RefreshCell(data)
  self._data = data
  if self._indefiniteDaysSignCellHelper then
    self._indefiniteDaysSignCellHelper:RefreshCell(self._delegate, data)
  end
  local iconKind = tonumber(self._data.extraCfg[2])
  local imageRecord = CImagePathTable:GetRecorder(iconKind)
  self._indefiniteDaysSignCellHelper._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._indefiniteDaysSignCellHelper._icongrey:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function FourteenDaysSignCell2:OnEvent(eventName, arg)
  if self._indefiniteDaysSignCellHelper then
    self._indefiniteDaysSignCellHelper:OnEvent(eventName, arg)
  end
end

return FourteenDaysSignCell2
