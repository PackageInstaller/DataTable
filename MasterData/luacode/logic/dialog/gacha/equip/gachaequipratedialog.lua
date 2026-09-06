local TableFrame = require("framework.ui.frame.table.tableframe")
local CEquipCardPool = BeanManager.GetTableByName("item.cequipcardpool")
local CardPool = BeanManager.GetTableByName("item.ccardpool")
local Type = {Normal = 1, Baodi = 2}
local GachaEquipRateDialog = class("GachaEquipRateDialog", Dialog)
GachaEquipRateDialog.AssetBundleName = "ui/layouts.baseshop"
GachaEquipRateDialog.AssetName = "TowerLegendDetail"

function GachaEquipRateDialog:Ctor(...)
  GachaEquipRateDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._poolTable = {}
  for _, id in ipairs(CardPool:GetAllIds()) do
    self._poolTable[id] = CardPool:GetRecorder(id)
  end
  self._data = {}
end

function GachaEquipRateDialog:OnCreate()
  self._panel = self:GetChild("Announcement/Frame")
  self._backBtn = self:GetChild("Announcement/CloseBtn")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

function GachaEquipRateDialog:OnDestroy()
  self._frame:Destroy()
end

function GachaEquipRateDialog:SetData(cardPoolId)
  while self._data[#self._data] do
    table.remove(self._data, #self._data)
  end
  local recorder = CEquipCardPool:GetRecorder(cardPoolId)
  if not recorder then
    LogErrorFormat("GachaEquipRateDialog", "carPool with id %s is not exist in cequipcardpool", cardPoolId)
    return
  end
  for i, v in ipairs(recorder.EquipShow) do
    table.insert(self._data, {
      data = v,
      type = Type.Normal
    })
  end
  local baodiTitle = self._poolTable[cardPoolId].describetitleTextID
  local baodiDes = self._poolTable[cardPoolId].detaileddescribeTextID
  for i, v in ipairs(baodiTitle) do
    local temp = {}
    temp.title = v
    temp.describe = TextManager.GetText(baodiDes[i])
    table.insert(self._data, {
      data = temp,
      type = Type.Baodi
    })
  end
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function GachaEquipRateDialog:OnBackBtnClicked(args)
  self:Destroy()
end

function GachaEquipRateDialog:NumberOfCell(frame)
  return #self._data
end

function GachaEquipRateDialog:CellAtIndex(frame, index)
  if self._data[index].type == Type.Normal then
    return "gacha.equip.gachaequipratecell"
  else
    return "gacha.gacharatebaodicell"
  end
end

function GachaEquipRateDialog:DataAtIndex(frame, index)
  return self._data[index].data
end

function GachaEquipRateDialog:ShouldLengthChange()
  return true
end

return GachaEquipRateDialog
