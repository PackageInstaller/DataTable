local Role = require("logic.manager.experimental.types.role")
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local LineUpStation = BattleClientProtocolManager.GetBeanDef("data.lineupstation")
local BattleReportDialog = class("BattleReportDialog", Dialog)
BattleReportDialog.AssetBundleName = "ui/layouts.battlewin"
BattleReportDialog.AssetName = "BattleReport"
local CampType = {Left = 1, Right = 2}
local NumberType = {
  Injury = 1,
  Treatment = 2,
  Damage = 3
}
local rowNum = 1
local colNum = 3
local BottomToTop = 3

function BattleReportDialog:Ctor(...)
  BattleReportDialog.super.Ctor(self, ...)
  self._groupName = "Message"
  self._campTag = nil
  self._numberTag = NumberType.Damage
  self._charData = {}
  self._alternativeCharData = {}
  self._bossData = {}
  self._supportData = {}
end

function BattleReportDialog:OnCreate()
  self._scrollBar = self:GetChild("Back/Scrollbar")
  self._damageBtn = self:GetChild("Back/GroupBtn1")
  self._treatmentBtn = self:GetChild("Back/GroupBtn2")
  self._injuryBtn = self:GetChild("Back/GroupBtn3")
  self._leftCampToggle = self:GetChild("Back/ToggleGroup/_Toggle_0")
  self._rightCampToggle = self:GetChild("Back/ToggleGroup/_Toggle_1")
  self._closeBtn = self:GetChild("Back/CloseBtn")
  self._charPanel = self:GetChild("Back/Frame")
  self._bossPanel = self:GetChild("Back/FrameBoss")
  self._damageBtn:Subscribe_PointerClickEvent(self.OnDamageBtnClicked, self)
  self._treatmentBtn:Subscribe_PointerClickEvent(self.OnTreatmentBtnClicked, self)
  self._injuryBtn:Subscribe_PointerClickEvent(self.OnInjuryBtnClicked, self)
  self._closeBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._leftCampToggle:Subscribe_PointerClickEvent(self.OnLeftCampToggleClicked, self)
  self._rightCampToggle:Subscribe_PointerClickEvent(self.OnRightCampToggleClicked, self)
  self._scrollBar:SetScrollDirection(BottomToTop)
  self._charFrame = TableFrame.Create(self._charPanel, self, true, true, true)
  self._bossFrame = GridFrame.Create(self._bossPanel, self, true, colNum, true)
  self:SetData()
  self:OnLeftCampToggleClicked()
  self:OnDamageBtnClicked()
end

function BattleReportDialog:OnDestroy()
  if self._charFrame then
    self._charFrame:Destroy()
    self._charFrame = nil
  end
  if self._bossFrame then
    self._bossFrame:Destroy()
    self._bossFrame = nil
  end
end

function BattleReportDialog:SetData()
  self._currentBattleInjury = NekoData.BehaviorManager.BM_Battle:GetCurrentBattleInjury()
  self._currentBattleTreatment = NekoData.BehaviorManager.BM_Battle:GetCurrentBattleTreatment()
  self._currentBattleDamage = NekoData.BehaviorManager.BM_Battle:GetCurrentBattleDamage()
end

function BattleReportDialog:RefreshData(changeCamp)
  local datalist = {}
  local data = {}
  local haveCreateInitialPlayerEntity = {}
  local addDamageCount = 0
  local addInjuryCount = 0
  local addTreatCount = 0
  for entityId, v in pairs(self._currentBattleDamage) do
    local damageValue = v.num
    if damageValue < 0 then
      damageValue = -damageValue
    end
    local injuryValue = self._currentBattleInjury[entityId].num or 0
    if injuryValue < 0 then
      injuryValue = -injuryValue
    end
    local treatValue = self._currentBattleTreatment[entityId].num or 0
    if treatValue < 0 then
      treatValue = -treatValue
    end
    if v.camp == self._campTag then
      addDamageCount = addDamageCount + damageValue
      addInjuryCount = addInjuryCount + injuryValue
      addTreatCount = addTreatCount + treatValue
      if v.isInitial or v.isPartner then
        data[entityId] = data[entityId] or {
          roleId = v.roleId,
          entityId = v.entityId,
          camp = v.camp,
          isInitial = v.isInitial,
          damage = damageValue,
          injury = injuryValue,
          treat = treatValue,
          isPartner = v.isPartner,
          isRole = v.isRole,
          stationKey = v.stationKey,
          nameTextId = v.nameTextId,
          level = v.level
        }
        if not v.isPartner then
          haveCreateInitialPlayerEntity[v.roleId] = true
        end
      else
        data[v.roleId] = data[v.roleId] or {
          roleId = v.roleId,
          entityId = v.entityId,
          camp = v.camp,
          isInitial = v.isInitial,
          damage = 0,
          injury = 0,
          treat = 0,
          isPartner = v.isPartner,
          isRole = v.isRole,
          stationKey = v.stationKey,
          nameTextId = v.nameTextId,
          level = v.level
        }
        data[v.roleId].damage = data[v.roleId].damage + damageValue
        data[v.roleId].injury = data[v.roleId].injury + injuryValue
        data[v.roleId].treat = data[v.roleId].treat + treatValue
      end
    end
  end
  local partnerData
  local maxDamageNumData = {
    damage = 0,
    entityid,
    index
  }
  local maxInjuryNumData = {
    injury = 0,
    entityid,
    index
  }
  local maxTreatNumData = {
    treat = 0,
    entityid,
    index
  }
  for _, v in pairs(data) do
    if v.damage >= maxDamageNumData.damage and not v.isPartner then
      maxDamageNumData.damage = v.damage
      maxDamageNumData.entityid = v.entityId
    end
    if v.injury >= maxInjuryNumData.injury and not v.isPartner then
      maxInjuryNumData.injury = v.injury
      maxInjuryNumData.entityid = v.entityId
    end
    if v.treat >= maxTreatNumData.treat and not v.isPartner then
      maxTreatNumData.treat = v.treat
      maxTreatNumData.entityid = v.entityId
    end
    if addDamageCount ~= 0 then
      v.damagePercent = v.damage * 100 // addDamageCount
    else
      v.damagePercent = 0
    end
    if addInjuryCount ~= 0 then
      v.injuryPercent = v.injury * 100 // addInjuryCount
    else
      v.injuryPercent = 0
    end
    if addTreatCount ~= 0 then
      v.treatPercent = v.treat * 100 // addTreatCount
    else
      v.treatPercent = 0
    end
    if not v.isPartner then
      table.insert(datalist, v)
    else
      partnerData = v
    end
  end
  if self._campTag == CampType.Left then
    local currentTeamId = NekoData.BehaviorManager.BM_SBattleStart:GetLineId()
    local currentTeamRoleList = NekoData.BehaviorManager.BM_Team:GetTeamRoles(currentTeamId)
    for station, roleId in pairs(currentTeamRoleList) do
      local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
      if roleId ~= 0 and not haveCreateInitialPlayerEntity[roleId] and 0 < role:GetCurrentHp() then
        table.insert(datalist, {
          roleId = roleId,
          entityId = -1,
          camp = CampType.Left,
          isInitial = true,
          damage = 0,
          injury = 0,
          treat = 0,
          isPartner = false,
          isRole = true,
          stationKey = station,
          damagePercent = 0,
          injuryPercent = 0,
          treatPercent = 0
        })
      end
    end
  end
  table.sort(datalist, function(a, b)
    return a.stationKey > b.stationKey
  end)
  local otherDamagePercent = 0
  local otherInjuryPercent = 0
  local otherTreatPercent = 0
  for index, v in ipairs(datalist) do
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
    self._supportData[1] = partnerData
  else
    local supportRole = NekoData.BehaviorManager.BM_Team:GetSupportRole().role
    if supportRole then
      self._supportData[1] = {
        roleId = supportRole:GetRoleId(),
        entityId = -1,
        camp = CampType.Left,
        isInitial = true,
        damage = 0,
        injury = 0,
        treat = 0,
        isPartner = true,
        isRole = true,
        stationKey = -1,
        damagePercent = 0,
        injuryPercent = 0,
        treatPercent = 0
      }
    end
  end
  if 0 < addDamageCount and datalist[maxDamageNumData.index] then
    datalist[maxDamageNumData.index].damagePercent = 100 - otherDamagePercent
    datalist[maxDamageNumData.index].isMax = true
  end
  if 0 < addInjuryCount and datalist[maxInjuryNumData.index] then
    datalist[maxInjuryNumData.index].injuryPercent = 100 - otherInjuryPercent
  end
  if 0 < addTreatCount and datalist[maxTreatNumData.index] then
    datalist[maxTreatNumData.index].treatPercent = 100 - otherTreatPercent
  end
  if self._campTag == CampType.Left then
    self._charData = {}
    self._alternativeCharData = {}
    for _, v in ipairs(datalist) do
      if v.isRole and v.stationKey == LineUpStation.ALTERNATE_FRONT_ROW or v.stationKey == LineUpStation.ALTERNATE_MIDDLE_ROW or v.stationKey == LineUpStation.ALTERNATE_BACK_ROW then
        table.insert(self._alternativeCharData, v)
      elseif v.isRole and v.stationKey == LineUpStation.FRONT_ROW or v.stationKey == LineUpStation.MIDDLE_ROW or v.stationKey == LineUpStation.BACK_ROW then
        table.insert(self._charData, v)
      else
        table.insert(self._supportData, v)
      end
    end
    self._charFrame:ReloadAllCell()
    self._charFrame:MoveToTop()
  elseif self._campTag == CampType.Right then
    self._bossData = datalist
    self._bossFrame:ReloadAllCell()
  end
end

function BattleReportDialog:OnInjuryBtnClicked()
  self._injuryBtn:SetSelected(true)
  self._treatmentBtn:SetSelected(false)
  self._damageBtn:SetSelected(false)
  self._numberTag = NumberType.Injury
  self:RefreshData()
end

function BattleReportDialog:OnTreatmentBtnClicked()
  self._injuryBtn:SetSelected(false)
  self._treatmentBtn:SetSelected(true)
  self._damageBtn:SetSelected(false)
  self._numberTag = NumberType.Treatment
  self:RefreshData()
end

function BattleReportDialog:OnDamageBtnClicked()
  self._injuryBtn:SetSelected(false)
  self._treatmentBtn:SetSelected(false)
  self._damageBtn:SetSelected(true)
  self._numberTag = NumberType.Damage
  self:RefreshData()
end

function BattleReportDialog:OnLeftCampToggleClicked()
  self._leftCampToggle:SetIsOnType(true)
  self._rightCampToggle:SetIsOnType(false)
  if self._campTag ~= CampType.Left then
    self._campTag = CampType.Left
    self._charPanel:SetActive(true)
    self._bossPanel:SetActive(false)
    self:RefreshData(true)
  end
end

function BattleReportDialog:OnRightCampToggleClicked()
  self._leftCampToggle:SetIsOnType(false)
  self._rightCampToggle:SetIsOnType(true)
  if self._campTag ~= CampType.Right then
    self._campTag = CampType.Right
    self._charPanel:SetActive(false)
    self._bossPanel:SetActive(true)
    self:RefreshData(true)
  end
end

function BattleReportDialog:OnBackBtnClicked()
  self:Destroy()
end

function BattleReportDialog:NumberOfCell(frame)
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
  elseif frame == self._bossFrame then
    return #self._bossData
  end
end

function BattleReportDialog:CellAtIndex(frame, index)
  if frame == self._charFrame then
    return "battle.battleaccount.battlereportframecell"
  elseif frame == self._bossFrame then
    return "battle.battleaccount.battlereportbosscell"
  end
end

function BattleReportDialog:DataAtIndex(frame, index)
  if frame == self._charFrame then
    if index == 1 then
      return self._charData
    elseif index == 2 then
      if #self._alternativeCharData ~= 0 then
        return self._alternativeCharData
      elseif #self._supportData ~= 0 then
        return self._supportData
      else
        LogErrorFormat("BattleReportDialog", "wrong index %s for frame _charFrame", index)
      end
    elseif index == 3 then
      if #self._supportData ~= 0 then
        return self._supportData
      else
        LogErrorFormat("BattleReportDialog", "wrong index %s for frame _charFrame", index)
      end
    else
      LogErrorFormat("BattleReportDialog", "wrong index %s for frame _charFrame", index)
    end
  elseif frame == self._bossFrame then
    return self._bossData[index]
  end
end

function BattleReportDialog:OnCurPosChange(frame, proportion)
  local marginlength, _ = 0, 0
  local total = 1
  if frame == self._charFrame then
    marginlength = self._charPanel:GetRectSize()
    total = self._charFrame:GetTotalLength()
  elseif frame == self._bossFrame then
    _, marginlength = self._bossPanel:GetRectSize()
    total = self._bossFrame:GetTotalLength()
  end
  if marginlength < total then
    self._scrollBar:SetScrollSize(marginlength / total)
    self._scrollBar:SetScrollValue(proportion)
  else
    self._scrollBar:SetScrollSize(1)
    self._scrollBar:SetScrollValue(proportion)
  end
end

return BattleReportDialog
