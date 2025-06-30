-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/magictreelvupeffectdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CTreeLvUp = (BeanManager.GetTableByName)("courtyard.ctreelvup")
local MagictreeLvUpEffectDialog = class("MagictreeLvUpEffectDialog", Dialog)
MagictreeLvUpEffectDialog.AssetBundleName = "ui/layouts.yard"
MagictreeLvUpEffectDialog.AssetName = "MagicTreeNewEffect"
MagictreeLvUpEffectDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MagictreeLvUpEffectDialog
  ((MagictreeLvUpEffectDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

MagictreeLvUpEffectDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, CTreeLvUp
  self._skipBtn = self:GetChild("SkipBtn")
  self._effect = self:GetChild("Effect")
  self._effectHandler = (self._effect):AddEffectSync((EffectUtil.GetAssetBundleNameAndAssetName)((CTreeLvUp:GetRecorder(((NekoData.BehaviorManager).BM_MagicTree):GetLevel() + 1)).treeevolveeffect))
  ;
  (self._effect):Subscribe_EffectStateExitEvent(self._effectHandler, self.OnAnimationEnd, self)
  ;
  (self._skipBtn):Subscribe_PointerClickEvent(self.OnSkipBtnClicked, self)
  local dialog = (DialogManager.GetDialog)("magictree.magictreedialog")
  if dialog then
    (dialog._magicTreeEffect):SetActive(false)
  end
end

MagictreeLvUpEffectDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("magictree.magictreedialog")
  if dialog then
    (dialog._magicTreeEffect):SetActive(true)
  end
end

MagictreeLvUpEffectDialog.OnSkipBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local ccompleteTask = (LuaNetManager.CreateProtocol)("protocol.yard.ccompletetask")
  ccompleteTask.id = DataCommon.MagicTree
  ccompleteTask:Send()
  self:Destroy()
end

MagictreeLvUpEffectDialog.OnAnimationEnd = function(self, handler, stateName, normalizedTime)
  -- function num : 0_4 , upvalues : _ENV
  local ccompleteTask = (LuaNetManager.CreateProtocol)("protocol.yard.ccompletetask")
  ccompleteTask.id = DataCommon.MagicTree
  ccompleteTask:Send()
  self:Destroy()
end

return MagictreeLvUpEffectDialog

