local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	
	return ins;
end

--目标角色
this.character = nil;

this.currStateHash = nil;

--初始化状态机
function this:Init(character)
    self.character = character;

end

--进入状态
function this:OnStateEnter(stateHash)   
    self.currStateHash = stateHash;
end
--获取当前状态hash值
function this:GetCurrStateHash()
    return self.currStateHash;
end


--获取技能状态名称
function this:GetCastStateName(castId)
    return "cast" .. castId;
end
--获取技能状态数据
function this:GetCastStateData(castName)
    local stateDatas = StateMgr:GetDatas(self.character.GetModelName());

    if(stateDatas ~= nil)then
        return stateDatas[castName];
    end
    return nil;
end



--移动
function this:Move(isMove)
    self.character.animator:SetBool("move",isMove);
end
--死亡
function this:Dead()
    self:SetDead(true)
end
--复活
function this:Relive()
    self:SetDead(false)
end
--死亡
function this:SetDead(isDead)
    self.character.animator:SetBool("dead",isDead);
    if(isDead)then
        self.character.animator:SetTrigger("deadTrigger");
    end
end
--受击
function this:Hit(hitType)
    --self.character.animator:SetBool("hitEnd",false);
    --self.hitLeftTime = time * 0.001;
    self.character.animator:SetInteger("hitType",hitType);
    self.character.animator:SetTrigger("hitTrigger");
end
--技能
function this:Cast(castName)          
    self.character.animator:Play(castName);
end
--设置眩晕状态
function this:SetStunState(state)
    self.character.animator:SetBool("stun",state and state ~= 0);
end

--胜利
function this:Win()  
    if(not self.character or IsNil(self.character.animator))then
        return;
    end
    self.character.animator:Play("win");
    --self.character.animator:SetBool("win",true);
end

return this;