--战斗MissBuff

if(FightActionAPIHandler == nil)then
    require "FightActionAPIHandler";
end

FightActionMissBuff = oo.class(FightActionBase);
local this = FightActionMissBuff;

function this:OnPlay()
    --LogError("MissBuff");
    FightActionAPIHandler:HandleFloatFont(self.data);
    self:Complete();
end

--是否在技能过程中触发
function this:IsPlayInSkill()
    local apiSetting = self:GetAPISetting();
    if(apiSetting)then              
        if(apiSetting.play_in_skill)then         
           return true;
        end  
    end   
    return false;
end

return this;
