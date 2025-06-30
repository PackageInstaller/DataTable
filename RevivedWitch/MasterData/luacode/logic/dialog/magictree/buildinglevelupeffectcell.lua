-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/buildinglevelupeffectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CCourtyardLvUpEffect = (BeanManager.GetTableByName)("courtyard.ccourtyardlvupeffect")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BuildingLevelUpEffectCell = class("BuildingLevelUpEffectCell", Dialog)
BuildingLevelUpEffectCell.AssetBundleName = "ui/layouts.yard"
BuildingLevelUpEffectCell.AssetName = "MagicTreeLevelUpEffectCell"
BuildingLevelUpEffectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BuildingLevelUpEffectCell
  ((BuildingLevelUpEffectCell.super).Ctor)(self, ...)
end

BuildingLevelUpEffectCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Image")
  self._normalTxt = self:GetChild("Txt")
  self._curEffectTxt = self:GetChild("Txt1")
  self._nextEffectTxt = self:GetChild("Txt1/Arrow/Txt2")
  self._curEffectWidth = (self._curEffectTxt):GetDeltaSize()
  self._nextEffectWidth = (self._nextEffectTxt):GetDeltaSize()
end

BuildingLevelUpEffectCell.OnDestroy = function(self)
  -- function num : 0_2
end

BuildingLevelUpEffectCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CCourtyardLvUpEffect, CImagePathTable, _ENV
  local record = CCourtyardLvUpEffect:GetRecorder(data)
  if not CImagePathTable:GetRecorder(record.iconid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if record.effecttype == 1 then
    (self._normalTxt):SetActive(false)
    ;
    (self._curEffectTxt):SetActive(true)
    local str = (TextManager.GetText)(record.textid)
    local strList = (string.split)(str, ";")
    ;
    (self._curEffectTxt):SetText(strList[1] .. strList[2])
    local textWidth, textHeight = (self._curEffectTxt):GetPreferredSize()
    ;
    (self._curEffectTxt):SetDeltaSize(textWidth, self._curEffectHeight)
    ;
    (self._nextEffectTxt):SetText(strList[3])
    textWidth = (self._nextEffectTxt):GetPreferredSize()
    ;
    (self._nextEffectTxt):SetDeltaSize(textWidth, self._nextEffectHeight)
  else
    do
      ;
      (self._normalTxt):SetActive(true)
      ;
      (self._curEffectTxt):SetActive(false)
      -- DECOMPILER ERROR at PC78: Overwrote pending register: R7 in 'AssignReg'

      ;
      (self._normalTxt):SetText((TextManager.GetText)(textHeight))
    end
  end
end

return BuildingLevelUpEffectCell

