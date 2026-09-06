local TableFrame = require("framework.ui.frame.table.tableframe")
local UniqueEquip = require("logic.manager.experimental.types.uniqueequip")
local Item = require("logic.manager.experimental.types.item")
local MoveDelta = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(107).Value)
local temp1 = string.split(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(110).Value, ";")
local Grey_r, Grey_g, Grey_b, Grey_a = tonumber(temp1[1]), tonumber(temp1[2]), tonumber(temp1[3]), tonumber(temp1[4])
local Init_r, Init_g, Init_b, Init_a = 1, 1, 1, 1
local UniqueEquipDialog = class("UniqueEquipDialog", Dialog)
UniqueEquipDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
UniqueEquipDialog.AssetName = "CharEquip"

function UniqueEquipDialog:Ctor(...)
  UniqueEquipDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._costItemList = {}
  self._attrList = {}
end

function UniqueEquipDialog:OnCreate()
  self._name = self:GetChild("Panel/Top/Name")
  self._width, self._height = self._name:GetRectSize()
  self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMinX, self._offsetMinY, self._offsetMaxX, self._offsetMaxY = self._name:GetAnchorAndOffset()
  self._img = self:GetChild("Equip")
  self._openLevelLimitTxt = self:GetChild("Panel/Top/Txt")
  self._openLevelLimitTxt:SetText(NekoData.BehaviorManager.BM_Message:GetString(1553))
  self._openLevelLimitPanel = self:GetChild("Panel/Up")
  self._unlockBtn = self:GetChild("Panel/UnlockBtn")
  self._haveOpenedLevelLimitTxt = self:GetChild("Panel/LevelOpen")
  self:GetChild("Panel/LevelOpen/LevelOpen"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1554))
  self._levelPanel = self:GetChild("Panel/Top/Name/Level")
  self._levelPanel_num = self:GetChild("Panel/Top/Name/Level/LevelNum")
  self._levelUpCostPanel = self:GetChild("Panel/Cost")
  self._levelUpCostPanel_itemPanel = self:GetChild("Panel/Cost/Item")
  self._levelUpCostPanel_manaNum = self:GetChild("Panel/Cost/Txt2")
  self._levelUpCostPanel_manaNumRed = self:GetChild("Panel/Cost/Txt2Red")
  self._levelUpCostPanel_btn = self:GetChild("Panel/Cost/Btn")
  self._levelUpCostPanel_itemFrame = TableFrame.Create(self._levelUpCostPanel_itemPanel, self, false, false)
  self._unlockTitle = self:GetChild("Panel/Panel/Txt1")
  self._unlockEffect = self:GetChild("Panel/Panel/Txt2/Txt2")
  self._unlockEffect_width, self._unlockEffect_height = self._unlockEffect:GetRectSize()
  self._anchorMinX1, self._anchorMinY1, self._anchorMaxX1, self._anchorMaxY1, self._offsetMinX1, self._offsetMinY1, self._offsetMaxX1, self._offsetMaxY1 = self._unlockEffect:GetAnchorAndOffset()
  self._iBtn = self:GetChild("Panel/Panel/Ibtn")
  self._panel = self:GetChild("Panel/Panel")
  self._anchoredx, self._anchoredy = self._panel:GetAnchoredPosition()
  self._propPanel = self:GetChild("Panel/Panel/Property")
  self._propFrame = TableFrame.Create(self._propPanel, self, true, true, true)
  self._arriveLimitPanel = self:GetChild("Panel/Max")
  self:GetChild("Panel/Max/Txt"):SetText(NekoData.BehaviorManager.BM_Message:GetString(1562))
  self._switchBtn = self:GetChild("SwitchBtn")
  self._switchBtnTip = self:GetChild("SwitchBtn/Txt")
  self._switchBtnTip:SetText(NekoData.BehaviorManager.BM_Message:GetString(1733))
  self._manaText = self:GetChild("TopGroup/Num1/Text")
  self._manaBtn = self:GetChild("TopGroup/Num1")
  self._manaBtn:Subscribe_PointerClickEvent(self.OnManaBtnClicked, self)
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._inDungeon = GlobalGameFSM:GetCurrentState() == "Dungeon"
  local dialog = DialogManager.GetDialog("battle.battleaccount.battlelosetextdialog")
  if dialog then
    self._tagFromBattleLoseDialog = dialog._selectGuideType.tag
  end
  if self._inDungeon or self._tagFromBattleLoseDialog then
    self._menuBtn:SetActive(false)
  end
  self._iBtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._unlockBtn:Subscribe_PointerClickEvent(self.OnUnlockBtnClicked, self)
  self._levelUpCostPanel_btn:Subscribe_PointerClickEvent(self.OnLevelUpBtnClicked, self)
  self._switchBtn:Subscribe_PointerClickEvent(self.OnSwitchBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnUniqueEquipLevelUp, Common.n_UniqueEquipLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  UIBackManager.SetUIBackShow(true)
  UIBackManager.SetUIModalBackColor(2)
  self:OnRefreshCurrency()
end

function UniqueEquipDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._levelUpCostPanel_itemFrame:Destroy()
  self._propFrame:Destroy()
  DialogManager.DestroySingletonDialog("uniqueequip.uniqueequipskilldialog")
  UIBackManager.SetUIBackShow(false)
end

function UniqueEquipDialog:HideUnlockBtn()
  self._hideUnlockBtn = true
end

local function RefreshShow(self)
  if self._role then
    self._uniqueEquipLevel = self._role:GetUniqueEquipLevel()
  end
  if self._role and self._uniqueEquipLevel > 0 then
    self._switchBtn:SetActive(true)
    self:RefreshSkillOpen()
  else
    self._switchBtn:SetActive(false)
  end
  while self._attrList[#self._attrList] do
    table.remove(self._attrList, #self._attrList)
  end
  if self._uniqueEquipLevel < 1 then
    self._img:SetColor(CS.UnityEngine.Color(Grey_r, Grey_g, Grey_b, Grey_a))
    self._openLevelLimitTxt:SetActive(true)
    self._openLevelLimitPanel:SetActive(true)
    if self._hideUnlockBtn then
      self._unlockBtn:SetActive(false)
    else
      self._unlockBtn:SetActive(true)
    end
    self._haveOpenedLevelLimitTxt:SetActive(false)
    self._levelPanel:SetActive(false)
    self._levelUpCostPanel:SetActive(false)
    self._arriveLimitPanel:SetActive(false)
    local unlockSkillId = self._uniqueEquipItem:GetCurShowSkillIdByLevel(1)
    if unlockSkillId then
      self._unlockTitle:SetActive(true)
      self._unlockEffect:SetActive(true)
      self._unlockTitle:SetText(NekoData.BehaviorManager.BM_Message:GetString(1555))
      local extraSkillDestribe = self._uniqueEquipItem:GetExtraSkillDestribeByLevel(1)
      self._unlockEffect:SetText(NekoData.BehaviorManager.BM_Message:GetUniqueEquipSkillDescribe(unlockSkillId) .. extraSkillDestribe)
    else
      self._unlockTitle:SetActive(false)
      self._unlockEffect:SetActive(false)
    end
    local initAttrs = self._uniqueEquipItem:GetInitAttrs()
    for k, v in pairs(initAttrs) do
      table.insert(self._attrList, {attrId = k, attrValue = v})
    end
  else
    self._img:SetColor(CS.UnityEngine.Color(Init_r, Init_g, Init_b, Init_a))
    self._panel:SetAnchoredPosition(self._anchoredx, self._anchoredy - MoveDelta)
    self._openLevelLimitTxt:SetActive(false)
    self._openLevelLimitPanel:SetActive(false)
    self._unlockBtn:SetActive(false)
    self._haveOpenedLevelLimitTxt:SetActive(true)
    self._levelPanel:SetActive(true)
    self._levelPanel_num:SetText(self._uniqueEquipLevel)
    self._unlockTitle:SetActive(true)
    if self._uniqueEquipLevel < self._uniqueEquipItem:GetMaxLevel() then
      self._levelUpCostPanel:SetActive(true)
      self._arriveLimitPanel:SetActive(false)
      self._costItemList = self._uniqueEquipItem:GetNextLevelCostItemList(self._uniqueEquipLevel)
      self._levelUpCostPanel_itemFrame:ReloadAllCell()
      local costManaNum = self._uniqueEquipItem:GetNextLevelCostManaNum(self._uniqueEquipLevel)
      local costEnough = true
      local mana = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID)
      if costManaNum > mana then
        self._levelUpCostPanel_manaNum:SetActive(false)
        self._levelUpCostPanel_manaNumRed:SetActive(true)
        self._levelUpCostPanel_manaNumRed:SetText(costManaNum)
        costEnough = false
      else
        self._levelUpCostPanel_manaNum:SetActive(true)
        self._levelUpCostPanel_manaNumRed:SetActive(false)
        self._levelUpCostPanel_manaNum:SetText(costManaNum)
      end
      if costEnough then
        for i, v in ipairs(self._costItemList) do
          if costEnough then
            local haveNum
            if string.sub(v.itemId, 1, 2) == "35" then
              haveNum = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(v.itemId)
            else
              haveNum = NekoData.BehaviorManager.BM_BagInfo:GetItemCountById(v.itemId)
            end
            costEnough = haveNum >= v.itemNum
          end
        end
      end
      self._levelUpCostPanel_btn:SetInteractable(costEnough)
      local nextLevel = self._uniqueEquipItem:GetNextLvStrengthenSkillByLevel(self._uniqueEquipLevel)
      if nextLevel then
        self._unlockTitle:SetText(NekoData.BehaviorManager.BM_Message:GetString(1556, {nextLevel}))
      else
        self._unlockTitle:SetText(NekoData.BehaviorManager.BM_Message:GetString(1557))
      end
    else
      self._levelUpCostPanel:SetActive(false)
      self._arriveLimitPanel:SetActive(true)
      self._unlockTitle:SetText(NekoData.BehaviorManager.BM_Message:GetString(1557))
    end
    local skillId = self._uniqueEquipItem:GetCurShowSkillIdByLevel(self._uniqueEquipLevel)
    if skillId then
      self._unlockEffect:SetActive(true)
      local extraSkillDestribe = self._uniqueEquipItem:GetExtraSkillDestribeByLevel(self._uniqueEquipLevel)
      self._unlockEffect:SetText(NekoData.BehaviorManager.BM_Message:GetUniqueEquipSkillDescribe(skillId) .. extraSkillDestribe)
    else
      self._unlockTitle:SetActive(false)
      self._unlockEffect:SetActive(false)
    end
    local curAttrs = self._role:GetUniqueEquipCurAttrs()
    local nextAttrs = self._role:GetUniqueEquipNextAttrs()
    local attrs = {}
    for k, v in pairs(curAttrs) do
      attrs[k] = {attrId = k, attrValue = v}
    end
    for k, v in pairs(nextAttrs) do
      local curValue = curAttrs[k]
      if curValue then
        if v ~= curValue then
          attrs[k].nextValue = v
        end
      else
        attrs[k] = {
          attrId = k,
          attrValue = 0,
          nextValue = v
        }
      end
    end
    for k, v in pairs(attrs) do
      if not v.nextValue and v.attrValue ~= 0 or v.nextValue and v.nextValue ~= v.attrValue then
        table.insert(self._attrList, v)
      end
    end
  end
  local textwidth, textheight = self._unlockEffect:GetPreferredSize()
  if textheight > self._unlockEffect_height then
    local delta = textheight - self._unlockEffect_height
    self._unlockEffect:SetAnchorAndOffset(self._anchorMinX1, self._anchorMinY1, self._anchorMaxX1, self._anchorMaxY1, self._offsetMinX1, self._offsetMinY1 - delta, self._offsetMaxX1, self._offsetMaxY1)
  else
    self._unlockEffect:SetAnchorAndOffset(self._anchorMinX1, self._anchorMinY1, self._anchorMaxX1, self._anchorMaxY1, self._offsetMinX1, self._offsetMinY1, self._offsetMaxX1, self._offsetMaxY1)
  end
  table.sort(self._attrList, function(a, b)
    return self._uniqueEquipItem:GetIndexByAttrId(a.attrId) < self._uniqueEquipItem:GetIndexByAttrId(b.attrId)
  end)
  self._propFrame:ReloadAllCell()
  self._propFrame:MoveToTop()
end

function UniqueEquipDialog:RefreshByProtocol(protocol)
  if protocol.roleId == self._uniqueEquipItem:GetRoleId() then
    RefreshShow(self)
  end
end

function UniqueEquipDialog:OnUniqueEquipLevelUp(notification)
  if self._role and notification.userInfo.roleId == self._role:GetRoleId() then
    self._sendProtocol = false
    RefreshShow(self)
  end
end

function UniqueEquipDialog:RefreshSkillOpen()
  self._switchBtn:SetSelected(not self._role:IsOpenUniqueEquipSkill())
end

function UniqueEquipDialog:RefreshSkillOpenByProtocol(protocol)
  if protocol.roleId == self._uniqueEquipItem:GetRoleId() then
    self:RefreshSkillOpen()
    self._sendProtocol_switchBtn = false
  end
end

function UniqueEquipDialog:SetData(uniqueEquipId, byRole)
  self._uniqueEquipItem = UniqueEquip.Create(uniqueEquipId)
  if byRole then
    self._role = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._uniqueEquipItem:GetRoleId())
  else
    self._uniqueEquipLevel = 0
  end
  self._name:SetText(self._uniqueEquipItem:GetName())
  local textwidth, textheight = self._name:GetPreferredSize()
  self._name:SetAnchorAndOffset(self._anchorMinX, self._anchorMinY, self._anchorMaxX, self._anchorMaxY, self._offsetMinX, self._offsetMinY, self._offsetMaxX + textwidth - self._width, self._offsetMaxY)
  local imageRecord = self._uniqueEquipItem:GetIcon()
  self._img:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  RefreshShow(self)
  if self._role and self._uniqueEquipLevel > 0 then
    local curAttrs = self._role:GetUniqueEquipCurAttrs()
    if table.nums(curAttrs) == 0 then
      local CGetSpecialWeaponInfo = LuaNetManager.CreateProtocol("protocol.item.cgetspecialweaponinfo")
      CGetSpecialWeaponInfo.roleId = self._uniqueEquipItem:GetRoleId()
      CGetSpecialWeaponInfo:Send()
    end
  end
end

function UniqueEquipDialog:NumberOfCell(frame, index)
  if frame == self._levelUpCostPanel_itemFrame then
    return #self._costItemList
  else
    return #self._attrList
  end
end

function UniqueEquipDialog:CellAtIndex(frame, index)
  if frame == self._levelUpCostPanel_itemFrame then
    return "skill.skillitemcell"
  else
    return "uniqueequip.uniqueequipattrcell"
  end
end

function UniqueEquipDialog:DataAtIndex(frame, index)
  if frame == self._levelUpCostPanel_itemFrame then
    return self._costItemList[index]
  else
    return self._attrList[index]
  end
end

function UniqueEquipDialog:OnIBtnClicked()
  DialogManager.CreateSingletonDialog("uniqueequip.uniqueequipskilldialog"):SetData(self._uniqueEquipItem)
end

function UniqueEquipDialog:OnUnlockBtnClicked()
  if self._inDungeon or self._tagFromBattleLoseDialog then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100370)
    return
  end
  local unlockJumpType = self._uniqueEquipItem:GetUnlockJumpType()
  if unlockJumpType == 1 then
    NekoData.DataManager.DM_Shop:ClientSetOpenShopID(DataCommon.UniqueEquipShopId)
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  elseif unlockJumpType == 2 then
    self._openShopAccumulationDialog = true
    NekoData.DataManager.DM_Shop:ClientSetOpenShopID(DataCommon.AccumulationShopId)
    local protocol = LuaNetManager.CreateProtocol("protocol.shop.copenshop")
    if protocol then
      protocol:Send()
    end
  end
end

function UniqueEquipDialog:OnLevelUpBtnClicked()
  if self._inDungeon or self._tagFromBattleLoseDialog then
    NekoData.BehaviorManager.BM_Message:SendMessageById(100370)
    return
  end
  if not self._sendProtocol then
    local nextLevel = self._uniqueEquipLevel + 1
    NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(119, {
      self._uniqueEquipItem:GetName(),
      nextLevel
    }, function()
      local CSpecialWeaponlvUp = LuaNetManager.CreateProtocol("protocol.item.cspecialweaponlvup")
      CSpecialWeaponlvUp.roleId = self._uniqueEquipItem:GetRoleId()
      CSpecialWeaponlvUp:Send()
      self._sendProtocol = true
    end, {}, nil, {})
  end
end

function UniqueEquipDialog:OnSwitchBtnClicked()
  if not self._sendProtocol_switchBtn then
    local CSpecialWeaponSkillSwitch = LuaNetManager.CreateProtocol("protocol.item.cspecialweaponskillswitch")
    CSpecialWeaponSkillSwitch.roleId = self._uniqueEquipItem:GetRoleId()
    CSpecialWeaponSkillSwitch:Send()
    self._sendProtocol_switchBtn = true
  end
end

function UniqueEquipDialog:OnRefreshCurrency()
  self._manaText:SetNumber(NekoData.BehaviorManager.BM_Currency:GetMoney())
end

function UniqueEquipDialog:OnManaBtnClicked()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.ManaID)
    })
    local width, height = self._manaBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._manaBtn:GetLocalPointInUiRootPanel())
  end
end

function UniqueEquipDialog:OnBackBtnClicked()
  self:Destroy()
end

function UniqueEquipDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return UniqueEquipDialog
