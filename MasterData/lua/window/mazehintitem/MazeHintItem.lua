local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local SE = require("Common/SkillEffect")
local TU = require("Common/TextUtil")
local m_allList = {}
local m_notHasEventList, m_eventList, m_hollowList, m_notHasHollowList
local m_allAbilityList = {}
local m_abilityList, m_researchLevel, m_index, m_type, m_data, m_maxLevel, m_relicList, m_mazeActivityId

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.ButtonRight, function()
    m_index = m_index + 1
    RefreshWindow()
  end)
  WU.BindButtonEvent(REF.ButtonLeft, function()
    m_index = m_index - 1
    RefreshWindow()
  end)
  WU.BindButtonEvent(REF.ButtonUnlock, OnClickUnlock)
  local allAbilityList = PB.all("MazeAbilityResearch")
  table.copy(allAbilityList, m_allAbilityList, true)
  m_maxLevel = allAbilityList[#allAbilityList].level
end

function InitWindow()
  m_mazeActivityId = this:GetData("MazeActivityId")
  m_index = 0
  m_data = {}
  this:BindRemote(DB:GameRequest("fci/Maze/Research/" .. m_mazeActivityId .. "/"), OnRefreshData)
end

function OnRefreshData(result)
  if result then
    OnRefreshAbilitys(result.researchAbility)
    m_researchLevel = result.researchLevel
  end
end

function OnRefreshAbilitys(result)
  if result then
    m_abilityList = {}
    for i = 1, #m_allAbilityList do
      local index = table.find(m_abilityList, function(k, v)
        return v.type == m_allAbilityList[i].type
      end)
      if index == nil then
        local temp = {}
        table.copy(m_allAbilityList[i], temp, true)
        table.insert(m_abilityList, temp)
      end
    end
    for i = 1, #m_abilityList do
      if result[m_abilityList[i].type] then
        m_abilityList[i].progress = result[m_abilityList[i].type]
        local _, abilityInfo = table.find(m_allAbilityList, function(k, v)
          if v.level == nil then
            v.level = 0
          end
          return v.type == m_abilityList[i].type and v.level == m_abilityList[i].progress
        end)
        m_abilityList[i].levelupCost = abilityInfo.levelupCost
      else
        m_abilityList[i].progress = 0
      end
    end
  end
end

function SetAbility(data)
  if data then
    local index = table.find(m_abilityList, function(k, v)
      return v.type == data.type
    end)
    if index then
      m_index = index
      RefreshWindow()
    else
      error("MazeAbilityLevelUp has no this ability type " .. data.type)
    end
  end
end

function RefreshWindow()
  if m_index > #m_abilityList then
    m_index = 1
  elseif m_index < 1 then
    m_index = #m_abilityList
  end
  local data = m_abilityList[m_index]
  m_data = data
  REF.LabelProgress.gameObject:SetActive(false)
  REF.LabelLevel.UILabel.text = "Lv." .. data.progress
  REF.SpriteExplore.UISprite.spriteName = "explore_skill_" .. data.type
  REF.LabelEventTitle.UILabel.text = WU.GetString("Maze_AbilityName_" .. data.type)
  REF.LabelDescEvent.UIHtmlLabel.text = WU.GetString("Maze_AbilityDesc_" .. data.type)
  if data.progress < m_maxLevel then
    REF.LabelCost.ResourcePrinter:SetResource(data.levelupCost[1].type, 0, data.levelupCost[1].count)
  end
  REF.LabelHasUnlock.gameObject:SetActive(data.progress == m_maxLevel)
  REF.NodeCost.gameObject:SetActive(data.progress < m_maxLevel)
  REF.ButtonUnlock.gameObject:SetActive(data.progress < m_maxLevel)
end

function OnClickUnlock()
  WU.TryToPay(m_data.levelupCost[1].type, 0, m_data.levelupCost[1].count, function()
    this:GameRequest("fci/Maze/Research/" .. m_mazeActivityId .. "/"):Post({
      abilityType = m_data.type
    }, function(result)
      if result then
        DBH.ResChange(result.resChange)
        REF.Effect.EffectGenerator:Reset()
        REF.Effect.EffectGenerator:Play()
        CS.SoundManager.Instance:PlaySound("Sound/system/s_System_Reward")
        this:SetData("fci/Maze/Research/" .. m_mazeActivityId .. "/", result)
        RefreshWindow()
      end
    end)
  end)
end
