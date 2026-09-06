local CardPool = BeanManager.GetTableByName("item.ccardpool")
local TableFrame = require("framework.ui.frame.table.tableframe")
local GachaRateDialog = class("GachaRateDialog", Dialog)
GachaRateDialog.AssetBundleName = "ui/layouts.gacha"
GachaRateDialog.AssetName = "GachaRate"
local Type = {
  Up = 1,
  All = 2,
  Baodi = 3
}
local Rarity = {
  UR = 4,
  SSR = 3,
  SR = 2,
  R = 1
}

function GachaRateDialog:Ctor(...)
  GachaRateDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function GachaRateDialog:OnCreate()
  self._closeBtn = self:GetChild("Announcement/CloseBtn")
  self._field = self:GetChild("Announcement/Frame")
  self._frame = TableFrame.Create(self._field, self, true, true, true)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._poolTable = {}
  for _, id in ipairs(CardPool:GetAllIds()) do
    self._poolTable[id] = CardPool:GetRecorder(id)
  end
end

function GachaRateDialog:OnDestroy()
  self._frame:Destroy()
end

function GachaRateDialog:Init(data)
  local detail = data.value.drawCardDetails
  local temp = {}
  self._data = {}
  self._rateUpData = {}
  for id, v in pairs(detail.upRoles) do
    temp = {}
    temp.roleId = id
    temp.rate = v
    table.insert(self._rateUpData, temp)
  end
  if #self._rateUpData > 0 then
    table.insert(self._data, {
      data = self._rateUpData,
      type = Type.Up
    })
  end
  self._rateAllData = {}
  if 0 < #detail.ur.ids then
    temp = {
      rank = Rarity.UR,
      rate = detail.ur.rate,
      idList = detail.ur.ids
    }
    table.insert(self._rateAllData, temp)
  end
  if 0 < #detail.ssr.ids then
    temp = {
      rank = Rarity.SSR,
      rate = detail.ssr.rate,
      idList = detail.ssr.ids
    }
    table.insert(self._rateAllData, temp)
  end
  if 0 < #detail.sr.ids then
    temp = {
      rank = Rarity.SR,
      rate = detail.sr.rate,
      idList = detail.sr.ids
    }
    table.insert(self._rateAllData, temp)
  end
  if 0 < #detail.r.ids then
    temp = {
      rank = Rarity.R,
      rate = detail.r.rate,
      idList = detail.r.ids
    }
    table.insert(self._rateAllData, temp)
  end
  if 0 < #self._rateAllData then
    table.insert(self._data, {
      data = self._rateAllData,
      type = Type.All
    })
  end
  local baodiTitle = self._poolTable[data.id].describetitleTextID
  local baodiDes = self._poolTable[data.id].detaileddescribeTextID
  for i, v in ipairs(baodiTitle) do
    temp = {}
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

function GachaRateDialog:NumberOfCell(frame)
  return #self._data
end

function GachaRateDialog:CellAtIndex(frame, index)
  if self._data[index].type == Type.Up then
    return "gacha.gacharateupcell"
  elseif self._data[index].type == Type.All then
    return "gacha.gacharateallcell"
  elseif self._data[index].type == Type.Baodi then
    return "gacha.gacharatebaodicell"
  end
end

function GachaRateDialog:DataAtIndex(frame, index)
  return self._data[index].data
end

function GachaRateDialog:ShouldLengthChange()
  return true
end

function GachaRateDialog:OnBackBtnClicked()
  self:Destroy()
end

return GachaRateDialog
