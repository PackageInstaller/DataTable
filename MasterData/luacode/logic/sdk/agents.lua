local Agents = {
  {
    path = "logic.sdk.agent.none",
    op = function(platformStr)
      return platformStr == "none"
    end
  },
  {
    path = "logic.sdk.agent.leiting",
    op = function(platformStr)
      return platformStr == "leit"
    end
  },
  {
    path = "logic.sdk.agent.yostar",
    op = function(platformStr)
      return platformStr == "yost"
    end
  },
  {
    path = "logic.sdk.agent.qianqian",
    op = function(platformStr)
      return platformStr == "qian"
    end
  },
  {
    path = "logic.sdk.agent.qianqian",
    op = function(platformStr)
      return platformStr == "mqan"
    end
  },
  {
    path = "logic.sdk.agent.quick",
    op = function(platformStr)
      return platformStr == "quka"
    end
  },
  {
    path = "logic.sdk.agent.quick",
    op = function(platformStr)
      return platformStr == "qukb"
    end
  }
}
return Agents
