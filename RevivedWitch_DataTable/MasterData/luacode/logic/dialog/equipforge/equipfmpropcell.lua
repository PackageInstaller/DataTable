-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipforge/equipfmpropcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CAttrEffectidNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CRandomAbilityTable = (BeanManager.GetTableByName)("equip.crandomability")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipFMPropCell = class("EquipFMPropCell", Dialog)
local ReplacePercent = function(str)
  -- function num : 0_0 , upvalues : _ENV
  str = (string.gsub)(str, "%%", "%%%%")
  return str
end

EquipFMPropCell.AssetBundleName = "ui/layouts.equip"
EquipFMPropCell.AssetName = "EquipFMProp"
EquipFMPropCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : EquipFMPropCell
  ((EquipFMPropCell.super).Ctor)(self, ...)
  self.canClick = true
end

EquipFMPropCell.OnCreate = function(self)
  -- function num : 0_2
  self._num = self:GetChild("Num")
  self._name = self:GetChild("Txt1")
  self._range = self:GetChild("Txt2")
  self._toggle = self:GetChild("_Toggle_0")
  self._back = self:GetChild("Back")
  self._backSelect = self:GetChild("BackSelect")
  ;
  (self._toggle):SetInteractable(false)
  ;
  (self._toggle):Subscribe_PointerClickEvent(self.OnToggleClicked, self)
end

EquipFMPropCell.OnDestroy = function(self)
  -- function num : 0_3
end

EquipFMPropCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV, CAttrEffectidNameTable, CRandomAbilityTable, CStringRes, ReplacePercent, Cequipbreakcfg
  local attrId = data.attrId - (math.fmod)(tonumber(data.attrId), 10)
  local attrRecord = CAttrEffectidNameTable:GetRecorder(attrId)
  ;
  (self._name):SetText((TextManager.GetText)(attrRecord.classnameTextID))
  local attrRangeRecord = (CRandomAbilityTable:GetRecorder(data.randomAbilityId)).attrRange
  local num1, num2 = (string.match)(attrRangeRecord, "(%d+);(%d+)")
  local attrValue = nil
  if attrRecord.isDecimal == 1 then
    attrValue = data.value / 1000 * 100
    num1 = num1 / 1000 * 100
    num2 = num2 / 1000 * 100
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1286)).msgTextID)
    attrValue = (string.gsub)(str, "%$parameter1%$", tostring(attrValue))
    num1 = (string.gsub)(str, "%$parameter1%$", tostring(num1))
    num2 = (string.gsub)(str, "%$parameter1%$", tostring(num2))
  else
    do
      attrValue = data.value
      ;
      (self._num):SetText(attrValue)
      if data.unLock then
        local str1 = (TextManager.GetText)((CStringRes:GetRecorder(1200)).msgTextID)
        str1 = (string.gsub)(str1, "%$parameter1%$", ReplacePercent(num1))
        str1 = (string.gsub)(str1, "%$parameter2%$", ReplacePercent(num2))
        ;
        (self._range):SetText(str1)
      else
        do
          local cequipbreakcfgAll = (Cequipbreakcfg:GetAllIds())
          local unlockStage = nil
          for i,id in pairs(cequipbreakcfgAll) do
            local record = Cequipbreakcfg:GetRecorder(id)
            if ((self._delegate)._equip):GetPinJiID() == record.pinJi and data.randomIndex == record.unlockAbilityNum then
              unlockStage = record.breaklv
              break
            end
          end
          do
            if unlockStage then
              local str1 = (TextManager.GetText)((CStringRes:GetRecorder(1209)).msgTextID)
              str1 = (string.gsub)(str1, "%$parameter1%$", ReplacePercent(num1))
              str1 = (string.gsub)(str1, "%$parameter2%$", ReplacePercent(num2))
              str1 = (string.gsub)(str1, "%$parameter3%$", tostring(unlockStage))
              ;
              (self._range):SetText(str1)
            else
              do
                do
                  local str1 = (TextManager.GetText)((CStringRes:GetRecorder(1200)).msgTextID)
                  str1 = (string.gsub)(str1, "%$parameter1%$", ReplacePercent(num1))
                  str1 = (string.gsub)(str1, "%$parameter2%$", ReplacePercent(num2))
                  ;
                  (self._range):SetText(str1)
                  LogError("EquipFMPropCell:", "Reading table Cequipbreakcfg failed")
                  if ((self._delegate)._equip):GetRandomIndex() == 0 then
                    self.canClick = true
                  else
                    self.canClick = false
                    if data.randomIndex == ((self._delegate)._equip):GetRandomIndex() then
                      (self._delegate):DisabledAllToggle()
                      -- DECOMPILER ERROR at PC241: Confused about usage of register: R8 in 'UnsetPending'

                      ;
                      (self._delegate)._selectedWordId = (self._cellData).randomIndex
                      ;
                      (self._toggle):SetIsOnType(true)
                      ;
                      (self._backSelect):SetActive(true)
                    else
                      ;
                      (self._toggle):SetIsOnType(false)
                      ;
                      (self._backSelect):SetActive(false)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

EquipFMPropCell.OnToggleClicked = function(self)
  -- function num : 0_5
  if self.canClick then
    (self._delegate):OnToggleClicked((self._cellData).randomIndex)
  end
end

EquipFMPropCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_6
  if eventName == "OffAllToggle" then
    if arg == (self._cellData).randomIndex then
      (self._toggle):SetIsOnType(true)
      ;
      (self._backSelect):SetActive(true)
    else
      ;
      (self._toggle):SetIsOnType(false)
      ;
      (self._backSelect):SetActive(false)
    end
  else
    if eventName == "DisabledAllToggle" then
      (self._toggle):SetInteractable(false)
    end
  end
end

return EquipFMPropCell

