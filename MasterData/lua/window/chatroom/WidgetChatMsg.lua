local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local HU = require("Common/HtmlUtil")
local m_data
local m_systemSpace = 10
local m_worldSpace = 10

function SetChatContent(data, type)
  if m_data ~= nil and data.id ~= nil and m_data.id == data.id then
    return
  end
  m_data = data
  REF["@type"] = 1
  REF.NPC.gameObject:SetActive(false)
  REF.MSG.gameObject:SetActive(true)
  local ref = _ENV["$"](REF.MSG)
  if type == PB.enum.EChatChannel.World then
    SetTextWorld(ref, data)
  elseif type == PB.enum.EChatChannel.System then
    SetTextSystem(ref, data)
  elseif type == PB.enum.EChatChannel.Private then
    SetTextPrivate(ref, data)
  elseif type == PB.enum.EChatChannel.Guild then
    SetTextMixed(ref, data)
  elseif type == PB.enum.EChatChannel.Group then
    SetTextWorld(ref, data)
  elseif type == PB.enum.EChatChannel.Event then
    SetTextWorld(ref, data)
  end
end

function IsImgContent(content)
  if string.find(content, "<img src=.*>") ~= nil then
    local height = REF.LabelContent.UIHtmlLabel.height / 2
    SetHeight(-height)
  end
end

function SetHeight(value)
  local v3 = REF.LabelPlayerName.transform.localPosition
  v3.y = value
  REF.LabelPlayerName.transform.localPosition = v3
end

function SetTextPrivate(ref, data)
  local content = data.content
  local senderId = data.senderId
  local applyHyperlink = this:GetData("ApplyChatRoomHyperLink")
  WU.SetActive(ref.LabelTip, data.isTitle)
  WU.SetActive(ref.LabelPlayerName, not data.isTitle)
  WU.SetActive(ref.LabelContent, not data.isTitle)
  WU.SetActive(ref.WidgetIconPlayerHeadPhoto, not data.isTitle)
  if data.isTitle == nil then
    local targetId = this:GetData("ChatRoom/PrivateTalkTarget")
    local nickName = "[" .. this:GetData("ChatRoom/PrivateTalkTargetNickName") .. "]"
    local target = fif(applyHyperlink, HU.ApplyHyperLink(nickName, "{ \"player\" : { \"id\" : \"" .. targetId .. "\"} }"), nickName)
    target = HU.ApplyFontColor(target, "#0199e9")
    if senderId == this:GetData("playerId") then
      ref.LabelPlayerName.UIHtmlLabel.text = WU.GetString("Window_TalkToPlayer", target)
      REF.WidgetIconPlayerHeadPhoto["$SetClickCallback"](nil)
    else
      ref.LabelPlayerName.UIHtmlLabel.text = WU.GetString("Window_PlayerTalkToMe", target)
      REF.WidgetIconPlayerHeadPhoto["$SetClickCallback"](function()
        WU.ShowPlayerDetailByIdOrName(senderId, "id")
      end)
    end
    if data.time ~= nil then
      REF.TimeLabel.UIHtmlLabel.text = WU.RenderTime(data.time)
    else
      REF.TimeLabel.UIHtmlLabel.text = ""
    end
    ref.LabelContent.UIHtmlLabel:UpdateAnchors()
    if applyHyperlink and data.hyperLinkPrefix then
      content = data.hyperLinkPrefix .. content .. "</a>"
    end
    local customHref = InitCustomHrefInfo(data)
    if customHref then
      content = content .. customHref
    end
    ref.LabelContent.UIHtmlLabel.text = content
    REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"]({
      playerId = senderId,
      headFrame = data.headFrame,
      headPhoto = data.headPhoto,
      socialPicture = data.socialPicture
    }, 0.6)
    REF.WidgetHeight.UIWidget.height = REF.LabelContent.UIHtmlLabel.height + REF.LabelPlayerName.UIHtmlLabel.height + m_worldSpace
  else
    ref.LabelTip.UIHtmlLabel.text = data.content
    REF.WidgetHeight.UIWidget.height = ref.LabelTip.UIHtmlLabel.height + m_systemSpace
  end
end

function SetTextMixed(ref, data)
  if data.sender == nil or U.trim(data.sender) == "" then
    SetTextSystem(ref, data)
  else
    SetTextWorld(ref, data)
  end
end

function SetTextSystem(ref, data)
  local applyHyperlink = this:GetData("ApplyChatRoomHyperLink")
  local content = data.content
  if not applyHyperlink then
    content = string.gsub(content, "a href=", "")
  end
  if ref.LabelPlayerName then
    ref.LabelPlayerName.UIHtmlLabel.text = ""
  end
  content = string.gsub(content, "\"", "\"")
  if data.time ~= nil then
    REF.TimeLabel.UIHtmlLabel.text = WU.RenderTime(data.time)
  else
    REF.TimeLabel.UIHtmlLabel.text = ""
  end
  if applyHyperlink and data.hyperLinkPrefix then
    content = data.hyperLinkPrefix .. content .. "</a>"
  end
  local customHref = InitCustomHrefInfo(data)
  if customHref then
    content = content .. customHref
  end
  local haveSender = HaveSender(data.sender, data.senderId)
  WU.SetActive(ref.LabelTip, not haveSender)
  WU.SetActive(ref.LabelPlayerName, haveSender)
  WU.SetActive(ref.LabelContent, haveSender)
  WU.SetActive(ref.WidgetIconPlayerHeadPhoto, haveSender)
  if haveSender then
    ref.LabelPlayerName.UIHtmlLabel.text = GetHTMLName(data.sender, data.senderId)
    ref.LabelContent.UIHtmlLabel.text = content
    REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"]({
      playerId = data.senderId,
      headFrame = data.headFrame,
      headPhoto = data.headPhoto,
      socialPicture = data.socialPicture
    }, 0.6)
    if data.senderId == this:GetData("playerId") then
      REF.WidgetIconPlayerHeadPhoto["$SetClickCallback"](nil)
    else
      REF.WidgetIconPlayerHeadPhoto["$SetClickCallback"](function()
        WU.ShowPlayerDetailByIdOrName(data.senderId, "id")
      end)
    end
    REF.WidgetHeight.UIWidget.height = REF.LabelContent.UIHtmlLabel.height + REF.LabelPlayerName.UIHtmlLabel.height + m_worldSpace
  else
    ref.LabelTip.UIHtmlLabel:UpdateAnchors()
    ref.LabelTip.UIHtmlLabel.text = content
    REF.WidgetHeight.UIWidget.height = REF.LabelTip.UIHtmlLabel.height + m_systemSpace
  end
end

function SetTextWorld(ref, data)
  local senderId = data.senderId
  local sender = data.sender
  local content = data.content
  local applyHyperlink = this:GetData("ApplyChatRoomHyperLink")
  local haveSender = HaveSender(sender, senderId)
  WU.SetActive(ref.LabelTip, not haveSender)
  WU.SetActive(ref.LabelPlayerName, haveSender)
  WU.SetActive(ref.LabelContent, haveSender)
  WU.SetActive(ref.WidgetIconPlayerHeadPhoto, haveSender)
  if haveSender then
    ref.LabelPlayerName.UIHtmlLabel.text = GetHTMLName(sender, senderId)
    if data.time ~= nil then
      REF.TimeLabel.UIHtmlLabel.text = WU.RenderTime(data.time)
    else
      REF.TimeLabel.UIHtmlLabel.text = ""
    end
    ref.LabelContent.UIHtmlLabel:UpdateAnchors()
    if applyHyperlink and data.hyperLinkPrefix then
      content = data.hyperLinkPrefix .. content .. "</a>"
    end
    local customHref = InitCustomHrefInfo(data)
    if customHref then
      content = content .. customHref
    end
    ref.LabelContent.UIHtmlLabel.text = content
    REF.WidgetIconPlayerHeadPhoto["$SetPlayerInfo"]({
      playerId = senderId,
      headFrame = data.headFrame,
      headPhoto = data.headPhoto,
      socialPicture = data.socialPicture
    }, 0.6)
    if senderId == this:GetData("playerId") then
      REF.WidgetIconPlayerHeadPhoto["$SetClickCallback"](nil)
    else
      REF.WidgetIconPlayerHeadPhoto["$SetClickCallback"](function()
        WU.ShowPlayerDetailByIdOrName(senderId, "id")
      end)
    end
    REF.WidgetHeight.UIWidget.height = REF.LabelContent.UIHtmlLabel.height + REF.LabelPlayerName.UIHtmlLabel.height + m_worldSpace
  else
    ref.LabelTip.UIHtmlLabel.text = data.content
    REF.WidgetHeight.UIWidget.height = ref.LabelTip.UIHtmlLabel.height + m_systemSpace
  end
end

function GetHTMLName(sender, senderId)
  local nameStr = sender or ""
  if U.trim(sender) == "" then
    nameStr = U.SplitStr(senderId, "_")[2]
  end
  local applyHyperlink = this:GetData("ApplyChatRoomHyperLink")
  nameStr = fif(applyHyperlink, HU.ApplyHyperLink(nameStr, "{ \"player\" : { \"id\" : \"" .. senderId .. "\"} }"), nameStr)
  if senderId == this:GetData("playerId") then
    nameStr = HU.ApplyFontColor(nameStr, "#03dae7")
  else
    nameStr = HU.ApplyFontColor(nameStr, "#0199e9")
  end
  return nameStr
end

function HaveSender(sender, senderId)
  return sender ~= nil and senderId ~= nil and sender ~= "" and senderId ~= ""
end

function SetNpcContent(data)
  if m_data ~= nil and m_data.id == data.id then
    return
  end
  m_data = data
  REF["@type"] = 2
  REF.NPC.gameObject:SetActive(true)
  REF.MSG.gameObject:SetActive(false)
  REF["@context"] = data
  local ref = _ENV["$"](REF.NPC)
  local role = PB.get("Role", data.npcRoleId)
  if role == nil then
    warning("Role.xlsx", "role id " .. tostring(data.npcRoleId))
    ref.NpcTexture.UITexture.enabled = false
  else
    ref.NpcTexture.UITexture.enabled = true
    ref.NpcTexture.UITexture.mainTexturePath = "Texture/ActorInfightHead/main/infight_head_" .. role.animRes
  end
  REF.TimeLabel.UIHtmlLabel.text = WU.RenderTime(data.time)
  ref.LabelContentNPC.UIHtmlLabel:UpdateAnchors()
  ref.LabelContentNPC.UIHtmlLabel.text = data.content
  REF.WidgetHeight.UIWidget.height = REF.NpcTexture.UITexture.height + m_systemSpace
end

function InitCustomHrefInfo(data)
  local result
  if data.shareTag == PB.enum.EChatShareTag.Href then
    local hrefData = JsonD(data.shareParam)
    if hrefData then
      local hrefContent = WU.GetString(hrefData.hrefContent)
      local index = string.find(hrefContent, "<font color")
      if index == nil then
        hrefContent = "<font color=#0199e9>" .. hrefContent .. "</font>"
      end
      local jsonParam = JsonE(hrefData.customParam)
      local href = string.format("<a href='{\"customEvent\":\"%s\",\"customParam\":%s}'>", hrefData.customEvent, jsonParam)
      result = href .. hrefContent .. "</a>"
    end
  end
  return result
end
