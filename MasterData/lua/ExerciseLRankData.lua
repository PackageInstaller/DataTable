local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(_cfg)
    self.cfg = _cfg

    local curLv = ExerciseMgr:GetRankLevel()
    local curScore = ExerciseMgr:GetScore()
    self.getNum = 0
    self.num1 = 0
    self.num2 = self.cfg.nScore
    if (curLv < self.cfg.id) then
    elseif (curLv == self.cfg.id) then
        self.num1 = curScore
    else
        self.getNum = 1
        self.num1 = self.num2
    end
end

function this:GetCfg()
    return self.cfg
end

function this:GetID()
    return self.cfg.id
end

function this:IsGetNum()
    return self.getNum
end

function this:IsGet()
    return self.getNum == 1
end

function this:GetNum()
    return self.num1, self.num2
end

return this
