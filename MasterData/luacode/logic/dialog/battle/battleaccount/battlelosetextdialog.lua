local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local LineUpStation = LuaNetManager.GetBeanDef("protocol.login.lineupstation")
local Item = require("logic.manager.experimental.types.item")
local Skill = require("logic.manager.experimental.types.skill")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local EquipTypeEnum = LuaNetManager.GetBeanDef("protocol.item.equiptype")
local MainLineTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local ResourceStageTable = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstage")
local CStarrymirrorlevel = BeanManager.GetTableByName("dungeonselect.cstarrymirrorlevel")
local CHEXAGONBATTLECONFIG = BeanManager.GetTableByName("dungeonselect.chexagonbattleconfig")
local CHEXAGONFUNCTION = BeanManager.GetTableByName("activity.chexagonfunction")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local CValentineInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cvalentineinterfacefunction")
local CFragmentLevelCfg = BeanManager.GetTableByName("dungeonselect.cfragmentlevelcfg")
local CBattleConfig = BeanManager.GetTableByName("battle.cbattleconstcfg")
local CAnniversarylevel = BeanManager.GetTableByName("dungeonselect.canniversarylevel")
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
local CSRResourceDungeonStage = BeanManager.GetTableByName("activity.csrresourcedungeonstage")
local TableFrame = require("framework.ui.frame.table.tableframe")
local EquipTypeIndex = {
  [EquipTypeEnum.WEAPON] = 1,
  [EquipTypeEnum.ARMOR] = 2,
  [EquipTypeEnum.JEWELRY] = 3
}
local Priority = 10
local Priority_EquipRatio = tonumber(CBattleConfig:GetRecorder(117).attr)
local Priority_SkillRatio = tonumber(CBattleConfig:GetRecorder(116).attr)
local BattleLoseTextDialog = class("BattleLoseTextDialog", Dialog)
BattleLoseTextDialog.AssetBundleName = "ui/layouts.battlelose"
BattleLoseTextDialog.AssetName = "BattleLoseTxt"

function BattleLoseTextDialog:Ctor(...)
  BattleLoseTextDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._guideStrengthenList = {}
  self._selectGuideType = nil
  self._playMoveUpAnimation = false
  self._playMoveUpAnimationTag = false
  self._showGuidePanelFinished = false
end

function BattleLoseTextDialog:OnCreate()
  self._spiritGive = self:GetChild("SpiritGive")
  self._text = self:GetChild("SpiritGive/Txt")
  self._itemCell = self:GetChild("SpiritGive/ItemCell")
  self._itemIcon = self:GetChild("SpiritGive/ItemCell/_BackGround/Icon")
  self._itemFrame = self:GetChild("SpiritGive/ItemCell/_BackGround/Frame")
  self._itemCount = self:GetChild("SpiritGive/ItemCell/_Count")
  self._guidePanel = self:GetChild("DefeatGuide")
  self._guidePanel_cellPanel = self:GetChild("DefeatGuide/Frame")
  self._guidePanel_cellPanel_width, self._guidePanel_cellPanel_height = self._guidePanel_cellPanel:GetRectSize()
  self._guidePanel_cellPanel_anchoredx, self._guidePanel_cellPanel_anchoredy = self._guidePanel_cellPanel:GetAnchoredPosition()
  self._guidePanel_cellFrame = TableFrame.Create(self._guidePanel_cellPanel, self, false, false)
  self._rolesShowPanel = self:GetChild("DefeatGuideFrame")
  self._rolesShowFrame = TableFrame.Create(self._rolesShowPanel, self, true, true, true)
  self._itemCell:Subscribe_PointerClickEvent(self.OnItemCellClicked, self)
  self:GetRootWindow():Subscribe_StateExitEvent(self.OnBattleLoseOver, self)
  self:GetRootWindow():Subscribe_PointerClickEvent(self.OnWindowClicked, self)
  self:PlayDefeatVoice()
  self:InitSpiritData()
  self:ShowGuidePanel()
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritData, Common.n_OnSEnterMainCity, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshSpiritData, Common.n_OnSShowObtainPanel, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRoleLevelUp, Common.n_LevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEquipLevelUp, Common.n_EquipLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnSkillImprove, Common.n_ImproveSkill, nil)
end

function BattleLoseTextDialog:OnDestroy()
  self._guidePanel_cellFrame:Destroy()
  self._rolesShowFrame:Destroy()
end

function BattleLoseTextDialog:PlayDefeatVoice()
  local currentTeamId = NekoData.BehaviorManager.BM_SBattleStart:GetLineId()
  local roleInfo = NekoData.BehaviorManager.BM_Team:GetTeamRoles(currentTeamId)
  local roleList = {}
  local i
  for _, key in ipairs(roleInfo) do
    if key ~= 0 then
      table.insert(roleList, NekoData.BehaviorManager.BM_AllRoles:GetRole(key))
    end
  end
  if #roleList == 0 then
    table.insert(roleList, NekoData.BehaviorManager.BM_AllRoles:GetRole(1))
  end
  i = math.random(1, #roleList)
  NekoData.BehaviorManager.BM_Voice:Play(roleList[i]:GetId(), NekoData.BehaviorManager.BM_Voice.VoiceType.Defeat, nil)
end

function BattleLoseTextDialog:OnBattleLoseOver(arg1, arg2)
  if arg2 == "BattleLoseTxt" then
    self:Destroy()
  end
end

function BattleLoseTextDialog:OnWindowClicked()
  self:Destroy()
end

function BattleLoseTextDialog:InitSpiritData()
  if GlobalGameFSM then
    if GlobalGameFSM:GetCurrentState() == "MainCityBattle" or GlobalGameFSM:GetCurrentState() == "SwimSuitActivityBattle" then
      self:SetSpiritGiveData(NekoData.BehaviorManager.BM_Game:GetResourceObtainMoney())
    elseif GlobalGameFSM:GetCurrentState() == "DungeonBattle" then
      self:SetSpiritGiveData(NekoData.BehaviorManager.BM_Game:GetDungeonObtainMoney())
    elseif GlobalGameFSM:GetCurrentState() == "TowerV2Battle" then
      self._spiritGive:SetActive(false)
    end
  end
end

function BattleLoseTextDialog:RefreshSpiritData(notification)
  if GlobalGameFSM then
    if GlobalGameFSM:GetCurrentState() == "MainCityBattle" then
      if notification.name == Common.n_OnSShowObtainPanel then
        self:SetSpiritGiveData(notification.userInfo.awardCurrency)
      end
    elseif GlobalGameFSM:GetCurrentState() == "DungeonBattle" and notification.name == Common.n_OnSEnterMainCity then
      self:SetSpiritGiveData(notification.userInfo.money)
    end
  end
end

local function PlayMoveUpAnimation(self)
  if not self._playMoveUpAnimationTag and self._showGuidePanelFinished and self._playMoveUpAnimation then
    self._playMoveUpAnimationTag = true
    self:GetRootWindow():PlayAnimation("BattleLoseStarBoss")
  end
end

function BattleLoseTextDialog:SetSpiritGiveData(moneyInfo)
  if moneyInfo and next(moneyInfo) ~= nil and moneyInfo[35003] ~= nil and moneyInfo[35003] > 0 then
    self._spiritGive:SetActive(true)
    self._itemId = 35003
    self._itemNum = moneyInfo[35003]
    self._item = Item.Create(self._itemId)
    self._itemCount:SetText(NumberManager.GetShowNumber(self._itemNum))
    self._itemIcon:SetSprite(self._item:GetIcon().assetBundle, self._item:GetIcon().assetName)
    self._itemFrame:SetSprite(self._item:GetPinJiImage().assetBundle, self._item:GetPinJiImage().assetName)
    self._text:SetText(string.gsub(TextManager.GetText(CStringRes:GetRecorder(1440).msgTextID), "%$parameter1%$", self._itemNum))
    self._playMoveUpAnimation = true
    PlayMoveUpAnimation(self)
  else
    self._spiritGive:SetActive(false)
    self._playMoveUpAnimation = false
    PlayMoveUpAnimation(self)
  end
end

function BattleLoseTextDialog:OnItemCellClicked()
  local dialog = DialogManager.CreateSingletonDialog("bag.itemtipsdialog")
  if dialog then
    dialog:Init({
      item = self._item
    })
  end
end

local function RefreshLevelUpRoleList(self)
  if self._recommendRoleLevel then
    local tag = false
    local recommend_priority
    local list1 = {}
    local list2 = {}
    for station, roleId in pairs(self._teamRoles) do
      if roleId ~= 0 then
        local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
        if role:GetLevel() < self._recommendRoleLevel then
          local temp = self._recommendRoleLevel - role:GetLevel()
          if temp > Priority and (not recommend_priority or recommend_priority < temp) then
            recommend_priority = temp
          end
          tag = true
          if self._isShattered then
            table.insert(list1, role)
          elseif station < LineUpStation.ALTERNATE_FRONT_ROW then
            table.insert(list1, role)
          else
            table.insert(list2, role)
          end
        end
      end
    end
    if tag then
      table.sort(list1, function(a, b)
        local a_lv, b_lv = a:GetLevel(), b:GetLevel()
        if a_lv == b_lv then
          local a_rarity, b_rarity = a:GetRarityId(), b:GetRarityId()
          if a_rarity == b_rarity then
            local a_id, b_id = a:GetId(), b:GetId()
            return a_id < b_id
          else
            return a_rarity > b_rarity
          end
        else
          return a_lv < b_lv
        end
      end)
      table.sort(list2, function(a, b)
        local a_lv, b_lv = a:GetLevel(), b:GetLevel()
        if a_lv == b_lv then
          local a_rarity, b_rarity = a:GetRarityId(), b:GetRarityId()
          if a_rarity == b_rarity then
            local a_id, b_id = a:GetId(), b:GetId()
            return a_id < b_id
          else
            return a_rarity > b_rarity
          end
        else
          return a_lv < b_lv
        end
      end)
      local roleList = {}
      for i, v in ipairs(list1) do
        table.insert(roleList, v)
      end
      for i, v in ipairs(list2) do
        table.insert(roleList, v)
      end
      table.insert(self._guideStrengthenList, {
        tag = "RoleLevelUp",
        recommend_priority = recommend_priority,
        recommendRoleLevel = self._recommendRoleLevel,
        roleList = roleList
      })
    end
  end
end

function BattleLoseTextDialog:OnRoleLevelUp(notification)
  if self._selectGuideType and self._selectGuideType.tag == "RoleLevelUp" then
    self._rolesShowFrame:FireEvent("RefreshRoleLv")
  end
end

local function RefreshStrengthenEquipRoleList(self)
  if self._recommendEquipLevel then
    local tag = false
    local recommend_priority
    local list1 = {}
    local list2 = {}
    for station, roleId in pairs(self._teamRoles) do
      if roleId ~= 0 then
        local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
        local equips = {}
        local num = 0
        local minEquipLevel, selectEquipType
        local equipList = role:GetEquipKeyList()
        for type, key in pairs(equipList) do
          if key and 0 < key then
            local equip = NekoData.BehaviorManager.BM_BagInfo:GetEquipItem(key)
            if equip:GetStrengthenLevel() < self._recommendEquipLevel then
              local temp = self._recommendEquipLevel - equip:GetStrengthenLevel() * Priority_EquipRatio
              if temp > Priority and (not recommend_priority or recommend_priority < temp) then
                recommend_priority = temp
              end
              tag = true
              num = num + 1
              if not minEquipLevel or minEquipLevel > equip:GetStrengthenLevel() then
                minEquipLevel = equip:GetStrengthenLevel()
              end
              if minEquipLevel >= equip:GetStrengthenLevel() and (not selectEquipType or EquipTypeIndex[type] < EquipTypeIndex[selectEquipType]) then
                selectEquipType = type
              end
            end
            equips[type] = equip
          end
        end
        if 0 < num then
          if self._isShattered then
            table.insert(list1, {
              role = role,
              equips = equips,
              minEquipLevel = minEquipLevel,
              selectEquipType = selectEquipType
            })
          elseif station < LineUpStation.ALTERNATE_FRONT_ROW then
            table.insert(list1, {
              role = role,
              equips = equips,
              minEquipLevel = minEquipLevel,
              selectEquipType = selectEquipType
            })
          else
            table.insert(list2, {
              role = role,
              equips = equips,
              minEquipLevel = minEquipLevel,
              selectEquipType = selectEquipType
            })
          end
        end
      end
    end
    if tag then
      table.sort(list1, function(a, b)
        local a_minEquipLevel, b_minEquipLevel = a.minEquipLevel, b.minEquipLevel
        if a_minEquipLevel == b_minEquipLevel then
          local a_rarity, b_rarity = a.role:GetRarityId(), b.role:GetRarityId()
          if a_rarity == b_rarity then
            local a_id, b_id = a.role:GetId(), b.role:GetId()
            return a_id < b_id
          else
            return a_rarity > b_rarity
          end
        else
          return a_minEquipLevel < b_minEquipLevel
        end
      end)
      table.sort(list2, function(a, b)
        local a_minEquipLevel, b_minEquipLevel = a.minEquipLevel, b.minEquipLevel
        if a_minEquipLevel == b_minEquipLevel then
          local a_rarity, b_rarity = a.role:GetRarityId(), b.role:GetRarityId()
          if a_rarity == b_rarity then
            local a_id, b_id = a.role:GetId(), b.role:GetId()
            return a_id < b_id
          else
            return a_rarity > b_rarity
          end
        else
          return a_minEquipLevel < b_minEquipLevel
        end
      end)
      local roleList = {}
      for i, v in ipairs(list1) do
        table.insert(roleList, v)
      end
      for i, v in ipairs(list2) do
        table.insert(roleList, v)
      end
      table.insert(self._guideStrengthenList, {
        tag = "RoleStrengthenEquip",
        recommend_priority = recommend_priority,
        recommendEquipLevel = self._recommendEquipLevel,
        roleList = roleList
      })
    end
  end
end

function BattleLoseTextDialog:OnEquipLevelUp(notification)
  if self._selectGuideType and self._selectGuideType.tag == "RoleStrengthenEquip" then
    self._rolesShowFrame:FireEvent("RefreshEquip")
  end
end

local function RefreshImproveSkillRoleList(self)
  if self._recommendSkillLevel then
    local tag = false
    local recommend_priority
    local list1 = {}
    local list2 = {}
    for station, roleId in pairs(self._teamRoles) do
      if roleId ~= 0 then
        local role = NekoData.BehaviorManager.BM_AllRoles:GetRole(roleId)
        local skillLevelSum
        local showSkills = {}
        local skill1Info = role:GetShowSkillDataByIndex(1)
        local skill = Skill.Create(skill1Info.skillId, skill1Info.skillItemId or true)
        if not skill1Info.unlock or skill:GetSkillLevel() < self._recommendSkillLevel then
          if not skill1Info.unlock then
            local temp = (self._recommendSkillLevel - 0) * Priority_SkillRatio
            if temp > Priority and (not recommend_priority or recommend_priority < temp) then
              recommend_priority = temp
            end
          else
            local temp = (self._recommendSkillLevel - skill:GetSkillLevel()) * Priority_SkillRatio
            if temp > Priority and (not recommend_priority or recommend_priority < temp) then
              recommend_priority = temp
            end
          end
          skillLevelSum = 0
          if skill1Info.unlock then
            skillLevelSum = skillLevelSum + skill:GetSkillLevel()
          end
          showSkills[1] = true
        end
        local skill2Info = role:GetShowSkillDataByIndex(2)
        skill = Skill.Create(skill2Info.skillId, skill2Info.skillItemId or true)
        if not skill2Info.unlock or skill:GetSkillLevel() < self._recommendSkillLevel then
          if not skill2Info.unlock then
            local temp = (self._recommendSkillLevel - 0) * Priority_SkillRatio
            if temp > Priority and (not recommend_priority or recommend_priority < temp) then
              recommend_priority = temp
            end
          else
            local temp = (self._recommendSkillLevel - skill:GetSkillLevel()) * Priority_SkillRatio
            if temp > Priority and (not recommend_priority or recommend_priority < temp) then
              recommend_priority = temp
            end
          end
          skillLevelSum = skillLevelSum or 0
          if skill2Info.unlock then
            skillLevelSum = skillLevelSum + skill:GetSkillLevel()
          end
          showSkills[2] = true
        end
        if skillLevelSum then
          tag = true
          if self._isShattered then
            table.insert(list1, {
              role = role,
              showSkills = showSkills,
              skillLevelSum = skillLevelSum
            })
          elseif station < LineUpStation.ALTERNATE_FRONT_ROW then
            table.insert(list1, {
              role = role,
              showSkills = showSkills,
              skillLevelSum = skillLevelSum
            })
          else
            table.insert(list2, {
              role = role,
              showSkills = showSkills,
              skillLevelSum = skillLevelSum
            })
          end
        end
      end
    end
    if tag then
      table.sort(list1, function(a, b)
        local a_skillLevelSum, b_skillLevelSum = a.skillLevelSum, b.skillLevelSum
        if a_skillLevelSum == b_skillLevelSum then
          local a_rarity, b_rarity = a.role:GetRarityId(), b.role:GetRarityId()
          if a_rarity == b_rarity then
            local a_id, b_id = a.role:GetId(), b.role:GetId()
            return a_id < b_id
          else
            return a_rarity > b_rarity
          end
        else
          return a_skillLevelSum < b_skillLevelSum
        end
      end)
      table.sort(list2, function(a, b)
        local a_skillLevelSum, b_skillLevelSum = a.skillLevelSum, b.skillLevelSum
        if a_skillLevelSum == b_skillLevelSum then
          local a_rarity, b_rarity = a.role:GetRarityId(), b.role:GetRarityId()
          if a_rarity == b_rarity then
            local a_id, b_id = a.role:GetId(), b.role:GetId()
            return a_id < b_id
          else
            return a_rarity > b_rarity
          end
        else
          return a_skillLevelSum < b_skillLevelSum
        end
      end)
      local roleList = {}
      for i, v in ipairs(list1) do
        table.insert(roleList, v)
      end
      for i, v in ipairs(list2) do
        table.insert(roleList, v)
      end
      table.insert(self._guideStrengthenList, {
        tag = "ImproveSkill",
        recommend_priority = recommend_priority,
        recommendSkillLevel = self._recommendSkillLevel,
        roleList = roleList
      })
    end
  end
end

function BattleLoseTextDialog:OnSkillImprove(notification)
  if self._selectGuideType and self._selectGuideType.tag == "ImproveSkill" then
    self._rolesShowFrame:FireEvent("RefreshSkill")
  end
end

local function GetMainLineIdBySceneId(sceneId)
  local mainLineId, lastMainLineSceneId
  local worldID = tonumber(string.sub(sceneId, 2, 2))
  local allIds = MainLineTable:GetAllIds()
  for _, id in ipairs(allIds) do
    local mainLineRecord = MainLineTable:GetRecorder(id)
    if tonumber(string.sub(mainLineRecord.sceneid, 2, 2)) == worldID then
      if sceneId < mainLineRecord.sceneid and lastMainLineSceneId then
        mainLineId = id - 1
        break
      elseif sceneId == mainLineRecord.sceneid then
        mainLineId = id
        break
      end
      lastMainLineSceneId = mainLineRecord.sceneid
    end
  end
  return mainLineId
end

function BattleLoseTextDialog:ShowGuidePanel()
  local unlock = NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.BattleLoseGuide)
  if unlock then
    local battleType = NekoData.BehaviorManager.BM_SBattleStart:GetBattleType()
    local currentTeamId = NekoData.BehaviorManager.BM_SBattleStart:GetLineId()
    self._teamRoles = NekoData.BehaviorManager.BM_Team:GetTeamRoles(currentTeamId)
    local recommendRoleLevel, recommendEquipLevel, recommendSkillLevel
    if battleType == CBattleStartProtocol.DUNGEON then
      local mainLineId = GetMainLineIdBySceneId(NekoData.BehaviorManager.BM_SEnterDungeon:GetId())
      local record = MainLineTable:GetRecorder(mainLineId)
      if record then
        recommendRoleLevel = record.magic
        recommendEquipLevel = record.minEquipLevel
        recommendSkillLevel = record.minSkillLevel
      else
        LogErrorFormat("BattleLoseTextDialog", "dungeonId：%s error.", mainLineId)
      end
    elseif battleType == CBattleStartProtocol.RESOURCE then
      local id = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().id
      local stageRecord = ResourceStageTable:GetRecorder(id)
      if stageRecord then
        recommendRoleLevel = stageRecord.levelShow
        recommendEquipLevel = stageRecord.minEquipLevel
        recommendSkillLevel = stageRecord.minSkillLevel
      else
        LogErrorFormat("BattleLoseTextDialog", "resourceId：%s error.", id)
      end
    elseif battleType == CBattleStartProtocol.STARRY or battleType == CBattleStartProtocol.STARRY_MIRROR then
      local id = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().id
      local stageRecord = CStarrymirrorlevel:GetRecorder(id)
      if stageRecord then
        recommendRoleLevel = stageRecord.suggestlevel
      else
        LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
      end
    elseif battleType == CBattleStartProtocol.SUMMER then
      local id = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().id
      local bettleID = CHEXAGONFUNCTION:GetRecorder(id).battleID
      local stageRecord = CHEXAGONBATTLECONFIG:GetRecorder(bettleID)
      if stageRecord then
        recommendRoleLevel = stageRecord.suggestlevel
      else
        LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
      end
    elseif battleType == CBattleStartProtocol.SUMMER_ECHO then
      local id = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().id
      local levelID = CSRFunction:GetRecorder(id).levelID
      if 0 < levelID then
        local levelRecorder = CSRResourceDungeonStage:GetRecorder(levelID)
        if levelRecorder then
          recommendRoleLevel = levelRecorder.levelShow
        else
          LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
        end
      else
        LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
      end
    elseif battleType == CBattleStartProtocol.CHRISTMAS then
      local id = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().id
      local bettleID = CInterfaceFunction:GetRecorder(id).battleID
      local stageRecord = CHEXAGONBATTLECONFIG:GetRecorder(bettleID)
      if stageRecord then
        recommendRoleLevel = stageRecord.suggestlevel
      else
        LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
      end
    elseif battleType == CBattleStartProtocol.LOVER then
      local id = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().id
      local bettleID = CValentineInterfaceFunction:GetRecorder(id).battleID
      local stageRecord = CHEXAGONBATTLECONFIG:GetRecorder(bettleID)
      if stageRecord then
        recommendRoleLevel = stageRecord.suggestlevel
      else
        LogErrorFormat("BattleLoseTextDialog", "activityId：%s error.", id)
      end
    elseif battleType == CBattleStartProtocol.SHATTERED then
      self._isShattered = battleType == CBattleStartProtocol.SHATTERED
      local battleId = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().battleid
      local allIds = CFragmentLevelCfg:GetAllIds()
      for _, id in ipairs(allIds) do
        local record = CFragmentLevelCfg:GetRecorder(id)
        if record.battleID == battleId then
          recommendRoleLevel = record.recommendLv
          recommendEquipLevel = record.minEquipLevel
          recommendSkillLevel = record.minSkillLevel
          break
        end
      end
      local left = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().left
      for k, v in pairs(left) do
        table.insert(self._teamRoles, v.id)
      end
    elseif battleType == CBattleStartProtocol.ANNIVERSARY then
      local id = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().id
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
    if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Equip_Unlock) and recommendEquipLevel then
      self._recommendEquipLevel = recommendEquipLevel
      RefreshStrengthenEquipRoleList(self)
    end
    if NekoData.BehaviorManager.BM_Game:IsUnlockFunction(DataCommon.Functions.Role_SkillLevelUp) and recommendSkillLevel then
      self._recommendSkillLevel = recommendSkillLevel
      RefreshImproveSkillRoleList(self)
    end
    if 0 < #self._guideStrengthenList then
      self._guidePanel:SetActive(true)
      self:GetRootWindow():PlayAnimation("BattleLoseDefeatGuide")
      self._recommendTag = nil
      local priority
      for i, v in ipairs(self._guideStrengthenList) do
        if v.recommend_priority and (not priority or priority < v.recommend_priority) then
          priority = v.recommend_priority
          self._recommendTag = v.tag
        end
      end
      self._guidePanel_cellFrame:ReloadAllCell()
      local cellPanelHeight = self._guidePanel_cellFrame:GetTotalLength()
      self._guidePanel_cellPanel:SetSize(0, cellPanelHeight, 0, self._guidePanel_cellPanel_height)
      self._guidePanel_cellPanel:SetAnchoredPosition(self._guidePanel_cellPanel_anchoredx, self._guidePanel_cellPanel_anchoredy)
    else
      self._guidePanel:SetActive(false)
      self._rolesShowPanel:SetActive(false)
      self._showGuidePanelFinished = true
      PlayMoveUpAnimation(self)
    end
  else
    self._guidePanel:SetActive(false)
    self._rolesShowPanel:SetActive(false)
    self._showGuidePanelFinished = true
    PlayMoveUpAnimation(self)
  end
end

function BattleLoseTextDialog:SetSelect(data)
  if not self._selectGuideType or data.tag ~= self._selectGuideType.tag then
    self._rolesShowPanel:SetActive(true)
    self._spiritGive:SetActive(false)
    self._selectGuideType = data
    self._rolesShowFrame:Destroy()
    self._rolesShowFrame = TableFrame.Create(self._rolesShowPanel, self, true, true, true)
    self._rolesShowFrame:ReloadAllCell()
    self._rolesShowFrame:MoveToTop()
    self._guidePanel_cellFrame:FireEvent()
  end
end

function BattleLoseTextDialog:NumberOfCell(frame, index)
  if frame == self._guidePanel_cellFrame then
    return #self._guideStrengthenList
  else
    return #self._selectGuideType.roleList
  end
end

function BattleLoseTextDialog:CellAtIndex(frame, index)
  if frame == self._guidePanel_cellFrame then
    return "battle.battleaccount.guidestrengthentypecell"
  elseif self._selectGuideType.tag == "RoleLevelUp" then
    return "battle.battleaccount.guiderolelevelupcell"
  elseif self._selectGuideType.tag == "RoleStrengthenEquip" then
    return "battle.battleaccount.guiderolestrengthenequipcell"
  elseif self._selectGuideType.tag == "ImproveSkill" then
    return "battle.battleaccount.guideroleimproveskillcell"
  end
end

function BattleLoseTextDialog:DataAtIndex(frame, index)
  if frame == self._guidePanel_cellFrame then
    return self._guideStrengthenList[index]
  else
    return self._selectGuideType.roleList[index]
  end
end

return BattleLoseTextDialog
