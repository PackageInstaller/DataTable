local LuaManager = CS.PixelNeko.LuaManager
local EventPointManager = CS.PixelNeko.P1.EventPoint.EventPointManager
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local UIBackManager = CS.PixelNeko.P1.UIBackManager
local State = {}

function State.OnEnter(lastState)
  LogInfo("BaseMainFSM", "Init Enter")
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("BaseMainFSM", "Init Exit")
end

return State
