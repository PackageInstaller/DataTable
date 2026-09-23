--跳过输入
FightActionSkip = oo.class(FightActionBase);
local this = FightActionSkip;

function this:OnPlay()   
    self:Complete();
end

return this;
