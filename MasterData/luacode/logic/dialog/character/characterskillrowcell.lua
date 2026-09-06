local Skill = require("logic.manager.experimental.types.skill")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CharacterSkillRowCell = class("CharacterSkillRowCell", Dialog)
CharacterSkillRowCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterSkillRowCell.AssetName = "CharSkillNewCell"

function CharacterSkillRowCell:Ctor(...)
  CharacterSkillRowCell.super.Ctor(self, ...)
  self._nodeColumnMap = {}
end

function CharacterSkillRowCell:OnCreate()
  self._indexBack_Normal = self:GetChild("NumBack")
  self._indexBack_AllUnlock = self:GetChild("NumBackSelect")
  self._indexTxt_Normal = self:GetChild("Num")
  self._indexTxt_AllUnlock = self:GetChild("NumSelect")
  self._posChilds = {}
  for i = 1, 3 do
    self._posChilds[i] = {}
    self._posChilds[i].panel = self:GetChild("Position" .. i)
    self._posChilds[i].panel_redDot = self:GetChild("Position" .. i .. "/RedDot")
    self._posChilds[i].skillPanels = {}
    self._posChilds[i].skillPanels[Skill.Type.Active] = {}
    local map = self._posChilds[i].skillPanels[Skill.Type.Active]
    local str = "ActiveSkill"
    map.skillPanel = self:GetChild("Position" .. i .. "/" .. str)
    map.select = self:GetChild("Position" .. i .. "/" .. str .. "/Select")
    map.icon = self:GetChild("Position" .. i .. "/" .. str .. "/Skill")
    map.lvMaxFrame = self:GetChild("Position" .. i .. "/" .. str .. "/BackFull")
    map.grey = self:GetChild("Position" .. i .. "/" .. str .. "/Grey")
    map.lv = self:GetChild("Position" .. i .. "/" .. str .. "/NumBack/Num")
    self._posChilds[i].skillPanels[Skill.Type.Charging] = {}
    local map = self._posChilds[i].skillPanels[Skill.Type.Charging]
    local str = "EnergySkill"
    map.skillPanel = self:GetChild("Position" .. i .. "/" .. str)
    map.select = self:GetChild("Position" .. i .. "/" .. str .. "/Select")
    map.icon = self:GetChild("Position" .. i .. "/" .. str .. "/Skill")
    map.lvMaxFrame = self:GetChild("Position" .. i .. "/" .. str .. "/BackFull")
    map.grey = self:GetChild("Position" .. i .. "/" .. str .. "/Grey")
    map.lv = self:GetChild("Position" .. i .. "/" .. str .. "/NumBack/Num")
    self._posChilds[i].skillPanels[Skill.Type.Passive] = {}
    local map = self._posChilds[i].skillPanels[Skill.Type.Passive]
    local str = "PassiveSkill"
    map.skillPanel = self:GetChild("Position" .. i .. "/" .. str)
    map.select = self:GetChild("Position" .. i .. "/" .. str .. "/Select")
    map.icon = self:GetChild("Position" .. i .. "/" .. str .. "/Skill")
    map.lvMaxFrame = self:GetChild("Position" .. i .. "/" .. str .. "/BackFull")
    map.grey = self:GetChild("Position" .. i .. "/" .. str .. "/Grey")
    map.lv = self:GetChild("Position" .. i .. "/" .. str .. "/NumBack/Num")
    self._posChilds[i].skillPanels[Skill.Type.Attribute] = {}
    local map = self._posChilds[i].skillPanels[Skill.Type.Attribute]
    local str = "PropSkill"
    map.skillPanel = self:GetChild("Position" .. i .. "/" .. str)
    map.select = self:GetChild("Position" .. i .. "/" .. str .. "/Select")
    map.icon = self:GetChild("Position" .. i .. "/" .. str .. "/Skill")
    map.grey = self:GetChild("Position" .. i .. "/" .. str .. "/Grey")
    self._posChilds[i].panel:Subscribe_PointerClickEvent(function()
      self:OnSkillNodeClick(i)
    end)
  end
end

function CharacterSkillRowCell:OnDestroy()
end

function CharacterSkillRowCell:Init(delegate, index, data)
  self._delegate = delegate
  self._index = index
  if data then
    for i = 1, 3 do
      self._posChilds[i].panel:SetActive(data[i])
    end
  else
    for i = 1, 3 do
      self._posChilds[i].panel:SetActive(false)
    end
  end
  self._indexTxt_Normal:SetText(index)
  self._indexTxt_AllUnlock:SetText(index)
end

function CharacterSkillRowCell:Refresh(nodeRecord)
  local posList = string.split(nodeRecord.position, ";")
  local column = tonumber(posList[2])
  local nodeChild = self._posChilds[column]
  local skillId = nodeRecord.skillID
  local skill
  if NekoData.BehaviorManager.BM_Game:IsSkillItemId(skillId) then
    skill = Skill.Create(skillId)
    skill:SetLevel(nodeRecord.skillLevel)
  else
    skill = Skill.Create(skillId, true)
  end
  local type = skill:GetType()
  local map = nodeChild.skillPanels[type]
  local imgRecord = skill:GetSkillIcon()
  map.icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  local lv = skill:GetSkillLevel()
  local maxLv = skill:GetSkillMaxLevel()
  if type == Skill.Type.Active then
    map.lvMaxFrame:SetActive(lv >= maxLv)
    map.lv:SetText(lv)
  elseif type == Skill.Type.Charging then
    map.lvMaxFrame:SetActive(lv >= maxLv)
    map.lv:SetText(lv)
  elseif type == Skill.Type.Passive then
    imgRecord = CImagePathTable:GetRecorder(12619) or DataCommon.DefaultImageAsset
    map.icon:SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    map.lvMaxFrame:SetActive(lv >= maxLv)
    map.lv:SetText(lv)
  elseif type == Skill.Type.Attribute then
  end
  for k, v in pairs(nodeChild.skillPanels) do
    v.skillPanel:SetActive(k == type)
  end
  map.select:SetActive(nodeRecord.id == self._delegate._selectNodeId)
  map.grey:SetActive(not self._delegate._unlockSkillNodes[nodeRecord.id])
  nodeChild.panel_redDot:SetActive(NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(4, {
    self._delegate._role:GetId(),
    nodeRecord.id
  }) > 0)
  if not self._nodeColumnMap[column] then
    self._nodeColumnMap[column] = {
      nodeRecord = nodeRecord,
      skill = skill,
      type = type
    }
  end
end

function CharacterSkillRowCell:AllSkillNodesRefreshFinished()
  local allUnlock = true
  for k, v in pairs(self._nodeColumnMap) do
    if not self._delegate._unlockSkillNodes[v.nodeRecord.id] then
      allUnlock = false
      break
    end
  end
  self._indexBack_Normal:SetActive(not allUnlock)
  self._indexTxt_Normal:SetActive(not allUnlock)
  self._indexBack_AllUnlock:SetActive(allUnlock)
  self._indexTxt_AllUnlock:SetActive(allUnlock)
end

function CharacterSkillRowCell:OnSkillNodeClick(skillNodeIndex)
  self._delegate:SelectSkillNode(self._nodeColumnMap[skillNodeIndex].nodeRecord.id)
end

function CharacterSkillRowCell:OnEvent(eventName)
  if eventName == "SetSelected" then
    for k, v in pairs(self._nodeColumnMap) do
      local nodeChild = self._posChilds[k]
      local nodeRecord = v.nodeRecord
      nodeChild.skillPanels[v.type].select:SetActive(nodeRecord.id == self._delegate._selectNodeId)
    end
  elseif eventName == "RefreshRedDot" then
    for k, v in pairs(self._nodeColumnMap) do
      local nodeChild = self._posChilds[k]
      local nodeRecord = v.nodeRecord
      nodeChild.panel_redDot:SetActive(NekoData.BehaviorManager.BM_RedPoint:GetRedPointNum(4, {
        self._delegate._role:GetId(),
        nodeRecord.id
      }) > 0)
    end
  end
end

return CharacterSkillRowCell
