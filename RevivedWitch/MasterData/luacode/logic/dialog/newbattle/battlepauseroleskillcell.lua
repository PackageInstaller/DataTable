-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battlepauseroleskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Skill = require("logic.manager.experimental.types.skill")
local TableFrame = require("framework.ui.frame.table.tableframe")
local BattlePauseRoleSkillCell = class("BattlePauseRoleSkillCell", Dialog)
BattlePauseRoleSkillCell.AssetBundleName = "ui/layouts.battlenew"
BattlePauseRoleSkillCell.AssetName = "BattlePauseCell"
local OnNewBattleGuideTimeType1003 = function(self, notification)
  -- function num : 0_0 , upvalues : _ENV
  if notification.userInfo == 2 then
    local skill = (self._cellData):GetShowSkillDataByIndex(2)
    if skill and skill.unlock and skill.skillId == 6016201 then
      self._battleGuideState = true
      ;
      ((NekoData.BehaviorManager).BM_Guide):CreateGuideDialogInBattle(nil, function()
    -- function num : 0_0_0 , upvalues : self
    local width, height = (self._skill2Panel):GetRectSize()
    local screenPos = (self._skill2PanelGuide):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, function()
    -- function num : 0_0_1 , upvalues : self
    local width, height = (self._skill2Panel):GetRectSize()
    local screenPos = (self._skill2PanelGuide):GetLocalPointInUiRootPanel()
    return {width = width, height = height, posX = screenPos.x, posY = screenPos.y}
  end
, "Down", 2301170)
    end
  end
end

BattlePauseRoleSkillCell.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : BattlePauseRoleSkillCell
  ((BattlePauseRoleSkillCell.super).Ctor)(self, ...)
end

BattlePauseRoleSkillCell.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame, _ENV, OnNewBattleGuideTimeType1003
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
  self._skill1DetailFrame = (TableFrame.Create)(self._skill1DetailPanel, self, true, true)
  self._skill2DetailFrame = (TableFrame.Create)(self._skill2DetailPanel, self, true, true)
  self._skill1DetailInfoData = {}
  self._skill2DetailInfoData = {}
  ;
  (self._skill2Panel):Subscribe_PointerClickEvent(self.OnSkillPanel2Clicked, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, OnNewBattleGuideTimeType1003, Common.n_NewBattleGuideTimeType1003, nil)
end

BattlePauseRoleSkillCell.OnDestroy = function(self)
  -- function num : 0_3
  if self._skill1DetailFrame then
    (self._skill1DetailFrame):Destroy()
    self._skill1DetailFrame = nil
  end
  if self._skill2DetailFrame then
    (self._skill2DetailFrame):Destroy()
    self._skill2DetailFrame = nil
  end
end

BattlePauseRoleSkillCell.RefreshCell = function(self, role)
  -- function num : 0_4 , upvalues : Skill
  local imgRecord = role:GetSkillHeadImageRecord()
  if imgRecord then
    (self._charImg):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  end
  local skill = role:GetShowSkillDataByIndex(1)
  if skill then
    if skill.unlock then
      (self._skill1Panel):SetActive(true)
      local skillItem = (Skill.Create)(skill.skillId, skill.skillItemId or true)
      imgRecord = skillItem:GetSkillIcon()
      ;
      (self._skill1Img):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
      ;
      (self._skill1Name):SetText(skillItem:GetSkillName())
      self._skill1DetailInfoData = {}
      -- DECOMPILER ERROR at PC49: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (self._skill1DetailInfoData)[1] = {describe = skillItem:GetDescribeTxt(), skillIndex = 1}
      ;
      (self._skill1DetailFrame):ReloadAllCell()
    else
      do
        ;
        (self._skill1Panel):SetActive(false)
        skill = role:GetShowSkillDataByIndex(2)
        if skill then
          if skill.unlock then
            (self._skill2Panel):SetActive(true)
            local skillItem = (Skill.Create)(skill.skillId, skill.skillItemId or true)
            imgRecord = skillItem:GetSkillIcon()
            ;
            (self._skill2Img):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
            ;
            (self._skill2Name):SetText(skillItem:GetSkillName())
            self._skill2DetailInfoData = {}
            -- DECOMPILER ERROR at PC99: Confused about usage of register: R5 in 'UnsetPending'

            ;
            (self._skill2DetailInfoData)[1] = {describe = skillItem:GetDescribeTxt(), skillIndex = 2}
            ;
            (self._skill2DetailFrame):ReloadAllCell()
          else
            do
              ;
              (self._skill2Panel):SetActive(false)
            end
          end
        end
      end
    end
  end
end

BattlePauseRoleSkillCell.NumberOfCell = function(self, frame)
  -- function num : 0_5
  if self._skill1DetailFrame == frame then
    return #self._skill1DetailInfoData
  else
    if self._skill2DetailFrame == frame then
      return #self._skill2DetailInfoData
    end
  end
end

BattlePauseRoleSkillCell.CellAtIndex = function(self, frame)
  -- function num : 0_6
  return "newbattle.battlepauseskilldetailcell"
end

BattlePauseRoleSkillCell.DataAtIndex = function(self, frame, index)
  -- function num : 0_7
  if self._skill1DetailFrame == frame then
    return (self._skill1DetailInfoData)[index]
  else
    if self._skill2DetailFrame == frame then
      return (self._skill2DetailInfoData)[index]
    end
  end
end

BattlePauseRoleSkillCell.SetFrameSlide = function(self, slideFlag, skillIndex)
  -- function num : 0_8
  if skillIndex == 1 then
    (self._skill1DetailFrame):SetSlide(slideFlag)
  else
    if skillIndex == 2 then
      (self._skill2DetailFrame):SetSlide(slideFlag)
    end
  end
end

BattlePauseRoleSkillCell.OnSkillPanel2Clicked = function(self)
  -- function num : 0_9 , upvalues : _ENV
  if self._battleGuideState then
    self._battleGuideState = false
    ;
    ((NekoData.BehaviorManager).BM_Guide):DestroyGuideDialogInBattle()
    ;
    (LuaNotificationCenter.PostNotification)(Common.n_NewBattleGuideTimeType1003, self, 3)
  end
end

return BattlePauseRoleSkillCell

