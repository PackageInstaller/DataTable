local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CbpBossHitRole = BeanManager.GetTableByName("activity.cbpbosshitrole")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemPinji = BeanManager.GetTableByName("item.citempinji")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local KillBossCharacterInfoDialog = class("KillBossCharacterInfoDialog", Dialog)
KillBossCharacterInfoDialog.AssetBundleName = "ui/layouts.battlepassnew"
KillBossCharacterInfoDialog.AssetName = "BattlePassNewCharUp"

function KillBossCharacterInfoDialog:Ctor(...)
  KillBossCharacterInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.GiftOfTimeActivityManagerID)
  self._sendProtocol = false
end

function KillBossCharacterInfoDialog:OnCreate()
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
  self._GrisBtn:Subscribe_PointerClickEvent(self.OnGrisBtnClicked, self)
  self._charLevelUpItemImg:Subscribe_PointerClickEvent(self.OnItemBtnClicked, self)
  self._charLevelUpBtn:Subscribe_PointerClickEvent(self.OnCharLevelUpBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsSRefreshFoolsDaySingleRole, Common.n_SWitchInAgainstBossUpLv, nil)
end

function KillBossCharacterInfoDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
end

function KillBossCharacterInfoDialog:SetData(roleInfo)
  local str = TextManager.GetText(CStringres:GetRecorder(1777).msgTextID)
  self._title:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1780).msgTextID)
  self._charLevelUpBtnTxt:SetText(str)
  self._data = roleInfo
  str = TextManager.GetText(self._data.cfg.upgradeID, self._data.cfg.basicHealth, self._data.cfg.basicAttack)
  self._tipsTxt:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1829).msgTextID)
  self._healthTagTxt:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1830).msgTextID)
  self._attackTagTxt:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1831).msgTextID)
  self._charTagTxt:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1827).msgTextID)
  self._charLevelMax:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1833).msgTextID)
  self._equipNeedTagTxt:SetText(str)
  local role = Role.Create(self._data.roleId)
  if self._data.roleId == 1 then
    self._charName:SetText(TextManager.GetText(CStringres:GetRecorder(1778).msgTextID))
  else
    self._charName:SetText(role:GetRoleName())
  end
  local image = role:GetDiamondHeadImageRecord()
  self._charImg:SetSprite(image.assetBundle, image.assetName)
  self._charLevelUpNeedItemId = DataCommon.KillBossCoin
  self:RefreshPanelInfo()
end

function KillBossCharacterInfoDialog:OnCharLevelUpBtnClicked()
  if NekoData.BehaviorManager.BM_Guide:IsCurrentStage(66, 2) then
    NekoData.BehaviorManager.BM_Guide:FinishGuide(66)
  end
  if not self._sendProtocol then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cwitchinagainstbossuplv")
    self._sendProtocol = true
    csend:Send()
  end
end

function KillBossCharacterInfoDialog:OnGrisBtnClicked()
  NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(146, nil, function()
    DialogManager.CreateSingletonDialog("activity.giftoftime.killbosstaskdialog"):Init()
    self:OnBackBtnClicked()
  end, {}, nil, {})
end

function KillBossCharacterInfoDialog:OnItemBtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._item
    })
  end
end

function KillBossCharacterInfoDialog:OnBackBtnClicked()
  self:Destroy()
end

function KillBossCharacterInfoDialog:OnAprilFoolsSRefreshFoolsDaySingleRole(notification)
  self._sendProtocol = false
  self:RefreshPanelInfo()
end

function KillBossCharacterInfoDialog:RefreshPanelInfo()
  self._charLvTxt:SetText(self._data.roleLv)
  self._healthNumTxt:SetText(self._data.blood)
  self._attackNumTxt:SetText(self._data.attack)
  local charlevelupneeditemcurrentnum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._charLevelUpNeedItemId)
  local charlevelupitemneednum = 0
  if self._data.roleLv > #CbpBossHitRole:GetAllIds() - 1 then
    charlevelupitemneednum = 0
  else
    charlevelupitemneednum = CbpBossHitRole:GetRecorder(self._data.roleLv + 1).num
  end
  if charlevelupneeditemcurrentnum >= charlevelupitemneednum and 0 < charlevelupitemneednum then
    self._charLevelUpItemNumTxtRed:SetActive(false)
    self._charLevelUpItemNumTxt:SetActive(true)
    self._charLevelUpBtn:SetInteractable(true)
    self._GrisBtn:SetActive(false)
  else
    self._charLevelUpItemNumTxtRed:SetActive(true)
    self._charLevelUpItemNumTxt:SetActive(false)
    self._charLevelUpBtn:SetInteractable(false)
    self._GrisBtn:SetActive(true)
  end
  if charlevelupitemneednum == 0 then
    self._charLevelMax:SetActive(true)
    self._charLevelUpBtn:SetActive(false)
    self._GrisBtn:SetActive(false)
    self._charLevelUpItemNumTxtRed:SetActive(false)
    self._charLevelUpItemNumTxt:SetActive(true)
  else
    self._charLevelMax:SetActive(false)
  end
  self._charLevelUpItemNumTxtRed:SetText(charlevelupneeditemcurrentnum)
  self._charLevelUpItemNumTxt:SetText(charlevelupneeditemcurrentnum)
  self._charLevelUpItemNeedNumTxt:SetText(charlevelupitemneednum)
  local item = Item.Create(self._charLevelUpNeedItemId)
  self._item = item
  local imageRecord = item:GetIcon()
  self._charLevelUpItemImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

return KillBossCharacterInfoDialog
