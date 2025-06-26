-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolstowerbattlefaileddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local AprilFoolsTowerBattleFailedDialog = class("AprilFoolsTowerBattleFailedDialog", Dialog)
AprilFoolsTowerBattleFailedDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerBattleFailedDialog.AssetName = "ActivityAprilFoolsLoose"
AprilFoolsTowerBattleFailedDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsTowerBattleFailedDialog
  ((AprilFoolsTowerBattleFailedDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

AprilFoolsTowerBattleFailedDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CStringRes
  self._finish = self:GetChild("Finish")
  self._text = self:GetChild("Text")
  self._tipsTxt = self:GetChild("Finish/Frame/TipText")
  ;
  (self._text):SetText((TextManager.GetText)((CStringRes:GetRecorder(1479)).msgTextID))
  ;
  (self._tipsTxt):SetText((TextManager.GetText)((CStringRes:GetRecorder(1853)).msgTextID))
  ;
  (self._finish):Subscribe_StateExitEvent(self.OnStateExit, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  ;
  (self._finish):SetAnimatorTrigger("End")
end

AprilFoolsTowerBattleFailedDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

AprilFoolsTowerBattleFailedDialog.OnStateExit = function(self, handle, statename, normalizedTime)
  -- function num : 0_3
  if statename == "towerfinish" then
  end
end

AprilFoolsTowerBattleFailedDialog.OnGlobalPointerDown = function(self)
  -- function num : 0_4
  self:Destroy()
end

return AprilFoolsTowerBattleFailedDialog

