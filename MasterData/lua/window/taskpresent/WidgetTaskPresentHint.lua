local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local RU = require("Common/RedMarkUtil")
local IU = require("Common/ItemUtil")
local DBH = require("Manager/DataBindingHandler")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local TU = require("Common/TaskUtil")
local DU = require("Common/DungeonUtil")
local m_task, m_totalTaskList
local BoxId = PB.all("Misc"):first().taskPresentRewardBoxId

function Start()
  m_totalTaskList = PB.all("TaskInfo"):where(function(k, v)
    return v.category == PB.enum.TaskCategory.Present
  end):toarray():sort(function(a, b)
    return a.priority > b.priority
  end)
  WU.BindButtonEvent(REF.ButtonSlot, OnClick)
  this:Bind("fci/dungeon/chapter/1", ToggleRendering)
  this:Bind("fci/presentTasks", OnPresentTaskChanged)
  this:Bind("fci/item/" .. BoxId, ToggleRendering)
  this:Bind("taskPresentTargetActor", OnTargetActorChanged)
  this:Bind("NavigationContext", OnNavigationContext)
end

function OnPresentTaskChanged(tasks)
  m_task = GetCurrentTask(tasks)
  this:SetData("fci/currentPresentTask", m_task)
  ToggleRendering()
  local lastTaskRes = m_totalTaskList:last()
  if m_task then
    if this:GetData("taskPresentTargetActor") == nil then
      this:GameRequest("fci/present-target-actor"):Get(function(resp)
        this:SetData("taskPresentTargetActor", resp.presentTargetActor)
      end)
    end
    if m_task.id == lastTaskRes.id and m_task.isDone then
      REF.LabelDesc.UIHtmlLabel.text = WU.GetString("WindowTaskPrsent_RewardRemind")
    else
      REF.LabelDesc.UIHtmlLabel.text = WU.GetString("TaskDesc_" .. m_task.res.id, m_task.res.maxProgress, TU.GetParamLocalizationText(m_task.res.taskParam, m_task.res.goalType)) .. string.format(" (%s/%s)", m_task.progress, m_task.res.maxProgress)
    end
    local index = table.find(m_totalTaskList, function(k, v)
      return v.id == m_task.id
    end)
    WU.SetActive(REF.EffectActor1, not m_task.isDone or not not m_task.rewardGot)
    WU.SetActive(REF.EffectActor2, m_task.isDone and not m_task.rewardGot)
  elseif this:GetData("fci/item/" .. BoxId).count > 0 then
    if this:GetData("taskPresentTargetActor") == nil then
      this:GameRequest("fci/present-target-actor"):Get(function(resp)
        this:SetData("taskPresentTargetActor", resp.presentTargetActor)
      end)
    end
    REF.LabelDesc.UIHtmlLabel.text = WU.GetString("WindowTaskPrsent_RewardRemind")
    WU.SetActive(REF.EffectActor1, false)
    WU.SetActive(REF.EffectActor2, true)
  end
  REF.SpriteBgBar.UISprite.width = REF.LabelDesc.UIHtmlLabel.width + 42
  local maskControl1 = _ENV["$"](REF.EffectSaku).MaskControl
  local maskControl2 = _ENV["$"](REF.EffectActor2).MaskControl
  if maskControl1 then
    local scale = maskControl1.transform.localScale
    scale.x = (REF.SpriteBgBar.UISprite.width + 34) / 542
    maskControl1.transform.localScale = scale
  end
  if maskControl2 then
    local scale = maskControl2.transform.localScale
    scale.x = (REF.SpriteBgBar.UISprite.width + 34) / 542
    maskControl2.transform.localScale = scale
  end
end

function OnTargetActorChanged(actorId)
  local hasActor = actorId ~= nil and actorId ~= 0
  WU.SetActive(REF.NodeActor, hasActor)
  WU.SetActive(REF.NodeSaku, not hasActor)
  local kind = 0
  if hasActor then
    kind = PB.get("ActorConfig", actorId).kind
    if kind == 1 then
      REF.TextureActorHeadMain.UITexture.mainTexturePath = string.format("Texture/ActorInfightHead/%s/infight_head_%sa", fif(PB.get("ActorConfig", actorId).kind == 1, "main", "sub"), actorId)
    elseif kind == 2 then
      REF.TextureActorHeadSub.UITexture.mainTexturePath = string.format("Texture/ActorInfightHead/%s/infight_head_%sa", fif(PB.get("ActorConfig", actorId).kind == 1, "main", "sub"), actorId)
    end
  end
  WU.SetActive(REF.TextureActorHeadMain, kind == 1)
  WU.SetActive(REF.TextureActorHeadSub, kind == 2)
end

function ToggleRendering()
  local taskInfo = this:GetData("fci/currentPresentTask")
  local boxCount = this:GetData("fci/item/" .. BoxId).count
  local isFinished = false
  DU.IsDungeonFinished(this:GetData("fci/dungeon/chapter-summary"), PB.all("Misc"):first().ptTaskPresent, function(finished)
    isFinished = finished
  end)
  local active = isFinished and taskInfo ~= nil or taskInfo == nil and 0 < boxCount
  WU.ToggleRendering(REF.root, active)
  local winCity = WU.FindWindow("City")
  if winCity then
    local p = _ENV["$"](winCity).ActivityGrid.transform.localPosition
    p.y = fif(active, 325, 250)
    _ENV["$"](winCity).ActivityGrid.transform.localPosition = p
    _ENV["$"](winCity).ActivityGrid.UIGrid:Reposition()
    p = _ENV["$"](winCity).BoardSpeechText.transform.localPosition
    p.y = fif(active, -371, -481)
    _ENV["$"](winCity).BoardSpeechText.transform.localPosition = p
  end
end

function OnClick()
  WU.AcquireWindowAsync("TaskPresent")
end

function GetCurrentTask(taskList)
  if taskList then
    local task = taskList[1]
    if task and (not (not task.isDone or task.rewardGot) or not task.isDone) then
      return task
    end
  end
end

function OnNavigationContext(winName)
  if winName == "City" then
    REF.EffectSaku.EffectGenerator:Play()
    REF.EffectActor1.EffectGenerator:Play()
    REF.EffectActor2.EffectGenerator:Play()
    REF.Holder.UIPlayTween:Play(true)
  end
end
