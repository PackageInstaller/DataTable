local RCardCell = class("RCardCell", Dialog)
RCardCell.AssetBundleName = "ui/layouts.gacha"
RCardCell.AssetName = "GachaResultCell1"

function RCardCell:Ctor(...)
  RCardCell.super.Ctor(self, ...)
  self._backEffectHandler = nil
end

function RCardCell:OnCreate()
  self._photo = self:GetChild("UI/Mask/Photo")
  self._new = self:GetChild("UI/New")
  self._new = self:GetChild("UI/New")
  self._star = self:GetChild("UI/Star")
  self._job = self:GetChild("UI/Job")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
  local random = math.random(1, 3)
  self:GetRootWindow():SetAnimatorTrigger("New Trigger" .. random)
end

function RCardCell:OnDestroy()
end

function RCardCell:RefreshCell(data)
  self._data = data
  if data.role then
    local image = data.role:GetGachaRoleImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    self._new:SetActive(data.isNew)
    self._job:SetText(data.role:GetVocationName())
  end
end

function RCardCell:OnCellClick(args)
  local keyTag = self._cellData and self._cellData.keyTag or self._data.keyTag
  self._delegate:CheckRoleInfo(keyTag)
end

function RCardCell:OnEvent(name, args)
  if name == "hidenew" then
    self._new:SetActive(false)
  end
end

function RCardCell:HideNew()
  self._new:SetActive(false)
end

return RCardCell
