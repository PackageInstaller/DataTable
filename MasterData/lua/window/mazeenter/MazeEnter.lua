local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local DBH = require("Manager/DataBindingHandler")
local m_mazeList, m_level, m_index, m_init, m_texturePortrait, m_effectScene, m_hollowCount, m_resMazePointCount, m_mazeActivityId, m_mazePassedList

function SetupWindow()
  WU.BindButtonEvent(REF.SpriteLeft, function()
    if 1 < m_index then
      m_index = m_index - 1
    end
    Refresh()
  end)
  WU.BindButtonEvent(REF.SpriteRight, function()
    if m_index < #m_mazeList then
      m_index = m_index + 1
    end
    Refresh()
  end)
  WU.BindButtonEvent(REF.SpriteBg, function()
    OnEnter(m_mazeList[m_index])
  end)
  WU.BindButtonEvent(REF.ButtonTechStudy, OnClickTechStudy)
  WU.BindButtonEvent(REF.ButtonResource1, function()
    WU.ShowItemDetail(80007)
  end)
  WU.BindButtonEvent(REF.ButtonResource2, function()
    WU.ShowItemDetail(80008)
  end)
end

function InitWindow()
  WU.ActiveByNeverClick(REF.MazeGetArmTip)
  if WU.GetGameDataCache("Maze/BalanceAllB4" .. DB:GetData("playerId")) then
    WU.ActiveByNeverClick(REF.MazeResearchTip)
  else
    REF.MazeResearchTip.gameObject:SetActive(false)
  end
  m_mazePassedList = this:GetData("mazePassedIds") or {}
  m_mazeActivityId = this:GetData("MazeActivityId")
  m_mazeList = _ENV["!"]({})
  local mazeAll = PB.all("MazeInfo")
  for i = 1, #mazeAll do
    if mazeAll[i].activityId == m_mazeActivityId then
      table.insert(m_mazeList, mazeAll[i])
    end
  end
  REF.NodeLeft.gameObject:SetActive(false)
  REF.NodeRight.gameObject:SetActive(false)
  REF.LabelLevel.gameObject:SetActive(false)
  REF.NodeLeftDown.gameObject:SetActive(false)
  m_init = true
  local baseInfo = this:GetData("fci/baseinfo/")
  this:BindRemote(DB:GameRequest("fci/Maze/Research/" .. m_mazeActivityId .. "/"), OnRefreshData)
  this:Bind("fci/resource/ResMazePoint_0", OnSetResMazePoint)
  m_level = baseInfo.level
  REF.LabelResource1.ResourcePrinter:SetResource(11, 80007)
  REF.LabelResource2.ResourcePrinter:SetResource(11, 80008)
  SetEnterState()
end

function SetEnterState()
  for i = 1, #m_mazeList do
    if m_level >= m_mazeList[i].unlockLevel then
      m_mazeList[i].canGetIn = true
    else
      m_mazeList[i].canGetIn = false
    end
  end
  m_index = 1
  if m_mazePassedList == nil or table.empty(m_mazePassedList) then
    m_index = 1
  else
    for i = 1, #m_mazeList do
      if m_mazeList[i].canGetIn == true and (table.has(m_mazePassedList, m_mazeList[i].id) or m_mazeList[i].id == m_mazePassedList[#m_mazePassedList] + 1) then
        m_index = i
      else
        break
      end
    end
  end
  Refresh()
end

function Refresh()
  if m_init == true then
    this:DelayInvokeInSeconds(0.25, function()
      REF.EffectLeft.EffectGenerator:Reset()
      REF.EffectRight.EffectGenerator:Reset()
      RefreshArrow()
    end)
    m_init = false
  else
    RefreshArrow()
  end
  RefreshScene()
end

function RefreshScene()
  REF.TextureLock.gameObject:SetActive(false)
  m_texturePortrait = WU.AcquireAsset("Texture/ChaoticSpace/ChaoticSpace_scene_" .. m_index)
  REF.LabelLevel.gameObject:SetActive(false)
  REF.EffectScene.EffectGenerator:Reset()
  REF.EffectSceneFront.EffectGenerator:Reset()
  this:DelayInvokeInSeconds(0.2, function()
    REF.LabelLevel.UILabel.text = WU.GetString("Maze_EnterDifficulty", m_mazeList[m_index].difficulty)
    REF.LabelLevel.gameObject:SetActive(true)
    REF.TextureLock.gameObject:SetActive(not GetUnLocked())
  end)
  m_effectScene = reRef(REF.EffectScene)
  m_effectScene.scene.MeshRenderer.material:SetTexture("_MainTex", m_texturePortrait)
end

function GetUnLocked()
  local isUnLock = true
  if m_mazePassedList == nil or table.empty(m_mazePassedList) then
    isUnLock = m_mazeList[m_index].canGetIn == true and m_index == 1
  else
    isUnLock = m_mazeList[m_index].canGetIn == true and (table.has(m_mazePassedList, m_mazeList[m_index].id) or m_mazeList[m_index].id == m_mazePassedList[#m_mazePassedList] + 1)
  end
  return isUnLock
end

function RefreshArrow()
  if m_index == 1 then
    REF.NodeLeft.gameObject:SetActive(false)
    REF.NodeRight.gameObject:SetActive(true)
  elseif m_index == #m_mazeList then
    REF.NodeLeft.gameObject:SetActive(true)
    REF.NodeRight.gameObject:SetActive(false)
  else
    REF.NodeLeft.gameObject:SetActive(true)
    REF.NodeRight.gameObject:SetActive(true)
  end
  REF.EffectLeft.EffectGenerator:Play()
  REF.EffectRight.EffectGenerator:Play()
end

function OnEnter(info)
  local baseInfo = this:GetData("fci/baseinfo/")
  if baseInfo.level < info.unlockLevel then
    WU.ShowHintText(WU.GetString("LocalMaze_Tips10"))
    return
  end
  this:SetData("fci/MazeId/" .. m_mazeActivityId .. "/", info.id)
  if IsTicketEnough(m_mazeList[m_index].cost) then
    if GetUnLocked() then
      WU.SetClickB4(REF.MazeGetArmTip)
      WU.AcquireWindowAsync("MazeNewTeam")
    else
      WU.ShowHintText(WU.GetString("Error_MazeMazeIdNotUnlock"))
      return
    end
  end
end

function OnClickTechStudy()
  WU.SetClickB4(REF.MazeResearchTip)
  WU.AcquireWindowAsync("MazeTechStudy")
end

function OnRefreshData(result)
  if result then
    m_hollowCount = #result.unlockedHollows
    REF.LabelRelicCount.UILabel.text = m_hollowCount
    REF.LabelLevelCount.UILabel.text = WU.GetString("Window_Level", result.researchLevel)
    this:DelayInvokeInSeconds(0.7, function()
      REF.NodeLeftDown.gameObject:SetActive(true)
    end)
  end
end

function OnSetResMazePoint(result)
  m_resMazePointCount = result
  REF.LabelPointCount.UILabel.text = m_resMazePointCount
end

function IsTicketEnough(cost)
  local info = this:GetData("fci/item/" .. cost.id)
  if info == nil or info.count < cost.count then
    WU.ShowHintText(WU.GetString("Maze_TicketNotEnough"))
    return false
  end
  return true
end
