local CFavourExp = BeanManager.GetTableByName("role.cfavourexp")
local CFavourSkill = BeanManager.GetTableByName("role.cfavourskill")
local CFavourGiftType = BeanManager.GetTableByName("role.cfavourgifttype")
local FavourGiftCell = class("FavourGiftCell", Dialog)
FavourGiftCell.AssetBundleName = "ui/layouts.tujian"
FavourGiftCell.AssetName = "FavourGiftCell"

function FavourGiftCell:Ctor(...)
  FavourGiftCell.super.Ctor(self, ...)
end

function FavourGiftCell:OnCreate()
  self._favourLvTxt = self:GetChild("LevelNum")
  self._normalPanel = self:GetChild("Normal")
  self._normalPanel_effectTxt = self:GetChild("Normal/Txt")
  self._normalPanel_gotBtn = self:GetChild("Normal/GetBtn1")
  self._normalPanel_unlockBtn = self:GetChild("Normal/GetBtn")
  self._lockPanel = self:GetChild("Lock")
  self._normalPanel_unlockBtn:Subscribe_PointerClickEvent(self.OnUnlockBtnClick, self)
end

function FavourGiftCell:OnDestroy()
end

local function GetString(self)
  local rewardType = self._cellData.rewardType
  local rewardId = self._cellData.rewardId
  if rewardType == DataCommon.Favour.Skill then
    local record = CFavourSkill:GetRecorder(rewardId)
    return TextManager.GetText(record.skillattributiontxt)
  elseif rewardType == DataCommon.Favour.BackgroundStory then
    local record = CFavourGiftType:GetRecorder(rewardType)
    return TextManager.GetText(record.storyandlineid[rewardId])
  elseif rewardType == DataCommon.Favour.Voice then
    local record = CFavourGiftType:GetRecorder(rewardType)
    return TextManager.GetText(record.storyandlineid[rewardId])
  end
end

function FavourGiftCell:RefreshCell(data)
  self._favourLvTxt:SetText(data.favourLv)
  if data.favourLv > self._delegate._curFavourLv then
    self._normalPanel:SetActive(false)
    self._lockPanel:SetActive(true)
  else
    self._normalPanel:SetActive(true)
    self._lockPanel:SetActive(false)
    self._normalPanel_effectTxt:SetText(GetString(self))
    if data.received then
      self._normalPanel_gotBtn:SetActive(true)
      self._normalPanel_unlockBtn:SetActive(false)
    else
      self._normalPanel_gotBtn:SetActive(false)
      self._normalPanel_unlockBtn:SetActive(true)
    end
  end
end

function FavourGiftCell:OnUnlockBtnClick()
  local rewardType = self._cellData.rewardType
  local csend = LuaNetManager.CreateProtocol("protocol.good.creceiveaward")
  csend.roleId = self._delegate._role:GetId()
  csend.level = self._cellData.favourLv
  csend:Send()
end

return FavourGiftCell
