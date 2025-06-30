-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/levelupmsgtipdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LevelUpMsgTipDialog = class("LevelUpMsgTipDialog", Dialog)
LevelUpMsgTipDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
LevelUpMsgTipDialog.AssetName = "BaseCharacterInfoLevelUpToastMain"
local INTERVAL = 0.2
local MAXTIME = 1
LevelUpMsgTipDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LevelUpMsgTipDialog
  ((LevelUpMsgTipDialog.super).Ctor)(self, ...)
  self._groupName = "Message"
  self._msgTipList = {}
  self._taskList = {}
end

LevelUpMsgTipDialog.OnCreate = function(self)
  -- function num : 0_1
end

LevelUpMsgTipDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  for i,v in ipairs(self._taskList) do
    (GameTimer.RemoveTask)(v)
    v = nil
  end
  for i,v in ipairs(self._msgTipList) do
    if v.cell then
      (v.cell):Destroy()
      ;
      (v.cell):RootWindowDestroy()
      v.cell = nil
    end
  end
end

LevelUpMsgTipDialog.OnRefresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if #self._msgTipList == 0 then
    (DialogManager.DestroySingletonDialog)("character.levelupmsgtipdialog")
    return 
  end
  local _, height = ((((self._msgTipList)[1]).cell):GetRootWindow()):GetRectSize()
  local deltaHeight = 0
  for index = 2, #self._msgTipList do
    local w, h = ((((self._msgTipList)[index - 1]).cell):GetRootWindow()):GetRectSize()
    deltaHeight = deltaHeight + h
    ;
    ((((self._msgTipList)[index]).cell):GetRootWindow()):SetYPosition(0, deltaHeight)
  end
end

LevelUpMsgTipDialog.AddMessageTip = function(self, msg)
  -- function num : 0_4 , upvalues : _ENV
  local msgCell = {}
  msgCell.cell = (DialogManager.CreateDialog)("character.levelupmsgtipcell", (self:GetRootWindow())._uiObject)
  ;
  (msgCell.cell):Refresh(msg)
  msgCell.str = msg
  local _, height = ((msgCell.cell):GetRootWindow()):GetRectSize()
  ;
  ((msgCell.cell):GetRootWindow()):SetYPosition(0, 0)
  ;
  (table.insert)(self._msgTipList, 1, msgCell)
  if #self._msgTipList >= 2 then
    (((self._msgTipList)[#self._msgTipList]).cell):Destroy()
    if (((self._msgTipList)[#self._msgTipList]).cell):GetRootWindow() then
      (((self._msgTipList)[#self._msgTipList]).cell):RootWindowDestroy()
    end
    -- DECOMPILER ERROR at PC63: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._msgTipList)[#self._msgTipList]).cell = nil
    ;
    (table.remove)(self._msgTipList, #self._msgTipList)
  end
  -- DECOMPILER ERROR at PC80: Confused about usage of register: R5 in 'UnsetPending'

  ;
  (self._taskList)[#self._msgTipList] = (GameTimer.AddTask)(1, 0, function()
    -- function num : 0_4_0 , upvalues : self, _ENV
    if #self._msgTipList > 0 then
      if ((self._msgTipList)[#self._msgTipList]).cell then
        (((self._msgTipList)[#self._msgTipList]).cell):Destroy()
        if (((self._msgTipList)[#self._msgTipList]).cell):GetRootWindow() then
          (((self._msgTipList)[#self._msgTipList]).cell):RootWindowDestroy()
        end
        -- DECOMPILER ERROR at PC38: Confused about usage of register: R0 in 'UnsetPending'

        ;
        ((self._msgTipList)[#self._msgTipList]).cell = nil
      end
      ;
      (table.remove)(self._msgTipList, #self._msgTipList)
    end
    if #self._msgTipList <= 0 then
      self:OnRefresh()
    end
  end
, nil)
  self:OnRefresh()
end

LevelUpMsgTipDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  return DataCommon.BackPressed_SkipResponse
end

return LevelUpMsgTipDialog

