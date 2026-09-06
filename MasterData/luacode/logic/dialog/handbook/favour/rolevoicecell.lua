local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local RoleVoiceCell = class("RoleVoiceCell", Dialog)
RoleVoiceCell.AssetBundleName = "ui/layouts.tujian"
RoleVoiceCell.AssetName = "CharVoiceCell"

function RoleVoiceCell:Ctor(...)
  RoleVoiceCell.super.Ctor(self, ...)
end

function RoleVoiceCell:OnCreate()
  self._normal = self:GetChild("Normal")
  self._normal_name = self:GetChild("Normal/VoiceBack/Txt")
  self._playBtn = self:GetChild("Normal/VoiceBtn")
  self._canUnlockPanel = self:GetChild("UnLock")
  self._canUnlockPanel_btn = self:GetChild("UnLock/UnLockBtn")
  self._lockPanel = self:GetChild("Lock")
  self._lockPanel_heartInfo = {}
  for i = 1, 5 do
    self._lockPanel_heartInfo[i] = {}
    self._lockPanel_heartInfo[i].back = self:GetChild("Lock/Heart" .. i .. "Back")
    self._lockPanel_heartInfo[i].light = self:GetChild("Lock/Heart" .. i)
  end
  self._unlockCondition = self:GetChild("Lock/Detail")
  self._rootWindow:Subscribe_PointerClickEvent(self.OnPlayBtnClick, self)
  self._canUnlockPanel_btn:Subscribe_PointerClickEvent(self.OnUnlockBtnClick, self)
end

function RoleVoiceCell:OnDestroy()
end

function RoleVoiceCell:RefreshCell(data)
  if data.tag == "Favour" then
    if data.reward.received then
      self._normal:SetActive(true)
      self._playBtn:SetActive(true)
      self._canUnlockPanel:SetActive(false)
      self._lockPanel:SetActive(false)
      self._normal_name:SetText(TextManager.GetText(data.titleId))
    elseif data.reward.favourLv <= self._delegate._favourLv then
      self._normal:SetActive(true)
      self._playBtn:SetActive(false)
      self._canUnlockPanel:SetActive(true)
      self._lockPanel:SetActive(false)
      self._normal_name:SetText(TextManager.GetText(data.titleId))
    else
      self._normal:SetActive(false)
      self._canUnlockPanel:SetActive(false)
      self._lockPanel:SetActive(true)
      self._unlockCondition:SetText(string.gsub(TextManager.GetText(502721), "%$parameter1%$", data.reward.favourLv))
      local maxHeartNum = self._delegate._maxHeartNum
      local record = CFavourExp:GetRecorder(data.reward.favourLv)
      local curHeartNum = record.heartnum / 10
      local integer, decimal = math.modf(curHeartNum)
      for i, v in ipairs(self._lockPanel_heartInfo) do
        if i > maxHeartNum then
          v.back:SetActive(false)
          v.light:SetActive(false)
        elseif curHeartNum > i - 1 and i > curHeartNum then
          v.light:SetFillAmount(decimal)
        elseif i <= curHeartNum then
          v.light:SetFillAmount(1)
        else
          v.light:SetFillAmount(0)
        end
      end
    end
  else
    self._normal:SetActive(true)
    self._playBtn:SetActive(true)
    self._canUnlockPanel:SetActive(false)
    self._lockPanel:SetActive(false)
    self._normal_name:SetText(TextManager.GetText(data.titleId))
  end
end

function RoleVoiceCell:OnPlayBtnClick()
  if self._cellData.tag == "Favour" and self._cellData.reward.received or self._cellData.tag == "Other" then
    local dialog = DialogManager.GetDialog("handbook.roledetailinfodialog") or DialogManager.GetDialog("handbook.handbooksceneroledetailinfodialog")
    if dialog then
      if self._cellData.tag == "Favour" then
        dialog:SetVoiceAndLines2(self._delegate._roleId, nil, NekoData.BehaviorManager.BM_Voice.HandbookVoiceType.relationVoice, self._cellData.voiceIndex, self._cellData.contentId, self._cellData.animation, true)
      else
        dialog:SetVoiceAndLines2(self._delegate._roleId, nil, NekoData.BehaviorManager.BM_Voice.HandbookVoiceType.otherVoice, self._cellData.voiceIndex, self._cellData.contentId, self._cellData.animation, true)
      end
    end
  end
end

function RoleVoiceCell:OnUnlockBtnClick()
  local csend = LuaNetManager.CreateProtocol("protocol.good.creceiveaward")
  csend.roleId = self._delegate._roleId
  csend.level = self._cellData.reward.favourLv
  csend:Send()
end

return RoleVoiceCell
