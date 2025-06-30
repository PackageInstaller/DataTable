-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/shop/towerlegendboxbuydialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local UIManager = ((CS.PixelNeko).UI).UIManager
local UIRootOffsetMax = (UIManager.GetUiRootOffsetMax)()
local UIRootPanelOffsetMax = (UIManager.GetUiRootPanelOffsetMax)()
local TableFrame = require("framework.ui.frame.table.tableframe")
local Equip = require("logic.manager.experimental.types.equip")
local TowerLegendBoxBuyDialog = class("TowerLegendBoxBuyDialog", Dialog)
TowerLegendBoxBuyDialog.AssetBundleName = "ui/layouts.baseshop"
TowerLegendBoxBuyDialog.AssetName = "TowerLegendBoxBuy"
TowerLegendBoxBuyDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TowerLegendBoxBuyDialog
  ((TowerLegendBoxBuyDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._equip = nil
  self._downDataList = {}
  self._basePropRecord = {}
  self._time = 0
  self.showIndex = 0
end

TowerLegendBoxBuyDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._tipsPanel = self:GetChild("EquipTipsNew")
  self._icon = self:GetChild("EquipTipsNew/TipsBack/Top/EquipCell/BackGround/Icon")
  self._equipIcon = self:GetChild("Equip")
  self._characterIcon = self:GetChild("EquipTipsNew/TipsBack/Top/EquipCell/CharPhoto")
  self._characterBack = self:GetChild("EquipTipsNew/TipsBack/Top/EquipCell/CharBack")
  self._equipFrame = self:GetChild("EquipTipsNew/TipsBack/Top/EquipCell/BackGround/Frame")
  self._level = self:GetChild("EquipTipsNew/TipsBack/Top/Level/Num")
  self._levelLabelTxt = self:GetChild("EquipTipsNew/TipsBack/Top/Level/Txt")
  self._levelMax = self:GetChild("EquipTipsNew/TipsBack/Top/Level/NumMax")
  self._equipName = self:GetChild("EquipTipsNew/TipsBack/Top/EquipName")
  self._score = self:GetChild("EquipTipsNew/TipsBack/Top/Fight/Num")
  self._prop1_Icon = self:GetChild("EquipTipsNew/TipsBack/Prop1/Image")
  self._prop1_Name = self:GetChild("EquipTipsNew/TipsBack/Prop1/Name")
  self._prop1_Num = self:GetChild("EquipTipsNew/TipsBack/Prop1/Num")
  self._prop2_Panel = self:GetChild("EquipTipsNew/TipsBack/Prop2")
  self._prop2_Icon = self:GetChild("EquipTipsNew/TipsBack/Prop2/Image")
  self._prop2_Name = self:GetChild("EquipTipsNew/TipsBack/Prop2/Name")
  self._prop2_Num = self:GetChild("EquipTipsNew/TipsBack/Prop2/Num")
  self._panel = self:GetChild("EquipTipsNew/TipsBack/Frame")
  self._shipBtn = self:GetChild("SkipBtn")
  self._jobField = self:GetChild("EquipTipsNew/TipsBack/Top/Job/JobFrame")
  self._jobFullTxt = self:GetChild("EquipTipsNew/TipsBack/Top/Job/Txt")
  self._jobFrame = (TableFrame.Create)(self._jobField, self, false, false)
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  ;
  (self._frame):SetMargin(15, 0)
  self._width = (self:GetRootWindow()):GetRectSize()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
  ;
  (self._rootWindow):Subscribe_StateExitEvent(self.OnAnimationStateExit, self)
  ;
  (self._shipBtn):Subscribe_PointerClickEvent(self.OnSkip, self)
end

TowerLegendBoxBuyDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (self._jobFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

TowerLegendBoxBuyDialog.Init = function(self, equipKey)
  -- function num : 0_3 , upvalues : _ENV
  local equip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(equipKey)
  do
    if not equip:IsChecked() then
      local cviewequip = (LuaNetManager.CreateProtocol)("protocol.item.cviewequip")
      if cviewequip then
        cviewequip.key = equipKey
        cviewequip:Send()
      end
    end
    self:RefreshInfo(equip)
  end
end

TowerLegendBoxBuyDialog.RefreshInfo = function(self, equip, isOtherUser)
  -- function num : 0_4 , upvalues : Equip, _ENV, CStringRes, CEquipItemTable, CAttrNameTable, CImagePathTable, Cequipbreakcfg
  if isOtherUser then
    self._equip = (Equip.Create)(equip.itemId)
    local iteminfo = {}
    iteminfo.extra = {}
    -- DECOMPILER ERROR at PC11: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (iteminfo.extra).equipType = equip.equipType
    -- DECOMPILER ERROR at PC14: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (iteminfo.extra).level = equip.level
    -- DECOMPILER ERROR at PC17: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (iteminfo.extra).stage = equip.stage
    -- DECOMPILER ERROR at PC20: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (iteminfo.extra).power = equip.power
    -- DECOMPILER ERROR at PC23: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (iteminfo.extra).baseAttr = equip.baseAttr
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (iteminfo.extra).finalAttr = equip.finalAttr
    -- DECOMPILER ERROR at PC29: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (iteminfo.extra).randomEntry = equip.randomEntry
    -- DECOMPILER ERROR at PC32: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (iteminfo.extra).range = equip.range
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (iteminfo.extra).recommend = equip.recommend
    ;
    (self._equip):InitWithFull(iteminfo)
    ;
    (self._levelLabelTxt):SetActive(false)
    ;
    (self._levelMax):SetActive(false)
  else
    do
      self._equip = equip
      local roleKey = ((self._equip):GetRoleKey())
      do
        local role = nil
        if roleKey ~= 0 then
          role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
        end
        ;
        (self._levelLabelTxt):SetActive(true)
        ;
        (self._levelMax):SetActive(true)
        local record = (self._equip):GetIcon()
        ;
        (self._icon):SetSprite(record.assetBundle, record.assetName)
        ;
        (self._equipIcon):SetSprite(record.assetBundle, record.assetName)
        record = (self._equip):GetPinJiImage()
        ;
        (self._equipFrame):SetSprite(record.assetBundle, record.assetName)
        ;
        (self._level):SetText((self._equip):GetStrengthenLevel())
        ;
        (self._levelMax):SetText((self._equip):GetStrengthenMaxLevel())
        ;
        (self._equipName):SetText((self._equip):GetName())
        ;
        (self._score):SetText((self._equip):GetScore())
        local roleKey = (self._equip):GetRoleKey()
        if roleKey and roleKey ~= 0 then
          local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
          ;
          (self._characterIcon):SetActive(true)
          ;
          (self._characterBack):SetActive(true)
          local imageRecord = role:GetSkillHeadImageRecord()
          ;
          (self._characterIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        else
          do
            ;
            (self._characterIcon):SetActive(false)
            ;
            (self._characterBack):SetActive(false)
            self._jobRecord = {}
            ;
            (self._jobField):SetActive(true)
            ;
            (table.insert)(self._jobRecord, (self._equip):GetApplyVocation())
            local str = (TextManager.GetText)((CStringRes:GetRecorder(1198)).msgTextID)
            ;
            (self._jobFullTxt):SetText(str)
            ;
            (self._jobFrame):ReloadAllCell()
            self._basePropRecord = {}
            record = CEquipItemTable:GetRecorder((self._equip):GetID())
            for i,v in ipairs(record.abilityID) do
              local temp = {}
              temp.attrId = v
              temp.value = (record.abilityValue)[i] * (record.initMagnify + ((self._equip):GetStrengthenLevel() - 1) + (self._equip):GetCurrentBreakMultiple())
              ;
              (table.insert)(self._basePropRecord, temp)
            end
            ;
            (table.sort)(self._basePropRecord, function(a, b)
    -- function num : 0_4_0
    do return a.attrId < b.attrId end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
            local propIndex = {firseProp = 1, secondProp = 2}
            local value = ((self._basePropRecord)[propIndex.firseProp]).value
            record = CAttrNameTable:GetRecorder(((self._basePropRecord)[propIndex.firseProp]).attrId)
            if not CImagePathTable:GetRecorder(record.classIcon) then
              local imageRecord = DataCommon.DefaultImageAsset
            end
            ;
            (self._prop1_Name):SetText((TextManager.GetText)(record.classnameTextID))
            ;
            (self._prop1_Num):SetText((math.ceil)(value))
            if (self._basePropRecord)[propIndex.secondProp] then
              value = ((self._basePropRecord)[propIndex.secondProp]).value
              record = CAttrNameTable:GetRecorder(((self._basePropRecord)[propIndex.secondProp]).attrId)
              if not CImagePathTable:GetRecorder(record.classIcon) then
                imageRecord = DataCommon.DefaultImageAsset
              end
              ;
              (self._prop2_Panel):SetActive(true)
              ;
              (self._prop2_Name):SetText((TextManager.GetText)(record.classnameTextID))
              ;
              (self._prop2_Num):SetText((math.ceil)(value))
            else
              ;
              (self._prop2_Panel):SetActive(false)
            end
            local randomWordList = (self._equip):GetRandomEntry()
            local cequipbreakcfgAll = (Cequipbreakcfg:GetAllIds())
            local unLockNumRecord = nil
            for i,id in pairs(cequipbreakcfgAll) do
              local record = Cequipbreakcfg:GetRecorder(id)
              if (self._equip):GetPinJiID() == record.pinJi and (self._equip):GetStage() == record.breaklv then
                unLockNumRecord = record.unlockAbilityNum
              end
            end
            self._downDataList = {}
            for i,v in pairs(randomWordList) do
              local temp = {}
              temp.tag = "RandomProp"
              temp.attrId = v.attr
              temp.value = v.attrValue
              temp.randomAbilityId = v.randomId
              temp.randomIndex = v.index
              temp.kind = v.kind
              ;
              (table.insert)(self._downDataList, temp)
            end
            local suitRecorder = (self._equip):GetEquipSuitRecorder()
            if suitRecorder then
              local temp = {}
              temp.tag = "SuitInfo"
              temp.suitName = suitRecorder.suitName
              temp.suitImg = suitRecorder.suitImg
              ;
              (table.insert)(self._downDataList, temp)
              local skillIDs = suitRecorder.suitSkillID
              for i,v in ipairs(skillIDs) do
                if v ~= 0 then
                  temp = {}
                  temp.tag = "SuitSkill"
                  temp.count = i
                  temp.skillID = v
                  ;
                  (table.insert)(self._downDataList, temp)
                end
              end
            end
            do
              local temp = {tag = "Describe", value = (self._equip):GetDestribe()}
              ;
              (table.insert)(self._downDataList, temp)
              ;
              (self._frame):ReloadAllCell()
              ;
              (self._frame):MoveToTop()
              self:GetDownLogicCell()
            end
          end
        end
      end
    end
  end
end

TowerLegendBoxBuyDialog.OnUpdate = function(self, notification)
  -- function num : 0_5
  if not self.showOneByOneEnd and self._animationEnd then
    self._time = self._time + (notification.userInfo).deltaTime
    if self._time > 1 then
      self.showIndex = self.showIndex + 1
      if ((self._downLogicCell)[self.showIndex])._cell then
        ((((self._downLogicCell)[self.showIndex])._cell):GetRootWindow()):SetActive(true)
      end
      self._time = 0
    end
    if self.showIndex == #self._downLogicCell then
      self.showOneByOneEnd = true
    end
  end
end

TowerLegendBoxBuyDialog.OnAnimationStateExit = function(self, handler, stateName, normalizedTime)
  -- function num : 0_6
  if stateName == "LegendBoxOpen" then
    self._animationEnd = true
  end
end

TowerLegendBoxBuyDialog.GetDownLogicCell = function(self)
  -- function num : 0_7 , upvalues : _ENV
  self._downLogicCell = {}
  for i = 1, #self._downDataList do
    local tempLogicCell = (self._frame):GetLogicCell(i)
    if tempLogicCell._cell then
      ((tempLogicCell._cell):GetRootWindow()):SetActive(false)
    end
    ;
    (table.insert)(self._downLogicCell, tempLogicCell)
  end
end

TowerLegendBoxBuyDialog.OnScreenPixelChanged = function(self)
  -- function num : 0_8
  self._screenPixelChanged = true
end

TowerLegendBoxBuyDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_9
  if frame == self._jobFrame then
    return #self._jobRecord
  else
    return #self._downDataList
  end
end

TowerLegendBoxBuyDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._jobFrame then
    return "equip.equipbagjobcell"
  else
    if ((self._downDataList)[index]).tag == "RandomProp" then
      return "equip.equiptiprandompropcell"
    else
      if ((self._downDataList)[index]).tag == "SuitInfo" then
        return "equip.equiptipssuitinfocell"
      else
        if ((self._downDataList)[index]).tag == "SuitSkill" then
          return "equip.equiptipssuitskillcell"
        else
          if ((self._downDataList)[index]).tag == "RandomSkill" then
            return "equip.equiptipskillcell"
          else
            if ((self._downDataList)[index]).tag == "Describe" then
              return "equip.equiptipdescribecell"
            end
          end
        end
      end
    end
  end
end

TowerLegendBoxBuyDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._jobFrame then
    return (self._jobRecord)[index]
  else
    return (self._downDataList)[index]
  end
end

TowerLegendBoxBuyDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_12 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self._tipsPanel)._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

TowerLegendBoxBuyDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13
  if self.showOneByOneEnd then
    self:Destroy()
  end
end

TowerLegendBoxBuyDialog.OnSkip = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (self:GetRootWindow()):PlayAnimation("LegendBoxHold")
  self.showOneByOneEnd = true
  for i,v in ipairs(self._downLogicCell) do
    if v._cell then
      ((v._cell):GetRootWindow()):SetActive(true)
    end
  end
end

return TowerLegendBoxBuyDialog

