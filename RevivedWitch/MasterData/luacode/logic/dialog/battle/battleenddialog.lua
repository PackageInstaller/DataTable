-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleenddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local UIManager = ((CS.PixelNeko).UI).UIManager
local BattleEndShowDialog = class("BattleEndShowDialog", Dialog)
BattleEndShowDialog.AssetBundleName = "ui/layouts.battle"
BattleEndShowDialog.AssetName = "BattleEndBackground"
BattleEndShowDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleEndShowDialog
  ((BattleEndShowDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
end

BattleEndShowDialog.OnCreate = function(self)
  -- function num : 0_1
  self._exit = self:GetChild("exit")
  ;
  (self._exit):Subscribe_PointerClickEvent(self.OnExitClicked, self)
end

BattleEndShowDialog.OnDestroy = function(self)
  -- function num : 0_2
end

BattleEndShowDialog.OnExitClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.DestroySingletonDialog)("battle.battleenddialog")
  if (SceneManager.GetSceneController)("BehaviacTest") then
    ((SceneManager.GetSceneController)("BehaviacTest")):BattleEnd()
  end
  if (SceneManager.GetSceneController)("W1_Boss_01") then
    ((SceneManager.GetSceneController)("W1_Boss_01")):BattleEnd()
  end
  if (SceneManager.GetSceneController)("T1_Battle_01") then
    ((SceneManager.GetSceneController)("T1_Battle_01")):BattleEnd()
  end
end

BattleEndShowDialog.Show = function(self, show)
  -- function num : 0_4
  if show then
    (self:GetRootWindow()):PlayAnimation("BattleEnd")
  end
end

return BattleEndShowDialog

