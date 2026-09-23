FightActionJumperMgr = {};
local this = FightActionJumperMgr;

--function this:PushData(apiData)
--    self.datas = self.datas or {};
--    table.insert(self.datas,1,apiData);
--end

function this:ApplyData(apiData)

--    LogError("ִ��=======");
--    LogError(apiData);

    local skillHandler = FightActionUtil:GetAPIHandler(APIType.Skill);
    local fightAction = skillHandler:Handle(apiData);
    fightAction.queueType = QUEUE_TYPE.Curr;  
    FightActionMgr:Push(fightAction);

--    if(self.datas == nil)then
--        return;
--    end

--    local skillHandler = FightActionUtil:GetAPIHandler(APIType.Skill);
--    for _,apiData in ipairs(self.datas)do
--        local fightAction = skillHandler:Handle(apiData);
--        fightAction.queueType = QUEUE_TYPE.Curr;  
--        FightActionMgr:Push(fightAction);
--    end

--    self.datas = nil;
end

return this;
