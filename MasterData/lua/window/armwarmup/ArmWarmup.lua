local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local TU = require("Common/TaskUtil")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local ACU = require("Common/ActivityUtil")
local CO = require("Common/Coroutine")
local m_activityManager = S:Get("ActivityManager")
local m_taskPath = {
  [PB.enum.TaskCategory.Warmup] = "fci/warmupTasks",
  [PB.enum.TaskCategory.WarmupDaily] = "fci/warmupDailyTasks"
}
local m_diceCost, m_taskRefreshCost, m_taskCategory, m_taskList, m_pathInfo, m_maxProgressId, m_warmUpInfo, m_chapterIndex, m_chapterRecord, m_roleWarnRect, m_curSlot, m_curSlotRealIndex, m_curSlotWrapIndex, m_sthShowing
local m_coinTexture = {}
local m_diced, m_scrollView, m_startPos, m_endPos, m_moveDistance, m_moveStartPos

function SetupWindow()
  CS.EventDelegate.Add(REF.DailyTab.UIToggle.onChange, function()
    if CS.UIToggle.current.value then
      SetTaskCategory(PB.enum.TaskCategory.WarmupDaily)
    end
  end)
  CS.EventDelegate.Add(REF.OnceTab.UIToggle.onChange, function()
    if CS.UIToggle.current.value then
      SetTaskCategory(PB.enum.TaskCategory.Warmup)
    end
  end)
  LU.Bind(REF.TaskWrapContent, {
    updateRow = UpdateTaskSlot
  })
  LU.Bind(REF.ProgressWrapContent, {
    updateRow = UpdateProgressSlot
  })
  WU.TraverseChildren(REF.TaskWrapContent, function(go)
    WU.BindButtonEvent(_ENV["$"](go).ButtonReplace, OnTaskReplaceClick)
  end)
  WU.BindButtonEvent(REF.ButtonStory, OnStoryClick)
  WU.BindButtonEvent(REF.ButtonAllReward, OnAllRewardClick)
  WU.BindButtonEvent(REF.ButtonDice, OnDiceClick)
  WU.BindButtonEvent(REF.ButtonAdd, OnAddClick)
  WU.BindButtonEvent(REF.ButtonBattleCancel, OnBattleCancelClick)
  WU.BindButtonEvent(REF.ButtonBattle, OnBattleClick)
  WU.BindButtonEvent(REF.LabelCount, function()
    WU.ShowResourceDetail(m_diceCost.type, m_diceCost.id)
  end)
  local config = PB.index("WarmupMiscConfig", 1)
  m_taskRefreshCost = config.taskRefreshCost
  m_diceCost = config.diceCost
  if m_diceCost.count == 0 then
    m_diceCost.count = 1
  end
  REF.LabelCount.ResourceChangeListener:AddListener(function(type, id, count)
    SetDiceButtonStatus(count)
  end, false)
  REF.LabelCount.ResourcePrinter:SetResource(m_diceCost.type, m_diceCost.id, m_diceCost.count)
  m_coinTexture[1] = WU.AcquireAsset("Texture/Impression/UI_FightActivation_Coin1", this)
  m_coinTexture[2] = WU.AcquireAsset("Texture/Impression/UI_FightActivation_Coin2", this)
  m_roleWarnRect = REF.RoleWarnRect.gameObject:GetComponent(typeof(CS.UIWidget))
  m_scrollView = REF.ProgressScrollView.UIScrollView
  m_startPos = m_scrollView.transform.localPosition.x
end

function OnPress()
  if REF.WidgetWarmupRewardSlot.gameObject.activeSelf then
    REF.WidgetWarmupRewardSlot.gameObject:SetActive(false)
  end
end

function UninitWindow()
  CS.UICamera.onPress = nil
end

function InitWindow()
  CS.UICamera.onPress = OnPress
  m_curSlot = nil
  this:BindRemote(DB:GameRequest("fci/warmup"), function(info)
    m_warmUpInfo = info
  end)
  RU.BindRedMark(this, "Welfare/ArmWarmup/Task", function(flag)
    WU.SetActive(REF.SpriteTaskNew, flag)
  end)
  RU.BindRedMark(this, "Welfare/ArmWarmup/DailyTask", function(flag)
    WU.SetActive(REF.SpriteDailyTaskNew, flag)
  end)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowUninited)
  SetView(this:GetData("ArmWarmup/EnterChapter"))
end

function DestroyWindow()
  WU.ReleaseAsset(m_coinTexture[1], this)
  WU.ReleaseAsset(m_coinTexture[2], this)
end

function OnWindowUninited(window)
  if m_sthShowing and window.name == "ArmWarmupStoryOpen" then
    m_sthShowing = false
    Go()
  end
end

function Focus(on)
  if m_sthShowing and on then
    m_sthShowing = false
    Go()
  end
end

function SetView(chapterId)
  REF.DailyTab.UIToggle.value = true
  m_taskCategory = nil
  SetTaskCategory(PB.enum.TaskCategory.WarmupDaily)
  m_chapterIndex, m_chapterRecord = table.find(m_warmUpInfo.chapterRecords, function(k, v)
    return v.chapterId == chapterId
  end)
  WU.SetActive(REF.EffectDice, false)
  WU.SetActive(REF.WidgetWarmupRewardSlot, false)
  m_sthShowing = false
  SetPath(chapterId)
  SetDiceButtonStatus()
end

function SetTaskCategory(category)
  if m_taskCategory ~= category then
    if m_taskCategory ~= nil then
      this:Unbind(m_taskPath[m_taskCategory], UpdateTaskList)
    end
    m_taskCategory = category
    this:Bind(m_taskPath[m_taskCategory], UpdateTaskList)
  end
end

function SetDiceButtonStatus(count)
  if m_chapterRecord == nil then
    return
  end
  if count == nil then
    count = this:GetData("fci/item/" .. m_diceCost.id).count
  end
  local finished = m_chapterRecord.currentProgressId == m_maxProgressId
  local available = not finished and count >= m_diceCost.count
  WU.SetActive(REF.EffectDiceButton, available)
  WU.SetActive(REF.SpriteDice, not available)
end

function SetPath(chapterId)
  m_pathInfo = PB.all("WarmupChapterProgressConfig"):where(function(k, v)
    return v.chapterId == chapterId
  end):toarray()
  table.sort(m_pathInfo, function(a, b)
    return a.progressId < b.progressId
  end)
  m_maxProgressId = m_pathInfo[#m_pathInfo].progressId
  LU.Set(REF.ProgressWrapContent, 0)
  REF.LabelPathProgress.UILabel.text = WU.GetString("ArmWarmup_Progress", m_chapterRecord.currentProgressId, #m_pathInfo - 1)
  this:DelayInvokeInSeconds(0.1, function()
    InitPos()
    Go()
  end)
end

function UpdateProgressSlot(slotRef, wrapIndex, realIndex)
  local index = realIndex + 1
  if m_pathInfo == nil or index > #m_pathInfo then
    return
  end
  local info = m_pathInfo[index]
  local isCurrent = info.progressId == m_chapterRecord.currentProgressId
  if isCurrent then
    m_curSlotWrapIndex = wrapIndex
    m_curSlotRealIndex = realIndex
    m_curSlot = slotRef
  end
  slotRef["$$SetView"](info, m_chapterRecord.currentProgressId, m_maxProgressId, wrapIndex, m_roleWarnRect, function()
    if info.progressType == PB.enum.WarmupProgressType.Story and (info.progressId < m_chapterRecord.currentProgressId or info.progressId == m_chapterRecord.currentProgressId and info.progressId == m_maxProgressId) then
      WU.AcquireWindowAsync("ArmWarmupStoryOpen", function(ui)
        _ENV["$"](ui)["$$SetProgress"](info.chapterId, info.progressId)
      end)
    elseif info.progressId ~= m_chapterRecord.currentProgressId or info.progressId == m_maxProgressId then
      local pos = slotRef.root.transform.position
      pos.y = pos.y + 0.55
      REF.WidgetWarmupRewardSlot["$SetData"](info.chapterId, info.progressId, pos)
    end
  end)
end

function UpdateTaskList(data)
  if data == nil then
    LU.Set(REF.TaskWrapContent, 0)
    return
  end
  m_taskList = data
  LU.Set(REF.TaskWrapContent, #m_taskList)
end

function UpdateTaskSlot(slotRef, wrapIndex, realIndex)
  local index = realIndex + 1
  if m_taskList == nil or index > #m_taskList then
    return
  end
  local taskInfo = m_taskList[index]
  slotRef["$$SetView"](taskInfo, 2)
  slotRef["$$ToggleRemainTime"](false)
  slotRef["$$SetRewardClick"](OnTaskRewardClick)
  slotRef.SpriteRewardIcon.UISprite.spriteName = "ResItem_" .. taskInfo.res.reward[1].id
  slotRef.LabelRewardCount.UIHtmlLabel.text = "x" .. taskInfo.res.reward[1].count
  local isDaily = m_taskCategory == PB.enum.TaskCategory.WarmupDaily
  WU.SetActive(slotRef.ButtonReplace, isDaily and not taskInfo.isDone)
  if isDaily then
    _ENV["$"](slotRef.ButtonReplace)["@taskInfo"] = taskInfo
    _ENV["$"](slotRef.ButtonReplace)["@root"] = slotRef
  end
end

function OnTaskRewardClick(go)
  local ref = _ENV["$"](go)
  local taskInfo = ref["@taskInfo"]
  this:GameRequest("fci/task/" .. taskInfo.id .. "/reward/"):Post(nil, function(result)
    DBH.ResChange(result.resChange)
    WU.ShowRewards(result.resChange)
    local index, task = _ENV["!"](m_taskList):find(function(k, v)
      return v.id == taskInfo.id
    end)
    if task ~= nil then
      task.rewardGot = true
      table.sort(m_taskList, TU.Sort)
      this:SetData(m_taskPath[m_taskCategory], m_taskList)
    end
  end)
end

function OnTaskReplaceClick(go)
  local ref = _ENV["$"](go)
  local taskInfo = ref["@taskInfo"]
  WU.TryToRefresh(m_taskRefreshCost.type, m_taskRefreshCost.count, function()
    WU.TryToPayResource(m_taskRefreshCost, function()
      this:GameRequest("fci/warmup/task-refresh/"):Post({
        taskId = taskInfo.id
      }, function(result)
        DBH.ResChange(result.resChange)
        if result.newTask.res == nil then
          result.newTask.res = PB.get("TaskInfo", result.newTask.id)
        end
        local i, t = m_taskList:find(function(k, v)
          return v.id == taskInfo.id
        end)
        table.remove(m_taskList, i)
        table.insert(m_taskList, i, result.newTask)
        ref["@taskInfo"] = result.newTask
        ref["@root"]["$$SetView"](result.newTask, 2)
        ref["@root"]["$UIPlayTween"]:Play(true)
      end)
    end)
  end, "ArmWarmup_ConfirmToReplaceTask")
end

function OnStoryClick()
  WU.AcquireWindowAsync("ArmWarmupStory", function(window)
    _ENV["$"](window)["$$SetIndex"](m_chapterRecord.chapterId)
  end)
end

function OnAllRewardClick()
  WU.AcquireWindowAsync("ArmWarmupReward", function(window)
    _ENV["$"](window)["$$SetChapterId"](m_chapterRecord.chapterId)
  end)
end

function OnAddClick()
  WU.Exchange(m_diceCost.type, nil, true, m_diceCost.id)
end

function OnBattleCancelClick()
  WU.SetActive(REF.BattleTrigger, false)
  Finish()
end

function OnBattleClick()
  local ac = m_activityManager.GetActivitySync(PB.enum.ActivityType.Warmup_Chapter, 87006)
  local dungeonId = m_chapterRecord.currentProgressParams[1]
  local dungeonReward = PB.get("DungeonReward", dungeonId)
  this:SetData("WindowDungeon/DungeonId", dungeonId)
  this:SetData("ActorGroup/DungeonType", dungeonReward.type)
  WU.AcquireWindowAsync("ActivityActorGroup", function(ui)
    this:SetData("Event/ActivityId", ac.activityId)
    this:SetData("ActivityActorGroup/DungeonInfo", {
      dungeonId = dungeonId,
      activityId = ac.activityId,
      activityType = ac.type,
      mode = "EventActivity"
    })
  end)
  WU.SetActive(REF.BattleTrigger, false)
  m_sthShowing = true
  Finish()
end

function OnDiceClick()
  if m_chapterRecord.currentProgressId ~= m_maxProgressId then
    WU.TryToPayResource(m_diceCost, function()
      this:GameRequest("fci/warmup/dice/"):Post(nil, function(result)
        DBH.ResChange(result.resChange)
        SaveRecord(result)
        m_diced = true
        Go()
      end)
    end, function()
      WU.ShowHintText(WU.GetString("ArmWarmup_CoinNotEnough"))
    end)
  else
    WU.ShowHintText(WU.GetString("ArmWarmup_ChapterFinished"))
  end
end

function Go()
  if m_sthShowing then
    return
  end
  m_moveDistance = 0
  CheckRoleVisible()
  m_curSlot["$$FinishChapter"]()
  if m_chapterRecord.currentProgressType ~= 0 then
    Result()
    return
  elseif m_chapterRecord.leftStep == 0 then
    return
  end
  CO.coroutine_call(Game, this)()
end

function Game()
  WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, true)
  if m_moveDistance ~= 0 then
    m_scrollView:RestrictWithinBounds(true)
    local nowPos = m_scrollView.transform.localPosition.x
    while math.abs(m_moveDistance) > 10 and nowPos >= m_endPos - 3 and nowPos <= m_startPos + 3 do
      local step = m_moveDistance * 0.2
      m_scrollView:MoveRelative(CS.UnityEngine.Vector3(step, 0, 0))
      m_moveDistance = m_moveDistance - step
      nowPos = m_scrollView.transform.localPosition.x
      CO.yield_return(CS.UnityEngine.WaitForSeconds(0.01))
    end
    m_scrollView:RestrictWithinBounds(true)
  end
  if m_diced then
    m_diced = false
    WU.SetActive(REF.EffectDice, true)
    local effect = _ENV["$"](REF.EffectDice)
    effect.CoinMesh.MeshRenderer.material:SetTexture("_MainTex", m_coinTexture[m_chapterRecord.leftStep])
    effect.root.EffectGenerator:Play()
    CS.SoundManager.Instance:PlaySound("Sound/se/Soiya")
    CO.yield_return(CS.UnityEngine.WaitForSeconds(2))
  end
  CO.coroutine_call(m_curSlot["$$Next"], this)()
  CO.yield_return(CS.UnityEngine.WaitForSeconds(2.1))
  m_curSlotWrapIndex = fif(m_curSlotWrapIndex + 1 >= #REF.ProgressWrapContent, 0, m_curSlotWrapIndex + 1)
  m_curSlot = REF.ProgressWrapContent[m_curSlotWrapIndex]
  WU.SetLockFlag(PB.enum.LockInputFlag.NormalBlock, false)
  Move()
end

function Move()
  this:GameRequest("fci/warmup/move/"):Post(nil, function(result)
    DBH.ResChange(result.resChange)
    m_curSlotRealIndex = m_curSlotRealIndex + 1
    SaveRecord(result)
    if m_chapterRecord.currentProgressType == PB.enum.WarmupProgressType.Reward then
      if m_warmUpInfo.secretPlan then
        WU.ShowRewards(result.resChange, Result)
      else
        m_sthShowing = true
        WU.AcquireWindowAsync("HintResourcesWithTitle2", function(ui)
          _ENV["$"](ui)["$$SetProgress"](m_chapterRecord.chapterId, m_chapterRecord.currentProgressId)
        end)
      end
    else
      Result()
    end
  end)
end

function Result()
  local param = m_chapterRecord.currentProgressParams[1]
  if param ~= nil and m_chapterRecord.currentProgressType == PB.enum.WarmupProgressType.Normal then
    WU.SetActive(REF.BattleTrigger, true)
  else
    if m_chapterRecord.currentProgressType == PB.enum.WarmupProgressType.Story then
      m_sthShowing = true
      WU.AcquireWindowAsync("ArmWarmupStoryOpen", function(ui)
        _ENV["$"](ui)["$$SetProgress"](m_chapterRecord.chapterId, m_chapterRecord.currentProgressId)
      end)
    end
    Finish()
  end
end

function Finish()
  this:GameRequest("fci/warmup/move-finish/"):Post(nil, function(result)
    SaveRecord(result, true)
    Go()
  end)
end

function SaveRecord(result, hasNew)
  m_chapterRecord = result.chapterRecord
  m_warmUpInfo.chapterRecords[m_chapterIndex] = m_chapterRecord
  if hasNew then
    m_warmUpInfo.chapterRecordNewUnlocked = result.chapterRecordNewUnlocked
    if result.chapterRecordNewUnlocked ~= nil then
      m_warmUpInfo.currentChapterId = result.chapterRecordNewUnlocked.chapterId
    end
    table.insert(m_warmUpInfo.chapterRecords, result.chapterRecordNewUnlocked)
    this:SetData("fci/warmup", m_warmUpInfo)
  end
  REF.LabelPathProgress.UILabel.text = WU.GetString("ArmWarmup_Progress", m_chapterRecord.currentProgressId, #m_pathInfo - 1)
  SetDiceButtonStatus()
end

function CheckRoleVisible()
  if m_curSlot ~= nil then
    local validWidget
    if m_chapterRecord.currentProgressId == 0 then
      validWidget = REF.Drag.UIWidget
    else
      validWidget = REF.RoleValidRect.gameObject:GetComponent(typeof(CS.UIWidget))
    end
    if not m_curSlot["$$CheckOverlap"](validWidget, true) then
      SetPos()
    end
  end
end

function SetPos()
  local toIndex = m_curSlotRealIndex - 1
  local itemHeight = REF.ProgressWrapContent.UIWrapContent.itemSize
  local personPos = toIndex * itemHeight
  m_moveStartPos = m_scrollView.transform.localPosition.x
  local toPos = m_startPos - personPos
  m_scrollView:DisableSpring()
  m_moveDistance = toPos - m_moveStartPos
end

function InitPos()
  LU.Set(REF.ProgressWrapContent, #m_pathInfo)
  m_scrollView:ResetPosition()
  m_startPos = m_scrollView.transform.localPosition.x
  local itemHeight = REF.ProgressWrapContent.UIWrapContent.itemSize
  local scorllSizeX = REF.ProgressScrollView.UIPanel.width
  m_endPos = m_startPos - #m_pathInfo * itemHeight + scorllSizeX - 370
  local index, progress = m_pathInfo:find(function(k, v)
    return v.progressId == m_chapterRecord.currentProgressId
  end)
  m_curSlotRealIndex = index - 1
  SetPos()
  m_scrollView:MoveRelative(CS.UnityEngine.Vector3(m_moveDistance, 0, 0))
  m_scrollView:RestrictWithinBounds(true)
end
