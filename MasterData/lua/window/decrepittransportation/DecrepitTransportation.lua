local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local S = require("Common/Singleton")
local activityManager = S:Get("ActivityManager")
local m_transportObjs, m_actorActivity

function SetupWindow()
  LU.Bind(REF.WrapContentActors, {
    updateRow = OnInitActorItem
  })
  WU.BindButtonEvent(REF.BtnClose, function()
    WU.RecycleWindow(this)
  end)
end

function InitWindow()
  activityManager.ProcessWhenActivityStartedOrFinished(PB.enum.ActivityType.Couple, function()
    local couple = this:GetData("fci/couple/")
    if couple == nil then
      DB:SyncRemote(DB:GameRequest("fci/couple/"))
    end
  end)
end

function InitData(actorActivity, transportList)
  m_actorActivity = actorActivity
  m_transportObjs = transportList
  local len = #m_transportObjs
  if len < 6 then
    REF.ScrollViewActors.UIScrollView.contentPivot = CS.UIWidget.Pivot.Center
  else
    REF.ScrollViewActors.UIScrollView.contentPivot = CS.UIWidget.Pivot.Left
  end
  LU.Set(REF.WrapContentActors, #m_transportObjs)
end

function OnInitActorItem(widget, wrapIndex, realIndex)
  if m_transportObjs ~= nil and realIndex ~= nil and realIndex < #m_transportObjs then
    local data = m_transportObjs[realIndex + 1]
    if data ~= nil then
      widget["@uid"] = data.uid
      widget["$$BindActor"](data)
      widget["$$ShowCustom"]({
        redPoint = false,
        lock = true,
        showEquips = false,
        showName = true,
        showCultivationTotal = false,
        showSpeed = false,
        showStar = false,
        showGroup = nil
      })
    end
    widget["$$SetClickCallback"](function(go)
      if data.isLock then
        WU.ShowHintText(WU.GetString("Window_ActorIsLocked"))
      elseif not AU.ActorDeleteValidate(data.uid) then
        WU.ShowHintText(WU.GetString("Window_StatusSpaceOrAura"))
      else
        this:SetData("Actor/SelectedUid", _ENV["$"](go)["@uid"])
        this:SetData("ActorTalentInherit/Mode", 2)
        this:SetData("ActorTalentInherit/ActivityInfo", m_actorActivity)
        WU.AcquireWindowAsync("ActorTalentInherit")
      end
    end)
  end
end
