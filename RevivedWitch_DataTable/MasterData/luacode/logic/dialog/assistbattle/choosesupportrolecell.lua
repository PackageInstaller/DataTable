-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/assistbattle/choosesupportrolecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local CSkillItemTable = (BeanManager.GetTableByName)("item.cskillitem")
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local CSupportTable = (BeanManager.GetTableByName)("friend.csupportconfig")
local CStringres = (BeanManager.GetTableByName)("message.cstringres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Skill = require("logic.manager.experimental.types.skill")
local ChooseSupportRoleCell = class("ChooseSupportRoleCell", Dialog)
ChooseSupportRoleCell.AssetBundleName = "ui/layouts.teamedit"
ChooseSupportRoleCell.AssetName = "TeamEditChooseAssistCell"
ChooseSupportRoleCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ChooseSupportRoleCell
  ((ChooseSupportRoleCell.super).Ctor)(self, ...)
end

ChooseSupportRoleCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._back = self:GetChild("CharacterCellSmall/_Back")
  self._img = self:GetChild("CharacterCellSmall/_CharacterImage")
  self._job = self:GetChild("CharacterCellSmall/_Job")
  self._rank = self:GetChild("CharacterCellSmall/_Quality")
  self._level = self:GetChild("CharacterCellSmall/Level/Num")
  self._element = self:GetChild("CharacterCellSmall/Element")
  self._breakLevelBackBlack = self:GetChild("BreakLevelBackBlack")
  self._breakLevelBack = self:GetChild("BreakLevelBack")
  self._breakLevel = self:GetChild("BreakLevelNum")
  self._maxLevel = self:GetChild("CharacterCellSmall/Level/MaxNum")
  self._friendTxt = self:GetChild("TitleBack/Txt/Txt2")
  self._strangerTxt = self:GetChild("TitleBack/Txt/Txt1")
  self._name = self:GetChild("TitleBack/Name")
  self._friendShip = self:GetChild("TitleBack/Num")
  self._skillIcon = self:GetChild("SkillIcon")
  self._skillName = self:GetChild("SkillName")
  self._skillLv = self:GetChild("Level/Num")
  self._select = self:GetChild("Select")
  self._iBtn = self:GetChild("Ibtn")
  self._jobLimit = self:GetChild("JobLimit")
  self._isJobLimit = false
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  if ((NekoData.BehaviorManager).BM_Guide):IsCurrentGuide(20) then
    (self._iBtn):SetActive(false)
  end
end

ChooseSupportRoleCell.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
end

ChooseSupportRoleCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CStringres, CSupportTable, Skill
  local imageRecord = (data.role):GetSmallRarityBackRecord()
  ;
  (self._back):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.role):GetShapeLittleHeadImageRecord()
  ;
  (self._img):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.role):GetVocationImageRecord()
  ;
  (self._job):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.role):GetRarityImageRecord()
  ;
  (self._rank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.role):GetElementImageRecord()
  ;
  (self._element):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._rank):SetActive((data.role):GetId() ~= 1)
  ;
  (self._level):SetText((data.role):GetShowLv())
  local breakLv = (data.role):GetBreakLv()
  ;
  (self._breakLevelBackBlack):SetActive(breakLv == 0)
  ;
  (self._breakLevelBack):SetActive(breakLv > 0)
  ;
  (self._breakLevel):SetActive(breakLv > 0)
  do
    if breakLv > 0 then
      local imageRecord = (data.role):GetCurBreakFrame2ImageRecord()
      ;
      (self._breakLevelBack):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
      ;
      (self._breakLevel):SetText(breakLv)
    end
    ;
    (self._maxLevel):SetText((data.role):GetMaxLevelIgnorePlayerLv())
    if (data.friend):IsFriend() then
      (self._friendTxt):SetActive(true)
      ;
      (self._strangerTxt):SetActive(false)
      local str = (TextManager.GetText)((CStringres:GetRecorder(1079)).msgTextID)
      ;
      (self._friendShip):SetText((string.gsub)(str, "%$parameter1%$", (CSupportTable:GetRecorder(1)).supportPointFriend))
    elseif (data.friend):IsStranger() then
      (self._friendTxt):SetActive(false)
      ;
      (self._strangerTxt):SetActive(true)
      local str = (TextManager.GetText)((CStringres:GetRecorder(1079)).msgTextID)
      ;
      (self._friendShip):SetText((string.gsub)(str, "%$parameter1%$", (CSupportTable:GetRecorder(1)).supportPointStranger))
    end
    ;
    (self._name):SetText((data.friend):GetName())
    local skillId = (data.role):GetSupportSkillId()
    self._skillItemId = (data.role):GetSupportSkillItemId()
    local skill = (Skill.Create)(skillId, self._skillItemId)
    self._skillId = skillId
    imageRecord = skill:GetSkillIcon()
    ;
    (self._skillIcon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
    ;
    (self._skillName):SetText(skill:GetSkillName())
    ;
    (self._skillLv):SetText(skill:GetSkillLevel())
    if (self._delegate)._selectedRole and (data.friend):GetID() == (((self._delegate)._selectedRole).friend):GetID() then
      (self._select):SetActive(true)
    else
      (self._select):SetActive(false)
    end
    self._isJobLimit = not ((NekoData.BehaviorManager).BM_Vocation):GetVocationIsSupport(data.role, (self._delegate)._supportVocationTable)
    ;
    (self._jobLimit):SetActive(self._isJobLimit)
    -- DECOMPILER ERROR: 9 unprocessed JMP targets
  end
end

ChooseSupportRoleCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if self._isJobLimit then
    ((NekoData.BehaviorManager).BM_Message):SendMessageById(100227)
    return 
  end
  if not (self._delegate)._selectedRole or ((self._cellData).friend):GetID() ~= (((self._delegate)._selectedRole).friend):GetID() then
    (self._delegate):SetSelectRole(self._cellData)
  else
    if (self._delegate)._selectedRole then
      (self._delegate):SetSelectRole(nil)
    end
  end
end

ChooseSupportRoleCell.OnIBtnClicked = function(self)
  -- function num : 0_5 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("assistbattle.skilldescriptiondialog")):Init(self._skillId, self._skillItemId)
end

ChooseSupportRoleCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_6
  if eventName == "SetSelectRoleState" then
    if ((self._cellData).friend):GetID() == arg then
      (self._select):SetActive(true)
    else
      ;
      (self._select):SetActive(false)
    end
  end
end

return ChooseSupportRoleCell

