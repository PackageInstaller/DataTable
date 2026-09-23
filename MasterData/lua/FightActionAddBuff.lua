--战斗添加Buff

if(FightActionAPI == nil)then    
    require "FightActionAPI";
end

FightActionAddBuff = oo.class(FightActionAPI);
local this = FightActionAddBuff;

--处理自己
function this:OnHandleSelf()
    --FightActionAPIHandler:Handle(self.data);
end

return this;
