local EvolveMaterialCell = class("EvolveMaterialCell", Dialog)
EvolveMaterialCell.AssetBundleName = "ui/layouts.basecharacterinfo"
EvolveMaterialCell.AssetName = "BaseCharacterInfoEvolveCell"

function EvolveMaterialCell:Ctor(...)
  EvolveMaterialCell.super.Ctor(self, ...)
  self._choose = false
end

function EvolveMaterialCell:OnCreate()
  self._photoGrey = self:GetChild("CharacterCell/PhotoGrey")
  self._photo = self:GetChild("CharacterCell/Photo")
  self._frame = self:GetChild("CharacterCell/Frame")
  self._select = self:GetChild("CharacterCell/Select")
  self._rank = self:GetChild("CharacterCell/Rank")
  self._job = self:GetChild("CharacterCell/Job")
  self._num = self:GetChild("CharacterCell/Down/Level/Num")
  self._maxNum = self:GetChild("CharacterCell/Down/Level/MaxNum")
  self._lockImg = self:GetChild("CharacterCell/Lock")
  self._teamImg = self:GetChild("CharacterCell/Team")
  self._select:SetActive(false)
  self._photoGrey:SetActive(false)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
end

function EvolveMaterialCell:OnDestroy()
end

function EvolveMaterialCell:RefreshCell(data)
  self._photo:SetSprite(data:GetShapeBustImageRecord().assetBundle, data:GetShapeBustImageRecord().assetName)
  self._frame:SetSprite(data:GetRarityFrameRecord().assetBundle, data:GetRarityFrameRecord().assetName)
  self._rank:SetSprite(data:GetRarityImageRecord().assetBundle, data:GetRarityImageRecord().assetName)
  self._job:SetSprite(data:GetVocationImageRecord().assetBundle, data:GetVocationImageRecord().assetName)
  self._num:SetText(tostring(data:GetLevel()))
  self._maxNum:SetText(tostring(data:GetMaxLevelIgnorePlayerLv()))
  self._lock = data:GetIsLock()
  self._isInTeams = data:IsInTeams()
  if self._lock then
    self._lockImg:SetActive(true)
  else
    self._lockImg:SetActive(false)
  end
  if self._isInTeams then
    self._teamImg:SetActive(true)
  else
    self._teamImg:SetActive(false)
  end
  self._choose = false
  self._select:SetActive(false)
  for _, v in pairs(self._delegate._selectList) do
    if v:GetRoleId() == self._cellData:GetRoleId() then
      self._select:SetActive(true)
      self._choose = true
      break
    end
  end
  if not (self._delegate._chooseNum ~= self._delegate._chooseNumMax or self._choose) or self._lock or self._isInTeams then
    self._photoGrey:SetActive(true)
  else
    self._photoGrey:SetActive(false)
  end
end

function EvolveMaterialCell:OnCellClick()
  if not self._lock and not self._isInTeams then
    for _, v in pairs(self._delegate._selectList) do
      if v:GetRoleId() == self._cellData:GetRoleId() then
        self._select:SetActive(true)
        self._choose = true
        break
      end
    end
    if self._choose then
      self._choose = not self._choose
      self._select:SetActive(self._choose)
      self._delegate:SubRole(self._cellData)
    elseif self._delegate._chooseNum < self._delegate._chooseNumMax then
      self._choose = not self._choose
      self._select:SetActive(self._choose)
      self._delegate:AddRole(self._cellData)
    end
  end
end

function EvolveMaterialCell:OnEvent(eventName, arg)
  if eventName == "ChangedSelected" then
    self._choose = false
    self._select:SetActive(false)
    for _, v in pairs(self._delegate._selectList) do
      if v:GetRoleId() == self._cellData:GetRoleId() then
        self._select:SetActive(true)
        self._choose = true
        break
      end
    end
    if not (self._delegate._chooseNum ~= self._delegate._chooseNumMax or self._choose) or self._lock or self._isInTeams then
      self._photoGrey:SetActive(true)
    else
      self._photoGrey:SetActive(false)
    end
  end
end

return EvolveMaterialCell
