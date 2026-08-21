local cConfig = {
  m_bAllMemoryRefFileAddTime = true,
  m_bSingleMemoryRefFileAddTime = true,
  m_bComparedMemoryRefFileAddTime = true
}

local function FormatDateTimeNow()
  local cDateTime = os.date("*t")
  local strDateTime = string.format("%04d%02d%02d-%02d%02d%02d", tostring(cDateTime.year), tostring(cDateTime.month), tostring(cDateTime.day), tostring(cDateTime.hour), tostring(cDateTime.min), tostring(cDateTime.sec))
  return strDateTime
end

local function GetOriginalToStringResult(cObject)
  if not cObject then
    return ""
  end
  local cMt = getmetatable(cObject)
  if not cMt then
    return tostring(cObject)
  end
  local strName = ""
  local cToString = rawget(cMt, "__tostring")
  if cToString then
    rawset(cMt, "__tostring", nil)
    strName = tostring(cObject)
    rawset(cMt, "__tostring", cToString)
  else
    strName = tostring(cObject)
  end
  return strName
end

local function CreateObjectReferenceInfoContainer()
  local cContainer = {}
  local cObjectReferenceCount = {}
  setmetatable(cObjectReferenceCount, {__mode = "k"})
  local cObjectAddressToName = {}
  setmetatable(cObjectAddressToName, {__mode = "k"})
  cContainer.m_cObjectReferenceCount = cObjectReferenceCount
  cContainer.m_cObjectAddressToName = cObjectAddressToName
  cContainer.m_nStackLevel = -1
  cContainer.m_strShortSrc = "None"
  cContainer.m_nCurrentLine = -1
  return cContainer
end

local function CreateObjectReferenceInfoContainerFromFile(strFilePath)
  local cContainer = CreateObjectReferenceInfoContainer()
  cContainer.m_strShortSrc = strFilePath
  local cRefInfo = cContainer.m_cObjectReferenceCount
  local cNameInfo = cContainer.m_cObjectAddressToName
  local cFile = assert(io.open(strFilePath, "rb"))
  for strLine in cFile:lines() do
    local strHeader = string.sub(strLine, 1, 2)
    if "--" ~= strHeader then
      local _, _, strAddr, strName, strRefCount = string.find(strLine, "(.+)\t(.*)\t(%d+)")
      if strAddr then
        cRefInfo[strAddr] = strRefCount
        cNameInfo[strAddr] = strName
      end
    end
  end
  io.close(cFile)
  cFile = nil
  return cContainer
end

local function CreateSingleObjectReferenceInfoContainer(strObjectName, cObject)
  local cContainer = {}
  local cObjectExistTag = {}
  setmetatable(cObjectExistTag, {__mode = "k"})
  local cObjectAliasName = {}
  local cObjectAccessTag = {}
  setmetatable(cObjectAccessTag, {__mode = "k"})
  cContainer.m_cObjectExistTag = cObjectExistTag
  cContainer.m_cObjectAliasName = cObjectAliasName
  cContainer.m_cObjectAccessTag = cObjectAccessTag
  cContainer.m_nStackLevel = -1
  cContainer.m_strShortSrc = "None"
  cContainer.m_nCurrentLine = -1
  cContainer.m_strObjectName = strObjectName
  cContainer.m_strAddressName = "string" == type(cObject) and "\"" .. tostring(cObject) .. "\"" or GetOriginalToStringResult(cObject)
  cContainer.m_cObjectExistTag[cObject] = true
  return cContainer
end

local function CollectObjectReferenceInMemory(strName, cObject, cDumpInfoContainer)
  if not cObject then
    return
  end
  strName = strName or ""
  cDumpInfoContainer = cDumpInfoContainer or CreateObjectReferenceInfoContainer()
  if cDumpInfoContainer.m_nStackLevel > 0 then
    local cStackInfo = debug.getinfo(cDumpInfoContainer.m_nStackLevel, "Sl")
    if cStackInfo then
      cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
      cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
    end
    cDumpInfoContainer.m_nStackLevel = -1
  end
  local cRefInfoContainer = cDumpInfoContainer.m_cObjectReferenceCount
  local cNameInfoContainer = cDumpInfoContainer.m_cObjectAddressToName
  local strType = type(cObject)
  if "table" == strType then
    if rawget(cObject, "__cname") then
      if type(cObject.__cname) == "string" then
        strName = strName .. "[class:" .. cObject.__cname .. "]"
      end
    elseif rawget(cObject, "class") then
      if "string" == type(cObject.class) then
        strName = strName .. "[class:" .. cObject.class .. "]"
      end
    elseif rawget(cObject, "_className") and "string" == type(cObject._className) then
      strName = strName .. "[class:" .. cObject._className .. "]"
    end
    if cObject == _G then
      strName = strName .. "[_G]"
    end
    local bWeakK = false
    local bWeakV = false
    local cMt = getmetatable(cObject)
    if cMt then
      local strMode = rawget(cMt, "__mode")
      if strMode then
        if string.find(strMode, "k") then
          bWeakK = true
        end
        if string.find(strMode, "v") then
          bWeakV = true
        end
      end
    end
    cRefInfoContainer[cObject] = cRefInfoContainer[cObject] and cRefInfoContainer[cObject] + 1 or 1
    if cNameInfoContainer[cObject] then
      return
    end
    cNameInfoContainer[cObject] = strName
    for k, v in pairs(cObject) do
      local strKeyType = type(k)
      if "table" == strKeyType then
        if not bWeakK then
          CollectObjectReferenceInMemory(strName .. ".[table:key.table]", k, cDumpInfoContainer)
        end
        if not bWeakV then
          CollectObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
        end
      elseif "function" == strKeyType then
        if not bWeakK then
          CollectObjectReferenceInMemory(strName .. ".[table:key.function]", k, cDumpInfoContainer)
        end
        if not bWeakV then
          CollectObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
        end
      elseif "thread" == strKeyType then
        if not bWeakK then
          CollectObjectReferenceInMemory(strName .. ".[table:key.thread]", k, cDumpInfoContainer)
        end
        if not bWeakV then
          CollectObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
        end
      elseif "userdata" == strKeyType then
        if not bWeakK then
          CollectObjectReferenceInMemory(strName .. ".[table:key.userdata]", k, cDumpInfoContainer)
        end
        if not bWeakV then
          CollectObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
        end
      else
        CollectObjectReferenceInMemory(strName .. "." .. tostring(k), v, cDumpInfoContainer)
      end
    end
    if cMt then
      CollectObjectReferenceInMemory(strName .. ".[metatable]", cMt, cDumpInfoContainer)
    end
  elseif "function" == strType then
    local cDInfo = debug.getinfo(cObject, "Su")
    cRefInfoContainer[cObject] = cRefInfoContainer[cObject] and cRefInfoContainer[cObject] + 1 or 1
    if cNameInfoContainer[cObject] then
      return
    end
    cNameInfoContainer[cObject] = strName .. "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"
    local nUpsNum = cDInfo.nups
    for i = 1, nUpsNum do
      local strUpName, cUpValue = debug.getupvalue(cObject, i)
      local strUpValueType = type(cUpValue)
      if "table" == strUpValueType then
        CollectObjectReferenceInMemory(strName .. ".[ups:table:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
      elseif "function" == strUpValueType then
        CollectObjectReferenceInMemory(strName .. ".[ups:function:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
      elseif "thread" == strUpValueType then
        CollectObjectReferenceInMemory(strName .. ".[ups:thread:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
      elseif "userdata" == strUpValueType then
        CollectObjectReferenceInMemory(strName .. ".[ups:userdata:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
      end
    end
    local getfenv = debug.getfenv
    if getfenv then
      local cEnv = getfenv(cObject)
      if cEnv then
        CollectObjectReferenceInMemory(strName .. ".[function:environment]", cEnv, cDumpInfoContainer)
      end
    end
  elseif "thread" == strType then
    cRefInfoContainer[cObject] = cRefInfoContainer[cObject] and cRefInfoContainer[cObject] + 1 or 1
    if cNameInfoContainer[cObject] then
      return
    end
    cNameInfoContainer[cObject] = strName
    local getfenv = debug.getfenv
    if getfenv then
      local cEnv = getfenv(cObject)
      if cEnv then
        CollectObjectReferenceInMemory(strName .. ".[thread:environment]", cEnv, cDumpInfoContainer)
      end
    end
    local cMt = getmetatable(cObject)
    if cMt then
      CollectObjectReferenceInMemory(strName .. ".[thread:metatable]", cMt, cDumpInfoContainer)
    end
  elseif "userdata" == strType then
    cRefInfoContainer[cObject] = cRefInfoContainer[cObject] and cRefInfoContainer[cObject] + 1 or 1
    if cNameInfoContainer[cObject] then
      return
    end
    cNameInfoContainer[cObject] = strName
    local getfenv = debug.getfenv
    if getfenv then
      local cEnv = getfenv(cObject)
      if cEnv then
        CollectObjectReferenceInMemory(strName .. ".[userdata:environment]", cEnv, cDumpInfoContainer)
      end
    end
    local cMt = getmetatable(cObject)
    if cMt then
      CollectObjectReferenceInMemory(strName .. ".[userdata:metatable]", cMt, cDumpInfoContainer)
    end
  else
    if "string" == strType then
      cRefInfoContainer[cObject] = cRefInfoContainer[cObject] and cRefInfoContainer[cObject] + 1 or 1
      if cNameInfoContainer[cObject] then
        return
      end
      cNameInfoContainer[cObject] = strName .. "[" .. strType .. "]"
    else
    end
  end
end

local function CollectSingleObjectReferenceInMemory(strName, cObject, cDumpInfoContainer)
  if not cObject then
    return
  end
  strName = strName or ""
  cDumpInfoContainer = cDumpInfoContainer or CreateObjectReferenceInfoContainer()
  if cDumpInfoContainer.m_nStackLevel > 0 then
    local cStackInfo = debug.getinfo(cDumpInfoContainer.m_nStackLevel, "Sl")
    if cStackInfo then
      cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
      cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
    end
    cDumpInfoContainer.m_nStackLevel = -1
  end
  local cExistTag = cDumpInfoContainer.m_cObjectExistTag
  local cNameAllAlias = cDumpInfoContainer.m_cObjectAliasName
  local cAccessTag = cDumpInfoContainer.m_cObjectAccessTag
  local strType = type(cObject)
  if "table" == strType then
    if rawget(cObject, "__cname") then
      if type(cObject.__cname) == "string" then
        strName = strName .. "[class:" .. cObject.__cname .. "]"
      end
    elseif rawget(cObject, "class") then
      if "string" == type(cObject.class) then
        strName = strName .. "[class:" .. cObject.class .. "]"
      end
    elseif rawget(cObject, "_className") and "string" == type(cObject._className) then
      strName = strName .. "[class:" .. cObject._className .. "]"
    end
    if cObject == _G then
      strName = strName .. "[_G]"
    end
    local bWeakK = false
    local bWeakV = false
    local cMt = getmetatable(cObject)
    if cMt then
      local strMode = rawget(cMt, "__mode")
      if strMode then
        if "k" == strMode then
          bWeakK = true
        elseif "v" == strMode then
          bWeakV = true
        elseif "kv" == strMode then
          bWeakK = true
          bWeakV = true
        end
      end
    end
    if cExistTag[cObject] and not cNameAllAlias[strName] then
      cNameAllAlias[strName] = true
    end
    if cAccessTag[cObject] then
      return
    end
    cAccessTag[cObject] = true
    for k, v in pairs(cObject) do
      local strKeyType = type(k)
      if "table" == strKeyType then
        if not bWeakK then
          CollectSingleObjectReferenceInMemory(strName .. ".[table:key.table]", k, cDumpInfoContainer)
        end
        if not bWeakV then
          CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
        end
      elseif "function" == strKeyType then
        if not bWeakK then
          CollectSingleObjectReferenceInMemory(strName .. ".[table:key.function]", k, cDumpInfoContainer)
        end
        if not bWeakV then
          CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
        end
      elseif "thread" == strKeyType then
        if not bWeakK then
          CollectSingleObjectReferenceInMemory(strName .. ".[table:key.thread]", k, cDumpInfoContainer)
        end
        if not bWeakV then
          CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
        end
      elseif "userdata" == strKeyType then
        if not bWeakK then
          CollectSingleObjectReferenceInMemory(strName .. ".[table:key.userdata]", k, cDumpInfoContainer)
        end
        if not bWeakV then
          CollectSingleObjectReferenceInMemory(strName .. ".[table:value]", v, cDumpInfoContainer)
        end
      else
        CollectSingleObjectReferenceInMemory(strName .. "." .. tostring(k), v, cDumpInfoContainer)
      end
    end
    if cMt then
      CollectSingleObjectReferenceInMemory(strName .. ".[metatable]", cMt, cDumpInfoContainer)
    end
  elseif "function" == strType then
    local cDInfo = debug.getinfo(cObject, "Su")
    local cCombinedName = strName .. "[line:" .. tostring(cDInfo.linedefined) .. "@file:" .. cDInfo.short_src .. "]"
    if cExistTag[cObject] and not cNameAllAlias[cCombinedName] then
      cNameAllAlias[cCombinedName] = true
    end
    if cAccessTag[cObject] then
      return
    end
    cAccessTag[cObject] = true
    local nUpsNum = cDInfo.nups
    for i = 1, nUpsNum do
      local strUpName, cUpValue = debug.getupvalue(cObject, i)
      local strUpValueType = type(cUpValue)
      if "table" == strUpValueType then
        CollectSingleObjectReferenceInMemory(strName .. ".[ups:table:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
      elseif "function" == strUpValueType then
        CollectSingleObjectReferenceInMemory(strName .. ".[ups:function:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
      elseif "thread" == strUpValueType then
        CollectSingleObjectReferenceInMemory(strName .. ".[ups:thread:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
      elseif "userdata" == strUpValueType then
        CollectSingleObjectReferenceInMemory(strName .. ".[ups:userdata:" .. strUpName .. "]", cUpValue, cDumpInfoContainer)
      end
    end
    local getfenv = debug.getfenv
    if getfenv then
      local cEnv = getfenv(cObject)
      if cEnv then
        CollectSingleObjectReferenceInMemory(strName .. ".[function:environment]", cEnv, cDumpInfoContainer)
      end
    end
  elseif "thread" == strType then
    if cExistTag[cObject] and not cNameAllAlias[strName] then
      cNameAllAlias[strName] = true
    end
    if cAccessTag[cObject] then
      return
    end
    cAccessTag[cObject] = true
    local getfenv = debug.getfenv
    if getfenv then
      local cEnv = getfenv(cObject)
      if cEnv then
        CollectSingleObjectReferenceInMemory(strName .. ".[thread:environment]", cEnv, cDumpInfoContainer)
      end
    end
    local cMt = getmetatable(cObject)
    if cMt then
      CollectSingleObjectReferenceInMemory(strName .. ".[thread:metatable]", cMt, cDumpInfoContainer)
    end
  elseif "userdata" == strType then
    if cExistTag[cObject] and not cNameAllAlias[strName] then
      cNameAllAlias[strName] = true
    end
    if cAccessTag[cObject] then
      return
    end
    cAccessTag[cObject] = true
    local getfenv = debug.getfenv
    if getfenv then
      local cEnv = getfenv(cObject)
      if cEnv then
        CollectSingleObjectReferenceInMemory(strName .. ".[userdata:environment]", cEnv, cDumpInfoContainer)
      end
    end
    local cMt = getmetatable(cObject)
    if cMt then
      CollectSingleObjectReferenceInMemory(strName .. ".[userdata:metatable]", cMt, cDumpInfoContainer)
    end
  else
    if "string" == strType then
      if cExistTag[cObject] and not cNameAllAlias[strName] then
        cNameAllAlias[strName] = true
      end
      if cAccessTag[cObject] then
        return
      end
      cAccessTag[cObject] = true
    else
    end
  end
end

local function OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject, cDumpInfoResultsBase, cDumpInfoResults)
  if not cDumpInfoResults then
    return
  end
  local strDateTime = FormatDateTimeNow()
  local cRefInfoBase = cDumpInfoResultsBase and cDumpInfoResultsBase.m_cObjectReferenceCount or nil
  local cNameInfoBase = cDumpInfoResultsBase and cDumpInfoResultsBase.m_cObjectAddressToName or nil
  local cRefInfo = cDumpInfoResults.m_cObjectReferenceCount
  local cNameInfo = cDumpInfoResults.m_cObjectAddressToName
  local cRes = {}
  local nIdx = 0
  for k in pairs(cRefInfo) do
    nIdx = nIdx + 1
    cRes[nIdx] = k
  end
  table.sort(cRes, function(l, r)
    return cRefInfo[l] > cRefInfo[r]
  end)
  local bOutputFile = strSavePath and string.len(strSavePath) > 0
  local cOutputHandle
  local cOutputEntry = print
  if bOutputFile then
    local strAffix = string.sub(strSavePath, -1)
    if "/" ~= strAffix and "\\" ~= strAffix then
      strSavePath = strSavePath .. "/"
    end
    local strFileName = strSavePath .. "LuaMemRefInfo-All"
    if not strExtraFileName or 0 == string.len(strExtraFileName) then
      if cDumpInfoResultsBase then
        if cConfig.m_bComparedMemoryRefFileAddTime then
          strFileName = strFileName .. "-[" .. strDateTime .. "].txt"
        else
          strFileName = strFileName .. ".txt"
        end
      elseif cConfig.m_bAllMemoryRefFileAddTime then
        strFileName = strFileName .. "-[" .. strDateTime .. "].txt"
      else
        strFileName = strFileName .. ".txt"
      end
    elseif cDumpInfoResultsBase then
      if cConfig.m_bComparedMemoryRefFileAddTime then
        strFileName = strFileName .. "-[" .. strDateTime .. "]-[" .. strExtraFileName .. "].txt"
      else
        strFileName = strFileName .. "-[" .. strExtraFileName .. "].txt"
      end
    elseif cConfig.m_bAllMemoryRefFileAddTime then
      strFileName = strFileName .. "-[" .. strDateTime .. "]-[" .. strExtraFileName .. "].txt"
    else
      strFileName = strFileName .. "-[" .. strExtraFileName .. "].txt"
    end
    local cFile = assert(io.open(strFileName, "w"))
    cOutputHandle = cFile
    cOutputEntry = cFile.write
  end
  
  local function cOutputer(strContent)
    if cOutputHandle then
      cOutputEntry(cOutputHandle, strContent)
    else
      cOutputEntry(strContent)
    end
  end
  
  if cDumpInfoResultsBase then
    cOutputer("--------------------------------------------------------\n")
    cOutputer("-- This is compared memory information.\n")
    cOutputer("--------------------------------------------------------\n")
    cOutputer("-- Collect base memory reference at line:" .. tostring(cDumpInfoResultsBase.m_nCurrentLine) .. "@file:" .. cDumpInfoResultsBase.m_strShortSrc .. "\n")
    cOutputer("-- Collect compared memory reference at line:" .. tostring(cDumpInfoResults.m_nCurrentLine) .. "@file:" .. cDumpInfoResults.m_strShortSrc .. "\n")
  else
    cOutputer("--------------------------------------------------------\n")
    cOutputer("-- Collect memory reference at line:" .. tostring(cDumpInfoResults.m_nCurrentLine) .. "@file:" .. cDumpInfoResults.m_strShortSrc .. "\n")
  end
  cOutputer("--------------------------------------------------------\n")
  cOutputer("-- [Table/Function/String Address/Name]\t[Reference Path]\t[Reference Count]\n")
  cOutputer("--------------------------------------------------------\n")
  if strRootObjectName and cRootObject then
    if "string" == type(cRootObject) then
      cOutputer("-- From Root Object: \"" .. tostring(cRootObject) .. "\" (" .. strRootObjectName .. ")\n")
    else
      cOutputer("-- From Root Object: " .. GetOriginalToStringResult(cRootObject) .. " (" .. strRootObjectName .. ")\n")
    end
  end
  for i, v in ipairs(cRes) do
    if not cDumpInfoResultsBase or not cRefInfoBase[v] then
      if nMaxRescords > 0 then
        if nMaxRescords >= i then
          if "string" == type(v) then
            local strOrgString = tostring(v)
            local nPattenBegin, nPattenEnd = string.find(strOrgString, "string: \".*\"")
            if not cDumpInfoResultsBase and (nil == nPattenBegin or nil == nPattenEnd) then
              local strRepString = string.gsub(strOrgString, "([\n\r])", "\\n")
              cOutputer("string: \"" .. strRepString .. "\"\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
            else
              cOutputer(tostring(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
            end
          else
            cOutputer(GetOriginalToStringResult(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
          end
        end
      elseif "string" == type(v) then
        local strOrgString = tostring(v)
        local nPattenBegin, nPattenEnd = string.find(strOrgString, "string: \".*\"")
        if not cDumpInfoResultsBase and (nil == nPattenBegin or nil == nPattenEnd) then
          local strRepString = string.gsub(strOrgString, "([\n\r])", "\\n")
          cOutputer("string: \"" .. strRepString .. "\"\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
        else
          cOutputer(tostring(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
        end
      else
        cOutputer(GetOriginalToStringResult(v) .. "\t" .. cNameInfo[v] .. "\t" .. tostring(cRefInfo[v]) .. "\n")
      end
    end
  end
  if bOutputFile then
    io.close(cOutputHandle)
    cOutputHandle = nil
  end
end

local function OutputMemorySnapshotSingleObject(strSavePath, strExtraFileName, nMaxRescords, cDumpInfoResults)
  if not cDumpInfoResults then
    return
  end
  local strDateTime = FormatDateTimeNow()
  local cObjectAliasName = cDumpInfoResults.m_cObjectAliasName
  local bOutputFile = strSavePath and string.len(strSavePath) > 0
  local cOutputHandle
  local cOutputEntry = print
  if bOutputFile then
    local strAffix = string.sub(strSavePath, -1)
    if "/" ~= strAffix and "\\" ~= strAffix then
      strSavePath = strSavePath .. "/"
    end
    local strFileName = strSavePath .. "LuaMemRefInfo-Single"
    if not strExtraFileName or 0 == string.len(strExtraFileName) then
      if cConfig.m_bSingleMemoryRefFileAddTime then
        strFileName = strFileName .. "-[" .. strDateTime .. "].txt"
      else
        strFileName = strFileName .. ".txt"
      end
    elseif cConfig.m_bSingleMemoryRefFileAddTime then
      strFileName = strFileName .. "-[" .. strDateTime .. "]-[" .. strExtraFileName .. "].txt"
    else
      strFileName = strFileName .. "-[" .. strExtraFileName .. "].txt"
    end
    local cFile = assert(io.open(strFileName, "w"))
    cOutputHandle = cFile
    cOutputEntry = cFile.write
  end
  
  local function cOutputer(strContent)
    if cOutputHandle then
      cOutputEntry(cOutputHandle, strContent)
    else
      cOutputEntry(strContent)
    end
  end
  
  cOutputer("--------------------------------------------------------\n")
  cOutputer("-- Collect single object memory reference at line:" .. tostring(cDumpInfoResults.m_nCurrentLine) .. "@file:" .. cDumpInfoResults.m_strShortSrc .. "\n")
  cOutputer("--------------------------------------------------------\n")
  local nCount = 0
  for k in pairs(cObjectAliasName) do
    nCount = nCount + 1
  end
  cOutputer("-- For Object: " .. cDumpInfoResults.m_strAddressName .. " (" .. cDumpInfoResults.m_strObjectName .. "), have " .. tostring(nCount) .. " reference in total.\n")
  cOutputer("--------------------------------------------------------\n")
  for i, k in pairs(cObjectAliasName) do
    if nMaxRescords > 0 then
      if nMaxRescords >= i then
        cOutputer(i .. "\n")
      end
    else
      cOutputer(i .. "\n")
    end
  end
  if bOutputFile then
    io.close(cOutputHandle)
    cOutputHandle = nil
  end
end

local function OutputFilteredResult(strFilePath, strFilter, bIncludeFilter, bOutputFile)
  if not strFilePath or 0 == string.len(strFilePath) then
    print("You need to specify a file path.")
    return
  end
  if not strFilter or 0 == string.len(strFilter) then
    print("You need to specify a filter string.")
    return
  end
  local cFilteredResult = {}
  local cReadFile = assert(io.open(strFilePath, "rb"))
  for strLine in cReadFile:lines() do
    local nBegin, nEnd = string.find(strLine, strFilter)
    if nBegin and nEnd then
      if bIncludeFilter then
        nBegin, nEnd = string.find(strLine, "[\r\n]")
        if nBegin and nEnd and string.len(strLine) == nEnd then
          table.insert(cFilteredResult, string.sub(strLine, 1, nBegin - 1))
        else
          table.insert(cFilteredResult, strLine)
        end
      end
    elseif not bIncludeFilter then
      nBegin, nEnd = string.find(strLine, "[\r\n]")
      if nBegin and nEnd and string.len(strLine) == nEnd then
        table.insert(cFilteredResult, string.sub(strLine, 1, nBegin - 1))
      else
        table.insert(cFilteredResult, strLine)
      end
    end
  end
  io.close(cReadFile)
  cReadFile = nil
  cOutputHandle = nil
  local cOutputHandle
  local cOutputEntry = print
  if bOutputFile then
    local _, _, strResFileName = string.find(strFilePath, "(.*)%.txt")
    strResFileName = strResFileName .. "-Filter-" .. (bIncludeFilter and "I" or "E") .. "-[" .. strFilter .. "].txt"
    local cFile = assert(io.open(strResFileName, "w"))
    cOutputHandle = cFile
    cOutputEntry = cFile.write
  end
  
  local function cOutputer(strContent)
    if cOutputHandle then
      cOutputEntry(cOutputHandle, strContent)
    else
      cOutputEntry(strContent)
    end
  end
  
  for i, v in ipairs(cFilteredResult) do
    cOutputer(v .. "\n")
  end
  if bOutputFile then
    io.close(cOutputHandle)
    cOutputHandle = nil
  end
end

local function DumpMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject)
  local strDateTime = FormatDateTimeNow()
  if cRootObject then
    if not strRootObjectName or 0 == string.len(strRootObjectName) then
      strRootObjectName = tostring(cRootObject)
    end
  else
    cRootObject = debug.getregistry()
    strRootObjectName = "registry"
  end
  local cDumpInfoContainer = CreateObjectReferenceInfoContainer()
  local cStackInfo = debug.getinfo(2, "Sl")
  if cStackInfo then
    cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
    cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
  end
  CollectObjectReferenceInMemory(strRootObjectName, cRootObject, cDumpInfoContainer)
  OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, strRootObjectName, cRootObject, nil, cDumpInfoContainer)
end

local function DumpMemorySnapshotCompared(strSavePath, strExtraFileName, nMaxRescords, cResultBefore, cResultAfter)
  OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, nil, nil, cResultBefore, cResultAfter)
end

local function DumpMemorySnapshotComparedFile(strSavePath, strExtraFileName, nMaxRescords, strResultFilePathBefore, strResultFilePathAfter)
  local cResultBefore = CreateObjectReferenceInfoContainerFromFile(strResultFilePathBefore)
  local cResultAfter = CreateObjectReferenceInfoContainerFromFile(strResultFilePathAfter)
  OutputMemorySnapshot(strSavePath, strExtraFileName, nMaxRescords, nil, nil, cResultBefore, cResultAfter)
end

local function DumpMemorySnapshotSingleObject(strSavePath, strExtraFileName, nMaxRescords, strObjectName, cObject)
  if not cObject then
    return
  end
  if not strObjectName or 0 == string.len(strObjectName) then
    strObjectName = GetOriginalToStringResult(cObject)
  end
  local strDateTime = FormatDateTimeNow()
  local cDumpInfoContainer = CreateSingleObjectReferenceInfoContainer(strObjectName, cObject)
  local cStackInfo = debug.getinfo(2, "Sl")
  if cStackInfo then
    cDumpInfoContainer.m_strShortSrc = cStackInfo.short_src
    cDumpInfoContainer.m_nCurrentLine = cStackInfo.currentline
  end
  CollectSingleObjectReferenceInMemory("registry", debug.getregistry(), cDumpInfoContainer)
  OutputMemorySnapshotSingleObject(strSavePath, strExtraFileName, nMaxRescords, cDumpInfoContainer)
end

local cPublications = {
  m_cConfig = nil,
  m_cMethods = {},
  m_cHelpers = {},
  m_cBases = {}
}
cPublications.m_cConfig = cConfig
cPublications.m_cMethods.DumpMemorySnapshot = DumpMemorySnapshot
cPublications.m_cMethods.DumpMemorySnapshotCompared = DumpMemorySnapshotCompared
cPublications.m_cMethods.DumpMemorySnapshotComparedFile = DumpMemorySnapshotComparedFile
cPublications.m_cMethods.DumpMemorySnapshotSingleObject = DumpMemorySnapshotSingleObject
cPublications.m_cHelpers.FormatDateTimeNow = FormatDateTimeNow
cPublications.m_cHelpers.GetOriginalToStringResult = GetOriginalToStringResult
cPublications.m_cBases.CreateObjectReferenceInfoContainer = CreateObjectReferenceInfoContainer
cPublications.m_cBases.CreateObjectReferenceInfoContainerFromFile = CreateObjectReferenceInfoContainerFromFile
cPublications.m_cBases.CreateSingleObjectReferenceInfoContainer = CreateSingleObjectReferenceInfoContainer
cPublications.m_cBases.CollectObjectReferenceInMemory = CollectObjectReferenceInMemory
cPublications.m_cBases.CollectSingleObjectReferenceInMemory = CollectSingleObjectReferenceInMemory
cPublications.m_cBases.OutputMemorySnapshot = OutputMemorySnapshot
cPublications.m_cBases.OutputMemorySnapshotSingleObject = OutputMemorySnapshotSingleObject
cPublications.m_cBases.OutputFilteredResult = OutputFilteredResult
return cPublications
