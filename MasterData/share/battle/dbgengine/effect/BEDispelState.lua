local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BattleUtilServer = require("Battle.Util.BattleUtilServer")
local bc = require("Battle.BattleConst")
local BattleLogicEvent = require("Battle.DbgEngine.Event.BattleLogicEvent")
local BEDispelState, Super = System.NewClass("BEDispelState", BattleEffectServer)

function BEDispelState:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEDispelState:Dispose()
  Super.Dispose(self)
end

function BEDispelState:DoEffect()
  Super.DoEffect(self)
  local targets = self.targets
  local dispelType = self.params[1] or bc.DispelType.Debuff
  local dispelPriority = self.params[3] or 1
  local showText = 1 == self.params[4]
  local stateMgr = self.battleEngine.stateMgr
  for _, target in ipairs(targets) do
    local stateList = stateMgr:GetStateByDispelType(target.uid, dispelType)
    local dispelNum = math.ceil(self.params[2] or 1)
    if 0 == dispelNum then
      dispelNum = #stateList
    end
    if dispelPriority == bc.DispelPriority.Random then
      local list = BattleUtilServer.GetRandomNNum(self.battleEngine, #stateList, dispelNum)
      for _, i in ipairs(list) do
        stateMgr:RemoveState(stateList[i], showText)
      end
    elseif dispelPriority == bc.DispelPriority.Old then
      local num = dispelNum
      for _, state in ipairs(stateList) do
        if num > 0 then
          stateMgr:RemoveState(state, showText)
          num = num - 1
        else
          break
        end
      end
    else
      local num = dispelNum
      for i = #stateList, 1, -1 do
        if num > 0 then
          stateMgr:RemoveState(stateList[i], showText)
          num = num - 1
        else
          break
        end
      end
    end
  end
  return true
end

return BEDispelState
