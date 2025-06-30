-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gacharateupcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CRoleItemTable = (BeanManager.GetTableByName)("item.croleitem")
local Role = require("logic.manager.experimental.types.role")
local RoleConfigTable = (BeanManager.GetTableByName)("role.roleconfig")
local GachaRateUpCell = class("GachaRateUpCell", Dialog)
GachaRateUpCell.AssetBundleName = "ui/layouts.gacha"
GachaRateUpCell.AssetName = "GachaRateUpTitle"
GachaRateUpCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaRateUpCell
  ((GachaRateUpCell.super).Ctor)(self, ...)
end

GachaRateUpCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._field = self:GetChild("CellFrame")
  self._frame = (TableFrame.Create)(self._field, self, true, false, true)
  local _ = nil
  _ = (self._field):GetRectSize()
  self._field_x = (self._field):GetPosition()
  _ = (self:GetRootWindow()):GetRectSize()
  self._x = (self:GetRootWindow()):GetSize()
end

GachaRateUpCell.OnDestroy = function(self)
  -- function num : 0_2
  (self._frame):Destroy()
end

GachaRateUpCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CRoleItemTable, RoleConfigTable
  self._data = {}
  for _,v in ipairs(data) do
    local roleId = (CRoleItemTable:GetRecorder(v.roleId)).roleid
    local rarityNum = (RoleConfigTable:GetRecorder(roleId)).rarity
    local temp = {}
    local flag = true
    for _,a in ipairs(self._data) do
      if a.rarity == rarityNum then
        temp = a
        flag = false
        break
      end
    end
    do
      temp.rarity = rarityNum
      -- DECOMPILER ERROR at PC43: Unhandled construct in 'MakeBoolean' P1

      if temp.rate and temp.rate ~= v.rate then
        LogErrorFormat("GachaRateUpCell", "role item id %s\'s rate is different with rarity %s roles\' rate", v.roleId, rarityNum)
      end
      temp.rate = v.rate
      if not temp.roleIdList then
        do
          temp.roleIdList = {}
          ;
          (table.insert)(temp.roleIdList, roleId)
          if flag then
            (table.insert)(self._data, temp)
          end
          -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out IF_THEN_STMT

          -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out IF_STMT

          -- DECOMPILER ERROR at PC64: LeaveBlock: unexpected jumping out DO_STMT

        end
      end
    end
  end
  ;
  (table.sort)(self._data, function(a, b)
    -- function num : 0_3_0
    do return b.rarity < a.rarity end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  ;
  (self._frame):ReloadAllCell()
  local totalLength = (self._frame):GetTotalLength()
  local delta = totalLength - self._fHeight
  ;
  (self._field):SetHeight(0, totalLength)
  ;
  (self._field):SetPosition(self._field_x, self._field_ox, self._field_y, self._field_oy - delta)
  ;
  (self:GetRootWindow()):SetSize(self._x, self._ox, 0, self._height + delta)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
end

GachaRateUpCell.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

GachaRateUpCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "gacha.gacharateupcellcell"
end

GachaRateUpCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

GachaRateUpCell.ShouldLengthChange = function(self)
  -- function num : 0_7
  return true
end

return GachaRateUpCell

