local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local CGuildHead = BeanManager.GetTableByName("guild.cguildhead")
local CImagePath = BeanManager.GetTableByName("ui.cimagepath")
local MaxWordCount_Name, MinWordCount_Name = NekoData.BehaviorManager.BM_Game:GetUpAndDownLimitsByFuncId(DataCommon.TextLimit.GuildName)
local MaxWordCount_Intro, MinWordCount_Intro = NekoData.BehaviorManager.BM_Game:GetUpAndDownLimitsByFuncId(DataCommon.TextLimit.GuildIntroduction)
local GuildCreateDialog = class("GuildCreateDialog", Dialog)
GuildCreateDialog.AssetBundleName = "ui/layouts.guild"
GuildCreateDialog.AssetName = "GuildCreate"

function GuildCreateDialog:Ctor(...)
  GuildCreateDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
  self._cost = 0
  self._autoPass = 0
  self._avatarId = 1
end

function GuildCreateDialog:OnCreate()
  self._logo = self:GetChild("Back/Logo")
  self._logoChangeButton = self:GetChild("Back/ChangeButton")
  self._logoName = self:GetChild("Back/ChangeButton/Text2")
  self._nameInput = self:GetChild("Back/InputField1")
  self:GetChild("Back/InputField1/_Placeholder"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1571, {MaxWordCount_Name}))
  self._introTextInput = self:GetChild("Back/InputField2")
  self._introWordCount = self:GetChild("Back/Num/Textnew1")
  self._toggleNoNeedCheck = self:GetChild("Back/ToggleGroup/_Toggle_0")
  self._toggleNeedCheck = self:GetChild("Back/ToggleGroup/_Toggle_1")
  self._needNoneyCount = self:GetChild("Back/Need/Num")
  self._cancelButton = self:GetChild("Back/CancelButton")
  self._confirmButton = self:GetChild("Back/ConfirmButton")
  self._toggleNoNeedCheck:Subscribe_ValueChangedEvent(self.OnNeedCheckChange, self)
  self._toggleNeedCheck:Subscribe_ValueChangedEvent(self.OnNeedCheckChange, self)
  self._cancelButton:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmButton:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  self._nameInput:Subscribe_ValueChangedEvent(self.OnNameInputValueChanged, self)
  self._introTextInput:Subscribe_ValueChangedEvent(self.OnIntroTextInputValueChanged, self)
  self._logo:Subscribe_PointerClickEvent(self.OnLogoClicked, self)
  self._logoChangeButton:Subscribe_PointerClickEvent(self.OnLogoClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnSOpenParty, Common.n_OnSOpenParty, nil)
  self:OnIntroTextInputValueChanged()
end

function GuildCreateDialog:OnDestroy()
end

function GuildCreateDialog:Init(cost)
  self._cost = cost
  self._autoPass = 1
  self._needNoneyCount:SetText(cost)
  local allId = CGuildHead:GetAllIds()
  local randomIndex = math.random(1, #allId)
  local randomRecorder = CGuildHead:GetRecorder(allId[randomIndex])
  self:SetHead(randomRecorder)
end

function GuildCreateDialog:OnBackBtnClicked()
  self:Destroy()
end

function GuildCreateDialog:OnConfirmBtnClicked()
  local name = self._nameInput:GetText()
  if #name == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100271)
    return
  end
  if NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SoulDropID) < self._cost then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100332)
    return
  end
  if string.utf8len(self._nameInput:GetText()) > MaxWordCount_Name then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100274)
    return
  end
  if string.utf8len(self._introTextInput:GetText()) > MaxWordCount_Intro then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100274)
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.party.choldparty")
  if csend then
    csend.partyName = self._nameInput:GetText()
    csend.partyDeclaration = self._introTextInput:GetText()
    csend.autoAcceptApply = self._autoPass
    csend.avatarId = self._avatarId
    csend:Send()
  end
end

function GuildCreateDialog:OnNeedCheckChange()
  if self._toggleNoNeedCheck:GetIsOnType() then
    self._autoPass = 1
  else
    self._autoPass = 0
  end
end

function GuildCreateDialog:OnIntroTextInputValueChanged()
  local str = self._introTextInput:GetText()
  self._introTextInput:SetText(str)
  local count = utf8.len(str)
  if count > MaxWordCount_Intro then
    self._introWordCount:SetText(NekoData.BehaviorManager.BM_Message:GetString(1570, {count, MaxWordCount_Intro}))
  else
    self._introWordCount:SetText(NekoData.BehaviorManager.BM_Message:GetString(1569, {count, MaxWordCount_Intro}))
  end
end

function GuildCreateDialog:OnNameInputValueChanged()
  local str = self._nameInput:GetText()
  if string.utf8len(str) > MaxWordCount_Name then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100274)
  end
  self._nameInput:SetText(str)
end

function GuildCreateDialog:OnSOpenParty()
  self:Destroy()
end

function GuildCreateDialog:OnLogoClicked()
  local dialog = DialogManager.CreateSingletonDialog("guild.guildlogoselectdialog")
  if dialog then
    dialog:Init(self, self._avatarId)
  end
end

function GuildCreateDialog:SetHead(data)
  self._avatarId = data.id
  local recorder = CGuildHead:GetRecorder(data.id)
  local imageRecord = CImagePath:GetRecorder(recorder.BigUiId) or DataCommon.DefaultImageAsset
  self._logo:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._logoName:SetText(TextManager.GetText(recorder.NameId))
end

return GuildCreateDialog
