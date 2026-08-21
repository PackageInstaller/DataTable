local BevConst = require("Logic/BevTree/BevConst")
local BevNode = require("Logic/BevTree/BevNode")
local BevActionPlayBestSkill = {}

function BevActionPlayBestSkill.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevActionPlayBestSkill"
  n.log = ""
  n.run = BevActionPlayBestSkill.run
  return n
end

function BevActionPlayBestSkill.new()
  return BevActionPlayBestSkill.ctor({})
end

function BevActionPlayBestSkill.run(node)
  info("BevTree", "BevActionLog triggerd: " .. node.log)
  return BevConst.RunState.Finished
end

return BevActionPlayBestSkill
