local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local CBannerAndEntrance = BeanManager.GetTableByName("activity.cbannerandentrance")
local BaseActivityIconCell = class("BaseActivityIconCell", Dialog)
BaseActivityIconCell.AssetBundleName = "ui/layouts.basemainhud"
BaseActivityIconCell.AssetName = "BaseActivityIcon"

function BaseActivityIconCell:Ctor(...)
  BaseActivityIconCell.super.Ctor(self, ...)
  self._cellData = nil
end

function BaseActivityIconCell:OnCreate()
  self._icon = self:GetChild("ActivityIcon")
  self._name = self:GetChild("ActivityIcon/Text")
  self._RedDot = self:GetChild("ActivityIcon/RedDot")
  self._leftTime = self:GetChild("ActivityIcon/Time")
  self._effect = self:GetChild("ActivityIcon/Effect")
  self._effectHandler = nil
  self._icon:Subscribe_PointerClickEvent(self.OnIconClicked, self)
end

function BaseActivityIconCell:OnDestroy()
end

function BaseActivityIconCell:RefreshCell(data)
  self._cellData = data
  local leftTime = data.leftTime
  local leftHourNumber = leftTime / 1000.0 / 3600.0
  local leftDayNumber = leftHourNumber / 24.0
  self._cellData.leftHourNumber = leftHourNumber
  self._cellData.leftDayNumber = leftDayNumber
  local record = data.record
  local spriteRecord = CImagePath:GetRecorder(self._cellData.record.pictureID)
  if spriteRecord then
    self._icon:SetSprite(spriteRecord.assetBundle, spriteRecord.assetName)
  end
  self._name:SetText(TextManager.GetText(record.activityTextID))
  self._RedDot:SetActive(data.showRedDot)
  self:RefreshTime()
  if record.effectsID > 0 then
    if self._effectHandler ~= nil then
      self._effect:ReleaseEffect(self._effectHandler)
    end
    self._effectHandler = self._effect:AddEffectSync(EffectUtil.GetAssetBundleNameAndAssetName(record.effectsID))
  elseif self._effectHandler ~= nil then
    self._effect:ReleaseEffect(self._effectHandler)
  end
end

function BaseActivityIconCell:RefreshTime()
  local leftTime = self._cellData.leftTime
  local leftHourNumber = leftTime / 1000.0 / 3600.0
  local leftDayNumber = leftHourNumber / 24.0
  leftDayNumber = math.floor(leftDayNumber)
  leftHourNumber = math.floor(leftHourNumber)
  if leftDayNumber < 1 then
    if self._cellData.leftHourNumber ~= leftHourNumber then
      local leftHourNumberText = TextManager.GetText(701627)
      leftHourNumberText = string.gsub(leftHourNumberText, "%$parameter1%$", leftHourNumber)
      self._leftTime:SetText(leftHourNumberText)
    end
  elseif self._cellData.leftDayNumber ~= leftDayNumber then
    local leftDayNumberText = TextManager.GetText(701626)
    leftDayNumberText = string.gsub(leftDayNumberText, "%$parameter1%$", leftDayNumber)
    self._leftTime:SetText(leftDayNumberText)
  end
end

function BaseActivityIconCell:OnEvent(eventName)
  self:RefreshTime()
end

function BaseActivityIconCell:OnIconClicked()
  NekoData.BehaviorManager.BM_Activity:EnterActivityById(self._cellData.id)
end

return BaseActivityIconCell
