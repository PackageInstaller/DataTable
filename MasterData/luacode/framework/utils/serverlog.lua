function LogInfo(tag, message)
  if LuaLogInfo then
    LuaLogInfo(tag, tostring(message))
  else
    print(string.format("[Info]  %s  %s  %s", os.date(), tag, message))
  end
end

function LogInfoFormat(tag, format, ...)
  LogInfo(tag, string.format(format, ...))
end

function LogWarning(tag, message)
  if LuaLogWarn then
    LuaLogWarn(tag, tostring(message))
  else
    print(string.format("[Warn]  %s  %s  %s", os.date(), tag, message))
  end
end

function LogWarningFormat(tag, format, ...)
  LogWarning(tag, string.format(format, ...))
end

function LogError(tag, message)
  if LuaLogError then
    LuaLogError(tag, string.format([[
%s

%s
]], message, debug.traceback()))
  else
    print(string.format([[
[Erro]  %s  %s  %s

%s
]], os.date(), tag, message, debug.traceback()))
  end
end

function LogErrorFormat(tag, format, ...)
  LogError(tag, string.format(format, ...))
end
