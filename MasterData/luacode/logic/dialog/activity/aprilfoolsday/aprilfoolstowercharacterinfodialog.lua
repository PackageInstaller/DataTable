local Role = require("logic.manager.experimental.types.role")
local Item = require("logic.manager.experimental.types.item")
local CClownEquip = BeanManager.GetTableByName("activity.cclownequip")
local CClownRoleLevelUp = BeanManager.GetTableByName("activity.cclownrolelevelup")
local CClownSpecialCfg = BeanManager.GetTableByName("activity.cclownspecialcfg")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CItemPinji = BeanManager.GetTableByName("item.citempinji")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local AprilFoolsTowerCharacterInfoDialog = class("AprilFoolsTowerCharacterInfoDialog", Dialog)
AprilFoolsTowerCharacterInfoDialog.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsTowerCharacterInfoDialog.AssetName = "ActivityAprilFoolsCharUp"

function AprilFoolsTowerCharacterInfoDialog:Ctor(...)
  AprilFoolsTowerCharacterInfoDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._bm = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.AprilFoolsDayActivityManagerID)
  self._sendProtocol = false
end

function AprilFoolsTowerCharacterInfoDialog:OnCreate()
  self._title = self:GetChild("Back/Title")
  self._equipLevelUpNeedItemImg = self:GetChild("CharCell/Item")
  self._healthNumTxt = self:GetChild("CharCell/Health/HealthNum")
  self._healthTagTxt = self:GetChild("CharCell/Health/Txt")
  self._charLvTxt = self:GetChild("CharCell/Level")
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
  self._equipPanel = self:GetChild("EquipCost/ActivityAprilFoolsCellItem/Panel/ItemCell/_BackGround")
  self._equipImg = self:GetChild("EquipCost/ActivityAprilFoolsCellItem/Panel/ItemCell/_BackGround/Icon")
  self._equipFrame = self:GetChild("EquipCost/ActivityAprilFoolsCellItem/Panel/ItemCell/_BackGround/Frame")
  self._equipHealthNumTxt = self:GetChild("EquipCost/Health/HealthNum")
  self._equipHealthTagTxt = self:GetChild("EquipCost/Health/Health")
  self._equipLevelUpItemImg = self:GetChild("EquipCost/Item")
  self._equipLevelUpItemNumTxt = self:GetChild("EquipCost/Item/Text")
  self._equipLevelUpItemNumTxtRed = self:GetChild("EquipCost/Item/Poor")
  self._equipLevelUpItemNeedNumTxt = self:GetChild("EquipCost/Item/Need")
  self._equipAttackNumTxt = self:GetChild("EquipCost/Attack/AttackNum")
  self._equipAttackTagTxt = self:GetChild("EquipCost/Attack/Attack")
  self._weaponLevelUpBtn = self:GetChild("EquipCost/UpBtn")
  self._weaponLevelUpBtnTxt = self:GetChild("EquipCost/UpBtn/Text")
  self._equipLvTxt = self:GetChild("EquipCost/ActivityAprilFoolsCellItem/Panel/ItemCell/_Count")
  self._equipNeedTagTxt = self:GetChild("ExpCost/Text1")
  self._charTagTxt = self:GetChild("ExpCost/Text2")
  self._equipTagTxt = self:GetChild("EquipCost/Text2")
  self._charLevelMax = self:GetChild("ExpCost/Max")
  self._equipLevelMax = self:GetChild("EquipCost/Max")
  self._charLevelUpBtn:Subscribe_PointerClickEvent(self.OnCharLevelUpBtnClicked, self)
  self._weaponLevelUpBtn:Subscribe_PointerClickEvent(self.OnWeaponLevelUpBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnCloseBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnAprilFoolsSRefreshFoolsDaySingleRole, Common.n_AprilFoolsSRefreshFoolsDaySingleRole, nil)
end

function AprilFoolsTowerCharacterInfoDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function AprilFoolsTowerCharacterInfoDialog:SetData(roleInfo)
  local str = TextManager.GetText(CStringres:GetRecorder(1777).msgTextID)
  self._title:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1780).msgTextID)
  self._charLevelUpBtnTxt:SetText(str)
  self._weaponLevelUpBtnTxt:SetText(str)
  self._data = roleInfo
  str = TextManager.GetText(self._data.tipstextid, self._data.growHP, self._data.growATK)
  self._tipsTxt:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1829).msgTextID)
  self._healthTagTxt:SetText(str)
  self._equipHealthTagTxt:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1830).msgTextID)
  self._attackTagTxt:SetText(str)
  self._equipAttackTagTxt:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1831).msgTextID)
  self._charTagTxt:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1832).msgTextID)
  self._equipTagTxt:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1833).msgTextID)
  self._equipNeedTagTxt:SetText(str)
  str = TextManager.GetText(CStringres:GetRecorder(1827).msgTextID)
  self._charLevelMax:SetText(str)
  self._equipLevelMax:SetText(str)
  local role = Role.Create(self._data.roleId)
  if self._data.roleId == 1 then
    self._charName:SetText(TextManager.GetText(CStringres:GetRecorder(1778).msgTextID))
  else
    self._charName:SetText(role:GetRoleName())
  end
  local image = role:GetDiamondHeadImageRecord()
  self._charImg:SetSprite(image.assetBundle, image.assetName)
  self._charLevelUpNeedItemId = tonumber(CClownSpecialCfg:GetRecorder(3).Value)
  self:RefreshPanelInfo()
end

function AprilFoolsTowerCharacterInfoDialog:OnCharLevelUpBtnClicked()
  if not self._sendProtocol then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cupgradefoolsdayrole")
    csend.Id = self._data.Id
    csend.upgradeType = csend.LEVEL
    csend:Send()
    self._sendProtocol = true
  end
end

function AprilFoolsTowerCharacterInfoDialog:OnWeaponLevelUpBtnClicked()
  if not self._sendProtocol then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cupgradefoolsdayrole")
    csend.Id = self._data.Id
    csend.upgradeType = csend.WEAPON
    csend:Send()
    self._sendProtocol = true
  end
end

function AprilFoolsTowerCharacterInfoDialog:OnCloseBtnClicked()
  self:Destroy()
end

function AprilFoolsTowerCharacterInfoDialog:OnAprilFoolsSRefreshFoolsDaySingleRole(notification)
  self._sendProtocol = false
  self:RefreshPanelInfo()
end

function AprilFoolsTowerCharacterInfoDialog:RefreshPanelInfo()
  self._charLvTxt:SetText(self._data.roleLv)
  self._healthNumTxt:SetText(self._data.blood)
  self._attackNumTxt:SetText(self._data.attack)
  local charlevelupneeditemcurrentnum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(self._charLevelUpNeedItemId)
  local charlevelupitemneednum = CClownRoleLevelUp:GetRecorder(self._data.roleLv).neednum
  if charlevelupneeditemcurrentnum >= charlevelupitemneednum and 0 < charlevelupitemneednum then
    self._charLevelUpItemNumTxtRed:SetActive(false)
    self._charLevelUpItemNumTxt:SetActive(true)
    self._charLevelUpBtn:SetInteractable(true)
  else
    self._charLevelUpItemNumTxtRed:SetActive(true)
    self._charLevelUpItemNumTxt:SetActive(false)
    self._charLevelUpBtn:SetInteractable(false)
  end
  if charlevelupitemneednum == 0 then
    self._charLevelMax:SetActive(true)
    self._charLevelUpBtn:SetActive(false)
    self._charLevelUpItemNumTxtRed:SetActive(false)
    self._charLevelUpItemNumTxt:SetActive(true)
  else
    self._charLevelMax:SetActive(false)
  end
  self._charLevelUpItemNumTxtRed:SetText(charlevelupneeditemcurrentnum)
  self._charLevelUpItemNumTxt:SetText(charlevelupneeditemcurrentnum)
  self._charLevelUpItemNeedNumTxt:SetText(charlevelupitemneednum)
  local item = Item.Create(self._charLevelUpNeedItemId)
  local imageRecord = item:GetIcon()
  self._charLevelUpItemImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local record
  for _, id in ipairs(CClownEquip:GetAllIds()) do
    record = CClownEquip:GetRecorder(id)
    if record.equipid == self._data.equipid and record.level == self._data.weaponLv then
      break
    end
  end
  if not record then
    LogErrorFormat("AprilFoolsTowerCharacterInfoDialog", "no record in cclownequip with equipid %s level %s", self._data.equipid, self._data.weaponLv)
    return
  end
  item = Item.Create(record.itemid)
  imageRecord = item:GetIcon()
  self._equipLevelUpNeedItemImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._equipLevelUpItemImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = CImagePathTable:GetRecorder(record.equipimg) or DataCommon.DefaultImageAsset
  self._equipImg:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local equiplevelupneeditemcurrentnum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(record.itemid)
  self._equipLevelUpItemNumTxt:SetText(equiplevelupneeditemcurrentnum)
  self._equipLevelUpItemNumTxtRed:SetText(equiplevelupneeditemcurrentnum)
  local equiplevelupitemneednum = record.itemnum
  self._equipLevelUpItemNeedNumTxt:SetText(equiplevelupitemneednum)
  if equiplevelupneeditemcurrentnum >= equiplevelupitemneednum and 0 < equiplevelupitemneednum then
    self._weaponLevelUpBtn:SetInteractable(true)
    self._equipLevelUpItemNumTxtRed:SetActive(false)
    self._equipLevelUpItemNumTxt:SetActive(true)
  else
    self._weaponLevelUpBtn:SetInteractable(false)
    self._equipLevelUpItemNumTxtRed:SetActive(true)
    self._equipLevelUpItemNumTxt:SetActive(false)
  end
  if equiplevelupitemneednum == 0 then
    self._equipLevelMax:SetActive(true)
    self._weaponLevelUpBtn:SetActive(false)
    self._equipLevelUpItemNumTxtRed:SetActive(false)
    self._equipLevelUpItemNumTxt:SetActive(true)
  else
    self._equipLevelMax:SetActive(false)
  end
  local str = TextManager.GetText(CStringres:GetRecorder(1783).msgTextID)
  self._equipAttackNumTxt:SetText(string.gsub(str, "%$parameter1%$", record.addATK))
  self._equipHealthNumTxt:SetText(string.gsub(str, "%$parameter1%$", record.addHP))
  self._equipLvTxt:SetText(self._data.weaponLv)
  local rankRecord = CItemPinji:GetRecorder(record.rank)
  if rankRecord then
    imageRecord = CImagePathTable:GetRecorder(rankRecord.imageDir)
    self._equipFrame:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  else
    LogErrorFormat("AprilFoolsTowerCharacterInfoDialog", "wrong rank %s in cclownequip with equipid %s level %s, rank not in citempinji", record.rank, self._data.equipid, self._data.weaponLv)
  end
end

return AprilFoolsTowerCharacterInfoDialog
