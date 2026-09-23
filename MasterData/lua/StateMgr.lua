--状态管理

local StateDatas = require "StateDatas";

local this = {};

--获取目标角色FireBall数据
function this:GetDatas(characterName)
    
    if(StringUtil:IsEmpty(characterName))then
        return nil;
    end

    if(self.stateDatas == nil)then
        self.stateDatas = {};
    end

    if(self.stateDatas[characterName] == nil)then
        local targetName = StateDatas[characterName];
        if(targetName ~= nil)then
            self.stateDatas[characterName] = require ("" .. targetName);
        end
    end
    return self.stateDatas[characterName];
end

function this:GetCommonData(name)
    local stateDatas = self:GetDatas("common");
    return stateDatas[name];
end

----技能
--this.type_cast = 0;
----待机
--this.type_idle = 1;
----位移
--this.type_move = 2;
----受击
--this.type_hit = 3;
----死亡
--this.type_dead = 4;
----未定义
--this.type_unknown = -1;

--function this:IsCast(stateType)
--    return stateType == self.type_cast;
--end
--function this:IsIdle(stateType)
--    return stateType == self.type_idle;
--end
--function this:IsMove(stateType)
--    return stateType == self.type_move;
--end
--function this:IsHit(stateType)
--    return stateType == self.type_hit;
--end
--function this:IsDead(stateType)
--    return stateType == self.type_dead;
--end
return this;