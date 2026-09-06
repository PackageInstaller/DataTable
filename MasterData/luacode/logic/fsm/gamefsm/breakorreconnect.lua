local Client = CS.PixelNeko.Net.TCP.Client
local InitType = Client.initType
local TimeOutType = Client.timeOutType
local TimeOutSocketType = Client.timeOutSocketType
local ExceptionType = Client.exceptionType
local OfflineType = LuaNetManager.GetBeanDef("protocol.common.offlinetype")
local ReconnectFSM_SdkLogin = require("logic.fsm.reconnectfsm.sdklogin")
local ReconnectFSM_QuestIPAndPort = require("logic.fsm.reconnectfsm.questipandport")
local State = {}
State.lastState = ""
State.token = nil

function State.OnEnter(lastState)
  LogInfo("GameFSM", "BreakOrReconnect Enter")
  State.FinishReconnectFSM()
  State.lastState = lastState
  GlobalGameFSM:SetString("toLogin", "")
  local client = NekoData.BehaviorManager.BM_Game:GetClosedClient()
  if client then
    NekoData.DataManager.DM_Game:OnSetClosedClient(nil)
    local offlineInfo = client:GetOffLineInfo()
    if offlineInfo then
      local offlineInfo_Type = offlineInfo.offtype
      if offlineInfo_Type == TimeOutType or offlineInfo_Type == TimeOutSocketType or offlineInfo_Type == OfflineType.HEART_OVERTIME or offlineInfo_Type == OfflineType.ACTIVE_OVERTIME or offlineInfo_Type == ExceptionType then
        State.token = client:GetToken()
        if not CS.PixelNeko.P1.GameApp.applicationPause then
          State.AutoReconnect()
        else
          LuaNotificationCenter.AddObserver(State, State.OnApplicationPause, Common.n_ApplicationPause, nil)
          local dialog = DialogManager.CreateSingletonDialog("net.secondconfirmdialog")
          dialog:PushDialogSetting(14, {offlineInfo_Type}, function()
            State.AutoReconnect()
          end, {}, function()
            DialogManager.CreateSingletonDialog("login.disconnectdialog"):Init(100022, {offlineInfo_Type}, function()
              State.SetToLoginValue("Disconnection")
            end)
          end, {})
        end
      elseif offlineInfo_Type == OfflineType.PLAY_TIMEOUT then
        local time = NekoData.BehaviorManager.BM_Game:GetLeiTingDataTotalTime()
        DialogManager.CreateSingletonDialog("login.childlimitconfirmdialog"):Init(time, 4, function()
          State.SetToLoginValue("Disconnection")
        end)
      elseif offlineInfo_Type == OfflineType.LIMIT_PERIOD then
        DialogManager.CreateSingletonDialog("login.childlimitconfirmdialog"):Init(nil, 4, function()
          State.SetToLoginValue("Disconnection")
        end)
      elseif offlineInfo_Type == OfflineType.ANTI_BLACK then
        local userid = CS.UnityEngine.PlayerPrefs.GetString("currentUserId", "0")
        if userid == "0" then
          userid = CS.UnityEngine.PlayerPrefs.GetString("lastUserId", "0")
        end
        DialogManager.CreateSingletonDialog("login.childlimitconfirmdialog"):Init(userid, -1, function()
          State.SetToLoginValue("Disconnection")
        end)
      elseif offlineInfo_Type ~= InitType and offlineInfo_Type ~= OfflineType.LOG_OFF then
        local msgId
        if offlineInfo_Type == OfflineType.MULTI_PLAYER then
          msgId = 100020
        elseif offlineInfo_Type == OfflineType.SERVER_REST then
          msgId = 100200
        elseif offlineInfo_Type == OfflineType.ACTIVE_TRY_TIMES then
          msgId = 100131
        elseif offlineInfo_Type == OfflineType.CUSTOMER_KICK then
          msgId = 100132
        elseif offlineInfo_Type == OfflineType.FORBID_LOGIN then
          msgId = 100133
        elseif offlineInfo_Type == OfflineType.FREQUENT_ENTER then
          msgId = 100145
        elseif offlineInfo_Type == OfflineType.QUEUE_FULL then
          msgId = 100156
        elseif offlineInfo_Type == OfflineType.SERVER_BUSY then
          msgId = 100157
        elseif offlineInfo_Type == OfflineType.TIME_SPEED then
          msgId = 100397
        else
          msgId = 100022
        end
        if msgId ~= 100133 then
          DialogManager.CreateSingletonDialog("login.disconnectdialog"):Init(msgId, {offlineInfo_Type}, function()
            State.SetToLoginValue("Disconnection")
          end)
        else
          local restTime = NekoData.BehaviorManager.BM_Login:GetForbidLoginRestTime()
          local day = math.floor(restTime / 86400)
          local hour = math.floor((restTime - day * 24 * 60 * 60) / 3600)
          local min = math.floor((restTime - day * 24 * 60 * 60 - hour * 60 * 60) / 60)
          local sec = math.floor(restTime - day * 24 * 60 * 60 - hour * 60 * 60 - min * 60)
          DialogManager.CreateSingletonDialog("login.disconnectdialog"):Init(msgId, {
            day,
            hour,
            min,
            sec
          }, function()
            State.SetToLoginValue("Disconnection")
          end)
        end
      elseif offlineInfo_Type == OfflineType.LOG_OFF then
        State.SetToLoginValue("Disconnection")
      end
    else
      State.SetToLoginValue("Disconnection")
    end
  else
    State.SetToLoginValue("Disconnection")
  end
  NekoData.BehaviorManager.BM_Game:StopSpeedTask()
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "BreakOrReconnect Exit")
end

function State.SetToLoginValue(value)
  if State.lastState ~= "Login" then
    GlobalGameFSM:SetString("toLogin", value)
  else
    GlobalGameFSM:SetString("toLogin", value .. "FromLoginState")
  end
end

function State.OnApplicationPause(observer, notification)
  if not notification.userInfo and State.token then
    local dialog = DialogManager.GetDialog("net.secondconfirmdialog")
    if dialog and dialog._confirmId and dialog._confirmId == 14 then
      dialog:OnClickConfirmBtn()
    else
      State.AutoReconnect()
    end
  end
end

function State.OnUpdate()
  if State.reconnectFSM then
    State.reconnectFSM:Update()
    if State.reconnectFSM then
      require("logic.fsm.reconnectfsm." .. string.lower(State.reconnectFSM:GetCurrentState())).Update()
    end
  end
end

function State.AutoReconnect()
  if State.reconnectFSM then
    return
  end
  State.reconnectFSM = ReconnectFSM.Create()
  State.reconnectFSM:Init()
  State.reconnectFSM:SetStateEnterCallBack(State.OnStateEnter, State)
  State.reconnectFSM:SetStateExitCallBack(State.OnStateExit, State)
  DialogManager.CreateSingletonDialog("login.loginwaitdialog")
  State.SetToLoginValue("Reconnection")
  LuaNotificationCenter.AddObserver(State, State.OnUpdate, Common.n_Update, nil)
end

function State.OnStateEnter(instance, currentState, lastState)
  require("logic.fsm.reconnectfsm." .. string.lower(currentState)).OnEnter(State, lastState)
end

function State.OnStateExit(instance, currentState, nextState)
  require("logic.fsm.reconnectfsm." .. string.lower(currentState)).OnExit(State, nextState)
end

function State.FinishReconnectFSM()
  LuaNotificationCenter.RemoveObserver(State)
  State.reconnectFSM = nil
  State.token = nil
  LuaNotificationCenter.RemoveObserver(ReconnectFSM_SdkLogin)
  LuaNotificationCenter.RemoveObserver(ReconnectFSM_QuestIPAndPort)
end

return State
