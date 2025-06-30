-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/log.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Log = (CS.PixelNeko).Log
LogInfo = function(tag, message)
  -- function num : 0_0 , upvalues : _ENV, Log
  if not global_var_debug then
    (Log.LogInfo)(tag, message)
  else
    ;
    (Log.LogInfo)(tag, (string.format)("%s\n\n%s\n", message, ""))
  end
end

LogInfoFormat = function(tag, format, ...)
  -- function num : 0_1 , upvalues : _ENV
  LogInfo(tag, (string.format)(format, ...))
end

LogWarning = function(tag, message)
  -- function num : 0_2 , upvalues : _ENV, Log
  if not global_var_debug then
    (Log.LogWarning)(tag, message)
  else
    ;
    (Log.LogWarning)(tag, (string.format)("%s\n\n%s\n", message, (debug.traceback)()))
  end
end

LogWarningFormat = function(tag, format, ...)
  -- function num : 0_3 , upvalues : _ENV
  LogWarning(tag, (string.format)(format, ...))
end

LogError = function(tag, message)
  -- function num : 0_4 , upvalues : Log, _ENV
  (Log.LogError)(tag, (string.format)("%s\n\n%s\n", message, (debug.traceback)()))
end

LogErrorFormat = function(tag, format, ...)
  -- function num : 0_5 , upvalues : _ENV
  LogError(tag, (string.format)(format, ...))
end

warn = function(...)
  -- function num : 0_6 , upvalues : _ENV
  local s = ""
  local len = select("#", ...)
  for i = 1, len do
    s = s .. " " .. tostring(select(i, ...))
  end
  LogWarning("[Debug]", s)
end


