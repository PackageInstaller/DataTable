local System = require("System.System")
local BattleEffectServer = require("Battle.DbgEngine.Effect.BattleEffectServer")
local BEPlayStory, Super = System.NewClass("BEPlayStory", BattleEffectServer)

function BEPlayStory:ctor(battleEngine, effectConfig)
  Super.ctor(self, battleEngine, effectConfig)
end

function BEPlayStory:Dispose()
  Super.Dispose(self)
end

function BEPlayStory:DoEffect()
  Super.DoEffect(self)
  local storyId = tonumber(self.params[1])
  self.battleEngine.recordMgr:OnBeginPlayStory(storyId)
  return true
end

return BEPlayStory
