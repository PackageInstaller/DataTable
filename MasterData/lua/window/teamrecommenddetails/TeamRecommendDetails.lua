local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local CO = require("Common/Coroutine")
local playerId = this:GetData("playerId")
local m_groupData, m_comments, m_recentCopy
local m_requestPage = 0
local m_currentPage = 0
local Misc = PB.all("Misc")[1]
local maxLen = Misc.inputLimit.TeamRCMDComment or 1
local PageLen = PB.all("Misc")[1].ShareGroupOnePageNum * 2

function SetupWindow()
  WU.BindButtonEvent(REF.SpriteSend, OnSubmitComment)
  WU.BindButtonEvent(REF.ButtonSearchUp, function()
    WU.AcquireWindowAsync("TeamRecommendResult", function(UI)
      _ENV["$"](UI)["$$SetData_B"](m_groupData.playerId)
    end)
  end)
  CS.EventDelegate.Add(REF.ScrollView.UIScrollView.onNext, function()
    if m_requestPage > m_currentPage then
      return
    end
    m_requestPage = m_requestPage + 1
    CommentsRequest(m_requestPage)
  end)
  CS.EventDelegate.Add(REF.ScrollView.UIScrollView.onPrev, function()
  end)
  REF.ContentTable.ReuseTable.onInitializeItem = UpdateSlot
  REF.ContentTable.ReuseTable.onGetChildWidget = OnBoundsCalculate
  REF.InputComment.UIInput.defaultText = WU.GetString("TeamRCMD_CommentLenLimit", maxLen)
  REF.InputComment.UIInput.characterLimit = maxLen
  WU.ToggleRendering(REF.NoData, true)
  WU.ToggleRendering(REF.SrollViewNode, false)
end

function ClearComments()
  m_requestPage = 0
  m_currentPage = 0
  m_comments = _ENV["!"]({})
  REF.ContentTable.ReuseTable:ResetPosition()
  REF.ContentTable.ReuseTable:SetDataCount(0)
end

function Reset()
  m_groupData = nil
  m_recentCopy = {}
  ClearComments()
end

function SetData(groupData)
  Reset()
  m_groupData = groupData
  if m_groupData then
    this:GameRequest("fci/share-group/copy/" .. m_groupData.groupId):Get(function(resp)
      m_recentCopy = resp.newestCopy
      InitMarquee()
    end)
  end
  REF.WidgetTeam["$SetData_A"](m_groupData)
  m_requestPage = m_requestPage + 1
  CommentsRequest(m_requestPage)
end

function OnSubmitComment()
  local content = REF.InputComment.UIInput.value
  if U.trim(content) == "" then
    return WU.ShowHintText(WU.GetString("TeamRCMD_CommentsEmpty"))
  end
  REF.InputComment.UIInput.value = ""
  this:GameRequest("fci/share-group/comments/" .. m_groupData.groupId):Post({content = content}, function(resp)
    if m_requestPage == m_currentPage then
      m_requestPage = m_requestPage + 1
      CommentsRequest(m_requestPage)
    end
  end)
end

function CommentsRequest(pageNum)
  this:GameRequest(string.format("fci/share-group/comments/%d/%d", m_groupData.groupId, pageNum)):Get(function(resp)
    UpdateData(resp.commentList, pageNum)
    m_currentPage = m_currentPage + 1
  end)
end

function UpdateData(comments, pageNum)
  if #comments == 0 then
    if m_currentPage == 0 then
      WU.ToggleRendering(REF.NoData, true)
      WU.ToggleRendering(REF.SrollViewNode, false)
    else
      WU.ShowHintText(WU.GetString("TeamRCMD_NoMoreData"))
    end
    m_currentPage = m_currentPage - 1
    m_requestPage = m_requestPage - 1
  else
    WU.ToggleRendering(REF.NoData, false)
    WU.ToggleRendering(REF.SrollViewNode, true)
    local startIndex = pageNum * PageLen - PageLen
    if #comments > PageLen then
      warning("TeamRCMD", "Message Length(" .. #comments .. ") Longer than define")
    end
    for i = 1, #comments do
      m_comments[startIndex + i] = comments[i]
    end
    REF.ContentTable.ReuseTable:SetDataCount(#m_comments)
    if m_currentPage == 0 and #comments >= #REF.ContentTable then
      REF.ContentTable.ReuseTable:ResetPosition(true)
    end
    if #comments < PageLen then
      m_currentPage = m_currentPage - 1
      m_requestPage = m_requestPage - 1
    end
  end
end

function UpdateSlot(go, wrapIndex, realIndex)
  if realIndex < #m_comments then
    local data = m_comments[realIndex + 1]
    local playerType = PB.enum.CommentPlayerType.None
    if data.playerId == m_groupData.playerId then
      playerType = PB.enum.CommentPlayerType.Up
    elseif playerId == data.playerId then
      playerType = PB.enum.CommentPlayerType.Me
    end
    _ENV["$"](go)["$$SetData"](data, playerType)
  end
end

function OnBoundsCalculate(transform)
  local ref = _ENV["$"](transform)
  return ref.Box.UIWidget
end

local m_marqueeCoroutine

function InitMarquee()
  if m_marqueeCoroutine == nil then
    m_marqueeCoroutine = coroutine.create(function()
      while true do
        local tmp = m_recentCopy
        for i = 1, #tmp do
          if tmp[i] and tmp[i].playerName then
            REF.LabelName.UILabel.text = WU.GetString("TeamRCMD_PlayerCopy", tmp[i].playerName)
            REF.RecentCopy.TweenScale:ResetToBeginning()
            REF.RecentCopy.TweenScale:PlayForward()
            coroutine.yield(false)
          else
            break
          end
          if m_recentCopy ~= tmp then
            break
          end
        end
        coroutine.yield(true)
      end
    end)
  end
  local OnAnimeFinish
  
  function OnAnimeFinish()
    local status, noData = coroutine.resume(m_marqueeCoroutine)
    if noData then
      this:DelayInvokeInSeconds(1, OnAnimeFinish)
    end
  end
  
  REF.RecentCopy.TweenScale:SetOnFinished(OnAnimeFinish)
  OnAnimeFinish()
end

function InitWindow()
  this:RegisterGameEvent("CopyTeamSuccess", OnCopyTeamSuccess)
end

function UninitWindow()
  this:UnregisterGameEvent("CopyTeamSuccess", OnCopyTeamSuccess)
  REF.RecentCopy.TweenScale:FinishImmediately()
  REF.RecentCopy.transform.localScale = CS.UnityEngine.Vector3(0, 0, 0)
end

function OnCopyTeamSuccess(groupData)
  if m_groupData.groupId == groupData.groupId then
    local playerId = this:GetData("playerId")
    for i = 1, #m_recentCopy do
      if m_recentCopy[i].playerId == playerId then
        return
      end
    end
    local baseinfo = this:GetData("fci/baseinfo")
    if baseinfo and baseinfo.name then
      table.insert(m_recentCopy, baseinfo.name)
    end
  end
end
