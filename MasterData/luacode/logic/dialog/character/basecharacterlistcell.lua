local BaseCharacterListCell = class("BaseCharacterListCell", Dialog)
BaseCharacterListCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharacterListCell.AssetName = "BaseCharacterListCell"

function BaseCharacterListCell:Ctor(...)
  BaseCharacterListCell.super.Ctor(self, ...)
  self._data = nil
end

function BaseCharacterListCell:OnCreate()
  self._back = self:GetChild("CharacterCell/_Back")
  self._photo = self:GetChild("CharacterCell/_Photo")
  self._rank = self:GetChild("CharacterCell/_Rank")
  self._lock = self:GetChild("CharacterCell/_Lock")
  self._level = self:GetChild("CharacterCell/_Level/Num")
  self._maxLevel = self:GetChild("CharacterCell/_Level/MaxNum")
  self._select = self:GetChild("CharacterCell/_Select")
  self._job = self:GetChild("CharacterCell/_Job")
  self._team = self:GetChild("CharacterCell/_Team")
  self._frame = self:GetChild("CharacterCell/_Frame")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

function BaseCharacterListCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BaseCharacterListCell:RefreshCell(data)
  self._data = data
  self._back:SetSprite(data:GetRarityBackRecord().assetBundle, data:GetRarityBackRecord().assetName)
  self._photo:SetSprite(data:GetShapeBustImageRecord().assetBundle, data:GetShapeBustImageRecord().assetName)
  if data:GetIsLeader() then
    self._rank:SetActive(false)
  else
    self._rank:SetActive(true)
    self._rank:SetSprite(data:GetRarityImageRecord().assetBundle, data:GetRarityImageRecord().assetName)
  end
  self._job:SetSprite(data:GetVocationImageRecord().assetBundle, data:GetVocationImageRecord().assetName)
  self._frame:SetSprite(data:GetRarityFrameRecord().assetBundle, data:GetRarityFrameRecord().assetName)
  self._lock:SetActive(data:GetIsLock())
  self._select:SetActive(self._delegate:GetSelectRole() == data:GetRoleId())
  self._level:SetText(data:GetLevel())
  self._maxLevel:SetText(data:GetMaxLevelIgnorePlayerLv())
end

function BaseCharacterListCell:OnCellClicked()
  if self._delegate:GetSelectRole() ~= self._cellData:GetRoleId() then
    self._select:SetActive(true)
    self._delegate:SetSelectRole(self._cellData:GetRoleId())
  else
    local dialog = DialogManager.CreateSingletonDialog("character.newcharacterinfodialog")
    if dialog then
      dialog:Refresh(self._data)
    end
  end
end

function BaseCharacterListCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    if self._cellData:GetRoleId() == arg then
      self._select:SetActive(true)
      self._delegate:Refresh(self._cellData)
    else
      self._select:SetActive(false)
    end
  elseif eventName == "RemoveAll" then
  end
end

return BaseCharacterListCell
