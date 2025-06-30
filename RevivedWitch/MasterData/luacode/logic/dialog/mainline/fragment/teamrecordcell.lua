-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/fragment/teamrecordcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CMessageTip = (BeanManager.GetTableByName)("message.cmessagetip")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Role = require("logic.manager.experimental.types.role")
local TeamRecordCell = class("TeamRecordCell", Dialog)
TeamRecordCell.AssetBundleName = "ui/layouts.fragment"
TeamRecordCell.AssetName = "TeamRecordCell"
TeamRecordCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TeamRecordCell
  ((TeamRecordCell.super).Ctor)(self, ...)
  self._data = {}
end

TeamRecordCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._timeTxt = self:GetChild("Time")
  self._confirmbtn = self:GetChild("ConfirmButton")
  ;
  (self._confirmbtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClick, self)
  self._frameUI = self:GetChild("CellFrame")
  self._frame = (TableFrame.Create)(self._frameUI, self, false, false, true)
end

TeamRecordCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

TeamRecordCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._data = {}
  for k,v in pairs(data.roles) do
    (table.insert)(self._data, {pos = k, id = v})
  end
  ;
  (table.sort)(self._data, function(a, b)
    -- function num : 0_3_0
    do return a.pos < b.pos end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  local str = (((BeanManager.GetTableByName)("message.cstringres")):GetRecorder(1107)).msgTextID
  str = (TextManager.GetText)(str)
  str = (string.gsub)(str, "%$parameter1%$", data.time)
  ;
  (self._timeTxt):SetText(str)
  ;
  (self._frame):ReloadAllCell()
end

TeamRecordCell.OnConfirmBtnClick = function(self)
  -- function num : 0_4 , upvalues : _ENV, CMessageTip, Role
  local dialog = (DialogManager.GetDialog)("mainline.fragment.fragmentmaindialog")
  local alreadyDispatched = {}
  if dialog then
    dialog:ClearnCurrentTile()
    dialog:ClearCharCellClick()
    for i,v in ipairs(self._data) do
      local lockZone = dialog:IsRoleLock(v.id)
      if lockZone and not dialog:IsRoleUnfrozen(v.id) then
        if alreadyDispatched[lockZone] then
          (table.insert)(alreadyDispatched[lockZone], v.id)
        else
          alreadyDispatched[lockZone] = {v.id}
        end
      else
        dialog:OnCharCellClick(v.id)
      end
    end
  end
  do
    if (table.nums)(alreadyDispatched) > 0 then
      local str = ""
      for zoneID,roleIds in pairs(alreadyDispatched) do
        local tempStr = (TextManager.GetText)((CMessageTip:GetRecorder(100229)).msgTextID)
        local charNames = ""
        for i,v in ipairs(roleIds) do
          charNames = charNames .. ((Role.Create)(v)):GetRoleName() .. ","
        end
        charNames = (string.sub)(charNames, 1, #charNames - 1)
        str = str .. (TextManager.GetText)((CMessageTip:GetRecorder(100229)).msgTextID)
        str = (string.gsub)(str, "%$parameter1%$", charNames)
        str = (string.gsub)(str, "%$parameter2%$", tostring(zoneID))
        str = str .. "\n"
      end
      local dialog = (DialogManager.CreateSingletonDialog)("mainline.fragment.alreadydispatchedtip")
      dialog:SetText(str)
    end
    do
      ;
      (self._delegate):Destroy()
    end
  end
end

TeamRecordCell.NumberOfCell = function(self, frame, index)
  -- function num : 0_5
  return #self._data
end

TeamRecordCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  return "mainline.fragment.teamrecordcharcell"
end

TeamRecordCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return ((self._data)[index]).id
end

return TeamRecordCell

