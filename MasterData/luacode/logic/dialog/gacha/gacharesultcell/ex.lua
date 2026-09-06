local ExCardCell = class("ExCardCell", Dialog)
ExCardCell.AssetBundleName = "ui/layouts.gacha"
ExCardCell.AssetName = "GachaResultCell5"

function ExCardCell:Ctor(...)
  ExCardCell.super.Ctor(self, ...)
  self._backEffectHandler = nil
end

function ExCardCell:OnCreate()
  self._photo = self:GetChild("UI/Mask/Photo")
  self._new = self:GetChild("UI/New")
  self._new = self:GetChild("UI/New")
  self._star = self:GetChild("UI/Star")
  self._job = self:GetChild("UI/Job")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
  local random = math.random(1, 3)
  self:GetRootWindow():SetAnimatorTrigger("New Trigger" .. random)
end

function ExCardCell:OnDestroy()
end

function ExCardCell:RefreshCell(data)
  self._data = data
  if data.role then
    local image = data.role:GetGachaRoleImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    self._new:SetActive(data.isNew)
    self._job:SetText(data.role:GetVocationName())
  end
end

function ExCardCell:OnCellClick(args)
  local keyTag = self._cellData and self._cellData.keyTag or self._data.keyTag
  self._delegate:CheckRoleInfo(keyTag)
end

function ExCardCell:OnEvent(name, args)
  if name == "hidenew" then
    self._new:SetActive(false)
  end
end

function ExCardCell:HideNew()
  self._new:SetActive(false)
end

return ExCardCell
