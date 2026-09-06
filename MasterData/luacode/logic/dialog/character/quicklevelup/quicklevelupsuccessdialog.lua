local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local RoleSkin = require("logic.manager.experimental.types.roleskin")
local QuickLevelUpSuccessDialog = class("QuickLevelUpSuccessDialog", Dialog)
QuickLevelUpSuccessDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
QuickLevelUpSuccessDialog.AssetName = "CharFastLevelUpSuccess"

function QuickLevelUpSuccessDialog:Ctor(...)
  QuickLevelUpSuccessDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function QuickLevelUpSuccessDialog:OnCreate()
  self._last_lv = self:GetChild("LevelBack1/LevelNum")
  self._last_breakLvBack = self:GetChild("LevelBack1/BreakLevelBack")
  self._last_breakLv = self:GetChild("LevelBack1/BreakLevelNum")
  self._cur_lv = self:GetChild("LevelBack2/LevelNum")
  self._cur_breakLvBack = self:GetChild("LevelBack2/BreakLevelBack")
  self._cur_breakLv = self:GetChild("LevelBack2/BreakLevelNum")
  self._prop_health_icon = self:GetChild("Property/Health/Image")
  self._prop_health_name = self:GetChild("Property/Health/Name")
  self._prop_phyAtk_icon = self:GetChild("Property/PhyAtk/Image")
  self._prop_phyAtk_name = self:GetChild("Property/PhyAtk/Name")
  self._prop_phyDef_icon = self:GetChild("Property/PhyDef/Image")
  self._prop_phyDef_name = self:GetChild("Property/PhyDef/Name")
  self._prop_magDef_icon = self:GetChild("Property/MagDef/Image")
  self._prop_magDef_name = self:GetChild("Property/MagDef/Name")
  self._last_prop_health_value = self:GetChild("Property/Health/Num")
  self._last_prop_phyAtk_value = self:GetChild("Property/PhyAtk/Num")
  self._last_prop_phyDef_value = self:GetChild("Property/PhyDef/Num")
  self._last_prop_magDef_value = self:GetChild("Property/MagDef/Num")
  self._cur_prop_health_value = self:GetChild("Property/Health/Num2")
  self._cur_prop_phyAtk_value = self:GetChild("Property/PhyAtk/Num2")
  self._cur_prop_phyDef_value = self:GetChild("Property/PhyDef/Num2")
  self._cur_prop_magDef_value = self:GetChild("Property/MagDef/Num2")
  self._unlockSkin_panel = self:GetChild("UnlockSkin")
  self._unlockSkin_panel_skinName = self:GetChild("UnlockSkin/SkinName")
  self._effect = self:GetChild("TitleBack/Effect")
  self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(1050))
  self._closeBtn = self:GetChild("Tips/CloseBtn")
  self._confirmBtn = self:GetChild("GetBtn")
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local imageRecord = CImagePathTable:GetRecorder(14211) or DataCommon.DefaultImageAsset
  self._last_breakLvBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._cur_breakLvBack:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

function QuickLevelUpSuccessDialog:OnDestroy()
  LuaNotificationCenter.PostNotification(Common.n_TriggerGuide, self, nil)
end

function QuickLevelUpSuccessDialog:SetData(protocol)
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(protocol.roleId)
  local breakLv, showLv = role:GetBreakLvAndShowLvByRoleLv(protocol.beforeLevel)
  self._last_lv:SetText(showLv)
  self._last_breakLvBack:SetActive(0 < breakLv)
  self._last_breakLv:SetActive(0 < breakLv)
  if 0 < breakLv then
    self._last_breakLv:SetText(breakLv)
  end
  breakLv, showLv = role:GetBreakLvAndShowLvByRoleLv(protocol.afterLevel)
  self._cur_lv:SetText(showLv)
  self._cur_breakLvBack:SetActive(0 < breakLv)
  self._cur_breakLv:SetActive(0 < breakLv)
  if 0 < breakLv then
    self._cur_breakLv:SetText(breakLv)
  end
  local lastProperties = protocol.beforePro
  local record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAX_HP)
  local imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._prop_health_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._prop_health_name:SetText(TextManager.GetText(record.classnameTextID))
  self._last_prop_health_value:SetText(tostring(lastProperties[AttrTypeEnum.MAX_HP]))
  if role:GetDamageType() == 1 then
    record = CAttrNameTable:GetRecorder(AttrTypeEnum.ATTACK)
  else
    record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_ATTACK)
  end
  imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._prop_phyAtk_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._prop_phyAtk_name:SetText(TextManager.GetText(record.classnameTextID))
  self._last_prop_phyAtk_value:SetText(tostring(lastProperties[AttrTypeEnum.ATTACK]))
  record = CAttrNameTable:GetRecorder(AttrTypeEnum.DEFEND)
  imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._prop_phyDef_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._prop_phyDef_name:SetText(TextManager.GetText(record.classnameTextID))
  self._last_prop_phyDef_value:SetText(tostring(lastProperties[AttrTypeEnum.DEFEND]))
  record = CAttrNameTable:GetRecorder(AttrTypeEnum.MAGIC_DEFEND)
  imageRecord = CImagePathTable:GetRecorder(record.classIcon) or DataCommon.DefaultImageAsset
  self._prop_magDef_icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._prop_magDef_name:SetText(TextManager.GetText(record.classnameTextID))
  self._last_prop_magDef_value:SetText(tostring(lastProperties[AttrTypeEnum.MAGIC_DEFEND]))
  local curProperties = protocol.afterPro
  self._cur_prop_health_value:SetText(tostring(curProperties[AttrTypeEnum.MAX_HP]))
  self._cur_prop_phyAtk_value:SetText(tostring(curProperties[AttrTypeEnum.ATTACK]))
  self._cur_prop_phyDef_value:SetText(tostring(curProperties[AttrTypeEnum.DEFEND]))
  self._cur_prop_magDef_value:SetText(tostring(curProperties[AttrTypeEnum.MAGIC_DEFEND]))
  if protocol.gainSkin ~= 0 then
    self._showGainSkin = protocol.gainSkin
    self._unlockSkin_panel:SetActive(true)
    local roleSkin = RoleSkin.Create(protocol.gainSkin)
    self._unlockSkin_panel_skinName:SetText(roleSkin:GetSkinName())
  else
    self._unlockSkin_panel:SetActive(false)
  end
end

function QuickLevelUpSuccessDialog:OnBackBtnClicked()
  if self._showGainSkin then
    DialogManager.CreateSingletonDialog("shop.fashionbuyresultdialog"):SetData({
      itemId = self._showGainSkin
    }, true)
  end
  self:Destroy()
end

return QuickLevelUpSuccessDialog
