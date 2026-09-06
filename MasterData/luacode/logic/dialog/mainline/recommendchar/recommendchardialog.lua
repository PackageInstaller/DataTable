local GridFrame = require("framework.ui.frame.grid.gridframe")
local TableFrame = require("framework.ui.frame.table.tableframe")
local CDungeonSelectMainlineTable = BeanManager.GetTableByName("dungeonselect.cdungeonselectmainline")
local CResourceDungeonStage = BeanManager.GetTableByName("dungeonselect.cresourcedungeonstage")
local CRecommendRole = BeanManager.GetTableByName("dungeonselect.crecommendrole")
local CBattleTypeCfg = BeanManager.GetTableByName("role.cbattletypecfg")
local CCostSkillTable = BeanManager.GetTableByName("skill.ccostskill")
local Role = require("logic.manager.experimental.types.role")
local Skill = require("logic.manager.experimental.types.skill")
local RecommendCharDiaLog = class("RecommendCharDiaLog", Dialog)
RecommendCharDiaLog.AssetBundleName = "ui/layouts.mainline"
RecommendCharDiaLog.AssetName = "RecommendChar"

function RecommendCharDiaLog:Ctor(...)
  RecommendCharDiaLog.super.Ctor(self, ...)
  self._select = {id = 0, index = 0}
  self._recommendCharData = {}
  self._handler = 0
end

function RecommendCharDiaLog:OnCreate()
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
  self._recommendCharTypeFrame = TableFrame.Create(self._recommendTypePanel, self, false, false, false)
  self._recommendCharFrame = TableFrame.Create(self._charPanel, self, true, true, true)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClicked, self)
  self._menuBtn:SetActive(not GlobalGameFSM or GlobalGameFSM:GetCurrentState() ~= "Dungeon")
end

function RecommendCharDiaLog:OnDestroy()
  self._recommendCharTypeFrame:Destroy()
  self._recommendCharFrame:Destroy()
end

function RecommendCharDiaLog:Refresh(data)
  local recommendIds
  if data.type == "MainLine" then
    recommendIds = CDungeonSelectMainlineTable:GetRecorder(data.id).recommendid
  elseif data.type == "Resource" then
    recommendIds = CResourceDungeonStage:GetRecorder(data.id).recommendid
  end
  if recommendIds then
    for key, value in pairs(recommendIds) do
      local temp = {}
      temp.typeid = CRecommendRole:GetRecorder(value).typeid
      temp.roleids = CRecommendRole:GetRecorder(value).roleid
      temp.index = key
      table.insert(self._recommendCharData, temp)
    end
  end
  self._recommendCharFrame:ReloadAllCell()
  self._recommendCharTypeFrame:ReloadAllCell()
  self._recommendCharFrame:MoveToTop()
  local firstId = self._recommendCharData[1].roleids[1]
  local firstIndex = 1
  if firstId then
    self:OnCellClicked(firstIndex, firstId)
  end
end

function RecommendCharDiaLog:OnCellClicked(index, id)
  self._select.id = id
  self._select.index = index
  local role = Role.Create(id, nil, true)
  local imageRecord = role:GetModelRecord()
  if self._handler ~= 0 then
    self._detail_Model:ReleaseModel(self._handler)
    self._handler = 0
  end
  self._handler = self._detail_Model:AddModelSync(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = role:GetRarityImageRecord()
  self._detail_Rank:SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  self._detail_Name:SetText(role:GetRoleName())
  self._detail_JobTxt:SetText(role:GetVocationName())
  local roleConfig = role:GetRoleConfig()
  local skillid1 = roleConfig.contractskillid
  local skillid2 = roleConfig.contractskillid2
  local skill1Level = skillid1 * 100 + 5
  local skill2Level = skillid2 * 100 + 5
  local skillItem = Skill.Create(skill1Level, skillid1)
  self._detail_Skill1_Name:SetText(skillItem:GetSkillName())
  self._detail_Skill1_Detail:SetText(skillItem:GetDescribeTxt())
  self._detail_Skill1_Cost1:SetText(skillItem:GetYellowCost())
  self._detail_Skill1_Cost2:SetText(skillItem:GetPurpleCost())
  skillItem = Skill.Create(skill2Level, skillid2)
  self._detail_Skill2_Name:SetText(skillItem:GetSkillName())
  self._detail_Skill2_Detail:SetText(skillItem:GetDescribeTxt())
  self._detail_Skill2_Cost1:SetText(skillItem:GetYellowCost())
  self._detail_Skill2_Cost2:SetText(skillItem:GetPurpleCost())
  self._recommendCharFrame:FireEvent("SetSelectedRole", self._select)
end

function RecommendCharDiaLog:OnBackBtnClicked()
  self:Destroy()
end

function RecommendCharDiaLog:OnMenuBtnClicked()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function RecommendCharDiaLog:CellAtIndex(frame, index)
  if frame == self._recommendCharFrame then
    return "mainline.recommendchar.recommendcharcell"
  elseif frame == self._recommendCharTypeFrame then
    return "mainline.recommendchar.recommendchartypecell"
  end
end

function RecommendCharDiaLog:DataAtIndex(frame, index)
  if frame == self._recommendCharFrame then
    return self._recommendCharData[index]
  elseif frame == self._recommendCharTypeFrame then
    return self._recommendCharData[index].typeid
  end
end

function RecommendCharDiaLog:NumberOfCell(frame)
  return #self._recommendCharData
end

function RecommendCharDiaLog:ShouldLengthChange()
  return true
end

return RecommendCharDiaLog
