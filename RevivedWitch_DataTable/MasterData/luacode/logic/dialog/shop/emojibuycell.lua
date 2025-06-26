-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/emojibuycell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CEmojiConfig = (BeanManager.GetTableByName)("guild.cguildemoji")
local EmojiBuyCell = class("EmojiBuyCell", Dialog)
EmojiBuyCell.AssetBundleName = "ui/layouts.baseshop"
EmojiBuyCell.AssetName = "EmojiBuyCell"
EmojiBuyCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EmojiBuyCell
  ((EmojiBuyCell.super).Ctor)(self, ...)
end

EmojiBuyCell.OnCreate = function(self)
  -- function num : 0_1
  self._item = self:GetChild("Item")
  self._itemName = self:GetChild("ItemName")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

EmojiBuyCell.OnDestroy = function(self)
  -- function num : 0_2
end

EmojiBuyCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CEmojiConfig, CImagePathTable, _ENV
  local record = CEmojiConfig:GetRecorder(data.id)
  if not record then
    return 
  end
  if not CImagePathTable:GetRecorder(record.EmojiId) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._item):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local str = (TextManager.GetText)(tonumber(record.EmojiNanmeId))
  ;
  (self._itemName):SetText(str)
end

EmojiBuyCell.OnCellClicked = function(self)
  -- function num : 0_4
end

return EmojiBuyCell

