local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringres = BeanManager.GetTableByName("message.cstringres")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CTreeLvUp = BeanManager.GetTableByName("courtyard.ctreelvup")
local CExploreLvUp = BeanManager.GetTableByName("courtyard.cexplorelvup")
local CCourtyardLvUpCfg = BeanManager.GetTableByName("courtyard.ccourtyardlvup")
local CYardSkillCfg = BeanManager.GetTableByName("courtyard.cyardskill")
local SlotEnum = LuaNetManager.GetBeanDef("protocol.yard.task")
local ChooseRoleDialog = class("ChooseRoleDialog", Dialog)
ChooseRoleDialog.AssetBundleName = "ui/layouts.yard"
ChooseRoleDialog.AssetName = "YardSend"
local cellNum = 6

function ChooseRoleDialog:Ctor(...)
  ChooseRoleDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._roleList = {}
  self._listByConditions = {}
  self._slotId = nil
  self._limitRolesNum = nil
  self._addTaskOrReplaceRole = ""
  self._task = nil
  self._buildingId = nil
  self._curTaskRoles = {}
  self._yardSkillRecordList = {}
  self._yardSkillRecorderMap = {}
  local allIds = CYardSkillCfg:GetAllIds()
  for i = 1, #allIds do
    local recorder = CYardSkillCfg:GetRecorder(allIds[i])
    if not self._yardSkillRecorderMap[recorder.functionID] then
      self._yardSkillRecorderMap[recorder.functionID] = {}
    end
    self._yardSkillRecorderMap[recorder.functionID][recorder.id] = true
  end
end

function ChooseRoleDialog:OnCreate()
  self._rolePanel = self:GetChild("CellFrame")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._detail = self:GetChild("Detail")
  self._name = self:GetChild("Detail/Name")
  self._loading = self:GetChild("Detail/Loading")
  self._progressNum = self:GetChild("Detail/Loading/Num/Num")
  self._progress = self:GetChild("Detail/Loading/Loading/BackGround/Progress")
  self._mood = self:GetChild("Detail/Loading/Mood")
  self._skillIcon = self:GetChild("Detail/Name/Image")
  self._skillName = self:GetChild("Detail/Name/Image/SkillName")
  self._skillDetail = self:GetChild("Detail/SkillDetail")
  self._skillPanel = self:GetChild("Detail/SkillFrame")
  self._chooseTxt = self:GetChild("Choose/Text")
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._roleFrame = GridFrame.Create(self._rolePanel, self, true, cellNum)
  self._roleFrame:SetMargin(40, 40)
  self._skillFrame = TableFrame.Create(self._skillPanel, self, true, false)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRoleEnergyChanged, Common.n_RoleEnergyChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshAllExploreSlots, Common.n_RefreshAllExploreSlots, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshExploreSlot, Common.n_RefreshExploreSlot, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshExploreSlotActive, Common.n_RefreshExploreSlotActive, nil)
  LuaNotificationCenter.AddObserver(self, self.OnAlchemyRoleChanged, Common.n_AlchemyRoleChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoomFurnitures, Common.n_RefreshRoomFurnitures, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshRoom, Common.n_RefreshRoom, nil)
end

function ChooseRoleDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  self._roleFrame:Destroy()
  self._skillFrame:Destroy()
end

function ChooseRoleDialog:OnRoleEnergyChanged(notification)
  local roles = {}
  for i, v in ipairs(notification.userInfo.list) do
    roles[v.id] = true
  end
  for i, v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    if roles[key] then
      self._listByConditions[i] = NekoData.BehaviorManager.BM_AllRoles:GetRole(key)
    end
  end
  self._roleFrame:FireEvent("RefreshCell", roles)
end

function ChooseRoleDialog:OnRefreshAllExploreSlots(notification)
  local roles = NekoData.BehaviorManager.BM_Explore:GetRoles()
  for i, v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    if roles[key] then
      self._listByConditions[i] = NekoData.BehaviorManager.BM_AllRoles:GetRole(key)
    end
  end
  self._roleFrame:FireEvent("RefreshCell", roles)
end

function ChooseRoleDialog:OnAlchemyRoleChanged(notification)
  local roleKey = notification.userInfo.alchemy.roleId
  if roleKey and roleKey ~= 0 then
    for i, v in ipairs(self._listByConditions) do
      local key = v:GetRoleId()
      if key == roleKey then
        self._listByConditions[i] = NekoData.BehaviorManager.BM_AllRoles:GetRole(key)
      end
    end
    self._roleFrame:FireEvent("RefreshCell", {
      [roleKey] = true
    })
  end
end

function ChooseRoleDialog:OnRefreshRoomFurnitures(notification)
  local roles = {}
  for k, v in pairs(notification.userInfo.floor.rolesLeftRecoveryTime) do
    roles[k] = true
  end
  for i, v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    if roles[key] then
      self._listByConditions[i] = NekoData.BehaviorManager.BM_AllRoles:GetRole(key)
    end
  end
  self._roleFrame:FireEvent("RefreshCell", roles)
end

function ChooseRoleDialog:OnRefreshRoom(notification)
  local roles = {}
  for k, v in pairs(notification.userInfo.floor.rolesLeftRecoveryTime) do
    roles[k] = true
  end
  for i, v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    if roles[key] then
      self._listByConditions[i] = NekoData.BehaviorManager.BM_AllRoles:GetRole(key)
    end
  end
  self._roleFrame:FireEvent("RefreshCell", roles)
end

function ChooseRoleDialog:OnRefreshExploreSlot(notification)
  local roles = {}
  for i, v in ipairs(notification.userInfo.task.roles) do
    roles[v.roleId] = true
  end
  for i, v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    if roles[key] then
      self._listByConditions[i] = NekoData.BehaviorManager.BM_AllRoles:GetRole(key)
    end
  end
  self._roleFrame:FireEvent("RefreshCell", roles)
end

function ChooseRoleDialog:OnRefreshExploreSlotActive(notification)
  local roles = {}
  for i, v in ipairs(notification.userInfo.cavernTask.roles) do
    roles[v.roleId] = true
  end
  for i, v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    if roles[key] then
      self._listByConditions[i] = NekoData.BehaviorManager.BM_AllRoles:GetRole(key)
    end
  end
  self._roleFrame:FireEvent("RefreshCell", roles)
end

function ChooseRoleDialog:Init(tag, buildingId, slotId)
  self._addTaskOrReplaceRole = tag
  self._buildingId = buildingId
  self._slotId = slotId
  local selectRoles
  if self._buildingId == DataCommon.MagicTree then
    self._limitRolesNum = CTreeLvUp:GetRecorder(NekoData.BehaviorManager.BM_MagicTree:GetLevel()).roleNum
    selectRoles = NekoData.BehaviorManager.BM_MagicTree:GetDispatchRoles()
  elseif self._buildingId == DataCommon.Explore then
    self._limitRolesNum = CExploreLvUp:GetRecorder(NekoData.BehaviorManager.BM_Explore:GetLevel()).roleNum
    selectRoles = {}
    for i, v in ipairs(NekoData.BehaviorManager.BM_Explore:GetSlotInfoBySlotId(slotId).roles) do
      table.insert(selectRoles, v)
    end
  elseif self._buildingId == DataCommon.Firefly then
    self._limitRolesNum = NekoData.BehaviorManager.BM_Firefly:GetDispatchMaxRoleNum()
    selectRoles = NekoData.BehaviorManager.BM_Firefly:GetDispatchRoles()
  elseif self._buildingId == DataCommon.Alchemy then
    self._limitRolesNum = NekoData.BehaviorManager.BM_Alchemy:GetDispatchMaxRoleNum()
    selectRoles = NekoData.BehaviorManager.BM_Alchemy:GetDispatchRoles()
  elseif self._buildingId == DataCommon.Cabin then
    self._limitRolesNum = NekoData.BehaviorManager.BM_Cabin:GetDispatchLimitRoleNum()
    local roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(self._slotId)
    selectRoles = {}
    for i, v in ipairs(roomInfo.roles) do
      table.insert(selectRoles, v)
    end
  elseif self._buildingId == DataCommon.TrainCamp then
    self._limitRolesNum = NekoData.BehaviorManager.BM_TrainCamp:GetDispatchLimitRoleNum()
    selectRoles = {}
    local dialog = DialogManager.GetDialog("traincamp.trainlistdialog")
    if dialog and dialog._roles[self._slotId] ~= 0 then
      table.insert(selectRoles, dialog._roles[self._slotId])
    end
  end
  self._selectRoles = {}
  if selectRoles then
    self._curTaskRoles = selectRoles
    for i, v in ipairs(selectRoles) do
      table.insert(self._selectRoles, v)
    end
    local num = #selectRoles
    if 0 < num then
      self:RefreshDetailInfo(selectRoles[num])
    end
  else
    self._curTaskRoles = {}
    self:RefreshDetailInfo(nil)
  end
  local str
  if #self._selectRoles < self._limitRolesNum then
    str = TextManager.GetText(CStringres:GetRecorder(1149).msgTextID)
  else
    str = TextManager.GetText(CStringres:GetRecorder(1150).msgTextID)
  end
  str = string.gsub(str, "%$parameter1%$", #self._selectRoles)
  str = string.gsub(str, "%$parameter2%$", self._limitRolesNum)
  self._chooseTxt:SetText(str)
  if self._buildingId == DataCommon.Alchemy or self._buildingId == DataCommon.Cabin or self._buildingId == DataCommon.Explore or self._buildingId == DataCommon.TrainCamp then
    self._confirmBtn:SetInteractable(true)
  else
    self._confirmBtn:SetInteractable(#self._selectRoles == self._limitRolesNum)
  end
  self:LoadLocalData()
  self._roleFrame:ReloadAllCell()
  if self._task then
    GameTimer.RemoveTask(self._task)
    self._task = nil
  end
  self._task = GameTimer.AddTask(0, 60, function()
    self._roleFrame:FireEvent("RefreshEnergy")
    local num = #self._selectRoles
    if 0 < num then
      self:RefreshDetailInfo(self._selectRoles[num])
    else
      self:RefreshDetailInfo(nil)
    end
  end, nil)
end

function ChooseRoleDialog:LoadLocalData()
  local roleList = NekoData.BehaviorManager.BM_AllRoles:GetContainMaterialRoleList()
  local selectRoleList = {}
  local workingCanNotChooseRoleList = {}
  local skillAndEnergyRoleList = {
    haveSkill = {},
    haveNoSkill = {},
    haveNoEnergy = {}
  }
  local cabinEnergyNotFullRoleList = {}
  local cabinRoleListFromOtherRooms = {}
  local trainCampRoleList = {
    reachLimit = {},
    notReachLimit = {}
  }
  local cabinRoles = {}
  if self._buildingId == DataCommon.Cabin then
    cabinRoles = NekoData.BehaviorManager.BM_Cabin:GetRoles()
  end
  local selectRoleMap = {}
  for i, v in ipairs(self._curTaskRoles) do
    selectRoleMap[v] = i
  end
  local removeIndexList = {}
  for i, v in ipairs(roleList) do
    local index = selectRoleMap[v:GetRoleId()]
    if index then
      table.insert(removeIndexList, i)
      table.insert(selectRoleList, {index = index, role = v})
    elseif v:GetBuildingId() and v:GetBuildingId() == DataCommon.Explore or v:GetBuildingId() == DataCommon.TrainCamp then
      table.insert(workingCanNotChooseRoleList, v)
    elseif self._buildingId == DataCommon.Alchemy then
      if v:GetEnergy() > 0 then
        local yardSkillId = v:GetYardSkillList()[1]
        if yardSkillId and self._yardSkillRecorderMap[self._buildingId][yardSkillId] then
          table.insert(skillAndEnergyRoleList.haveSkill, v)
        else
          table.insert(skillAndEnergyRoleList.haveNoSkill, v)
        end
      else
        table.insert(skillAndEnergyRoleList.haveNoEnergy, v)
      end
    elseif self._buildingId == DataCommon.Explore then
      if v:GetEnergy() > 0 then
        local yardSkillId = v:GetYardSkillList()[1]
        if yardSkillId and self._yardSkillRecorderMap[self._buildingId][yardSkillId] then
          table.insert(skillAndEnergyRoleList.haveSkill, v)
        else
          table.insert(skillAndEnergyRoleList.haveNoSkill, v)
        end
      else
        table.insert(skillAndEnergyRoleList.haveNoEnergy, v)
      end
    elseif self._buildingId == DataCommon.Cabin then
      if cabinRoles[v:GetRoleId()] and cabinRoles[v:GetRoleId()].roomId ~= self._slotId then
        table.insert(cabinRoleListFromOtherRooms, v)
      elseif v:GetEnergy() >= DataCommon.TotalEnergy then
        local yardSkillId = v:GetYardSkillList()[1]
        if yardSkillId and self._yardSkillRecorderMap[self._buildingId][yardSkillId] then
          table.insert(skillAndEnergyRoleList.haveSkill, v)
        else
          table.insert(skillAndEnergyRoleList.haveNoSkill, v)
        end
      else
        table.insert(cabinEnergyNotFullRoleList, v)
      end
    elseif self._buildingId == DataCommon.TrainCamp then
      if v:GetLevel() < v:GetMaxLevel() then
        table.insert(trainCampRoleList.notReachLimit, v)
      else
        table.insert(trainCampRoleList.reachLimit, v)
      end
    end
  end
  table.sort(selectRoleList, function(a, b)
    return a.index < b.index
  end)
  for i, v in ipairs(selectRoleList) do
    table.insert(self._listByConditions, selectRoleList[i].role)
  end
  if self._buildingId ~= DataCommon.Cabin and self._buildingId ~= DataCommon.TrainCamp then
    table.sort(skillAndEnergyRoleList.haveSkill, function(a, b)
      local aRestEnergy, bRestEnergy = math.floor(a:GetEnergy()), math.floor(b:GetEnergy())
      if aRestEnergy ~= bRestEnergy then
        return aRestEnergy > bRestEnergy
      else
        local _a, _b = a:GetBirthDay(), b:GetBirthDay()
        if _a == _b then
          return a:GetId() < b:GetId()
        else
          return _a > _b
        end
      end
    end)
    table.sort(skillAndEnergyRoleList.haveNoSkill, function(a, b)
      local aRestEnergy, bRestEnergy = math.floor(a:GetEnergy()), math.floor(b:GetEnergy())
      if aRestEnergy ~= bRestEnergy then
        return aRestEnergy > bRestEnergy
      else
        local _a, _b = a:GetBirthDay(), b:GetBirthDay()
        if _a == _b then
          return a:GetId() < b:GetId()
        else
          return _a > _b
        end
      end
    end)
    for i, v in ipairs(skillAndEnergyRoleList.haveSkill) do
      table.insert(self._listByConditions, v)
    end
    for i, v in ipairs(skillAndEnergyRoleList.haveNoSkill) do
      table.insert(self._listByConditions, v)
    end
    for i, v in ipairs(skillAndEnergyRoleList.haveNoEnergy) do
      table.insert(self._listByConditions, v)
    end
  elseif self._buildingId == DataCommon.Cabin then
    table.sort(cabinEnergyNotFullRoleList, function(a, b)
      local aRestEnergy, bRestEnergy = math.floor(a:GetEnergy()), math.floor(b:GetEnergy())
      if aRestEnergy ~= bRestEnergy then
        return aRestEnergy < bRestEnergy
      else
        local yardSkillId_a, yardSkillId_b = a:GetYardSkillList()[1], b:GetYardSkillList()[1]
        local isBuildingSkill_a, isBuildingSkill_b = self._yardSkillRecorderMap[self._buildingId][yardSkillId_a], self._yardSkillRecorderMap[self._buildingId][yardSkillId_b]
        if yardSkillId_a and isBuildingSkill_a and (not yardSkillId_b or not isBuildingSkill_b) then
          return true
        elseif yardSkillId_a and isBuildingSkill_a and yardSkillId_b and isBuildingSkill_b then
          local _a, _b = a:GetBirthDay(), b:GetBirthDay()
          if _a == _b then
            return a:GetId() < b:GetId()
          else
            return _a > _b
          end
        elseif (not yardSkillId_a or not isBuildingSkill_a) and (not yardSkillId_b or not isBuildingSkill_b) then
          local _a, _b = a:GetBirthDay(), b:GetBirthDay()
          if _a == _b then
            return a:GetId() < b:GetId()
          else
            return _a > _b
          end
        else
          return false
        end
      end
    end)
    for i, v in ipairs(cabinEnergyNotFullRoleList) do
      table.insert(self._listByConditions, v)
    end
    for i, v in ipairs(skillAndEnergyRoleList.haveSkill) do
      table.insert(self._listByConditions, v)
    end
    for i, v in ipairs(skillAndEnergyRoleList.haveNoSkill) do
      table.insert(self._listByConditions, v)
    end
    for i, v in ipairs(cabinRoleListFromOtherRooms) do
      table.insert(self._listByConditions, v)
    end
  elseif self._buildingId == DataCommon.TrainCamp then
    table.sort(trainCampRoleList.notReachLimit, function(a, b)
      local _a, _b = a:GetRarityId(), b:GetRarityId()
      if _a == _b then
        local _aLv, _bLv = a:GetLevel(), b:GetLevel()
        if _aLv == _bLv then
          return a:GetBirthDay() > b:GetBirthDay()
        else
          return _aLv < _bLv
        end
      else
        return _a > _b
      end
    end)
    table.sort(trainCampRoleList.reachLimit, function(a, b)
      local _a, _b = a:GetRarityId(), b:GetRarityId()
      if _a == _b then
        local _aLv, _bLv = a:GetLevel(), b:GetLevel()
        if _aLv == _bLv then
          return a:GetBirthDay() > b:GetBirthDay()
        else
          return _aLv < _bLv
        end
      else
        return _a > _b
      end
    end)
    for i, v in ipairs(trainCampRoleList.notReachLimit) do
      table.insert(self._listByConditions, v)
    end
    for i, v in ipairs(trainCampRoleList.reachLimit) do
      table.insert(self._listByConditions, v)
    end
  end
  for i, v in ipairs(workingCanNotChooseRoleList) do
    table.insert(self._listByConditions, v)
  end
end

function ChooseRoleDialog:RefreshDetailInfo(roleKey)
  while self._yardSkillRecordList[#self._yardSkillRecordList] do
    table.remove(self._yardSkillRecordList, #self._yardSkillRecordList)
  end
  if roleKey then
    self._detail:SetActive(true)
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleKey)
    self._name:SetText(role:GetRoleName())
    local textwidth, textheight = self._name:GetPreferredSize()
    self._name:SetDeltaSize(textwidth, textheight)
    local restEnergy = 0
    local buildingId = role:GetBuildingId()
    if buildingId then
      if buildingId == DataCommon.Explore then
        local roleInfo = NekoData.BehaviorManager.BM_Explore:GetRoles()[roleKey]
        restEnergy = roleInfo.energy
      elseif buildingId == DataCommon.Alchemy or buildingId == DataCommon.TrainCamp then
        restEnergy = role:GetEnergy()
      elseif buildingId == DataCommon.Cabin then
        if role:GetEnergy() < DataCommon.TotalEnergy then
          local roleInfo = NekoData.BehaviorManager.BM_Cabin:GetRoles()[roleKey]
          local roomInfo = NekoData.BehaviorManager.BM_Cabin:GetRoomInfoById(roleInfo.roomId)
          restEnergy = role:GetEnergy()
        else
          restEnergy = DataCommon.TotalEnergy
        end
      end
    else
      restEnergy = role:GetEnergy()
    end
    restEnergy = math.floor(restEnergy)
    self._progressNum:SetText(tostring(restEnergy) .. "/" .. tostring(DataCommon.TotalEnergy))
    self._progress:SetFillAmount(restEnergy / DataCommon.TotalEnergy)
    local imgRecord = NekoData.BehaviorManager.BM_Cabin:GetImgRecordByEnergy(restEnergy)
    if imgRecord then
      self._mood:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    else
      LogError("imgRecord is nil.")
    end
    local yardSkillList = role:GetYardSkillList()
    for i, v in ipairs(yardSkillList) do
      local yardSkillRecord = CYardSkillCfg:GetRecorder(v)
      table.insert(self._yardSkillRecordList, yardSkillRecord)
    end
    self._skillFrame:ReloadAllCell()
    local yardSkillRecord = self._yardSkillRecordList[1]
    if yardSkillRecord then
      local imgRecord = CImagePathTable:GetRecorder(yardSkillRecord.image)
      self._skillIcon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      self._skillName:SetText(TextManager.GetText(yardSkillRecord.nameTextID))
      self._skillDetail:SetText(TextManager.GetText(yardSkillRecord.descTextID))
    else
      self._skillIcon:SetActive(false)
      self._skillName:SetActive(false)
      self._skillDetail:SetActive(false)
    end
  else
    self._detail:SetActive(false)
  end
end

function ChooseRoleDialog:OnConfirmBtnClicked()
  local tag = false
  if #self._curTaskRoles == #self._selectRoles then
    for i, v in ipairs(self._curTaskRoles) do
      if not table.indexof(self._selectRoles, v) then
        tag = true
        break
      end
    end
  else
    tag = true
  end
  if tag then
    if self._buildingId == DataCommon.Explore then
      if #self._selectRoles < self._limitRolesNum then
        NekoData.BehaviorManager.BM_Message:SendMessageById(100209, {
          self._limitRolesNum
        })
      else
        local haveEnergyNotFullOrNotExploreSkill = false
        for i, v in ipairs(self._selectRoles) do
          local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(v)
          local yardSkill = role:GetYardSkillList()[1]
          if not (role:GetEnergy() == DataCommon.TotalEnergy and yardSkill) or not self._yardSkillRecorderMap[self._buildingId][yardSkill] then
            haveEnergyNotFullOrNotExploreSkill = true
          end
        end
        if haveEnergyNotFullOrNotExploreSkill then
          NekoData.BehaviorManager.BM_Message:AddSecondConfirmDialog(65, nil, function()
            if self._addTaskOrReplaceRole == "StartTask" then
              local cstartCavernTask = LuaNetManager.CreateProtocol("protocol.yard.cstartcaverntask")
              cstartCavernTask.id = self._slotId
              cstartCavernTask.roles = self._selectRoles
              cstartCavernTask:Send()
            else
              local creplaceRolesInCavern = LuaNetManager.CreateProtocol("protocol.yard.creplacerolesincavern")
              creplaceRolesInCavern.id = self._slotId
              creplaceRolesInCavern.roleIds = self._selectRoles
              creplaceRolesInCavern:Send()
            end
          end, {}, nil, {})
        elseif self._addTaskOrReplaceRole == "StartTask" then
          local cstartCavernTask = LuaNetManager.CreateProtocol("protocol.yard.cstartcaverntask")
          cstartCavernTask.id = self._slotId
          cstartCavernTask.roles = self._selectRoles
          cstartCavernTask:Send()
        else
          local creplaceRolesInCavern = LuaNetManager.CreateProtocol("protocol.yard.creplacerolesincavern")
          creplaceRolesInCavern.id = self._slotId
          creplaceRolesInCavern.roleIds = self._selectRoles
          creplaceRolesInCavern:Send()
        end
      end
    elseif self._buildingId == DataCommon.Alchemy then
      local caddRoleInAlchemy = LuaNetManager.CreateProtocol("protocol.yard.caddroleinalchemy")
      local key = self._selectRoles[1]
      if key then
        caddRoleInAlchemy.roleId = key
      else
        caddRoleInAlchemy.roleId = 0
      end
      caddRoleInAlchemy:Send()
    elseif self._buildingId == DataCommon.Cabin then
      local caddRolesInRoom = LuaNetManager.CreateProtocol("protocol.yard.caddrolesinroom")
      caddRolesInRoom.floorId = self._slotId
      caddRolesInRoom.roles = self._selectRoles
      caddRolesInRoom:Send()
    elseif self._buildingId == DataCommon.TrainCamp then
      local dialog = DialogManager.GetDialog("traincamp.trainlistdialog")
      if dialog then
        dialog:SetRoleByChooseRoleDialog(self._slotId, self._selectRoles[1])
      end
      self:Destroy()
    end
  else
    self:Destroy()
  end
end

function ChooseRoleDialog:SelectRoles(roleKey)
  local index = table.indexof(self._selectRoles, roleKey)
  if index then
    table.remove(self._selectRoles, index)
    self._roleFrame:FireEvent("SelectRoles", nil)
    self:RefreshDetailInfo(self._selectRoles[#self._selectRoles])
  elseif self._limitRolesNum == 1 then
    local key = self._selectRoles[1]
    if key then
      table.remove(self._selectRoles, 1)
    end
    table.insert(self._selectRoles, roleKey)
    self._roleFrame:FireEvent("SelectRoles", nil)
    self:RefreshDetailInfo(roleKey)
  elseif #self._selectRoles < self._limitRolesNum then
    table.insert(self._selectRoles, roleKey)
    self._roleFrame:FireEvent("SelectRoles", nil)
    self:RefreshDetailInfo(roleKey)
  end
  local str
  if #self._selectRoles < self._limitRolesNum then
    str = TextManager.GetText(CStringres:GetRecorder(1149).msgTextID)
  else
    str = TextManager.GetText(CStringres:GetRecorder(1150).msgTextID)
  end
  str = string.gsub(str, "%$parameter1%$", #self._selectRoles)
  str = string.gsub(str, "%$parameter2%$", self._limitRolesNum)
  self._chooseTxt:SetText(str)
  if self._buildingId == DataCommon.Alchemy or self._buildingId == DataCommon.Cabin or self._buildingId == DataCommon.Explore or self._buildingId == DataCommon.TrainCamp then
    self._confirmBtn:SetInteractable(true)
  else
    self._confirmBtn:SetInteractable(#self._selectRoles == self._limitRolesNum)
  end
end

function ChooseRoleDialog:NumberOfCell(frame)
  if frame == self._roleFrame then
    return #self._listByConditions
  else
    return #self._yardSkillRecordList
  end
end

function ChooseRoleDialog:CellAtIndex(frame)
  if frame == self._roleFrame then
    return "magictree.chooserolecell"
  else
    return "magictree.chooseroleskillcell"
  end
end

function ChooseRoleDialog:DataAtIndex(frame, index)
  if frame == self._roleFrame then
    return self._listByConditions[index]
  else
    return self._yardSkillRecordList[index]
  end
end

function ChooseRoleDialog:OnBackBtnClicked()
  self:Destroy()
end

function ChooseRoleDialog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

return ChooseRoleDialog
