-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/breakorreconnect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Client = (((CS.PixelNeko).Net).TCP).Client
local InitType = Client.initType
local TimeOutType = Client.timeOutType
local TimeOutSocketType = Client.timeOutSocketType
local ExceptionType = Client.exceptionType
local OfflineType = (LuaNetManager.GetBeanDef)("protocol.common.offlinetype")
local ReconnectFSM_SdkLogin = require("logic.fsm.reconnectfsm.sdklogin")
local ReconnectFSM_QuestIPAndPort = require("logic.fsm.reconnectfsm.questipandport")
local State = {}
State.lastState = ""
State.token = nil
State.OnEnter = function(lastState)
  -- function num : 0_0 , upvalues : _ENV, State, TimeOutType, TimeOutSocketType, OfflineType, ExceptionType, InitType
  LogInfo("GameFSM", "BreakOrReconnect Enter")
  ;
  (State.FinishReconnectFSM)()
  State.lastState = lastState
  GlobalGameFSM:SetString("toLogin", "")
  local client = ((NekoData.BehaviorManager).BM_Game):GetClosedClient()
  if client then
    ((NekoData.DataManager).DM_Game):OnSetClosedClient(nil)
    local offlineInfo = client:GetOffLineInfo()
    if offlineInfo then
      local offlineInfo_Type = offlineInfo.offtype
      do
        if offlineInfo_Type == TimeOutType or offlineInfo_Type == TimeOutSocketType or offlineInfo_Type == OfflineType.HEART_OVERTIME or offlineInfo_Type == OfflineType.ACTIVE_OVERTIME or offlineInfo_Type == ExceptionType then
          State.token = client:GetToken()
          if not (((CS.PixelNeko).P1).GameApp).applicationPause then
            (State.AutoReconnect)()
          else
            ;
            (LuaNotificationCenter.AddObserver)(State, State.OnApplicationPause, Common.n_ApplicationPause, nil)
            local dialog = (DialogManager.CreateSingletonDialog)("net.secondconfirmdialog")
            dialog:PushDialogSetting(14, {offlineInfo_Type}, function()
    -- function num : 0_0_0 , upvalues : State
    (State.AutoReconnect)()
  end
, {}, function()
    -- function num : 0_0_1 , upvalues : _ENV, offlineInfo_Type, State
    ((DialogManager.CreateSingletonDialog)("login.disconnectdialog")):Init(100022, {offlineInfo_Type}, function()
      -- function num : 0_0_1_0 , upvalues : State
      (State.SetToLoginValue)("Disconnection")
    end
)
  end
, {})
          end
        else
          do
            if offlineInfo_Type == OfflineType.PLAY_TIMEOUT then
              local time = ((NekoData.BehaviorManager).BM_Game):GetLeiTingDataTotalTime()
              ;
              ((DialogManager.CreateSingletonDialog)("login.childlimitconfirmdialog")):Init(time, 4, function()
    -- function num : 0_0_2 , upvalues : State
    (State.SetToLoginValue)("Disconnection")
  end
)
            else
              do
                if offlineInfo_Type == OfflineType.LIMIT_PERIOD then
                  ((DialogManager.CreateSingletonDialog)("login.childlimitconfirmdialog")):Init(nil, 4, function()
    -- function num : 0_0_3 , upvalues : State
    (State.SetToLoginValue)("Disconnection")
  end
)
                else
                  if offlineInfo_Type == OfflineType.ANTI_BLACK then
                    local userid = (((CS.UnityEngine).PlayerPrefs).GetString)("currentUserId", "0")
                    if userid == "0" then
                      userid = (((CS.UnityEngine).PlayerPrefs).GetString)("lastUserId", "0")
                    end
                    ;
                    ((DialogManager.CreateSingletonDialog)("login.childlimitconfirmdialog")):Init(userid, -1, function()
    -- function num : 0_0_4 , upvalues : State
    (State.SetToLoginValue)("Disconnection")
  end
)
                  else
                    do
                      do
                        do
                          if offlineInfo_Type ~= InitType and offlineInfo_Type ~= OfflineType.LOG_OFF then
                            local msgId = nil
                            if offlineInfo_Type == OfflineType.MULTI_PLAYER then
                              msgId = 100020
                            else
                              if offlineInfo_Type == OfflineType.SERVER_REST then
                                msgId = 100200
                              else
                                if offlineInfo_Type == OfflineType.ACTIVE_TRY_TIMES then
                                  msgId = 100131
                                else
                                  if offlineInfo_Type == OfflineType.CUSTOMER_KICK then
                                    msgId = 100132
                                  else
                                    if offlineInfo_Type == OfflineType.FORBID_LOGIN then
                                      msgId = 100133
                                    else
                                      if offlineInfo_Type == OfflineType.FREQUENT_ENTER then
                                        msgId = 100145
                                      else
                                        if offlineInfo_Type == OfflineType.QUEUE_FULL then
                                          msgId = 100156
                                        else
                                          if offlineInfo_Type == OfflineType.SERVER_BUSY then
                                            msgId = 100157
                                          else
                                            if offlineInfo_Type == OfflineType.TIME_SPEED then
                                              msgId = 100397
                                            else
                                              msgId = 100022
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                            if msgId ~= 100133 then
                              ((DialogManager.CreateSingletonDialog)("login.disconnectdialog")):Init(msgId, {offlineInfo_Type}, function()
    -- function num : 0_0_5 , upvalues : State
    (State.SetToLoginValue)("Disconnection")
  end
)
                            else
                              local restTime = ((NekoData.BehaviorManager).BM_Login):GetForbidLoginRestTime()
                              local day = (math.floor)(restTime / 86400)
                              local hour = (math.floor)((restTime - day * 24 * 60 * 60) / 3600)
                              local min = (math.floor)((restTime - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
                              local sec = (math.floor)(restTime - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
                              ;
                              ((DialogManager.CreateSingletonDialog)("login.disconnectdialog")):Init(msgId, {day, hour, min, sec}, function()
    -- function num : 0_0_6 , upvalues : State
    (State.SetToLoginValue)("Disconnection")
  end
)
                            end
                          else
                            do
                              if offlineInfo_Type == OfflineType.LOG_OFF then
                                (State.SetToLoginValue)("Disconnection")
                              end
                            end
                          end
                          ;
                          (State.SetToLoginValue)("Disconnection")
                          ;
                          (State.SetToLoginValue)("Disconnection")
                          ;
                          ((NekoData.BehaviorManager).BM_Game):StopSpeedTask()
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

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("GameFSM", "BreakOrReconnect Exit")
end

State.SetToLoginValue = function(value)
  -- function num : 0_3 , upvalues : State, _ENV
  if State.lastState ~= "Login" then
    GlobalGameFSM:SetString("toLogin", value)
  else
    GlobalGameFSM:SetString("toLogin", value .. "FromLoginState")
  end
end

State.OnApplicationPause = function(observer, notification)
  -- function num : 0_4 , upvalues : State, _ENV
  if not notification.userInfo and State.token then
    local dialog = (DialogManager.GetDialog)("net.secondconfirmdialog")
    if dialog and dialog._confirmId and dialog._confirmId == 14 then
      dialog:OnClickConfirmBtn()
    else
      ;
      (State.AutoReconnect)()
    end
  end
end

State.OnUpdate = function()
  -- function num : 0_5 , upvalues : State, _ENV
  if State.reconnectFSM then
    (State.reconnectFSM):Update()
    if State.reconnectFSM then
      ((require("logic.fsm.reconnectfsm." .. (string.lower)((State.reconnectFSM):GetCurrentState()))).Update)()
    end
  end
end

State.AutoReconnect = function()
  -- function num : 0_6 , upvalues : State, _ENV
  if State.reconnectFSM then
    return 
  end
  State.reconnectFSM = (ReconnectFSM.Create)()
  ;
  (State.reconnectFSM):Init()
  ;
  (State.reconnectFSM):SetStateEnterCallBack(State.OnStateEnter, State)
  ;
  (State.reconnectFSM):SetStateExitCallBack(State.OnStateExit, State)
  ;
  (DialogManager.CreateSingletonDialog)("login.loginwaitdialog")
  ;
  (State.SetToLoginValue)("Reconnection")
  ;
  (LuaNotificationCenter.AddObserver)(State, State.OnUpdate, Common.n_Update, nil)
end

State.OnStateEnter = function(instance, currentState, lastState)
  -- function num : 0_7 , upvalues : _ENV, State
  ((require("logic.fsm.reconnectfsm." .. (string.lower)(currentState))).OnEnter)(State, lastState)
end

State.OnStateExit = function(instance, currentState, nextState)
  -- function num : 0_8 , upvalues : _ENV, State
  ((require("logic.fsm.reconnectfsm." .. (string.lower)(currentState))).OnExit)(State, nextState)
end

State.FinishReconnectFSM = function()
  -- function num : 0_9 , upvalues : _ENV, State, ReconnectFSM_SdkLogin, ReconnectFSM_QuestIPAndPort
  (LuaNotificationCenter.RemoveObserver)(State)
  State.reconnectFSM = nil
  State.token = nil
  ;
  (LuaNotificationCenter.RemoveObserver)(ReconnectFSM_SdkLogin)
  ;
  (LuaNotificationCenter.RemoveObserver)(ReconnectFSM_QuestIPAndPort)
end

return State

