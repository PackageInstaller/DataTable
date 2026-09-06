local Skill = require("logic.manager.experimental.types.skill")
local CSkillShow_Role = BeanManager.GetTableByName("skill.cskillshow_role")
local CSkillTable = BeanManager.GetTableByName("skill.cskill")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CCostSkillTable = BeanManager.GetTableByName("skill.ccostskill")
local CSkillItemTable = BeanManager.GetTableByName("item.cskillitem")
local FightSkillCell = class("FightSkillCell", Dialog)
FightSkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
FightSkillCell.AssetName = "BaseCharacterInfoSkillNewCell2"
FightSkillCell.SkillType = {ContractSkill = 1, OrderSkill = 2}

function FightSkillCell:Ctor(...)
  FightSkillCell.super.Ctor(self, ...)
  self._data = nil
  self._two_protocol_come_one = false
  self._two_protocol_come_two = false
end

function FightSkillCell:OnCreate()
  self._title1 = self:GetChild("Title1/Title1")
  self._title2 = self:GetChild("Title1/Title2")
  self._skill1Panel = self:GetChild("Skill1")
  self._skill1 = self:GetChild("Skill1/SkillBack/Skill")
  self._rank1 = self:GetChild("Skill1/SkillBack/Rank")
  self._level1 = self:GetChild("Skill1/SkillBack/Level")
  self._skillName1 = self:GetChild("Skill1/SkillName")
  self._skill1Num1 = self:GetChild("Skill1/Num1")
  self._skill1Num2 = self:GetChild("Skill1/Num2")
  self._skill2Empty = self:GetChild("Skill2Empty")
  self._skill2Panel = self:GetChild("Skil2")
  self._skill2 = self:GetChild("Skil2/SkillBack/Skill")
  self._rank2 = self:GetChild("Skil2/SkillBack/Rank")
  self._level2 = self:GetChild("Skil2/SkillBack/Level")
  self._skillName2 = self:GetChild("Skil2/SkillName")
  self._skill2Num1 = self:GetChild("Skil2/Num1")
  self._skill2Num2 = self:GetChild("Skil2/Num2")
  self._skill1:Subscribe_PointerClickEvent(self.OnSkill1Clicked, self)
  self._skill2:Subscribe_PointerClickEvent(self.OnSkill2Clicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
  LuaNotificationCenter.AddObserver(self, self.Refresh, Common.n_ImproveSkill, nil)
end

function FightSkillCell:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function FightSkillCell:RefreshCell(data)
  self._data = data
  self:Refresh()
end

function FightSkillCell:Refresh()
  local data
  if self._data then
    data = NekoData.BehaviorManager.BM_AllRoles:GetRole(self._data:GetRoleId())
  end
  if data then
    self._data = data
    if data:GetIsLeader() then
      self._title1:SetActive(true)
      self._title2:SetActive(false)
    else
      self._title1:SetActive(false)
      self._title2:SetActive(true)
    end
    local skill1 = data:GetContractSkillInfo()
    if skill1 then
      local constract = skill1.skillLevel
      local cSkillTable = CSkillTable:GetRecorder(constract)
      if not cSkillTable then
        LogErrorFormat("FightSkillCell", "wrong constract skillid %d", constract)
      end
      local imageRecord = CImagePathTable:GetRecorder(cSkillTable.icon) or DataCommon.DefaultImageAsset
      self._skill1:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._skill1Num1:SetText(tostring(CCostSkillTable:GetRecorder(constract).OrderCost))
      self._skill1Num2:SetText(tostring(CCostSkillTable:GetRecorder(constract).ChaosCost))
      local show = CSkillShow_Role:GetRecorder(cSkillTable.id)
      self._skillName1:SetText(tostring(TextManager.GetText(show.nameTextID)))
    else
    end
    local skill2 = data:GetOrderSkill()
    if skill2 then
      self._skill2Panel:SetActive(true)
      self._skill2Empty:SetActive(false)
      local constract = skill2.skillLevel
      local cSkillTable = CSkillTable:GetRecorder(constract)
      if not cSkillTable then
        LogErrorFormat("FightSkillCell", "wrong constract skillid %d", constract)
      end
      local imageRecord = CImagePathTable:GetRecorder(cSkillTable.icon) or DataCommon.DefaultImageAsset
      self._skill2:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      self._skill2Num1:SetText(tostring(CCostSkillTable:GetRecorder(constract).OrderCost))
      self._skill2Num2:SetText(tostring(CCostSkillTable:GetRecorder(constract).ChaosCost))
      local show = CSkillShow_Role:GetRecorder(cSkillTable.id)
      self._skillName2:SetText(tostring(TextManager.GetText(show.nameTextID)))
    else
      self._skill2Panel:SetActive(false)
      self._skill2Empty:SetActive(true)
    end
  else
    LogError("FightSkillCell", "data is nil, wrong use for Refresh function")
  end
end

function FightSkillCell:OnRoleInfoChange(notification)
  if notification.userInfo.name == "supdateorderskill" then
    if self._two_protocol_come_one then
      self:Refresh()
      self._two_protocol_come_one = false
      self._two_protocol_come_two = false
    else
      self._two_protocol_come_two = true
    end
  end
end

function FightSkillCell:OnSkill1Clicked()
end

function FightSkillCell:OnSkill2Clicked()
end

function FightSkillCell:OnSkillInfoChange(userInfo)
  if self._data:GetRoleId() == userInfo.roleKey and userInfo.itemKey == 0 then
    self._skill2Panel:SetActive(false)
    self._skill2Empty:SetActive(true)
  else
  end
end

function FightSkillCell:OnContractSkillImprove()
end

function FightSkillCell:OnOrderSkillImprove()
end

function FightSkillCell:OnOrderSkillChange()
end

return FightSkillCell
