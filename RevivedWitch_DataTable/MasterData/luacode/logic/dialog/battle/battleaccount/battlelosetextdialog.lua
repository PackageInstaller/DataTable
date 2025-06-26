-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/battle/battleaccount/battlelosetextdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local LineUpStation = (LuaNetManager.GetBeanDef)("protocol.login.lineupstation")
local Item = require("logic.manager.experimental.types.item")
local Skill = require("logic.manager.experimental.types.skill")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local EquipTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.equiptype")
local MainLineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local ResourceStageTable = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local CStarrymirrorlevel = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel")
local CHEXAGONBATTLECONFIG = (BeanManager.GetTableByName)("dungeonselect.chexagonbattleconfig")
local CHEXAGONFUNCTION = (BeanManager.GetTableByName)("activity.chexagonfunction")
local CInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cinterfacefunction")
local CValentineInterfaceFunction = (BeanManager.GetTableByName)("dungeonselect.cvalentineinterfacefunction")
local CFragmentLevelCfg = (BeanManager.GetTableByName)("dungeonselect.cfragmentlevelcfg")
local CBattleConfig = (BeanManager.GetTableByName)("battle.cbattleconstcfg")
local CAnniversarylevel = (BeanManager.GetTableByName)("dungeonselect.canniversarylevel")
local CSRFunction = (BeanManager.GetTableByName)("activity.csrfunction")
local CSRResourceDungeonStage = (BeanManager.GetTableByName)("activity.csrresourcedungeonstage")
local TableFrame = require("framework.ui.frame.table.tableframe")
local EquipTypeIndex = {[EquipTypeEnum.WEAPON] = 1, [EquipTypeEnum.ARMOR] = 2, [EquipTypeEnum.JEWELRY] = 3}
local Priority = 10
local Priority_EquipRatio = tonumber((CBattleConfig:GetRecorder(117)).attr)
local Priority_SkillRatio = tonumber((CBattleConfig:GetRecorder(116)).attr)
local BattleLoseTextDialog = class("BattleLoseTextDialog", Dialog)
BattleLoseTextDialog.AssetBundleName = "ui/layouts.battlelose"
BattleLoseTextDialog.AssetName = "BattleLoseTxt"
BattleLoseTextDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleLoseTextDialog
  ((BattleLoseTextDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._guideStrengthenList = {}
  self._selectGuideType = nil
  self._playMoveUpAnimation = false
  self._playMoveUpAnimationTag = false
  self._showGuidePanelFinished = false
end

BattleLoseTextDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._spiritGive = self:GetChild("SpiritGive")
  self._text = self:GetChild("SpiritGive/Txt")
  self._itemCell = self:GetChild("SpiritGive/ItemCell")
  self._itemIcon = self:GetChild("SpiritGive/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("SpiritGive/ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("SpiritGive/ItemCell/_Count")
  self._guidePanel = self:GetChild("DefeatGuide")
  self._guidePanel_cellPanel = self:GetChild("DefeatGuide/Frame")
  self._guidePanel_cellPanel_width = (self._guidePanel_cellPanel):GetRectSize()
  self._guidePanel_cellPanel_anchoredx = (self._guidePanel_cellPanel):GetAnchoredPosition()
  self._guidePanel_cellFrame = (TableFrame.Create)(self._guidePanel_cellPanel, self, false, false)
  self._rolesShowPanel = self:GetChild("DefeatGuideFrame")
  self._rolesShowFrame = (TableFrame.Create)(self._rolesShowPanel, self, true, true, true)
  ;
  (self._itemCell):Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_StateExitEvent(self.OnBattleLoseOver, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnWindowClicked, self)
  self:PlayDefeatVoice()
  self:InitSpiritData()
  self:ShowGuidePanel()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritData, Common.n_OnSEnterMainCity, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshSpiritData, Common.n_OnSShowObtainPanel, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleLevelUp, Common.n_LevelUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnEquipLevelUp, Common.n_EquipLevelUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnSkillImprove, Common.n_ImproveSkill, nil)
end

BattleLoseTextDialog.OnDestroy = function(self)
  -- function num : 0_2
  (self._guidePanel_cellFrame):Destroy()
  ;
  (self._rolesShowFrame):Destroy()
end

BattleLoseTextDialog.PlayDefeatVoice = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local currentTeamId = ((NekoData.BehaviorManager).BM_SBattleStart):GetLineId()
  local roleInfo = ((NekoData.BehaviorManager).BM_Team):GetTeamRoles(currentTeamId)
  local roleList = {}
  local i = nil
  for _,key in ipairs(roleInfo) do
    if key ~= 0 then
      (table.insert)(roleList, ((NekoData.BehaviorManager).BM_AllRoles):GetRole(key))
    end
  end
  if #roleList == 0 then
    (table.insert)(roleList, ((NekoData.BehaviorManager).BM_AllRoles):GetRole(1))
  end
  i = (math.random)(1, #roleList)
  ;
  ((NekoData.BehaviorManager).BM_Voice):Play((roleList[i]):GetId(), (((NekoData.BehaviorManager).BM_Voice).VoiceType).Defeat, nil)
end

BattleLoseTextDialog.OnBattleLoseOver = function(self, arg1, arg2)
  -- function num : 0_4
  if arg2 == "BattleLoseTxt" then
    self:Destroy()
  end
end

BattleLoseTextDialog.OnWindowClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

BattleLoseTextDialog.InitSpiritData = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if GlobalGameFSM then
    if GlobalGameFSM:GetCurrentState() == "MainCityBattle" or GlobalGameFSM:GetCurrentState() == "SwimSuitActivityBattle" then
      self:SetSpiritGiveData(((NekoData.BehaviorManager).BM_Game):GetResourceObtainMoney())
    else
      if GlobalGameFSM:GetCurrentState() == "DungeonBattle" then
        self:SetSpiritGiveData(((NekoData.BehaviorManager).BM_Game):GetDungeonObtainMoney())
      else
        if GlobalGameFSM:GetCurrentState() == "TowerV2Battle" then
          (self._spiritGive):SetActive(false)
        end
      end
    end
  end
end

BattleLoseTextDialog.RefreshSpiritData = function(self, notification)
  -- function num : 0_7 , upvalues : _ENV
  -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

  -- DECOMPILER ERROR at PC16: Unhandled construct in 'MakeBoolean' P1

  if GlobalGameFSM and GlobalGameFSM:GetCurrentState() == "MainCityBattle" and notification.name == Common.n_OnSShowObtainPanel then
    self:SetSpiritGiveData((notification.userInfo).awardCurrency)
  end
  if GlobalGameFSM:GetCurrentState() == "DungeonBattle" and notification.name == Common.n_OnSEnterMainCity then
    self:SetSpiritGiveData((notification.userInfo).money)
  end
end

local PlayMoveUpAnimation = function(self)
  -- function num : 0_8
  if not self._playMoveUpAnimationTag and self._showGuidePanelFinished and self._playMoveUpAnimation then
    self._playMoveUpAnimationTag = true
    ;
    (self:GetRootWindow()):PlayAnimation("BattleLoseStarBoss")
  end
end

BattleLoseTextDialog.SetSpiritGiveData = function(self, moneyInfo)
  -- function num : 0_9 , upvalues : _ENV, Item, CStringRes, PlayMoveUpAnimation
  if moneyInfo and next(moneyInfo) ~= nil and moneyInfo[35003] ~= nil and moneyInfo[35003] > 0 then
    (self._spiritGive):SetActive(true)
    self._itemId = 35003
    self._itemNum = moneyInfo[35003]
    self._item = (Item.Create)(self._itemId)
    ;
    (self._itemCount):SetText((NumberManager.GetShowNumber)(self._itemNum))
    ;
    (self._itemIcon):SetSprite(((self._item):GetIcon()).assetBundle, ((self._item):GetIcon()).assetName)
    ;
    (self._itemFrame):SetSprite(((self._item):GetPinJiImage()).assetBundle, ((self._item):GetPinJiImage()).assetName)
    ;
    (self._text):SetText((string.gsub)((TextManager.GetText)((CStringRes:GetRecorder(1440)).msgTextID), "%$parameter1%$", self._itemNum))
    self._playMoveUpAnimation = true
    PlayMoveUpAnimation(self)
  else
    ;
    (self._spiritGive):SetActive(false)
    self._playMoveUpAnimation = false
    PlayMoveUpAnimation(self)
  end
end

BattleLoseTextDialog.OnItemCellClicked = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if dialog then
    dialog:Init({item = self._item})
  end
end

local RefreshLevelUpRoleList = function(self)
  -- function num : 0_11 , upvalues : _ENV, Priority, LineUpStation
  if self._recommendRoleLevel then
    local tag = false
    local recommend_priority = nil
    local list1 = {}
    local list2 = {}
    for station,roleId in pairs(self._teamRoles) do
      if roleId ~= 0 then
        local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
        if role:GetLevel() < self._recommendRoleLevel then
          local temp = self._recommendRoleLevel - role:GetLevel()
          if Priority < temp and (not recommend_priority or recommend_priority < temp) then
            recommend_priority = temp
          end
          tag = true
          if self._isShattered then
            (table.insert)(list1, role)
          else
            if station < LineUpStation.ALTERNATE_FRONT_ROW then
              (table.insert)(list1, role)
            else
              ;
              (table.insert)(list2, role)
            end
          end
        end
      end
    end
    if tag then
      (table.sort)(list1, function(a, b)
    -- function num : 0_11_0
    local a_lv, b_lv = a:GetLevel(), b:GetLevel()
    if a_lv == b_lv then
      local a_rarity, b_rarity = a:GetRarityId(), b:GetRarityId()
      if a_rarity == b_rarity then
        local a_id, b_id = a:GetId(), b:GetId()
        return a_id < b_id
      else
        return b_rarity < a_rarity
      end
    else
      return a_lv < b_lv
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
)
      ;
      (table.sort)(list2, function(a, b)
    -- function num : 0_11_1
    local a_lv, b_lv = a:GetLevel(), b:GetLevel()
    if a_lv == b_lv then
      local a_rarity, b_rarity = a:GetRarityId(), b:GetRarityId()
      if a_rarity == b_rarity then
        local a_id, b_id = a:GetId(), b:GetId()
        return a_id < b_id
      else
        return b_rarity < a_rarity
      end
    else
      return a_lv < b_lv
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
)
      local roleList = {}
      for i,v in ipairs(list1) do
        (table.insert)(roleList, v)
      end
      for i,v in ipairs(list2) do
        (table.insert)(roleList, v)
      end
      ;
      (table.insert)(self._guideStrengthenList, {tag = "RoleLevelUp", recommend_priority = recommend_priority, recommendRoleLevel = self._recommendRoleLevel, roleList = roleList})
    end
  end
end

BattleLoseTextDialog.OnRoleLevelUp = function(self, notification)
  -- function num : 0_12
  if self._selectGuideType and (self._selectGuideType).tag == "RoleLevelUp" then
    (self._rolesShowFrame):FireEvent("RefreshRoleLv")
  end
end

local RefreshStrengthenEquipRoleList = function(self)
  -- function num : 0_13 , upvalues : _ENV, Priority_EquipRatio, Priority, EquipTypeIndex, LineUpStation
  if self._recommendEquipLevel then
    local tag = false
    local recommend_priority = nil
    local list1 = {}
    local list2 = {}
    for station,roleId in pairs(self._teamRoles) do
      if roleId ~= 0 then
        local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId)
        local equips = {}
        local num = 0
        local minEquipLevel, selectEquipType = nil, nil
        local equipList = role:GetEquipKeyList()
        for type,key in pairs(equipList) do
          if key and key > 0 then
            local equip = ((NekoData.BehaviorManager).BM_BagInfo):GetEquipItem(key)
            do
              do
                if equip:GetStrengthenLevel() < self._recommendEquipLevel then
                  local temp = self._recommendEquipLevel - equip:GetStrengthenLevel() * Priority_EquipRatio
                  if Priority < temp and (not recommend_priority or recommend_priority < temp) then
                    recommend_priority = temp
                  end
                  tag = true
                  num = num + 1
                  if not minEquipLevel or equip:GetStrengthenLevel() < minEquipLevel then
                    minEquipLevel = equip:GetStrengthenLevel()
                  end
                  if equip:GetStrengthenLevel() <= minEquipLevel and (not selectEquipType or EquipTypeIndex[type] < EquipTypeIndex[selectEquipType]) then
                    selectEquipType = type
                  end
                end
                equips[type] = equip
                -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out DO_STMT

                -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_THEN_STMT

                -- DECOMPILER ERROR at PC80: LeaveBlock: unexpected jumping out IF_STMT

              end
            end
          end
        end
        if num > 0 then
          if self._isShattered then
            (table.insert)(list1, {role = role, equips = equips, minEquipLevel = minEquipLevel, selectEquipType = selectEquipType})
          else
            if station < LineUpStation.ALTERNATE_FRONT_ROW then
              (table.insert)(list1, {role = role, equips = equips, minEquipLevel = minEquipLevel, selectEquipType = selectEquipType})
            else
              ;
              (table.insert)(list2, {role = role, equips = equips, minEquipLevel = minEquipLevel, selectEquipType = selectEquipType})
            end
          end
        end
      end
    end
    if tag then
      (table.sort)(list1, function(a, b)
    -- function num : 0_13_0
    local a_minEquipLevel, b_minEquipLevel = a.minEquipLevel, b.minEquipLevel
    if a_minEquipLevel == b_minEquipLevel then
      local a_rarity, b_rarity = (a.role):GetRarityId(), (b.role):GetRarityId()
      if a_rarity == b_rarity then
        local a_id, b_id = (a.role):GetId(), (b.role):GetId()
        return a_id < b_id
      else
        return b_rarity < a_rarity
      end
    else
      return a_minEquipLevel < b_minEquipLevel
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
)
      ;
      (table.sort)(list2, function(a, b)
    -- function num : 0_13_1
    local a_minEquipLevel, b_minEquipLevel = a.minEquipLevel, b.minEquipLevel
    if a_minEquipLevel == b_minEquipLevel then
      local a_rarity, b_rarity = (a.role):GetRarityId(), (b.role):GetRarityId()
      if a_rarity == b_rarity then
        local a_id, b_id = (a.role):GetId(), (b.role):GetId()
        return a_id < b_id
      else
        return b_rarity < a_rarity
      end
    else
      return a_minEquipLevel < b_minEquipLevel
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
)
      local roleList = {}
      for i,v in ipairs(list1) do
        (table.insert)(roleList, v)
      end
      for i,v in ipairs(list2) do
        (table.insert)(roleList, v)
      end
      ;
      (table.insert)(self._guideStrengthenList, {tag = "RoleStrengthenEquip", recommend_priority = recommend_priority, recommendEquipLevel = self._recommendEquipLevel, roleList = roleList})
    end
  end
end

BattleLoseTextDialog.OnEquipLevelUp = function(self, notification)
  -- function num : 0_14
  if self._selectGuideType and (self._selectGuideType).tag == "RoleStrengthenEquip" then
    (self._rolesShowFrame):FireEvent("RefreshEquip")
  end
end

local RefreshImproveSkillRoleList = function(self)
  -- function num : 0_15 , upvalues : _ENV, Skill, Priority_SkillRatio, Priority, LineUpStation
  if self._recommendSkillLevel then
    local tag = false
    local recommend_priority = nil
    local list1 = {}
    local list2 = {}
    for station,roleId in pairs(self._teamRoles) do
      if roleId ~= 0 then
        local role = (((NekoData.BehaviorManager).BM_AllRoles):GetRole(roleId))
        local skillLevelSum = nil
        local showSkills = {}
        local skill1Info = role:GetShowSkillDataByIndex(1)
        local skill = (Skill.Create)(skill1Info.skillId, skill1Info.skillItemId or true)
        if not skill1Info.unlock or skill:GetSkillLevel() < self._recommendSkillLevel then
          if not skill1Info.unlock then
            local temp = (self._recommendSkillLevel - 0) * Priority_SkillRatio
            if Priority < temp and (not recommend_priority or recommend_priority < temp) then
              recommend_priority = temp
            end
          else
            do
              do
                local temp = (self._recommendSkillLevel - skill:GetSkillLevel()) * Priority_SkillRatio
                if Priority < temp and (not recommend_priority or recommend_priority < temp) then
                  recommend_priority = temp
                end
                skillLevelSum = 0
                if skill1Info.unlock then
                  skillLevelSum = skillLevelSum + skill:GetSkillLevel()
                end
                showSkills[1] = true
                local skill2Info = role:GetShowSkillDataByIndex(2)
                skill = (Skill.Create)(skill2Info.skillId, skill2Info.skillItemId or true)
                if not skill2Info.unlock or skill:GetSkillLevel() < self._recommendSkillLevel then
                  if not skill2Info.unlock then
                    local temp = (self._recommendSkillLevel - 0) * Priority_SkillRatio
                    if Priority < temp and (not recommend_priority or recommend_priority < temp) then
                      recommend_priority = temp
                    end
                  else
                    do
                      do
                        do
                          local temp = (self._recommendSkillLevel - skill:GetSkillLevel()) * Priority_SkillRatio
                          if Priority < temp and (not recommend_priority or recommend_priority < temp) then
                            recommend_priority = temp
                          end
                          if not skillLevelSum then
                            skillLevelSum = 0
                          end
                          if skill2Info.unlock then
                            skillLevelSum = skillLevelSum + skill:GetSkillLevel()
                          end
                          showSkills[2] = true
                          if skillLevelSum then
                            tag = true
                            if self._isShattered then
                              (table.insert)(list1, {role = role, showSkills = showSkills, skillLevelSum = skillLevelSum})
                            else
                              if station < LineUpStation.ALTERNATE_FRONT_ROW then
                                (table.insert)(list1, {role = role, showSkills = showSkills, skillLevelSum = skillLevelSum})
                              else
                                ;
                                (table.insert)(list2, {role = role, showSkills = showSkills, skillLevelSum = skillLevelSum})
                              end
                            end
                          end
                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out IF_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out IF_THEN_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out IF_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out DO_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out IF_ELSE_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out IF_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out IF_THEN_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out IF_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out IF_THEN_STMT

                          -- DECOMPILER ERROR at PC171: LeaveBlock: unexpected jumping out IF_STMT

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
    if tag then
      (table.sort)(list1, function(a, b)
    -- function num : 0_15_0
    local a_skillLevelSum, b_skillLevelSum = a.skillLevelSum, b.skillLevelSum
    if a_skillLevelSum == b_skillLevelSum then
      local a_rarity, b_rarity = (a.role):GetRarityId(), (b.role):GetRarityId()
      if a_rarity == b_rarity then
        local a_id, b_id = (a.role):GetId(), (b.role):GetId()
        return a_id < b_id
      else
        return b_rarity < a_rarity
      end
    else
      return a_skillLevelSum < b_skillLevelSum
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
)
      ;
      (table.sort)(list2, function(a, b)
    -- function num : 0_15_1
    local a_skillLevelSum, b_skillLevelSum = a.skillLevelSum, b.skillLevelSum
    if a_skillLevelSum == b_skillLevelSum then
      local a_rarity, b_rarity = (a.role):GetRarityId(), (b.role):GetRarityId()
      if a_rarity == b_rarity then
        local a_id, b_id = (a.role):GetId(), (b.role):GetId()
        return a_id < b_id
      else
        return b_rarity < a_rarity
      end
    else
      return a_skillLevelSum < b_skillLevelSum
    end
    -- DECOMPILER ERROR: 6 unprocessed JMP targets
  end
)
      local roleList = {}
      for i,v in ipairs(list1) do
        (table.insert)(roleList, v)
      end
      for i,v in ipairs(list2) do
        (table.insert)(roleList, v)
      end
      ;
      (table.insert)(self._guideStrengthenList, {tag = "ImproveSkill", recommend_priority = recommend_priority, recommendSkillLevel = self._recommendSkillLevel, roleList = roleList})
    end
  end
end

BattleLoseTextDialog.OnSkillImprove = function(self, notification)
  -- function num : 0_16
  if self._selectGuideType and (self._selectGuideType).tag == "ImproveSkill" then
    (self._rolesShowFrame):FireEvent("RefreshSkill")
  end
end

local GetMainLineIdBySceneId = function(sceneId)
  -- function num : 0_17 , upvalues : _ENV, MainLineTable
  local mainLineId, lastMainLineSceneId = nil, nil
  local worldID = tonumber((string.sub)(sceneId, 2, 2))
  local allIds = MainLineTable:GetAllIds()
  for _,id in ipairs(allIds) do
    local mainLineRecord = MainLineTable:GetRecorder(id)
    if tonumber((string.sub)(mainLineRecord.sceneid, 2, 2)) == worldID then
      if sceneId < mainLineRecord.sceneid and lastMainLineSceneId then
        mainLineId = id - 1
        break
      else
        if sceneId == mainLineRecord.sceneid then
          mainLineId = id
          break
        end
      end
      lastMainLineSceneId = mainLineRecord.sceneid
    end
  end
  do
    return mainLineId
  end
end

BattleLoseTextDialog.ShowGuidePanel = function(self)
  -- function num : 0_18 , upvalues : _ENV, CBattleStartProtocol, GetMainLineIdBySceneId, MainLineTable, ResourceStageTable, CStarrymirrorlevel, CHEXAGONFUNCTION, CHEXAGONBATTLECONFIG, CSRFunction, CSRResourceDungeonStage, CInterfaceFunction, CValentineInterfaceFunction, CFragmentLevelCfg, CAnniversarylevel, RefreshLevelUpRoleList, RefreshStrengthenEquipRoleList, RefreshImproveSkillRoleList, PlayMoveUpAnimation
  local unlock = ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).BattleLoseGuide)
  if unlock then
    local battleType = ((NekoData.BehaviorManager).BM_SBattleStart):GetBattleType()
    local currentTeamId = ((NekoData.BehaviorManager).BM_SBattleStart):GetLineId()
    self._teamRoles = ((NekoData.BehaviorManager).BM_Team):GetTeamRoles(currentTeamId)
    local recommendRoleLevel, recommendEquipLevel, recommendSkillLevel = nil, nil, nil
    if battleType == CBattleStartProtocol.DUNGEON then
      local mainLineId = GetMainLineIdBySceneId(((NekoData.BehaviorManager).BM_SEnterDungeon):GetId())
      local record = MainLineTable:GetRecorder(mainLineId)
      if record then
        recommendRoleLevel = record.magic
        recommendEquipLevel = record.minEquipLevel
        recommendSkillLevel = record.minSkillLevel
      else
        LogErrorFormat("BattleLoseTextDialog", "dungeonId：%s error.", mainLineId)
      end
    else
      do
        if battleType == CBattleStartProtocol.RESOURCE then
          local id = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).id
          local stageRecord = ResourceStageTable:GetRecorder(id)
          if stageRecord then
            recommendRoleLevel = stageRecord.levelShow
            recommendEquipLevel = stageRecord.minEquipLevel
            recommendSkillLevel = stageRecord.minSkillLevel
          else
            LogErrorFormat("BattleLoseTextDialog", "resourceId：%s error.", id)
          end
        else
          do
            if battleType == CBattleStartProtocol.STARRY or battleType == CBattleStartProtocol.STARRY_MIRROR then
              local id = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).id
              local stageRecord = CStarrymirrorlevel:GetRecorder(id)
              if stageRecord then
                recommendRoleLevel = stageRecord.suggestlevel
              else
                LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
              end
            else
              do
                if battleType == CBattleStartProtocol.SUMMER then
                  local id = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).id
                  local bettleID = (CHEXAGONFUNCTION:GetRecorder(id)).battleID
                  local stageRecord = CHEXAGONBATTLECONFIG:GetRecorder(bettleID)
                  if stageRecord then
                    recommendRoleLevel = stageRecord.suggestlevel
                  else
                    LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
                  end
                else
                  do
                    if battleType == CBattleStartProtocol.SUMMER_ECHO then
                      local id = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).id
                      local levelID = (CSRFunction:GetRecorder(id)).levelID
                      if levelID > 0 then
                        local levelRecorder = CSRResourceDungeonStage:GetRecorder(levelID)
                        if levelRecorder then
                          recommendRoleLevel = levelRecorder.levelShow
                        else
                          LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
                        end
                      else
                        do
                          do
                            LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
                            if battleType == CBattleStartProtocol.CHRISTMAS then
                              local id = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).id
                              local bettleID = (CInterfaceFunction:GetRecorder(id)).battleID
                              local stageRecord = CHEXAGONBATTLECONFIG:GetRecorder(bettleID)
                              if stageRecord then
                                recommendRoleLevel = stageRecord.suggestlevel
                              else
                                LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
                              end
                            else
                              do
                                if battleType == CBattleStartProtocol.LOVER then
                                  local id = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).id
                                  local bettleID = (CValentineInterfaceFunction:GetRecorder(id)).battleID
                                  local stageRecord = CHEXAGONBATTLECONFIG:GetRecorder(bettleID)
                                  if stageRecord then
                                    recommendRoleLevel = stageRecord.suggestlevel
                                  else
                                    LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
                                  end
                                else
                                  do
                                    if battleType ~= CBattleStartProtocol.SHATTERED then
                                      do
                                        self._isShattered = battleType ~= CBattleStartProtocol.SHATTERED
                                        local battleId = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).battleid
                                        local allIds = CFragmentLevelCfg:GetAllIds()
                                        for _,id in ipairs(allIds) do
                                          local record = CFragmentLevelCfg:GetRecorder(id)
                                          if record.battleID == battleId then
                                            recommendRoleLevel = record.recommendLv
                                            recommendEquipLevel = record.minEquipLevel
                                            recommendSkillLevel = record.minSkillLevel
                                            break
                                          end
                                        end
                                        local left = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).left
                                        for k,v in pairs(left) do
                                          (table.insert)(self._teamRoles, v.id)
                                        end
                                        if battleType == CBattleStartProtocol.ANNIVERSARY then
                                          local id = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).id
                                          local stageRecord = CAnniversarylevel:GetRecorder(id)
                                          if stageRecord then
                                            recommendRoleLevel = stageRecord.suggestlevel
                                          else
                                            LogErrorFormat("BattleLoseTextDialog", "levelId：%s error.", id)
                                          end
                                        end
                                        if recommendRoleLevel then
                                          self._recommendRoleLevel = recommendRoleLevel
                                          RefreshLevelUpRoleList(self)
                                        end
                                        if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Equip_Unlock) and recommendEquipLevel then
                                          self._recommendEquipLevel = recommendEquipLevel
                                          RefreshStrengthenEquipRoleList(self)
                                        end
                                        if ((NekoData.BehaviorManager).BM_Game):IsUnlockFunction((DataCommon.Functions).Role_SkillLevelUp) and recommendSkillLevel then
                                          self._recommendSkillLevel = recommendSkillLevel
                                          RefreshImproveSkillRoleList(self)
                                        end
                                        if #self._guideStrengthenList > 0 then
                                          (self._guidePanel):SetActive(true)
                                          ;
                                          (self:GetRootWindow()):PlayAnimation("BattleLoseDefeatGuide")
                                          self._recommendTag = nil
                                          local priority = nil
                                          for i,v in ipairs(self._guideStrengthenList) do
                                            if v.recommend_priority and (not priority or priority < v.recommend_priority) then
                                              priority = v.recommend_priority
                                              self._recommendTag = v.tag
                                            end
                                          end
                                          ;
                                          (self._guidePanel_cellFrame):ReloadAllCell()
                                          local cellPanelHeight = (self._guidePanel_cellFrame):GetTotalLength()
                                          ;
                                          (self._guidePanel_cellPanel):SetSize(0, cellPanelHeight, 0, self._guidePanel_cellPanel_height)
                                          ;
                                          (self._guidePanel_cellPanel):SetAnchoredPosition(self._guidePanel_cellPanel_anchoredx, self._guidePanel_cellPanel_anchoredy)
                                        else
                                          (self._guidePanel):SetActive(false)
                                          ;
                                          (self._rolesShowPanel):SetActive(false)
                                          self._showGuidePanelFinished = true
                                          PlayMoveUpAnimation(self)
                                        end
                                        ;
                                        (self._guidePanel):SetActive(false)
                                        ;
                                        (self._rolesShowPanel):SetActive(false)
                                        self._showGuidePanelFinished = true
                                        PlayMoveUpAnimation(self)
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

BattleLoseTextDialog.SetSelect = function(self, data)
  -- function num : 0_19 , upvalues : TableFrame
  if not self._selectGuideType or data.tag ~= (self._selectGuideType).tag then
    (self._rolesShowPanel):SetActive(true)
    ;
    (self._spiritGive):SetActive(false)
    self._selectGuideType = data
    ;
    (self._rolesShowFrame):Destroy()
    self._rolesShowFrame = (TableFrame.Create)(self._rolesShowPanel, self, true, true, true)
    ;
    (self._rolesShowFrame):ReloadAllCell()
    ;
    (self._rolesShowFrame):MoveToTop()
    ;
    (self._guidePanel_cellFrame):FireEvent()
  end
end

BattleLoseTextDialog.NumberOfCell = function(self, frame, index)
  -- function num : 0_20
  if frame == self._guidePanel_cellFrame then
    return #self._guideStrengthenList
  else
    return #(self._selectGuideType).roleList
  end
end

BattleLoseTextDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_21
  if frame == self._guidePanel_cellFrame then
    return "battle.battleaccount.guidestrengthentypecell"
  else
    if (self._selectGuideType).tag == "RoleLevelUp" then
      return "battle.battleaccount.guiderolelevelupcell"
    else
      if (self._selectGuideType).tag == "RoleStrengthenEquip" then
        return "battle.battleaccount.guiderolestrengthenequipcell"
      else
        if (self._selectGuideType).tag == "ImproveSkill" then
          return "battle.battleaccount.guideroleimproveskillcell"
        end
      end
    end
  end
end

BattleLoseTextDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_22
  if frame == self._guidePanel_cellFrame then
    return (self._guideStrengthenList)[index]
  else
    return ((self._selectGuideType).roleList)[index]
  end
end

return BattleLoseTextDialog

