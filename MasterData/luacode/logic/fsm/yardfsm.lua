local YardFSM = strictclass("YardFSM", require("framework.fsm"))

function YardFSM:Init()
  YardFSM.super.Init(self)
  self._parameters = {sceneId = 0, cameraAnimatorState = 0}
  self._states = {
    "Init",
    "Cabin",
    "TrainCamp"
  }
  self._transGraphs = {
    {
      from = "Init",
      to = "Cabin",
      conditions = {
        {
          parameterName = "sceneId",
          op = "eq",
          value = 30008
        }
      }
    },
    {
      from = "Cabin",
      to = "Init",
      conditions = {
        {
          parameterName = "sceneId",
          op = "eq",
          value = 0
        }
      }
    },
    {
      from = "Init",
      to = "TrainCamp",
      conditions = {
        {
          parameterName = "sceneId",
          op = "eq",
          value = 30013
        }
      }
    },
    {
      from = "TrainCamp",
      to = "Init",
      conditions = {
        {
          parameterName = "sceneId",
          op = "eq",
          value = 0
        }
      }
    }
  }
  self._initialState = "Init"
  self:CheckError()
end

return YardFSM
