local CStringRes = BeanManager.GetTableByName("message.cstringres")
local FilterSortCell = class("FilterSortCell", Dialog)
FilterSortCell.AssetBundleName = "ui/layouts.basecharacterinfo"
FilterSortCell.AssetName = "BaseCharacterListSortCell"

function FilterSortCell:Ctor(...)
  FilterSortCell.super.Ctor(self, ...)
  self._wordTable = nil
end

function FilterSortCell:OnCreate()
  self._selectBtn = self:GetChild("SelectBtn")
  self._text = self:GetChild("SelectBtn/Txt")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function FilterSortCell:OnDestroy()
end

function FilterSortCell:RefreshCell(data)
  local target
  if self._delegate._tag == "Sort" then
    target = self._delegate._target
    if self._delegate._nameId == data.nameid then
      self._selectBtn:SetSelected(true)
    else
      self._selectBtn:SetSelected(false)
    end
  elseif self._delegate._delegate._tag == "Filter" then
    target = self._delegate._delegate._target
    if self:IsInFilterConditions(data.type, data.nameid) then
      self._selectBtn:SetSelected(true)
    else
      self._selectBtn:SetSelected(false)
    end
  end
  if not target or target == "Equip" or target == "EquipStrengthenItem" or target == "EquipEnchantItem" or target == "EquipBook" then
    self._text:SetText(TextManager.GetText(data.nameid))
  elseif target == "Role" then
    self._text:SetText(TextManager.GetText(data.nameid))
  elseif target == "Monster" then
    self._text:SetText(TextManager.GetText(data.nameid))
  elseif target == "SupportRole" then
    self._text:SetText(TextManager.GetText(data.nameid))
  end
end

function FilterSortCell:IsInFilterConditions(type, nameId)
  for k, v in pairs(self._delegate._delegate._conditions) do
    if k == type then
      for _, value in ipairs(v) do
        if value.nameid == nameId then
          return true
        end
      end
    end
  end
  return false
end

function FilterSortCell:OnCellClick()
  if self._delegate._tag == "Sort" then
    if self._cellData.nameid ~= self._delegate._nameId then
      self._delegate:SetSelectedNameId(self._cellData.nameid)
    end
  elseif self._delegate._delegate._tag == "Filter" then
    self._delegate._delegate:SetSelectedNameId(self._cellData)
  end
end

function FilterSortCell:OnEvent(eventName, arg)
  if eventName == "ChangeSelectNameId" then
    if self._delegate._tag == "Sort" then
      if self._delegate._nameId == self._cellData.nameid then
        self._selectBtn:SetSelected(true)
      else
        self._selectBtn:SetSelected(false)
      end
    elseif self._delegate._delegate._tag == "Filter" then
      if self:IsInFilterConditions(self._cellData.type, self._cellData.nameid) then
        self._selectBtn:SetSelected(true)
      else
        self._selectBtn:SetSelected(false)
      end
    end
  end
end

return FilterSortCell
