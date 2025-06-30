-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/resource/resourceselectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local ResourceSelectCell = class("ResourceSelectCell", Dialog)
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
ResourceSelectCell.AssetBundleName = "ui/layouts.mainline"
ResourceSelectCell.AssetName = "ResourceDungeonSelectCell"
ResourceSelectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResourceSelectCell
  ((ResourceSelectCell.super).Ctor)(self, ...)
end

ResourceSelectCell.OnCreate = function(self)
  -- function num : 0_1
  self._back = self:GetChild("Back")
  self._img = self:GetChild("CellImg")
  self._select = self:GetChild("Select")
  ;
  (self._select):SetActive(false)
  self._stage = self:GetChild("Class")
  self._name = self:GetChild("ChapterName")
  self._condition = self:GetChild("Condition")
  self._new = self:GetChild("New")
  self._clear = self:GetChild("Clear")
  ;
  (self._clear):SetActive(false)
  self._grey = self:GetChild("Grey")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

ResourceSelectCell.OnDestroy = function(self)
  -- function num : 0_2
end

ResourceSelectCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : ImageTable, _ENV, CStringRes
  self._data = data
  local image = ImageTable:GetRecorder(data.img)
  if image then
    (self._img):SetSprite(image.assetBundle, image.assetName)
  end
  ;
  (self._stage):SetText(data.stage)
  ;
  (self._name):SetText(data.name)
  if data.lock then
    (self._grey):SetActive(true)
    ;
    (self._condition):SetActive(true)
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1101)).msgTextID)
    ;
    (self._condition):SetText(str)
    ;
    (self._new):SetActive(false)
    ;
    (self._img):SetActive(false)
    ;
    (self._name):SetActive(false)
  else
    do
      ;
      (self._grey):SetActive(false)
      ;
      (self._condition):SetActive(false)
      if data.clear then
        (self._new):SetActive(false)
      else
        ;
        (self._new):SetActive(true)
      end
      ;
      (self._img):SetActive(true)
      ;
      (self._name):SetActive(true)
      ;
      (self._select):SetActive((self._delegate):GetSelectedId() == (self._data).id)
      -- DECOMPILER ERROR: 1 unprocessed JMP targets
    end
  end
end

ResourceSelectCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):OnCellClicked((self._data).id)
end

ResourceSelectCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if arg ~= (self._data).id then
    (self._select):SetActive(eventName ~= "SetFloorSelectedState")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return ResourceSelectCell

