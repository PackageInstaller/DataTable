local UniqueEquipSkillCell = class("UniqueEquipSkillCell", Dialog)
UniqueEquipSkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipSkillCell.AssetName = "CharEquipSkillCell"

function UniqueEquipSkillCell:Ctor(...)
  UniqueEquipSkillCell.super.Ctor(self, ...)
end

function UniqueEquipSkillCell:OnCreate()
  self._unlockPanel = self:GetChild("Back/Unlock")
  self._unlockPanel_txt1 = self:GetChild("Back/Unlock/Txt1")
  self._unlockPanel_effect = self:GetChild("Back/Unlock/Txt3")
  self._normalPanel = self:GetChild("Back/Level")
  self._normalPanel_lv = self:GetChild("Back/Level/Num")
  self._normalPanel_effect = self:GetChild("Back/Level/Txt3")
  self._unlockPanel_effect_x, self._unlockPanel_effect_y = self._unlockPanel_effect:GetAnchoredPosition()
  self._unlockPanel_effect_width, self._unlockPanel_effect_height = self._unlockPanel_effect:GetRectSize()
  self._unlockPanel_effect_anchorMinX, self._unlockPanel_effect_anchorMinY, self._unlockPanel_effect_anchorMaxX, self._unlockPanel_effect_anchorMaxY, self._unlockPanel_effect_offsetMinX, self._unlockPanel_effect_offsetMinY, self._unlockPanel_effect_offsetMaxX, self._unlockPanel_effect_offsetMaxY = self._unlockPanel_effect:GetAnchorAndOffset()
  self._normalPanel_effect_x, self._normalPanel_effect_y = self._normalPanel_effect:GetAnchoredPosition()
  self._normalPanel_effect_width, self._normalPanel_effect_height = self._normalPanel_effect:GetRectSize()
  self._normalPanel_effect_anchorMinX, self._normalPanel_effect_anchorMinY, self._normalPanel_effect_anchorMaxX, self._normalPanel_effect_anchorMaxY, self._normalPanel_effect_offsetMinX, self._normalPanel_effect_offsetMinY, self._normalPanel_effect_offsetMaxX, self._normalPanel_effect_offsetMaxY = self._normalPanel_effect:GetAnchorAndOffset()
  self._rootWindow_width, self._rootWindow_height = self._rootWindow:GetDeltaSize()
end

function UniqueEquipSkillCell:OnDestroy()
end

function UniqueEquipSkillCell:RefreshCell(data)
  local extraSkillDestribe = self._delegate._uniqueEquipItem:GetExtraSkillDestribeByLevel(data.uniqueEquipLv)
  if data.uniqueEquipLv == 1 then
    self._unlockPanel:SetActive(true)
    self._normalPanel:SetActive(false)
    self._unlockPanel_txt1:SetText(NekoData.BehaviorManager.BM_Message:GetString(1559))
    self._unlockPanel_effect:SetText(NekoData.BehaviorManager.BM_Message:GetUniqueEquipSkillDescribe(data.skillId) .. extraSkillDestribe)
    local _, textheight = self._unlockPanel_effect:GetPreferredSize()
    if textheight > self._unlockPanel_effect_height then
      local delta = textheight - self._unlockPanel_effect_height
      self._unlockPanel_effect:SetAnchorAndOffset(self._unlockPanel_effect_anchorMinX, self._unlockPanel_effect_anchorMinY, self._unlockPanel_effect_anchorMaxX, self._unlockPanel_effect_anchorMaxY, self._unlockPanel_effect_offsetMinX, self._unlockPanel_effect_offsetMinY - delta, self._unlockPanel_effect_offsetMaxX, self._unlockPanel_effect_offsetMaxY)
      self._rootWindow:SetDeltaSize(self._rootWindow_width, self._rootWindow_height + delta)
    else
      self._unlockPanel_effect:SetAnchorAndOffset(self._unlockPanel_effect_anchorMinX, self._unlockPanel_effect_anchorMinY, self._unlockPanel_effect_anchorMaxX, self._unlockPanel_effect_anchorMaxY, self._unlockPanel_effect_offsetMinX, self._unlockPanel_effect_offsetMinY, self._unlockPanel_effect_offsetMaxX, self._unlockPanel_effect_offsetMaxY)
      self._rootWindow:SetDeltaSize(self._rootWindow_width, self._rootWindow_height)
    end
    self._unlockPanel_effect:SetAnchoredPosition(self._unlockPanel_effect_x, self._unlockPanel_effect_y)
  else
    self._unlockPanel:SetActive(false)
    self._normalPanel:SetActive(true)
    self._normalPanel_lv:SetText(NekoData.BehaviorManager.BM_Message:GetString(1560, {
      data.uniqueEquipLv
    }))
    self._normalPanel_effect:SetText(NekoData.BehaviorManager.BM_Message:GetUniqueEquipSkillDescribe(data.skillId) .. extraSkillDestribe)
    local _, textheight = self._normalPanel_effect:GetPreferredSize()
    if textheight > self._normalPanel_effect_height then
      local delta = textheight - self._normalPanel_effect_height
      self._normalPanel_effect:SetAnchorAndOffset(self._normalPanel_effect_anchorMinX, self._normalPanel_effect_anchorMinY, self._normalPanel_effect_anchorMaxX, self._normalPanel_effect_anchorMaxY, self._normalPanel_effect_offsetMinX, self._normalPanel_effect_offsetMinY, self._normalPanel_effect_offsetMaxX, self._normalPanel_effect_offsetMaxY + delta)
      self._rootWindow:SetDeltaSize(self._rootWindow_width, self._rootWindow_height + delta)
    else
      self._normalPanel_effect:SetAnchorAndOffset(self._normalPanel_effect_anchorMinX, self._normalPanel_effect_anchorMinY, self._normalPanel_effect_anchorMaxX, self._normalPanel_effect_anchorMaxY, self._normalPanel_effect_offsetMinX, self._normalPanel_effect_offsetMinY, self._normalPanel_effect_offsetMaxX, self._normalPanel_effect_offsetMaxY)
      self._rootWindow:SetDeltaSize(self._rootWindow_width, self._rootWindow_height)
    end
    self._normalPanel_effect:SetAnchoredPosition(self._normalPanel_effect_x, self._normalPanel_effect_y)
  end
end

return UniqueEquipSkillCell
