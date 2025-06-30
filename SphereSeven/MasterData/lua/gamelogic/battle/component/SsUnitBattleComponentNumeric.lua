local this = require("GameLogic.Battle.Component.SsUnitBattleComponent")

function this.InitTurnNumeric(self)
    self.TurnNumeric = {}
    for k, v in pairs(NumericType) do
        self.TurnNumeric[v] = 0
    end
end

function this.IncTurnNumeric(self, numericType, value)
    self.TurnNumeric[numericType] = self.TurnNumeric[numericType] + value
end

function this.EnableTurnNumeric(self)
    for k, v in pairs(NumericType) do
        self.__entity:GetComponent("NumericComponent"):Inc(v, self.TurnNumeric[v])
    end
end

function this.DisableTurnNumeric(self)
    for k, v in pairs(NumericType) do
        self.__entity:GetComponent("NumericComponent"):Dec(v, self.TurnNumeric[v])
    end
end

function this.InitTempNumeric(self)
    self.TempNumeric = {}
    for k, v in pairs(NumericType) do
        self.TempNumeric[v] = 0
    end
end

function this.IncTempNumeric(self, numericType, value)
    self.TempNumeric[numericType] = self.TempNumeric[numericType] + value
end

function this.EnableTempNumeric(self)
    for k, v in pairs(NumericType) do
        if self.TempNumeric[v] ~= 0 then
            self.__entity:GetComponent("NumericComponent"):Inc(v, self.TempNumeric[v])
            Logger.BattleLog(string.format("技能效果前额外属性加成, 类型: %s 值: %s", v, self.TempNumeric[v]))
        end
    end
end

function this.DisableTempNumeric(self)
    for k, v in pairs(NumericType) do
        if self.TempNumeric[v] ~= 0 then
            self.__entity:GetComponent("NumericComponent"):Dec(v, self.TempNumeric[v])
        end
    end
end

return this