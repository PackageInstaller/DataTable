-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharacterlistselectcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BaseCharacterListSelectCell = class("BaseCharacterListSelectCell", Dialog)
BaseCharacterListSelectCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListSelectCell.AssetName = "BaseCharacterListSelectCell"
BaseCharacterListSelectCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharacterListSelectCell
  ((BaseCharacterListSelectCell.super).Ctor)(self, ...)
end

BaseCharacterListSelectCell.OnCreate = function(self)
  -- function num : 0_1
  self._select = self:GetChild("Select")
  self._text = self:GetChild("Text")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

BaseCharacterListSelectCell.OnDestroy = function(self)
  -- function num : 0_2
end

BaseCharacterListSelectCell.RefreshCell = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._text):SetText((TextManager.GetText)(self._cellData))
  ;
  (self._select):SetActive(false)
  for _,v in pairs((self._delegate)._nameIdList) do
    if v == self._cellData then
      (self._select):SetActive(true)
      break
    end
  end
end

BaseCharacterListSelectCell.OnCellClick = function(self)
  -- function num : 0_4
  (self._delegate):OnVocationTabCellClick(self._cellData)
end

return BaseCharacterListSelectCell

