local SortFocusBase = inherit("Window/SortBase/SortFocusBase", _ENV)
local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local LU = require("Common/ListUtil")
local AU = require("Common/ActorUtil")
local DBH = require("Manager/DataBindingHandler")
local SU = require("Common/SortUtil")
local EU = require("Common/EquipUtil")
local GU = require("Common/GroupUtil")
local NU = require("Common/NotepadUtil")
local m_fateActorMainSlot, m_fateActors, m_chooseCallback

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonOK, OnComplete)
  WU.BindButtonEvent(REF.ButtonClose, function()
    WU.RecycleWindow(this)
  end)
  WU.TraverseChildren(REF.FateActorList, function(slot)
    _ENV["$"](slot)["$$SetClickCallback"](OnClickSelectFateActorMainSlot)
  end)
end

function InitWindow()
end

function SetFateActors(pool)
  WU.SetActive(REF.Locked, false)
  WU.SetActive(REF.UnLocked, true)
  m_pool = pool
  local selected = false
  local gachaCustomActorID = this:GetData("gachaCustomActorID")
  for i = 1, #pool do
    local widget = _ENV["$"](REF.FateActorList).root[i - 1]
    local actor = pool[i]
    widget["@actor"] = actor
    widget["$$SetActorDataById"](actor.chooseResId)
    if actor.chooseResId == gachaCustomActorID then
      select(widget)
      selected = true
    end
  end
  if not selected then
    select(_ENV["$"](REF.FateActorList).root[0])
  end
  WU.TraverseChildren(REF.FateActorList, function(slot)
    _ENV["$"](slot)["$$SetClickCallback"](OnClickSelectFateActorMainSlot)
  end)
end

function OnClickSelectFateActorMainSlot(go)
  select(_ENV["$"](go))
end

function select(ref)
  if m_fateActorMainSlot then
    m_fateActorMainSlot["$$SetSelected"](false)
  end
  m_fateActorMainSlot = ref
  m_fateActorMainSlot["$$SetSelected"](true)
end

function SetChooseCallback(callback)
  m_chooseCallback = callback
end

function OnComplete()
  this:GameRequest("fci/gacha-custom/choose-pool/"):Post({
    chooseRes = m_pool
  }, function()
    local pack = {
      chooseActivityRes = {
        chooseResId = m_fateActorMainSlot["@actor"].chooseResId,
        chooseResType = 15
      }
    }
    this:GameRequest("fci/gacha-custom/choose-activity-res/"):Post(pack, function(res)
      local actorId = m_fateActorMainSlot["@actor"].chooseResId
      this:SetData("gachaCustomActorID", actorId)
      local gachainfo = DB:GetData("fci/gachainfo")
      local _, customGacha = _ENV["!"](gachainfo):find(function(k, v)
        return v.id == 7
      end)
      customGacha.customPoolStatus = 2
      DB:SetData("fci/gachainfo", gachainfo)
      WU.RecycleWindow(this)
      if m_chooseCallback then
        m_chooseCallback(actorId)
        m_chooseCallback = nil
      end
    end)
  end)
end

function ShowCustomPoolLocked(pool)
  WU.SetActive(REF.Locked, true)
  WU.SetActive(REF.UnLocked, false)
  m_pool = pool.choosePoolRes
  for i = 1, #m_pool do
    local widget = _ENV["$"](REF.FateActorList).root[i - 1]
    local actor = m_pool[i]
    widget["@actor"] = actor
    widget["$$SetActorDataById"](actor.chooseResId)
    if actor.chooseResId == pool.activityRes.chooseResId then
      select(widget)
    end
  end
  WU.TraverseChildren(REF.FateActorList, function(slot)
    _ENV["$"](slot)["$$SetClickCallback"](nil)
  end)
end
