local Log = CS.PixelNeko.Log

function LogInfo(tag, message)
  if not global_var_debug then
    Log.LogInfo(tag, message)
  else
    Log.LogInfo(tag, string.format([[
%s

%s
]], message, ""))
  end
end

function LogInfoFormat(tag, format, ...)
  LogInfo(tag, string.format(format, ...))
end

function LogWarning(tag, message)
  if not global_var_debug then
    Log.LogWarning(tag, message)
  else
    Log.LogWarning(tag, string.format([[
%s

%s
]], message, debug.traceback()))
  end
end

function LogWarningFormat(tag, format, ...)
  LogWarning(tag, string.format(format, ...))
end

function LogError(tag, message)
  Log.LogError(tag, string.format([[
%s

%s
]], message, debug.traceback()))
end

function LogErrorFormat(tag, format, ...)
  LogError(tag, string.format(format, ...))
end

function warn(...)
  local s = ""
  local len = select("#", ...)
  for i = 1, len do
    s = s .. " " .. tostring(select(i, ...))
  end
  LogWarning("[Debug]", s)
end
