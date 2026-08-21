local U = require("Common/Util")
local WU, DB = require("Common/WindowUtil")()
local HU = require("Common/HtmlUtil")
local EU = require("Common/EquipUtil")
local PB = require("Common/PbHelper")
local AU = require("Common/ActorUtil")
local RU = require("Common/RedMarkUtil")
local DBH = require("Manager/DataBindingHandler")
local DU = require("Common/DungeonUtil")
local CU = {
  ChannelCache = {
    PB.get("ChatChannel", PB.enum.EChatChannel.World).maxShowNum,
    PB.get("ChatChannel", PB.enum.EChatChannel.System).maxShowNum,
    PB.get("ChatChannel", PB.enum.EChatChannel.Private).maxShowNum,
    10,
    PB.get("ChatChannel", PB.enum.EChatChannel.Guild).maxShowNum,
    PB.get("ChatChannel", PB.enum.EChatChannel.Group).maxShowNum,
    PB.get("ChatChannel", PB.enum.EChatChannel.Event).maxShowNum,
    10,
    PB.get("ChatChannel", PB.enum.EChatChannel.GuildRecruit).maxShowNum
  }
}

function CU.HandlerChatMessages(message)
  if message.channel == PB.enum.EChatChannel.World and DB:GetData("playerId") ~= message.senderId then
    OnWorldMessages({message})
  elseif message.channel == PB.enum.EChatChannel.System then
    OnSystemMessages({message})
  elseif message.channel == PB.enum.EChatChannel.Broad then
    OnBroadMessages({message})
  end
end

function CU.AddPrivateTitle(msgCache, name)
  local hint = {
    content = WU.GetString("Window_TalkWithTarget", name),
    isTitle = true
  }
  table.insert(msgCache, hint)
end

function GetChannelDataByType(type)
  if type == 1 then
    return "ChatRoom/PrivateMsg/", "NewPrivateMsg/Display"
  elseif type == 2 then
    return "GuildMsg", "NewGuildMsg/Display"
  elseif type == 3 then
    return "GuildSystemMessageRaw", "Guild/Message/System"
  elseif type == 4 then
    return "ChatRoom/ChatContentEvent", "NewEventMsg/Display"
  elseif type == 5 then
    return "ChatRoom/ChatContentGuildRecruit", "NewGuildRecruit/Display"
  end
end

function CU.HandlerNewMsg(msg, type)
  local binding, newBinding = GetChannelDataByType(type)
  if type == 1 then
    binding = binding .. msg.senderId
  end
  local msgCache = DB:GetData(binding) or _ENV["!"]({})
  if type == 1 and table.empty(msgCache) then
    CU.AddPrivateTitle(msgCache, msg.sender)
  end
  msgCache = CU.MergeChatContent(msgCache, {msg})
  DB:SetData(binding, msgCache)
  if type == 3 then
    RU.SetRedMark(newBinding, true)
  else
    DB:SetData(newBinding, true)
  end
  if type == 1 then
    local latest = CU.UpdateLatest(msg.senderId, msg.sender)
    latest.newCount = latest.newCount + 1
    DB:BroadcastGameEvent("NewPrivateMsg", msg.senderId, msg.sender)
  end
end

function CU.UpdateLatest(senderId, sender)
  local friendList = DB:GetData("fci/friendlist/")
  local isFriend = false
  if table.find(friendList, function(_, v)
    return v.playerId == senderId
  end) then
    isFriend = true
  end
  if isFriend then
    local targets = DB:GetData("ChatRoom/Friends") or {}
    targets = DBH.DBFirst(targets, "senderId", senderId)
    DB:SetData("ChatRoom/Friends", targets)
    return targets[1]
  else
    return CU.AddLatestTalkTarget(senderId, sender)
  end
end

function CU.AddLatestTalkTarget(playerId, playerName)
  local targets = DB:GetData("LatestChatTargets") or {}
  targets = DBH.DBFirst(targets, "senderId", playerId, {
    senderId = playerId,
    sender = playerName,
    newCount = 0
  })
  DB:SetData("LatestChatTargets", targets)
  return targets[1]
end

function OnBroadMessages(result)
  if table.empty(result) then
    return
  end
  CU.FilterResult(result)
  if 0 < #result then
    DB:BroadcastGameEvent("OnShowHintRollingText", result)
  end
end

function OnSystemMessages(result)
  if table.empty(result) then
    return
  end
  CU.FilterResult(result)
  CU.SystemFilterByBlacklist(result, DB:GetData("fci/blacklist/"))
  if 0 < #result then
    CU.ParseSystemMessage(result)
    local chatContent = DB:GetData("ChatRoom/ChatContentSystem") or _ENV["!"]({})
    chatContent = CU.MergeChatContent(chatContent, result)
    DB:SetData("ChatRoom/ChatContentSystem", chatContent)
    AddToGuild(result)
  end
end

function AddToGuild(messages)
  local guildId = DB:GetData("guildId")
  for i = 1, #messages do
    local message = messages[i]
    if message.guildId and message.guildId > 0 and guildId == message.guildId then
      local messageCopy = {}
      table.copy(message, messageCopy)
      messageCopy.channel = PB.enum.EChatChannel.Guild
      CU.HandlerNewMsg(messageCopy, 3)
    end
  end
end

function OnWorldMessages(result)
  if table.empty(result) then
    return
  end
  CU.FilterResult(result)
  CU.FilterSubChannel(result, DB:GetData("ChatRoom/WorldSubChannel"))
  CU.ChatContentFilterByBlacklist(result, DB:GetData("fci/blacklist/"))
  if 0 < #result then
    local chatContent = DB:GetData("ChatRoom/ChatContentWorld") or _ENV["!"]({})
    chatContent = CU.MergeChatContent(chatContent, result)
    DB:SetData("ChatRoom/ChatContentWorld", chatContent)
    DB:SetData("NewWorldMsg/Display", true)
  end
end

function CU.MergeChatContent(chatContent, newChatContent)
  table.append(chatContent, newChatContent)
  if chatContent.unreadCount == nil then
    chatContent.unreadCount = #newChatContent
  else
    chatContent.unreadCount = chatContent.unreadCount + #newChatContent
  end
  return chatContent
end

function CU.ParseSystemMessage(messages)
  for i = 1, #messages do
    local message = messages[i]
    local params = message.localStrParam
    local paramTable = {}
    if params then
      for i = 1, #params do
        local jsonText = string.sub(params[i], 3, #params[i] - 1)
        table.insert(paramTable, JsonToHtml(jsonText))
      end
      message.content = WU.GetString(message.localStr, table.unpack(paramTable))
    end
  end
end

function CU.ParseMessage(messages)
  for i = 1, #messages do
    local content = messages[i].content
    local b, e = string.find(content, "%$%(.-%)")
    while b and e do
      local jsonText = string.sub(content, b + 2, e - 1)
      local contentNew = ""
      if 1 < b then
        contentNew = string.sub(content, 1, b - 1)
      end
      contentNew = contentNew .. JsonToHtml(jsonText)
      if e < #content then
        contentNew = contentNew .. string.sub(content, e + 1, #content)
      end
      content = contentNew
      b, e = string.find(content, "%$%(.-%)")
    end
    messages[i].content = content
  end
end

function JsonToHtml(jsonText)
  local jsonObj = JsonD(jsonText)
  if jsonObj.item then
    local itemInfo = PB.get("ItemInfo", jsonObj.item.id)
    local itemName = HU.ApplyFontColor("[" .. WU.GetString("ItemName_" .. jsonObj.item.id) .. "]", EU.GetQualityColorString(itemInfo.quality))
    return HU.ApplyHyperLink(itemName, jsonText)
  elseif jsonObj.equip then
    local equipInfo = PB.get("EquipInfo", jsonObj.equip.id)
    if equipInfo then
      local equipName = HU.ApplyFontColor("[" .. WU.GetString("EquipName_" .. jsonObj.equip.id) .. "]", EU.GetQualityColorString(equipInfo.quality))
      return HU.ApplyHyperLink(equipName, jsonText)
    else
      return ""
    end
  elseif jsonObj.achievement then
    local achievementName = WU.GetString("AchievementName_" .. jsonObj.achievement.id)
    return HU.ApplyHyperLink(achievementName, jsonText)
  elseif jsonObj.actor then
    local actorName = HU.ApplyFontColor("[" .. WU.GetString("ActorName_" .. jsonObj.actor.id) .. "]", EU.GetQualityColorString(jsonObj.actor.quality))
    return HU.ApplyHyperLink(actorName, jsonText)
  elseif jsonObj.player then
    local playerName = jsonObj.player.name
    return HU.ApplyHyperLink(playerName, jsonText)
  elseif jsonObj.dungeon then
    local activeName = ""
    if jsonObj.dungeon.activeId then
      activeName = WU.GetString("Activity_Id_Name_" .. jsonObj.dungeon.activeId)
    end
    local dungeonName = WU.GetString("DungeonName_" .. jsonObj.dungeon.id)
    return activeName .. dungeonName
  elseif jsonObj.gacha then
    local gachaName = WU.GetString("WindowGacha_Mode" .. jsonObj.gacha.id)
    return gachaName
  end
end

function CU.HandleObjectHyperLink(jsonObj)
  if jsonObj.item then
    WU.ShowItemDetail(jsonObj.item.id)
  elseif jsonObj.equip then
    WU.AcquireWindowAsync("EquipDetail", function(window)
      _ENV["$"](window)["$$SetEquipSystemRaw"](jsonObj.equip)
    end)
  elseif jsonObj.achievement then
    WU.AcquireWindowAsync("AchievementDetail", function(window)
      _ENV["$"](window)["$$SetViewRaw"](jsonObj.achievement)
    end)
  elseif jsonObj.actor then
    WU.AcquireWindowAsync("ItemDetail", function(ui)
      _ENV["$"](ui)["$$SetActorInfo"](jsonObj.actor.id, jsonObj.actor.quality)
    end)
  elseif jsonObj.player then
    if jsonObj.player.id ~= DB:GetData("playerId") then
      WU.ShowPlayerDetailByIdOrName(jsonObj.player.id, "id")
    end
  elseif jsonObj.dungeonTeam then
    local function Join()
      DU.IsInDungeonTeamPrepare(function()
        DU.SetDungeonTeamUrl(jsonObj.dungeonTeam.url)
        
        WU.AcquireWindowAsync("DungeonTeamPrepare", function(ui)
          _ENV["$"](ui)["$$JoinRoom"](jsonObj.dungeonTeam.roomId, jsonObj.dungeonTeam.activityId, jsonObj.dungeonTeam.dungeonId)
          _ENV["$"](ui)["$$InitBackAndHomeCallback"]()
        end)
      end)
    end
    
    if DB:GetData("DungeonTeamInviteHint/Hide") then
      WU.ShowHintText(WU.GetString("DungeonTeam_EnterDungeonForbid"))
      return
    elseif not DU.IsWaitingForJob(Join) then
      Join()
    end
  elseif jsonObj.event then
    WU.AcquireWindowAsync("TriggeredEvent", function(ui)
      _ENV["$"](ui)["$$FocusOn"](jsonObj.event.eventKey)
    end)
  elseif jsonObj.dormPlayerId then
    if tostring(jsonObj.dormPlayerId) ~= DB:GetData("playerId") then
      DB:GameRequest("fci/dorm/" .. jsonObj.dormPlayerId):Get(function(resp)
        DB:SetData("Dorm/Host", resp)
        WU.AcquireWindowAsync("Dorm", function()
          DB:SetData("Dorm/InVisitMode", true)
        end)
      end)
    end
  elseif jsonObj.customEvent then
    local jsonData
    if jsonObj.customParam then
      jsonData = JsonD(jsonObj.customParam)
    end
    CS.GameEvent.Instance:Broadcast(jsonObj.customEvent, jsonData)
  end
end

function CU.FilterSubChannel(result, subChannel)
  for i = #result, 1, -1 do
    if result[i].subChannelId ~= subChannel then
      table.remove(result, i)
    end
  end
end

function CU.FilterResult(result)
  if CS.ResourceManager.Instance.ConstConfig.Debug.DisplayAllMessages then
    return result
  end
  local loginTime = DB:GetData("GameLoginTime")
  for i = #result, 1, -1 do
    if loginTime and loginTime > result[i].time then
      table.remove(result, i)
    end
  end
end

function CU.SystemFilterByBlacklist(result, blacklist)
  for i = #result, 1, -1 do
    local content = result[i].content
    for match in string.gmatch(content, "%$%(.-%)") do
      local jsonText = string.sub(match, 3, #match - 1)
      local jsonObj = JsonD(jsonText)
      if jsonObj.player then
        do
          local find = table.find(blacklist, function(k, v)
            return v.playerId == jsonObj.player.id
          end)
          if find ~= nil then
            table.remove(result, i)
            break
          end
        end
      end
    end
  end
end

function CU.ChatContentFilterByBlacklist(newContent, blacklist)
  for i = #newContent, 1 do
    if table.find(blacklist, function(k, v)
      return newContent[i].senderId == v.playerId
    end) then
      table.remove(newContent, i)
    end
  end
end

function CU.SearchPrivateTalkTarget()
  local targets = DB:GetData("ChatRoom/Friends") or {}
  local _, target = table.find(targets, function(_, v)
    return v.newCount ~= nil and v.newCount > 0
  end)
  if target ~= nil and target.newCount ~= nil and target.newCount > 0 then
    return target.senderId, target.sender, true
  else
    targets = DB:GetData("LatestChatTargets") or {}
    local _, stranger = table.find(targets, function(_, v)
      return v.newCount ~= nil and v.newCount > 0
    end)
    if stranger ~= nil and stranger.newCount ~= nil and stranger.newCount > 0 then
      return stranger.senderId, stranger.sender, false
    end
  end
end

function CU.PrivateTalk(target)
  local function targetEvent()
    if CS.GameEvent.Instance ~= nil then
      CS.GameEvent.Instance:Broadcast("OnPrivateTalk", target.playerId, target.name)
    end
  end
  
  local top = WU.TopWindow()
  if top and top.name ~= "ChatRoom" then
    DB:SetData("ApplyChatRoomHyperLink", true)
    WU.AcquireWindowAsync("ChatRoom", function(window)
      targetEvent()
    end)
  else
    targetEvent()
  end
end

function CU.CheckChatContentLimit(content, channel)
  if #content > CU.ChannelCache[channel] then
    local capacity = CU.ChannelCache[channel] / 2
    local delCount = #content - capacity
    while 0 < delCount do
      table.remove(content, 1)
      delCount = delCount - 1
    end
  end
end

function CU.AddChannelSwitchMsg(messages)
  local chatContent = DB:GetData("ChatRoom/ChatContentWorld") or _ENV["!"]({})
  chatContent = CU.MergeChatContent(chatContent, messages)
  DB:SetData("ChatRoom/ChatContentWorld", chatContent)
end

function CU.OnAsyncPvpVideoShare(channel, dunUid)
  DB:SetData("ApplyChatRoomHyperLink", true)
  WU.AcquireWindowAsync("ChatRoom", function(window)
    _ENV["$"](window)["$$OnAsyncPvpVideoShare"](channel, dunUid)
  end)
end

return CU
