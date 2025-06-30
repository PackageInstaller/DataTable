-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/newbattle/battleroleskillsdetaildialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Role = require("logic.manager.experimental.types.role")
local BattleRoleSkillsDetailDialog = class("BattleRoleSkillsDetailDialog", Dialog)
BattleRoleSkillsDetailDialog.AssetBundleName = "ui/layouts.battlenew"
BattleRoleSkillsDetailDialog.AssetName = "BattleSkillExplain"
BattleRoleSkillsDetailDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BattleRoleSkillsDetailDialog
  ((BattleRoleSkillsDetailDialog.super).Ctor)(self, ...)
  self._groupName = "ModalFrame"
end

BattleRoleSkillsDetailDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._charIcon = self:GetChild("CharBack/Char")
  self._skills = {}
  for i = 1, 2 do
    -- DECOMPILER ERROR at PC12: Confused about usage of register: R5 in 'UnsetPending'

    (self._skills)[i] = {}
    -- DECOMPILER ERROR at PC21: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._skills)[i]).icon = self:GetChild("Frame/Skill" .. i .. "/SkillBack/Skill")
    -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._skills)[i]).name = self:GetChild("Frame/Skill" .. i .. "/TitleBack/Num")
    -- DECOMPILER ERROR at PC39: Confused about usage of register: R5 in 'UnsetPending'

    ;
    ((self._skills)[i]).describe = self:GetChild("Frame/Skill" .. i .. "/Detail")
  end
  local dialog = (DialogManager.GetDialog)("newbattle.battlepausedialog")
  if dialog then
    (dialog:GetRootWindow()):SetActive(false)
  end
end

BattleRoleSkillsDetailDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("newbattle.battlepausedialog")
  if dialog then
    (dialog:GetRootWindow()):SetActive(true)
  end
end

BattleRoleSkillsDetailDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : Role, _ENV, CSkillTable, CImagePathTable, CSkillShow_Role
  local role = (Role.Create)(data:GetConfigId())
  local record = role:GetSkillHeadImageRecord()
  if record then
    (self._charIcon):SetSprite(record.assetBundle, record.assetName)
  end
  for i,v in ipairs(data:GetSkillList()) do
    local skillRecord = CSkillTable:GetRecorder(v)
    if not CImagePathTable:GetRecorder(skillRecord.icon) then
      local image = DataCommon.DefaultImageAsset
    end
    ;
    (((self._skills)[i]).icon):SetSprite(image.assetBundle, image.assetName)
    local skillShowRecord = CSkillShow_Role:GetRecorder(v)
    ;
    (((self._skills)[i]).name):SetText((TextManager.GetText)(skillShowRecord.nameTextID))
    ;
    (((self._skills)[i]).describe):SetText(((NekoData.BehaviorManager).BM_Message):GetRoleSkillDescribe(v))
  end
end

BattleRoleSkillsDetailDialog.OnBackClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return BattleRoleSkillsDetailDialog

