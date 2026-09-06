local CFlowerWordConfig = BeanManager.GetTableByName("activity.cflowerword")
local GiveFlowerDialog = class("GiveFlowerDialog", Dialog)
GiveFlowerDialog.AssetBundleName = "ui/layouts.flower"
GiveFlowerDialog.AssetName = "FlowerSend"

function GiveFlowerDialog:Ctor(...)
  GiveFlowerDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function GiveFlowerDialog:OnCreate()
  self._titleTxt = self:GetChild("Back/Txt1")
  self._flowerNum = self:GetChild("Back/Name")
  local numTab = {
    1,
    11,
    99,
    365,
    999
  }
  for i = 1, 5 do
    self:GetChild("Back/Btn" .. i):Subscribe_PointerClickEvent(function()
      self:OnNumBtnClicked(numTab[i])
    end)
  end
  self._numEdit = self:GetChild("Back/EditSendNum/InputField")
  self._meaningTxt = self:GetChild("Back/Meaning/Txt")
  self._confirmBtn = self:GetChild("Back/ConfirmButton")
  self._closeBtn = self:GetChild("CloseBtn")
  self._numEdit:Subscribe_ValueChangedEvent(self.OnNumUpdate, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.Destroy, self)
end

function GiveFlowerDialog:SetData(roleid, roleName, flowerNum)
  self._roleID = roleid
  self._titleTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(2263, {roleName}))
  local allIds = CFlowerWordConfig:GetAllIds()
  self._randomWordId = math.random(#allIds)
  local wordCfg = CFlowerWordConfig:GetRecorder(self._randomWordId)
  self._meaningTxt:SetText(TextManager.GetText(wordCfg.wordid))
  self._hasFlowerNum = flowerNum
  self._flowerNum:SetText(NekoData.BehaviorManager.BM_Message:GetString(2272, {
    self._hasFlowerNum
  }))
  self._numEdit:SetText("1")
end

function GiveFlowerDialog:OnNumBtnClicked(num)
  local _num = math.min(self._hasFlowerNum, num)
  self._numEdit:SetText(tostring(_num))
end

function GiveFlowerDialog:OnNumUpdate()
  local num = tonumber(self._numEdit:GetText())
  if num > self._hasFlowerNum then
    self._numEdit:SetText(tostring(self._hasFlowerNum))
  end
end

function GiveFlowerDialog:OnConfirmBtnClicked()
  local flowerActInfo = NekoData.BehaviorManager.BM_Activity:GetFlowerActInfo()
  if not flowerActInfo then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100033)
  else
    local p = LuaNetManager.CreateProtocol("protocol.activity.floweract.csendflowers")
    p.targetRoleId = self._roleID
    p.num = tonumber(self._numEdit:GetText())
    p.msgId = self._randomWordId
    p:Send()
  end
  self:Destroy()
end

return GiveFlowerDialog
