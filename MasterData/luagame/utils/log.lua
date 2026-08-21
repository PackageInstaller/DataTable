local Logger = require("utils.logger")
local l = Logger:new()
l.stack_level = l.stack_level + 1
local logging = {}
logging.NOLOG = l.NOLOG
logging.DEBUG = l.DEBUG
logging.INFO = l.INFO
logging.WARNING = l.WARNING
logging.ERROR = l.ERROR
logging.CRITICAL = l.CRITICAL
logging.FATAL = l.FATAL

function logging.DebugHero(char, ...)
  if char:is_hero() then
    logging.Debug(...)
  end
end

function logging.DebugMonster(char, ...)
  if char:is_monster() then
    logging.Debug(...)
  end
end

function logging.DebugPlayer(char, ...)
  if char:is_player() then
    logging.Debug(...)
  end
end

function logging.Debug(...)
  if UNITY_EDITOR then
    l:Debug(...)
  end
end

function logging.Debugf(format, ...)
  if UNITY_EDITOR then
    l:Debugf(format, ...)
  end
end

function logging.Just2File(...)
  l:Just2File(...)
end

function logging.Info(...)
  l:Info(...)
end

function logging.Infof(format, ...)
  l:Infof(format, ...)
end

function logging.Warning(...)
  l:Warning(...)
end

function logging.Warningf(format, ...)
  l:Warningf(format, ...)
end

function logging.Error(...)
  l:Error(...)
end

function logging.Errorf(format, ...)
  l:Errorf(format, ...)
end

function logging.Critical(...)
  l:Critical(...)
end

function logging.Criticalf(format, ...)
  l:Criticalf(format, ...)
end

function logging.Fatal(...)
  l:Fatal(...)
end

function logging.Fatalf(format, ...)
  l:Fatalf(format, ...)
end

function logging.Assert(v, message)
  return l:Assert(v, message)
end

function logging.SError(message, level)
  level = level and level + 1 or 2
  return l:SError(message, level)
end

function logging.Tag(key, value)
  l:Tag(key, value)
end

function logging.Untag(key)
  l:Untag(key)
end

function logging.set_modname(name)
  l:set_modname(name)
end

function logging.config(t)
  l:config(t)
end

local LocalStorage = require("utils.localstorage")

function logging.load_log_flag()
  local v = LocalStorage:load_int(Global.config.WRITER_LOG_KEY, 0)
  Global.is_open_writer_log = 1 == v
end

local _origin_print = print

function logging.check_filter()
  if not UNITY_EDITOR then
    if Global.is_open_writer_log then
      l:config({
        level = logging.NOLOG
      })
      print = _origin_print
    else
      l:config({
        level = logging.ERROR
      })
      
      function print()
      end
    end
  end
end

function logging.force_print(...)
  _origin_print(...)
end

function logging.upload_log()
  local PathDefine = require("utils.path_define")
  local Account = require("gamelogic.account.account")
  local log_path = PathDefine.updown_log_dir
  local log_txt = "无log信息"
  local contextHead = {}
  local form = UnityEngine.WWWForm()
  local platform = PathDefine.platform
  local account = Account:get_account() or ""
  local uuid = Global.player_uuid or ""
  table.insert(contextHead, "account = " .. account)
  table.insert(contextHead, "uuid = " .. uuid)
  table.insert(contextHead, "platform = " .. platform)
  table.insert(contextHead, "deviceModel = " .. UnityEngine.SystemInfo.deviceModel)
  table.insert(contextHead, "deviceName = " .. UnityEngine.SystemInfo.deviceName)
  table.insert(contextHead, "deviceUniqueIdentifier = " .. UnityEngine.SystemInfo.deviceUniqueIdentifier)
  table.insert(contextHead, "graphicsDeviceID = " .. UnityEngine.SystemInfo.graphicsDeviceID)
  table.insert(contextHead, "graphicsDeviceName = " .. UnityEngine.SystemInfo.graphicsDeviceName)
  table.insert(contextHead, "graphicsMemorySize = " .. UnityEngine.SystemInfo.graphicsMemorySize)
  table.insert(contextHead, "systemMemorySize = " .. UnityEngine.SystemInfo.systemMemorySize)
  form:AddField("classID", "Log")
  form:AddField("localTime", os.date("%Y-%m-%d_%H-%M-%S", os.time()))
  form:AddField("roleID", os.date("%Y-%m-%d_%H-%M-%S", os.time()) .. "--Log.txt")
  local err_key = "**Log**" .. UnityEngine.SystemInfo.deviceModel .. "_" .. platform .. "_" .. account .. "_" .. uuid
  form:AddField("errorKey", err_key)
  local file1 = io.input(log_path)
  if not file1 then
    Log.Error("log not exist, path = " .. log_path)
    return
  end
  log_txt = io.read("*a")
  io.close()
  local content = ""
  content = table.concat(contextHead, "\n") .. "\n" .. log_txt
  form:AddField("content", content)
  CSHelper.PostWWWForm("http://dbug-error-log.mz/collectlog.php", form)
  Util.show_notify_popup_message(nil, "上传日志成功")
end

return logging
