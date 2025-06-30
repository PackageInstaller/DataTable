-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/hpdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local GlobalCameras = (((CS.PixelNeko).P1).Common).GlobalCameras
local CSharpBattlerComponent = require("logic.battle.component.csharpbattlercomponent")
local Utility = require("logic.battle.utility")
local HPShowDialog = class("HPShowDialog", Dialog)
HPShowDialog.AssetBundleName = "ui/layouts.battle"
HPShowDialog.AssetName = "HPDialog"
HPShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : HPShowDialog
  ((HPShowDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._hpCells = {}
  self._damageCells = {}
end

HPShowDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetRootWindow()):Subscribe_LateUpdateEvent(self.OnUpdate, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnHPChanged, Common.n_HpChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnBattleEnd, Common.n_BattleEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

HPShowDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  for k,dialog in pairs(self._hpCells) do
    dialog:Destroy()
    dialog:RootWindowDestroy()
  end
  self._hpCells = {}
  for k,dialog in pairs(self._damageCells) do
    dialog:Destroy()
    dialog:RootWindowDestroy()
  end
  self._damageCells = {}
end

HPShowDialog.Show = function(self, show)
  -- function num : 0_3
  if show then
    (self:GetRootWindow()):PlayAnimation("HPDialogShow")
  else
    ;
    (self:GetRootWindow()):PlayAnimation("HPDialogHide")
  end
end

HPShowDialog.OnUpdate = function(self)
  -- function num : 0_4 , upvalues : _ENV, CSharpBattlerComponent, Utility, UIManager
  for k,dialog in pairs(self._hpCells) do
    dialog:OnUpdate()
  end
  for k,dialog in pairs(self._damageCells) do
    if (dialog._battler):GetComponent(CSharpBattlerComponent) then
      local px, py, pz = (Utility.GetBattlerCharacterPosition)(dialog._battler, "HitPoint")
      local x, y = (UIManager.ScreenPointToLocalPointInRectangle)(self._root, (UIManager.WorldToScreenPointInMargin)("BattleMain", px, py, pz))
      dialog:SetPosition(x, y)
    end
  end
end

HPShowDialog.OnBattleEnd = function(self)
  -- function num : 0_5 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("battle.hpdialog")
end

HPShowDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_6
  local dialog = notification.userInfo
  if (self._hpCells)[dialog._dialogKey] then
    dialog:RootWindowDestroy()
    -- DECOMPILER ERROR at PC10: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._hpCells)[dialog._dialogKey] = nil
  end
  if (self._damageCells)[dialog._dialogKey] then
    dialog:RootWindowDestroy()
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._damageCells)[dialog._dialogKey] = nil
  end
end

HPShowDialog.CreateBatttlerHPBar = function(self, battlerEntity)
  -- function num : 0_7 , upvalues : _ENV
  local cell = (DialogManager.CreateDialog)("battle.hpcell", (self:GetRootWindow())._uiObject)
  cell:SetBattlerInfo(battlerEntity)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._hpCells)[cell._dialogKey] = cell
  return cell._dialogKey
end

HPShowDialog.DestroyBatttlerHPBar = function(self, dialogKey)
  -- function num : 0_8
  if (self._hpCells)[dialogKey] then
    ((self._hpCells)[dialogKey]):Destroy()
  end
end

HPShowDialog.CreateBossHPBar = function(self, battlerEntity)
  -- function num : 0_9 , upvalues : _ENV
  local cell = (DialogManager.CreateDialog)("battle.bosshpcell", (self:GetRootWindow())._uiObject)
  cell:SetBattlerInfo(battlerEntity)
  -- DECOMPILER ERROR at PC12: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._hpCells)[cell._dialogKey] = cell
  return cell._dialogKey
end

HPShowDialog.DestroyBossHPBar = function(self, dialogKey)
  -- function num : 0_10
  if (self._hpCells)[dialogKey] then
    ((self._hpCells)[dialogKey]):Destroy()
  end
end

HPShowDialog.OnHPChanged = function(self, notification)
  -- function num : 0_11 , upvalues : Utility, UIManager, _ENV
  local battler = (notification.userInfo).battler
  local hpChanged = (notification.userInfo).hpChanged
  local damageType = (notification.userInfo).damageType
  local critical = (notification.userInfo).critical
  local px, py, pz = (Utility.GetBattlerCharacterPosition)(battler, "HitPoint_Body")
  local x, y = (UIManager.ScreenPointToLocalPointInRectangle)(self._root, (UIManager.WorldToScreenPointInMargin)("BattleMain", px, py, pz))
  local cell = (DialogManager.CreateDialog)("battle.damagenumcell", (self:GetRootWindow())._uiObject)
  cell:Refresh(battler, hpChanged, x, y, critical, damageType)
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R12 in 'UnsetPending'

  ;
  (self._damageCells)[cell._dialogKey] = cell
end

return HPShowDialog

