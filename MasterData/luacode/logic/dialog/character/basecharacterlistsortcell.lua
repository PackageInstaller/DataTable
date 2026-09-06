local CStringRes = BeanManager.GetTableByName("message.cstringres")
local BaseCharacterListSortCell = class("BaseCharacterListSortCell", Dialog)
BaseCharacterListSortCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListSortCell.AssetName = "BaseCharacterListSortCell"

function BaseCharacterListSortCell:Ctor(...)
  BaseCharacterListSortCell.super.Ctor(self, ...)
  self._filter = true
end

function BaseCharacterListSortCell:OnCreate()
  self._btn = self:GetChild("SelectBtn")
  self._text = self:GetChild("SelectBtn/Txt")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function BaseCharacterListSortCell:OnDestroy()
end

function BaseCharacterListSortCell:RefreshCell()
  if self._delegate:GetOperateType() == "sort" or self._delegate:GetOperateType() == "filter" then
    self._text:SetText(TextManager.GetText(self._cellData))
  elseif self._delegate:GetOperateType() == "skillsort" or self._delegate:GetOperateType() == "skillfilter" then
    local str = TextManager.GetText(CStringRes:GetRecorder(self._cellData).msgTextID)
    self._text:SetText(str)
  end
  if self._delegate:GetOperateType() == "sort" or self._delegate:GetOperateType() == "skillsort" then
    self._btn:SetSelected(self._delegate:GetSelect() == self._cellData)
  elseif self._delegate:GetOperateType() == "filter" or self._delegate:GetOperateType() == "skillfilter" then
    self._filter = false
    for _, v in pairs(self._delegate._nameIdListRank) do
      if v == self._cellData then
        self._filter = true
        break
      end
    end
    for _, v in pairs(self._delegate._nameIdListVocation) do
      if v == self._cellData then
        self._filter = true
        break
      end
    end
    self._btn:SetSelected(self._filter)
  end
end

function BaseCharacterListSortCell:OnCellClick()
  LogError("BaseCharacterListSortCell:OnCellClick()")
  if self._delegate:GetOperateType() == "sort" or self._delegate:GetOperateType() == "skillsort" then
    if self._delegate:GetSelect() ~= self._cellData then
      self._btn:SetSelected(true)
      self._delegate:SetSelect(self._cellData)
      self._delegate:OnSortCellClick(self._cellData)
      self._delegate:SetScreenedListTypeTxt(self._text:GetText())
    end
  elseif self._delegate:GetOperateType() == "filter" or self._delegate:GetOperateType() == "skillfilter" then
    if self._cellData ~= 37 and self._cellData ~= 38 then
      if self._filter == false then
        self._filter = true
        self._btn:SetSelected(self._filter)
      else
        self._filter = false
        self._btn:SetSelected(self._filter)
      end
      self._delegate:OnFilterCellClick(self._cellData)
    elseif not self._filter then
      self._delegate:OnFilterCellClick(self._cellData)
    end
  end
end

function BaseCharacterListSortCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    if self._cellData == arg then
      self._btn:SetSelected(true)
    else
      self._btn:SetSelected(false)
    end
  elseif eventName == "Remove" then
    if self._cellData == arg then
      self._filter = false
      self._btn:SetSelected(false)
    end
  elseif eventName == "Insert" and self._cellData == arg then
    self._filter = true
    self._btn:SetSelected(true)
  end
end

return BaseCharacterListSortCell
