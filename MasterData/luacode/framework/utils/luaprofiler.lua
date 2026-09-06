local Profiler = {}
local sampleStack = {}
local sampleStackIndex = 0
local profileTable = {}

local function GetNameByIndex(index)
  local tempName = ""
  for i = 1, index - 1 do
    tempName = sampleStack[i] .. "/"
  end
  return tempName .. sampleStack[index]
end

local function GetCurrentName(name)
  local tempName = ""
  for i = 1, sampleStackIndex do
    tempName = sampleStack[i] .. "/"
  end
  return tempName .. name
end

function Profiler.BeginSample(name)
  local currentName = GetCurrentName(name)
  sampleStackIndex = sampleStackIndex + 1
  sampleStack[sampleStackIndex] = name
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
  local time = os.clock()
  profile.beginTime = time
end

function Profiler.EndSample(name)
  local currentName = GetNameByIndex(sampleStackIndex)
  local time = os.clock()
  local profile = profileTable[currentName]
  local diffTime = time - profile.beginTime
  profile.totalTime = profile.totalTime + diffTime
  profile.count = profile.count + 1
  sampleStackIndex = sampleStackIndex - 1
end

function Profiler.Clear()
  profileTable = {}
end

function Profiler.Print()
  local result = {}
  table.insert(result, "\r\n")
  table.insert(result, " name \t total time \t total count \t average time \r\n")
  local allTime = 0
  for k, v in pairs(profileTable) do
    local totalCount = v.count
    local totalTime = v.totalTime * 1000
    table.insert(result, k .. "\t" .. totalTime .. "\t" .. totalCount .. "\t" .. totalTime / totalCount .. "\r\n")
  end
  local resultStr = table.concat(result)
  LogError("Profiler", resultStr)
end

return Profiler
