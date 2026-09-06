local Skill = require("logic.manager.experimental.types.skill")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BattlePauseRoleSkillCell = class("BattlePauseRoleSkillCell", Dialog)
BattlePauseRoleSkillCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseRoleSkillCell.AssetName = "BattlePauseCell"

local function OnNewBattleGuideTimeType1003(self, notification)
  if notification.userInfo == 2 then
    local skill = self._cellData:GetShowSkillDataByIndex(2)
    if skill and skill.unlock and skill.skillId == 6016201 then
      self._battleGuideState = true
      NekoData.BehaviorManager.BM_Guide:CreateGuideDialogInBattle(nil, function()
        local width, height = self._skill2Panel:GetRectSize()
        local screenPos = self._skill2PanelGuide:GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = screenPos.x,
          posY = screenPos.y
        }
      end, function()
        local width, height = self._skill2Panel:GetRectSize()
        local screenPos = self._skill2PanelGuide:GetLocalPointInUiRootPanel()
        return {
          width = width,
          height = height,
          posX = screenPos.x,
          posY = screenPos.y
        }
      end, "Down", 2301170)
    end
  end
end

function BattlePauseRoleSkillCell:Ctor(...)
  BattlePauseRoleSkillCell.super.Ctor(self, ...)
end

function BattlePauseRoleSkillCell:OnCreate()
  self._skill1Panel = self:GetChild("Char/Skill1")
  self._skill2Panel = self:GetChild("Char/Skill2")
  self._skill2PanelGuide = self:GetChild("Char/Skill2/Guide")
  self._skill1Img = self:GetChild("Char/Skill1/SkillBack/Skill")
  self._skill2Img = self:GetChild("Char/Skill2/SkillBack/Skill")
  self._skill1Name = self:GetChild("Char/Skill1/TitleBack/Num")
  self._skill2Name = self:GetChild("Char/Skill2/TitleBack/Num")
  self._skill1DetailPanel = self:GetChild("Char/Skill1/Frame")
  self._skill2DetailPanel = self:GetChild("Char/Skill2/Frame")
  self._charBack = self:GetChild("Char/CharBack")
  self._charImg = self:GetChild("Char/CharBack/Char")
  self._describe = self:GetChild("Char/Detail")
  self._skill1DetailFrame = TableFrame.Create(self._skill1DetailPanel, self, true, true)
  self._skill2DetailFrame = TableFrame.Create(self._skill2DetailPanel, self, true, true)
  self._skill1DetailInfoData = {}
  self._skill2DetailInfoData = {}
  self._skill2Panel:Subscribe_PointerClickEvent(self.OnSkillPanel2Clicked, self)
  LuaNotificationCenter.AddObserver(self, OnNewBattleGuideTimeType1003, Common.n_NewBattleGuideTimeType1003, nil)
end

function BattlePauseRoleSkillCell:OnDestroy()
  if self._skill1DetailFrame then
    self._skill1DetailFrame:Destroy()
    self._skill1DetailFrame = nil
  end
  if self._skill2DetailFrame then
    self._skill2DetailFrame:Destroy()
    self._skill2DetailFrame = nil
  end
end

function BattlePauseRoleSkillCell:RefreshCell(role)
  local imgRecord = role:GetSkillHeadImageRecord()
  if imgRecord then
    self._charImg:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
  local skill = role:GetShowSkillDataByIndex(1)
  if skill then
    if skill.unlock then
      self._skill1Panel:SetActive(true)
      local skillItem = Skill.Create(skill.skillId, skill.skillItemId or true)
      imgRecord = skillItem:GetSkillIcon()
      self._skill1Img:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      self._skill1Name:SetText(skillItem:GetSkillName())
      self._skill1DetailInfoData = {}
      self._skill1DetailInfoData[1] = {
        describe = skillItem:GetDescribeTxt(),
        skillIndex = 1
      }
      self._skill1DetailFrame:ReloadAllCell()
    else
      self._skill1Panel:SetActive(false)
    end
  end
  skill = role:GetShowSkillDataByIndex(2)
  if skill then
    if skill.unlock then
      self._skill2Panel:SetActive(true)
      local skillItem = Skill.Create(skill.skillId, skill.skillItemId or true)
      imgRecord = skillItem:GetSkillIcon()
      self._skill2Img:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      self._skill2Name:SetText(skillItem:GetSkillName())
      self._skill2DetailInfoData = {}
      self._skill2DetailInfoData[1] = {
        describe = skillItem:GetDescribeTxt(),
        skillIndex = 2
      }
      self._skill2DetailFrame:ReloadAllCell()
    else
      self._skill2Panel:SetActive(false)
    end
  end
end

function BattlePauseRoleSkillCell:NumberOfCell(frame)
  if self._skill1DetailFrame == frame then
    return #self._skill1DetailInfoData
  elseif self._skill2DetailFrame == frame then
    return #self._skill2DetailInfoData
  end
end

function BattlePauseRoleSkillCell:CellAtIndex(frame)
  return "newbattle.battlepauseskilldetailcell"
end

function BattlePauseRoleSkillCell:DataAtIndex(frame, index)
  if self._skill1DetailFrame == frame then
    return self._skill1DetailInfoData[index]
  elseif self._skill2DetailFrame == frame then
    return self._skill2DetailInfoData[index]
  end
end

function BattlePauseRoleSkillCell:SetFrameSlide(slideFlag, skillIndex)
  if skillIndex == 1 then
    self._skill1DetailFrame:SetSlide(slideFlag)
  elseif skillIndex == 2 then
    self._skill2DetailFrame:SetSlide(slideFlag)
  end
end

function BattlePauseRoleSkillCell:OnSkillPanel2Clicked()
  if self._battleGuideState then
    self._battleGuideState = false
    NekoData.BehaviorManager.BM_Guide:DestroyGuideDialogInBattle()
    LuaNotificationCenter.PostNotification(Common.n_NewBattleGuideTimeType1003, self, 3)
  end
end

return BattlePauseRoleSkillCell
