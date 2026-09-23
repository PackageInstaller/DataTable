--战斗角色死亡检测

FightActionDeadChecker = oo.class(FightActionBase);
local this = FightActionDeadChecker;


function this:OnPlay()    
   --LogError("死亡检测======================");
   --local teamPriority = self.data and self.data.team or TeamUtil.enemyTeamId;
   local deads = nil;
   --local deads2 = nil;
   local allCharacters = CharacterMgr:GetAll();
   if(allCharacters)then
        for _,character in pairs(allCharacters)do
            if(character and character.IsDead() and not character.IsDeadPlayed())then
                deads = deads or {};
                table.insert(deads,character.GetID());

                --local teamId = character.GetTeam();

--                if(teamId == teamPriority)then
--                    deads1 = deads1 or {};
--                    table.insert(deads1,character.GetID());
--                else
--                    deads2 = deads2 or {};
--                    table.insert(deads2,character.GetID());
--                end
            end
        end
   end

   --local checkTime = 0;

   if(deads)then
        self:PushSub(FightActionMgr:Apply(FightActionType.Dead,{ deads = deads }));
        self:PushSub(FightActionMgr:Apply(FightActionType.DeadChecker),4);
        --checkTime = checkTime + 5000;
   end

--   if(deads2)then
--        self:PushSub(FightActionMgr:Apply(FightActionType.Dead,{ deads = deads2 }));
--        --checkTime = checkTime + 5000;
--   end

--   if(checkTime > 0)then
--        LogError("死亡名单======================");
--        if(deads1)then
--            LogError(deads1);
--        end
--        if(deads2)then
--            LogError(deads2);
--        end
--        FuncUtil:Call(self.CompleteCheck,self,checkTime);
--   end

   self:Complete();
--   if(deads1 or deads2)then        
--        FuncUtil:Call(self.Complete,self,20);
--   else
--        self:Complete();
--   end
end

--function this:CompleteCheck()   

--    if(self.isComplete == nil)then
--        if(self.subs)then
--            LogError("触发死亡bug检测！！！强制结束死亡检测阶段，保证流程");    
--            LogError(self:GetSubInfo());

--            --self.isComplete = 1;    
--            --self:CompleteCallBack();
--        end    

--        LogError("卡住了=====================");
--    end
--end


--function this:OnComplete()
--    LogError("死亡检测结束====================");
--end

return this;


