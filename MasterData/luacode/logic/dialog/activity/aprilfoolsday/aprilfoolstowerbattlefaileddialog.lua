local CStringRes = BeanManager.GetTableByName("message.cstringres")
local AprilFoolsTowerBattleFailedDialog = class("AprilFoolsTowerBattleFailedDialog", Dialog)
AprilFoolsTowerBattleFailedDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerBattleFailedDialog.AssetName = "ActivityAprilFoolsLoose"

function AprilFoolsTowerBattleFailedDialog:Ctor(...)
  AprilFoolsTowerBattleFailedDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function AprilFoolsTowerBattleFailedDialog:OnCreate()
  self._finish = self:GetChild("Finish")
  self._text = self:GetChild("Text")
  self._tipsTxt = self:GetChild("Finish/Frame/TipText")
  self._text:SetText(TextManager.GetText(CStringRes:GetRecorder(1479).msgTextID))
  self._tipsTxt:SetText(TextManager.GetText(CStringRes:GetRecorder(1853).msgTextID))
  self._finish:Subscribe_StateExitEvent(self.OnStateExit, self)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
  self._finish:SetAnimatorTrigger("End")
end

function AprilFoolsTowerBattleFailedDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function AprilFoolsTowerBattleFailedDialog:OnStateExit(handle, statename, normalizedTime)
  if statename == "towerfinish" then
  end
end

function AprilFoolsTowerBattleFailedDialog:OnGlobalPointerDown()
  self:Destroy()
end

return AprilFoolsTowerBattleFailedDialog
