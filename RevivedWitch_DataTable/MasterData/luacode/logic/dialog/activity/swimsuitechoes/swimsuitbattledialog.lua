-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuitechoes/swimsuitbattledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local CSRLand = (BeanManager.GetTableByName)("activity.csrland")
local State = {Unlock = 1, Lock = 2, Repeat = 3}
local SwimSuitBattleDialog = class("SwimSuitBattleDialog", Dialog)
SwimSuitBattleDialog.AssetBundleName = "ui/layouts.activitysummer2"
SwimSuitBattleDialog.AssetName = "ActivitySummer2FullscreenMain"
SwimSuitBattleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitBattleDialog
  ((SwimSuitBattleDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

SwimSuitBattleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame
  self._backBtnText = self:GetChild("BackBtn/Text")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._title = self:GetChild("Title")
  self._topGroupPanel = self:GetChild("TopGroup")
  self._centerPanel = self:GetChild("frame")
  self._centerFrame = (TableFrame.Create)(self._centerPanel, self, false, true)
end

SwimSuitBattleDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._centerFrame then
    (self._centerFrame):Destroy()
  end
end

SwimSuitBattleDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : CSRLand, _ENV, State
  self._functionIDs = data.functionIDs
  self._constructionID = data.constructionID
  self._locked = data.locked
  self._autoExplore = data.autoExplore
  local landRecord = CSRLand:GetRecorder(self._constructionID)
  local backName = landRecord.name
  ;
  (self._title):SetText((TextManager.GetText)(backName))
  self._stateCommon = State
  self._battlesData = {}
  for i,v in ipairs(self._functionIDs) do
    local temp = {functionID = v, state = State.Unlock, constructionID = self._constructionID, index = i}
    ;
    (table.insert)(self._battlesData, temp)
  end
  for _,v in ipairs(self._locked) do
    if not (table.contain)(self._functionIDs, v) then
      local temp = {functionID = v, state = State.Lock, constructionID = self._constructionID, index = #self._battlesData + 1}
      ;
      (table.insert)(self._battlesData, temp)
    else
      do
        for j,k in ipairs(self._battlesData) do
          -- DECOMPILER ERROR at PC79: Confused about usage of register: R14 in 'UnsetPending'

          if k.functionID == v then
            ((self._battlesData)[j]).state = State.Lock
          end
        end
        do
          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC82: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  for _,v in ipairs(self._autoExplore) do
    if not (table.contain)(self._functionIDs, v) then
      local temp = {functionID = v, state = State.Repeat, constructionID = self._constructionID, index = #self._battlesData + 1}
      ;
      (table.insert)(self._battlesData, temp)
    else
      do
        for j,k in ipairs(self._battlesData) do
          -- DECOMPILER ERROR at PC121: Confused about usage of register: R14 in 'UnsetPending'

          if k.functionID == v then
            ((self._battlesData)[j]).state = State.Repeat
          end
        end
        do
          -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out DO_STMT

          -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_ELSE_STMT

          -- DECOMPILER ERROR at PC124: LeaveBlock: unexpected jumping out IF_STMT

        end
      end
    end
  end
  ;
  (self._centerFrame):ReloadAllCell()
end

SwimSuitBattleDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._battlesData
end

SwimSuitBattleDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_5
  return "activity.swimsuitechoes.resourcedetailcell"
end

SwimSuitBattleDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._battlesData)[index]
end

SwimSuitBattleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

SwimSuitBattleDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return SwimSuitBattleDialog

