local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local DBH = require("Manager/DataBindingHandler")
local S = require("Common/Singleton")
local m_activityManager = S:Get("ActivityManager")
local ACU = require("Common/ActivityUtil")
local RU = require("Common/RedMarkUtil")
local LU = require("Common/ListUtil")
local TR = require("Common/TeamRCMDUtil")
local Misc = PB.all("Misc")[1]
local m_dataPage, m_requestPage, m_datas
local m_tabindex = 1
local m_activeData
local PageLen = Misc.ShareGroupOnePageNum * 2

function Start()
  CS.EventDelegate.Add(REF.TeamScrollView.UIScrollView.onNext, function()
    RequestNextPage(m_tabindex)
  end)
  CS.EventDelegate.Add(REF.TeamScrollView.UIScrollView.onPrev, function()
  end)
  WU.TraverseChildren(REF.TabPage, function(GO, index)
    local ref = _ENV["$"](GO)
    WU.BindButtonEvent(ref.root, function()
      m_tabindex = index + 1
      ChangeWrapData(m_tabindex)
      WU.ToggleRendering(REF.NoData, false)
      WU.ToggleRendering(REF.TeamRCMDList, true)
      if m_dataPage[m_tabindex] == 0 then
        RequestNextPage(m_tabindex)
      end
    end)
  end)
  WU.BindButtonEvent(REF.BtnSearch, function()
    WU.AcquireWindowAsync("TeamRecommendSearch")
  end)
  WU.BindButtonEvent(REF.BtnStore, function()
    if not WU.WindowIsLocked(PB.enum.UnlockWindow.Shop, PB.enum.UnlockWindow.Shop) then
      WU.AcquireWindowAsync("Shop", function(ui)
        _ENV["$"](ui)["$$SetSelected"](1401)
      end)
    end
  end)
  WU.BindButtonEvent(REF.BtnUpload, function()
    WU.AcquireWindowAsync("TeamRecommendUpload")
  end)
  WU.BindButtonEvent(REF.pic, function()
    WU.AcquireWindowAsync("TeamRecommendUpload")
  end)
  LU.Bind(REF.TeamWrapContent, {
    updateRow = function(ref, wrapIndex, realIndex)
      ref["$$SetData"](m_activeData[realIndex + 1])
    end
  })
  WU.BindButtonEvent(REF.Point, function()
    WU.ShowResourceDetail(PB.enum.ResourceType.ResItem, Misc.ShareGroupPointId)
  end)
  REF.LabelMoney.ResourcePrinter:SetResource(PB.enum.ResourceType.ResItem, Misc.ShareGroupPointId)
  LU.Set(REF.TeamWrapContent, 0)
  WU.ToggleRendering(REF.NoData, false)
  WU.SetActive(REF.NoData, true)
  ChangeWrapData(m_tabindex)
end

function RequestNextPage(tabindex)
  if m_dataPage[tabindex] == m_requestPage[tabindex] then
    m_requestPage[tabindex] = m_requestPage[tabindex] + 1
    RequestPage(m_requestPage[tabindex], tabindex, m_requestPage[tabindex] == 0)
  end
end

function RequestPage(pageNum, tabindex, syncInput)
  this:GameRequest(string.format("fci/share-group/group/%d/%d", tabindex, pageNum)):SyncInput(syncInput):Get(function(resp)
    UpdateWrapData(resp.groupList, pageNum, tabindex)
    if pageNum > m_dataPage[tabindex] then
      m_dataPage[tabindex] = m_dataPage[tabindex] + 1
    end
  end)
end

function ChangeWrapData(tabindex)
  if tabindex == PB.enum.GroupListType.Newest then
    for i = PageLen + 1, #m_datas[tabindex] do
      m_datas[tabindex][i] = nil
    end
    m_dataPage[tabindex] = 0
    m_requestPage[tabindex] = 0
  end
  m_activeData = m_datas[tabindex]
  LU.Set(REF.TeamWrapContent, #m_activeData)
  if #m_activeData == 0 then
    m_activeData.needReset = true
  end
end

function UpdateWrapData(datas, pageNum, index)
  local target = m_datas[index]
  local datasLen = #datas
  if datasLen > PageLen then
    warning("TeamRCMD", "groupList Length(" .. datasLen .. ") Longer than define")
  end
  if datasLen == 0 then
    if m_dataPage[index] == 0 and index == m_tabindex then
      WU.ToggleRendering(REF.NoData, true)
      WU.ToggleRendering(REF.TeamRCMDList, false)
    else
      WU.ShowHintText(WU.GetString("TeamRCMD_NoMoreData"))
    end
    m_dataPage[index] = m_dataPage[index] - 1
    m_requestPage[index] = m_requestPage[index] - 1
  else
    local startIndex = pageNum * PageLen - PageLen
    for k, v in ipairs(datas) do
      for i = 1, 6 do
        local actor = v.actors[i]
        if actor then
          v.actors[i] = TR.ActorDataStencil(actor)
        end
      end
      target[startIndex + k] = v
    end
    if m_tabindex == index then
      LU.Set(REF.TeamWrapContent, #m_activeData, m_activeData.needReset)
      m_activeData.needReset = false
    end
    if datasLen < PageLen then
      m_dataPage[index] = m_dataPage[index] - 1
      m_requestPage[index] = m_requestPage[index] - 1
    end
  end
end

function ClearAll()
  m_dataPage = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0
  }
  m_requestPage = {
    [1] = 0,
    [2] = 0,
    [3] = 0,
    [4] = 0
  }
  m_datas = {
    [1] = {},
    [2] = {},
    [3] = {},
    [4] = {}
  }
  m_activeData = {}
  ChangeWrapData(m_tabindex)
end

function OnEnable()
  this:RegisterGameEvent("AddNewTeam", AddNewTeam)
  ClearAll()
  TR.AcqPointChange()
  RequestNextPage(m_tabindex)
end

function OnDisable()
  this:UnregisterGameEvent("AddNewTeam", AddNewTeam)
end

function AddNewTeam(data)
  table.remove(m_datas[PB.enum.GroupListType.Self])
  table.insert(m_datas[PB.enum.GroupListType.Self], 1, data)
  LU.Set(REF.TeamWrapContent, #m_activeData, false)
end
