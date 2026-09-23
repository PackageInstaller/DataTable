local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	
	return ins;
end

--角色
this.character = nil;

--初始化
function this:Init(character)
    self.character = character;
end 
function this:Reset()
    self.moveData = nil;
    self.callBack = nil;
    self.stateMoveData = nil;
end

function this:ApplyStateMoveData(moveData)
    self.stateMoveData = moveData;
end


--状态事件
--状态Hash值
function this:OnStateEnter(stateHash)

    --处理状态位移
    if(self.stateMoveData)then
        self:HandleStateMoveData(stateHash,self.stateMoveData,self.character.GetFightAction());
    end


     if(self.moveData == nil)then
        --LogError(self.moveData);
        return;
     end

      local moveData = self.moveData;
      for _,v in ipairs(moveData.acts) do
        if(stateHash == v.state)then        
--            LogError("匹配====");
--            LogError(v);
            local time = v.time ~= nil and v.time * 0.001 or -1;
            if(v.pos_ref ~= nil)then               
                if(moveData.fightAction:IsHelp() and v.ignore_in_help_cast)then
                    --协战忽略的位移
                else
--                    LogError("执行=====");
--                    LogError(v);
                    FuncUtil:Call(self.ApplyAction,self,v.delay,v.pos_ref,moveData.fightAction,time);
                end
                
            else
                FuncUtil:Call(self.ApplyLastAction,self,v.delay,moveData.pos,time,self.callBack);
            end           
        end    
    end
    
      
end

function this:HandleStateMoveData(stateHash,acts,fightAction)
    if(acts == nil)then
        return;
    end

     for _,v in ipairs(acts) do
        if(stateHash == v.state)then        
            local time = v.time ~= nil and v.time * 0.001 or -1;
            if(v.pos_ref ~= nil)then               
                if(fightAction:IsHelp() and v.ignore_in_help_cast)then
                    --协战忽略的位移
                else
                    FuncUtil:Call(self.ApplyAction,self,v.delay,v.pos_ref,fightAction,time);
                end
            end  
        end    
    end  

end

function this:ApplyMove(moveData,callBack)   
    self.moveData = moveData;
    self.callBack = callBack;
end

--应用一个位移
function this:ApplyAction(pos_ref,fightAction,time)    
    local x,y,z = fightAction:Calculate(pos_ref);  
--    LogError("分段位移==================");
--    LogError(pos_ref);
--    LogError(x .. "," .. z);
    CSAPI.MoveTo(self.character.gameObject,nil,x,y,z,nil,time);
end

function this:ApplyLastAction(pos,time,callBack)
    local x,y,z = pos.x,pos.y,pos.z;
    CSAPI.MoveTo(self.character.gameObject,nil,x,y,z,callBack,time);
--    LogError("最后一段位移==================");
--    LogError(pos);
    self:Reset();
end


return this;