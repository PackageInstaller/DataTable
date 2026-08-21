local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local HU = require("Common/HtmlUtil")
local U = require("Common/Util")
local DBH = require("Manager/DataBindingHandler")
local TR = require("Common/TeamRCMDUtil")
local m_groupData
local m_canClickComment = true
local TypeColor = TR.TypeColor

function ResetState()
  m_groupData = nil
  WU.SetActive(REF.WidgetActorGroup, false)
end

function Start()
  WU.BindButtonEvent(REF.CommentButton, ShowDetails)
  if REF.CommentButton2 then
    WU.BindButtonEvent(REF.CommentButton2, ShowDetails)
  end
  WU.BindButtonEvent(REF.CopyButton, function()
    if m_groupData then
      WU.AcquireWindowAsync("TeamRecommendCopy", function(UI)
        _ENV["$"](UI)["$$SetData"](m_groupData)
      end)
    end
  end)
  WU.BindButtonEvent(REF.LikeButton, function()
    if m_groupData then
      if m_groupData.liked then
        WU.ShowHintText(WU.GetString("Error_ShareGroupHaveLiked"))
      else
        TR.AppraiseRequest(m_groupData, PB.enum.GroupLikeOperate.Like)
      end
    end
  end)
  if REF.DislikeButton then
    WU.BindButtonEvent(REF.DislikeButton, function()
      if m_groupData then
        if m_groupData.liked then
          WU.ShowHintText(WU.GetString("Error_ShareGroupHaveLiked"))
        else
          TR.AppraiseRequest(m_groupData, PB.enum.GroupLikeOperate.Dislike)
        end
      end
    end)
  end
end

function ShowDetails()
  if m_groupData and m_canClickComment then
    WU.AcquireWindowAsync("TeamRecommendDetails", function(UI)
      _ENV["$"](UI)["$$SetData"](m_groupData)
    end)
  end
end

function SetData_A(groupData)
  m_canClickComment = false
  SetData(groupData)
  if m_groupData and m_groupData.dislikeCount then
    REF.LabelDislikeCount.UILabel.text = WU.SimplifyNum(m_groupData.dislikeCount)
  end
end

function SetData(groupData)
  ResetState()
  m_groupData = groupData
  WU.SetActive(REF.Visual, groupData)
  if m_groupData then
    if m_groupData.actors then
      WU.SetActive(REF.WidgetActorGroup, true)
      local actors = m_groupData.actors
      for index = 1, 6 do
        local Gasketactor = REF["WidgetIconActor" .. index]
        Gasketactor["$SetActorCustom"](actors[index] or {id = -3})
      end
    end
    REF.LabelTeamName.UILabel.text = m_groupData.name
    REF.LabelUpName.UILabel.text = WU.GetString("TeamRCMD_Up") .. m_groupData.playerName
    if m_groupData.tag then
      local color = TypeColor[m_groupData.tag]
      if color then
        REF.LabelTeamType.UILabel.text = WU.GetString("TeamRCMD_Type" .. m_groupData.tag)
        REF.SpriteTeamType.UISprite.color = color
      else
        REF.LabelTeamType.UILabel.text = WU.GetString("TeamRCMD_UnknownType")
        REF.SpriteTeamType.UISprite.color = TypeColor[1]
      end
    end
    if m_groupData.uploadTime > 0 then
      REF.LabelUpTime.UILabel.text = WU.GetString("TeamRCMD_UpTime", WU.RenderTime(m_groupData.uploadTime))
    else
      REF.LabelUpTime.UILabel.text = ""
    end
    UpdateCount()
  end
end

function UpdateCount()
  REF.LabelUseCount.UILabel.text = WU.GetString("TeamRCMD_UseCount", WU.SimplifyNum(m_groupData.useCount))
  REF.LabelLikeCount.UILabel.text = WU.SimplifyNum(m_groupData.likeCount)
  REF.LabelCommentCount.UILabel.text = WU.SimplifyNum(m_groupData.commentCount)
  if REF.LabelDislikeCount then
    REF.LabelDislikeCount.UILabel.text = WU.SimplifyNum(m_groupData.dislikeCount)
  end
end

function OnEnable()
  this:RegisterGameEvent("UpdateTeamDetails", UpdateTeamDetails)
end

function OnDisable()
  this:UnregisterGameEvent("UpdateTeamDetails", UpdateTeamDetails)
end

function UpdateTeamDetails(groupData)
  if groupData.groupId == m_groupData.groupId then
    UpdateCount()
  end
end
