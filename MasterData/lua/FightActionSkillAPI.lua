--技能API
FightActionSkillAPI = oo.class(FightActionBase);
local this = FightActionSkillAPI;

function this:OnPlay()  
--    LogError("执行====\n" .. table.tostring(self.data));
--    LogError("self.faParent\n" .. self.faParent:GetData());
    if(self.faParent)then
        local apiSetting = self:GetAPISetting();
        local ignoreDelay = false;
        if(apiSetting and apiSetting.play_aft_skill)then
            ignoreDelay = true;
        end
--        LogError("执行====\n" .. table.tostring(self.data));
--        LogError(apiSetting);
        self.faParent:PlayAPIs(self.data.datas,ignoreDelay);        
    else
        FightActionUtil:PlayAPIsByOrder(self.data.datas)
        --LogError("执行==================================\n" .. table.tostring(self.data));
    end
    self:Complete();
end

function this:OnClean()
    FightActionAPI.OnClean(self);
    self.faHelps = nil;
end


function this:SetData(fightActionData)
    FightActionBase.SetData(self,fightActionData);
    self:InitData(fightActionData.datas);
end

function this:InitData(datas)
    if(datas)then
        for i,data in ipairs(datas)do
            if(data.api == APIType.OnHelp)then
                local faHelp = FightActionUtil:HandleAPIData(data);
                self:AddHelp(faHelp);
                table.remove(datas,i);
                self:InitData(datas);
                break;
            end
        end
    end
end

function this:AddHelp(faHelp)
    self.faHelps = self.faHelps or {}
    table.insert(self.faHelps,faHelp);
end
function this:GetHelps()
    return self.faHelps;
end

return this;
