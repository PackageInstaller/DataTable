---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/22 16:52
--- 服部半藏
---自身使用技能后自身获得【隐蔽】效果
local FightSoul_30012 = BaseClass("FightSoul_30012",Skill)
local base = Skill

local function __init(self)
    
end

local function OnBattleStart(self)
    base.OnBattleStart(self)
    self.__snc:Inc(NumericType.Speed,self.Params[1])
    Logger.BattleLog("战魂30012, 第一回合增加速度:" .. self.Params[1])
end

local function OnUnitSelfTurnStart(self)
    base.OnUnitSelfTurnEnd(self)
    if self.__subc.TotalTurnNum == 1 then
        self.__snc:Dec(NumericType.Speed,self.Params[1])
    end
end

FightSoul_30012.__init = __init
FightSoul_30012.OnBattleStart = OnBattleStart
FightSoul_30012.OnUnitSelfTurnStart = OnUnitSelfTurnStart

return FightSoul_30012