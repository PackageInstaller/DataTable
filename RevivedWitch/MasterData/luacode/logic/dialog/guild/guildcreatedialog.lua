-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildcreatedialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local CGuildHead = (BeanManager.GetTableByName)("guild.cguildhead")
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local MaxWordCount_Name, MinWordCount_Name = ((NekoData.BehaviorManager).BM_Game):GetUpAndDownLimitsByFuncId((DataCommon.TextLimit).GuildName)
local MaxWordCount_Intro, MinWordCount_Intro = ((NekoData.BehaviorManager).BM_Game):GetUpAndDownLimitsByFuncId((DataCommon.TextLimit).GuildIntroduction)
local GuildCreateDialog = class("GuildCreateDialog", Dialog)
GuildCreateDialog.AssetBundleName = "ui/layouts.guild"
GuildCreateDialog.AssetName = "GuildCreate"
GuildCreateDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildCreateDialog
  ((GuildCreateDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._cost = 0
  self._autoPass = 0
  self._avatarId = 1
end

GuildCreateDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV, MaxWordCount_Name
  self._logo = self:GetChild("Back/Logo")
  self._logoChangeButton = self:GetChild("Back/ChangeButton")
  self._logoName = self:GetChild("Back/ChangeButton/Text2")
  self._nameInput = self:GetChild("Back/InputField1")
  ;
  (self:GetChild("Back/InputField1/_Placeholder")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1571, {MaxWordCount_Name}))
  self._introTextInput = self:GetChild("Back/InputField2")
  self._introWordCount = self:GetChild("Back/Num/Textnew1")
  self._toggleNoNeedCheck = self:GetChild("Back/ToggleGroup/_Toggle_0")
  self._toggleNeedCheck = self:GetChild("Back/ToggleGroup/_Toggle_1")
  self._needNoneyCount = self:GetChild("Back/Need/Num")
  self._cancelButton = self:GetChild("Back/CancelButton")
  self._confirmButton = self:GetChild("Back/ConfirmButton")
  ;
  (self._toggleNoNeedCheck):Subscribe_ValueChangedEvent(self.OnNeedCheckChange, self)
  ;
  (self._toggleNeedCheck):Subscribe_ValueChangedEvent(self.OnNeedCheckChange, self)
  ;
  (self._cancelButton):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmButton):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._nameInput):Subscribe_ValueChangedEvent(self.OnNameInputValueChanged, self)
  ;
  (self._introTextInput):Subscribe_ValueChangedEvent(self.OnIntroTextInputValueChanged, self)
  ;
  (self._logo):Subscribe_PointerClickEvent(self.OnLogoClicked, self)
  ;
  (self._logoChangeButton):Subscribe_PointerClickEvent(self.OnLogoClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSOpenParty, Common.n_OnSOpenParty, nil)
  self:OnIntroTextInputValueChanged()
end

GuildCreateDialog.OnDestroy = function(self)
  -- function num : 0_2
end

GuildCreateDialog.Init = function(self, cost)
  -- function num : 0_3 , upvalues : CGuildHead, _ENV
  self._cost = cost
  self._autoPass = 1
  ;
  (self._needNoneyCount):SetText(cost)
  local allId = CGuildHead:GetAllIds()
  local randomIndex = (math.random)(1, #allId)
  local randomRecorder = CGuildHead:GetRecorder(allId[randomIndex])
  self:SetHead(randomRecorder)
end

GuildCreateDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

GuildCreateDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV, MaxWordCount_Name, MaxWordCount_Intro
  local name = (self._nameInput):GetText()
  if #name == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100271)
    return 
  end
  if ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SoulDropID) < self._cost then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100332)
    return 
  end
  if MaxWordCount_Name < (string.utf8len)((self._nameInput):GetText()) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
    return 
  end
  if MaxWordCount_Intro < (string.utf8len)((self._introTextInput):GetText()) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.choldparty")
  if csend then
    csend.partyName = (self._nameInput):GetText()
    csend.partyDeclaration = (self._introTextInput):GetText()
    csend.autoAcceptApply = self._autoPass
    csend.avatarId = self._avatarId
    csend:Send()
  end
end

GuildCreateDialog.OnNeedCheckChange = function(self)
  -- function num : 0_6
  if (self._toggleNoNeedCheck):GetIsOnType() then
    self._autoPass = 1
  else
    self._autoPass = 0
  end
end

GuildCreateDialog.OnIntroTextInputValueChanged = function(self)
  -- function num : 0_7 , upvalues : _ENV, MaxWordCount_Intro
  local str = (self._introTextInput):GetText()
  ;
  (self._introTextInput):SetText(str)
  local count = (utf8.len)(str)
  if MaxWordCount_Intro < count then
    (self._introWordCount):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1570, {count, MaxWordCount_Intro}))
  else
    ;
    (self._introWordCount):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1569, {count, MaxWordCount_Intro}))
  end
end

GuildCreateDialog.OnNameInputValueChanged = function(self)
  -- function num : 0_8 , upvalues : _ENV, MaxWordCount_Name
  local str = (self._nameInput):GetText()
  if MaxWordCount_Name < (string.utf8len)(str) then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100274)
  end
  ;
  (self._nameInput):SetText(str)
end

GuildCreateDialog.OnSOpenParty = function(self)
  -- function num : 0_9
  self:Destroy()
end

GuildCreateDialog.OnLogoClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("guild.guildlogoselectdialog")
  if dialog then
    dialog:Init(self, self._avatarId)
  end
end

GuildCreateDialog.SetHead = function(self, data)
  -- function num : 0_11 , upvalues : CGuildHead, CImagePath, _ENV
  self._avatarId = data.id
  local recorder = CGuildHead:GetRecorder(data.id)
  if not CImagePath:GetRecorder(recorder.BigUiId) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._logo):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._logoName):SetText((TextManager.GetText)(recorder.NameId))
end

return GuildCreateDialog

