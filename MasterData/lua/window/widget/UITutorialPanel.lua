local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local m_window, m_stepIndex, m_stepCount, m_tutorialId
local m_SORTING_ORDER = 29960
local m_DEPTH = 22799
local m_specialInit, m_specialInitIndex

function Awake()
  WU.BindButtonEvent(REF.BtnNext, OnClickNext)
end

function SwitchOffView()
  HideTutorial()
end

function Init(specialInitIndex, specialInit)
  m_tutorialId = REF["$UITutorialPanel"].tutorialId
  m_window = REF["$transform"]:GetComponentInParent(typeof(CS.UILuaWindow))
  WU.TraverseChildren(REF.NodeSteps, function(go)
    _ENV["$"](go)["$$Init"]()
  end)
  REF.InputBlock.gameObject:AddComponent(typeof(CS.UIKeyResponser))
  REF.InputBlock.UIKeyResponser:SetKeyCode(CS.UnityEngine.KeyCode.Escape)
  SetInputBlock(true)
  if specialInitIndex then
    m_specialInitIndex = specialInitIndex
    m_specialInit = specialInit
  end
end

function StartTutorial(delay)
  m_stepIndex = 0
  m_stepCount = REF.NodeSteps.transform.childCount
  REF["$UIPanel"].depth = m_DEPTH
  REF["$UIPanel"].sortingOrder = m_SORTING_ORDER
  this:DelayInvokeInScaledSeconds(delay, StartTutorialImpl)
end

function StartTutorialImpl()
  REF.Black.gameObject:SetActive(true)
  REF.BtnNext.gameObject:SetActive(true)
  NextStep()
end

function NextStep()
  if 0 < m_stepIndex and m_stepIndex - 1 < m_stepCount then
    if m_specialInitIndex then
      local index, _ = table.find(m_specialInitIndex, function(_, k)
        return k == m_stepIndex
      end)
      if index then
        m_specialInit[index](false)
      end
    end
    REF.NodeSteps[m_stepIndex - 1]["$$EndStep"]()
    REF.NodeSteps[m_stepIndex - 1]["$gameObject"]:SetActive(false)
  end
  if m_stepIndex < m_stepCount then
    local ref = REF.NodeSteps[m_stepIndex]
    ResetTweenToPlay(ref)
    ref["$gameObject"]:SetActive(true)
    ref["$$StartStep"]()
    if m_specialInitIndex then
      local index, _ = table.find(m_specialInitIndex, function(_, k)
        return k == m_stepIndex + 1
      end)
      if index then
        m_specialInit[index](true)
      end
    end
  else
    HideTutorial()
    EndTutorial()
    SetInputBlock(false)
  end
  WU.AdjustWidgetDepth(m_window.gameObject)
  if m_stepIndex == m_stepCount - 1 then
    REF.LabelNext.UILabel.text = WU.GetString("WindowTutorial_End")
  else
    REF.LabelNext.UILabel.text = WU.GetString("WindowTutorial_Next")
  end
  m_stepIndex = m_stepIndex + 1
end

function HideTutorial()
  REF.Black.gameObject:SetActive(false)
  REF.BtnNext.gameObject:SetActive(false)
  WU.TraverseChildren(REF.NodeSteps, function(go)
    go:SetActive(false)
  end)
end

function EndTutorial()
  this:GameRequest("fci/tutorial/" .. m_tutorialId):Put({status = 1}, function()
    local _, t = table.find(this:GetData("fci/tutorial/"), function(k, v)
      return v.id == m_tutorialId
    end)
    t.status = 1
  end)
end

function SetInputBlock(active)
  REF.InputBlock.gameObject:SetActive(active)
end

function OnClickNext()
  if 0 < m_stepIndex then
    NextStep()
  end
end

function ResetTweenToPlay(ref)
  WU.TraverseChildren(ref.root, function(go, i)
    local holderRef = _ENV["$"](go)
    holderRef.root[0]["$TweenPosition"]:ResetToBeginning()
    holderRef.root[0]["$TweenAlpha"]:ResetToBeginning()
    holderRef.root[1]["$TweenWidth"]:ResetToBeginning()
  end)
  ref["$gameObject"]:SetActive(true)
  WU.TraverseChildren(ref.root, function(go, i)
    local holderRef = _ENV["$"](go)
    holderRef.root[0]["$TweenPosition"]:PlayForward()
    holderRef.root[0]["$TweenAlpha"]:PlayForward()
    holderRef.root[1]["$TweenWidth"]:PlayForward()
  end)
end
