-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/giftoftime/killbosscharacterinfodialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CbpBossHitRole = (BeanManager.GetTableByName)("activity.cbpbosshitrole")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CItemPinji = (BeanManager.GetTableByName)("item.citempinji")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local KillBossCharacterInfoDialog = class("KillBossCharacterInfoDialog", Dialog)
KillBossCharacterInfoDialog.AssetBundleName = "ui/layouts.battlepassnew"
KillBossCharacterInfoDialog.AssetName = "BattlePassNewCharUp"
KillBossCharacterInfoDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : KillBossCharacterInfoDialog, _ENV
  ((KillBossCharacterInfoDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.GiftOfTimeActivityManagerID)
  self._sendProtocol = false
end

KillBossCharacterInfoDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._title = self:GetChild("Back/Title")
  self._healthNumTxt = self:GetChild("CharCell/Health/HealthNum")
  self._healthTagTxt = self:GetChild("CharCell/Health/Txt")
  self._charLvTxt = self:GetChild("CharCell/Level")
  self._equipNeedTagTxt = self:GetChild("ExpCost/Text1")
  self._closeBtn = self:GetChild("CloseBtn")
  self._charName = self:GetChild("CharCell/Name")
  self._attackNumTxt = self:GetChild("CharCell/Attack/AttackNum")
  self._attackTagTxt = self:GetChild("CharCell/Attack/Txt")
  self._charImg = self:GetChild("CharCell/HeadPhoto")
  self._tipsTxt = self:GetChild("CharCell/tips/Text2")
  self._charLevelUpItemNeedNumTxt = self:GetChild("ExpCost/Need")
  self._charLevelUpItemNumTxtRed = self:GetChild("ExpCost/Poor")
  self._charLevelUpItemNumTxt = self:GetChild("ExpCost/Now")
  self._charLevelUpItemImg = self:GetChild("ExpCost/Item")
  self._charLevelUpBtn = self:GetChild("ExpCost/UpBtn")
  self._charLevelUpBtnTxt = self:GetChild("ExpCost/UpBtn/Text")
  self._charTagTxt = self:GetChild("ExpCost/Text2")
  self._charLevelMax = self:GetChild("ExpCost/Max")
  self._GrisBtn = self:GetChild("ExpCost/Gris")
  ;
  (self._GrisBtn):Subscribe_PointerClickEvent(self.OnGrisBtnClicked, self)
  ;
  (self._charLevelUpItemImg):Subscribe_PointerClickEvent(self.OnItemBtnClicked, self)
  ;
  (self._charLevelUpBtn):Subscribe_PointerClickEvent(self.OnCharLevelUpBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAprilFoolsSRefreshFoolsDaySingleRole, Common.n_SWitchInAgainstBossUpLv, nil)
end

KillBossCharacterInfoDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
end

KillBossCharacterInfoDialog.SetData = function(self, roleInfo)
  -- function num : 0_3 , upvalues : _ENV, CStringres, Role
  local str = (TextManager.GetText)((CStringres:GetRecorder(1777)).msgTextID)
  ;
  (self._title):SetText(str)
  str = (TextManager.GetText)((CStringres:GetRecorder(1780)).msgTextID)
  ;
  (self._charLevelUpBtnTxt):SetText(str)
  self._data = roleInfo
  str = (TextManager.GetText)(((self._data).cfg).upgradeID, ((self._data).cfg).basicHealth, ((self._data).cfg).basicAttack)
  ;
  (self._tipsTxt):SetText(str)
  str = (TextManager.GetText)((CStringres:GetRecorder(1829)).msgTextID)
  ;
  (self._healthTagTxt):SetText(str)
  str = (TextManager.GetText)((CStringres:GetRecorder(1830)).msgTextID)
  ;
  (self._attackTagTxt):SetText(str)
  str = (TextManager.GetText)((CStringres:GetRecorder(1831)).msgTextID)
  ;
  (self._charTagTxt):SetText(str)
  str = (TextManager.GetText)((CStringres:GetRecorder(1827)).msgTextID)
  ;
  (self._charLevelMax):SetText(str)
  str = (TextManager.GetText)((CStringres:GetRecorder(1833)).msgTextID)
  ;
  (self._equipNeedTagTxt):SetText(str)
  local role = (Role.Create)((self._data).roleId)
  if (self._data).roleId == 1 then
    (self._charName):SetText((TextManager.GetText)((CStringres:GetRecorder(1778)).msgTextID))
  else
    ;
    (self._charName):SetText(role:GetRoleName())
  end
  local image = role:GetDiamondHeadImageRecord()
  ;
  (self._charImg):SetSprite(image.assetBundle, image.assetName)
  self._charLevelUpNeedItemId = DataCommon.KillBossCoin
  self:RefreshPanelInfo()
end

KillBossCharacterInfoDialog.OnCharLevelUpBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentStage(66, 2) then
    ((NekoData.BehaviorManager).BM_Guide):FinishGuide(66)
  end
  if not self._sendProtocol then
    local csend = (LuaNetManager.CreateProtocol)("protocol.activity.cwitchinagainstbossuplv")
    self._sendProtocol = true
    csend:Send()
  end
end

KillBossCharacterInfoDialog.OnGrisBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(146, nil, function()
    -- function num : 0_5_0 , upvalues : _ENV, self
    ((DialogManager.CreateSingletonDialog)("activity.giftoftime.killbosstaskdialog")):Init()
    self:OnBackBtnClicked()
  end
, {}, nil, {})
end

KillBossCharacterInfoDialog.OnItemBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._item})
  end
end

KillBossCharacterInfoDialog.OnBackBtnClicked = function(self)
  -- function num : 0_7
  self:Destroy()
end

KillBossCharacterInfoDialog.OnAprilFoolsSRefreshFoolsDaySingleRole = function(self, notification)
  -- function num : 0_8
  self._sendProtocol = false
  self:RefreshPanelInfo()
end

KillBossCharacterInfoDialog.RefreshPanelInfo = function(self)
  -- function num : 0_9 , upvalues : _ENV, CbpBossHitRole, Item
  (self._charLvTxt):SetText((self._data).roleLv)
  ;
  (self._healthNumTxt):SetText((self._data).blood)
  ;
  (self._attackNumTxt):SetText((self._data).attack)
  local charlevelupneeditemcurrentnum = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(self._charLevelUpNeedItemId)
  local charlevelupitemneednum = 0
  if #CbpBossHitRole:GetAllIds() - 1 < (self._data).roleLv then
    charlevelupitemneednum = 0
  else
    charlevelupitemneednum = (CbpBossHitRole:GetRecorder((self._data).roleLv + 1)).num
  end
  if charlevelupitemneednum <= charlevelupneeditemcurrentnum and charlevelupitemneednum > 0 then
    (self._charLevelUpItemNumTxtRed):SetActive(false)
    ;
    (self._charLevelUpItemNumTxt):SetActive(true)
    ;
    (self._charLevelUpBtn):SetInteractable(true)
    ;
    (self._GrisBtn):SetActive(false)
  else
    ;
    (self._charLevelUpItemNumTxtRed):SetActive(true)
    ;
    (self._charLevelUpItemNumTxt):SetActive(false)
    ;
    (self._charLevelUpBtn):SetInteractable(false)
    ;
    (self._GrisBtn):SetActive(true)
  end
  if charlevelupitemneednum == 0 then
    (self._charLevelMax):SetActive(true)
    ;
    (self._charLevelUpBtn):SetActive(false)
    ;
    (self._GrisBtn):SetActive(false)
    ;
    (self._charLevelUpItemNumTxtRed):SetActive(false)
    ;
    (self._charLevelUpItemNumTxt):SetActive(true)
  else
    ;
    (self._charLevelMax):SetActive(false)
  end
  ;
  (self._charLevelUpItemNumTxtRed):SetText(charlevelupneeditemcurrentnum)
  ;
  (self._charLevelUpItemNumTxt):SetText(charlevelupneeditemcurrentnum)
  ;
  (self._charLevelUpItemNeedNumTxt):SetText(charlevelupitemneednum)
  local item = (Item.Create)(self._charLevelUpNeedItemId)
  self._item = item
  local imageRecord = item:GetIcon()
  ;
  (self._charLevelUpItemImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

return KillBossCharacterInfoDialog

