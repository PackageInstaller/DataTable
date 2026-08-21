local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local U = require("Common/Util")
local m_resMazePointCount
local m_levelExpList = PB.all("MazeResearchLevel")
local m_mazeActivityId

function SetupWindow()
end

function InitWindow()
  m_mazeActivityId = this:GetData("MazeActivityId")
  this:BindRemote(DB:GameRequest("fci/Maze/Research/" .. m_mazeActivityId .. "/"), OnRefreshData)
  this:Bind("fci/resource/ResMazePoint_0", OnSetResMazePoint)
end

function OnRefreshData(result)
  if result then
    REF.LabelLevelCount.UILabel.text = "Lv." .. result.researchLevel
    REF.WidgetProgressBar.UIProgressBar.value = SetExpRatio(result.researchLevel, result.researchExp)
  end
end

function OnSetResMazePoint(result)
  m_resMazePointCount = result
  REF.LabelResource.ResourcePrinter:SetResource(PB.enum.ResourceType.ResMazePoint, 0, m_resMazePointCount)
end

function SetExpRatio(level, exp)
  local allExp = 0
  local curLevelExpAll = 0
  local curLevelExp = 0
  local ratio = 0
  local _, curinfo = table.find(m_levelExpList, function(k, v)
    return v.level == level
  end)
  local _, nextinfo = table.find(m_levelExpList, function(k, v)
    return v.level == level + 1
  end)
  if nextinfo ~= nil then
    curLevelExpAll = curinfo.scoreCost
    curLevelExp = exp
  else
    curLevelExpAll = 100
    curLevelExp = 100
  end
  if curLevelExpAll == 0 then
    return 0
  else
    return math.min(1, curLevelExp / curLevelExpAll)
  end
end
