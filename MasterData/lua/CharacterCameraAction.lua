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


--初始化
function this:Init(character)
    self.character = character;
    self.datas = CameraActionMgr:GetDatas(character.GetModelName());         
end 

--状态事件
--状态Hash值
function this:OnStateEnter(stateHash)    
    if(self.character.IsSkipSkill())then
        return;
    end

    if(self.datas == nil)then
        return;
    end

    local cameraActions = self.datas[stateHash];
    if(cameraActions)then
        local fightAction = self.character.GetFightAction();
        if(fightAction and fightAction:IsHelp() == false)then         
            for _,v in ipairs(cameraActions)do              
                CameraMgr:ApplyAction(v,self.character.GetFightAction(),self.character.gameObject,nil,true);
            end
        end
    end
end

--技能状态数据
function this:GetCameraData(stateName)
    if(self.datas and stateName)then
        return self.datas[CSAPI.StringToHash(stateName)];
    end
end

return this;