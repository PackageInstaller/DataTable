local SRCardCell = class("SRCardCell", Dialog)
SRCardCell.AssetBundleName = "ui/layouts.gacha"
SRCardCell.AssetName = "GachaResultCell2"

function SRCardCell:Ctor(...)
  SRCardCell.super.Ctor(self, ...)
  self._backEffectHandler = nil
end

function SRCardCell:OnCreate()
  self._photo = self:GetChild("UI/Mask/Photo")
  self._new = self:GetChild("UI/New")
  self._new = self:GetChild("UI/New")
  self._star = self:GetChild("UI/Star")
  self._job = self:GetChild("UI/Job")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
  local random = math.random(1, 3)
  self:GetRootWindow():SetAnimatorTrigger("New Trigger" .. random)
end

function SRCardCell:OnDestroy()
end

function SRCardCell:RefreshCell(data)
  self._data = data
  if data.role then
    local image = data.role:GetGachaRoleImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    self._new:SetActive(data.isNew)
    self._job:SetText(data.role:GetVocationName())
  end
end

function SRCardCell:OnCellClick(args)
  local keyTag = self._cellData and self._cellData.keyTag or self._data.keyTag
  self._delegate:CheckRoleInfo(keyTag)
end

function SRCardCell:OnEvent(name, args)
  if name == "hidenew" then
    self._new:SetActive(false)
  end
end

function SRCardCell:HideNew()
  self._new:SetActive(false)
end

return SRCardCell
