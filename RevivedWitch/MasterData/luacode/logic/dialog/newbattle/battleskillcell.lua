-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battleskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Role = require("logic.manager.experimental.types.role")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BattleSkillCell = class("BattleSkillCell", Dialog)
BattleSkillCell.AssetBundleName = "ui/layouts.battlenew"
BattleSkillCell.AssetName = "BattleCharSkillCell"
local OnNewBattleGuideEnd = function(self, notification)
  -- function num : 0_0
  local userInfo = notification.userInfo
  if userInfo == nil then
    return 
  end
  self._guideFinished = true
end

BattleSkillCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : BattleSkillCell
  ((BattleSkillCell.super).Ctor)(self, ...)
  self._tag = nil
  self._skillList = {}
end

BattleSkillCell.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, _ENV, OnNewBattleGuideEnd
  self._middle = self:GetChild("CharBack")
  self._middleIcon = self:GetChild("CharBack/Char")
  self._hpProgress = self:GetChild("CharBack/Blood")
  self._panelOne = self:GetChild("FrameOne")
  self._panelTwo = self:GetChild("FrameTwo")
  self._frameOne = (TableFrame.Create)(self._panelOne, self, false, false)
  self._frameTwo = (TableFrame.Create)(self._panelTwo, self, false, false)
  ;
  (self._middle):Subscribe_PointerClickEvent(self.OnLittleCharClicked, self)
  self._battleID = ((NekoData.BehaviorManager).BM_Battle):GetBattleId()
  self._guideFinished = false
  ;
  (LuaNotificationCenter.AddObserver)(self, OnNewBattleGuideEnd, Common.n_NewBattleGuideEnd, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnUpdate, Common.n_LateUpdate, nil)
end

BattleSkillCell.OnDestroy = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (self._frameOne):Destroy()
  ;
  (self._frameTwo):Destroy()
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

BattleSkillCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : _ENV
  self._skillList = {}
  local unlockSkillList = (self._cellData):GetSkillList()
  for _,skillId in ipairs(unlockSkillList) do
    (table.insert)(self._skillList, {skillId = skillId, lockState = false})
  end
  local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(data:GetConfigId())
  local showSkillData = role:GetShowSkillData()
  for _,v in ipairs(showSkillData) do
    -- DECOMPILER ERROR at PC45: Unhandled construct in 'MakeBoolean' P1

    if not v.unlock and #self._skillList < 2 then
      do
        (table.insert)(self._skillList, {skillId = v.skillId, lockState = true})
        -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC46: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  if self._battleID == 1120 then
    (self._panelOne):SetActive(true)
    ;
    (self._panelTwo):SetActive(false)
    ;
    (self._frameOne):ReloadAllCell()
    self._tag = "one"
  else
    ;
    (self._panelOne):SetActive(false)
    ;
    (self._panelTwo):SetActive(true)
    ;
    (self._frameTwo):ReloadAllCell()
    self._tag = "two"
  end
  if #(self._delegate)._entityList == 1 then
    (self._middle):SetActive(false)
  else
    ;
    (self._middle):SetActive(true)
    local role = ((NekoData.BehaviorManager).BM_AllRoles):GetRoleById(data:GetConfigId())
    local record = role:GetSkillHeadImageRecord()
    if record then
      (self._middleIcon):SetSprite(record.assetBundle, record.assetName)
    end
  end
end

BattleSkillCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  return #self._skillList
end

BattleSkillCell.CellAtIndex = function(self, frame, index)
  -- function num : 0_6
  if ((self._skillList)[index]).lockState then
    return "newbattle.battlelockskillsmallcell"
  else
    return "newbattle.battleskillsmallcell"
  end
end

BattleSkillCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  return ((self._skillList)[index]).skillId
end

BattleSkillCell.OnControlOtherSkill = function(self, entityId, releaseSkill)
  -- function num : 0_8
  if self._tag and self._tag == "two" then
    local data = {entityId = entityId, releaseSkill = releaseSkill}
    ;
    (self._frameTwo):FireEvent("NoClickSkill", data)
  end
end

BattleSkillCell.OnLittleCharClicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if (self._delegate)._pause then
    ((DialogManager.CreateSingletonDialog)("newbattle.battleroleskillsdetaildialog")):SetData(self._cellData)
  end
end

BattleSkillCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_10
  if eventName == "ShowSkillCardBack" and arg and arg == (self._cellData):GetEntityId() then
    if self._tag and self._tag == "one" then
      (self._frameOne):FireEvent("ShowSkillCardBack", (self._cellData):GetEntityId())
    end
    if self._tag and self._tag == "two" then
      (self._frameTwo):FireEvent("ShowSkillCardBack", (self._cellData):GetEntityId())
    end
  end
  if eventName == "ShowSkillCardFrame" and arg and arg == (self._cellData):GetEntityId() then
    if self._tag and self._tag == "one" then
      (self._frameOne):FireEvent("ShowSkillCardFrame", (self._cellData):GetEntityId())
    end
    if self._tag and self._tag == "two" then
      (self._frameTwo):FireEvent("ShowSkillCardFrame", (self._cellData):GetEntityId())
    end
  end
  if eventName == "ChangeAutoSkill" then
    (self._frameTwo):FireEvent("ChangeAutoSkill", arg)
  end
  if eventName == "ChangeLittleCharRaycastTarget" then
    (self._middle):SetRaycastTarget(arg)
    if self._tag and self._tag == "one" then
      (self._frameOne):FireEvent("ForbidClick", not arg)
    end
    if self._tag and self._tag == "two" then
      (self._frameTwo):FireEvent("ForbidClick", not arg)
    end
  end
  if eventName == "SkillCDStateChange" then
    (self._frameTwo):FireEvent("SkillCDStateChange", arg)
  end
  if eventName == "ChangeSkillAutoEffectState" then
    (self._frameTwo):FireEvent("ChangeSkillAutoEffectState", arg)
  end
end

BattleSkillCell.OnUpdate = function(self)
  -- function num : 0_11
  local hp = (self._cellData):GetHp()
  local hpMax = (self._cellData):GetHpMax()
  ;
  (self._hpProgress):SetFillAmount(hp / hpMax)
end

return BattleSkillCell

