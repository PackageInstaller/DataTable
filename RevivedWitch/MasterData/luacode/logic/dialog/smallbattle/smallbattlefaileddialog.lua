-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/smallbattle/smallbattlefaileddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local SmallBattleFailedDialog = class("SmallBattleFailedDialog", Dialog)
SmallBattleFailedDialog.AssetBundleName = "ui/layouts.battlepassnew"
SmallBattleFailedDialog.AssetName = "BattlePassNewLoose"
SmallBattleFailedDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SmallBattleFailedDialog
  ((SmallBattleFailedDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

SmallBattleFailedDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CStringRes
  self._finish = self:GetChild("Finish")
  self._text = self:GetChild("Text")
  self._tipsTxt = self:GetChild("Finish/Frame/TipText")
  ;
  (self._text):SetText((TextManager.GetText)((CStringRes:GetRecorder(1479)).msgTextID))
  ;
  (self._tipsTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1973)).msgTextID))
  ;
  (self._finish):Subscribe_StateExitEvent(self.OnStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  ;
  (self._finish):SetAnimatorTrigger("End")
end

SmallBattleFailedDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

SmallBattleFailedDialog.OnStateExit = function(self, handle, statename, normalizedTime)
  -- function num : 0_3
  if statename == "towerfinish" then
  end
end

SmallBattleFailedDialog.OnGlobalPointerDown = function(self)
  -- function num : 0_4
  self:Destroy()
end

return SmallBattleFailedDialog

