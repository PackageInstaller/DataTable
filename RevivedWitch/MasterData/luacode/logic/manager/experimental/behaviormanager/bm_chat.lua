-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/bm_chat.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GraphicsCommand = (((CS.PixelNeko).P1).Render).GraphicsCommand
local perf = require("perf.profiler")
local SysConfigEnum = (LuaNetManager.GetBeanDef)("protocol.user.sysconfig")
local CGuildEmoji = (BeanManager.GetTableByName)("guild.cguildemoji")
local CEmojiItem = (BeanManager.GetTableByName)("item.cemojiitem")
local BM_Chat = class("BM_Chat")
BM_Chat.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._chatData = (NekoData.Data).chat
  self._popMsgDlg = nil
  self._luaTest = nil
end

BM_Chat.GetChannelChatData = function(self, channel)
  -- function num : 0_1
  return (self._chatData)[channel]
end

BM_Chat.GetSubChannel = function(self)
  -- function num : 0_2
  return (self._chatData)._subChannel
end

BM_Chat.PopChatMsg = function(self, chatdata)
  -- function num : 0_3 , upvalues : _ENV
  if not ((NekoData.BehaviorManager).BM_Game):GetShowChannelPop(chatdata.channel) then
    return 
  end
  local popBack = nil
  local dialogName = "base.basemainui"
  local mainUIDlg = (DialogManager.GetDialog)("base.basemainui")
  if not mainUIDlg then
    mainUIDlg = (DialogManager.GetDialog)("dungeon.dungeonhud")
    dialogName = "dungeon.dungeonhud"
  end
  if mainUIDlg and mainUIDlg:IsActive() then
    popBack = mainUIDlg:GetMsgPopBack()
  end
  if not popBack then
    return 
  end
  local dialog = (DialogManager.GetDialog)("chat.msgpopdialog")
  if not dialog then
    dialog = (DialogManager.CreateSingletonChildDialog)("chat.msgpopdialog", dialogName, popBack)
  end
  dialog:AddPopMsg(chatdata)
end

BM_Chat.SendMsg = function(self, msg, channel)
  -- function num : 0_4 , upvalues : _ENV, SysConfigEnum, GraphicsCommand
  if global_var_debug then
    if (string.find)(msg, "client") then
      if (string.find)(msg, "opencall") then
        if (((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.ChristmasCallActivityManagerID)):GetIsOpen() then
          if ((NekoData.BehaviorManager).BM_Game):ShowLocalTips((DataCommon.LocalTips).ChristmasCallActivityUnlock) then
            local sceneController = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).Base)
            if sceneController then
              (sceneController._baseMainFSM):SetNumber("storyId", DataCommon.ChristmasCallTimeLineId)
            end
          else
            do
              ;
              (DialogManager.CreateSingletonDialog)("activity.chrismascall.maindialog")
              ;
              ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).ChristmasCallActivityUnlock)
              ;
              ((NekoData.BehaviorManager).BM_Message):SendMessageById(100439)
              do
                if (string.find)(msg, "client_npcchat") then
                  local temp = {}
                  for s in (string.gmatch)(msg, "%d+") do
                    (table.insert)(temp, s)
                  end
                  if #temp == 1 then
                    ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(tonumber(temp[1]))
                  else
                    if #temp == 2 then
                      ((DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")):SetDialogLibraryId(tonumber(temp[1]), false, tonumber(temp[2]))
                    end
                  end
                  return 
                end
                do
                  if (string.find)(msg, "client_syschat") then
                    local id = (string.match)(msg, "%d+")
                    ;
                    ((NekoData.BehaviorManager).BM_Message):SendMessageById(tonumber(id))
                    return 
                  end
                  if msg:find("flyto2") then
                    for strx,stry in msg:gmatch("flyto2 (%d+) (%d+)") do
                      local x = tonumber(strx)
                      local y = tonumber(R10_PC158)
                      R10_PC158 = math
                      R10_PC158 = R10_PC158.type
                      R10_PC158 = R10_PC158(x)
                      if R10_PC158 == "integer" then
                        R10_PC158 = math
                        R10_PC158 = R10_PC158.type
                        R10_PC158 = R10_PC158(y)
                      end
                      if R10_PC158 ~= "integer" then
                        return 
                      end
                      if x < 0 or y < 0 then
                        return 
                      end
                      R10_PC158 = EffectFactory
                      R10_PC158 = R10_PC158.CreateFlyToEffect
                      R10_PC158 = R10_PC158("[actor]", x, y, true)
                      R10_PC158(R10_PC158)
                    end
                  end
                  do
                    -- DECOMPILER ERROR at PC196: Confused about usage of register: R3 in 'UnsetPending'

                    if msg:find("unlockbook") then
                      ((NekoData.BehaviorManager).BM_HandBook)._allUnlock = true
                      return 
                    end
                    if msg:find(" movetype ") then
                      local type = (string.match)(msg, "%d+")
                      local map = {[SysConfigEnum.moveType] = tonumber(type)}
                      ;
                      ((NekoData.BehaviorManager).BM_Game):SetSystemConfig(map)
                      return 
                    end
                    do
                      do
                        if msg:find("buydiamod") then
                          local cBuyDiamod = (LuaNetManager.CreateProtocol)("protocol.charge.cbuydiamond")
                          if cBuyDiamod then
                            cBuyDiamod.goodId = 2
                            cBuyDiamod:Send()
                          end
                          return 
                        end
                        if (string.find)(msg, "openwinaccount") then
                          local id = (string.match)(msg, "%d+")
                          ;
                          (DialogManager.DestroySingletonDialog)("battle.battleaccount.battlewinaccountdialog")
                          local dialog = (DialogManager.CreateSingletonDialog)("battle.battleaccount.battlewinaccountdialog")
                          if dialog then
                            dialog:Show(true, tonumber(id))
                          end
                          return 
                        end
                        do
                          do
                            if (string.find)(msg, "fash") then
                              local id = tonumber((string.match)(msg, "%d+"))
                              ;
                              ((DialogManager.CreateSingletonDialog)("shop.fashionbuyresultdialog")):SetData({itemId = id})
                              return 
                            end
                            do
                              if (string.find)(msg, "daynight") then
                                local value = (string.match)(msg, "%d+")
                                ;
                                (SceneManager.SetForceDay)(tonumber(value))
                              end
                              if msg:find("cleanaudio") then
                                (((CS.UnityEngine).PlayerPrefs).DeleteKey)("audieName")
                                return 
                              end
                              do
                                if msg:find("monthcard") then
                                  local dialog = (DialogManager.CreateSingletonDialog)("shop.monthcarddiscountdialog")
                                end
                                do
                                  if (string.find)(msg, "client_showfuncunlock") then
                                    local id = (string.match)(msg, "%d+")
                                    ;
                                    ((NekoData.BehaviorManager).BM_Message):PopFunctionUnlockDialog(tonumber(id))
                                    ;
                                    ((NekoData.BehaviorManager).BM_Message):ShowFunctionUnlockDialog()
                                    return 
                                  end
                                  do return  end
                                  if (string.find)(msg, "~~") then
                                    (GraphicsCommand.HandleCommand)(msg)
                                    return 
                                  end
                                  if msg == "" then
                                    LogInfo("BM_Chat", "You must input some message")
                                  else
                                    if (string.find)(msg, "//") == 1 then
                                      local csend = (LuaNetManager.CreateProtocol)("protocol.gm.csendcommand")
                                      csend.cmd = msg
                                      csend:Send()
                                    else
                                      do
                                        if (string.find)(msg, "testproto") == 1 then
                                          local params = (string.split)(msg, " ")
                                          if #params ~= 3 then
                                            ((NekoData.BehaviorManager).BM_Message):AddMessageTip("wrong format: testproto 127.0.0.1 6677")
                                            return 
                                          end
                                          ;
                                          (LuaNetManager.ConnectToProtoDbgServer)(params[2], tonumber(params[3]))
                                        else
                                          do
                                            if (string.find)(msg, "dis testproto") then
                                              (LuaNetManager.SwitchDbgProto)(false)
                                            else
                                              if (string.find)(msg, "enable testproto") then
                                                (LuaNetManager.SwitchDbgProto)(true)
                                              else
                                                local csend = (LuaNetManager.CreateProtocol)("protocol.chat.csendchatmsg")
                                                csend.channelType = channel
                                                csend.msg = msg
                                                csend:Send()
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BM_Chat.IsLuaTestStart = function(self)
  -- function num : 0_5
  return self._luaTest
end

BM_Chat.StartLuaTest = function(self)
  -- function num : 0_6 , upvalues : perf
  if not self._luaTest then
    (perf.start)()
    self._luaTest = true
  end
end

BM_Chat.StopLuaTest = function(self)
  -- function num : 0_7 , upvalues : perf
  if self._luaTest then
    (perf.stop)()
    self._luaTest = nil
  end
end

BM_Chat.GetGuideCommentCache = function(self)
  -- function num : 0_8
  return (self._chatData)._guideCommentCache
end

BM_Chat.GetGuideCommentType = function(self)
  -- function num : 0_9
  return (self._chatData)._guideCommentType
end

BM_Chat.GetShowEmojiTypes = function(self)
  -- function num : 0_10 , upvalues : CEmojiItem, _ENV
  local result = {}
  local allIDs = CEmojiItem:GetAllIds()
  for i,v in ipairs(allIDs) do
    local record = CEmojiItem:GetRecorder(v)
    if not (table.contain)(result, record.type) and (record.itemId == 0 or (table.indexof)((self._chatData)._emojiInfo, v)) then
      (table.insert)(result, record.type)
    end
  end
  return result
end

BM_Chat.GetEmojisByType = function(self, type)
  -- function num : 0_11 , upvalues : CEmojiItem, _ENV
  local result = {}
  local allIDs = CEmojiItem:GetAllIds()
  for i,v in ipairs(allIDs) do
    local record = CEmojiItem:GetRecorder(v)
    if record.type == type and (record.itemId == 0 or (table.indexof)((self._chatData)._emojiInfo, record.id)) then
      local data = (string.split)(record.emojiIds, "-")
      if #data == 2 then
        local op = tonumber(data[1])
        local ep = tonumber(data[2])
        for i = op, ep do
          (table.insert)(result, i)
        end
      else
        do
          do
            if #data == 1 then
              (table.insert)(result, tonumber(record.emojiIds))
            else
              LogErrorFormat("BM_Chat", "Error Id:%s In CEmojiItem ", v)
            end
            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out DO_STMT

            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_ELSE_STMT

            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_THEN_STMT

            -- DECOMPILER ERROR at PC67: LeaveBlock: unexpected jumping out IF_STMT

          end
        end
      end
    end
  end
  return result
end

return BM_Chat

