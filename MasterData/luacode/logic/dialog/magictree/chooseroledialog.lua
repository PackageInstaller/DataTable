-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/chooseroledialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CTreeLvUp = (BeanManager.GetTableByName)("courtyard.ctreelvup")
local CExploreLvUp = (BeanManager.GetTableByName)("courtyard.cexplorelvup")
local CCourtyardLvUpCfg = (BeanManager.GetTableByName)("courtyard.ccourtyardlvup")
local CYardSkillCfg = (BeanManager.GetTableByName)("courtyard.cyardskill")
local SlotEnum = (LuaNetManager.GetBeanDef)("protocol.yard.task")
local ChooseRoleDialog = class("ChooseRoleDialog", Dialog)
ChooseRoleDialog.AssetBundleName = "ui/layouts.yard"
ChooseRoleDialog.AssetName = "YardSend"
local cellNum = 6
ChooseRoleDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChooseRoleDialog, CYardSkillCfg
  ((ChooseRoleDialog.super).Ctor)(self, ...)
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
    -- DECOMPILER ERROR at PC40: Confused about usage of register: R7 in 'UnsetPending'

    if not (self._yardSkillRecorderMap)[recorder.functionID] then
      (self._yardSkillRecorderMap)[recorder.functionID] = {}
    end
    -- DECOMPILER ERROR at PC45: Confused about usage of register: R7 in 'UnsetPending'

    ;
    ((self._yardSkillRecorderMap)[recorder.functionID])[recorder.id] = true
  end
end

ChooseRoleDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : GridFrame, cellNum, TableFrame, _ENV
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
  self._roleFrame = (GridFrame.Create)(self._rolePanel, self, true, cellNum)
  ;
  (self._roleFrame):SetMargin(40, 40)
  self._skillFrame = (TableFrame.Create)(self._skillPanel, self, true, false)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleEnergyChanged, Common.n_RoleEnergyChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshAllExploreSlots, Common.n_RefreshAllExploreSlots, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshExploreSlot, Common.n_RefreshExploreSlot, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshExploreSlotActive, Common.n_RefreshExploreSlotActive, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnAlchemyRoleChanged, Common.n_AlchemyRoleChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRoomFurnitures, Common.n_RefreshRoomFurnitures, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshRoom, Common.n_RefreshRoom, nil)
end

ChooseRoleDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._task then
    (GameTimer.RemoveTask)(self._task)
    self._task = nil
  end
  ;
  (self._roleFrame):Destroy()
  ;
  (self._skillFrame):Destroy()
end

ChooseRoleDialog.OnRoleEnergyChanged = function(self, notification)
  -- function num : 0_3 , upvalues : _ENV
  local roles = {}
  for i,v in ipairs((notification.userInfo).list) do
    roles[v.id] = true
  end
  for i,v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R9 in 'UnsetPending'

    if roles[key] then
      (self._listByConditions)[i] = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
    end
  end
  ;
  (self._roleFrame):FireEvent("RefreshCell", roles)
end

ChooseRoleDialog.OnRefreshAllExploreSlots = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
  local roles = ((NekoData.BehaviorManager).BM_Explore):GetRoles()
  for i,v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R9 in 'UnsetPending'

    if roles[key] then
      (self._listByConditions)[i] = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
    end
  end
  ;
  (self._roleFrame):FireEvent("RefreshCell", roles)
end

ChooseRoleDialog.OnAlchemyRoleChanged = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local roleKey = ((notification.userInfo).alchemy).roleId
  if roleKey and roleKey ~= 0 then
    for i,v in ipairs(self._listByConditions) do
      local key = v:GetRoleId()
      -- DECOMPILER ERROR at PC22: Confused about usage of register: R9 in 'UnsetPending'

      if key == roleKey then
        (self._listByConditions)[i] = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
      end
    end
    ;
    (self._roleFrame):FireEvent("RefreshCell", {[roleKey] = true})
  end
end

ChooseRoleDialog.OnRefreshRoomFurnitures = function(self, notification)
  -- function num : 0_6 , upvalues : _ENV
  local roles = {}
  for k,v in pairs(((notification.userInfo).floor).rolesLeftRecoveryTime) do
    roles[k] = true
  end
  for i,v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R9 in 'UnsetPending'

    if roles[key] then
      (self._listByConditions)[i] = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
    end
  end
  ;
  (self._roleFrame):FireEvent("RefreshCell", roles)
end

ChooseRoleDialog.OnRefreshRoom = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  local roles = {}
  for k,v in pairs(((notification.userInfo).floor).rolesLeftRecoveryTime) do
    roles[k] = true
  end
  for i,v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    -- DECOMPILER ERROR at PC26: Confused about usage of register: R9 in 'UnsetPending'

    if roles[key] then
      (self._listByConditions)[i] = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
    end
  end
  ;
  (self._roleFrame):FireEvent("RefreshCell", roles)
end

ChooseRoleDialog.OnRefreshExploreSlot = function(self, notification)
  -- function num : 0_8 , upvalues : _ENV
  local roles = {}
  for i,v in ipairs(((notification.userInfo).task).roles) do
    roles[v.roleId] = true
  end
  for i,v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R9 in 'UnsetPending'

    if roles[key] then
      (self._listByConditions)[i] = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
    end
  end
  ;
  (self._roleFrame):FireEvent("RefreshCell", roles)
end

ChooseRoleDialog.OnRefreshExploreSlotActive = function(self, notification)
  -- function num : 0_9 , upvalues : _ENV
  local roles = {}
  for i,v in ipairs(((notification.userInfo).cavernTask).roles) do
    roles[v.roleId] = true
  end
  for i,v in ipairs(self._listByConditions) do
    local key = v:GetRoleId()
    -- DECOMPILER ERROR at PC27: Confused about usage of register: R9 in 'UnsetPending'

    if roles[key] then
      (self._listByConditions)[i] = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key)
    end
  end
  ;
  (self._roleFrame):FireEvent("RefreshCell", roles)
end

ChooseRoleDialog.Init = function(self, tag, buildingId, slotId)
  -- function num : 0_10 , upvalues : _ENV, CTreeLvUp, CExploreLvUp, CStringres
  self._addTaskOrReplaceRole = tag
  self._buildingId = buildingId
  self._slotId = slotId
  local selectRoles = nil
  if self._buildingId == DataCommon.MagicTree then
    self._limitRolesNum = (CTreeLvUp:GetRecorder(((NekoData.BehaviorManager).BM_MagicTree):GetLevel())).roleNum
    selectRoles = ((NekoData.BehaviorManager).BM_MagicTree):GetDispatchRoles()
  else
    if self._buildingId == DataCommon.Explore then
      self._limitRolesNum = (CExploreLvUp:GetRecorder(((NekoData.BehaviorManager).BM_Explore):GetLevel())).roleNum
      selectRoles = {}
      for i,v in ipairs((((NekoData.BehaviorManager).BM_Explore):GetSlotInfoBySlotId(slotId)).roles) do
        (table.insert)(selectRoles, v)
      end
    else
      do
        if self._buildingId == DataCommon.Firefly then
          self._limitRolesNum = ((NekoData.BehaviorManager).BM_Firefly):GetDispatchMaxRoleNum()
          selectRoles = ((NekoData.BehaviorManager).BM_Firefly):GetDispatchRoles()
        else
          if self._buildingId == DataCommon.Alchemy then
            self._limitRolesNum = ((NekoData.BehaviorManager).BM_Alchemy):GetDispatchMaxRoleNum()
            selectRoles = ((NekoData.BehaviorManager).BM_Alchemy):GetDispatchRoles()
          else
            if self._buildingId == DataCommon.Cabin then
              self._limitRolesNum = ((NekoData.BehaviorManager).BM_Cabin):GetDispatchLimitRoleNum()
              local roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById(self._slotId)
              selectRoles = {}
              for i,v in ipairs(roomInfo.roles) do
                (table.insert)(selectRoles, v)
              end
            else
              do
                if self._buildingId == DataCommon.TrainCamp then
                  self._limitRolesNum = ((NekoData.BehaviorManager).BM_TrainCamp):GetDispatchLimitRoleNum()
                  selectRoles = {}
                  local dialog = (DialogManager.GetDialog)("traincamp.trainlistdialog")
                  if dialog and (dialog._roles)[self._slotId] ~= 0 then
                    (table.insert)(selectRoles, (dialog._roles)[self._slotId])
                  end
                end
                do
                  self._selectRoles = {}
                  if selectRoles then
                    self._curTaskRoles = selectRoles
                    for i,v in ipairs(selectRoles) do
                      (table.insert)(self._selectRoles, v)
                    end
                    local num = #selectRoles
                    if num > 0 then
                      self:RefreshDetailInfo(selectRoles[num])
                    end
                  else
                    do
                      self._curTaskRoles = {}
                      self:RefreshDetailInfo(nil)
                      local str = nil
                      if #self._selectRoles < self._limitRolesNum then
                        str = (TextManager.GetText)((CStringres:GetRecorder(1149)).msgTextID)
                      else
                        str = (TextManager.GetText)((CStringres:GetRecorder(1150)).msgTextID)
                      end
                      str = (string.gsub)(str, "%$parameter1%$", #self._selectRoles)
                      str = (string.gsub)(str, "%$parameter2%$", self._limitRolesNum)
                      ;
                      (self._chooseTxt):SetText(str)
                      if self._buildingId == DataCommon.Alchemy or self._buildingId == DataCommon.Cabin or self._buildingId == DataCommon.Explore or self._buildingId == DataCommon.TrainCamp then
                        (self._confirmBtn):SetInteractable(true)
                      else
                        ;
                        (self._confirmBtn):SetInteractable(#self._selectRoles == self._limitRolesNum)
                      end
                      self:LoadLocalData()
                      ;
                      (self._roleFrame):ReloadAllCell()
                      if self._task then
                        (GameTimer.RemoveTask)(self._task)
                        self._task = nil
                      end
                      self._task = (GameTimer.AddTask)(0, 60, function()
    -- function num : 0_10_0 , upvalues : self
    (self._roleFrame):FireEvent("RefreshEnergy")
    local num = #self._selectRoles
    if num > 0 then
      self:RefreshDetailInfo((self._selectRoles)[num])
    else
      self:RefreshDetailInfo(nil)
    end
  end
, nil)
                      -- DECOMPILER ERROR: 3 unprocessed JMP targets
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

ChooseRoleDialog.LoadLocalData = function(self)
  -- function num : 0_11 , upvalues : _ENV
  local roleList = ((NekoData.BehaviorManager).BM_AllRoles):GetContainMaterialRoleList()
  local selectRoleList = {}
  local workingCanNotChooseRoleList = {}
  local skillAndEnergyRoleList = {
haveSkill = {}
, 
haveNoSkill = {}
, 
haveNoEnergy = {}
}
  local cabinEnergyNotFullRoleList = {}
  local cabinRoleListFromOtherRooms = {}
  local trainCampRoleList = {
reachLimit = {}
, 
notReachLimit = {}
}
  local cabinRoles = {}
  if self._buildingId == DataCommon.Cabin then
    cabinRoles = ((NekoData.BehaviorManager).BM_Cabin):GetRoles()
  end
  local selectRoleMap = {}
  for i,v in ipairs(self._curTaskRoles) do
    selectRoleMap[v] = i
  end
  local removeIndexList = {}
  for i,v in ipairs(roleList) do
    local index = selectRoleMap[v:GetRoleId()]
    if index then
      (table.insert)(removeIndexList, i)
      ;
      (table.insert)(selectRoleList, {index = index, role = v})
    else
      if (v:GetBuildingId() and v:GetBuildingId() == DataCommon.Explore) or v:GetBuildingId() == DataCommon.TrainCamp then
        (table.insert)(workingCanNotChooseRoleList, v)
      else
        if self._buildingId == DataCommon.Alchemy then
          if v:GetEnergy() > 0 then
            local yardSkillId = (v:GetYardSkillList())[1]
            if yardSkillId and ((self._yardSkillRecorderMap)[self._buildingId])[yardSkillId] then
              (table.insert)(skillAndEnergyRoleList.haveSkill, v)
            else
              ;
              (table.insert)(skillAndEnergyRoleList.haveNoSkill, v)
            end
          else
            do
              ;
              (table.insert)(skillAndEnergyRoleList.haveNoEnergy, v)
              if self._buildingId == DataCommon.Explore then
                if v:GetEnergy() > 0 then
                  local yardSkillId = (v:GetYardSkillList())[1]
                  if yardSkillId and ((self._yardSkillRecorderMap)[self._buildingId])[yardSkillId] then
                    (table.insert)(skillAndEnergyRoleList.haveSkill, v)
                  else
                    ;
                    (table.insert)(skillAndEnergyRoleList.haveNoSkill, v)
                  end
                else
                  do
                    ;
                    (table.insert)(skillAndEnergyRoleList.haveNoEnergy, v)
                    if self._buildingId == DataCommon.Cabin then
                      if cabinRoles[v:GetRoleId()] and (cabinRoles[v:GetRoleId()]).roomId ~= self._slotId then
                        (table.insert)(cabinRoleListFromOtherRooms, v)
                      else
                        if DataCommon.TotalEnergy <= v:GetEnergy() then
                          local yardSkillId = (v:GetYardSkillList())[1]
                          if yardSkillId and ((self._yardSkillRecorderMap)[self._buildingId])[yardSkillId] then
                            (table.insert)(skillAndEnergyRoleList.haveSkill, v)
                          else
                            ;
                            (table.insert)(skillAndEnergyRoleList.haveNoSkill, v)
                          end
                        else
                          do
                            do
                              ;
                              (table.insert)(cabinEnergyNotFullRoleList, v)
                              if self._buildingId == DataCommon.TrainCamp then
                                if v:GetLevel() < v:GetMaxLevel() then
                                  (table.insert)(trainCampRoleList.notReachLimit, v)
                                else
                                  ;
                                  (table.insert)(trainCampRoleList.reachLimit, v)
                                end
                              end
                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out DO_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_THEN_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                              -- DECOMPILER ERROR at PC242: LeaveBlock: unexpected jumping out IF_STMT

                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  ;
  (table.sort)(selectRoleList, function(a, b)
    -- function num : 0_11_0
    do return a.index < b.index end
    -- DECOMPILER ERROR: 1 unprocessed JMP targets
  end
)
  for i,v in ipairs(selectRoleList) do
    (table.insert)(self._listByConditions, (selectRoleList[i]).role)
  end
  if self._buildingId ~= DataCommon.Cabin and self._buildingId ~= DataCommon.TrainCamp then
    (table.sort)(skillAndEnergyRoleList.haveSkill, function(a, b)
    -- function num : 0_11_1 , upvalues : _ENV
    local aRestEnergy, bRestEnergy = (math.floor)(a:GetEnergy()), (math.floor)(b:GetEnergy())
    if bRestEnergy >= aRestEnergy then
      do return aRestEnergy == bRestEnergy end
      local _a, _b = a:GetBirthDay(), b:GetBirthDay()
      if a:GetId() >= b:GetId() then
        do
          do return _a ~= _b end
          do return _b < _a end
          -- DECOMPILER ERROR: 6 unprocessed JMP targets
        end
      end
    end
  end
)
    ;
    (table.sort)(skillAndEnergyRoleList.haveNoSkill, function(a, b)
    -- function num : 0_11_2 , upvalues : _ENV
    local aRestEnergy, bRestEnergy = (math.floor)(a:GetEnergy()), (math.floor)(b:GetEnergy())
    if bRestEnergy >= aRestEnergy then
      do return aRestEnergy == bRestEnergy end
      local _a, _b = a:GetBirthDay(), b:GetBirthDay()
      if a:GetId() >= b:GetId() then
        do
          do return _a ~= _b end
          do return _b < _a end
          -- DECOMPILER ERROR: 6 unprocessed JMP targets
        end
      end
    end
  end
)
    for i,v in ipairs(skillAndEnergyRoleList.haveSkill) do
      (table.insert)(self._listByConditions, v)
    end
    for i,v in ipairs(skillAndEnergyRoleList.haveNoSkill) do
      (table.insert)(self._listByConditions, v)
    end
    for i,v in ipairs(skillAndEnergyRoleList.haveNoEnergy) do
      (table.insert)(self._listByConditions, v)
    end
  else
    do
      if self._buildingId == DataCommon.Cabin then
        (table.sort)(cabinEnergyNotFullRoleList, function(a, b)
    -- function num : 0_11_3 , upvalues : _ENV, self
    local aRestEnergy, bRestEnergy = (math.floor)(a:GetEnergy()), (math.floor)(b:GetEnergy())
    if aRestEnergy >= bRestEnergy then
      do return aRestEnergy == bRestEnergy end
      local yardSkillId_a, yardSkillId_b = (a:GetYardSkillList())[1], (b:GetYardSkillList())[1]
      local isBuildingSkill_a, isBuildingSkill_b = ((self._yardSkillRecorderMap)[self._buildingId])[yardSkillId_a], ((self._yardSkillRecorderMap)[self._buildingId])[yardSkillId_b]
      if yardSkillId_a and isBuildingSkill_a and (not yardSkillId_b or not isBuildingSkill_b) then
        return true
      elseif yardSkillId_a and isBuildingSkill_a and yardSkillId_b and isBuildingSkill_b then
        local _a, _b = a:GetBirthDay(), b:GetBirthDay()
        if a:GetId() >= b:GetId() then
          do
            do return _a ~= _b end
            do return _b < _a end
            if (not yardSkillId_a or not isBuildingSkill_a) and (not yardSkillId_b or not isBuildingSkill_b) then
              local _a, _b = a:GetBirthDay(), b:GetBirthDay()
              if a:GetId() >= b:GetId() then
                do
                  do
                    do return _a ~= _b end
                    do return _b < _a end
                    do return false end
                    -- DECOMPILER ERROR: 15 unprocessed JMP targets
                  end
                end
              end
            end
          end
        end
      end
    end
  end
)
        for i,v in ipairs(cabinEnergyNotFullRoleList) do
          (table.insert)(self._listByConditions, v)
        end
        for i,v in ipairs(skillAndEnergyRoleList.haveSkill) do
          (table.insert)(self._listByConditions, v)
        end
        for i,v in ipairs(skillAndEnergyRoleList.haveNoSkill) do
          (table.insert)(self._listByConditions, v)
        end
        for i,v in ipairs(cabinRoleListFromOtherRooms) do
          (table.insert)(self._listByConditions, v)
        end
      else
        do
          if self._buildingId == DataCommon.TrainCamp then
            (table.sort)(trainCampRoleList.notReachLimit, function(a, b)
    -- function num : 0_11_4
    local _a, _b = a:GetRarityId(), b:GetRarityId()
    if _a == _b then
      local _aLv, _bLv = a:GetLevel(), b:GetLevel()
      if b:GetBirthDay() >= a:GetBirthDay() then
        do
          do return _aLv ~= _bLv end
          do return _aLv < _bLv end
          do return _b < _a end
          -- DECOMPILER ERROR: 6 unprocessed JMP targets
        end
      end
    end
  end
)
            ;
            (table.sort)(trainCampRoleList.reachLimit, function(a, b)
    -- function num : 0_11_5
    local _a, _b = a:GetRarityId(), b:GetRarityId()
    if _a == _b then
      local _aLv, _bLv = a:GetLevel(), b:GetLevel()
      if b:GetBirthDay() >= a:GetBirthDay() then
        do
          do return _aLv ~= _bLv end
          do return _aLv < _bLv end
          do return _b < _a end
          -- DECOMPILER ERROR: 6 unprocessed JMP targets
        end
      end
    end
  end
)
            for i,v in ipairs(trainCampRoleList.notReachLimit) do
              (table.insert)(self._listByConditions, v)
            end
            for i,v in ipairs(trainCampRoleList.reachLimit) do
              (table.insert)(self._listByConditions, v)
            end
          end
          do
            for i,v in ipairs(workingCanNotChooseRoleList) do
              (table.insert)(self._listByConditions, v)
            end
          end
        end
      end
    end
  end
end

ChooseRoleDialog.RefreshDetailInfo = function(self, roleKey)
  -- function num : 0_12 , upvalues : _ENV, CYardSkillCfg, CImagePathTable
  while (self._yardSkillRecordList)[#self._yardSkillRecordList] do
    (table.remove)(self._yardSkillRecordList, #self._yardSkillRecordList)
  end
  if roleKey then
    (self._detail):SetActive(true)
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleKey)
    ;
    (self._name):SetText(role:GetRoleName())
    local textwidth, textheight = (self._name):GetPreferredSize()
    ;
    (self._name):SetDeltaSize(textwidth, textheight)
    local restEnergy = 0
    local buildingId = role:GetBuildingId()
    if buildingId then
      if buildingId == DataCommon.Explore then
        local roleInfo = (((NekoData.BehaviorManager).BM_Explore):GetRoles())[roleKey]
        restEnergy = roleInfo.energy
      else
        do
          if buildingId == DataCommon.Alchemy or buildingId == DataCommon.TrainCamp then
            restEnergy = role:GetEnergy()
          else
            if buildingId == DataCommon.Cabin then
              if role:GetEnergy() < DataCommon.TotalEnergy then
                local roleInfo = (((NekoData.BehaviorManager).BM_Cabin):GetRoles())[roleKey]
                local roomInfo = ((NekoData.BehaviorManager).BM_Cabin):GetRoomInfoById(roleInfo.roomId)
                restEnergy = role:GetEnergy()
              else
                do
                  restEnergy = DataCommon.TotalEnergy
                  restEnergy = role:GetEnergy()
                  restEnergy = (math.floor)(restEnergy)
                  ;
                  (self._progressNum):SetText(tostring(restEnergy) .. "/" .. tostring(DataCommon.TotalEnergy))
                  ;
                  (self._progress):SetFillAmount(restEnergy / DataCommon.TotalEnergy)
                  local imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetImgRecordByEnergy(restEnergy)
                  if imgRecord then
                    (self._mood):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                  else
                    LogError("imgRecord is nil.")
                  end
                  local yardSkillList = role:GetYardSkillList()
                  for i,v in ipairs(yardSkillList) do
                    local yardSkillRecord = CYardSkillCfg:GetRecorder(v)
                    ;
                    (table.insert)(self._yardSkillRecordList, yardSkillRecord)
                  end
                  ;
                  (self._skillFrame):ReloadAllCell()
                  local yardSkillRecord = (self._yardSkillRecordList)[1]
                  if yardSkillRecord then
                    local imgRecord = CImagePathTable:GetRecorder(yardSkillRecord.image)
                    ;
                    (self._skillIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
                    ;
                    (self._skillName):SetText((TextManager.GetText)(yardSkillRecord.nameTextID))
                    ;
                    (self._skillDetail):SetText((TextManager.GetText)(yardSkillRecord.descTextID))
                  else
                    do
                      do
                        ;
                        (self._skillIcon):SetActive(false)
                        ;
                        (self._skillName):SetActive(false)
                        ;
                        (self._skillDetail):SetActive(false)
                        ;
                        (self._detail):SetActive(false)
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

ChooseRoleDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local tag = false
  if #self._curTaskRoles == #self._selectRoles then
    for i,v in ipairs(self._curTaskRoles) do
      if not (table.indexof)(self._selectRoles, v) then
        tag = true
        break
      end
    end
  else
    do
      tag = true
      if tag then
        if self._buildingId == DataCommon.Explore then
          if #self._selectRoles < self._limitRolesNum then
            ((NekoData.BehaviorManager).BM_Message):SendMessageById(100209, {self._limitRolesNum})
          else
            local haveEnergyNotFullOrNotExploreSkill = false
            for i,v in ipairs(self._selectRoles) do
              local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(v)
              local yardSkill = (role:GetYardSkillList())[1]
              if role:GetEnergy() ~= DataCommon.TotalEnergy or not yardSkill or not ((self._yardSkillRecorderMap)[self._buildingId])[yardSkill] then
                haveEnergyNotFullOrNotExploreSkill = true
              end
            end
            if haveEnergyNotFullOrNotExploreSkill then
              ((NekoData.BehaviorManager).BM_Message):AddSecondConfirmDialog(65, nil, function()
    -- function num : 0_13_0 , upvalues : self, _ENV
    if self._addTaskOrReplaceRole == "StartTask" then
      local cstartCavernTask = (LuaNetManager.CreateProtocol)("protocol.yard.cstartcaverntask")
      cstartCavernTask.id = self._slotId
      cstartCavernTask.roles = self._selectRoles
      cstartCavernTask:Send()
    else
      do
        local creplaceRolesInCavern = (LuaNetManager.CreateProtocol)("protocol.yard.creplacerolesincavern")
        creplaceRolesInCavern.id = self._slotId
        creplaceRolesInCavern.roleIds = self._selectRoles
        creplaceRolesInCavern:Send()
      end
    end
  end
, {}, nil, {})
            else
              if self._addTaskOrReplaceRole == "StartTask" then
                local cstartCavernTask = (LuaNetManager.CreateProtocol)("protocol.yard.cstartcaverntask")
                cstartCavernTask.id = self._slotId
                cstartCavernTask.roles = self._selectRoles
                cstartCavernTask:Send()
              else
                do
                  do
                    local creplaceRolesInCavern = (LuaNetManager.CreateProtocol)("protocol.yard.creplacerolesincavern")
                    creplaceRolesInCavern.id = self._slotId
                    creplaceRolesInCavern.roleIds = self._selectRoles
                    creplaceRolesInCavern:Send()
                    if self._buildingId == DataCommon.Alchemy then
                      local caddRoleInAlchemy = (LuaNetManager.CreateProtocol)("protocol.yard.caddroleinalchemy")
                      local key = (self._selectRoles)[1]
                      if key then
                        caddRoleInAlchemy.roleId = key
                      else
                        caddRoleInAlchemy.roleId = 0
                      end
                      caddRoleInAlchemy:Send()
                    else
                      do
                        if self._buildingId == DataCommon.Cabin then
                          local caddRolesInRoom = (LuaNetManager.CreateProtocol)("protocol.yard.caddrolesinroom")
                          caddRolesInRoom.floorId = self._slotId
                          caddRolesInRoom.roles = self._selectRoles
                          caddRolesInRoom:Send()
                        else
                          do
                            do
                              if self._buildingId == DataCommon.TrainCamp then
                                local dialog = (DialogManager.GetDialog)("traincamp.trainlistdialog")
                                if dialog then
                                  dialog:SetRoleByChooseRoleDialog(self._slotId, (self._selectRoles)[1])
                                end
                                self:Destroy()
                              end
                              self:Destroy()
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

ChooseRoleDialog.SelectRoles = function(self, roleKey)
  -- function num : 0_14 , upvalues : _ENV, CStringres
  local index = (table.indexof)(self._selectRoles, roleKey)
  if index then
    (table.remove)(self._selectRoles, index)
    ;
    (self._roleFrame):FireEvent("SelectRoles", nil)
    self:RefreshDetailInfo((self._selectRoles)[#self._selectRoles])
  else
    if self._limitRolesNum == 1 then
      local key = (self._selectRoles)[1]
      if key then
        (table.remove)(self._selectRoles, 1)
      end
      ;
      (table.insert)(self._selectRoles, roleKey)
      ;
      (self._roleFrame):FireEvent("SelectRoles", nil)
      self:RefreshDetailInfo(roleKey)
    else
      do
        if #self._selectRoles < self._limitRolesNum then
          (table.insert)(self._selectRoles, roleKey)
          ;
          (self._roleFrame):FireEvent("SelectRoles", nil)
          self:RefreshDetailInfo(roleKey)
        end
        local str = nil
        if #self._selectRoles < self._limitRolesNum then
          str = (TextManager.GetText)((CStringres:GetRecorder(1149)).msgTextID)
        else
          str = (TextManager.GetText)((CStringres:GetRecorder(1150)).msgTextID)
        end
        str = (string.gsub)(str, "%$parameter1%$", #self._selectRoles)
        str = (string.gsub)(str, "%$parameter2%$", self._limitRolesNum)
        ;
        (self._chooseTxt):SetText(str)
        if self._buildingId == DataCommon.Alchemy or self._buildingId == DataCommon.Cabin or self._buildingId == DataCommon.Explore or self._buildingId == DataCommon.TrainCamp then
          (self._confirmBtn):SetInteractable(true)
        else
          ;
          (self._confirmBtn):SetInteractable(#self._selectRoles == self._limitRolesNum)
        end
        -- DECOMPILER ERROR: 2 unprocessed JMP targets
      end
    end
  end
end

ChooseRoleDialog.NumberOfCell = function(self, frame)
  -- function num : 0_15
  if frame == self._roleFrame then
    return #self._listByConditions
  else
    return #self._yardSkillRecordList
  end
end

ChooseRoleDialog.CellAtIndex = function(self, frame)
  -- function num : 0_16
  if frame == self._roleFrame then
    return "magictree.chooserolecell"
  else
    return "magictree.chooseroleskillcell"
  end
end

ChooseRoleDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_17
  if frame == self._roleFrame then
    return (self._listByConditions)[index]
  else
    return (self._yardSkillRecordList)[index]
  end
end

ChooseRoleDialog.OnBackBtnClicked = function(self)
  -- function num : 0_18
  self:Destroy()
end

ChooseRoleDialog.OnMenuBtnClicked = function(self)
  -- function num : 0_19 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

return ChooseRoleDialog

