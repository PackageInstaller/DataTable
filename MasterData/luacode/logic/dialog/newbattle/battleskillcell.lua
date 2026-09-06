local Role = require("logic.manager.experimental.types.role")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BattleSkillCell = class("BattleSkillCell", Dialog)
BattleSkillCell.AssetBundleName = "ui/layouts.battlenew"
BattleSkillCell.AssetName = "BattleCharSkillCell"

local function OnNewBattleGuideEnd(self, notification)
  local userInfo = notification.userInfo
  if userInfo == nil then
    return
  end
  self._guideFinished = true
end

function BattleSkillCell:Ctor(...)
  BattleSkillCell.super.Ctor(self, ...)
  self._tag = nil
  self._skillList = {}
end

function BattleSkillCell:OnCreate()
  self._middle = self:GetChild("CharBack")
  self._middleIcon = self:GetChild("CharBack/Char")
  self._hpProgress = self:GetChild("CharBack/Blood")
  self._panelOne = self:GetChild("FrameOne")
  self._panelTwo = self:GetChild("FrameTwo")
  self._frameOne = TableFrame.Create(self._panelOne, self, false, false)
  self._frameTwo = TableFrame.Create(self._panelTwo, self, false, false)
  self._middle:Subscribe_PointerClickEvent(self.OnLittleCharClicked, self)
  self._battleID = NekoData.BehaviorManager.BM_Battle:GetBattleId()
  self._guideFinished = false
  LuaNotificationCenter.AddObserver(self, OnNewBattleGuideEnd, Common.n_NewBattleGuideEnd, nil)
  LuaNotificationCenter.AddObserver(self, self.OnUpdate, Common.n_BattleLateUpdate, nil)
end

function BattleSkillCell:OnDestroy()
  self._frameOne:Destroy()
  self._frameTwo:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function BattleSkillCell:RefreshCell(data)
  self._skillList = {}
  local unlockSkillList = self._cellData:GetSkillList()
  for _, skillId in ipairs(unlockSkillList) do
    table.insert(self._skillList, {skillId = skillId, lockState = false})
  end
  local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(data:GetConfigId())
  local showSkillData = role:GetShowSkillData()
  for _, v in ipairs(showSkillData) do
    if not v.unlock then
      if #self._skillList >= 2 then
        break
      end
      table.insert(self._skillList, {
        skillId = v.skillId,
        lockState = true
      })
    end
  end
  if self._battleID == 1120 then
    self._panelOne:SetActive(true)
    self._panelTwo:SetActive(false)
    self._frameOne:ReloadAllCell()
    self._tag = "one"
  else
    self._panelOne:SetActive(false)
    self._panelTwo:SetActive(true)
    self._frameTwo:ReloadAllCell()
    self._tag = "two"
  end
  if #self._delegate._entityList == 1 then
    self._middle:SetActive(false)
  else
    self._middle:SetActive(true)
    local role = NekoData.BehaviorManager.BM_AllRoles:GetRoleById(data:GetConfigId())
    local record = role:GetSkillHeadImageRecord()
    if record then
      self._middleIcon:SetSprite(record.assetBundle, record.assetName)
    end
  end
end

function BattleSkillCell:NumberOfCell(frame)
  return #self._skillList
end

function BattleSkillCell:CellAtIndex(frame, index)
  if self._skillList[index].lockState then
    return "newbattle.battlelockskillsmallcell"
  else
    return "newbattle.battleskillsmallcell"
  end
end

function BattleSkillCell:DataAtIndex(frame, index)
  return self._skillList[index].skillId
end

function BattleSkillCell:OnControlOtherSkill(entityId, releaseSkill)
  if self._tag and self._tag == "two" then
    local data = {entityId = entityId, releaseSkill = releaseSkill}
    self._frameTwo:FireEvent("NoClickSkill", data)
  end
end

function BattleSkillCell:OnLittleCharClicked()
  if self._delegate._pause then
    DialogManager.CreateSingletonDialog("newbattle.battleroleskillsdetaildialog"):SetData(self._cellData)
  end
end

function BattleSkillCell:OnEvent(eventName, arg)
  if eventName == "ShowSkillCardBack" and arg and arg == self._cellData:GetEntityId() then
    if self._tag and self._tag == "one" then
      self._frameOne:FireEvent("ShowSkillCardBack", self._cellData:GetEntityId())
    end
    if self._tag and self._tag == "two" then
      self._frameTwo:FireEvent("ShowSkillCardBack", self._cellData:GetEntityId())
    end
  end
  if eventName == "ShowSkillCardFrame" and arg and arg == self._cellData:GetEntityId() then
    if self._tag and self._tag == "one" then
      self._frameOne:FireEvent("ShowSkillCardFrame", self._cellData:GetEntityId())
    end
    if self._tag and self._tag == "two" then
      self._frameTwo:FireEvent("ShowSkillCardFrame", self._cellData:GetEntityId())
    end
  end
  if eventName == "ChangeAutoSkill" then
    self._frameTwo:FireEvent("ChangeAutoSkill", arg)
  end
  if eventName == "ChangeLittleCharRaycastTarget" then
    self._middle:SetRaycastTarget(arg)
    if self._tag and self._tag == "one" then
      self._frameOne:FireEvent("ForbidClick", not arg)
    end
    if self._tag and self._tag == "two" then
      self._frameTwo:FireEvent("ForbidClick", not arg)
    end
  end
  if eventName == "SkillCDStateChange" then
    self._frameTwo:FireEvent("SkillCDStateChange", arg)
  end
  if eventName == "ChangeSkillAutoEffectState" then
    self._frameTwo:FireEvent("ChangeSkillAutoEffectState", arg)
  end
end

function BattleSkillCell:OnUpdate()
  local hp = self._cellData:GetHp()
  local hpMax = self._cellData:GetHpMax()
  self._hpProgress:SetFillAmount(hp / hpMax)
end

return BattleSkillCell
