local WU, DB = require("Common/WindowUtil")()
local PB = require("Common/PbHelper")
local DU = require("Common/DungeonUtil")
local S = require("Common/Singleton"):Register(_ENV, "TutorialManager")
local m_configDataManager = S:Get("ConfigDataManager")
local m_tutorialsWhenWindowShow = {}
local m_tutorialsWhenWindowOpen = {}
local m_tutorialsWhenWindowClose = {}
local m_allTutorial, m_curTutorial, m_curStep, m_stepIndex, m_curScene, m_contextWindow
local m_navWindow = "Back"
local m_view
local m_clickedTarget = true
local m_selectedGroupId, TlogEntry
TestSwitch = true
Enable = true

function Start()
  this:RegisterGameEvent("Tutorial/StepReady", OnStepReady)
  this:RegisterGameEvent("Tutorial/StepDone", OnStepDone)
  this:RegisterGameEvent("GameRequestDone", OnGameRequestDone)
  this:RegisterGameEvent("SceneAwake", OnSceneAwake)
  this:RegisterGameEvent("UI/WindowInited", OnWindowInited)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  this:RegisterGameEvent("Tutorial/TriggerTutorial", ForceTriggerTutorial)
  this:Bind("SceneContext/SceneCity", OnSceneCityConextChange)
  this:Bind("NavigationContext", OnWindowShow)
  this:Bind("fci/tutorial/", OnTutorialStatusChange)
  CategoriseTutorialWindow()
  TlogEntry = table.where(PB.all("TutorialStep"), function(k, v)
    return v.id == 1000
  end)
end

function OnDestroy()
end

function OnStepReady()
  info("TutorialManager", "On StepReady, m_view == nil:" .. tostring(m_view == nil))
  if m_curStep ~= nil then
    if m_curStep.id == 2 and m_curStep.step == 121 or m_curStep.id == 3 and m_curStep.step == 91 or m_curStep.id == 21 and m_curStep.step == 111 or m_curStep.id == 22 and m_curStep.step == 121 or m_curStep.id == 27 and m_curStep.step == 171 or m_curStep.id == 24 and m_curStep.step == 171 or m_curStep.id == 56 and m_curStep.step == 71 then
      return
    end
    if m_view ~= nil then
      info("TutorialManager", "view not nil, start show tutorial")
      m_view["$$Show"](m_curStep, true)
    else
      info("TutorialManager", "view is nil, acquire it !")
      WU.AcquireWindowAsync("Tutorial", function(ui)
        m_view = _ENV["$"](ui)
        m_view["$$Show"](m_curStep, false)
      end)
    end
    if m_curStep.id == 10 then
      CS.GameTime.timeScale = 0
    end
  else
    info("TutorialManager", "Tutorial/StepStart, nil")
    this:BroadcastGameEvent("Tutorial/StepStart", nil)
  end
end

function Update()
  if m_view ~= nil and CS.UnityEngine.Input.GetMouseButtonDown(0) and m_curScene == "SceneFight" and IsFightTutorial() and (not m_curStep or m_curStep.id ~= 24 or m_curStep.step ~= 171) then
    m_view["$$TryToJumpForceTutorial"](true)
  end
end

function OnStepDone()
  info("TutorialManager", "On OnStepDone")
  if m_curStep ~= nil then
    if m_curStep.id == 21 and m_curStep.step == 111 or m_curStep.id == 22 and m_curStep.step == 121 or m_curStep.id == 27 and m_curStep.step == 171 or m_curStep.id == 24 and m_curStep.step == 171 or m_curStep.id == 101 and m_curStep.step == 51 or m_curStep.id == 102 and m_curStep.step == 51 or m_curStep.id == 103 and m_curStep.step == 51 or m_curStep.id == 104 and m_curStep.step == 41 or m_curStep.id == 105 and m_curStep.step == 41 or m_curStep.id == 106 and m_curStep.step == 41 then
      return
    end
    DoTutorial()
  end
end

function OnGameRequestDone(uri)
  if m_curStep ~= nil and m_curStep.Indicator ~= nil and not m_curStep.Indicator:IsNull() and uri == m_curStep.Indicator.Uri then
    DoTutorial()
  end
end

function OnSceneAwake(scene)
  m_curScene = scene
  m_curTutorial = nil
  m_view = nil
end

function OnWindowInited(window)
  if not (Enable and TestSwitch) or m_allTutorial == nil then
    return
  end
  if window.name == "GachaResult" or window.name == "ActivityStageChoose2" or window.name == "ActorGroup" then
    return
  end
  if m_curStep ~= nil and window.name == m_curStep.whenOpenWindow and m_view ~= nil then
    m_view["$$NextTalk"]()
    return
  end
  local isNavWindowValid = m_navWindow == "Back" or m_navWindow == window.name
  if isNavWindowValid and m_curTutorial == nil and CheckContextWindow(window.name) then
    local steps = m_tutorialsWhenWindowOpen[window.name]
    if steps ~= nil then
      TriggerTutorial(steps)
    end
  end
end

function OnWindowUninited(window)
  if not (Enable and TestSwitch) or m_allTutorial == nil then
    return
  end
  if window.name == "Tutorial" then
    m_view = nil
  end
  if m_curStep ~= nil and window.name == m_curStep.whenCloseWindow and m_view ~= nil and (m_curStep.whenShowWindow == "" or m_curStep.whenShowWindow == this:GetData("NavigationContext")) then
    m_view["$$NextTalk"]()
    return
  end
  local isNavWindowValid = m_navWindow == "Back"
  if isNavWindowValid and m_curTutorial == nil then
    local steps = m_tutorialsWhenWindowClose[window.name]
    if steps ~= nil then
      local windowValidSteps = steps:where(function(k, v)
        return v.whenShowWindow == this:GetData("NavigationContext")
      end)
      if windowValidSteps ~= nil then
        TriggerTutorial(windowValidSteps)
      end
    end
  end
end

function OnWindowShow(name)
  if not TestSwitch or name == nil or name == "" or m_allTutorial == nil then
    return
  end
  local isNavWindowValid = m_navWindow == "Back" or m_navWindow == name
  if name == m_navWindow then
    m_navWindow = "Back"
  end
  if m_curStep ~= nil and name == m_curStep.whenShowWindow and m_curStep.whenCloseWindow == "" and m_view ~= nil then
    m_view["$$NextTalk"]()
    return
  end
  if m_curTutorial ~= nil and not m_curStep.force and not m_clickedTarget and (name ~= m_curStep.whenShowWindow or name ~= m_curStep.whenOpenWindow) then
    EndTutorial()
  end
  if m_curTutorial == nil and isNavWindowValid and CheckContextWindow(name) then
    local steps = m_tutorialsWhenWindowShow[name]
    if steps ~= nil then
      local windowValidSteps = steps:where(function(k, v)
        return v.whenCloseWindow == "" or v.whenCloseWindow == "ManualBoxActor"
      end)
      if windowValidSteps ~= nil then
        TriggerTutorial(windowValidSteps)
      end
    end
  end
end

function SetNavigation(name)
  m_navWindow = name
end

function OnSceneCityConextChange(context)
  m_contextWindow = context
  if m_contextWindow ~= nil then
    m_contextWindow = context:split(",")
    table.insert(m_contextWindow, 1, "City")
    for i, s in pairs(m_contextWindow) do
      m_contextWindow[i] = s:trim()
    end
  end
end

function CheckContextWindow(window)
  if m_contextWindow == nil then
    return true
  else
    local index, win = _ENV["!"](m_contextWindow):find(function(k, v)
      return v == window
    end)
    return index == nil or index == #m_contextWindow
  end
end

function OnTutorialStatusChange(result)
  if result == nil then
    return
  end
  local forceTutorials = {}
  for _, t in pairs(result) do
    if t.id < 1000 then
      table.insert(forceTutorials, t)
    end
  end
  table.sort(forceTutorials, function(a, b)
    return a.sequence < b.sequence
  end)
  local _, next = _ENV["!"](forceTutorials):find(function(k, v)
    return v.status == PB.enum.TutorialStatus.Undone
  end)
  if next == nil then
    Enable = false
    this:SetData("CurrentTutorial", -1)
  end
  if Enable and TestSwitch then
    this:SetData("CurrentTutorial", next.id)
  end
  m_allTutorial = _ENV["!"]({})
  for _, t in pairs(forceTutorials) do
    m_allTutorial[t.id] = t
  end
  this:BindRemote(DB:GameRequest("fci/SelectedGroupId/StoryMode/"), function(data)
    if data == nil then
      return
    end
    m_selectedGroupId = data.selectActorGroupId
    if m_selectedGroupId == 0 then
      m_selectedGroupId = 1
    end
  end)
end

function GetSkipCount()
  return m_configDataManager.GetPreferences().skipTutorial
end

function SetSkipCount(count)
  local preferences = m_configDataManager.GetPreferences()
  preferences.skipTutorial = count
  m_configDataManager.SetPreferences(preferences)
end

function IsTutorialUIShowing()
  return m_view ~= nil and m_view["$$IsTutorialUIShowing"]()
end

function IsFightTutorial(id)
  if id == nil then
    id = this:GetData("CurrentTutorial")
  end
  local fightIds = _ENV["!"]({
    2,
    3,
    8,
    9,
    10,
    21,
    22,
    23,
    24,
    25,
    26,
    27
  })
  return fightIds:has(id)
end

function IsTrainingTutorial(id)
  local dungeonId = this:GetData("WindowDungeon/DungeonId")
  if id == 101 then
    local normalChapter = this:GetData("fci/dungeon/chapter/1")
    return normalChapter.recordDungeons[2]
  elseif dungeonId == 5 and id == 102 then
    return true
  elseif dungeonId == 7 and id == 103 then
    return true
  elseif dungeonId == 9 and id == 104 then
    return true
  elseif dungeonId == 13 and id == 105 then
    return true
  elseif dungeonId == 15 and id == 106 then
    return true
  end
  return false
end

function IsTutorialDoing()
  local curId = this:GetData("CurrentTutorial")
  return TestSwitch and curId ~= nil and 0 < curId
end

function IsForceTutorialDone()
  local forceIds = {
    1,
    2,
    3,
    5,
    7,
    14,
    99,
    21,
    22,
    23,
    24,
    27,
    30,
    31
  }
  local done = true
  for _, id in pairs(forceIds) do
    if m_allTutorial[id].status == PB.enum.TutorialStatus.Undone then
      done = false
      break
    end
  end
  return not TestSwitch or done
end

function IsTutorialDone(id)
  if m_allTutorial[id] then
    return m_allTutorial[id].status == PB.enum.TutorialStatus.Done
  else
    warning("data not match between server and client!")
    return true
  end
end

function DoTutorial()
  info("TutorialManager", "DoTutorial id:" .. m_curStep.id .. " step:" .. m_curStep.step)
  if m_curStep.id == 10 then
    CS.GameTime.timeScale = 1
  end
  if m_allTutorial[m_curStep.id].status == PB.enum.TutorialStatus.Undone then
    this:GameRequest("fci/tutorial/" .. m_curStep.id .. "/" .. m_curStep.step):Post()
  end
  m_stepIndex = m_stepIndex + 1
  local next = m_curTutorial[m_stepIndex]
  if next == nil then
    TutorialDone(m_curStep.id)
    local todoId
    if m_curStep.id == 17 then
      todoId = 18
    elseif m_curStep.id == 18 then
      todoId = 17
    elseif m_curStep.id == 19 then
      todoId = 20
    end
    if todoId ~= nil then
      TutorialDone(todoId)
    end
  elseif m_curStep.endFlag then
    TutorialDone(m_curStep.id, false, true)
  end
  if m_curStep.id == 19 and m_curStep.step == 31 then
    WU.AcquireWindowAsync("SakuGuide", function(win)
      _ENV["$"](win)["$$SetContent"](WU.GetString("Tutorial_Arm"), WU.GetString("Tutorial_Arm_Enter"), WU.GetString("Tutorial_Arm_Back"), enterArmTutorial, exitArmTutorial)
    end)
  end
  if m_curStep.id == 15 and m_curStep.step == 11 or m_curStep.id == 15 and m_curStep.step == 21 or m_curStep.id == 23 and m_curStep.step == 21 then
    EndTutorial()
    next = nil
  end
  if next == nil then
    EndTutorial()
    this:BroadcastGameEvent("Tutorial/StepStart", nil)
    info("TutorialManager", "no next, end")
  elseif m_curStep.Indicator == nil or m_curStep.Indicator:IsNull() or m_curStep.Indicator.Target == nil or WaitForReady() then
    info("TutorialManager", "hide tutorial, waiting ready event")
    m_view["$$ToggleTutorial"](false)
    m_curStep.Indicator = nil
    m_curStep = next
  else
    m_curStep.Indicator = nil
    m_curStep = next
    m_view["$$Show"](m_curStep, true)
  end
end

function WaitForReady()
  return m_curStep.id == 100 and m_curStep.step == 101 or m_curStep.id == 100 and m_curStep.step == 121
end

function TutorialDone(id, force, hasNext)
  force = fif(force == nil, false, true)
  if m_allTutorial[id].status == PB.enum.TutorialStatus.Undone then
    if not hasNext then
      m_allTutorial[id].status = PB.enum.TutorialStatus.Done
    end
    this:GameRequest("fci/tutorial/" .. id):Put({status = 1, stepForceFinish = force}, nil, function(result)
      m_allTutorial[id].status = PB.enum.TutorialStatus.Undone
    end)
  end
  SetSkipCount(0)
  if id == 25 then
    local steps = m_tutorialsWhenWindowShow.FightRound
    TriggerTutorial(steps)
  end
end

function EndTutorial(skip)
  info("TutorialManager", "end tutorial")
  if not skip and m_curStep and (m_curStep.id == 23 and m_curStep.step == 21 or m_curStep.id == 27 and m_curStep.step == 21) then
    this:SetData("TutorialLevel13", true)
  end
  m_curTutorial = nil
  m_curStep = nil
  this:SetData("CurrentTutorial", -1)
  if m_view ~= nil then
    m_view["$$ToggleTutorial"](false)
  end
  CS.GameTime.timeScale = 1
end

function Skip()
  local count = GetSkipCount()
  if count == nil then
    count = 0
  end
  info("Tutorial", "jump force tutorial, count:" .. tostring(count))
  this:SetData("TutorialLevel13", false)
  local id = m_curStep.id
  EndTutorial(true)
  SetSkipCount(count + 1)
  if count == 0 then
    if IsFightTutorial(id) and m_curScene == "SceneFight" then
      DU.Restart()
    elseif id == 23 then
      WU.ReturnCity("")
    else
      local top = WU.TopWindow()
      if top and top.name == "City" then
        OnWindowShow("City")
      else
        SetNavigation("City")
        this:BroadcastGameEvent("OnNavigation", "City")
      end
    end
  elseif count == 1 then
    CS.GameGlobal.Instance:ResetGame()
  elseif count == 2 then
    TutorialDone(id, true)
    if id == 23 then
      WU.ReturnCity("")
    end
  end
end

function SkipAll()
  for _, t in pairs(m_allTutorial) do
    if t.status == PB.enum.TutorialStatus.Undone then
      TutorialDone(t.id, true)
    end
  end
  EndTutorial(true)
end

function TriggerTutorial(steps)
  info("TutorialManager", table.dump(steps))
  local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
  local _, validStep = steps:find(FindValidStep)
  if validStep ~= nil then
    if (this:GetData("CurrentTutorial") == 1 or this:GetData("CurrentTutorial") == 99) and (validStep.id ~= 1 or validStep.id ~= 99) then
      return
    end
    this:SetData("CurrentTutorial", validStep.id)
    info("TutorialManager", "trigger valid step" .. table.dump(validStep))
    m_curTutorial = PB.all("TutorialStep"):where(function(k, v)
      return v.id == validStep.id
    end):toarray()
    table.sort(m_curTutorial, function(a, b)
      return a.step < b.step
    end)
    m_stepIndex, m_curStep = m_curTutorial:find(function(k, v)
      return v.step == validStep.step
    end)
    m_view = _ENV["$"](WU.AcquireWindow("Tutorial"))
    if m_curScene ~= "SceneFight" or m_curStep.id == 26 then
      info("TutorialManager", "show tutorial")
      m_view["$$Show"](m_curStep, false)
    else
      info("TutorialManager", "hide tutorial wait ready event, m_view == nil:" .. tostring(m_view == nil))
      m_view["$$ToggleTutorial"](false)
    end
  else
    this:SetData("CurrentTutorial", -1)
  end
end

function FindValidStep(_, step)
  if m_allTutorial[step.id].status == PB.enum.TutorialStatus.Undone then
    return IsAvaliable(step.id)
  end
  return false
end

function IsAvaliable(id)
  local storyChapter = this:GetData("fci/dungeon/chapter/1001")
  local normalChapter = this:GetData("fci/dungeon/chapter/1")
  local normalChapter2 = this:GetData("fci/dungeon/chapter/2")
  local level = this:GetData("fci/baseinfo/").level
  if (id == 99 or id == 21 or id == 22 or id == 23 or id == 24 or id == 27 or id == 101 or id == 32 or id == 51 or id == 52 or id == 101 or id == 102 or id == 103) and normalChapter2 and normalChapter2.recordDungeons[9] then
    TutorialDone(id, true)
    return false
  end
  if (id == 104 or id == 28 or id == 105 or id == 106 or id == 55 or id == 56 or id == 57 or id == 58 or id == 59 or id == 28 or id == 25 or id == 26 or id == 34 or id == 41) and normalChapter2 and normalChapter2.recordDungeons[16] then
    TutorialDone(id, true)
    return false
  end
  if id == 2 then
    if storyChapter.recordDungeons[2013] then
      TutorialDone(2, true)
      return false
    end
    return storyChapter.recordDungeons[2012] ~= nil
  elseif id == 3 then
    if storyChapter.recordDungeons[2013] then
      TutorialDone(3, true)
      return false
    end
    return storyChapter.recordDungeons[2013] ~= nil
  elseif id == 5 then
    local gachaCost = PB.get("GachaType", 1).cost
    local item = this:GetData("fci/item/" .. gachaCost.id)
    return item ~= nil and item.count >= 10
  elseif id == 7 then
    local gachaTutorialDone = m_allTutorial[5].status == PB.enum.TutorialStatus.Done
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local unlocked = _ENV["!"](chapterInfo.finishedChapterId):has(1001)
    local subActors = _ENV["!"](this:GetData("fci/actor")):where(function(k, v)
      return PB.get("ActorConfig", v.id).kind == PB.enum.ActorType.Sub
    end)
    return gachaTutorialDone and unlocked and 2 <= subActors:count()
  elseif id == 8 then
    local unlocked = not WU.WindowIsLocked(PB.enum.UnlockWindow.AutoFight)
    local isNormalDungeon = this:GetData("FightDungeonType") == PB.enum.DungeonType.Normal
    return unlocked and isNormalDungeon
  elseif id == 9 then
    local dungeonId = this:GetData("WindowDungeon/DungeonId")
    return dungeonId == 4
  elseif id == 10 then
    local dungeonType = this:GetData("FightDungeonType")
    if dungeonType == PB.enum.DungeonType.Normal then
      local auto_val
      local autoData = this:GetData("fci/autoFightSetting/")
      if autoData ~= nil then
        auto_val = autoData["1"]
      end
      if auto_val ~= nil then
        return 1 << tonumber(dungeonType) & auto_val ~= 0
      end
      return false
    end
    return false
  elseif id == 11 then
    local dungeonId = this:GetData("WindowDungeon/DungeonId")
    return dungeonId == 6
  elseif id == 12 then
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local isUnlocked
    DU.IsDungeonUnlocked(chapterInfo, 5001, function(unlocked)
      isUnlocked = unlocked
    end)
    return isUnlocked
  elseif id == 13 then
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local isUnlocked
    DU.IsDungeonUnlocked(chapterInfo, 5102, function(unlocked)
      isUnlocked = unlocked
    end)
    return isUnlocked
  elseif id == 14 then
    local locked = WU.WindowIsLocked(PB.enum.UnlockWindow.ActivityStageChoose2)
    local power = this:GetData("fci/resource/ResPlayerPower_0") or 0
    return not locked and 12 <= power
  elseif id == 15 then
    return not WU.WindowIsLocked(PB.enum.UnlockWindow.ActivityStageChoose2)
  elseif id == 16 then
    local freeReName = not this:GetData("fci/name/").notFirstRename
    return freeReName and this:GetData("fci/baseinfo").level >= PB.all("Misc")[1].modifyNameTutorialLevel
  elseif id == 17 then
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local isFinished
    DU.IsDungeonFinished(chapterInfo, 6, function(finished)
      isFinished = finished
    end)
    return isFinished
  elseif id == 18 then
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local isFinished
    DU.IsDungeonFinished(chapterInfo, 6, function(finished)
      isFinished = finished
    end)
    return isFinished
  elseif id == 19 then
    local arm = this:GetData("fci/arms/")
    local actorUid = this:GetData("Actor/SelectedUid")
    local reachLevel = false
    local canEquip = false
    if actorUid then
      local actor = this:GetData("fci/actor/" .. actorUid)
      reachLevel = actor.level >= PB.all("Misc"):first().weaponMisc.weaponShowLevel
      local position = actor.kind
      if arm then
        canEquip = table.find(arm, function(k, v)
          return position == v.position
        end)
      end
    end
    return 0 < #arm and DB:GetData("Arm/ArmUnlock") and reachLevel and canEquip
  elseif id == 20 then
    local arms = this:GetData("fci/arms") or {}
    local oldArms = this:GetData("OldArms") or {}
    local gachaResult = this:GetData("fci/gachaResult/")
    local actors = this:GetData("fci/actor/")
    local hasArm
    if gachaResult then
      hasArm = table.find(arms, function(k, v)
        local _, actor = table.find(actors, function(key, value)
          return value.kind == v.position and value.level >= PB.all("Misc"):first().weaponMisc.weaponShowLevel
        end)
        return actor ~= nil
      end)
    end
    local armEquipDone = m_allTutorial[19].status == PB.enum.TutorialStatus.Done
    return not armEquipDone and hasArm and #oldArms == 0
  elseif id == 21 then
    if storyChapter.recordDungeons[2012] then
      TutorialDone(21, true)
      return false
    end
    return storyChapter.recordDungeons[2011]
  elseif id == 22 then
    if storyChapter.recordDungeons[2013] then
      TutorialDone(22, true)
      return false
    end
    return m_allTutorial[21].status == PB.enum.TutorialStatus.Done and storyChapter.recordDungeons[2012] ~= nil
  elseif id == 23 then
    if storyChapter.recordDungeons[2013] == nil then
      return
    end
    if normalChapter.recordDungeons[1] then
      TutorialDone(23, true)
      return false
    end
    local GetActorTutorialDone = m_allTutorial[22].status == PB.enum.TutorialStatus.Done
    local ActorGroup = this:GetData("fci/ActorGroup/")
    local DefaultActorGroup
    if ActorGroup then
      DefaultActorGroup = ActorGroup["1"]
    end
    local actors = this:GetData("fci/actor/")
    if actors then
      local _, toma = _ENV["!"](actors):find(function(k, v)
        return v.id == 2112
      end)
      if not toma then
        return false
      end
    else
      return false
    end
    if GetActorTutorialDone and DefaultActorGroup and DefaultActorGroup.members then
      for _, v in pairs(DefaultActorGroup.members) do
        if v.actorUid ~= 0 then
          local actor = this:GetData("fci/actor/" .. v.actorUid)
          if v.index == 1 and actor.id ~= 1008 then
            return false
          elseif v.index == 0 and actor.id ~= 1001 then
            return false
          elseif v.index == 4 and actor.id ~= 2114 then
            return false
          elseif v.index ~= 1 and v.index ~= 0 and v.index ~= 4 then
            return false
          end
        elseif v.index == 1 or v.index == 0 or v.index == 4 then
          return false
        end
      end
      return true
    else
      return false
    end
  elseif id == 27 then
    if normalChapter.recordDungeons[1] then
      TutorialDone(27, true)
      return false
    end
    return m_allTutorial[23].status == PB.enum.TutorialStatus.Done and storyChapter.recordDungeons[2013] ~= nil
  elseif id == 24 then
    if normalChapter.recordDungeons[1] == nil then
      return
    end
    if normalChapter.recordDungeons[2] ~= nil then
      TutorialDone(24, true)
      return false
    end
    if m_selectedGroupId and m_selectedGroupId ~= 1 then
      return
    end
    local preDone = m_allTutorial[27].status == PB.enum.TutorialStatus.Done
    return preDone
  elseif id == 25 then
    local unlocked = not WU.WindowIsLocked(PB.enum.UnlockWindow.AutoFight)
    local isNormalDungeon = this:GetData("FightDungeonType") == PB.enum.DungeonType.Normal
    return unlocked and isNormalDungeon
  elseif id == 26 then
    local dungeonType = this:GetData("FightDungeonType")
    if dungeonType == PB.enum.DungeonType.Normal then
      local auto_val
      local autoData = this:GetData("fci/autoFightSetting/")
      if autoData ~= nil then
        auto_val = autoData["1"]
      end
      if auto_val ~= nil then
        return 1 << tonumber(dungeonType) & auto_val ~= 0
      end
      return false
    end
    return false
  elseif id == 28 then
    if this:GetData("Chapter1Finished") then
      this:SetData("Chapter1Finished", false)
      return true
    else
      return false
    end
  elseif id == 32 then
    if normalChapter.recordDungeons[3] == nil then
      return
    end
    local gachaCost = PB.get("GachaType", 1).cost
    local item = this:GetData("fci/item/" .. gachaCost.id)
    local actors = this:GetData("fci/actor/")
    local _, kirino = table.find(actors, function(k, v)
      return v.id == 1009
    end)
    return item ~= nil and item.count >= gachaCost.count and not kirino
  elseif id == 40 then
    if normalChapter == nil or normalChapter.recordDungeons[3] == nil or normalChapter.recordDungeons[4] ~= nil or m_selectedGroupId ~= 1 then
      return
    end
    local group = this:GetData("fci/ActorGroup/")
    local actors = this:GetData("fci/actor/")
    local mainActors = _ENV["!"](this:GetData("fci/actor")):where(function(k, v)
      return v.kind == PB.enum.ActorType.Main
    end):toarray()
    local subActors = _ENV["!"](this:GetData("fci/actor")):where(function(k, v)
      return v.kind == PB.enum.ActorType.Sub
    end):toarray()
    local selectedGroup = group[tostring(m_selectedGroupId)].members
    local mainActorsInGroup = table.where(selectedGroup, function(k, v)
      return v.actorUid ~= 0 and v.index < 3
    end):toarray()
    local subActorsInGroup = table.where(selectedGroup, function(k, v)
      return v.actorUid ~= 0 and v.index > 3
    end):toarray()
    local mainAvaliable = mainActors:duplicate()
    for k, v in pairs(mainActorsInGroup) do
      local actor = this:GetData("fci/actor/" .. v.actorUid)
      mainAvaliable = mainAvaliable:where(function(key, value)
        return value.id ~= actor.id
      end)
    end
    info("TutorialManager", "id=40" .. "inGroup:" .. mainActorsInGroup:count() .. "avl:" .. mainAvaliable:count())
    local canPlaceMain = mainActorsInGroup:count() < 3 and mainAvaliable:count() > 0
    return canPlaceMain
  elseif id == 34 then
    local chapterDungeon = this:GetData("fci/dungeon/chapter/1")
    if chapterDungeon.recordChapter then
      local _, v = table.find(chapterDungeon.recordChapter.starRewardGot, function(k, v)
        return v == 0
      end)
      if v ~= nil or not chapterDungeon.recordChapter.finished then
        return false
      end
    end
    local chapterSummary = this:GetData("fci/dungeon/chapter-summary")
    local chapterInfos = PB.all("ChapterInfo"):where(function(k, v)
      return v.type == 2
    end):toarray()
    local showChapter = chapterInfos:where(function(k, v)
      return DU.IsChapterUnlocked(chapterSummary, v.chapterId)
    end):toarray()
    if #showChapter ~= 2 then
      return false
    end
    return true
  elseif id == 41 then
    local unlockLevel = PB.all("Misc"):first().unlockFightSpeedLevel
    if unlockLevel <= this:GetData("fci/baseinfo/").level then
      local dungeonId = this:GetData("WindowDungeon/DungeonId")
      if dungeonId and (dungeonId == 2 or dungeonId == 5 or dungeonId == 7 or dungeonId == 9 or dungeonId == 13 or dungeonId == 15) then
        return false
      end
      return normalChapter.recordDungeons[3]
    end
    return false
  elseif id == 51 then
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local isFinished
    DU.IsDungeonFinished(chapterInfo, 7, function(finished)
      isFinished = finished
    end)
    local mikotos = _ENV["!"](this:GetData("fci/actor/")):where(function(_, v)
      return v.id == 1001
    end):toarray()
    local mikoto = table.find(mikotos, function(_, v)
      return v.level >= 4 and v.star == 1
    end)
    local isActorLevelUp = false
    local updateItems = _ENV["!"](this:GetData("fci/item")):where(function(_, v)
      return v.funcType == PB.enum.ItemFuncType.ActorExp
    end):toarray()
    for _, v in ipairs(updateItems) do
      if v.historyGetCount ~= nil and v.count < v.historyGetCount or v.countDelta and v.countDelta < 0 then
        isActorLevelUp = true
        break
      end
    end
    if isActorLevelUp then
      TutorialDone(51, true)
      return false
    end
    return isFinished and mikoto ~= nil
  elseif id == 52 then
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local isFinished
    DU.IsDungeonFinished(chapterInfo, 7, function(finished)
      isFinished = finished
    end)
    local isActorStarLevelUp = table.find(this:GetData("fci/actor/"), function(_, v)
      return v.star > 1
    end) ~= nil
    local mikotos = _ENV["!"](this:GetData("fci/actor/")):where(function(_, v)
      return v.id == 1001
    end):toarray()
    local mikoto = table.find(mikotos, function(_, v)
      return v.level >= 5 and v.star == 1
    end)
    local item = this:GetData("fci/item/30001")
    if not item or not (item.count >= 5) then
      return false
    end
    return isFinished and mikoto ~= nil and not isActorStarLevelUp
  elseif id == 55 then
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local isFinished
    DU.IsDungeonFinished(chapterInfo, 8, function(finished)
      isFinished = finished
    end)
    return isFinished
  elseif id == 56 then
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local isFinished
    DU.IsDungeonFinished(chapterInfo, 9, function(finished)
      isFinished = finished
    end)
    local equips = this:GetData("fci/equip/") or {}
    if 0 < #equips then
      TutorialDone(56, true)
      return false
    end
    return isFinished and #equips == 0
  elseif id == 58 then
    local chapterInfo = this:GetData("fci/dungeon/chapter-summary")
    local isFinished
    DU.IsDungeonFinished(chapterInfo, 9, function(finished)
      isFinished = finished
    end)
    local actors = this:GetData("fci/actor/")
    local isEquiped = false
    for _, v in ipairs(actors) do
      if 0 < #v.bodyEquips then
        isEquiped = true
        TutorialDone(58, true)
        break
      end
    end
    local equips = this:GetData("fci/equip/") or {}
    return equips[1] and not isEquiped and isFinished
  elseif id == 59 then
    local equips = this:GetData("fci/equip/")
    local updateItems = _ENV["!"](this:GetData("fci/item")):where(function(_, v)
      return v.funcType == PB.enum.ItemFuncType.EquipExp
    end):toarray()
    warning("")
    local isUpgradeEquip = false
    for _, v in ipairs(updateItems) do
      if v.count < fif(v.historyGetCount, v.historyGetCount, v.count) then
        isUpgradeEquip = true
        break
      end
    end
    if isUpgradeEquip then
      TutorialDone(59, true)
      return false
    end
    return IsTutorialDone(58) and 0 < #updateItems and 0 < #equips
  elseif id == 100 then
    local uniqueWeaponGuide = this:GetData("uniqueWeaponTutorial")
    return uniqueWeaponGuide
  elseif 100 < id then
    return IsTrainingTutorial(id)
  else
    return true
  end
end

function CategoriseTutorialWindow()
  local allSteps = PB.all("TutorialStep")
  for _, step in pairs(allSteps) do
    local info = PB.get("Tutorial", step.id)
    if info ~= nil then
      step.sequence = info.sequence
      PutStep(m_tutorialsWhenWindowShow, step.whenShowWindow, step)
      PutStep(m_tutorialsWhenWindowOpen, step.whenOpenWindow, step)
      PutStep(m_tutorialsWhenWindowClose, step.whenCloseWindow, step)
    end
  end
  SortStep(m_tutorialsWhenWindowShow)
  SortStep(m_tutorialsWhenWindowOpen)
  SortStep(m_tutorialsWhenWindowClose)
end

function PutStep(tutorialTable, kind, step)
  if kind ~= "" then
    if tutorialTable[kind] == nil then
      tutorialTable[kind] = _ENV["!"]({})
    end
    table.insert(tutorialTable[kind], step)
  end
end

function SortStep(tutorial)
  for _, steps in pairs(tutorial) do
    table.sort(steps, function(a, b)
      if a.sequence ~= b.sequence then
        return a.sequence < b.sequence
      else
        return a.step < b.step
      end
    end)
  end
end

function GetAllTutorial()
  return m_curTutorial
end

function ForceTriggerTutorial(winName)
  if winName and TestSwitch then
    local steps = m_tutorialsWhenWindowOpen[winName]
    if steps ~= nil then
      TriggerTutorial(steps)
    end
  end
end

function enterArmTutorial()
  this:SetData("FightSelfTeam", 1)
  this:SetData("FightDungeonType", 1)
  this:SetData("WindowDungeon/DungeonId", 3101)
  this:SetData("uniqueWeaponTutorial", true)
  CS.GameGlobal.Instance:LoadGameLevel(tostring(3101), true)
  WU.RecycleWindow("SakuGuide")
end

function exitArmTutorial()
  WU.RecycleWindow("SakuGuide")
end

function OnTutorialTlog(msg)
  local playerLevel = this:GetData("fci/baseinfo/").level
  if 2 < playerLevel then
    return
  end
  if TlogEntry then
    local _, step = TlogEntry:find(function(k, v)
      return v.param == msg
    end)
    if step then
      this:GameRequest("fci/tutorial/1000/" .. step.step):Post()
    end
  end
end
