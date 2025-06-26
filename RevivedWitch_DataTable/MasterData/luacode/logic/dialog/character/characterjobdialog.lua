-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/characterjobdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CWordColor = (BeanManager.GetTableByName)("message.cwordcolor")
local CVocationCfgTable = (BeanManager.GetTableByName)("role.cvocationcfg")
local UIManager = ((CS.PixelNeko).UI).UIManager
local CharacterJobDialog = class("CharacterJobDialog", Dialog)
CharacterJobDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterJobDialog.AssetName = "JobDetail"
CharacterJobDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterJobDialog
  ((CharacterJobDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

CharacterJobDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, _ENV
  self._field = self:GetChild("Back/Frame")
  self._back = self:GetChild("Back")
  self._frame = (GridFrame.Create)(self._field, self, true, 2, false)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

CharacterJobDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

CharacterJobDialog.SetData = function(self, jobId)
  -- function num : 0_3 , upvalues : _ENV, CVocationCfgTable, CWordColor, CStringRes
  self._data = {}
  for _,id in ipairs(CVocationCfgTable:GetAllIds()) do
    local record = CVocationCfgTable:GetRecorder(id)
    if jobId == id then
      local wordcolor = (CWordColor:GetRecorder(34)).wordcolor
      local str = (TextManager.GetText)((CStringRes:GetRecorder(1115)).msgTextID)
      str = (string.gsub)(str, "%$parameter1%$", tostring(wordcolor))
      ;
      (table.insert)(self._data, {imageId = record.imgDescribeBlue, text = (string.gsub)(str, "%$parameter2%$", (TextManager.GetText)(record.nameTextID)), detail = (string.gsub)(str, "%$parameter2%$", (TextManager.GetText)(record.vocationDescribeTextID))})
    else
      do
        do
          ;
          (table.insert)(self._data, {imageId = record.imgDescribe, text = (TextManager.GetText)(record.nameTextID), detail = (TextManager.GetText)(record.vocationDescribeTextID)})
          -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC81: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (self._frame):ReloadAllCell()
end

CharacterJobDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_4
  return #self._data
end

CharacterJobDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "character.characterjobcell"
end

CharacterJobDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

CharacterJobDialog.OnGlobalPointerDown = function(self, args)
  -- function num : 0_7 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._back)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

CharacterJobDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

return CharacterJobDialog

