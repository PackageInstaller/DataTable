-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/recommendchar/recommendcharcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBattleTypeCfg = (BeanManager.GetTableByName)("role.cbattletypecfg")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local RecommendCharCell = class("RecommendCharCell", Dialog)
RecommendCharCell.AssetBundleName = "ui/layouts.mainline"
RecommendCharCell.AssetName = "RecommendCharCell"
RecommendCharCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RecommendCharCell
  ((RecommendCharCell.super).Ctor)(self, ...)
  self._rolesId = {}
  self._index = 0
end

RecommendCharCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame
  self._title = self:GetChild("Title")
  self._rolePanel = self:GetChild("Frame")
  self._roleFrame = (GridFrame.Create)(self._rolePanel, self, true, 3, false)
  self._x = (self._rolePanel):GetSize()
  self._rootX = (self:GetRootWindow()):GetSize()
end

RecommendCharCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._roleFrame):Destroy()
end

RecommendCharCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CBattleTypeCfg, _ENV
  self._index = data.index
  local recorder = CBattleTypeCfg:GetRecorder(data.typeid)
  if recorder then
    (self._title):SetText((TextManager.GetText)(recorder.typenameTextID))
  else
    ;
    (self._title):SetText("")
  end
  self._rolesId = data.roleids
  ;
  (self._roleFrame):ReloadAllCell()
  local totallength = (self._roleFrame):GetTotalLength()
  ;
  (self._rolePanel):SetSize(self._x, self._ox, 0, totallength)
  ;
  (self:GetRootWindow()):SetSize(self._rootX, self._rootOX, 0, self._rootOY + (totallength - self._oy))
  ;
  (self._roleFrame):ReloadAllCell()
end

RecommendCharCell.OnCellClicked = function(self, data)
  -- function num : 0_4
  (self._delegate):OnCellClicked(self._index, data)
end

RecommendCharCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "mainline.recommendchar.recommendcharcharactercell"
end

RecommendCharCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._rolesId)[index]
end

RecommendCharCell.NumberOfCell = function(self, frame)
  -- function num : 0_7
  return #self._rolesId
end

RecommendCharCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_8
  if self._cellData and eventName == "SetSelectedRole" then
    (self._roleFrame):FireEvent("SetSelectedRole", arg)
  end
end

return RecommendCharCell

