local FastMenuDialog = class("FastMenuDialog", Dialog)
FastMenuDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
FastMenuDialog.AssetName = "FastMenu"

function FastMenuDialog:Ctor(...)
  FastMenuDialog.super.Ctor(self, ...)
  self._groupName = "ModalFrame"
  self._inCourtyard = false
end

function FastMenuDialog:OnCreate()
  self._menuBtn = self:GetChild("MenuBtn")
  self._charInfoBtn = self:GetChild("Back/Left1")
  self._workShopBtn = self:GetChild("Back/Left2")
  self._friends = self:GetChild("Back/Left3")
  self._guildBtn = self:GetChild("Back/Left4")
  self._dungeonBtn = self:GetChild("Back/Right1")
  self._gachaBtn = self:GetChild("Back/Right2")
  self._shopBtn = self:GetChild("Back/ShopBtn")
  self._mailBtn = self:GetChild("Back/Center1")
  self._taskBtn = self:GetChild("Back/Center2")
  self._repairBtn = self:GetChild("Back/Center3")
  self._memoryBtn = self:GetChild("Back/Center4")
  self._settingBtn = self:GetChild("Back/Center5")
  self._teamBtn = self:GetChild("Back/TeamBtn")
  self._mainCityBtn = self:GetChild("Back/HomeBtn")
  self._tuJianBtn = self:GetChild("Back/BookBtn")
  self._courtyardBtn = self:GetChild("Back/YardBtn")
  self._guildBtn = self:GetChild("Back/GuildBtn")
  self._workShopBtn:Subscribe_PointerClickEvent(self.OnWorkShopBtnPointerClick, self)
  self._charInfoBtn:Subscribe_PointerClickEvent(self.OnCharInfoBtnPointerClick, self)
  self._shopBtn:Subscribe_PointerClickEvent(self.OnShopBtnPointerClick, self)
  self._guildBtn:Subscribe_PointerClickEvent(self.OnGuildBtnPointerClick, self)
  self._friends:Subscribe_PointerClickEvent(self.OnFriendsBtnPointerClick, self)
  self._dungeonBtn:Subscribe_PointerClickEvent(self.OnDungeonBtnPointerClick, self)
  self._gachaBtn:Subscribe_PointerClickEvent(self.OnGachaBtnPointerClick, self)
  self._mailBtn:Subscribe_PointerClickEvent(self.OnMailBtnPointerClick, self)
  self._taskBtn:Subscribe_PointerClickEvent(self.OnTaskBtnPointerClick, self)
  self._repairBtn:Subscribe_PointerClickEvent(self.OnRepairBtnPointerClick, self)
  self._memoryBtn:Subscribe_PointerClickEvent(self.OnMemoryBtnPointerClick, self)
  self._settingBtn:Subscribe_PointerClickEvent(self.OnSettingBtnPointerClick, self)
  self._teamBtn:Subscribe_PointerClickEvent(self.OnTeamBtnPointerClick, self)
  self._mainCityBtn:Subscribe_PointerClickEvent(self.OnMainCityBtnPointerClick, self)
  self._tuJianBtn:Subscribe_PointerClickEvent(self.OnHandBookClicked, self)
  self._courtyardBtn:Subscribe_PointerClickEvent(self.OnCourtyardBtnClicked, self)
  self._guildBtn:Subscribe_PointerClickEvent(self.OnGuildBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnRootWinowPointerClick, self)
  self._baseMainUI = DialogManager.GetDialog("base.basemainui")
  self._baseMainMenuUI = DialogManager.GetDialog("base.basemainmenudialog")
  if GlobalGameFSM and (GlobalGameFSM:GetCurrentState() == "CourtYard" or GlobalGameFSM:GetCurrentState() == "SwimSuitActivity") then
    self._inCourtyard = GlobalGameFSM:GetCurrentState()
  end
  self._shopBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Shop))
  self._gachaBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Gacha))
  self._taskBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Task_MainLine))
  self._tuJianBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Handbook))
  self._courtyardBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.CourtYard))
  self._guildBtn:SetActive(NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Guild))
end

function FastMenuDialog:OnDestroy()
end

function FastMenuDialog:OnWorkShopBtnPointerClick()
  if self._inCourtyard then
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard("WorkShop")
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  else
    local dialog = DialogManager.GetDialog("equip.bagdialog")
    if dialog then
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      self._baseMainUI:OnWorkShopClick()
    end
  end
  self:Destroy()
end

function FastMenuDialog:OnCharInfoBtnPointerClick()
  if self._inCourtyard then
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard("CharacterList")
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  else
    local dialog = DialogManager.GetDialog("character.basecharacterlistdialog")
    if dialog then
      dialog:ReturnInitStatus()
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      self._baseMainUI:HandleCharacterButtonPointerClick()
    end
  end
  self:Destroy()
end

function FastMenuDialog:OnShopBtnPointerClick()
  if self._inCourtyard then
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard("Shop")
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  else
    local dialog = DialogManager.GetDialog("shop.shopmaindialog")
    if dialog then
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      self._baseMainUI:OnShopClick()
    end
  end
  self:Destroy()
end

function FastMenuDialog:OnFriendsBtnPointerClick()
  local dialog = DialogManager.GetDialog("chat.chatmaindialog")
  dialog = dialog or DialogManager.GetDialog("debug.gmorderdialog")
  if dialog then
    DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
  else
    DialogManager.GetGroup("Modal"):ReturnModalDialog()
    self._baseMainMenuUI:OnFriendsClick()
  end
  self:Destroy()
end

function FastMenuDialog:OnDungeonBtnPointerClick()
  if self._inCourtyard then
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard("Dungeon")
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  else
    local dialog = DialogManager.GetDialog("mainline.mainline.mainlineworlddialog")
    if dialog then
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      self._baseMainUI:OnDungeonClick()
    end
  end
  self:Destroy()
end

function FastMenuDialog:OnGachaBtnPointerClick()
  if self._inCourtyard then
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard("Gacha")
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  else
    local dialog = DialogManager.GetDialog("gacha.gachamaindialog")
    if dialog then
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      self._baseMainUI:OnGachaClick()
    end
  end
  self:Destroy()
end

function FastMenuDialog:OnMailBtnPointerClick()
  local dialog = DialogManager.GetDialog("mail.maildialog")
  if dialog then
    DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
  else
    DialogManager.GetGroup("Modal"):ReturnModalDialog()
    self._baseMainUI:HandleMailButtonPointerClick()
  end
  self:Destroy()
end

function FastMenuDialog:OnTaskBtnPointerClick()
  if self._inCourtyard then
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard("Task")
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  else
    local dialog = DialogManager.GetDialog("task.taskentrancedialog")
    if dialog then
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      self._baseMainUI:OnTaskClick()
    end
  end
  self:Destroy()
end

function FastMenuDialog:OnRepairBtnPointerClick()
end

function FastMenuDialog:OnMemoryBtnPointerClick()
end

function FastMenuDialog:OnSettingBtnPointerClick()
  if self._inCourtyard then
    local dialog = DialogManager.GetDialog("systemsetting.systemsettingdialog")
    if dialog then
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.CreateSingletonDialog("systemsetting.systemsettingdialog")
    end
  else
    local dialog = DialogManager.GetDialog("systemsetting.systemsettingdialog")
    if dialog then
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      self._baseMainUI:OnHeadPhotoClick()
    end
  end
  self:Destroy()
end

function FastMenuDialog:OnTeamBtnPointerClick()
  if self._inCourtyard then
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard("Team")
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  else
    local dialog = DialogManager.GetDialog("teamedit.teampresetmaindialog")
    if dialog then
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      self._baseMainMenuUI:OnTeamPresetBtnClick()
    end
  end
  self:Destroy()
end

function FastMenuDialog:OnMainCityBtnPointerClick()
  if self._inCourtyard then
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  else
    DialogManager.GetGroup("Modal"):ReturnModalDialog()
  end
  self:Destroy()
end

function FastMenuDialog:OnHandBookClicked()
  if self._inCourtyard then
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard("HandBook")
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  else
    local dialog = DialogManager.GetDialog("handbook.handbookdialog")
    if dialog then
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      self._baseMainMenuUI:OnHandBookClicked()
    end
  end
  self:Destroy()
end

function FastMenuDialog:OnCourtyardBtnClicked()
  if self._inCourtyard then
    local csend = LuaNetManager.CreateProtocol("protocol.yard.copenyard")
    csend:Send()
    DialogManager.GetGroup("Modal"):ReturnModalDialog()
  else
    DialogManager.GetGroup("Modal"):ReturnModalDialog()
    self._baseMainMenuUI:OnCourtyardBtnClicked()
  end
  self:Destroy()
end

function FastMenuDialog:OnGuildBtnClicked()
  if self._inCourtyard then
    NekoData.DataManager.DM_Game:SetFastMenuSignFromCourtyard("Guild")
    local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
    csend:Send()
  else
    local dialog = DialogManager.GetDialog("guild.guildmaindetail")
    if dialog then
      DialogManager.GetGroup("Modal"):ReturnModalDialog(dialog)
    else
      DialogManager.GetGroup("Modal"):ReturnModalDialog()
      self._baseMainMenuUI:OnGuildClick()
    end
  end
  self:Destroy()
end

function FastMenuDialog:OnBackBtnClicked()
  self:Destroy()
end

function FastMenuDialog:OnRootWinowPointerClick()
  self:Destroy()
end

return FastMenuDialog
