-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/offlinepvp/offlinepvpenemylineupdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CNPCShape = (BeanManager.GetTableByName)("npc.cnpcshape")
local OffLinePvpEnemyLineupDialog = class("OffLinePvpEnemyLineupDialog", Dialog)
OffLinePvpEnemyLineupDialog.AssetBundleName = "ui/layouts.offlinepvp"
OffLinePvpEnemyLineupDialog.AssetName = "OffLinePVPEnemy"
local TableFrame = require("framework.ui.frame.table.tableframe")
OffLinePvpEnemyLineupDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : OffLinePvpEnemyLineupDialog
  ((OffLinePvpEnemyLineupDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._roleList = {}
end

OffLinePvpEnemyLineupDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._name = self:GetChild("TeamBack/TeamName/Name")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._frame = self:GetChild("TeamBack/CharacterPanel/CellFrame")
  self._helper = (TableFrame.Create)(self._frame, self, false, false, false)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
end

OffLinePvpEnemyLineupDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._helper):Destroy()
end

OffLinePvpEnemyLineupDialog.InitDataInfo = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._data = data
  ;
  (self._name):SetText((data.enemyUserData).userName)
  self._roleList = {}
  for index = 1, 3 do
    local v = (data.enemyRoleList)[index]
    if v then
      local info = {}
      info.index = index
      info.roleId = ((data.enemyRoleList)[index]).id
      info.level = ((data.enemyRoleList)[index]).lv
      info.breakLv = ((data.enemyRoleList)[index]).breakLv
      info.userId = (data.enemyUserData).userId
      info.userName = (data.enemyUserData).userName
      info.skin = ((data.enemyRoleList)[index]).skin
      ;
      (table.insert)(self._roleList, info)
    else
      do
        do
          local info = {}
          info.nodata = true
          ;
          (table.insert)(self._roleList, info)
          -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC53: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (self._helper):ReloadAllCell()
end

OffLinePvpEnemyLineupDialog.GetRoleList = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local temp = {}
  for i,v in pairs((self._data).enemyRoleList) do
    (table.insert)(temp, v)
  end
  return temp
end

OffLinePvpEnemyLineupDialog.NumberOfCell = function(self, helper)
  -- function num : 0_5
  return 3
end

OffLinePvpEnemyLineupDialog.CellAtIndex = function(self, helper, index)
  -- function num : 0_6
  return "mainline.offlinepvp.offlinepvpenemylinecell"
end

OffLinePvpEnemyLineupDialog.DataAtIndex = function(self, helper, index)
  -- function num : 0_7
  return (self._roleList)[index]
end

OffLinePvpEnemyLineupDialog.OnBackBtnClicked = function(self)
  -- function num : 0_8
  self:Destroy()
end

OffLinePvpEnemyLineupDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return OffLinePvpEnemyLineupDialog

