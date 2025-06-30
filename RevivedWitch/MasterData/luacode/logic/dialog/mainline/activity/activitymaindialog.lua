-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/activity/activitymaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CArenaSeasonConfig = (BeanManager.GetTableByName)("dungeonselect.carenaseasonconfig")
local ActivityMainDialog = class("ActivityMainDialog", Dialog)
ActivityMainDialog.AssetBundleName = "ui/layouts.mainline"
ActivityMainDialog.AssetName = "ActivityMain"
local oneline = 4
local slideRow = 2
ActivityMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActivityMainDialog
  ((ActivityMainDialog.super).Ctor)(self, ...)
  self._data = {}
end

ActivityMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._field = self:GetChild("Frame")
  self._frame = (TableFrame.Create)(self._field, self, false, true)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(6)
end

ActivityMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  if self._frame then
    (self._frame):Destroy()
  end
  ;
  (UIBackManager.SetUIBackShow)(false)
end

ActivityMainDialog.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, oneline, TableFrame, slideRow, GridFrame
  self._data = clone(data)
  for k,v in pairs(self._data) do
    if #v.data == 1 and ((v.data)[1]).id == 3 and not ((NekoData.BehaviorManager).BM_TowerV2):IsOpen() then
      (table.remove)(self._data, k)
      break
    end
  end
  do
    if self._frame then
      (self._frame):Destroy()
      self._frame = nil
    end
    if oneline < #self._data then
      self._frame = (TableFrame.Create)(self._field, self, false, true)
    else
      if oneline * slideRow < #self._data then
        self._frame = (TableFrame.Create)(self._field, self, false, true)
      else
        self._frame = (GridFrame.Create)(self._field, self, true, oneline, false)
      end
    end
    ;
    (self._frame):ReloadAllCell()
  end
end

ActivityMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

ActivityMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  if #((self._data)[index]).data == 1 then
    if ((((self._data)[index]).data)[1]).id == 3 then
      return "mainline.activity.towerv2cell"
    end
    return "mainline.activity.activitymaincell"
  else
    return "mainline.activity.activitymainbosscell"
  end
end

ActivityMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  if #((self._data)[index]).data == 1 then
    return (((self._data)[index]).data)[1]
  else
    return ((self._data)[index]).data
  end
end

ActivityMainDialog.OnWorldIClicked = function(self, id)
  -- function num : 0_7 , upvalues : _ENV
  if id == 1 then
    if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(49) then
      ((NekoData.BehaviorManager).BM_Guide):FinishGuide(49)
    end
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cgetshatteredzonesinfo")
    csend:Send()
  else
    do
      if id == 2 then
        ((DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog")):OpenBossRushPanel()
      else
        if id == 3 then
          if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(26) then
            ((NekoData.BehaviorManager).BM_Guide):FinishGuide(26)
          end
          ;
          ((NekoData.BehaviorManager).BM_TowerV2):TryEnter()
        else
          if id == 4 then
            if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(47) then
              ((NekoData.BehaviorManager).BM_Guide):FinishGuide(47)
            end
            local protocol = (LuaNetManager.CreateProtocol)("protocol.battle.copenarenapanel")
            if protocol then
              protocol:Send()
            end
          else
            do
              if id == 5 then
                local csend = (LuaNetManager.CreateProtocol)("protocol.activity.copenundecidedroad")
                csend:Send()
                local dialog = (DialogManager.CreateSingletonDialog)("mainline.undecidedroad.undecidedroadmaindialog")
                dialog:Init()
              else
                do
                  if id == 6 then
                    ((DialogManager.GetDialog)("mainline.mainline.mainlineworlddialog")):OpenWeekBossDialog()
                  else
                    if id == 7 then
                      if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(47) then
                        ((NekoData.BehaviorManager).BM_Guide):FinishGuide(47)
                      end
                      local fantasyProtocol = (LuaNetManager.CreateProtocol)("protocol.battle.cfantasyconflictopenpanel")
                      if fantasyProtocol then
                        fantasyProtocol:Send()
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

return ActivityMainDialog

