-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equipstrengthen/filtersortcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local FilterSortCell = class("FilterSortCell", Dialog)
FilterSortCell.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterSortCell.AssetName = "BaseCharacterListSortCell"
FilterSortCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FilterSortCell
  ((FilterSortCell.super).Ctor)(self, ...)
  self._wordTable = nil
end

FilterSortCell.OnCreate = function(self)
  -- function num : 0_1
  self._selectBtn = self:GetChild("SelectBtn")
  self._text = self:GetChild("SelectBtn/Txt")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

FilterSortCell.OnDestroy = function(self)
  -- function num : 0_2
end

FilterSortCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local target = nil
  if (self._delegate)._tag == "Sort" then
    target = (self._delegate)._target
    if (self._delegate)._nameId == data.nameid then
      (self._selectBtn):SetSelected(true)
    else
      ;
      (self._selectBtn):SetSelected(false)
    end
  else
    if ((self._delegate)._delegate)._tag == "Filter" then
      target = ((self._delegate)._delegate)._target
      if self:IsInFilterConditions(data.type, data.nameid) then
        (self._selectBtn):SetSelected(true)
      else
        ;
        (self._selectBtn):SetSelected(false)
      end
    end
  end
  if not target or target == "Equip" or target == "EquipStrengthenItem" or target == "EquipEnchantItem" or target == "EquipBook" then
    (self._text):SetText((TextManager.GetText)(data.nameid))
  else
    if target == "Role" then
      (self._text):SetText((TextManager.GetText)(data.nameid))
    else
      if target == "Monster" then
        (self._text):SetText((TextManager.GetText)(data.nameid))
      else
        if target == "SupportRole" then
          (self._text):SetText((TextManager.GetText)(data.nameid))
        end
      end
    end
  end
end

FilterSortCell.IsInFilterConditions = function(self, type, nameId)
  -- function num : 0_4 , upvalues : _ENV
  for k,v in pairs(((self._delegate)._delegate)._conditions) do
    if k == type then
      for _,value in ipairs(v) do
        if value.nameid == nameId then
          return true
        end
      end
    end
  end
  return false
end

FilterSortCell.OnCellClick = function(self)
  -- function num : 0_5
  -- DECOMPILER ERROR at PC14: Unhandled construct in 'MakeBoolean' P1

  if (self._delegate)._tag == "Sort" and (self._cellData).nameid ~= (self._delegate)._nameId then
    (self._delegate):SetSelectedNameId((self._cellData).nameid)
  end
  if ((self._delegate)._delegate)._tag == "Filter" then
    ((self._delegate)._delegate):SetSelectedNameId(self._cellData)
  end
end

FilterSortCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_6
  if eventName == "ChangeSelectNameId" then
    if (self._delegate)._tag == "Sort" then
      if (self._delegate)._nameId == (self._cellData).nameid then
        (self._selectBtn):SetSelected(true)
      else
        ;
        (self._selectBtn):SetSelected(false)
      end
    else
      if ((self._delegate)._delegate)._tag == "Filter" then
        if self:IsInFilterConditions((self._cellData).type, (self._cellData).nameid) then
          (self._selectBtn):SetSelected(true)
        else
          ;
          (self._selectBtn):SetSelected(false)
        end
      end
    end
  end
end

return FilterSortCell

