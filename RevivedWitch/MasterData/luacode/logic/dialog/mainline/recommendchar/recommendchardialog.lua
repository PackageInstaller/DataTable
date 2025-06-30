-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/recommendchar/recommendchardialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CDungeonSelectMainlineTable = (BeanManager.GetTableByName)("dungeonselect.cdungeonselectmainline")
local CResourceDungeonStage = (BeanManager.GetTableByName)("dungeonselect.cresourcedungeonstage")
local CRecommendRole = (BeanManager.GetTableByName)("dungeonselect.crecommendrole")
local CBattleTypeCfg = (BeanManager.GetTableByName)("role.cbattletypecfg")
local CCostSkillTable = (BeanManager.GetTableByName)("skill.ccostskill")
local Role = require("logic.manager.experimental.types.role")
local Skill = require("logic.manager.experimental.types.skill")
local RecommendCharDiaLog = class("RecommendCharDiaLog", Dialog)
RecommendCharDiaLog.AssetBundleName = "ui/layouts.mainline"
RecommendCharDiaLog.AssetName = "RecommendChar"
RecommendCharDiaLog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RecommendCharDiaLog
  ((RecommendCharDiaLog.super).Ctor)(self, ...)
  self._select = {id = 0, index = 0}
  self._recommendCharData = {}
  self._handler = 0
end

RecommendCharDiaLog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._recommendTypePanel = self:GetChild("RecommendType/Frame")
  self._charPanel = self:GetChild("CharFrame")
  self._detail_Model = self:GetChild("Detail/Model")
  self._detail_Rank = self:GetChild("Detail/Rank")
  self._detail_Name = self:GetChild("Detail/Name")
  self._detail_JobTxt = self:GetChild("Detail/JobTxt")
  self._detail_Skill1_Name = self:GetChild("Detail/Skill1/Name")
  self._detail_Skill1_Detail = self:GetChild("Detail/Skill1/Detail")
  self._detail_Skill1_Cost1 = self:GetChild("Detail/Skill1/Cost/Num1")
  self._detail_Skill1_Cost2 = self:GetChild("Detail/Skill1/Cost/Num2")
  self._detail_Skill2_Name = self:GetChild("Detail/Skill2/Name")
  self._detail_Skill2_Detail = self:GetChild("Detail/Skill2/Detail")
  self._detail_Skill2_Cost1 = self:GetChild("Detail/Skill2/Cost/Num1")
  self._detail_Skill2_Cost2 = self:GetChild("Detail/Skill2/Cost/Num2")
  self._recommendCharTypeFrame = (TableFrame.Create)(self._recommendTypePanel, self, false, false, false)
  self._recommendCharFrame = (TableFrame.Create)(self._charPanel, self, true, true, true)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  ;
  (self._menuBtn):SetActive(not GlobalGameFSM or GlobalGameFSM:GetCurrentState() ~= "Dungeon")
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

RecommendCharDiaLog.OnDestroy = function(self)
  -- function num : 0_2
  (self._recommendCharTypeFrame):Destroy()
  ;
  (self._recommendCharFrame):Destroy()
end

RecommendCharDiaLog.Refresh = function(self, data)
  -- function num : 0_3 , upvalues : CDungeonSelectMainlineTable, CResourceDungeonStage, _ENV, CRecommendRole
  local recommendIds = nil
  if data.type == "MainLine" then
    recommendIds = (CDungeonSelectMainlineTable:GetRecorder(data.id)).recommendid
  else
    if data.type == "Resource" then
      recommendIds = (CResourceDungeonStage:GetRecorder(data.id)).recommendid
    end
  end
  if recommendIds then
    for key,value in pairs(recommendIds) do
      local temp = {}
      temp.typeid = (CRecommendRole:GetRecorder(value)).typeid
      temp.roleids = (CRecommendRole:GetRecorder(value)).roleid
      temp.index = key
      ;
      (table.insert)(self._recommendCharData, temp)
    end
  end
  do
    ;
    (self._recommendCharFrame):ReloadAllCell()
    ;
    (self._recommendCharTypeFrame):ReloadAllCell()
    ;
    (self._recommendCharFrame):MoveToTop()
    local firstId = (((self._recommendCharData)[1]).roleids)[1]
    local firstIndex = 1
    if firstId then
      self:OnCellClicked(firstIndex, firstId)
    end
  end
end

RecommendCharDiaLog.OnCellClicked = function(self, index, id)
  -- function num : 0_4 , upvalues : Role, Skill
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R3 in 'UnsetPending'

  (self._select).id = id
  -- DECOMPILER ERROR at PC3: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._select).index = index
  local role = (Role.Create)(id, nil, true)
  local imageRecord = role:GetModelRecord()
  if self._handler ~= 0 then
    (self._detail_Model):ReleaseModel(self._handler)
    self._handler = 0
  end
  self._handler = (self._detail_Model):AddModelSync(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = role:GetRarityImageRecord()
  ;
  (self._detail_Rank):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._detail_Name):SetText(role:GetRoleName())
  ;
  (self._detail_JobTxt):SetText(role:GetVocationName())
  local roleConfig = role:GetRoleConfig()
  local skillid1 = roleConfig.contractskillid
  local skillid2 = roleConfig.contractskillid2
  local skill1Level = skillid1 * 100 + 5
  local skill2Level = skillid2 * 100 + 5
  local skillItem = (Skill.Create)(skill1Level, skillid1)
  ;
  (self._detail_Skill1_Name):SetText(skillItem:GetSkillName())
  ;
  (self._detail_Skill1_Detail):SetText(skillItem:GetDescribeTxt())
  ;
  (self._detail_Skill1_Cost1):SetText(skillItem:GetYellowCost())
  ;
  (self._detail_Skill1_Cost2):SetText(skillItem:GetPurpleCost())
  skillItem = (Skill.Create)(skill2Level, skillid2)
  ;
  (self._detail_Skill2_Name):SetText(skillItem:GetSkillName())
  ;
  (self._detail_Skill2_Detail):SetText(skillItem:GetDescribeTxt())
  ;
  (self._detail_Skill2_Cost1):SetText(skillItem:GetYellowCost())
  ;
  (self._detail_Skill2_Cost2):SetText(skillItem:GetPurpleCost())
  ;
  (self._recommendCharFrame):FireEvent("SetSelectedRole", self._select)
end

RecommendCharDiaLog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

RecommendCharDiaLog.OnMenuBtnClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

RecommendCharDiaLog.CellAtIndex = function(self, frame, index)
  -- function num : 0_7
  if frame == self._recommendCharFrame then
    return "mainline.recommendchar.recommendcharcell"
  else
    if frame == self._recommendCharTypeFrame then
      return "mainline.recommendchar.recommendchartypecell"
    end
  end
end

RecommendCharDiaLog.DataAtIndex = function(self, frame, index)
  -- function num : 0_8
  if frame == self._recommendCharFrame then
    return (self._recommendCharData)[index]
  else
    if frame == self._recommendCharTypeFrame then
      return ((self._recommendCharData)[index]).typeid
    end
  end
end

RecommendCharDiaLog.NumberOfCell = function(self, frame)
  -- function num : 0_9
  return #self._recommendCharData
end

RecommendCharDiaLog.ShouldLengthChange = function(self)
  -- function num : 0_10
  return true
end

return RecommendCharDiaLog

