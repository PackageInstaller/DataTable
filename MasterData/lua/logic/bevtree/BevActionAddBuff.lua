local BevConst = require("Logic/BevTree/BevConst")
local BevData = require("Logic/BevTree/BevData")
local BevNode = require("Logic/BevTree/BevNode")
local Combat = require("Logic/Combat")
local FH = require("Logic/HelpLogic")
local BevActionAddBuff = {}

function BevActionAddBuff.ctor(node)
  local n = BevNode.ctor(node)
  n.name = "BevActionAddBuff"
  n.targetTeam = BevConst.AiTeamType.SelfTeam
  n.target = BevConst.AiConditionTarget.Position1
  n.buffIndexExp = ""
  n.buffLevelExp = ""
  n.run = BevActionAddBuff.run
  return n
end

function BevActionAddBuff.new()
  return BevActionAddBuff.ctor({})
end

function BevActionAddBuff.run(node)
  info("BevTree", "BevActionAddBuff running..")
  local fightData = BevData.instance.fightActiveData
  local teamInfo = Combat.getTeamInfo(fightData, BevData.instance.currentTeam)
  local teamId = node.getTeamId(fightData, node.targetTeam)
  local buffIndex = node.eval(node.buffIndexExp)
  local buffLevel = node.eval(node.buffLevelExp)
  local attacker = FH.getActorByUid(teamInfo, fightData.sequenceActor)
  if attacker then
    if node.target == BevConst.AiConditionTarget.AllActors then
      for i = BevConst.AiConditionTarget.Position1, BevConst.AiConditionTarget.Position3 do
        local targetInfo = Combat.getActorInfo(fightData, teamId, i)
        if targetInfo ~= nil then
          local newBuffAddInfo = {
            target = targetInfo,
            infoList = {}
          }
          table.insert(newBuffAddInfo.infoList, {
            attack = attacker,
            index = buffIndex,
            level = buffLevel
          })
          BevData.instance.buffList[#BevData.instance.buffList + 1] = newBuffAddInfo
        else
          error("BevTree", "Add Buff failed to find targetInfo by target id: " .. i)
        end
      end
    elseif node.target >= BevConst.AiConditionTarget.Position1 and node.target <= BevConst.AiConditionTarget.Position3 then
      local targetInfo = Combat.getActorInfo(fightData, teamId, node.target)
      if targetInfo ~= nil then
        local newBuffAddInfo = {
          target = targetInfo,
          infoList = {}
        }
        table.insert(newBuffAddInfo.infoList, {
          attack = attacker,
          index = buffIndex,
          level = buffLevel
        })
        BevData.instance.buffList[#BevData.instance.buffList + 1] = newBuffAddInfo
      else
        error("BevTree", "Add Buff failed to find targetInfo by target id: " .. node.target)
      end
    else
      error("BevTree", "Cannot Add Buff to target id: " .. node.target)
    end
  else
    error("BevTree", "Cannot getActorByUid: " .. fightData.sequenceActor)
  end
  return BevConst.RunState.Finished
end

return BevActionAddBuff
