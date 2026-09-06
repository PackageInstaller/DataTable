local ReconnectFSM = strictclass("ReconnectFSM", require("framework.fsm"))

function ReconnectFSM:Init()
  ReconnectFSM.super.Init(self)
  self._parameters = {
    adult = 2,
    toQuestIPAndPort = false,
    ip = "",
    port = -1
  }
  self._states = {
    "Init",
    "SdkLogin",
    "QuestIPAndPort",
    "GameLogin"
  }
  self._transGraphs = {
    {
      from = "Init",
      to = "SdkLogin",
      conditions = {
        {
          parameterName = "adult",
          op = "eq",
          value = 2
        }
      }
    },
    {
      from = "Init",
      to = "SdkLogin",
      conditions = {
        {
          parameterName = "adult",
          op = "eq",
          value = 0
        }
      }
    },
    {
      from = "Init",
      to = "QuestIPAndPort",
      conditions = {
        {
          parameterName = "adult",
          op = "eq",
          value = 1
        }
      }
    },
    {
      from = "SdkLogin",
      to = "QuestIPAndPort",
      conditions = {
        {
          parameterName = "toQuestIPAndPort",
          op = "eq",
          value = true
        }
      }
    },
    {
      from = "QuestIPAndPort",
      to = "GameLogin",
      conditions = {
        {
          parameterName = "ip",
          op = "ne",
          value = ""
        },
        {
          parameterName = "port",
          op = "ne",
          value = -1
        }
      }
    }
  }
  self._initialState = "Init"
  self:CheckError()
end

return ReconnectFSM
