local CTreeLvUp = BeanManager.GetTableByName("courtyard.ctreelvup")
local MagictreeLvUpEffectDialog = class("MagictreeLvUpEffectDialog", Dialog)
MagictreeLvUpEffectDialog.AssetBundleName = "ui/layouts.yard"
MagictreeLvUpEffectDialog.AssetName = "MagicTreeNewEffect"

function MagictreeLvUpEffectDialog:Ctor(...)
  MagictreeLvUpEffectDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function MagictreeLvUpEffectDialog:OnCreate()
  self._skipBtn = self:GetChild("SkipBtn")
  self._effect = self:GetChild("Effect")
  self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(CTreeLvUp:GetRecorder(NekoData.BehaviorManager.BM_MagicTree:GetLevel() + 1).treeevolveeffect))
  self._effect:Subscribe_EffectStateExitEvent(self._effectHandler, self.OnAnimationEnd, self)
  self._skipBtn:Subscribe_PointerClickEvent(self.OnSkipBtnClicked, self)
  local dialog = DialogManager.GetDialog("magictree.magictreedialog")
  if dialog then
    dialog._magicTreeEffect:SetActive(false)
  end
end

function MagictreeLvUpEffectDialog:OnDestroy()
  local dialog = DialogManager.GetDialog("magictree.magictreedialog")
  if dialog then
    dialog._magicTreeEffect:SetActive(true)
  end
end

function MagictreeLvUpEffectDialog:OnSkipBtnClicked()
  local ccompleteTask = LuaNetManager.CreateProtocol("protocol.yard.ccompletetask")
  ccompleteTask.id = DataCommon.MagicTree
  ccompleteTask:Send()
  self:Destroy()
end

function MagictreeLvUpEffectDialog:OnAnimationEnd(handler, stateName, normalizedTime)
  local ccompleteTask = LuaNetManager.CreateProtocol("protocol.yard.ccompletetask")
  ccompleteTask.id = DataCommon.MagicTree
  ccompleteTask:Send()
  self:Destroy()
end

return MagictreeLvUpEffectDialog
