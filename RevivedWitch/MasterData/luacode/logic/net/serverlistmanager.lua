-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/net/serverlistmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ServerListManager = {}
ServerListManager.ErrorType = {LinkFail = 1}
ServerListManager.IPServerResponseResultType = {RESULT_SUCCESS = 0, RESULT_FAIL_1 = 1, RESULT_FAIL_3 = 3, RESULT_FAIL_4 = 4, RESULT_FAIL_5 = 5, RESULT_FAIL_7 = 7, RESULT_FAIL_8 = 8}
local token, plat, domain, ipServerPort, account, channelNo, serverID = nil, nil, nil, nil, nil, nil, nil
local questRestrict = 1
local ipServerURL = "$parameter1$:$parameter2$"
local last_token, last_plat, last_account, last_channelNo = nil, nil, nil, nil
local lastLoginTime = (os.time)()
local OnIPServerResponse = function(result)
  -- function num : 0_0 , upvalues : _ENV, ipServerURL, token, plat, account, channelNo, ServerListManager, questRestrict, domain, ipServerPort, serverID
  if result ~= "Connection failed" then
    LogInfoFormat("ServerListManager", "ip server response, url is %s", ipServerURL)
    local resultJson = (JSON.decode)(result)
    if resultJson then
      LogInfoFormat("ServerListManager", "ip server response result %s, url is %s", resultJson.result, ipServerURL)
      token = nil
      plat = nil
      account = nil
      channelNo = nil
      if resultJson.result == (ServerListManager.IPServerResponseResultType).RESULT_SUCCESS then
        if resultJson.ip and resultJson.port then
          (LuaNotificationCenter.PostNotification)(Common.n_QuestIPResult, ServerListManager, result)
        else
          LogErrorFormat("ServerListManager", "ip server response ip is %s, port is %s", resultJson.ip, resultJson.port)
          ;
          ((NekoData.BehaviorManager).BM_Login):IPServerLinkFail(resultJson.result)
        end
      else
        LogErrorFormat("ServerListManager", "ip server response result %s", resultJson.result)
        ;
        ((NekoData.BehaviorManager).BM_Login):IPServerLinkFail(resultJson.result)
      end
    else
      LogErrorFormat("ServerListManager", "wrong json result %s", result)
      ;
      ((NekoData.BehaviorManager).BM_Login):IPServerLinkFail(resultJson.result)
    end
  else
    do
      questRestrict = questRestrict - 1
      if questRestrict < 0 then
        LogError("ServerListManager", "questRestrict reach the upper limit")
        ;
        ((NekoData.BehaviorManager).BM_Login):IPServerLinkFail()
        ;
        (LuaNotificationCenter.PostNotification)(Common.n_IPServerLinkFailed, ServerListManager, {errorType = (ServerListManager.ErrorType).LinkFail})
        return 
      end
      if token and plat then
        LogErrorFormat("ServerListManager", "result %s token:%s plat:%s", result, token, plat)
        ;
        (ServerListManager.QuestIPAndPort)(token, plat, domain, ipServerPort, account, channelNo, serverID, true)
      end
    end
  end
end

ServerListManager.QuestIPAndPort = function(_token, _plat, _domain, _port, _account, _channelNo, _serverID, fromServerListManager)
  -- function num : 0_1 , upvalues : _ENV, lastLoginTime, token, plat, domain, ipServerPort, account, channelNo, serverID, ipServerURL, last_token, last_plat, last_account, last_channelNo, OnIPServerResponse
  if not fromServerListManager then
    local curTime = (os.time)()
    local loginFailTimes = ((NekoData.BehaviorManager).BM_Login):GetLoginFailTimes()
    -- DECOMPILER ERROR at PC30: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC30: Unhandled construct in 'MakeBoolean' P1

    if loginFailTimes > 0 and (loginFailTimes == 1 or loginFailTimes == 2) and curTime - lastLoginTime < 1 then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100159, {1 - (curTime - lastLoginTime)})
      return 
    end
    -- DECOMPILER ERROR at PC51: Unhandled construct in 'MakeBoolean' P1

    if (loginFailTimes == 3 or loginFailTimes == 4) and curTime - lastLoginTime < 5 then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100159, {5 - (curTime - lastLoginTime)})
      return 
    end
    if curTime - lastLoginTime < 10 then
      ((NekoData.BehaviorManager).BM_Message):SendMessageById(100159, {10 - (curTime - lastLoginTime)})
      return 
    end
    lastLoginTime = curTime
    ;
    (DialogManager.CreateSingletonDialog)("login.loginwaitdialog")
  end
  do
    token = _token
    plat = _plat
    domain = _domain
    ipServerPort = _port
    if not _account then
      _account = ""
    end
    account = _account
    if not _channelNo then
      _channelNo = ""
    end
    channelNo = _channelNo
    serverID = _serverID or ""
    ipServerURL = "$parameter1$:$parameter2$"
    ipServerURL = (string.gsub)(ipServerURL, "%$parameter1%$", tostring(_domain))
    ipServerURL = (string.gsub)(ipServerURL, "%$parameter2%$", tostring(_port))
    LogInfoFormat("ServerListManager", "QuestIPAndPort url is %s token:%s, plat:%s, account:%s, channelNo:%s, serverID:%s", ipServerURL, _token, _plat, _account, channelNo, serverID)
    last_token = token
    last_plat = plat
    last_account = account
    last_channelNo = channelNo
    ;
    (LuaNetManager.HttpPostRequestAsync)(ipServerURL .. "/ip", (JSON.encode)({token = _token, plat = _plat, account = _account, channelNo = channelNo, serverID = serverID}), OnIPServerResponse)
  end
end

ServerListManager.ReQuestIPAndPort = function()
  -- function num : 0_2 , upvalues : ServerListManager, last_token, last_plat, domain, ipServerPort, last_account, last_channelNo, serverID
  (ServerListManager.QuestIPAndPort)(last_token, last_plat, domain, ipServerPort, last_account, last_channelNo, serverID, true)
end

return ServerListManager

