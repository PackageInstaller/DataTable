-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipfmresulttipdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CRankShow = (BeanManager.GetTableByName)("equip.crankshow")
local CAttrEffectidNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CRandomAbilityTable = (BeanManager.GetTableByName)("equip.crandomability")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local EquipFMResultTipDialog = class("EquipFMResultTipDialog", Dialog)
EquipFMResultTipDialog.AssetBundleName = "ui/layouts.equip"
EquipFMResultTipDialog.AssetName = "EquipFMTips"
EquipFMResultTipDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipFMResultTipDialog
  ((EquipFMResultTipDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._timer = 0
  self._totalTime = 2
end

EquipFMResultTipDialog.OnCreate = function(self)
  -- function num : 0_1
  self._rankImage = self:GetChild("BackImage/Back/LevelImg")
  self._propertyNameText = self:GetChild("BackImage/Back/Txt1")
  self._propertyValueText = self:GetChild("BackImage/Back/Num")
  self._tipText = self:GetChild("BackImage/Text")
  ;
  (self._rootWindow):Subscribe_UpdateEvent(self.OnUpdate, self)
end

EquipFMResultTipDialog.OnDestroy = function(self)
  -- function num : 0_2
end

EquipFMResultTipDialog.OnUpdate = function(self, deltaTime)
  -- function num : 0_3
  self._timer = self._timer + deltaTime
  if self._totalTime < self._timer then
    self:Destroy()
  end
end

EquipFMResultTipDialog.Refresh = function(self, data)
  -- function num : 0_4 , upvalues : CRankShow, CImagePathTable, _ENV, CAttrEffectidNameTable, CRandomAbilityTable, CStringRes
  local rankShowRecord = CRankShow:GetRecorder(data.newAttrRank)
  local imageRecord = CImagePathTable:GetRecorder(rankShowRecord.imgid)
  ;
  (self._rankImage):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local attrId = data.newAttrId - (math.fmod)(tonumber(data.newAttrId), 10)
  local attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
  ;
  (self._propertyNameText):SetText((TextManager.GetText)(attrRecord.classnameTextID))
  local cRandomAbilityRecord = CRandomAbilityTable:GetRecorder(data.newRandomAbilityId)
  local num1, num2 = (string.match)(cRandomAbilityRecord.attrRange, "(%d+);(%d+)")
  local attrValue = nil
  if attrRecord.isDecimal == 1 then
    attrValue = data.newValue / 1000 * 100
    num1 = num1 / 1000 * 100
    num2 = num2 / 1000 * 100
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1286)).msgTextID)
    attrValue = (string.gsub)(str, "%$parameter1%$", tostring(attrValue))
    num1 = (string.gsub)(str, "%$parameter1%$", tostring(num1))
    num2 = (string.gsub)(str, "%$parameter1%$", tostring(num2))
  else
    do
      attrValue = data.newValue
      ;
      (self._propertyValueText):SetText(attrValue)
      local tip = (TextManager.GetText)((CStringRes:GetRecorder(1382)).msgTextID)
      ;
      (self._tipText):SetText(tip)
    end
  end
end

return EquipFMResultTipDialog

