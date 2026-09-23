--API
if(FightActionAPIHandler == nil)then
    require "FightActionAPIHandler";
end


FightActionAPI = oo.class(FightActionBase);
local this = FightActionAPI;

function this:OnPlay()  
--    if(self.data.api == APIType.AddBuff)then
--        LogError("执行API=======================" .. tostring(self.data.api) .. "\n" .. table.tostring(self.data));
--    end

    local apiSetting = self:GetAPISetting();
    if(apiSetting)then        
        if(apiSetting.delay and apiSetting.delay > 0)then
            if(apiSetting.delay > 5000)then
                LogError("APISetting延迟异常"); 
                LogError(apiSetting);           
            end
            FuncUtil:Call(self.ApplyHandle,self,apiSetting.delay);          
            return;
        end     
    end   
    self:ApplyHandle();
end


function this:ApplyHandle()
    --self:OnHandleSelf();
    --LogError(self.data); 

    local apiSetting = self:GetAPISetting();

    if(self.data)then
        if(apiSetting and apiSetting.action_delay)then
            FuncUtil:Call(FightActionAPIHandler.Handle,FightActionAPIHandler,apiSetting.action_delay,self.data);
        else
            FightActionAPIHandler:Handle(self.data);
        end
        
        self:CreateEff();
    end
    
    if(apiSetting)then              
        if(apiSetting.time and apiSetting.time > 0)then
            if(apiSetting.time > 5000)then
                LogError("APISetting时间异常"); 
                LogError(apiSetting);           
            end
           FuncUtil:Call(self.APIComplete,self,apiSetting.time);
           return;
        end  
    end   
    if(not self:TryPlayPlot())then
        self:APIComplete();
    end
    --self:TryPlayPlot()
    --self:APIComplete();
end
--处理自己
function this:OnHandleSelf()
end

--无目标
function this:GetActorCharacter()
    return nil;
end

function this:APIComplete()
--    LogError("执行API完成=======================");
--    LogError(self.data);

    if(self.faParent)then         
         if(self.subs)then
            for _,subFightAction in ipairs(self.subs)do                
                subFightAction.applyed = 1;
            end
        end    
        self.faParent:PlayAPIs(self.data.datas);       
    end
   
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

function this:TryPlayPlot()
    local data = self.data;
    if(data and data.api == APIType.Custom and data.action == "play_plot")then
        local plotId = data.param.id;
        --LogError("api播放剧情：" .. table.tostring(data,true))
        return PlotMgr:TryPlay(plotId,self.APIComplete,self);
    end
end



--创建特效
function this:CreateEff()
    local apiSetting = self:GetAPISetting();    
    if(apiSetting)then              
        
        if(apiSetting.play_eff)then         
           local character = self:GetTargetCharacter();
            local x,y,z = 0,0,0;
           if(character)then
                x,y,z = character.GetPos();                
           end
           ResUtil:CreateEffect(apiSetting.play_eff,x,y,z,nil,function (effGO)
                if(character)then                
                    local xScale = character and character.GetFlipScale() or 1;                
                    CSAPI.SetScale(effGO,xScale,1,1);
                    --LogError(xScale);
                end 
           end);

           
           
        end  
    end   
end

return this;
