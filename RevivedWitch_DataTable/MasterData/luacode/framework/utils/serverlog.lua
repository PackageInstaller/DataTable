-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/serverlog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
LogInfo = function(tag, message)
  -- function num : 0_0 , upvalues : _ENV
  if LuaLogInfo then
    LuaLogInfo(tag, tostring(message))
  else
    print((string.format)("[Info]  %s  %s  %s", (os.date)(), tag, message))
  end
end

LogInfoFormat = function(tag, format, ...)
  -- function num : 0_1 , upvalues : _ENV
  LogInfo(tag, (string.format)(format, ...))
end

LogWarning = function(tag, message)
  -- function num : 0_2 , upvalues : _ENV
  if LuaLogWarn then
    LuaLogWarn(tag, tostring(message))
  else
    print((string.format)("[Warn]  %s  %s  %s", (os.date)(), tag, message))
  end
end

LogWarningFormat = function(tag, format, ...)
  -- function num : 0_3 , upvalues : _ENV
  LogWarning(tag, (string.format)(format, ...))
end

LogError = function(tag, message)
  -- function num : 0_4 , upvalues : _ENV
  if LuaLogError then
    LuaLogError(tag, (string.format)("%s\n\n%s\n", message, (debug.traceback)()))
  else
    print((string.format)("[Erro]  %s  %s  %s\n\n%s\n", (os.date)(), tag, message, (debug.traceback)()))
  end
end

LogErrorFormat = function(tag, format, ...)
  -- function num : 0_5 , upvalues : _ENV
  LogError(tag, (string.format)(format, ...))
end


