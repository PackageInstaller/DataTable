-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/characterskillrowcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Skill = require("logic.manager.experimental.types.skill")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local CharacterSkillRowCell = class("CharacterSkillRowCell", Dialog)
CharacterSkillRowCell.AssetBundleName = "ui/layouts.basecharacterinfo"
CharacterSkillRowCell.AssetName = "CharSkillNewCell"
CharacterSkillRowCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : CharacterSkillRowCell
  ((CharacterSkillRowCell.super).Ctor)(self, ...)
  self._nodeColumnMap = {}
end

CharacterSkillRowCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : Skill
  self._indexBack_Normal = self:GetChild("NumBack")
  self._indexBack_AllUnlock = self:GetChild("NumBackSelect")
  self._indexTxt_Normal = self:GetChild("Num")
  self._indexTxt_AllUnlock = self:GetChild("NumSelect")
  self._posChilds = {}
  for i = 1, 3 do
    do
      -- DECOMPILER ERROR at PC24: Confused about usage of register: R5 in 'UnsetPending'

      (self._posChilds)[i] = {}
      -- DECOMPILER ERROR at PC32: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._posChilds)[i]).panel = self:GetChild("Position" .. i)
      -- DECOMPILER ERROR at PC41: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._posChilds)[i]).panel_redDot = self:GetChild("Position" .. i .. "/RedDot")
      -- DECOMPILER ERROR at PC45: Confused about usage of register: R5 in 'UnsetPending'

      ;
      ((self._posChilds)[i]).skillPanels = {}
      -- DECOMPILER ERROR at PC52: Confused about usage of register: R5 in 'UnsetPending'

      ;
      (((self._posChilds)[i]).skillPanels)[(Skill.Type).Active] = {}
      local map = (((self._posChilds)[i]).skillPanels)[(Skill.Type).Active]
      local str = "ActiveSkill"
      map.skillPanel = self:GetChild("Position" .. i .. "/" .. str)
      map.select = self:GetChild("Position" .. i .. "/" .. str .. "/Select")
      map.icon = self:GetChild("Position" .. i .. "/" .. str .. "/Skill")
      map.lvMaxFrame = self:GetChild("Position" .. i .. "/" .. str .. "/BackFull")
      map.grey = self:GetChild("Position" .. i .. "/" .. str .. "/Grey")
      map.lv = self:GetChild("Position" .. i .. "/" .. str .. "/NumBack/Num")
      -- DECOMPILER ERROR at PC119: Confused about usage of register: R7 in 'UnsetPending'

      ;
      (((self._posChilds)[i]).skillPanels)[(Skill.Type).Charging] = {}
      local map = (((self._posChilds)[i]).skillPanels)[(Skill.Type).Charging]
      local str = "EnergySkill"
      map.skillPanel = self:GetChild("Position" .. i .. "/" .. str)
      map.select = self:GetChild("Position" .. i .. "/" .. str .. "/Select")
      map.icon = self:GetChild("Position" .. i .. "/" .. str .. "/Skill")
      map.lvMaxFrame = self:GetChild("Position" .. i .. "/" .. str .. "/BackFull")
      map.grey = self:GetChild("Position" .. i .. "/" .. str .. "/Grey")
      map.lv = self:GetChild("Position" .. i .. "/" .. str .. "/NumBack/Num")
      -- DECOMPILER ERROR at PC186: Confused about usage of register: R9 in 'UnsetPending'

      ;
      (((self._posChilds)[i]).skillPanels)[(Skill.Type).Passive] = {}
      local map = (((self._posChilds)[i]).skillPanels)[(Skill.Type).Passive]
      local str = "PassiveSkill"
      map.skillPanel = self:GetChild("Position" .. i .. "/" .. str)
      map.select = self:GetChild("Position" .. i .. "/" .. str .. "/Select")
      map.icon = self:GetChild("Position" .. i .. "/" .. str .. "/Skill")
      map.lvMaxFrame = self:GetChild("Position" .. i .. "/" .. str .. "/BackFull")
      map.grey = self:GetChild("Position" .. i .. "/" .. str .. "/Grey")
      map.lv = self:GetChild("Position" .. i .. "/" .. str .. "/NumBack/Num")
      -- DECOMPILER ERROR at PC253: Confused about usage of register: R11 in 'UnsetPending'

      ;
      (((self._posChilds)[i]).skillPanels)[(Skill.Type).Attribute] = {}
      local map = (((self._posChilds)[i]).skillPanels)[(Skill.Type).Attribute]
      local str = "PropSkill"
      map.skillPanel = self:GetChild("Position" .. i .. "/" .. str)
      map.select = self:GetChild("Position" .. i .. "/" .. str .. "/Select")
      map.icon = self:GetChild("Position" .. i .. "/" .. str .. "/Skill")
      map.grey = self:GetChild("Position" .. i .. "/" .. str .. "/Grey")
      ;
      (((self._posChilds)[i]).panel):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnSkillNodeClick(i)
  end
)
    end
  end
end

CharacterSkillRowCell.OnDestroy = function(self)
  -- function num : 0_2
end

CharacterSkillRowCell.Init = function(self, delegate, index, data)
  -- function num : 0_3
  self._delegate = delegate
  self._index = index
  if data then
    for i = 1, 3 do
      (((self._posChilds)[i]).panel):SetActive(data[i])
    end
  else
    do
      for i = 1, 3 do
        (((self._posChilds)[i]).panel):SetActive(false)
      end
      do
        ;
        (self._indexTxt_Normal):SetText(index)
        ;
        (self._indexTxt_AllUnlock):SetText(index)
      end
    end
  end
end

CharacterSkillRowCell.Refresh = function(self, nodeRecord)
  -- function num : 0_4 , upvalues : _ENV, Skill, CImagePathTable
  local posList = (string.split)(nodeRecord.position, ";")
  local column = tonumber(posList[2])
  local nodeChild = (self._posChilds)[column]
  local skillId = nodeRecord.skillID
  local skill = nil
  if ((NekoData.BehaviorManager).BM_Game):IsSkillItemId(skillId) then
    skill = (Skill.Create)(skillId)
    skill:SetLevel(nodeRecord.skillLevel)
  else
    skill = (Skill.Create)(skillId, true)
  end
  local type = skill:GetType()
  local map = (nodeChild.skillPanels)[type]
  local imgRecord = skill:GetSkillIcon()
  ;
  (map.icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  local lv = skill:GetSkillLevel()
  local maxLv = skill:GetSkillMaxLevel()
  if maxLv > lv then
    (map.lvMaxFrame):SetActive(type ~= (Skill.Type).Active)
    ;
    (map.lv):SetText(lv)
    if maxLv > lv then
      (map.lvMaxFrame):SetActive(type ~= (Skill.Type).Charging)
      ;
      (map.lv):SetText(lv)
      if type == (Skill.Type).Passive then
        if not CImagePathTable:GetRecorder(12619) then
          imgRecord = DataCommon.DefaultImageAsset
        end
        ;
        (map.icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
        ;
        (map.lvMaxFrame):SetActive(maxLv <= lv)
        ;
        (map.lv):SetText(lv)
      end
      if type == (Skill.Type).Attribute then
        for k,v in pairs(nodeChild.skillPanels) do
          (v.skillPanel):SetActive(k == type)
        end
        ;
        (map.select):SetActive(nodeRecord.id == (self._delegate)._selectNodeId)
        ;
        (map.grey):SetActive(not ((self._delegate)._unlockSkillNodes)[nodeRecord.id])
        ;
        (nodeChild.panel_redDot):SetActive(((NekoData.BehaviorManager).BM_RedPoint):GetRedPointNum(4, {((self._delegate)._role):GetId(), nodeRecord.id}) > 0)
        -- DECOMPILER ERROR at PC173: Confused about usage of register: R12 in 'UnsetPending'

        if not (self._nodeColumnMap)[column] then
          (self._nodeColumnMap)[column] = {nodeRecord = nodeRecord, skill = skill, type = type}
        end
        -- DECOMPILER ERROR: 13 unprocessed JMP targets
      end
    end
  end
end

CharacterSkillRowCell.AllSkillNodesRefreshFinished = function(self)
  -- function num : 0_5 , upvalues : _ENV
  local allUnlock = true
  for k,v in pairs(self._nodeColumnMap) do
    if not ((self._delegate)._unlockSkillNodes)[(v.nodeRecord).id] then
      allUnlock = false
      break
    end
  end
  do
    ;
    (self._indexBack_Normal):SetActive(not allUnlock)
    ;
    (self._indexTxt_Normal):SetActive(not allUnlock)
    ;
    (self._indexBack_AllUnlock):SetActive(allUnlock)
    ;
    (self._indexTxt_AllUnlock):SetActive(allUnlock)
  end
end

CharacterSkillRowCell.OnSkillNodeClick = function(self, skillNodeIndex)
  -- function num : 0_6
  (self._delegate):SelectSkillNode((((self._nodeColumnMap)[skillNodeIndex]).nodeRecord).id)
end

CharacterSkillRowCell.OnEvent = function(self, eventName)
  -- function num : 0_7 , upvalues : _ENV
  if eventName == "SetSelected" then
    for k,v in pairs(self._nodeColumnMap) do
      local nodeChild = (self._posChilds)[k]
      local nodeRecord = v.nodeRecord
      ;
      (((nodeChild.skillPanels)[v.type]).select):SetActive(nodeRecord.id == (self._delegate)._selectNodeId)
    end
  elseif eventName == "RefreshRedDot" then
    for k,v in pairs(self._nodeColumnMap) do
      local nodeChild = (self._posChilds)[k]
      local nodeRecord = v.nodeRecord
      ;
      (nodeChild.panel_redDot):SetActive(((NekoData.BehaviorManager).BM_RedPoint):GetRedPointNum(4, {((self._delegate)._role):GetId(), nodeRecord.id}) > 0)
    end
  end
  -- DECOMPILER ERROR: 6 unprocessed JMP targets
end

return CharacterSkillRowCell

