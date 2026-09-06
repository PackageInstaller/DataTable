local AttrTypeEnum = LuaNetManager.GetBeanDef("protocol.login.attrtype")
local CAttrNameTable = BeanManager.GetTableByName("role.cattreffectidname")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Num = 3
local RuneAdvancementLevelUpDialog = class("RuneAdvancementLevelUpDialog", Dialog)
RuneAdvancementLevelUpDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
RuneAdvancementLevelUpDialog.AssetName = "CharUpgradeSecondConfirm"

function RuneAdvancementLevelUpDialog:Ctor(...)
  RuneAdvancementLevelUpDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function RuneAdvancementLevelUpDialog:OnCreate()
  self._tip_Text = self:GetChild("Text")
  self._titleText = self:GetChild("NameText")
  self._icon = self:GetChild("NormalIcon/Icon")
  self:GetChild("ConfirmButton/_Text"):SetText(TextManager.GetText(CStringRes:GetRecorder(1).msgTextID))
  self:GetChild("CancelButton/_Text"):SetText(TextManager.GetText(CStringRes:GetRecorder(2).msgTextID))
  self:GetChild("_Toggle_0/Label"):SetText(NekoData.BehaviorManager.BM_Message:GetString(2054))
  self._cancleBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._cancleBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._lastDiableNoticeTime = NekoData.BehaviorManager.BM_Game:GetLocalCache(DataCommon.LocalCache.LastBodyAdvancedDailyReminder)
  self._toggleButton = self:GetChild("_Toggle_0")
  self._toggleButton:SetIsOnType(self._lastDiableNoticeTime ~= 0)
  self._toggleButton:Subscribe_ValueChangedEvent(self.ToggleButtonValueChanged, self)
end

function RuneAdvancementLevelUpDialog:SetData(data, role)
  self._data = data
  self._role = role
  local imageRecord = CImagePathTable:GetRecorder(data.icon) or DataCommon.DefaultImageAsset
  self._icon:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local namestr = role:GetRoleName()
  if role:GetRoleId() == 1 then
    namestr = NekoData.BehaviorManager.BM_Message:GetString(1778)
  end
  self._titleText:SetText(NekoData.BehaviorManager.BM_Message:GetString(1991, {namestr}))
  self._tip_Text:SetText(NekoData.BehaviorManager.BM_Message:GetString(1993, {
    TextManager.GetText(data.name),
    data.lv + 1
  }))
end

function RuneAdvancementLevelUpDialog:OnDestroy()
end

function RuneAdvancementLevelUpDialog:OnBackBtnClicked()
  self:Destroy()
end

function RuneAdvancementLevelUpDialog:OnConfirmBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.login.crunelevelup")
  csend.roleId = self._role:GetRoleId()
  csend.runeId = self._data.type
  csend:Send()
  self:Destroy()
end

function RuneAdvancementLevelUpDialog:ToggleButtonValueChanged()
  local value = self._toggleButton:GetIsOnType()
  if value then
    local nowDay = tonumber(os.date("!%Y%m%d", ServerGameTimer.GetServerTimeForecast() // 1000))
    NekoData.BehaviorManager.BM_Game:SetLocalCache(DataCommon.LocalCache.LastBodyAdvancedDailyReminder, nowDay)
  else
    NekoData.BehaviorManager.BM_Game:ClearLocalCache(DataCommon.LocalCache.LastBodyAdvancedDailyReminder)
  end
end

return RuneAdvancementLevelUpDialog
