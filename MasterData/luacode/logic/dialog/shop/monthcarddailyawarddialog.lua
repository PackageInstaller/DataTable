local cImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local MonthCardDailyAwardDialog = class("MonthCardDailyAwardDialog", Dialog)
MonthCardDailyAwardDialog.AssetBundleName = "ui/layouts.baseshop"
MonthCardDailyAwardDialog.AssetName = "MonthCardItemAccount"

function MonthCardDailyAwardDialog:Ctor(...)
  MonthCardDailyAwardDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function MonthCardDailyAwardDialog:OnCreate()
  self._cellArea = self:GetChild("CellPanel/CellPanel")
  self._cellFrame = GridFrame.Create(self._cellArea, self, true, 5)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function MonthCardDailyAwardDialog:OnDestroy()
  self._cellFrame:Destroy()
end

function MonthCardDailyAwardDialog:SetData(data)
  self._itemList = {}
  for k, v in pairs(data) do
    table.insert(self._itemList, {itemid = k, itemnum = v})
  end
  self._cellFrame:ReloadAllCell()
end

function MonthCardDailyAwardDialog:NumberOfCell(frame)
  return #self._itemList
end

function MonthCardDailyAwardDialog:CellAtIndex(frame, index)
  return "shop.monthcarddailyawardcell"
end

function MonthCardDailyAwardDialog:DataAtIndex(frame, index)
  return self._itemList[index]
end

function MonthCardDailyAwardDialog:OnBackBtnClicked()
  if self:GetRootWindow():IsActive() then
    self:Destroy()
  end
end

return MonthCardDailyAwardDialog
