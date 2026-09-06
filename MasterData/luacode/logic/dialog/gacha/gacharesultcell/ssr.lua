local SSRCardCell = class("SSRCardCell", Dialog)
SSRCardCell.AssetBundleName = "ui/layouts.gacha"
SSRCardCell.AssetName = "GachaResultCell3"

function SSRCardCell:Ctor(...)
  SSRCardCell.super.Ctor(self, ...)
  self._backEffectHandler = nil
end

function SSRCardCell:OnCreate()
  self._photo = self:GetChild("UI/Mask/Photo")
  self._new = self:GetChild("UI/New")
  self._star = self:GetChild("UI/Star")
  self._job = self:GetChild("UI/Job")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
  local random = math.random(1, 3)
  self:GetRootWindow():SetAnimatorTrigger("New Trigger" .. random)
end

function SSRCardCell:OnDestroy()
end

function SSRCardCell:RefreshCell(data)
  self._data = data
  if data.role then
    local image = data.role:GetGachaRoleImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    self._new:SetActive(data.isNew)
    self._job:SetText(data.role:GetVocationName())
  end
end

function SSRCardCell:OnCellClick(args)
  local keyTag = self._cellData and self._cellData.keyTag or self._data.keyTag
  self._delegate:CheckRoleInfo(keyTag)
end

function SSRCardCell:OnEvent(name, args)
  if name == "hidenew" then
    self._new:SetActive(false)
  end
end

function SSRCardCell:HideNew()
  self._new:SetActive(false)
end

return SSRCardCell
