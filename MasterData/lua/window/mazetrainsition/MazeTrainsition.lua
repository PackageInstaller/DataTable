local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local LU = require("Common/ListUtil")
local CO = require("Common/Coroutine")
local DBH = require("Manager/DataBindingHandler")
local m_buffRowList, m_map, m_mazeInfo, m_mazeId

function SetupWindow()
end

function InitWindow()
end

function SetData(data)
  local mazeId = data.mazeId
  local pMazeId = this:GetData("fci/MazeId/" .. mazeId .. "/")
  local param = {mazeId = pMazeId, mazeFloor = 1}
  local gotListUid = this:GetData("MazeSelectActorUid")
  if gotListUid and not table.empty(gotListUid) then
    local selectRoleId = data.selectRoleId
    
    local function onFail()
      WU.RecycleWindow(this)
    end
    
    this:GameRequest("fci/Maze/change-role/" .. selectRoleId .. "/" .. mazeId .. "/"):Post(nil, function(resRole)
      this:GameRequest("fci/Maze/Enter/" .. mazeId .. "/"):Post(param, function(res)
        this:SetData("fci/MazeInfo/", res.mazeInfo)
        DBH.ResChange(res.resChange)
        this:GameRequest("fci/Maze/Actor/" .. mazeId .. "/"):Post({actorUids = gotListUid}, function(result)
          this:SetData("fci/Maze/Actor/" .. mazeId .. "/", result)
          this:SetData("MazeFirstTweenOn", true)
          this:DelayInvokeInSeconds(1.0, function()
            WU.RecycleWindow("MazeNewTeam")
            WU.RecycleWindow("MazeEnter")
            WU.AcquireWindow("MazeMain")
            this:DelayInvokeInSeconds(0.1, function()
              WU.RecycleWindow(this)
            end)
          end)
        end, onFail)
      end, onFail)
    end, onFail)
  else
    WU.ShowHintText(WU.GetString("Tower_AtleastOneMain"))
    WU.RecycleWindow(this)
  end
end
