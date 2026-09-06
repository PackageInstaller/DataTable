local TableFrame = require("framework.ui.frame.table.tableframe")
local CRoleItemTable = BeanManager.GetTableByName("item.croleitem")
local Role = require("logic.manager.experimental.types.role")
local RoleConfigTable = BeanManager.GetTableByName("role.roleconfig")
local GachaRateUpCell = class("GachaRateUpCell", Dialog)
GachaRateUpCell.AssetBundleName = "ui/layouts.gacha"
GachaRateUpCell.AssetName = "GachaRateUpTitle"

function GachaRateUpCell:Ctor(...)
  GachaRateUpCell.super.Ctor(self, ...)
end

function GachaRateUpCell:OnCreate()
  self._field = self:GetChild("CellFrame")
  self._frame = TableFrame.Create(self._field, self, true, false, true)
  local _
  _, self._fHeight = self._field:GetRectSize()
  self._field_x, self._field_ox, self._field_y, self._field_oy = self._field:GetPosition()
  _, self._height = self:GetRootWindow():GetRectSize()
  self._x, self._ox = self:GetRootWindow():GetSize()
end

function GachaRateUpCell:OnDestroy()
  self._frame:Destroy()
end

function GachaRateUpCell:RefreshCell(data)
  self._data = {}
  for _, v in ipairs(data) do
    local roleId = CRoleItemTable:GetRecorder(v.roleId).roleid
    local rarityNum = RoleConfigTable:GetRecorder(roleId).rarity
    local temp = {}
    local flag = true
    for _, a in ipairs(self._data) do
      if a.rarity == rarityNum then
        temp = a
        flag = false
        break
      end
    end
    temp.rarity = rarityNum
    if temp.rate then
      if temp.rate ~= v.rate then
        LogErrorFormat("GachaRateUpCell", "role item id %s's rate is different with rarity %s roles' rate", v.roleId, rarityNum)
      end
    else
      temp.rate = v.rate
    end
    temp.roleIdList = temp.roleIdList or {}
    table.insert(temp.roleIdList, roleId)
    if flag then
      table.insert(self._data, temp)
    end
  end
  table.sort(self._data, function(a, b)
    return a.rarity > b.rarity
  end)
  self._frame:ReloadAllCell()
  local totalLength = self._frame:GetTotalLength()
  local delta = totalLength - self._fHeight
  self._field:SetHeight(0, totalLength)
  self._field:SetPosition(self._field_x, self._field_ox, self._field_y, self._field_oy - delta)
  self:GetRootWindow():SetSize(self._x, self._ox, 0, self._height + delta)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
end

function GachaRateUpCell:NumberOfCell(frame)
  return #self._data
end

function GachaRateUpCell:CellAtIndex(frame, index)
  return "gacha.gacharateupcellcell"
end

function GachaRateUpCell:DataAtIndex(frame, index)
  return self._data[index]
end

function GachaRateUpCell:ShouldLengthChange()
  return true
end

return GachaRateUpCell
