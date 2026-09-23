local FireBallDatas = require "FireBallDatas";

local this = {};

--创建FireBall
--x,y,z：坐标
--character：创建者
--data：数据
--cfg：配置
--parent：父节点
function this:Create(x,y,z,character,data,cfg,parent,hitTarget)
    local fbGO = CSAPI.CreateGO("FireBall",x,y,z,parent); --ResUtil:CreateFireBall("FireBall",x,y,z,parent);
    local fireBall = ComUtil.GetLuaTable(fbGO);
    fireBall.Clear();
    if(hitTarget)then
        fireBall.SetHitTarget(hitTarget);
    end

    
    fireBall.Init(character,data,cfg);
    fbs = fbs or {};
    if(fireBall)then
        fbs[fireBall] = fireBall;
    end
    return fireBall;
end 

function this:ClearFBEffs()
    if(fbs)then
        for fb,_ in pairs(fbs)do
            if(fb and not fb.DontRemoveWhenSkip())then
                fb.RemoveEff();
            end
        end
    end
end

function this:ClearFBs()
    if(fbs)then
        for fb,_ in pairs(fbs)do
            if(fb)then
                fb.Remove();
            end
        end
    end
end


--获取目标角色FireBall数据
function this:GetDatas(characterName)
    
    if(StringUtil:IsEmpty(characterName))then
        return nil;
    end

    if(self.fireBallDatas == nil)then
        self.fireBallDatas = {};
    end

    if(self.fireBallDatas[characterName] == nil)then
        local targetName = FireBallDatas[characterName];
        if(targetName ~= nil)then
            self.fireBallDatas[characterName] = require ("" .. targetName);
        end
    end
    return self.fireBallDatas[characterName];
end

return this;