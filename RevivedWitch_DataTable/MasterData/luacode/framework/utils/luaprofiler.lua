-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/utils/luaprofiler.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Profiler = {}
local sampleStack = {}
local sampleStackIndex = 0
local profileTable = {}
local GetNameByIndex = function(index)
  -- function num : 0_0 , upvalues : sampleStack
  local tempName = ""
  for i = 1, index - 1 do
    tempName = sampleStack[i] .. "/"
  end
  return tempName .. sampleStack[index]
end

local GetCurrentName = function(name)
  -- function num : 0_1 , upvalues : sampleStackIndex, sampleStack
  local tempName = ""
  for i = 1, sampleStackIndex do
    tempName = sampleStack[i] .. "/"
  end
  return tempName .. name
end

Profiler.BeginSample = function(name)
  -- function num : 0_2 , upvalues : GetCurrentName, sampleStackIndex, sampleStack, profileTable, _ENV
  local currentName = GetCurrentName(name)
  sampleStackIndex = sampleStackIndex + 1
  sampleStack[sampleStackIndex] = name
  do
    if profileTable[currentName] == nil then
      local profile = {}
      profile.name = currentName
      profile.totalTime = 0
      profile.count = 0
      profile.beginTime = 0
      profile.level = sampleStackIndex
      profileTable[currentName] = profile
    end
    local profile = profileTable[currentName]
    local time = (os.clock)()
    profile.beginTime = time
  end
end

Profiler.EndSample = function(name)
  -- function num : 0_3 , upvalues : GetNameByIndex, sampleStackIndex, _ENV, profileTable
  local currentName = GetNameByIndex(sampleStackIndex)
  local time = (os.clock)()
  local profile = profileTable[currentName]
  local diffTime = time - profile.beginTime
  profile.totalTime = profile.totalTime + diffTime
  profile.count = profile.count + 1
  sampleStackIndex = sampleStackIndex - 1
end

Profiler.Clear = function()
  -- function num : 0_4 , upvalues : profileTable
  profileTable = {}
end

Profiler.Print = function()
  -- function num : 0_5 , upvalues : _ENV, profileTable
  local result = {}
  ;
  (table.insert)(result, "\r\n")
  ;
  (table.insert)(result, " name \t total time \t total count \t average time \r\n")
  local allTime = 0
  for k,v in pairs(profileTable) do
    local totalCount = v.count
    local totalTime = v.totalTime * 1000
    ;
    (table.insert)(result, k .. "\t" .. totalTime .. "\t" .. totalCount .. "\t" .. totalTime / totalCount .. "\r\n")
  end
  local resultStr = (table.concat)(result)
  LogError("Profiler", resultStr)
end

return Profiler

