local CStringRes = BeanManager.GetTableByName("message.cstringres")
local SmallBattleFailedDialog = class("SmallBattleFailedDialog", Dialog)
SmallBattleFailedDialog.AssetBundleName = "ui/layouts.battlepassnew"
SmallBattleFailedDialog.AssetName = "BattlePassNewLoose"

function SmallBattleFailedDialog:Ctor(...)
  SmallBattleFailedDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function SmallBattleFailedDialog:OnCreate()
  self._finish = self:GetChild("Finish")
  self._text = self:GetChild("Text")
  self._tipsTxt = self:GetChild("Finish/Frame/TipText")
  self._text:SetText(TextManager.GetText(CStringRes:GetRecorder(1479).msgTextID))
  self._tipsTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1973).msgTextID))
  self._finish:Subscribe_StateExitEvent(self.OnStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._finish:SetAnimatorTrigger("End")
end

function SmallBattleFailedDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SmallBattleFailedDialog:OnStateExit(handle, statename, normalizedTime)
  if statename == "towerfinish" then
  end
end

function SmallBattleFailedDialog:OnGlobalPointerDown()
  self:Destroy()
end

return SmallBattleFailedDialog
