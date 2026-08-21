-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/basecharactorskillcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSkillTable = (BeanManager.GetTableByName)("skill.cskill")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BaseCharactorSkillCell = class("BaseCharactorSkillCell", Dialog)
BaseCharactorSkillCell.AssetBundleName = "ui/layouts.basecharacterinfo"
BaseCharactorSkillCell.AssetName = "BaseCharactorSkillCell"
BaseCharactorSkillCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BaseCharactorSkillCell
  ((BaseCharactorSkillCell.super).Ctor)(self, ...)
end

BaseCharactorSkillCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("SkillCell/_BackGround/Icon")
  self._frame = self:GetChild("SkillCell/_BackGround/Frame")
  self._select = self:GetChild("SkillCell/_BackGround/Select")
  ;
  (self._frame):Subscribe_PointerClickEvent(self.OnCellPointerClick, self)
  ;
  (self:GetRootWindow()):SetUserData(self)
  ;
  (self._select):SetActive(false)
end

BaseCharactorSkillCell.OnDestroy = function(self)
  -- function num : 0_2
end

BaseCharactorSkillCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CSkillTable, CImagePathTable, _ENV
  local skillRecord = CSkillTable:GetRecorder(data)
  if not CImagePathTable:GetRecorder(skillRecord.icon) then
    local iconImageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(iconImageRecord.assetBundle, iconImageRecord.assetName)
end

BaseCharactorSkillCell.OnCellPointerClick = function(self)
  -- function num : 0_4
  (self._select):SetActive(true)
  ;
  (self._delegate):SetSelectedID((self:GetRootWindow()):GetUserData())
end

BaseCharactorSkillCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if (self:GetRootWindow()):GetUserData() ~= arg then
    (self._select):SetActive(eventName ~= "ChangedSelected")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return BaseCharactorSkillCell

