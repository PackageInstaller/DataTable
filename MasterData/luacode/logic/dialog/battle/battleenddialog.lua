local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local UIManager = CS.PixelNeko.UI.UIManager
local BattleEndShowDialog = class("BattleEndShowDialog", Dialog)
BattleEndShowDialog.AssetBundleName = "ui/layouts.battle"
BattleEndShowDialog.AssetName = "BattleEndBackground"

function BattleEndShowDialog:Ctor(...)
  BattleEndShowDialog.super.Ctor(self, ...)
  self._groupName = "Default"
end

function BattleEndShowDialog:OnCreate()
  self._exit = self:GetChild("exit")
  self._exit:Subscribe_PointerClickEvent(self.OnExitClicked, self)
end

function BattleEndShowDialog:OnDestroy()
end

function BattleEndShowDialog:OnExitClicked()
  DialogManager.DestroySingletonDialog("battle.battleenddialog")
  if SceneManager.GetSceneController("BehaviacTest") then
    SceneManager.GetSceneController("BehaviacTest"):BattleEnd()
  end
  if SceneManager.GetSceneController("W1_Boss_01") then
    SceneManager.GetSceneController("W1_Boss_01"):BattleEnd()
  end
  if SceneManager.GetSceneController("T1_Battle_01") then
    SceneManager.GetSceneController("T1_Battle_01"):BattleEnd()
  end
end

function BattleEndShowDialog:Show(show)
  if show then
    self:GetRootWindow():PlayAnimation("BattleEnd")
  end
end

return BattleEndShowDialog
