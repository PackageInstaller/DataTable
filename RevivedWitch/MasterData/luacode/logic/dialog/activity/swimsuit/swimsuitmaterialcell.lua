-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/swimsuit/swimsuitmaterialcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local SwimSuitMaterialCell = class("SwimSuitMaterialCell", Dialog)
SwimSuitMaterialCell.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitMaterialCell.AssetName = "ActivitySummerMainMaterialCell"
SwimSuitMaterialCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : SwimSuitMaterialCell
  ((SwimSuitMaterialCell.super).Ctor)(self, ...)
end

SwimSuitMaterialCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  self._text = self:GetChild("Text")
end

SwimSuitMaterialCell.OnDestroy = function(self)
  -- function num : 0_2
end

SwimSuitMaterialCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item, CStringRes
  local totle = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(data.id)
  local item = (Item.Create)(data.id)
  ;
  (self._image):SetSprite(item:GetIconAB())
  local str = nil
  if totle < data.count then
    str = CStringRes:GetRecorder(1617)
  else
    str = CStringRes:GetRecorder(1616)
  end
  str = (TextManager.GetText)(str.msgTextID)
  str = (string.gsub)(str, "%$parameter1%$", item:GetName())
  str = (string.gsub)(str, "%$parameter2%$", data.count)
  ;
  (self._text):SetText(str)
end

return SwimSuitMaterialCell

