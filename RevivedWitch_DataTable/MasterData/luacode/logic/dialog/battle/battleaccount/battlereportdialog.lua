-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battlereportdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local LineUpStation = (BattleClientProtocolManager.GetBeanDef)("data.lineupstation")
local BattleReportDialog = class("BattleReportDialog", Dialog)
BattleReportDialog.AssetBundleName = "ui/layouts.battlewin"
BattleReportDialog.AssetName = "BattleReport"
local CampType = {Left = 1, Right = 2}
local NumberType = {Injury = 1, Treatment = 2, Damage = 3}
local rowNum = 1
local colNum = 3
local BottomToTop = 3
BattleReportDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleReportDialog, NumberType
  ((BattleReportDialog.super).Ctor)(self, ...)
  self._groupName = "Message"
  self._campTag = nil
  self._numberTag = NumberType.Damage
  self._charData = {}
  self._alternativeCharData = {}
  self._bossData = {}
  self._supportData = {}
end

BattleReportDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : BottomToTop, TableFrame, GridFrame, colNum
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._damageBtn = self:GetChild("Back/GroupBtn1")
  self._treatmentBtn = self:GetChild("Back/GroupBtn2")
  self._injuryBtn = self:GetChild("Back/GroupBtn3")
  self._leftCampToggle = self:GetChild("Back/ToggleGroup/_Toggle_0")
  self._rightCampToggle = self:GetChild("Back/ToggleGroup/_Toggle_1")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._charPanel = self:GetChild("Back/Frame")
  self._bossPanel = self:GetChild("Back/FrameBoss")
  ;
  (self._damageBtn):Subscribe_PointerClickEvent(self.OnDamageBtnClicked, self)
  ;
  (self._treatmentBtn):Subscribe_PointerClickEvent(self.OnTreatmentBtnClicked, self)
  ;
  (self._injuryBtn):Subscribe_PointerClickEvent(self.OnInjuryBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._leftCampToggle):Subscribe_PointerClickEvent(self.OnLeftCampToggleClicked, self)
  ;
  (self._rightCampToggle):Subscribe_PointerClickEvent(self.OnRightCampToggleClicked, self)
  ;
  (self._scrollBar):SetScrollDirection(BottomToTop)
  self._charFrame = (TableFrame.Create)(self._charPanel, self, true, true, true)
  self._bossFrame = (GridFrame.Create)(self._bossPanel, self, true, colNum, true)
  self:SetData()
  self:OnLeftCampToggleClicked()
  self:OnDamageBtnClicked()
end

BattleReportDialog.OnDestroy = function(self)
  -- function num : 0_2
  if self._charFrame then
    (self._charFrame):Destroy()
    self._charFrame = nil
  end
  if self._bossFrame then
    (self._bossFrame):Destroy()
    self._bossFrame = nil
  end
end

BattleReportDialog.SetData = function(self)
  -- function num : 0_3 , upvalues : _ENV
  self._currentBattleInjury = ((NekoData.BehaviorManager).BM_Battle):GetCurrentBattleInjury()
  self._currentBattleTreatment = ((NekoData.BehaviorManager).BM_Battle):GetCurrentBattleTreatment()
  self._currentBattleDamage = ((NekoData.BehaviorManager).BM_Battle):GetCurrentBattleDamage()
end

BattleReportDialog.RefreshData = function(self, changeCamp)
  -- function num : 0_4 , upvalues : _ENV, CampType, LineUpStation
  local datalist = {}
  local data = {}
  local haveCreateInitialPlayerEntity = {}
  local addDamageCount = 0
  local addInjuryCount = 0
  local addTreatCount = 0
  for entityId,v in pairs(self._currentBattleDamage) do
    local damageValue = v.num
    if damageValue < 0 then
      damageValue = -damageValue
    end
    local injuryValue = ((self._currentBattleInjury)[entityId]).num or 0
    if injuryValue < 0 then
      injuryValue = -injuryValue
    end
    local treatValue = ((self._currentBattleTreatment)[entityId]).num or 0
    if treatValue < 0 then
      treatValue = -treatValue
    end
    if v.camp == self._campTag then
      addDamageCount = addDamageCount + damageValue
      addInjuryCount = addInjuryCount + injuryValue
      addTreatCount = addTreatCount + treatValue
      if v.isInitial or v.isPartner then
        if not data[entityId] then
          data[entityId] = {roleId = v.roleId, entityId = v.entityId, camp = v.camp, isInitial = v.isInitial, damage = damageValue, injury = injuryValue, treat = treatValue, isPartner = v.isPartner, isRole = v.isRole, stationKey = v.stationKey, nameTextId = v.nameTextId, level = v.level}
          if not v.isPartner then
            haveCreateInitialPlayerEntity[v.roleId] = true
          end
          if not data[v.roleId] then
            do
              data[v.roleId] = {roleId = v.roleId, entityId = v.entityId, camp = v.camp, isInitial = v.isInitial, damage = 0, injury = 0, treat = 0, isPartner = v.isPartner, isRole = v.isRole, stationKey = v.stationKey, nameTextId = v.nameTextId, level = v.level}
              -- DECOMPILER ERROR at PC111: Confused about usage of register: R16 in 'UnsetPending'

              ;
              (data[v.roleId]).damage = (data[v.roleId]).damage + damageValue
              -- DECOMPILER ERROR at PC118: Confused about usage of register: R16 in 'UnsetPending'

              ;
              (data[v.roleId]).injury = (data[v.roleId]).injury + injuryValue
              -- DECOMPILER ERROR at PC125: Confused about usage of register: R16 in 'UnsetPending'

              ;
              (data[v.roleId]).treat = (data[v.roleId]).treat + treatValue
              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_STMT

              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_THEN_STMT

              -- DECOMPILER ERROR at PC126: LeaveBlock: unexpected jumping out IF_STMT

            end
          end
        end
      end
    end
  end
  local partnerData = nil
  local maxDamageNumData = {entityid, index; damage = 0}
  local maxInjuryNumData = {entityid, index; injury = 0}
  local maxTreatNumData = {entityid, index; treat = 0}
  for _,v in pairs(data) do
    if maxDamageNumData.damage <= v.damage and not v.isPartner then
      maxDamageNumData.damage = v.damage
      maxDamageNumData.entityid = v.entityId
    end
    if maxInjuryNumData.injury <= v.injury and not v.isPartner then
      maxInjuryNumData.injury = v.injury
      maxInjuryNumData.entityid = v.entityId
    end
    if maxTreatNumData.treat <= v.treat and not v.isPartner then
      maxTreatNumData.treat = v.treat
      maxTreatNumData.entityid = v.entityId
    end
    if addDamageCount ~= 0 then
      v.damagePercent = v.damage * 100 // (addDamageCount)
    else
      v.damagePercent = 0
    end
    if addInjuryCount ~= 0 then
      v.injuryPercent = v.injury * 100 // (addInjuryCount)
    else
      v.injuryPercent = 0
    end
    if addTreatCount ~= 0 then
      v.treatPercent = v.treat * 100 // (addTreatCount)
    else
      v.treatPercent = 0
    end
    if not v.isPartner then
      (table.insert)(datalist, v)
    else
      partnerData = v
    end
  end
  if self._campTag == CampType.Left then
    local currentTeamId = ((NekoData.BehaviorManager).BM_SBattleStart):GetLineId()
    local currentTeamRoleList = ((NekoData.BehaviorManager).BM_Team):GetTeamRoles(currentTeamId)
    for station,roleId in pairs(currentTeamRoleList) do
      local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
      if roleId ~= 0 and not haveCreateInitialPlayerEntity[roleId] and role:GetCurrentHp() > 0 then
        (table.insert)(datalist, {roleId = roleId, entityId = -1, camp = CampType.Left, isInitial = true, damage = 0, injury = 0, treat = 0, isPartner = false, isRole = true, stationKey = station, damagePercent = 0, injuryPercent = 0, treatPercent = 0})
      end
    end
  end
  do
    ;
    (table.sort)(datalist, function(a, b)
    -- function num : 0_4_0
    do return b.stationKey < a.stationKey end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
    local otherDamagePercent = 0
    local otherInjuryPercent = 0
    local otherTreatPercent = 0
    for index,v in ipairs(datalist) do
      if v.entityId ~= maxDamageNumData.entityid then
        otherDamagePercent = otherDamagePercent + v.damagePercent
      else
        maxDamageNumData.index = index
      end
      if v.entityId ~= maxInjuryNumData.entityid then
        otherInjuryPercent = otherInjuryPercent + v.injuryPercent
      else
        maxInjuryNumData.index = index
      end
      if v.entityId ~= maxTreatNumData.entityid then
        otherTreatPercent = otherTreatPercent + v.treatPercent
      else
        maxTreatNumData.index = index
      end
    end
    self._supportData = {}
    if partnerData then
      otherDamagePercent = otherDamagePercent + partnerData.damagePercent
      otherInjuryPercent = otherInjuryPercent + partnerData.injuryPercent
      otherTreatPercent = otherTreatPercent + partnerData.treatPercent
      -- DECOMPILER ERROR at PC321: Confused about usage of register: R15 in 'UnsetPending'

      ;
      (self._supportData)[1] = partnerData
    else
      local supportRole = (((NekoData.BehaviorManager).BM_Team):GetSupportRole()).role
      -- DECOMPILER ERROR at PC349: Confused about usage of register: R16 in 'UnsetPending'

      if supportRole then
        (self._supportData)[1] = {roleId = supportRole:GetRoleId(), entityId = -1, camp = CampType.Left, isInitial = true, damage = 0, injury = 0, treat = 0, isPartner = true, isRole = true, stationKey = -1, damagePercent = 0, injuryPercent = 0, treatPercent = 0}
      end
    end
    do
      -- DECOMPILER ERROR at PC359: Confused about usage of register: R15 in 'UnsetPending'

      if addDamageCount > 0 and datalist[maxDamageNumData.index] then
        (datalist[maxDamageNumData.index]).damagePercent = 100 - (otherDamagePercent)
        -- DECOMPILER ERROR at PC362: Confused about usage of register: R15 in 'UnsetPending'

        ;
        (datalist[maxDamageNumData.index]).isMax = true
      end
      -- DECOMPILER ERROR at PC372: Confused about usage of register: R15 in 'UnsetPending'

      if addInjuryCount > 0 and datalist[maxInjuryNumData.index] then
        (datalist[maxInjuryNumData.index]).injuryPercent = 100 - (otherInjuryPercent)
      end
      -- DECOMPILER ERROR at PC382: Confused about usage of register: R15 in 'UnsetPending'

      if addTreatCount > 0 and datalist[maxTreatNumData.index] then
        (datalist[maxTreatNumData.index]).treatPercent = 100 - (otherTreatPercent)
      end
      if self._campTag == CampType.Left then
        self._charData = {}
        self._alternativeCharData = {}
        for _,v in ipairs(datalist) do
          -- DECOMPILER ERROR at PC414: Unhandled construct in 'MakeBoolean' P3

          if (v.isRole and v.stationKey == LineUpStation.ALTERNATE_FRONT_ROW) or v.stationKey == LineUpStation.ALTERNATE_BACK_ROW then
            (table.insert)(self._alternativeCharData, v)
          else
            -- DECOMPILER ERROR at PC435: Unhandled construct in 'MakeBoolean' P3

            if (v.isRole and v.stationKey == LineUpStation.FRONT_ROW) or v.stationKey == LineUpStation.BACK_ROW then
              (table.insert)(self._charData, v)
            else
              ;
              (table.insert)(self._supportData, v)
            end
          end
        end
        ;
        (self._charFrame):ReloadAllCell()
        ;
        (self._charFrame):MoveToTop()
      else
        if self._campTag == CampType.Right then
          self._bossData = datalist
          ;
          (self._bossFrame):ReloadAllCell()
        end
      end
    end
  end
end

BattleReportDialog.OnInjuryBtnClicked = function(self)
  -- function num : 0_5 , upvalues : NumberType
  (self._injuryBtn):SetSelected(true)
  ;
  (self._treatmentBtn):SetSelected(false)
  ;
  (self._damageBtn):SetSelected(false)
  self._numberTag = NumberType.Injury
  self:RefreshData()
end

BattleReportDialog.OnTreatmentBtnClicked = function(self)
  -- function num : 0_6 , upvalues : NumberType
  (self._injuryBtn):SetSelected(false)
  ;
  (self._treatmentBtn):SetSelected(true)
  ;
  (self._damageBtn):SetSelected(false)
  self._numberTag = NumberType.Treatment
  self:RefreshData()
end

BattleReportDialog.OnDamageBtnClicked = function(self)
  -- function num : 0_7 , upvalues : NumberType
  (self._injuryBtn):SetSelected(false)
  ;
  (self._treatmentBtn):SetSelected(false)
  ;
  (self._damageBtn):SetSelected(true)
  self._numberTag = NumberType.Damage
  self:RefreshData()
end

BattleReportDialog.OnLeftCampToggleClicked = function(self)
  -- function num : 0_8 , upvalues : CampType
  (self._leftCampToggle):SetIsOnType(true)
  ;
  (self._rightCampToggle):SetIsOnType(false)
  if self._campTag ~= CampType.Left then
    self._campTag = CampType.Left
    ;
    (self._charPanel):SetActive(true)
    ;
    (self._bossPanel):SetActive(false)
    self:RefreshData(true)
  end
end

BattleReportDialog.OnRightCampToggleClicked = function(self)
  -- function num : 0_9 , upvalues : CampType
  (self._leftCampToggle):SetIsOnType(false)
  ;
  (self._rightCampToggle):SetIsOnType(true)
  if self._campTag ~= CampType.Right then
    self._campTag = CampType.Right
    ;
    (self._charPanel):SetActive(false)
    ;
    (self._bossPanel):SetActive(true)
    self:RefreshData(true)
  end
end

BattleReportDialog.OnBackBtnClicked = function(self)
  -- function num : 0_10
  self:Destroy()
end

BattleReportDialog.NumberOfCell = function(self, frame)
  -- function num : 0_11
  if frame == self._charFrame then
    local count = 0
    if #self._charData ~= 0 then
      count = count + 1
    end
    if #self._alternativeCharData ~= 0 then
      count = count + 1
    end
    if #self._supportData ~= 0 then
      count = count + 1
    end
    return count
  else
    do
      if frame == self._bossFrame then
        return #self._bossData
      end
    end
  end
end

BattleReportDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_12
  if frame == self._charFrame then
    return "battle.battleaccount.battlereportframecell"
  else
    if frame == self._bossFrame then
      return "battle.battleaccount.battlereportbosscell"
    end
  end
end

BattleReportDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_13 , upvalues : _ENV
  if frame == self._charFrame then
    if index == 1 then
      return self._charData
    else
      if index == 2 then
        if #self._alternativeCharData ~= 0 then
          return self._alternativeCharData
        else
          if #self._supportData ~= 0 then
            return self._supportData
          else
            LogErrorFormat("BattleReportDialog", "wrong index %s for frame _charFrame", index)
          end
        end
      else
        if index == 3 then
          if #self._supportData ~= 0 then
            return self._supportData
          else
            LogErrorFormat("BattleReportDialog", "wrong index %s for frame _charFrame", index)
          end
        else
          LogErrorFormat("BattleReportDialog", "wrong index %s for frame _charFrame", index)
        end
      end
    end
  else
    if frame == self._bossFrame then
      return (self._bossData)[index]
    end
  end
end

BattleReportDialog.OnCurPosChange = function(self, frame, proportion)
  -- function num : 0_14
  local marginlength, _ = 0, 0
  local total = 1
  if frame == self._charFrame then
    marginlength = (self._charPanel):GetRectSize()
    total = (self._charFrame):GetTotalLength()
  else
    if frame == self._bossFrame then
      _ = (self._bossPanel):GetRectSize()
      total = (self._bossFrame):GetTotalLength()
    end
  end
  if marginlength < total then
    (self._scrollBar):SetScrollSize(marginlength / total)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  else
    ;
    (self._scrollBar):SetScrollSize(1)
    ;
    (self._scrollBar):SetScrollValue(proportion)
  end
end

return BattleReportDialog

