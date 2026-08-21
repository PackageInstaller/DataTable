local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local RU = require("Common/RedMarkUtil")
local TU = require("Common/TaskUtil")
local DBH = require("Manager/DataBindingHandler")
local m_maxRefreshCount = PB.index("Misc", 1).taskWeekRefreshMaxCountPerDay
local m_taskList, m_selectedSlot, m_selectedId

function SetupWindow()
  if CS.GameGlobal.DoesDeviceHaveNotch() then
    REF.ScrollViewMix.UIPanel.clipSoftness = CS.UnityEngine.Vector2(CS.UIRoot.LeftNotchWidth, 0)
  end
  LU.Bind(REF.WrapContentMix, {
    updateRow = UpdateMixSlot
  })
  WU.BindButtonEvent(REF.ButtonReplace, OnReplaceClick)
  WU.TraverseChildren(REF.WrapContentMix, function(go)
    local ref = _ENV["$"](go)
    WU.ToggleRendering(_ENV["$"](ref.WidgetTaskSlot).BtnGo, false)
    WU.ToggleRendering(_ENV["$"](ref.WidgetTaskSlot).BtnGetReward, false)
    WU.BindButtonEvent(_ENV["$"](go).ButtonSelect, function()
      OnTaskClick(_ENV["$"](go))
    end)
  end)
end

function InitWindow()
  m_selectedSlot = nil
  m_selectedId = nil
  WU.SetActive(REF.LabelAlreadyReplaced, false)
  WU.SetActive(REF.ButtonReplace, true)
  REF.ButtonReplace.UIButton.isEnabled = false
  local all = this:GetData("fci/task/")[PB.enum.TaskCategory.Week] or {}
  m_taskList = _ENV["!"](all):where(function(k, v)
    return not v.rewardGot and v.id > 0
  end):toarray()
  local count = #m_taskList
  if #m_taskList < #REF.WrapContentMix - 2 then
    REF.ScrollViewMix.UIScrollView.contentPivot = CS.UIWidget.Pivot.Center
  else
    REF.ScrollViewMix.UIScrollView.contentPivot = CS.UIWidget.Pivot.Left
  end
  LU.Set(REF.WrapContentMix, #m_taskList)
end

function UninitWindow()
  RU.SetRedMark("Task/" .. PB.enum.TaskCategory.Week .. "/New", false)
  TU.TaskSetNew(PB.enum.TaskCategory.Week, this:GetData("fci/task/")[PB.enum.TaskCategory.Week])
  if m_selectedSlot ~= nil then
    WU.SetActive(m_selectedSlot.EffectReplaced, false)
  end
end

function UpdateMixSlot(slotRef, wrapIndex, rowIndex)
  if m_taskList and rowIndex < #m_taskList then
    local task = m_taskList[rowIndex + 1]
    slotRef["@taskId"] = task.id
    slotRef.WidgetTaskSlot["$SetView"](task)
    local selected = m_selectedId == task.id
    WU.ToggleRendering(slotRef.SpriteSelected, selected)
  end
end

function OnTaskClick(ref)
  REF.ButtonReplace.UIButton.isEnabled = true
  if m_selectedSlot ~= nil then
    WU.ToggleRendering(m_selectedSlot.SpriteSelected, false)
  end
  m_selectedSlot = ref
  m_selectedId = ref["@taskId"]
  WU.ToggleRendering(m_selectedSlot.SpriteSelected, true)
end

function OnReplaceClick()
  this:GameRequest("fci/task/refreshtaskweek/"):Post({taskId = m_selectedId}, function(result)
    local weekInfo = this:GetData("task/taskWeekInfo")
    weekInfo.refershCountToday = result.refershCountToday
    this:SetData("task/taskWeekInfo", weekInfo)
    local replaced = weekInfo.refershCountToday >= m_maxRefreshCount
    WU.SetActive(REF.LabelAlreadyReplaced, replaced)
    WU.SetActive(REF.ButtonReplace, not replaced)
    WU.SetActive(m_selectedSlot.EffectReplaced, true)
    if result.newTask.res == nil then
      result.newTask.res = PB.get("TaskInfo", result.newTask.id)
    end
    result.newTask.isNew = true
    local i, t = m_taskList:find(function(k, v)
      return v.id == m_selectedId
    end)
    table.remove(m_taskList, i)
    table.insert(m_taskList, i, result.newTask)
    LU.Set(REF.WrapContentMix, #m_taskList, false)
  end)
end
