--特殊排队的API

FightActionJumper = oo.class(FightActionBase);
local this = FightActionJumper;

function this:OnPlay()
    FightActionJumperMgr:ApplyData(self.data);
    self:Complete();
end

return this;
