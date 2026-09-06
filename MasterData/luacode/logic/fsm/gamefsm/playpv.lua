local PlayerPrefs = CS.UnityEngine.PlayerPrefs
local True = 1
local False = 0
local State = {}

function State.OnEnter(lastState)
  LogInfo("GameFSM", "PlayPV Enter")
  GlobalGameFSM:SetBoolean("toPalyPV", false)
  GlobalGameFSM:SetString("toLogin", "Init")
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "PlayPV Exit")
end

return State
