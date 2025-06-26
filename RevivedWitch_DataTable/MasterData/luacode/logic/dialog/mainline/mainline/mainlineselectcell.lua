-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/mainline/mainlineselectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local MainLineSelectCell = class("MainLineSelectCell", Dialog)
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
MainLineSelectCell.AssetBundleName = "ui/layouts.mainline"
MainLineSelectCell.AssetName = "MainLineSelectCell"
MainLineSelectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MainLineSelectCell
  ((MainLineSelectCell.super).Ctor)(self, ...)
  self.guideEffectHandler = nil
end

MainLineSelectCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Back")
  self._img = self:GetChild("CellImg")
  self._select = self:GetChild("Select")
  ;
  (self._select):SetActive(false)
  self._floor = self:GetChild("Floor")
  self._name = self:GetChild("ChapterName")
  self._guideEffect = self:GetChild("Effect")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

MainLineSelectCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

MainLineSelectCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : ImageTable
  self._data = data
  local image = ImageTable:GetRecorder(data.img)
  if image then
    (self._img):SetSprite(image.assetBundle, image.assetName)
  end
  ;
  (self._floor):SetText(data.floor)
  ;
  (self._name):SetText(data.name)
  ;
  (self._select):SetActive((self._delegate):GetSelectedId() == (self._data).id)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

MainLineSelectCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):OnCellClicked(self._data)
end

MainLineSelectCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if arg ~= (self._data).id then
    (self._select):SetActive(eventName ~= "SetFloorSelectedState")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return MainLineSelectCell

