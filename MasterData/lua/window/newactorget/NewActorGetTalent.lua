local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local m_talentData, m_tweenPlayed

function SetupWindow()
  local playList = REF.GridNode.transform:GetComponentsInChildren(typeof(CS.UIPlayTween))
  CS.EventDelegate.Add(playList[1].onFinished, function()
    for i = 1, 4 do
      REF.GridNode[i - 1].WidgetTalentSlot.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
      REF.GridNode[i - 1].Group.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
      REF.GridNode[i - 1]["$gameObject"]:SetActive(false)
    end
    WU.RecycleWindow(this)
  end)
  WU.BindButtonEvent(REF.Black, function()
    if m_tweenPlayed then
      return
    end
    m_tweenPlayed = true
    REF.Black.gameObject:SetActive(false)
    OnTalentDisappear()
  end)
end

function InitWindow()
  REF.Black.gameObject:SetActive(true)
  m_tweenPlayed = false
  REF.GridNode.gameObject:SetActive(false)
end

function SetData(talentData)
  m_talentData = talentData
  for i = 1, 4 do
    REF.GridNode[i - 1].WidgetTalentSlot.transform.localPosition = CS.UnityEngine.Vector3(0, 0, 0)
    REF.GridNode[i - 1].Group.transform.localScale = CS.UnityEngine.Vector3(1, 1, 1)
    REF.GridNode[i - 1].WidgetTalentSlot.TweenPosition.enabled = false
    if talentData[5 - i] then
      REF.GridNode[i - 1].root.gameObject:SetActive(true)
      REF.GridNode[i - 1].WidgetTalentSlot["$SetData"](talentData[5 - i])
    else
      REF.GridNode[i - 1].root.gameObject:SetActive(false)
    end
  end
  REF.GridNode.gameObject:SetActive(true)
  REF.GridNode.UIGrid:Reposition()
end

function OnTalentDisappear()
  for i = 1, 4 do
    if m_talentData[5 - i] ~= nil then
      local v1 = REF.TalentScoreLabel.transform:TransformPoint(CS.UnityEngine.Vector3(0, 0, 0))
      local targetPosition = REF.GridNode[i - 1].WidgetTalentSlot.transform:InverseTransformPoint(v1)
      REF.GridNode[i - 1].WidgetTalentSlot.TweenPosition.from = CS.UnityEngine.Vector3(0, 0, 0)
      REF.GridNode[i - 1].WidgetTalentSlot.TweenPosition.to = targetPosition
    end
  end
  REF.GridNode.transform:GetComponentsInChildren(typeof(CS.UIPlayTween))[1]:Play(true)
end
