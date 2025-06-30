-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equiptipsdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local UIManager = ((CS.PixelNeko).UI).UIManager
local UIRootOffsetMax = nil
local UIRootPanelOffsetMax = (UIManager.GetUiRootPanelOffsetMax)()
local TableFrame = require("framework.ui.frame.table.tableframe")
local Equip = require("logic.manager.experimental.types.equip")
local EquipTipsDialog = class("EquipTipsDialog", Dialog)
EquipTipsDialog.AssetBundleName = "ui/layouts.equip"
EquipTipsDialog.AssetName = "EquipTipsNew"
EquipTipsDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipTipsDialog, UIRootOffsetMax, UIManager
  ((EquipTipsDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._equip = nil
  self._downDataList = {}
  self._basePropRecord = {}
  UIRootOffsetMax = (UIManager.GetUiRootOffsetMax)()
end

EquipTipsDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._tipsBack = self:GetChild("TipsBack")
  self._icon = self:GetChild("TipsBack/Top/EquipCell/BackGround/Icon")
  self._characterIcon = self:GetChild("TipsBack/Top/EquipCell/CharPhoto")
  self._characterBack = self:GetChild("TipsBack/Top/EquipCell/CharBack")
  self._equipFrame = self:GetChild("TipsBack/Top/EquipCell/BackGround/Frame")
  self._level = self:GetChild("TipsBack/Top/Level/Num")
  self._levelLabelTxt = self:GetChild("TipsBack/Top/Level/Txt")
  self._levelMax = self:GetChild("TipsBack/Top/Level/NumMax")
  self._equipName = self:GetChild("TipsBack/Top/EquipName")
  self._score = self:GetChild("TipsBack/Top/Fight/Num")
  self._prop1_Icon = self:GetChild("TipsBack/Prop1/Image")
  self._prop1_Name = self:GetChild("TipsBack/Prop1/Name")
  self._prop1_Num = self:GetChild("TipsBack/Prop1/Num")
  self._prop2_Panel = self:GetChild("TipsBack/Prop2")
  self._prop2_Icon = self:GetChild("TipsBack/Prop2/Image")
  self._prop2_Name = self:GetChild("TipsBack/Prop2/Name")
  self._prop2_Num = self:GetChild("TipsBack/Prop2/Num")
  self._panel = self:GetChild("TipsBack/Frame")
  self._jobField = self:GetChild("TipsBack/Top/Job/JobFrame")
  self._jobFullTxt = self:GetChild("TipsBack/Top/Job/Txt")
  self._jobFrame = (TableFrame.Create)(self._jobField, self, false, false)
  self._frame = (TableFrame.Create)(self._panel, self, true, true, true)
  self._x = (self._panel):GetSize()
  self._rootX = (self:GetRootWindow()):GetSize()
  ;
  (self._tipsBack):Subscribe_PointerClickEvent(self.OnMouseClick, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnRootWindowClick, self)
  self._width = (self:GetRootWindow()):GetRectSize()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
end

EquipTipsDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (self._jobFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

EquipTipsDialog.Init = function(self, equipKey)
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

EquipTipsDialog.RefreshInfo = function(self, equip, isOtherUser)
  -- function num : 0_4 , upvalues : Equip, _ENV, CStringRes, CEquipItemTable, CAttrNameTable, CImagePathTable
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
    (iteminfo.extra).finalAttrRandomEntry = equip.finalAttrRandomEntry
    -- DECOMPILER ERROR at PC35: Confused about usage of register: R4 in 'UnsetPending'

    ;
    (iteminfo.extra).range = equip.range
    -- DECOMPILER ERROR at PC38: Confused about usage of register: R4 in 'UnsetPending'

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
            local suit = (self._equip):GetEquipSuitRecorder()
            if suit then
              local temp = {}
              temp.tag = "SuitInfo"
              temp.suitName = suit.suitName
              temp.suitImg = suit.suitImg
              ;
              (table.insert)(self._downDataList, temp)
              local skillIDs = suit.suitSkillID
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
              local totallength = (self._frame):GetTotalLength()
              local delta = totallength - self._oy
              if delta < 0 then
                (self._panel):SetSize(self._x, self._ox, self._y, self._oy + delta)
                ;
                (self:GetRootWindow()):SetSize(self._rootX, self._rootOX, self._rooty, self._rootOY + delta)
                ;
                (self._frame):SetSlide(false)
              end
              ;
              (self._frame):MoveToTop()
            end
          end
        end
      end
    end
  end
end

local SetTipsPosition = function(self, cell_width, cell_height, posX, posY)
  -- function num : 0_5 , upvalues : UIRootOffsetMax, UIRootPanelOffsetMax
  local newPos = {}
  local rightSpaceWidth = UIRootOffsetMax.x - (posX + cell_width / 2)
  if self._width < rightSpaceWidth then
    newPos.x = posX + cell_width / 2 + self._width / 2
  else
    newPos.x = posX - cell_width / 2 - self._width / 2
  end
  if posY + cell_height / 2 - self._height < -UIRootPanelOffsetMax.y then
    newPos.y = -UIRootPanelOffsetMax.y + self._height / 2
  else
    newPos.y = posY + cell_height / 2 - self._height / 2
  end
  ;
  (self:GetRootWindow()):SetAnchoredPosition(newPos.x, newPos.y)
end

EquipTipsDialog.OnUpdate = function(self)
  -- function num : 0_6 , upvalues : UIRootOffsetMax, UIManager, SetTipsPosition
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    self._width = (self:GetRootWindow()):GetRectSize()
    UIRootOffsetMax = (UIManager.GetUiRootOffsetMax)()
    if self._parmFunc then
      local parms = (self._parmFunc)()
      SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
    end
  end
end

EquipTipsDialog.OnScreenPixelChanged = function(self)
  -- function num : 0_7
  self._screenPixelChanged = true
end

EquipTipsDialog.SetTipsParmFunc = function(self, parmFunc)
  -- function num : 0_8 , upvalues : SetTipsPosition
  self._parmFunc = parmFunc
  if parmFunc then
    local parms = parmFunc()
    SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
  end
end

EquipTipsDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_9
  if frame == self._jobFrame then
    return #self._jobRecord
  else
    return #self._downDataList
  end
end

EquipTipsDialog.CellAtIndex = function(self, frame, index)
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
          if ((self._downDataList)[index]).tag == "Describe" then
            return "equip.equiptipdescribecell"
          end
        end
      end
    end
  end
end

EquipTipsDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._jobFrame then
    return (self._jobRecord)[index]
  else
    return (self._downDataList)[index]
  end
end

EquipTipsDialog.OnRootWindowClick = function(self)
  -- function num : 0_12
  self:Destroy()
end

EquipTipsDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_13 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

EquipTipsDialog.ShouldLengthChange = function(self)
  -- function num : 0_14
  return true
end

EquipTipsDialog.HasRandomPropOrSuit = function(self)
  -- function num : 0_15
  do return #(self._equip):GetRandomEntry() <= 0 and (self._equip):GetEquipSuitRecorder() end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EquipTipsDialog.OnBackBtnClicked = function(self)
  -- function num : 0_16
  self:Destroy()
end

return EquipTipsDialog

