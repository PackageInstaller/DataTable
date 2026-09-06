local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CVarConfig = BeanManager.GetTableByName("var.cvarconfig")
local GuildSearchDialog = class("GuildSearchDialog", Dialog)
GuildSearchDialog.AssetBundleName = "ui/layouts.guild"
GuildSearchDialog.AssetName = "GuildSearch"

function GuildSearchDialog:Ctor(...)
  GuildSearchDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

function GuildSearchDialog:OnCreate()
  self._panel = self:GetChild("Frame")
  self._empty = self:GetChild("Empty")
  self._searchInputField = self:GetChild("Search/InputField")
  self._searchBtn = self:GetChild("Search/SearchBtn")
  self._refreshBtn = self:GetChild("RefreshBtn")
  self._createBtn = self:GetChild("CreateBtn")
  self._createGuildImg = self:GetChild("GroupNew1/CreateGuild")
  self._rankBtn = self:GetChild("levelrank")
  self._applyBtn = self:GetChild("ApplyBtn")
  self._frame = TableFrame.Create(self._panel, self, true, true, true)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._moneyPanel = self:GetChild("TopGroup")
  self._manaBtn = self:GetChild("TopGroup/Num1")
  self._manaTxt = self:GetChild("TopGroup/Num1/Text")
  self._manaBtn:Subscribe_PointerClickEvent(self.OnManaBtnClick, self)
  self._diamondBtn = self:GetChild("TopGroup/Num2")
  self._diamondTxt = self:GetChild("TopGroup/Num2/Text")
  self._tableHead = self:GetChild("GroupNew2")
  self._diamondBtn:Subscribe_PointerClickEvent(self.OnDiamondBtnClick, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._searchBtn:Subscribe_PointerClickEvent(self.OnSearchBtnClicked, self)
  self._refreshBtn:Subscribe_PointerClickEvent(self.OnRefreshBtnClicked, self)
  self._createBtn:Subscribe_PointerClickEvent(self.OnCreateBtnClicked, self)
  self._createGuildImg:Subscribe_PointerClickEvent(self.OnCreateBtnClicked, self)
  self._rankBtn:Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  self._applyBtn:Subscribe_PointerClickEvent(self.OnApplyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnSOpenParty, Common.n_OnSOpenParty, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshCurrency, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(2)
end

function GuildSearchDialog:OnDestroy()
  UIBackManager.SetUIBackShow(false)
  self._frame:Destroy()
  if self._baseSceneController then
    self._baseSceneController:SetCameraAnimatorState(0)
  end
end

function GuildSearchDialog:Refrash(data)
  self._baseSceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
  self._data = data.allParty
  self._empty:SetActive(not self._data or #self._data == 0)
  self._tableHead:SetActive(self._data and #self._data >= 0)
  self._frame:ReloadAllCell()
  self._frame:MoveToTop()
  self._manaTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SoulDropID))
  self._diamondTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
end

function GuildSearchDialog:NumberOfCell(frame)
  return #self._data
end

function GuildSearchDialog:CellAtIndex(frame)
  return "guild.guildsearchcell"
end

function GuildSearchDialog:DataAtIndex(frame, index)
  return self._data[index]
end

function GuildSearchDialog:OnBackBtnClicked()
  self:Destroy()
end

function GuildSearchDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function GuildSearchDialog:OnSearchBtnClicked()
  local txt = self._searchInputField:GetText()
  local id = 0
  if 0 < #txt then
    id = tonumber(txt)
  end
  local csend = LuaNetManager.CreateProtocol("protocol.party.csearchparty")
  if csend then
    csend.partyId = id
    csend:Send()
  end
end

function GuildSearchDialog:OnRefreshBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.party.csearchparty")
  if csend then
    csend.partyId = 0
    local list = {}
    for i, v in ipairs(self._data) do
      list[i] = v.partyId
    end
    csend.excludePartyIds = list
    csend:Send()
  end
end

function GuildSearchDialog:OnCreateBtnClicked()
  if NekoData.BehaviorManager.BM_Game:IsGuest() and CVarConfig:GetRecorder(93).Value == "0" then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100337)
    return
  end
  local csend = LuaNetManager.CreateProtocol("protocol.party.cgetholdpartyconsume")
  if csend then
    csend:Send()
  end
end

function GuildSearchDialog:OnRankBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.party.crequestpartyrank")
  if csend then
    csend:Send()
  end
end

function GuildSearchDialog:OnApplyBtnClicked()
  local list = {}
  for i, v in ipairs(self._data) do
    list[i] = v.partyId
  end
  if #list == 0 then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100344)
  end
  local csend = LuaNetManager.CreateProtocol("protocol.party.cjoinparty")
  if csend then
    csend.partyIdList = list
    csend:Send()
  end
end

function GuildSearchDialog:OnSOpenParty()
  self:Destroy()
end

function GuildSearchDialog:OnManaBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.SoulDropID)
    })
    local width, height = self._manaBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._manaBtn:GetLocalPointInUiRootPanel())
  end
end

function GuildSearchDialog:OnDiamondBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.DiamodID)
    })
    local width, height = self._diamondBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._diamondBtn:GetLocalPointInUiRootPanel())
  end
end

function GuildSearchDialog:RefreshCurrency()
  self._manaTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.SoulDropID))
  self._diamondTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
end

function GuildSearchDialog:AddNewModal(dialog)
  if dialog._dialogName == "guild.guilddetaildialog" or dialog._dialogName == "guild.guildrankleveldialog" then
    self._rootWindow:SetActive(true)
  else
    self._rootWindow:SetActive(false)
  end
end

function GuildSearchDialog:OnDialogDestroy(notification)
  if notification.userInfo._dialogName == "friend.charactershowdialog" then
    self._rootWindow:SetActive(true)
  end
end

return GuildSearchDialog
