-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/bag/itemtipsgaintypecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CItemAccessType = (BeanManager.GetTableByName)("item.citemaccesstype")
local ItemTipsGainTypeCell = class("ItemTipsGainTypeCell", Dialog)
ItemTipsGainTypeCell.AssetBundleName = "ui/layouts.bag"
ItemTipsGainTypeCell.AssetName = "ItemTipsNewGet1"
ItemTipsGainTypeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ItemTipsGainTypeCell
  ((ItemTipsGainTypeCell.super).Ctor)(self, ...)
end

ItemTipsGainTypeCell.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Title")
  self._showBtn = self:GetChild("Add")
  self._hideBtn = self:GetChild("Reduce")
  ;
  (self._showBtn):Subscribe_PointerClickEvent(self.OnShowGainWays, self)
  ;
  (self._hideBtn):Subscribe_PointerClickEvent(self.OnShowGainWays, self)
end

ItemTipsGainTypeCell.OnDestroy = function(self)
  -- function num : 0_2
end

ItemTipsGainTypeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CItemAccessType
  (self._title):SetText((TextManager.GetText)((CItemAccessType:GetRecorder(data.type)).type))
  local show = ((self._delegate)._dataMap)[data.type]
  ;
  (self._showBtn):SetActive(not show)
  ;
  (self._hideBtn):SetActive(show)
end

ItemTipsGainTypeCell.OnShowGainWays = function(self)
  -- function num : 0_4
  (self._delegate):ShowGainWays((self._cellData).type)
end

ItemTipsGainTypeCell.OnEvent = function(self, eventName)
  -- function num : 0_5
  if eventName == "RefreshOperateBtn" then
    local show = ((self._delegate)._dataMap)[(self._cellData).type]
    ;
    (self._showBtn):SetActive(not show)
    ;
    (self._hideBtn):SetActive(show)
  end
end

return ItemTipsGainTypeCell

