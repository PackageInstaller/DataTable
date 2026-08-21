-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/levelupconsumecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Item = require("logic.manager.experimental.types.item")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local LevelUpConsumeCell = class("LevelUpConsumeCell", Dialog)
LevelUpConsumeCell.AssetBundleName = "ui/layouts.activitysummer"
LevelUpConsumeCell.AssetName = "ActivitySummerLevelUpConfirmCell"
LevelUpConsumeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LevelUpConsumeCell
  ((LevelUpConsumeCell.super).Ctor)(self, ...)
end

LevelUpConsumeCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Icon")
  self._num = self:GetChild("Num")
end

LevelUpConsumeCell.OnDestroy = function(self)
  -- function num : 0_2
end

LevelUpConsumeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : Item, _ENV, CStringRes
  local item = (Item.Create)(data.itemID)
  local imageRecord = item:GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local hadNum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(data.itemID)
  if data.itemNum <= hadNum then
    (self._num):SetText((TextManager.GetText)((CStringRes:GetRecorder(1590)).msgTextID, data.itemNum))
  else
    ;
    (self._num):SetText((TextManager.GetText)((CStringRes:GetRecorder(1591)).msgTextID, data.itemNum))
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

    ;
    (self._delegate)._canLevelUp = false
  end
end

return LevelUpConsumeCell

