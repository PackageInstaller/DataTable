local URCardCell = class("URCardCell", Dialog)
URCardCell.AssetBundleName = "ui/layouts.gacha"
URCardCell.AssetName = "GachaResultCell4"

function URCardCell:Ctor(...)
  URCardCell.super.Ctor(self, ...)
  self._backEffectHandler = nil
end

function URCardCell:OnCreate()
  self._photo = self:GetChild("UI/Mask/Photo")
  self._new = self:GetChild("UI/New")
  self._new = self:GetChild("UI/New")
  self._star = self:GetChild("UI/Star")
  self._job = self:GetChild("UI/Job")
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnCellClick, self)
  local random = math.random(1, 3)
  self:GetRootWindow():SetAnimatorTrigger("New Trigger" .. random)
end

function URCardCell:OnDestroy()
end

function URCardCell:RefreshCell(data)
  self._data = data
  if data.role then
    local image = data.role:GetGachaRoleImageRecord()
    self._photo:SetSprite(image.assetBundle, image.assetName)
    self._new:SetActive(data.isNew)
    self._job:SetText(data.role:GetVocationName())
  end
end

function URCardCell:OnCellClick(args)
  local keyTag = self._cellData and self._cellData.keyTag or self._data.keyTag
  self._delegate:CheckRoleInfo(keyTag)
end

function URCardCell:OnEvent(name, args)
  if name == "hidenew" then
    self._new:SetActive(false)
  end
end

function URCardCell:HideNew()
  self._new:SetActive(false)
end

return URCardCell
