-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/maskcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MaskCell = class("MaskCell", Dialog)
MaskCell.AssetBundleName = "ui/layouts.activitysummer"
MaskCell.AssetName = "ActivitySummerMaskCell"
MaskCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MaskCell
  ((MaskCell.super).Ctor)(self, ...)
end

MaskCell.OnCreate = function(self)
  -- function num : 0_1
  self._maskIcon = self:GetChild("Image")
  self._maskName = self:GetChild("Text")
  self._maskStateText = self:GetChild("Buttom/Text")
  self._checkBorder = self:GetChild("Check")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

MaskCell.OnDestroy = function(self)
  -- function num : 0_2
end

MaskCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_3
  if eventName == "ChangedSelected" then
    if arg == self._index then
      (self._checkBorder):SetActive(true)
    else
      ;
      (self._checkBorder):SetActive(false)
    end
  end
end

MaskCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : CImagePathTable, _ENV, CStringRes
  self._index = data.index
  self._data = data.data
  if not CImagePathTable:GetRecorder((self._data).image) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._maskIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._maskName):SetText((TextManager.GetText)((self._data).name))
  if (self._data).isUnlock == 0 then
    (self._maskStateText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1607)).msgTextID))
  else
    if (self._data).isUnlock == 1 then
      (self._maskStateText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1609)).msgTextID))
    else
      if (self._data).isUnlock == 2 then
        (self._maskStateText):SetText((TextManager.GetText)((CStringRes:GetRecorder(1608)).msgTextID))
      end
    end
  end
end

MaskCell.OnCellClicked = function(self)
  -- function num : 0_5
  (self._delegate):ShowOneMaskDetail(self._index)
end

return MaskCell

