local DormAI = {}
local DormAIControllerProto = {}
DormAI.AGENT_STATE = {
  Idle = "Idle",
  Move = "Move",
  Control = "Control",
  Furniture = "Furniture",
  Resolve = "Resolve"
}

function DormAI.NewController(root, board, agentMap)
  local controller = {}
  controller.root = root
  controller.board = board
  controller.agentMap = agentMap
  controller.movingAgentCount = 0
  setmetatable(controller, {__index = DormAIControllerProto})
  return controller
end

function DormAIControllerProto:Update(deltaTime)
  for _, agent in pairs(self.agentMap) do
    UpdateAgent(agent, deltaTime)
  end
end

function UpdateAgent(agent, deltaTime)
  if not agent.gameObject:IsNull() and agent.gameObject.activeSelf then
    agent["$UpdateState"](deltaTime)
  end
end

function DormAIControllerProto:GetMovingCount()
  return self.movingAgentCount
end

function DormAIControllerProto:IncreaseMovingCount()
  self.movingAgentCount = self.movingAgentCount + 1
end

function DormAIControllerProto:DecreaseMovingCount()
  self.movingAgentCount = self.movingAgentCount - 1
end

return DormAI
