local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local GlobalCameras = CS.PixelNeko.P1.Common.GlobalCameras
local CSharpBattlerComponent = require("logic.battle.component.csharpbattlercomponent")
local Utility = require("logic.battle.utility")
local HPShowDialog = class("HPShowDialog", Dialog)
HPShowDialog.AssetBundleName = "ui/layouts.battle"
HPShowDialog.AssetName = "HPDialog"

function HPShowDialog:Ctor(...)
  HPShowDialog.super.Ctor(self, ...)
  self._groupName = "Default"
  self._hpCells = {}
  self._damageCells = {}
end

function HPShowDialog:OnCreate()
  self:GetRootWindow():Subscribe_LateUpdateEvent(self.OnUpdate, self)
  LuaNotificationCenter.AddObserver(self, self.OnHPChanged, Common.n_HpChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnBattleEnd, Common.n_BattleEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

function HPShowDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  for k, dialog in pairs(self._hpCells) do
    dialog:Destroy()
    dialog:RootWindowDestroy()
  end
  self._hpCells = {}
  for k, dialog in pairs(self._damageCells) do
    dialog:Destroy()
    dialog:RootWindowDestroy()
  end
  self._damageCells = {}
end

function HPShowDialog:Show(show)
  if show then
    self:GetRootWindow():PlayAnimation("HPDialogShow")
  else
    self:GetRootWindow():PlayAnimation("HPDialogHide")
  end
end

function HPShowDialog:OnUpdate()
  for k, dialog in pairs(self._hpCells) do
    dialog:OnUpdate()
  end
  for k, dialog in pairs(self._damageCells) do
    if dialog._battler:GetComponent(CSharpBattlerComponent) then
      local px, py, pz = Utility.GetBattlerCharacterPosition(dialog._battler, "HitPoint")
      local x, y = UIManager.ScreenPointToLocalPointInRectangle(self._root, UIManager.WorldToScreenPointInMargin("BattleMain", px, py, pz))
      dialog:SetPosition(x, y)
    end
  end
end

function HPShowDialog:OnBattleEnd()
  DialogManager.DestroySingletonDialog("battle.hpdialog")
end

function HPShowDialog:OnDialogDestroy(notification)
  local dialog = notification.userInfo
  if self._hpCells[dialog._dialogKey] then
    dialog:RootWindowDestroy()
    self._hpCells[dialog._dialogKey] = nil
  end
  if self._damageCells[dialog._dialogKey] then
    dialog:RootWindowDestroy()
    self._damageCells[dialog._dialogKey] = nil
  end
end

function HPShowDialog:CreateBatttlerHPBar(battlerEntity)
  local cell = DialogManager.CreateDialog("battle.hpcell", self:GetRootWindow()._uiObject)
  cell:SetBattlerInfo(battlerEntity)
  self._hpCells[cell._dialogKey] = cell
  return cell._dialogKey
end

function HPShowDialog:DestroyBatttlerHPBar(dialogKey)
  if self._hpCells[dialogKey] then
    self._hpCells[dialogKey]:Destroy()
  end
end

function HPShowDialog:CreateBossHPBar(battlerEntity)
  local cell = DialogManager.CreateDialog("battle.bosshpcell", self:GetRootWindow()._uiObject)
  cell:SetBattlerInfo(battlerEntity)
  self._hpCells[cell._dialogKey] = cell
  return cell._dialogKey
end

function HPShowDialog:DestroyBossHPBar(dialogKey)
  if self._hpCells[dialogKey] then
    self._hpCells[dialogKey]:Destroy()
  end
end

function HPShowDialog:OnHPChanged(notification)
  local battler = notification.userInfo.battler
  local hpChanged = notification.userInfo.hpChanged
  local damageType = notification.userInfo.damageType
  local critical = notification.userInfo.critical
  local px, py, pz = Utility.GetBattlerCharacterPosition(battler, "HitPoint_Body")
  local x, y = UIManager.ScreenPointToLocalPointInRectangle(self._root, UIManager.WorldToScreenPointInMargin("BattleMain", px, py, pz))
  local cell = DialogManager.CreateDialog("battle.damagenumcell", self:GetRootWindow()._uiObject)
  cell:Refresh(battler, hpChanged, x, y, critical, damageType)
  self._damageCells[cell._dialogKey] = cell
end

return HPShowDialog
