--战棋角色管理
BattleCharacterMgr = {};
local this = BattleCharacterMgr;


function this:Reset()
    self.characters = {};
end

function this:GetCharacter(id)
    if(not id)then
        return nil;
    end
    return self.characters and self.characters[id];
end
function this:GetAll()
    return self.characters;
end


--移除角色
function this:RemoveCharacter(id)
    if(self.characters)then
       self.characters[id] = nil; 
    end
end

function this:ApplyCreate(data,parentGo)
    if(self.createFuncs == nil)then
        self.createFuncs = {};
        self.createFuncs[eDungeonCharType.MyCard] = self.CreateMyCard;
        self.createFuncs[eDungeonCharType.MonsterGroup] = self.CreateMonster;
        self.createFuncs[eDungeonCharType.Prop] = self.CreateProp;
    end
    local func = self.createFuncs[data.type];
    if(func == nil)then
        LogError("战棋系统：创建单位失败！！！无法识别的类型");
        LogError(data);
        return nil;
    end

    if(data.state == eDungeonCharState.Death)then
        return;
    end    

    local character = self:GetCharacter(data.oid);
    if(character)then
        character.SetData(data);
    else
        character = func(self,data,parentGo);

        if(character)then
            character.SetData(data);
            character.SetToGrid(data.pos);        
            --character.ApplyBorn();
            self.characters[data.oid] = character;
        end

        EventMgr.Dispatch(EventType.Battle_Character_Created,character); 
    end

    return character;
end
--创建我方角色
function this:CreateMyCard(data,parentGo)
    if(not data)then
        LogError("创建副本角色失败");
        return;
    end
    local fightTeamData = TeamMgr:GetFightTeamData(data.nTeamID);    
    if(fightTeamData == nil)then
        UIUtil:LogFightTeamState();
        LogError("找不到战斗队伍数据！".. tostring(data.nTeamID) .. "\n" .. table.tostring(data,true));
        --return;
    end
    local leader = fightTeamData and fightTeamData:GetLeader();
    if(not leader)then
        LogError("编队中不存在队长！\n"  .. table.tostring(fightTeamData,true));
    end
    local leaderData = leader and FormationUtil.FindTeamCard(leader.cid);
    if(leaderData == nil)then        
        LogError("队长数据错误！！！cid=" .. tostring(leader and leader.cid));
    end

    local character = self:CreateCharacter(data.model,parentGo);   
    character.SetCfg(leaderData and leaderData.cfg);
--    character.SetMoveStep(leaderData.cfg.nStep);
--    character.SetJumpStep(leaderData.cfg.nJump);
    character.SetMoveStep(data.nStep);
    character.SetJumpStep(data.nJump);
    return character;
end
--创建怪物
function this:CreateMonster(data,parentGo)
    local cfgMonsterGroup = Cfgs.MonsterGroup:GetByID(data.nMonsterGroupID);
    local cfgMonsterData = Cfgs.MonsterData:GetByID(cfgMonsterGroup.monster);    
    local character = self:CreateCharacter(cfgMonsterData.model,parentGo);
    --character.SetScale(cfgMonsterGroup.monsterSize);
    character.SetCfg(cfgMonsterGroup);
    character.SetLv(cfgMonsterData.level);
   
--    character.SetMoveStep(cfgMonsterGroup.nStep);
--    character.SetJumpStep(cfgMonsterGroup.nJump);
    character.SetMoveStep(data.nStep);
    character.SetJumpStep(data.nJump);

    CSAPI.PreLoadScene(cfgMonsterGroup.scene);

    return character;
end

--新副本代码-----------------------------------------------------------------------------------------------

--创建角色（新）
function this:CreateCharacter(modelId,parentGo)    
    local go = CSAPI.CreateGO("BattleCharacter",0,0,0,parentGo);
    CSAPI.SetAngle(go,0,90,0);
    local lua = ComUtil.GetLuaTable(go);
    lua.Init(modelId);

    return lua;
end

--创建道具（新）
function this:CreateProp(data,parentGo)
    local go = CSAPI.CreateGO("BattlePropNew",0,0,0,parentGo);
    local character = ComUtil.GetLuaTable(go);

    character.InitProp(data.nPropID);
    return character;
end


return this;
