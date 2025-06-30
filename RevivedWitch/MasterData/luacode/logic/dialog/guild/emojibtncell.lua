-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/emojibtncell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CShopTypeConfig = (BeanManager.GetTableByName)("recharge.cshoptypeconfig")
local CEmojiItem = (BeanManager.GetTableByName)("item.cemojiitem")
local DM_RedDot = (NekoData.DataManager).DM_RedDot
local EmojiBtnCell = class("EmojiBtnCell", Dialog)
EmojiBtnCell.AssetBundleName = "ui/layouts.guild"
EmojiBtnCell.AssetName = "EmojiTab"
EmojiBtnCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EmojiBtnCell
  ((EmojiBtnCell.super).Ctor)(self, ...)
end

EmojiBtnCell.OnCreate = function(self)
  -- function num : 0_1
  self._btn = self:GetChild("NextBtn")
  self._image = self:GetChild("Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

EmojiBtnCell.OnDestroy = function(self)
  -- function num : 0_2
end

EmojiBtnCell.RefreshCell = function(self, record)
  -- function num : 0_3 , upvalues : CImagePathTable, CEmojiItem, _ENV
  self._groupBtnID = record
  self._barSelected = self._groupBtnID == (self._delegate)._emojiType
  ;
  (self._btn):SetSelected(self._barSelected)
  if not CImagePathTable:GetRecorder((CEmojiItem:GetRecorder(record)).tabImgId) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EmojiBtnCell.OnCellClicked = function(self, args)
  -- function num : 0_4
  (self._delegate):OnEmojiTypeBtnClicked(self._groupBtnID)
end

EmojiBtnCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if self._groupBtnID ~= arg then
    self._barSelected = eventName ~= "ChangedSelected"
    ;
    (self._btn):SetSelected(self._barSelected)
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return EmojiBtnCell

