local this = BaseClass("LevelComponent", Component);
local base = Component

function this.Awake(self)
    self.numeric_component = self.__entity:GetComponent("NumericComponent")
    self.diff = Game.Scene:GetComponent("AgainstComponent"):GetCurLevelDiff()

    if self.diff == nil then -- 深渊和争霸不需要
        return
    end
    
    -- 特殊关卡
    local ZBattleLevel = Game.Scene:GetComponent("AgainstComponent"):GetCurZBattleLevel()
    if ZBattleLevel == nil or string.IsNullOrEmpty(ZBattleLevel.LevelAdd) then
        return
    end
    local func = this["Level_"..ZBattleLevel.LevelAdd]
    func(self)
end

function this.Dispose(self)
    base.Dispose(self)
    
end

return this