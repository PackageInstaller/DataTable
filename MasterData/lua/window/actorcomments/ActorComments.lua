local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local CO = require("Common/Coroutine")
local m_perPage = 5
local m_interval = 2
local m_commentInterval = 0
local m_actorId, m_curPageNumber, m_hasNext, m_smallestCommentTime
local m_comments = {}
local m_topComments = {}
local m_data, m_contentHeight, m_isWaiting
local FromViewType = {
  From_ActorWiki = 1,
  From_ActorList = 2,
  Fromt_None = 3
}
local m_fromViewType = FromViewType.Fromt_None

function SetupWindow()
  WU.BindButtonEvent(REF.SpriteSend, OnSubmitComment)
  CS.EventDelegate.Add(REF.ScrollView.UIScrollView.onNext, function()
    warning("Actor", "next page request")
    if m_hasNext then
      m_isWaiting = true
      RefreshComments(false)
      this:GameRequest("fci/comment/" .. m_actorId):Page(m_curPageNumber, m_perPage):Get(function(resp)
        if #resp == m_perPage then
          m_curPageNumber = m_curPageNumber + 1
        else
          m_hasNext = false
        end
        for i = 1, #resp do
          if m_smallestCommentTime == nil then
            m_smallestCommentTime = resp[i].info.createTime
          end
          if m_smallestCommentTime > resp[i].info.createTime then
            m_smallestCommentTime = resp[i].info.createTime
            table.insert(m_comments, resp[i])
          else
            print("Actor", "throw comment " .. table.dump(resp[i]))
          end
        end
        m_isWaiting = false
        this:DelayInvokeInSeconds(2, function()
          RefreshComments(false)
        end)
      end)
    end
  end)
  CS.EventDelegate.Add(REF.ScrollView.UIScrollView.onPrev, function()
    warning("Actor", "previous page request")
  end)
  REF.ContentTable.ReuseTable.onInitializeItem = UpdateSlot
  REF.ContentTable.ReuseTable.onGetChildWidget = OnBoundsCalculate
end

function SetWhereFrom(fromType)
  m_fromViewType = fromType
end

function InitData()
  WU.ToggleRendering(REF.ContentTable, false)
  REF.InputComment.UIInput.defaultText = WU.GetString("Window_CommentDefaultText")
  REF.LabelTitle.UIHtmlLabel.text = WU.GetString("Window_ActorCommentsTitle")
  m_curPageNumber = 0
  m_comments = {}
  m_topComments = {}
  m_smallestCommentTime = nil
  m_hasNext = true
  if m_fromViewType == FromViewType.From_ActorWiki then
    local actorID = this:GetData("ActorWikiSelected")
    m_actorId = actorID
  elseif m_fromViewType == FromViewType.From_ActorList then
    local actor = this:GetData("fci/actor/{Actor/SelectedUid}")
    m_actorId = actor.id
  end
  SetCommentsDetail()
end

function InitWindow()
  m_isWaiting = false
  this:RegisterGameEvent("CommentLiked", OnCommentLiked)
end

function UninitWindow()
  this:UnregisterGameEvent("CommentLiked", OnCommentLiked)
end

function OnCommentLiked(comment)
  local idx = table.find(m_comments, function(k, v)
    return v.info.id == comment.info.id
  end)
  if idx ~= nil then
    m_comments[idx] = comment
  end
  idx = table.find(m_topComments, function(_, v)
    return v.info.id == comment.info.id
  end)
  if idx ~= nil then
    comment.rank = m_topComments[idx].rank
    m_topComments[idx] = comment
  end
  RefreshComments(false)
end

function SetCommentsDetail()
  this:SetData("ActorComment/ActorId", m_actorId)
  local resActorConfig = PB.get("ActorConfig", m_actorId)
  if resActorConfig == nil then
    info("Actor", "resActorConfig xlsx is missing actorId " .. m_actorId)
    REF.TextureActor.UITexture.mainTexturePath = nil
  else
    REF.TextureActor.UITexture.mainTexturePath = "Texture/ActorInfightHead/main/infight_head_" .. resActorConfig.animRes
  end
  this:SetData("Actor/ActorId", m_actorId)
  this:GameRequest("fci/comment/" .. m_actorId):Page(m_curPageNumber, m_perPage):Get(OnPullingComments)
end

function OnPullingComments(resp)
  if #resp == m_perPage then
    m_curPageNumber = m_curPageNumber + 1
  else
    m_hasNext = false
  end
  for i = 1, #resp do
    if resp[i].rank == 0 and not resp[i].alwaysTop then
      table.insert(m_comments, resp[i])
    else
      table.insert(m_topComments, resp[i])
    end
    if resp[i].rank == 0 and not resp[i].alwaysTop then
      if m_smallestCommentTime == nil then
        m_smallestCommentTime = resp[i].info.createTime
      end
      if m_smallestCommentTime > resp[i].info.createTime then
        m_smallestCommentTime = resp[i].info.createTime
      end
    end
  end
  RefreshComments(true)
end

function UpdateWindow(delta)
  m_commentInterval = m_commentInterval + delta
end

function OnSubmitComment()
  if m_actorId and m_commentInterval > m_interval then
    local content = REF.InputComment.UIInput.value
    if U.trim(content) == "" then
      return
    end
    content = string.gsub(content, "<", "&lt;")
    content = string.gsub(content, ">", "&gt;")
    local postData = {content = content, like = false}
    this:GameRequest("fci/comment/" .. m_actorId):Post(postData, function(resp)
      table.insert(m_comments, 1, resp)
      REF.InputComment.UIInput.value = ""
      m_commentInterval = 0
      WU.ShowHintText(WU.GetString("Window_SubmitComment"))
      RefreshComments(true)
    end)
  end
end

function RefreshComments(goTop)
  m_data = _ENV["!"]({})
  m_data:append(m_topComments)
  table.insert(m_data, {splitLine = true})
  m_data:append(m_comments)
  if m_hasNext then
    table.insert(m_data, {isWaiting = true})
  end
  REF.ContentTable.ReuseTable:SetDataCount(#m_data)
  if goTop then
    REF.ContentTable.ReuseTable:WrapStaticData()
    REF.ScrollView.UIScrollView:ResetPosition()
  end
  WU.ToggleRendering(REF.ContentTable, true)
end

function UpdateSlot(go, wrapIndex, realIndex)
  if realIndex < #m_data then
    local data = m_data[realIndex + 1]
    local ref = _ENV["$"](go)
    if data.splitLine and not data.isWaiting then
      ref["$$SetAsSplitLine"]()
    elseif not data.splitLine and not data.isWaiting then
      ref["$$SetAsComment"](data)
    elseif data.isWaiting then
      ref["$$SetAsWaiting"](m_isWaiting)
    end
  end
end

function OnBoundsCalculate(transform)
  local ref = _ENV["$"](transform)
  if ref["@isLine"] then
    return ref.LabelNews.UILabel
  elseif ref["@isTop"] then
    return fif(ref.SpriteFront.UISprite.height > ref.LabelComment.UILabel.height, ref.SpriteFront.UISprite, ref.LabelComment.UILabel)
  elseif ref["@isWaiting"] then
    return ref.SignWaiting.UISprite
  else
    return fif(ref.NodeStar.UIWidget.height > ref.LabelComment.UILabel.height, ref.NodeStar.UIWidget, ref.LabelComment.UILabel)
  end
end
