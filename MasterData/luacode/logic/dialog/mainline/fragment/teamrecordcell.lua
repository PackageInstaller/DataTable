local CMessageTip = BeanManager.GetTableByName("message.cmessagetip")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local TeamRecordCell = class("TeamRecordCell", Dialog)
TeamRecordCell.AssetBundleName = "ui/layouts.fragment"
TeamRecordCell.AssetName = "TeamRecordCell"

function TeamRecordCell:Ctor(...)
  TeamRecordCell.super.Ctor(self, ...)
  self._data = {}
end

function TeamRecordCell:OnCreate()
  self._timeTxt = self:GetChild("Time")
  self._confirmbtn = self:GetChild("ConfirmButton")
  self._confirmbtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self._frameUI = self:GetChild("CellFrame")
  self._frame = TableFrame.Create(self._frameUI, self, false, false, true)
end

function TeamRecordCell:OnDestroy()
  self._frame:Destroy()
end

function TeamRecordCell:RefreshCell(data)
  self._data = {}
  for k, v in pairs(data.roles) do
    table.insert(self._data, {pos = k, id = v})
  end
  table.sort(self._data, function(a, b)
    return a.pos < b.pos
  end)
  local str = BeanManager.GetTableByName("message.cstringres"):GetRecorder(1107).msgTextID
  str = TextManager.GetText(str)
  str = string.gsub(str, "%$parameter1%$", data.time)
  self._timeTxt:SetText(str)
  self._frame:ReloadAllCell()
end

function TeamRecordCell:OnConfirmBtnClick()
  local dialog = DialogManager.GetDialog("mainline.fragment.fragmentmaindialog")
  local alreadyDispatched = {}
  if dialog then
    dialog:ClearnCurrentTile()
    dialog:ClearCharCellClick()
    for i, v in ipairs(self._data) do
      local lockZone = dialog:IsRoleLock(v.id)
      if lockZone and not dialog:IsRoleUnfrozen(v.id) then
        if alreadyDispatched[lockZone] then
          table.insert(alreadyDispatched[lockZone], v.id)
        else
          alreadyDispatched[lockZone] = {
            v.id
          }
        end
      else
        dialog:OnCharCellClick(v.id)
      end
    end
  end
  if table.nums(alreadyDispatched) > 0 then
    local str = ""
    for zoneID, roleIds in pairs(alreadyDispatched) do
      local tempStr = TextManager.GetText(CMessageTip:GetRecorder(100229).msgTextID)
      local charNames = ""
      for i, v in ipairs(roleIds) do
        charNames = charNames .. Role.Create(v):GetRoleName() .. ","
      end
      charNames = string.sub(charNames, 1, #charNames - 1)
      str = str .. TextManager.GetText(CMessageTip:GetRecorder(100229).msgTextID)
      str = string.gsub(str, "%$parameter1%$", charNames)
      str = string.gsub(str, "%$parameter2%$", tostring(zoneID))
      str = str .. "\n"
    end
    local dialog = DialogManager.CreateSingletonDialog("mainline.fragment.alreadydispatchedtip")
    dialog:SetText(str)
  end
  self._delegate:Destroy()
end

function TeamRecordCell:NumberOfCell(frame, index)
  return #self._data
end

function TeamRecordCell:CellAtIndex(frame, index)
  return "mainline.fragment.teamrecordcharcell"
end

function TeamRecordCell:DataAtIndex(frame, index)
  return self._data[index].id
end

return TeamRecordCell
