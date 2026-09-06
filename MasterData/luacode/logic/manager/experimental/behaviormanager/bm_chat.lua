local GraphicsCommand = CS.PixelNeko.P1.Render.GraphicsCommand
local perf = require("perf.profiler")
local SysConfigEnum = LuaNetManager.GetBeanDef("protocol.user.sysconfig")
local CGuildEmoji = BeanManager.GetTableByName("guild.cguildemoji")
local CEmojiItem = BeanManager.GetTableByName("item.cemojiitem")
local BM_Chat = class("BM_Chat")

function BM_Chat:Ctor()
  self._chatData = NekoData.Data.chat
  self._popMsgDlg = nil
  self._luaTest = nil
  self._maxLineOutPannel = 4
end

function BM_Chat:GetChannelChatData(channel)
  return self._chatData[channel]
end

function BM_Chat:GetChannelChatDataOut(channel)
  local outData = {}
  local total = #self._chatData[channel]
  for i, v in ipairs(self._chatData[channel]) do
    if total - i < self._maxLineOutPannel then
      table.insert(outData, v)
    end
  end
  return outData
end

function BM_Chat:GetSubChannel()
  return self._chatData._subChannel
end

function BM_Chat:GetWorldChatSwitch()
  return self._chatData._worldchatswitch
end

function BM_Chat:PopChatMsg(chatdata)
  if not NekoData.BehaviorManager.BM_Game:GetShowChannelPop(chatdata.channel) then
    return
  end
  local popBack
  local dialogName = "base.basemainui"
  local mainUIDlg = DialogManager.GetDialog("base.basemainui")
  if not mainUIDlg then
    mainUIDlg = DialogManager.GetDialog("dungeon.dungeonhud")
    dialogName = "dungeon.dungeonhud"
  end
  if mainUIDlg and mainUIDlg:IsActive() then
    popBack = mainUIDlg:GetMsgPopBack()
  end
  if not popBack then
    return
  end
  local dialog = DialogManager.GetDialog("chat.msgpopdialog")
  dialog = dialog or DialogManager.CreateSingletonChildDialog("chat.msgpopdialog", dialogName, popBack)
  dialog:AddPopMsg(chatdata)
end

function BM_Chat:SendMsg(msg, emojiId, channel)
  if msg == nil then
    msg = ""
  end
  if global_var_debug then
    if string.find(msg, "client") then
      if string.find(msg, "opencall") then
        if NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasCallActivityManagerID):GetIsOpen() then
          if NekoData.BehaviorManager.BM_Game:ShowLocalTips(DataCommon.LocalTips.ChristmasCallActivityUnlock) then
            local sceneController = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.Base)
            if sceneController then
              sceneController._baseMainFSM:SetNumber("storyId", DataCommon.ChristmasCallTimeLineId)
            end
          else
            DialogManager.CreateSingletonDialog("activity.chrismascall.maindialog")
            NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.ChristmasCallActivityUnlock)
          end
        else
          NekoData.BehaviorManager.BM_Message:SendMessageById(100439)
        end
      end
      if string.find(msg, "client_npcchat") then
        local temp = {}
        for s in string.gmatch(msg, "%d+") do
          table.insert(temp, s)
        end
        if #temp == 1 then
          DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog"):SetDialogLibraryId(tonumber(temp[1]))
        elseif #temp == 2 then
          DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog"):SetDialogLibraryId(tonumber(temp[1]), false, tonumber(temp[2]))
        end
        return
      end
      if string.find(msg, "client_syschat") then
        local id = string.match(msg, "%d+")
        NekoData.BehaviorManager.BM_Message:SendMessageById(tonumber(id))
        return
      end
      if msg:find("flyto2") then
        for strx, stry in msg:gmatch("flyto2 (%d+) (%d+)") do
          local x = tonumber(strx)
          local y = tonumber(stry)
          if math.type(x) ~= "integer" or math.type(y) ~= "integer" then
            return
          end
          if x < 0 or y < 0 then
            return
          end
          EffectFactory.CreateFlyToEffect("[actor]", x, y, true):Run()
        end
      end
      if msg:find("unlockbook") then
        NekoData.BehaviorManager.BM_HandBook._allUnlock = true
        return
      end
      if msg:find(" movetype ") then
        local type = string.match(msg, "%d+")
        local map = {
          [SysConfigEnum.moveType] = tonumber(type)
        }
        NekoData.BehaviorManager.BM_Game:SetSystemConfig(map)
        return
      end
      if msg:find("buydiamod") then
        local cBuyDiamod = LuaNetManager.CreateProtocol("protocol.charge.cbuydiamond")
        if cBuyDiamod then
          cBuyDiamod.goodId = 2
          cBuyDiamod:Send()
        end
        return
      end
      if string.find(msg, "openwinaccount") then
        local id = string.match(msg, "%d+")
        DialogManager.DestroySingletonDialog("battle.battleaccount.battlewinaccountdialog")
        local dialog = DialogManager.CreateSingletonDialog("battle.battleaccount.battlewinaccountdialog")
        if dialog then
          dialog:Show(true, tonumber(id))
        end
        return
      end
      if string.find(msg, "fash") then
        local id = tonumber(string.match(msg, "%d+"))
        DialogManager.CreateSingletonDialog("shop.fashionbuyresultdialog"):SetData({itemId = id})
        return
      end
      if string.find(msg, "daynight") then
        local value = string.match(msg, "%d+")
        SceneManager.SetForceDay(tonumber(value))
      end
      if msg:find("cleanaudio") then
        CS.UnityEngine.PlayerPrefs.DeleteKey("audieName")
        return
      end
      if msg:find("monthcard") then
        local dialog = DialogManager.CreateSingletonDialog("shop.monthcarddiscountdialog")
      end
      if string.find(msg, "client_showfuncunlock") then
        local id = string.match(msg, "%d+")
        NekoData.BehaviorManager.BM_Message:PopFunctionUnlockDialog(tonumber(id))
        NekoData.BehaviorManager.BM_Message:ShowFunctionUnlockDialog()
        return
      end
      return
    elseif string.find(msg, "~~") then
      GraphicsCommand.HandleCommand(msg)
      return
    end
  end
  if msg == "" and emojiId == nil then
    LogInfo("BM_Chat", "You must input some message")
  elseif string.find(msg, "//") == 1 then
    local csend = LuaNetManager.CreateProtocol("protocol.gm.csendcommand")
    csend.cmd = msg
    csend:Send()
  elseif string.find(msg, "testproto") == 1 then
    local params = string.split(msg, " ")
    if #params ~= 3 then
      NekoData.BehaviorManager.BM_Message:AddMessageTip("wrong format: testproto 127.0.0.1 6677")
      return
    end
    LuaNetManager.ConnectToProtoDbgServer(params[2], tonumber(params[3]))
  elseif string.find(msg, "dis testproto") then
    LuaNetManager.SwitchDbgProto(false)
  elseif string.find(msg, "enable testproto") then
    LuaNetManager.SwitchDbgProto(true)
  else
    local hyperlinks = {}
    if emojiId ~= nil and 0 < emojiId then
      local hyperlink = LuaNetManager.GetBeanDef("protocol.chat.hyperlink")
      hyperlinks[1] = hyperlink
      hyperlinks[1].linkType = hyperlink.EMOJI
      hyperlinks[1].linkText = emojiId
      hyperlinks[1].userId = 0
    end
    local csend = LuaNetManager.CreateProtocol("protocol.chat.csendchatmsg")
    csend.channelType = channel
    csend.msg = msg
    csend.hyperlinks = hyperlinks
    csend:Send()
  end
end

function BM_Chat:IsLuaTestStart()
  return self._luaTest
end

function BM_Chat:StartLuaTest()
  if not self._luaTest then
    perf.start()
    self._luaTest = true
  end
end

function BM_Chat:StopLuaTest()
  if self._luaTest then
    perf.stop()
    self._luaTest = nil
  end
end

function BM_Chat:GetGuideCommentCache()
  return self._chatData._guideCommentCache
end

function BM_Chat:GetGuideCommentType()
  return self._chatData._guideCommentType
end

function BM_Chat:GetShowEmojiTypes()
  local result = {}
  local allIDs = CEmojiItem:GetAllIds()
  for i, v in ipairs(allIDs) do
    local record = CEmojiItem:GetRecorder(v)
    if not table.contain(result, record.type) and (record.itemId == 0 or table.indexof(self._chatData._emojiInfo, v)) then
      table.insert(result, record.type)
    end
  end
  return result
end

function BM_Chat:GetEmojisByType(type)
  local result = {}
  local allIDs = CEmojiItem:GetAllIds()
  for i, v in ipairs(allIDs) do
    local record = CEmojiItem:GetRecorder(v)
    if record.type == type and (record.itemId == 0 or table.indexof(self._chatData._emojiInfo, record.id)) then
      local data = string.split(record.emojiIds, "-")
      if #data == 2 then
        local op = tonumber(data[1])
        local ep = tonumber(data[2])
        for i = op, ep do
          table.insert(result, i)
        end
      elseif #data == 1 then
        table.insert(result, tonumber(record.emojiIds))
      else
        LogErrorFormat("BM_Chat", "Error Id:%s In CEmojiItem ", v)
      end
    end
  end
  return result
end

return BM_Chat
