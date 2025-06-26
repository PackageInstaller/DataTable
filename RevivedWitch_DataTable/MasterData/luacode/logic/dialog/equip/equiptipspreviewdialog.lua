-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/equip/equiptipspreviewdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CstringCfg = (BeanManager.GetTableByName)("message.cstringres")
local CAttrNameTable = (BeanManager.GetTableByName)("role.cattreffectidname")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Cequipbreakcfg = (BeanManager.GetTableByName)("equip.cequipbreakcfg")
local CEquipItemTable = (BeanManager.GetTableByName)("item.cequipitem")
local CRandomAbilityLib = (BeanManager.GetTableByName)("equip.crandomabilitylib")
local CRandomAbility = (BeanManager.GetTableByName)("equip.crandomability")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local UIManager = ((CS.PixelNeko).UI).UIManager
local UIRootOffsetMax = (UIManager.GetUiRootOffsetMax)()
local UIRootPanelOffsetMax = (UIManager.GetUiRootPanelOffsetMax)()
local TableFrame = require("framework.ui.frame.table.tableframe")
local Equip = require("logic.manager.experimental.types.equip")
local EquipTipsPreviewDialog = class("EquipTipsPreviewDialog", Dialog)
EquipTipsPreviewDialog.AssetBundleName = "ui/layouts.equip"
EquipTipsPreviewDialog.AssetName = "EquipTipsNew"
EquipTipsPreviewDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : EquipTipsPreviewDialog
  ((EquipTipsPreviewDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
  self._equip = nil
  self._downDataList = {}
  self._basePropRecord = {}
end

EquipTipsPreviewDialog.OnCreate = function(self)
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
  self._width = (self:GetRootWindow()):GetRectSize()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_Update, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnScreenPixelChanged, Common.n_ScreenPixelChanged, nil)
end

EquipTipsPreviewDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._frame):Destroy()
  ;
  (self._jobFrame):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

EquipTipsPreviewDialog.Init = function(self, equipID, showMaxLevel)
  -- function num : 0_3 , upvalues : Equip
  local equip = (Equip.Create)(equipID)
  self:RefreshInfo(equip, showMaxLevel)
end

EquipTipsPreviewDialog.RefreshInfo = function(self, equip, showMaxLevel)
  -- function num : 0_4 , upvalues : _ENV, CStringRes, CEquipItemTable, Cequipbreakcfg, CRandomAbilityLib, CAttrNameTable, CImagePathTable
  self._equip = equip
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
  (self._equipName):SetText((self._equip):GetName())
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
  local level = 1
  if showMaxLevel then
    local equipBreakCfgAllId = Cequipbreakcfg:GetAllIds()
    for i,value in ipairs(equipBreakCfgAllId) do
      local equipBreakCfgRecorder = Cequipbreakcfg:GetRecorder(value)
      if equipBreakCfgRecorder.pinJi == (self._equip):GetPinJiID() and level < equipBreakCfgRecorder.levelmax then
        level = equipBreakCfgRecorder.levelmax
        ;
        (self._equip):SetStage((self._equip):GetBreaKLimitTimes())
      end
    end
    ;
    (self._level):SetText(level)
    ;
    (self._levelMax):SetText(level)
  else
    do
      ;
      (self._level):SetText("1")
      ;
      (self._levelMax):SetText("10")
      local score = record.baseScore * (record.initMagnify + (level - 1))
      ;
      (self._score):SetText((math.floor)(score))
      for i,v in ipairs(record.randomAbility) do
        local libRecord = CRandomAbilityLib:GetRecorder(v)
        if #libRecord.abilityID > 1 then
          local temp = {tag = "WordDescribe", value = -1}
          ;
          (table.insert)(self._downDataList, temp)
        else
          do
            do
              if #libRecord.abilityID == 1 then
                local temp = {tag = "WordDescribe", value = (libRecord.abilityID)[1]}
                ;
                (table.insert)(self._downDataList, temp)
              end
              -- DECOMPILER ERROR at PC173: LeaveBlock: unexpected jumping out DO_STMT

              -- DECOMPILER ERROR at PC173: LeaveBlock: unexpected jumping out IF_ELSE_STMT

              -- DECOMPILER ERROR at PC173: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
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
        for i,v in ipairs(record.abilityID) do
          local temp = {}
          temp.attrId = v
          temp.value = (record.abilityValue)[i] * (record.initMagnify + (level - 1) + equip:GetCurrentBreakMultiple())
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

EquipTipsPreviewDialog.OnUpdate = function(self)
  -- function num : 0_6 , upvalues : UIRootOffsetMax, UIManager, SetTipsPosition
  if self._screenPixelChanged then
    self._screenPixelChanged = false
    self._width = (self:GetRootWindow()):GetRectSize()
    UIRootOffsetMax = (UIManager.GetUiRootPanelOffsetMax)()
    if self._parmFunc then
      local parms = (self._parmFunc)()
      SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
    end
  end
end

EquipTipsPreviewDialog.OnScreenPixelChanged = function(self)
  -- function num : 0_7
  self._screenPixelChanged = true
end

EquipTipsPreviewDialog.SetTipsParmFunc = function(self, parmFunc)
  -- function num : 0_8 , upvalues : SetTipsPosition
  self._parmFunc = parmFunc
  if parmFunc then
    local parms = parmFunc()
    SetTipsPosition(self, parms.width, parms.height, parms.posX, parms.posY)
  end
end

EquipTipsPreviewDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_9
  if frame == self._jobFrame then
    return #self._jobRecord
  else
    return #self._downDataList
  end
end

EquipTipsPreviewDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._jobFrame then
    return "equip.equipbagjobcell"
  else
    if ((self._downDataList)[index]).tag == "WordDescribe" then
      return "equip.equiptipworddescribecell"
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

EquipTipsPreviewDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_11
  if frame == self._jobFrame then
    return (self._jobRecord)[index]
  else
    return (self._downDataList)[index]
  end
end

EquipTipsPreviewDialog.OnRootWindowClick = function(self)
  -- function num : 0_12
  self:Destroy()
end

EquipTipsPreviewDialog.OnEveryWhereClick = function(self, args)
  -- function num : 0_13 , upvalues : UIManager
  if not (UIManager.RectangleContainsScreenPoint)((self:GetRootWindow())._uiObject, (((args.userInfo).eventData).position).x, (((args.userInfo).eventData).position).y) then
    self:OnBackBtnClicked()
  end
end

EquipTipsPreviewDialog.ShouldLengthChange = function(self)
  -- function num : 0_14
  return true
end

EquipTipsPreviewDialog.HasRandomPropOrSuit = function(self)
  -- function num : 0_15 , upvalues : CEquipItemTable
  local record = CEquipItemTable:GetRecorder((self._equip):GetID())
  do return #record.randomAbility <= 0 and (self._equip):GetEquipSuitRecorder() end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

EquipTipsPreviewDialog.OnBackBtnClicked = function(self)
  -- function num : 0_16
  self:Destroy()
end

return EquipTipsPreviewDialog

