local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local HU = require("Common/HtmlUtil")
local CU = require("Common/ChatUtil")
local m_inFriendMode, m_dataList

function SetupWindow()
  WU.BindButtonEvent(REF.ButtonFriend, OnClickFriend)
  WU.BindButtonEvent(REF.ButtonVisitor, OnClickVisitor)
  WU.BindButtonEvent(REF.ButtonShow, OnClickShow)
  WU.BindButtonEvent(REF.ButtonRandom, OnClickRandom)
  LU.Bind(REF.WrapContent, {
    updateRow = UpdateSlot
  })
end

function InitWindow()
  WU.SetActive()
  this:BindRemote(this:GameRequest("fci/dorm-visitor/"), OnDormVisitors)
end

function OnDormVisitors()
  SetMode(true)
end

function SetMode(inFriendMode)
  m_inFriendMode = inFriendMode
  if m_inFriendMode then
    m_dataList = this:GetData("fci/friendlist/")
  else
    m_dataList = this:GetData("fci/dorm-visitor/").visitorInfo
  end
  REF.ButtonFriend.UISprite.spriteName = fif(inFriendMode, "tab_button_3_s", "tab_button_3_n")
  REF.ButtonVisitor.UISprite.spriteName = fif(not inFriendMode, "tab_button_3_s", "tab_button_3_n")
  LU.Set(REF.WrapContent, #m_dataList)
end

function UpdateSlot(goRef, wrapIndex, realIndex)
  if realIndex and m_dataList and realIndex < #m_dataList then
    goRef["$$SetData"](m_dataList[realIndex + 1], m_inFriendMode)
  end
end

function SendMsgToWorld()
  local dormName = this:GetData("fci/dorm/{playerId}").dormInfo.dormName
  local url = string.format("{\"dormPlayerId\":%s}", this:GetData("playerId"))
  dormName = string.gsub(dormName, "<", "&lt;")
  dormName = string.gsub(dormName, ">", "&gt;")
  local postData = {
    content = string.format("<font color=#fa8afe>[%s]</font>", HU.ApplyHyperLink(dormName, url)),
    channel = PB.enum.EChatChannel.World,
    worldSubChannel = this:GetData("ChatRoom/WorldSubChannel") or 0
  }
  local wireFormatTable = ProtobufT("ApiChat", postData)
  this:GameRequest("fci/chat/"):Post(wireFormatTable, function(resp)
    WU.ShowHintText("Dorm_VisitShareSucceed")
    local msgCache = this:GetData("ChatRoom/ChatContentWorld") or _ENV["!"]({})
    msgCache = CU.MergeChatContent(msgCache, {resp})
    this:SetData("ChatRoom/ChatContentWorld", msgCache)
  end)
end

function OnClickShow()
  WU.ShowMessageYesNo("Dorm_ShowDormHint", function(msg)
    if msg == "YES" then
      SendMsgToWorld()
    end
  end)
end

function OnClickFriend()
  SetMode(true)
end

function OnClickVisitor()
  SetMode(false)
end

function OnClickRandom()
  this:GameRequest("fci/dorm-visitor/"):Post(nil, function(resp)
    DB:SetData("Dorm/Host", resp)
    DB:SetData("Dorm/InVisitMode", true)
    WU.RecycleWindow(this)
  end)
end
