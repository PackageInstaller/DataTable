-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/xiguarankbosscell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local XiGuaRankBossCell = class("XiGuaRankBossCell", Dialog)
XiGuaRankBossCell.AssetBundleName = "ui/layouts.activitysummer"
XiGuaRankBossCell.AssetName = "ActivitySummerXiGuaRankBossCell"
XiGuaRankBossCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : XiGuaRankBossCell
  ((XiGuaRankBossCell.super).Ctor)(self, ...)
end

XiGuaRankBossCell.OnCreate = function(self)
  -- function num : 0_1
  self._boss = self:GetChild("Boss")
  self._text = self:GetChild("Text")
  self._checkBorder = self:GetChild("Select")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

XiGuaRankBossCell.OnDestroy = function(self)
  -- function num : 0_2
end

XiGuaRankBossCell.OnEvent = function(self, eventName, arg)
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

XiGuaRankBossCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : CImagePathTable, _ENV
  self._index = data.index
  self._data = data.data
  if not CImagePathTable:GetRecorder(((self._data).cfg).tapImage) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._boss):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._text):SetText((TextManager.GetText)(((self._data).cfg).name))
  ;
  (self._checkBorder):SetActive(self._index == (self._delegate)._selectedBossCellIndex)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

XiGuaRankBossCell.OnCellClicked = function(self)
  -- function num : 0_5
  (self._delegate):OneBossCellSelect(self._index)
end

return XiGuaRankBossCell

