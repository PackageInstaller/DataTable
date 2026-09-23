--战斗治疗

FightActionCure = oo.class(FightActionBase);
local this = FightActionCure;

function this:Apply()   
   
    local cureDatas = self.data.datas;
    if(cureDatas == nil or #cureDatas == 0)then
        LogError("治疗数据为空");
        return true;
    end
    local applyState = true;
    for index,cureData in ipairs(cureDatas)do
        if(cureData.isApplyed == nil)then
            cureData.isApplyed = 1;
            cureData.type = self.data.type;
            
            local character = self:GetActorCharacter();
            if(character)then               
                character.ApplyCureData(cureData);            
            end

            if(index < #cureDatas)then
                applyState = false;
            end
            break;
        end
    end

    return applyState;
end

return this;
