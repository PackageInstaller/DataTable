local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	
	return ins;
end

--角色
this.character = nil;
--数据
this.datas = nil;
--当前状态Hash
--this.currStateHash = nil;

--初始化
function this:Init(character)
    self.character = character;
    self.datas = FireBallMgr:GetDatas(character.GetModelName());   
    
    self:PreloadSound();      
end 


--预加载声音
function this:PreloadSound()
    local arr = nil;
    local addedArr = {};
    if(self.datas)then
        for _,data in pairs(self.datas)do
            for _,fbDatas in pairs(self.datas)do
                if(fbDatas)then
                    for _,fbData in ipairs(fbDatas)do
                        local cueSheet = fbData.cue_sheet;                
                        if(cueSheet and not addedArr[cueSheet])then
                            addedArr[cueSheet] = 1;
                            arr = arr or {};
                            table.insert(arr,cueSheet);
                        end
                    end
                end                
            end
        end
    end
    if(arr)then
        CSAPI.PreloadSound(arr);
    end
end

--状态事件
--状态Hash值
function this:OnStateEnter(stateHash)
    --self.currStateHash = stateHash;

    self:CreateStateFB(stateHash);
end

--创建状态FireBall
function this:CreateStateFB(stateHash)
    local fbDatas = self.datas and self.datas[stateHash]; 
   
    if(fbDatas)then        
--        LogError("==================================================");   
--        LogError(self.character.GetModelName() .. ",state;" .. stateHash);   
--        LogError(fbDatas);
        for _,v in pairs(fbDatas) do
            self:ApplyCreateFireBall(v);
        end
    end
end


--创建技能状态前FireBall
function this:CreateCastPreFB(castState)
    local stateHash = CSAPI.StringToHash(castState);

    local fbDatas = self.datas and self.datas[stateHash]; 
    
    local fightAction = self.character.GetFightAction();
    if(fbDatas)then           
        for _,v in pairs(fbDatas) do
            if(v.delay and v.delay < 0)then
                self:CreateFireBall(v,fightAction);
            end
        end
    end
end


function this:ApplyCreateFireBall(data)
--    DebugLog("新FireBall组件：=================================");
--    DebugLog(data);
    
 

    local fightAction = self.character.GetFightAction();
    
    if(not data)then
        return
    end

    if(data.hide_in_help and fightAction and fightAction:IsHelp())then
        return;
    end

    local delay = data.delay or 0;
    if(delay < 0)then
        return;
    end

    if(self.character.IsSkipSkill())then
        self:CreateFireBall(data,fightAction);
    else        
        FuncUtil:Call(self.CreateFireBall,self,delay,data,fightAction);
    end
end


--创建FireBall
function this:CreateFireBall(data,fightAction,targetCharacter)   
    if(targetCharacter == nil)then
        targetCharacter = fightAction and fightAction:GetActionTarget(data.pos_ref) or nil;   
    end 

    local x,y,z = FightPosRefUtil:Calculate(data.pos_ref,self.character,targetCharacter,fightAction);   
    
    local luaFireBall = FireBallMgr:Create(x,y,z,self.character,fightAction,data);
end


function this:GetFireBallData(castState)
    local stateHash = CSAPI.StringToHash(castState);
    
    return self:GetFireBallDataByKey(stateHash);
end
function this:GetFireBallDataByKey(fbKey)  
    if(fbKey == nil)then
        LogError("FireBall键无效");
    end

    local data = self.datas[fbKey];
    if(data == nil)then
        --LogError("不存在FireBall数据" .. fbKey);
    end
    
   return data;
end

return this;