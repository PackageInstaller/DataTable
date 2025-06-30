-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/passiveskillcellcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillShow_Role = (BeanManager.GetTableByName)("skill.cskillshow_role")
local CSKIllTable = (BeanManager.GetTableByName)("skill.cskill")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local PassiveSkillCellCell = class("PassiveSkillCellCell", Dialog)
PassiveSkillCellCell.AssetBundleName = "ui/layouts.basecharacterinfo"
PassiveSkillCellCell.AssetName = "BaseCharacterInfoSkillNewCell1"
PassiveSkillCellCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : PassiveSkillCellCell
  ((PassiveSkillCellCell.super).Ctor)(self, ...)
end

PassiveSkillCellCell.OnCreate = function(self)
  -- function num : 0_1
  self._grey = self:GetChild("Grey")
  ;
  (self._grey):SetActive(false)
  self._skill = self:GetChild("SkillBack/Skill")
  self._skillName = self:GetChild("SkillName")
  self._skillDescribe = self:GetChild("SkillDescribe")
  self._lock = self:GetChild("Lock")
  self._unlockCondition = self:GetChild("Lock/Txt")
end

PassiveSkillCellCell.OnDestroy = function(self)
  -- function num : 0_2
end

local SetCondition = function(self, total, index)
  -- function num : 0_3 , upvalues : _ENV, CStringRes
  -- DECOMPILER ERROR at PC20: Unhandled construct in 'MakeBoolean' P3

  if (total == 1 and index == 1) or total ~= 2 or total == 3 and index == 3 then
    local str = (TextManager.GetText)((CStringRes:GetRecorder(1075)).msgTextID)
    ;
    (self._unlockCondition):SetText(str)
  else
    do
      if (total == 2 and index == 1) or total == 3 and index == 2 then
        local str = (TextManager.GetText)((CStringRes:GetRecorder(1073)).msgTextID)
        ;
        (self._unlockCondition):SetText(str)
      else
        do
          if total == 3 and index == 1 then
            local str = (TextManager.GetText)((CStringRes:GetRecorder(1072)).msgTextID)
            ;
            (self._unlockCondition):SetText(str)
          end
        end
      end
    end
  end
end

PassiveSkillCellCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : SetCondition, CSKIllTable, CImagePathTable, _ENV, CSkillShow_Role
  if data.unlock then
    (self._lock):SetActive(false)
  else
    ;
    (self._lock):SetActive(true)
    SetCondition(self, data.count, data.index)
  end
  local cSkillTable = CSKIllTable:GetRecorder(data.id)
  if not CImagePathTable:GetRecorder(cSkillTable.icon) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._skill):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  local show = CSkillShow_Role:GetRecorder(cSkillTable.id)
  ;
  (self._skillName):SetText(tostring((TextManager.GetText)(show.nameTextID)))
  ;
  (self._skillDescribe):SetText(((NekoData.BehaviorManager).BM_Message):GetRoleSkillDescribe(cSkillTable.id))
end

PassiveSkillCellCell.OnCellClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local tipsDialog = (DialogManager.CreateSingletonDialog)("character.characterskilltipsdialog")
  if tipsDialog then
    tipsDialog:Init((self._cellData).id)
    self._Anchoredx = ((self._delegate):GetRootWindow()):GetAnchoredPosition()
    ;
    (tipsDialog:GetRootWindow()):SetAnchoredPosition(self._Anchoredx, self._Anchoredy)
  end
end

return PassiveSkillCellCell

