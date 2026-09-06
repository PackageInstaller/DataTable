local AnimationHelper = CS.PixelNeko.Animation.AnimationHelper
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local CUpdateUISortType = require("protocols.def.protocol.login.cupdateuisorttype")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local Cequipbreakcfg = BeanManager.GetTableByName("equip.cequipbreakcfg")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local CMessageTip = BeanManager.GetTableByName("message.cmessagetip")
local CEquipItemTable = BeanManager.GetTableByName("item.cequipitem")
local CGemSuitTable = BeanManager.GetTableByName("equip.cbaoshisuit")
local ColumnsNum = 5
local MinRowNum = 3
local BottomToTop = 3
local BreakTimesString = {
  [0] = TextManager.GetText(CMessageTip:GetRecorder(100146).msgTextID),
  TextManager.GetText(CMessageTip:GetRecorder(100147).msgTextID),
  TextManager.GetText(CMessageTip:GetRecorder(100148).msgTextID),
  TextManager.GetText(CMessageTip:GetRecorder(100149).msgTextID),
  TextManager.GetText(CMessageTip:GetRecorder(100150).msgTextID)
}
local EquipBagTabCell = class("EquipBagTabCell", Dialog)
EquipBagTabCell.AssetBundleName = "ui/layouts.equip"
EquipBagTabCell.AssetName = "EquipList"

function EquipBagTabCell:Ctor(...)
  EquipBagTabCell.super.Ctor(self, ...)
  self._bagEquipList = {}
  self._screeningConditions = {}
  self._sortCriteriaNameId = 1500042
  self._isAscendingOrder = false
  self._listByConditions = {}
  self._isLock = false
  self._downDataList = {}
end

function EquipBagTabCell:OnCreate()
  self._manaBtn = self:GetChild("TopGroup/Num1")
  self._manaTxt = self:GetChild("TopGroup/Num1/Text")
  self._diamondBtn = self:GetChild("TopGroup/Num2")
  self._diamondTxt = self:GetChild("TopGroup/Num2/Text")
  self._manaBtn:Subscribe_PointerClickEvent(self.OnManaBtnClick, self)
  self._diamondBtn:Subscribe_PointerClickEvent(self.OnDiamondBtnClick, self)
  self._filterBtn = self:GetChild("FliterBtn")
  self._levelBtn = self:GetChild("LevelBtn")
  self._levelBtnTxt = self:GetChild("LevelBtn/_Text")
  self._sortBtn = self:GetChild("SortBtn")
  self._sortUpBtnImg = self:GetChild("SortBtn/Up")
  self._sortUpBtnImg:SetActive(self._isAscendingOrder)
  self._sortDownBtnImg = self:GetChild("SortBtn/Down")
  self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt = self:GetChild("SortBtn/_TextUp")
  self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt = self:GetChild("SortBtn/_TextDown")
  self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  self._filterBtn:Subscribe_PointerClickEvent(self.OnFilterBtnClick, self)
  self._levelBtn:Subscribe_PointerClickEvent(self.OnLevelBtnClick, self)
  self._sortBtn:Subscribe_PointerClickEvent(self.OnSortBtnClick, self)
  self._filterPanel = self:GetChild("BaseCharacterListFliterNew")
  self._filterDlg = require("logic.dialog.common.filterdialog").Create(self._filterPanel)
  self._resolveBtn = self:GetChild("ResolveBtn")
  self._resolveBtn:Subscribe_PointerClickEvent(self.OnResolveBtnClick, self)
  self._num = self:GetChild("Page/Num")
  self._totalNum = self:GetChild("Page/Total")
  self._totalNum:SetText(NekoData.BehaviorManager.BM_BagInfo:GetBagCapacityByType(LuaNetManager.GetBeanDef("protocol.item.beans.bagtypes").EQUIPBAG))
  self._panel = self:GetChild("ItemFrame")
  self._empty = self:GetChild("Empty")
  self._frame = GridFrame.Create(self._panel, self, true, ColumnsNum)
  self._scrollBar = self:GetChild("Scrollbar")
  self._scrollBar:SetScrollDirection(3)
  self._left_panel = self:GetChild("Left")
  self._left_back = self:GetChild("Left/LeftBack")
  self._left_rank = self:GetChild("Left/Top/EquipCell/BackGround/Frame")
  self._left_icon = self:GetChild("Left/Top/EquipCell/BackGround/Icon")
  self._left_pinJiStar = self:GetChild("Left/Top/EquipCell/BackGround/BreakPoint")
  self._left_charPhotoBack = self:GetChild("Left/Top/EquipCell/BackGround/CharBack")
  self._left_charPhoto = self:GetChild("Left/Top/EquipCell/BackGround/CharPhoto")
  self._left_specialFMImage = self:GetChild("Left/Top/EquipCell/BackGround/FuMo")
  self._left_score = self:GetChild("Left/Top/Fight/Num")
  self._left_equipName = self:GetChild("Left/Top/EquipName")
  self._left_jobField = self:GetChild("Left/Top/Job/JobFrame")
  self._left_jobFullTxt = self:GetChild("Left/Top/Job/Txt")
  self._left_lv = self:GetChild("Left/Level/Num")
  self._left_lvMax = self:GetChild("Left/Level/NumMax")
  self._left_field = self:GetChild("Left/Frame")
  self._left_lockBtn = self:GetChild("Left/LockBtn")
  self._left_forgeBtn = self:GetChild("Left/ForgeBtn")
  self._left_lockBtn:Subscribe_PointerClickEvent(self.OnLockBtnClick, self)
  self._left_forgeBtn:Subscribe_PointerClickEvent(self.OnForgeBtnClick, self)
  self._left_frame = TableFrame.Create(self._left_field, self, true, true, true)
  self._left_frame:SetMargin(15, 0)
  self._left_jobFrame = TableFrame.Create(self._left_jobField, self, false, false)
  self._animator = self._rootWindow:GetUIObject():GetComponent("Animator")
  local uiSortInfo = NekoData.BehaviorManager.BM_Game:GetUISortType(CUpdateUISortType.EQUIPMENT_LIST)
  if uiSortInfo then
    self._sortCriteriaNameId = uiSortInfo.nameTxtId or self._sortCriteriaNameId
    self._isAscendingOrder = uiSortInfo.isAscending or self._isAscendingOrder
    self._sortUpBtnImg:SetActive(self._isAscendingOrder)
    self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
    self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
    self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  end
  self:RefreshTabCell()
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EnchantEquip, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipBreak, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipExpUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_EquipGemSetting, nil)
  LuaNotificationCenter.AddObserver(self, self.OnItemRemove, Common.n_ItemRemove, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefresh, Common.n_DecomposeEquips, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEquipIdentifySuccess, Common.n_EquipIdentifySuccess, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEquipLockStateChanged, Common.n_EquipLockStateChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEquipChecked, Common.n_EquipChecked, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAPChange, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnFindCachedPreFM, Common.n_FindCachedPreFM, nil)
end

function EquipBagTabCell:OnDestroy()
  self._frame:Destroy()
  self._left_frame:Destroy()
  self._left_jobFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._filterDlg then
    self._filterDlg:Destroy()
    self._filterDlg = nil
  end
  self:SendCUpdateUISortType()
end

function EquipBagTabCell:OnEquipIdentifySuccess(notification)
  self._frame:FireEvent("EquipIdentifySuccess", notification.userInfo)
end

function EquipBagTabCell:OnRefresh(notification)
  self:RefreshTabCell()
end

function EquipBagTabCell:OnItemRemove(notification)
  while self._bagEquipList[#self._bagEquipList] do
    table.remove(self._bagEquipList, #self._bagEquipList)
  end
  for i, v in ipairs(NekoData.BehaviorManager.BM_BagInfo:GetEquipList()) do
    table.insert(self._bagEquipList, v)
  end
  if notification.userInfo.itemKey then
    local index = self:GetCellIndex(notification.userInfo.itemKey)
    if index then
      self._frame:RemoveCellsAtIndex({index})
      table.remove(self._listByConditions, index)
      local num = #self._listByConditions
      local minLatticeNum = ColumnsNum * MinRowNum
      if num < minLatticeNum then
        self._frame:InsertCellsAtIndex({minLatticeNum})
      elseif num < math.ceil(num / ColumnsNum) * ColumnsNum then
        self._frame:InsertCellsAtIndex({
          math.ceil(num / ColumnsNum) * ColumnsNum
        })
      elseif num == math.ceil(num / ColumnsNum) * ColumnsNum then
        for i = 1, MinRowNum do
          if self._frame:GetLogicCell(num + 1) then
            self._frame:RemoveCellsAtIndex({
              num + 1
            })
          end
        end
      end
    end
    self._num:SetText(#self._listByConditions)
    self:RefreshTabCell()
  end
end

function EquipBagTabCell:GetCellIndex(key)
  for i, v in ipairs(self._listByConditions) do
    if v:GetKey() == key then
      return i
    end
  end
  return nil
end

function EquipBagTabCell:OnEquipLockStateChanged(notification)
  while self._bagEquipList[#self._bagEquipList] do
    table.remove(self._bagEquipList, #self._bagEquipList)
  end
  for i, v in ipairs(NekoData.BehaviorManager.BM_BagInfo:GetEquipList()) do
    table.insert(self._bagEquipList, v)
  end
  for i, v in ipairs(self._listByConditions) do
    local key = notification.userInfo.key
    if v:GetKey() == key then
      self._listByConditions[i] = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(key)
    end
  end
  self._frame:FireEvent("EquipLockStateChanged", notification.userInfo)
end

function EquipBagTabCell:OnEquipChecked(notification)
  while self._bagEquipList[#self._bagEquipList] do
    table.remove(self._bagEquipList, #self._bagEquipList)
  end
  for i, v in ipairs(NekoData.BehaviorManager.BM_BagInfo:GetEquipList()) do
    table.insert(self._bagEquipList, v)
  end
  for i, v in ipairs(self._listByConditions) do
    local key = notification.userInfo.key
    if v:GetKey() == key then
      self._listByConditions[i] = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(key)
    end
  end
  self._frame:FireEvent("EquipChecked", notification.userInfo)
end

function EquipBagTabCell:RefreshTabCell()
  while self._bagEquipList[#self._bagEquipList] do
    table.remove(self._bagEquipList, #self._bagEquipList)
  end
  for i, v in ipairs(NekoData.BehaviorManager.BM_BagInfo:GetEquipList()) do
    table.insert(self._bagEquipList, v)
  end
  if #self._bagEquipList > 0 then
    self._empty:SetActive(false)
    self._scrollBar:SetActive(true)
  else
    self._empty:SetActive(true)
    self._scrollBar:SetActive(false)
  end
  self._manaTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID))
  self._diamondTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
  self:ScreeningAndSorting()
end

function EquipBagTabCell:OnFindCachedPreFM(notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  local index = self:GetCellIndex(userInfo.lastKey)
  if index then
    self._frame:MoveTopToIndex(index)
    self:OnCellClicked(self._listByConditions[index])
  end
end

function EquipBagTabCell:OnResolveBtnClick()
  if DialogManager.GetDialog("equip.bagdialog") then
    DialogManager.CreateSingletonDialog("equip.equipresolvedialog")
  end
end

function EquipBagTabCell:OnManaBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.ManaID)
    })
    local width, height = self._manaBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._manaBtn:GetLocalPointInUiRootPanel())
  end
end

function EquipBagTabCell:OnDiamondBtnClick()
  local tipsDialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init({
      item = Item.Create(DataCommon.DiamodID)
    })
    local width, height = self._diamondBtn:GetRectSize()
    tipsDialog:SetTipsPosition(width, height, self._diamondBtn:GetLocalPointInUiRootPanel())
  end
end

function EquipBagTabCell:GetNumByEquipId(id)
  local count = 0
  for i, v in ipairs(self._listByConditions) do
    if v:GetID() == id then
      count = count + 1
    end
  end
  return count
end

function EquipBagTabCell:ScreeningAndSorting()
  self._levelBtnTxt:SetText(TextManager.GetText(self._sortCriteriaNameId))
  while self._listByConditions[#self._listByConditions] do
    table.remove(self._listByConditions, #self._listByConditions)
  end
  for i, v in ipairs(self._bagEquipList) do
    table.insert(self._listByConditions, v)
  end
  for k, v in pairs(self._screeningConditions) do
    local select = false
    if k == 1 then
      local indexMap = {}
      for index, value in ipairs(v) do
        select = true
        for i, equip in ipairs(self._listByConditions) do
          if value.nameid == 1500047 and equip:GetPinJiID() == 3 then
            indexMap[i] = i
          elseif value.nameid == 1500048 and equip:GetPinJiID() == 2 then
            indexMap[i] = i
          elseif value.nameid == 1500049 and equip:GetPinJiID() == 1 then
            indexMap[i] = i
          elseif value.nameid == 1500062 and equip:GetPinJiID() == 5 then
            indexMap[i] = i
          end
        end
      end
      if select then
        local deleteList = {}
        for i = 1, #self._listByConditions do
          if not indexMap[i] then
            table.insert(deleteList, i)
          end
        end
        while deleteList[#deleteList] do
          table.remove(self._listByConditions, deleteList[#deleteList])
          table.remove(deleteList, #deleteList)
        end
      end
    elseif k == 2 then
      local indexMap = {}
      for index, value in ipairs(v) do
        select = true
        for i, equip in ipairs(self._listByConditions) do
          if value.nameid == 1500043 and equip:GetEquipType() == EquipTypeEnum.WEAPON then
            indexMap[i] = i
          elseif value.nameid == 1500044 and equip:GetEquipType() == EquipTypeEnum.ARMOR then
            indexMap[i] = i
          elseif value.nameid == 1500045 and equip:GetEquipType() == EquipTypeEnum.JEWELRY then
            indexMap[i] = i
          end
        end
      end
      if select then
        local deleteList = {}
        for i = 1, #self._listByConditions do
          if not indexMap[i] then
            table.insert(deleteList, i)
          end
        end
        while deleteList[#deleteList] do
          table.remove(self._listByConditions, deleteList[#deleteList])
          table.remove(deleteList, #deleteList)
        end
      end
    elseif k == 3 then
      local indexMap = {}
      for index, value in ipairs(v) do
        select = true
        for i, equip in ipairs(self._listByConditions) do
          if equip:GetEquipSuitId() > 0 and value.nameid == 1500069 then
            indexMap[i] = i
          elseif equip:GetEquipSuitId() == 0 and value.nameid == 1500070 then
            indexMap[i] = i
          end
        end
      end
      if select then
        local deleteList = {}
        for i = 1, #self._listByConditions do
          if not indexMap[i] then
            table.insert(deleteList, i)
          end
        end
        while deleteList[#deleteList] do
          table.remove(self._listByConditions, deleteList[#deleteList])
          table.remove(deleteList, #deleteList)
        end
      end
    end
  end
  table.sort(self._listByConditions, function(a, b)
    local _a, _b
    if self._sortCriteriaNameId == 1500032 then
      _a = a:GetPinJiID()
      _b = b:GetPinJiID()
    elseif self._sortCriteriaNameId == 1500033 then
      _a = a:GetStrengthenLevel()
      _b = b:GetStrengthenLevel()
    elseif self._sortCriteriaNameId == 1500042 then
      _a = a:GetScore()
      _b = b:GetScore()
    elseif self._sortCriteriaNameId == 1500034 then
      _a = self:GetNumByEquipId(a:GetID())
      _b = self:GetNumByEquipId(b:GetID())
    elseif self._sortCriteriaNameId == 1500035 then
      _a = a:GetKey()
      _b = b:GetKey()
    elseif self._sortCriteriaNameId == 1500036 then
      _a = a:GetLimitEquip()
      _b = b:GetLimitEquip()
    elseif self._sortCriteriaNameId == 1500037 then
      _a = a:GetEquipMaxHp()
      _b = b:GetEquipMaxHp()
    elseif self._sortCriteriaNameId == 1500038 then
      _a = a:GetEquipATK()
      _b = b:GetEquipATK()
    elseif self._sortCriteriaNameId == 1500039 then
      _a = a:GetEquipMagAtk()
      _b = b:GetEquipMagAtk()
    elseif self._sortCriteriaNameId == 1500040 then
      _a = a:GetEquipDef()
      _b = b:GetEquipDef()
    elseif self._sortCriteriaNameId == 1500041 then
      _a = a:GetEquipMagDef()
      _b = b:GetEquipMagDef()
    end
    if _a == _b and self._sortCriteriaNameId ~= 1500035 then
      local aId, bId
      if self._sortCriteriaNameId == 1500032 or self._sortCriteriaNameId == 1500033 or self._sortCriteriaNameId == 1500042 then
        aId, bId = a:GetID(), b:GetID()
      end
      if aId == bId then
        local aKey, bKey
        aKey, bKey = a:GetKey(), b:GetKey()
        if self._isAscendingOrder then
          return aKey > bKey
        else
          return aKey < bKey
        end
      elseif self._isAscendingOrder then
        return aId < bId
      else
        return aId > bId
      end
    elseif self._isAscendingOrder then
      return _a < _b
    else
      return _a > _b
    end
  end)
  self._num:SetText(#self._listByConditions)
  self._frame:ReloadAllCell()
  self:OnCellClicked(self._listByConditions[1])
end

function EquipBagTabCell:OnFilterBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 1, "Equip", self._screeningConditions)
end

function EquipBagTabCell:OnLevelBtnClick()
  if not self._filterDlg then
    LogError("[Dialog]: ", "Common filter dlg create error")
    return
  end
  self._filterDlg:SetData(self, 2, "Equip", self._sortCriteriaNameId)
end

function EquipBagTabCell:OnSortBtnClick()
  self._isAscendingOrder = not self._isAscendingOrder
  self._sortUpBtnImg:SetActive(self._isAscendingOrder)
  self._sortDownBtnImg:SetActive(not self._isAscendingOrder)
  self._sortUpBtnTxt:SetActive(self._isAscendingOrder)
  self._sortDownBtnTxt:SetActive(not self._isAscendingOrder)
  self:ScreeningAndSorting()
  NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.EQUIPMENT_LIST, self._sortCriteriaNameId, self._isAscendingOrder)
end

function EquipBagTabCell:OnLockBtnClick()
  self._isLock = not self._isLock
  if self._isLock then
    self._frame:FireEvent("LockEquip", self._select:GetKey())
    self._left_lockBtn:SetSelected(true)
    local clockequip = LuaNetManager.CreateProtocol("protocol.item.clockequip")
    if clockequip then
      clockequip.key = self._select:GetKey()
      clockequip:Send()
    end
  else
    self._frame:FireEvent("UnLockEquip", self._select:GetKey())
    self._left_lockBtn:SetSelected(false)
    local clockequip = LuaNetManager.CreateProtocol("protocol.item.clockequip")
    if clockequip then
      clockequip.key = self._select:GetKey()
      clockequip:Send()
    end
  end
end

function EquipBagTabCell:OnForgeBtnClick()
  DialogManager.CreateSingletonDialog("equipforge.equipforgedialog"):Init(self._select:GetKey())
end

function EquipBagTabCell:SetSortCriteriaNameId(nameId)
  if nameId ~= self._sortCriteriaNameId then
    self._sortCriteriaNameId = nameId
    self:ScreeningAndSorting()
    NekoData.DataManager.DM_Game:RecorderUISortType(CUpdateUISortType.EQUIPMENT_LIST, self._sortCriteriaNameId, self._isAscendingOrder)
  end
end

function EquipBagTabCell:SetScreeningConditions(screeningConditions)
  self._screeningConditions = screeningConditions
  self:ScreeningAndSorting()
end

function EquipBagTabCell:OnCellClicked(data)
  if data then
    self._frame:FireEvent("SetSelectedEquip", data:GetKey())
    self._left_panel:SetActive(true)
    self._select = data
    local equipKey = data:GetKey()
    local equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(equipKey)
    if not equip:IsChecked() then
      local cviewequip = LuaNetManager.CreateProtocol("protocol.item.cviewequip")
      if cviewequip then
        cviewequip.key = equipKey
        cviewequip:Send()
      end
    end
    local record = equip:GetIcon()
    self._left_icon:SetSprite(record.assetBundle, record.assetName)
    self._left_pinJiStar:SetText(equip:GetEquipStarStr())
    local roleKey = equip:GetRoleKey()
    if roleKey ~= 0 then
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
      self._left_charPhoto:SetActive(true)
      self._left_charPhotoBack:SetActive(true)
      local imageRecord = role:GetSkillHeadImageRecord()
      self._left_charPhoto:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    else
      self._left_charPhoto:SetActive(false)
      self._left_charPhotoBack:SetActive(false)
    end
    record = equip:GetPinJiImage()
    self._left_rank:SetSprite(record.assetBundle, record.assetName)
    record = equip:GetBagInfoBackPinJiImage()
    self._left_back:SetSprite(record.assetBundle, record.assetName)
    self._left_lv:SetText(equip:GetStrengthenLevel())
    local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
    local maxLevel
    for i, value in ipairs(equipBreakCfgAllId) do
      local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
      if equipBreakCfgRecorder.pinJi == equip:GetPinJiID() and equipBreakCfgRecorder.breaklv == equip:GetStage() then
        maxLevel = equipBreakCfgRecorder.levelmax
      end
    end
    self._left_lvMax:SetText(maxLevel)
    self._left_equipName:SetText(equip:GetName())
    self._left_score:SetText(equip:GetScore())
    self._left_specialFMImage:SetActive(equip:GetFinalRandomEntry())
    if equip:GetFinalRandomEntry() then
      AnimationHelper.SetAnimatorInteger2(self._rootWindow:GetUIObject(), "par", 1)
    else
      AnimationHelper.SetAnimatorInteger2(self._rootWindow:GetUIObject(), "par", 0)
    end
    self._downDataList = {}
    local temp = {}
    temp.tag = "Title1"
    table.insert(self._downDataList, temp)
    local basePropRecord = {}
    record = CEquipItemTable:GetRecorder(equip:GetID())
    local baseRate = record.initMagnify + (equip:GetStrengthenLevel() - 1) + equip:GetCurrentBreakMultiple()
    for i, v in ipairs(record.abilityID) do
      local temp = {}
      temp.tag = "BaseProp"
      temp.attrId = v
      temp.value = math.ceil(record.abilityValue[i] * baseRate * (1 + equip:GetGemSuitAttrRate(v)))
      table.insert(basePropRecord, temp)
    end
    table.sort(basePropRecord, function(a, b)
      return a.attrId < b.attrId
    end)
    for i, v in ipairs(basePropRecord) do
      table.insert(self._downDataList, v)
    end
    temp = {}
    temp.tag = "Title2"
    table.insert(self._downDataList, temp)
    local randomWordList = data:GetRandomEntry()
    local cequipbreakcfgAll = Cequipbreakcfg:GetAllIds()
    local unLockNumRecord
    for i, id in pairs(cequipbreakcfgAll) do
      local record = Cequipbreakcfg:GetRecorder(id)
      if self._select:GetPinJiID() == record.pinJi and self._select:GetStage() == record.breaklv then
        unLockNumRecord = record.unlockAbilityNum
      end
    end
    for i, v in pairs(randomWordList) do
      local temp = {}
      temp.tag = "RandomProp"
      temp.attrId = v.attr
      temp.value = v.attrValue
      temp.randomAbilityId = v.randomId
      temp.randomIndex = v.index
      temp.kind = v.kind
      table.insert(self._downDataList, temp)
    end
    local gemsAttr = equip:GetGemAttr()
    if 0 < table.nums(gemsAttr) then
      temp = {}
      temp.tag = "Title1"
      temp.titleID = 702682
      table.insert(self._downDataList, temp)
      local gemShowAttrs = {}
      for attr, attrValue in pairs(gemsAttr) do
        temp = {}
        temp.tag = "GemProp"
        temp.attrId = attr
        temp.value = attrValue
        table.insert(gemShowAttrs, temp)
      end
      table.sort(gemShowAttrs, function(a, b)
        return a.attrId < b.attrId
      end)
      for _, v in ipairs(gemShowAttrs) do
        table.insert(self._downDataList, v)
      end
      local gemSuitID = equip:GetGemSuitId()
      if 0 < gemSuitID then
        local gemSuitCfg = CGemSuitTable:GetRecorder(gemSuitID)
        local suitNameData = {}
        suitNameData.tag = "GemSuit"
        suitNameData.showText = TextManager.GetText(gemSuitCfg.nameid)
        suitNameData.color = "FFFFFF"
        table.insert(self._downDataList, suitNameData)
        local suitEffectData = {}
        suitEffectData.tag = "GemSuit"
        suitEffectData.showText = NekoData.BehaviorManager.BM_Message:GetString(1046, {
          TextManager.GetText(gemSuitCfg.txtid)
        })
        suitEffectData.color = "81C65B"
        table.insert(self._downDataList, suitEffectData)
      end
    end
    local suit = equip:GetEquipSuitRecorder()
    if suit then
      local temp = {}
      temp.tag = "SuitInfo"
      temp.suitName = suit.suitName
      temp.suitImg = suit.suitImg
      table.insert(self._downDataList, temp)
      local skillIDs = suit.suitSkillID
      for i, v in ipairs(skillIDs) do
        if v ~= 0 then
          temp = {}
          temp.tag = "SuitSkill"
          temp.count = i
          temp.skillID = v
          table.insert(self._downDataList, temp)
        end
      end
    end
    local temp = {
      tag = "Describe",
      value = equip:GetDestribe()
    }
    table.insert(self._downDataList, temp)
    self._left_frame:ReloadAllCell()
    self._left_frame:MoveToTop()
    self._jobRecord = {}
    self._left_jobField:SetActive(true)
    local str = TextManager.GetText(CStringRes:GetRecorder(1198).msgTextID)
    self._left_jobFullTxt:SetText(str)
    table.insert(self._jobRecord, equip:GetApplyVocation())
    self._left_jobFrame:ReloadAllCell()
    self._isLock = equip:IsLocked()
    self._left_lockBtn:SetActive(true)
    if self._isLock then
      self._left_lockBtn:SetSelected(true)
    else
      self._left_lockBtn:SetSelected(false)
    end
  else
    self._left_panel:SetActive(false)
    self._left_lockBtn:SetActive(false)
  end
end

function EquipBagTabCell:NumberOfCell(frame)
  if frame == self._frame then
    local num = #self._listByConditions
    local minLatticeNum = ColumnsNum * MinRowNum
    if num < minLatticeNum then
      return minLatticeNum
    else
      local curRow = math.ceil(num / ColumnsNum)
      return curRow * ColumnsNum
    end
  elseif frame == self._left_frame then
    return #self._downDataList
  elseif frame == self._left_jobFrame then
    return #self._jobRecord
  end
end

function EquipBagTabCell:CellAtIndex(frame, index)
  if frame == self._frame then
    return "equip.equipbagcell"
  elseif frame == self._left_frame then
    if self._downDataList[index].tag == "BaseProp" then
      return "equip.equiplistbasicpropcell"
    elseif self._downDataList[index].tag == "RandomProp" then
      return "equip.equiplistrandompropcell"
    elseif self._downDataList[index].tag == "GemProp" then
      return "equip.equiplistgempropcell"
    elseif self._downDataList[index].tag == "GemSuit" then
      return "equip.equiplistgemsuitcell"
    elseif self._downDataList[index].tag == "SuitInfo" then
      return "equip.equipsuitinfocell"
    elseif self._downDataList[index].tag == "SuitSkill" then
      return "equip.equipsuitskillcell"
    elseif self._downDataList[index].tag == "Describe" then
      return "equip.equiplistdescribecell"
    elseif self._downDataList[index].tag == "Title1" then
      return "equip.equiplisttitlecell1"
    elseif self._downDataList[index].tag == "Title2" then
      return "equip.equiplisttitlecell2"
    end
  elseif frame == self._left_jobFrame then
    return "equip.equipbagjobcell"
  end
end

function EquipBagTabCell:DataAtIndex(frame, index)
  if frame == self._frame then
    return self._listByConditions[index]
  elseif frame == self._left_frame then
    return self._downDataList[index]
  elseif frame == self._left_jobFrame then
    return self._jobRecord[index]
  end
end

function EquipBagTabCell:GetSelectEquipKey()
  if self._select then
    return self._select:GetKey()
  else
    return nil
  end
end

function EquipBagTabCell:OnAPChange()
  self._manaTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.ManaID))
  self._diamondTxt:SetNumber(NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(DataCommon.DiamodID))
end

function EquipBagTabCell:OnCurPosChange(frame, proportion)
  if frame == self._frame then
    local width, height = self._panel:GetRectSize()
    local total = self._frame:GetTotalLength()
    if height < total then
      self._scrollBar:SetActive(true)
      self._scrollBar:SetScrollSize(height / total)
      self._scrollBar:SetScrollValue(proportion)
    else
      self._scrollBar:SetActive(false)
    end
  end
end

function EquipBagTabCell:SendCUpdateUISortType()
  local OrderType = {Ascending = 1, Descending = 2}
  local csend = LuaNetManager.CreateProtocol("protocol.login.cupdateuisorttype")
  csend.key = CUpdateUISortType.EQUIPMENT_LIST
  local order = OrderType.Ascending
  if not self._isAscendingOrder then
    order = OrderType.Descending
  end
  csend.Showtype = self._sortCriteriaNameId * 10 + order
  csend:Send()
end

function EquipBagTabCell:ShouldLengthChange()
  return true
end

return EquipBagTabCell
