-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/qualitytabbtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAlchemyPicRes = (BeanManager.GetTableByName)("courtyard.calchemypicres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local QualityTabBtnCell = class("QualityTabBtnCell", Dialog)
QualityTabBtnCell.AssetBundleName = "ui/layouts.yard"
QualityTabBtnCell.AssetName = "AlchemyChooseGroupBtn"
QualityTabBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : QualityTabBtnCell
  ((QualityTabBtnCell.super).Ctor)(self, ...)
end

QualityTabBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._groupBtn = self:GetChild("GroupBtn")
  self._groupBtnTxt = self:GetChild("GroupBtn/Text")
  self._groupBtnDot = self:GetChild("GroupBtn/Dot")
  self._groupBtnLock = self:GetChild("GroupBtn/Lock")
  ;
  (self._groupBtn):Subscribe_PointerClickEvent(self.OnGroupBtnClicked, self)
end

QualityTabBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

QualityTabBtnCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CAlchemyPicRes, CImagePathTable, _ENV
  local alchemyPicResRecord = CAlchemyPicRes:GetRecorder(data.level)
  if not CImagePathTable:GetRecorder(alchemyPicResRecord.bookmarkdot) then
    local imgRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._groupBtnDot):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  local levelTxtId = 800119 + data.level - 1
  ;
  (self._groupBtnTxt):SetText((TextManager.GetText)(levelTxtId))
  ;
  (self._groupBtn):SetSelected(data.level == (self._delegate)._selectLv)
  if (data.data).lock then
    (self._groupBtnDot):SetActive(false)
    ;
    (self._groupBtnLock):SetActive(true)
  else
    (self._groupBtnDot):SetActive(true)
    ;
    (self._groupBtnLock):SetActive(false)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

QualityTabBtnCell.OnGroupBtnClicked = function(self)
  -- function num : 0_4
  (self._delegate):SelectLevel((self._cellData).level)
end

QualityTabBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if (self._cellData).level ~= arg then
    (self._groupBtn):SetSelected(eventName ~= "SetSelectTab")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return QualityTabBtnCell

