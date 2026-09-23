--战斗中位置计算工具
FightPosType = 
{ 
    --目标前
    Target_Front = 0,
    --目标位置
    Target = 1,
        
    --敌方场地前
    Enemy_Ground_Front = 2,
    --敌方场地中心
    Enemy_Ground_Center = 3,
   
    --命中目标
    Hit_Target = 4,

     --选中格子
    Sel_Grid = 5,

    --行动者
    Actor = 6,

    --目标部位
    Target_Part = 7,

    --行动者和目标中点
    Between_Actor_And_Target = 8,

    --场地中点
    Fight_Ground_Center = 10,

    --我方场地前
    My_Ground_Front = 12,
    --我方场地中点
    My_Ground_Center = 13,

    --治疗目标
    CureTarget = 14,
    --Buff目标
    BuffTarget = 15,
    --Debuff目标
    DebuffTarget = 16,
}


local this = {};

--function this:CalculatePos(data,fightAction,target)
--    if(data == nil)then
--        LogError("未指定任何位置信息，无法计算");
--        return 0,0,0;
--    end
--end


--计算位置
function this:Calculate(cfg,originCharacter,targetCharacter,fightAction)
    if(self.posRefFuncList == nil)then
        self.posRefFuncList = {};

        --------------------------------------角色相关--------------------------------------

        --行动者
        self.posRefFuncList[FightPosType.Actor] = self.CalculatePos_OriginCharacter;

        
        --攻击目标占格前
        self.posRefFuncList[FightPosType.Target_Part] = self.CalculatePos_Target_Part;
        --攻击目标占格前
        self.posRefFuncList[FightPosType.Target_Front] = self.CalculatePos_Target_Front;
        --攻击目标
        self.posRefFuncList[FightPosType.Target] = self.CalculatePos_Target_Center;       
     
        --行动者和攻击目标中心
        self.posRefFuncList[FightPosType.Between_Actor_And_Target] = self.CalculatePos_Between_Origin_Target;

        --Buff目标
        self.posRefFuncList[FightPosType.BuffTarget] = self.CalculatePos_Buff_Target;
        --Debuff目标
        self.posRefFuncList[FightPosType.DebuffTarget] = self.CalculatePos_Debuff_Target;    

        --命中目标
        self.posRefFuncList[FightPosType.Hit_Target] = self.CalculatePos_Hit_Target;           

        --------------------------------------场地相关--------------------------------------

        --战场中心
        self.posRefFuncList[FightPosType.Fight_Ground_Center] = self.CalculatePos_FightGroundCenter;

        --行动者场地前
        self.posRefFuncList[FightPosType.My_Ground_Front] = self.CalculatePos_MyFightGround_Front;
        --行动者场地中心
        self.posRefFuncList[FightPosType.My_Ground_Center] = self.CalculatePos_MyFightGround_Center; 

        --行动者敌人场地前
        self.posRefFuncList[FightPosType.Enemy_Ground_Front] = self.CalculatePos_EnemyFightGround_Front;
        --行动者敌人场地中心
        self.posRefFuncList[FightPosType.Enemy_Ground_Center] = self.CalculatePos_EnemyFightGround_Center;


        
        self.posRefFuncList[FightPosType.Sel_Grid] = self.CalculatePos_SelectGrid_Center;
--        self.posRefFuncList[5] = self.CalculatePos_SelectGrid_FixationRow;        
--        self.posRefFuncList[7] = self.CalculatePos_FireBall;      
    end

    if(not cfg)then      
        --LogError("无法获取位置"); 
        return 0,0,0;
    end
--    LogError("计算位置=============================");
--    LogError(cfg);
    local func = self.posRefFuncList[cfg.ref_type];
    if(func == nil)then
        LogError("originCharacter:" ..  (originCharacter and tostring(originCharacter:GetName()) or ""));
        LogError("targetCharacter:" ..  (targetCharacter and tostring(targetCharacter:GetName()) or ""));
        LogError("cureCharacter:" ..  (fightAction and fightAction:GetCureCharacter() and tostring(fightAction:GetCureCharacter():GetName()) or ""));

        LogError("找不到计算位置的方法"); 
        LogError(cfg); 
    end
    local x,y,z = func(self,cfg,originCharacter,targetCharacter,fightAction);
    x = x or 0;
    y = y or 0;
    z = z or 0;

    local heightOffset = 0;
    if(cfg.offset_height ~= nil)then
        heightOffset = cfg.offset_height * 0.01;
    end
    y = y + heightOffset;

    if(cfg.lock_row or cfg.lock_col)then
        local character = originCharacter;
        if(fightAction)then
            character = fightAction:GetActionTarget(cfg);  
        end

        local dir = character and character.GetDir() or 1;

        local x0,z0 = self:CalculateOffset(cfg,dir);
        x = cfg.lock_row and x0 or x;
        z = cfg.lock_col and z0 or z;
    end
   
    --LogError("x:"..x..",y:"..y.. ",z:" ..z);
    return x,y,z;
end

function this:SetOverTurn(overTurnState)
    self.overTurnState = overTurnState;
    --LogError(tostring(overTurnState));
end

--计算偏移量
function this:CalculateOffset(cfg,dir)
    local gridSize = FightGroundMgr:GetGridSize();

    local offsetRow = cfg.offset_row or 0;
    local offsetCol = cfg.offset_col or 0;

    local x = offsetRow * 0.01 * gridSize * dir;
    local y = offsetCol * 0.01 * gridSize;    

    if(self.overTurnState)then
        y = y * dir;         
    end
    --local y = offsetCol * 0.01 * gridSize * -dir;   

--    LogError("计算偏差结果：x=" .. x);
--    LogError(cfg);
--    LogError(dir);
    return x,y;
end
--计算X坐标
--rowValue：排值
--teamId：队伍编号
function this:CalculateX(rowValue,teamId)
    local dir = TeamUtil:GetTeamDir(teamId);
    local gridSize = FightGroundMgr:GetGridSize();
    --中间间隔1半，本身格子半个格子
    local x = (rowValue + 0.5 + FightGroundMgr:GetCenterSpace() * 0.5) * gridSize * dir;
    return x;
end

----计算锁定位置
--function this:CalculateLock(cfg,teamId)
--    local x = nil;
--    local z = nil;

--    if(cfg.lock_row)then
--        x = self:CalculateX(cfg.lock_row,teamId);
--    end

--    if(cfg.lock_col)then
--        local gridSize = FightGroundMgr:GetGridSize();
--        z = (cfg.lock_col - 2) * -1 * gridSize;   
--    end

--    return x,z;
--end


--7
--参照目标部位
function this:CalculatePos_Target_Part(cfg,originCharacter,targetCharacter)
    if(targetCharacter == nil)then
        LogError("计算目标位置失败！！！缺少目标");
        LogError(cfg);
        return;
    end
    local partIndex = cfg.part_index;
    local x,y,z = targetCharacter.GetPartPos(partIndex);

    local xOffset,yOffset = self:CalculateOffset(cfg,targetCharacter.GetDir());
    return x + xOffset,y,z + yOffset;
end

--0
--参照目标部位
function this:CalculatePos_Target_Front(cfg,originCharacter,targetCharacter)
    if(targetCharacter == nil)then
        LogError("计算目标位置失败！！！缺少目标");
        LogError(cfg);
        return;
    end
  
    local x,y,z = targetCharacter.GetPos(partIndex);

    local rowIndex1 = 0;
    local sizeX = 0;
    local attacher = FightGroundMgr:GetCharacterAttacher(targetCharacter);

    if(attacher ~= nil and attacher.list ~= nil)then
        for _,placeholdInfo in pairs(attacher.list) do
            --rowIndex1 = placeholdInfo.firstRowIndex;
            sizeX = placeholdInfo.sizeX;
            break;
        end
    end

    --local teamId = targetCharacter.GetTeam();
    local dir = targetCharacter.GetDir();
    local xDelta = sizeX * 0.5 * -dir;
    --LogError("sizeX:" .. sizeX .. ",dir:" .. dir);
    x = x + xDelta;

    local xOffset,yOffset = self:CalculateOffset(cfg,targetCharacter.GetDir());
--    DebugLog("x:".. x .. ",z:" ..z);
--    DebugLog("xOffset:".. xOffset .. ",yOffset:" .. yOffset);
    return x + xOffset,y,z + yOffset;
end
--1
--参照目标中点
function this:CalculatePos_Target_Center(cfg,originCharacter,targetCharacter)
    if(targetCharacter == nil)then
        LogError("计算目标位置失败！！！缺少目标");
        LogError(cfg);
        return;
    end

    local x,y,z = targetCharacter.GetPos();

    local teamId = targetCharacter.GetTeam();
    local xOffset,yOffset = self:CalculateOffset(cfg,targetCharacter.GetDir());

    return x + xOffset,y,z + yOffset;
end

--2
--敌方场地前
function this:CalculatePos_EnemyFightGround_Front(cfg,originCharacter,targetCharacter)
    if(targetCharacter == nil)then
        LogError("计算行动者敌方场地位置失败！！！缺少行动者");
        LogError(cfg);
        return;
    end
    local originTeamId = originCharacter.GetTeam();
    local teamId = TeamUtil:GetOpponent(originTeamId);

    local x = self:CalculateX(0.5,teamId);
    local xOffset,yOffset = self:CalculateOffset(cfg,TeamUtil:GetTeamDir(teamId));

    return x + xOffset,0,yOffset;
end

--3
--参照敌方场地中心
function this:CalculatePos_EnemyFightGround_Center(cfg,originCharacter,targetCharacter)
    if(originCharacter == nil)then
        LogError("计算行动者敌方场地位置失败！！！缺少行动者");
        LogError(cfg);
        return;
    end

    local originTeamId = originCharacter.GetTeam();
    local teamId = TeamUtil:GetOpponent(originTeamId);

    local x,y,z = FightGroundMgr:GetCenter(teamId);
    local xOffset,yOffset = self:CalculateOffset(cfg,TeamUtil:GetTeamDir(teamId));

    return x + xOffset,y,z + yOffset;
end

--4
--参照目标中点
function this:CalculatePos_Hit_Target(cfg,originCharacter,targetCharacter)
    if(targetCharacter == nil)then
        --LogError("计算命中目标位置失败！！！缺少目标");
        --LogError(cfg);
        return;
    end

    local partIndex = cfg.part_index;
    local x,y,z;
    if(partIndex)then
        x,y,z = targetCharacter.GetPartPos(partIndex);
    else
        x,y,z = targetCharacter.GetPos();
    end

    local xOffset,yOffset = self:CalculateOffset(cfg,targetCharacter.GetDir());
   
    return x + xOffset,y,z + yOffset;
end

--5
--选中格子中点
function this:CalculatePos_SelectGrid_Center(cfg,originCharacter,targetCharacter,fightAction)

    if(fightAction == nil)then
        LogError("计算格子位置失败，缺少技能FightAction，无法获取选中格子相关数据！");
        return;
    end

    local actorCharacter = fightAction:GetActorCharacter();
    local actorTeamId  = actorCharacter.GetTeam();
    local teamId  = actorTeamId;

    local cfgSkill = Cfgs.skill:GetByID(fightAction:GetSkillID());
    if(cfgSkill.target_camp == 0)then
        teamId = TeamUtil:GetOpponent(teamId);
    end

    local rowIndex,colIndex = fightAction:GetSelGridData();

    local luaFightGrid = FightGroundMgr:GetGrid(rowIndex,colIndex,teamId);
    
    local x = self:CalculateX(rowIndex,teamId);
    local z = luaFightGrid and luaFightGrid.y or 0;
    local dir = TeamUtil:GetTeamDir(teamId);
    local xOffset,yOffset = self:CalculateOffset(cfg,dir);
    --LogError(teamId);LogError(cfg);
    return x + xOffset,0,z + yOffset;
end

--5
--选中格子列，排数由配置
--function this:CalculatePos_SelectGrid_FixationRow(cfg,originCharacter,targetCharacter,fireBall,rowIndex,colIndex)

--    local originTeamId = originCharacter.GetTeam();
--    local teamId = TeamUtil:GetOpponent(originTeamId);

--    local luaFightGrid = FightGroundMgr:GetGrid(rowIndex,colIndex,teamId);

--     local x = self:CalculateX(0,teamId);
--     local z = luaFightGrid.y;

--     local xOffset,yOffset = self:CalculateOffset(cfg,teamId);

--     return x + xOffset,0,z + yOffset;
--end

--6
--参照行动者
function this:CalculatePos_OriginCharacter(cfg,originCharacter,targetCharacter)
    if(originCharacter == nil)then
        LogError("计算行动者位置失败！！！缺少行动者");
        LogError(cfg);
        return;
    end

    local x,y,z = originCharacter.GetPos();

    local teamId = originCharacter.GetTeam();
    --LogError("队伍ID：" .. teamId);
    local xOffset,yOffset = self:CalculateOffset(cfg,originCharacter.GetDir());

    return x + xOffset,y,z + yOffset;
end
--7
--参照FireBall
--function this:CalculatePos_FireBall(cfg,originCharacter,targetCharacter,fireBall,rowIndex,colIndex)
--    local x,y,z = CSAPI.GetPos(fireBall.goAction);
--    local teamId = originCharacter.GetTeam();
--    local xOffset,yOffset = self:CalculateOffset(cfg,teamId);

--    return x + xOffset,y,z + yOffset;
--end


--8
--参照行动者和目标中心
function this:CalculatePos_Between_Origin_Target(cfg,originCharacter,targetCharacter)
    if(originCharacter == nil or targetCharacter == nil)then
        LogError("计算目标位置失败！！！缺少行动者和目标");
        LogError(cfg);
        return;
    end
   

    local x1,y1,z1 = originCharacter.GetPos();
    local x2,y2,z2 = targetCharacter.GetPos();

    local x,y,z = (x1 + x2) * 0.5,(y1 + y2) * 0.5,(z1 + z2) * 0.5;
--    DebugLog(x1 .. "," .. y1 .. "," .. z1);
--    DebugLog(x2 .. "," .. y2 .. "," .. z2);
--    DebugLog(x .. "," .. y .. "," .. z);
    local teamId = originCharacter.GetTeam();
    local xOffset,yOffset = self:CalculateOffset(cfg,originCharacter.GetDir());

    return x + xOffset,y,z + yOffset;
end


--10
--场地中心
function this:CalculatePos_FightGroundCenter(cfg,originCharacter,targetCharacter)   
    local teamId = nil;
    if(originCharacter)then
        teamId = originCharacter.GetTeam();       
    end
    local dir = TeamUtil:GetTeamDir(teamId);
 
    local gridSize = FightGroundMgr:GetGridSize();    

    local offsetRow = cfg.offset_row or 0;
    local offsetCol = cfg.offset_col or 0;
    local offsetHeight = cfg.offset_height or 0;

    local x = offsetRow * 0.01 * gridSize * dir;
    local y = 0;--offsetHeight * 0.01;
    local z = offsetCol * 0.01 * gridSize;    
    return x,y,z;
end


--12
--我方场地前
function this:CalculatePos_MyFightGround_Front(cfg,originCharacter,targetCharacter)
    if(originCharacter == nil)then
        LogError("计算行动者场地位置失败！！！缺少行动者");
        LogError(cfg);
        return;
    end

    local teamId = originCharacter.GetTeam();

    local x = self:CalculateX(0.5,teamId);
    local xOffset,yOffset = self:CalculateOffset(cfg,TeamUtil:GetTeamDir(teamId));

    return x + xOffset,0,yOffset;
end

--13
--参照我方场地中心
function this:CalculatePos_MyFightGround_Center(cfg,originCharacter,targetCharacter)
    if(originCharacter == nil)then
        LogWarning("计算行动者场地位置失败！！！缺少行动者");
        LogWarning(cfg);
        return;
    end

    local teamId = originCharacter.GetTeam();

    local x,y,z = FightGroundMgr:GetCenter(teamId);
    local xOffset,yOffset = self:CalculateOffset(cfg,TeamUtil:GetTeamDir(teamId));
    
    return x + xOffset,y,z + yOffset;
end



--15
--参照Buff目标中点
function this:CalculatePos_Buff_Target(cfg,originCharacter,targetCharacter)
    if(targetCharacter == nil)then
        LogError("计算Buff目标位置失败！！！缺少目标");
        LogError(cfg);
        return;
    end

    local x,y,z = targetCharacter.GetPos();

    local teamId = targetCharacter.GetTeam();
    local xOffset,yOffset = self:CalculateOffset(cfg,targetCharacter.GetDir());

    return x + xOffset,y,z + yOffset;
end
--16
--参照Debuff目标中点
function this:CalculatePos_Debuff_Target(cfg,originCharacter,targetCharacter)
    if(targetCharacter == nil)then
        LogError("计算Debuff目标位置失败！！！缺少目标");
        LogError(cfg);
        return;
    end

    local x,y,z = targetCharacter.GetPos();

    local teamId = targetCharacter.GetTeam();
    local xOffset,yOffset = self:CalculateOffset(cfg,targetCharacter.GetDir());

    return x + xOffset,y,z + yOffset;
end


return this;