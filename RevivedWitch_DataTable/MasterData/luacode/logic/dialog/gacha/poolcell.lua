-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/poolcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CardPool = (BeanManager.GetTableByName)("item.ccardpool")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local PoolCell = class("PoolCell", Dialog)
PoolCell.AssetBundleName = "ui/layouts.gacha"
PoolCell.AssetName = "GachaPoolCell"
PoolCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PoolCell
  ((PoolCell.super).Ctor)(self, ...)
  self._item = nil
end

PoolCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Panel/Back")
  self._name = self:GetChild("Panel/Name")
  self._timeInfo = self:GetChild("Panel/TimeInfo")
  self._selected = self:GetChild("Panel/Select")
  ;
  (self._selected):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnMouseClick, self)
end

PoolCell.OnDestroy = function(self)
  -- function num : 0_2
end

PoolCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CardPool, _ENV, ImageTable
  local record = CardPool:GetRecorder(data.id)
  ;
  (self._name):SetText((TextManager.GetText)(record.poolNameTextID))
  if not ImageTable:GetRecorder(record.CellImgID) then
    local image = DataCommon.DefaultImageAsset
  end
  ;
  (self._back):SetSprite(image.assetBundle, image.assetName)
  if record.isshowTimeShow < 1 then
    (self._timeInfo):SetActive(false)
  else
    if record.isshowTimeShow == 1 then
      (self._timeInfo):SetActive(true)
      ;
      (self._timeInfo):SetText(record.timeText)
    else
      ;
      (self._timeInfo):SetActive(true)
      ;
      (self._timeInfo):SetText((TextManager.GetText)(record.isshowTimeShow))
    end
  end
  ;
  (self._selected):SetActive(not ((self._delegate)._cardPoolList)[(self._delegate)._selectedPoolIndex] or (((self._delegate)._cardPoolList)[(self._delegate)._selectedPoolIndex]).id == data.id)
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

PoolCell.OnMouseClick = function(self)
  -- function num : 0_4
  (self._delegate):OnPoolCellClick(self._cellData)
end

PoolCell.OnEvent = function(self, name, args)
  -- function num : 0_5
  if args ~= (self._cellData).id then
    (self._selected):SetActive(name ~= "select")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return PoolCell

