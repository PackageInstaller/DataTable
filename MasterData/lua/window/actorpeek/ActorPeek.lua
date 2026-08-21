local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local SE = require("Common/SkillEffect")
local AU = require("Common/ActorUtil")
local LU = require("Common/ListUtil")
local m_actor, m_dataList

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonClose, function()
    this:SetData("ActorSelect/PeekActorUid", nil)
    WU.RecycleWindow(this)
  end)
  LU.Bind(REF.WrapContent, {
    dataSource = function(index)
      return m_dataList and m_dataList[index]
    end,
    updateRow = UpdateSlot
  })
end

function SetData(actor)
  m_actor = actor
  if m_actor then
    m_dataList = SE.GetActorSkills(actor.id, true)
    m_dataList:append(AU.GetActorLinks(actor, this:GetData("fci/actor/")))
    if (#m_dataList - 1) * REF.WrapContent.UIWrapContent.itemSize + REF.WrapContent[0]["$UIWidget"].width < REF.ScrollView.UIPanel.finalClipRegion.z then
      REF.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Center
    else
      REF.ScrollView.UIScrollView.contentPivot = CS.UIWidget.Pivot.Left
    end
    LU.Set(REF.WrapContent, #m_dataList)
    this:SetData("ActorSelect/PeekActorUid", m_actor.uid)
  end
end

function UpdateSlot(slotRef, wrapIndex, realIndex)
  if m_dataList and realIndex and realIndex < #m_dataList then
    slotRef["$$SetData"](m_actor, m_dataList[realIndex + 1])
  end
end
