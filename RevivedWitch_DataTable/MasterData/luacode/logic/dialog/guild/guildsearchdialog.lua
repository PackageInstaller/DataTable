-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/guild/guildsearchdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CVarConfig = (BeanManager.GetTableByName)("var.cvarconfig")
local GuildSearchDialog = class("GuildSearchDialog", Dialog)
GuildSearchDialog.AssetBundleName = "ui/layouts.guild"
GuildSearchDialog.AssetName = "GuildSearch"
GuildSearchDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GuildSearchDialog
  ((GuildSearchDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._data = {}
end

GuildSearchDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._panel = self:GetChild("Frame")
  self._empty = self:GetChild("Empty")
  self._searchInputField = self:GetChild("Search/InputField")
  self._searchBtn = self:GetChild("Search/SearchBtn")
  self._refreshBtn = self:GetChild("RefreshBtn")
  self._createBtn = self:GetChild("CreateBtn")
  self._createGuildImg = self:GetChild("GroupNew1/CreateGuild")
  self._rankBtn = self:GetChild("levelrank")
  self._applyBtn = self:GetChild("ApplyBtn")
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._moneyPanel = self:GetChild("TopGroup")
  self._manaBtn = self:GetChild("TopGroup/Num1")
  self._manaTxt = self:GetChild("TopGroup/Num1/Text")
  ;
  (self._manaBtn):Subscribe_PointerClickEvent(self.OnManaBtnClick, self)
  self._diamondBtn = self:GetChild("TopGroup/Num2")
  self._diamondTxt = self:GetChild("TopGroup/Num2/Text")
  self._tableHead = self:GetChild("GroupNew2")
  ;
  (self._diamondBtn):Subscribe_PointerClickEvent(self.OnDiamondBtnClick, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._searchBtn):Subscribe_PointerClickEvent(self.OnSearchBtnClicked, self)
  ;
  (self._refreshBtn):Subscribe_PointerClickEvent(self.OnRefreshBtnClicked, self)
  ;
  (self._createBtn):Subscribe_PointerClickEvent(self.OnCreateBtnClicked, self)
  ;
  (self._createGuildImg):Subscribe_PointerClickEvent(self.OnCreateBtnClicked, self)
  ;
  (self._rankBtn):Subscribe_PointerClickEvent(self.OnRankBtnClicked, self)
  ;
  (self._applyBtn):Subscribe_PointerClickEvent(self.OnApplyBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSOpenParty, Common.n_OnSOpenParty, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshCurrency, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
  ;
  (UIBackManager.SetUIBackShow)(true)
  ;
  (UIBackManager.SetUIModalBackColor)(2)
end

GuildSearchDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (UIBackManager.SetUIBackShow)(false)
  ;
  (self._frame):Destroy()
  if self._baseSceneController then
    (self._baseSceneController):SetCameraAnimatorState(0)
  end
end

GuildSearchDialog.Refrash = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  self._baseSceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
  self._data = data.allParty
  ;
  (self._empty):SetActive(not self._data or #self._data == 0)
  ;
  (self._tableHead):SetActive(not self._data or #self._data >= 0)
  ;
  (self._frame):ReloadAllCell()
  ;
  (self._frame):MoveToTop()
  ;
  (self._manaTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SoulDropID))
  ;
  (self._diamondTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.DiamodID))
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

GuildSearchDialog.NumberOfCell = function(self, frame)
  -- function num : 0_4
  return #self._data
end

GuildSearchDialog.CellAtIndex = function(self, frame)
  -- function num : 0_5
  return "guild.guildsearchcell"
end

GuildSearchDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_6
  return (self._data)[index]
end

GuildSearchDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

GuildSearchDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_8 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

GuildSearchDialog.OnSearchBtnClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  local txt = (self._searchInputField):GetText()
  local id = 0
  if #txt > 0 then
    id = tonumber(txt)
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.csearchparty")
  if csend then
    csend.partyId = id
    csend:Send()
  end
end

GuildSearchDialog.OnRefreshBtnClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.csearchparty")
  if csend then
    csend.partyId = 0
    local list = {}
    for i,v in ipairs(self._data) do
      list[i] = v.partyId
    end
    csend.excludePartyIds = list
    csend:Send()
  end
end

GuildSearchDialog.OnCreateBtnClicked = function(self)
  -- function num : 0_11 , upvalues : _ENV, CVarConfig
  if ((NekoData.BehaviorManager).BM_Game):IsGuest() and (CVarConfig:GetRecorder(93)).Value == "0" then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100337)
    return 
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cgetholdpartyconsume")
  if csend then
    csend:Send()
  end
end

GuildSearchDialog.OnRankBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.crequestpartyrank")
  if csend then
    csend:Send()
  end
end

GuildSearchDialog.OnApplyBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local list = {}
  for i,v in ipairs(self._data) do
    list[i] = v.partyId
  end
  if #list == 0 then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100344)
  end
  local csend = (LuaNetManager.CreateProtocol)("protocol.party.cjoinparty")
  if csend then
    csend.partyIdList = list
    csend:Send()
  end
end

GuildSearchDialog.OnSOpenParty = function(self)
  -- function num : 0_14
  self:Destroy()
end

GuildSearchDialog.OnManaBtnClick = function(self)
  -- function num : 0_15 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.SoulDropID)})
    local width, height = (self._manaBtn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._manaBtn):GetLocalPointInUiRootPanel())
  end
end

GuildSearchDialog.OnDiamondBtnClick = function(self)
  -- function num : 0_16 , upvalues : _ENV, Item
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({item = (Item.Create)(DataCommon.DiamodID)})
    local width, height = (self._diamondBtn):GetRectSize()
    tipsDialog:SetTipsPosition(width, height, (self._diamondBtn):GetLocalPointInUiRootPanel())
  end
end

GuildSearchDialog.RefreshCurrency = function(self)
  -- function num : 0_17 , upvalues : _ENV
  (self._manaTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.SoulDropID))
  ;
  (self._diamondTxt):SetNumber(((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(DataCommon.DiamodID))
end

GuildSearchDialog.AddNewModal = function(self, dialog)
  -- function num : 0_18
  if dialog._dialogName == "guild.guilddetaildialog" or dialog._dialogName == "guild.guildrankleveldialog" then
    (self._rootWindow):SetActive(true)
  else
    ;
    (self._rootWindow):SetActive(false)
  end
end

GuildSearchDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_19
  if (notification.userInfo)._dialogName == "friend.charactershowdialog" then
    (self._rootWindow):SetActive(true)
  end
end

return GuildSearchDialog

