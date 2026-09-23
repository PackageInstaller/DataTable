local this = {};

this.list = {};

--获取角色
function this:Get(id)    
    return id ~= nil and self.list[id] or nil;
end

--获取全部角色
function this:GetAll()
    return self.list;
end

function this:GetFront(teamId)
    local targetCharacter = nil;

    local list = self:GetAll();
    if(list)then
        for _,character in pairs(list)do
            if(character.GetTeam() == teamId)then
                if(targetCharacter)then
                    local x1 = targetCharacter.GetPos();
                    local x2 = character.GetPos();
                    if(math.abs(x1) > math.abs(x2))then
                        targetCharacter = character;
                    end
                else
                    targetCharacter = character;
                end
            end
        end
    end
    
    return targetCharacter;
end

--获取队伍中点
function this:GetCenterPos(teamId)
    local xMin,xMax,zMin,zMax;

    local targetCharacter = nil;

    local list = self:GetAll();
    if(list)then
        for _,character in pairs(list)do
            if(character.GetTeam() == teamId)then
                local x,y,z = character.GetPos();   
                xMin = xMin and (xMin > x and x or xMin) or x;           
                xMax = xMax and (xMax < x and x or xMax) or x;      
                
                zMin = zMin and (zMin > z and z or zMin) or z;           
                zMax = zMax and (zMax < z and z or zMax) or z;                 
            end
        end
    end
    xMin = xMin or 0;
    xMax = xMax or 0;
    zMin = zMin or 0;
    zMax = zMax or 0;

    return (xMin + xMax) * 0.5,0,(zMin + zMax) * 0.5;
end


function this:SetAllShowState(isShow)
    --LogError("状态：" .. (isShow and "是" or "否"));

    local all = self:GetAll();
    if(all)then
        for _,character in pairs(all) do
            character.SetShowState(isShow);
        end
    end
end

function this:IsSpecialId(id)
    return id and id == 1 or id == 2;
end

--创建角色
function this:Create(characterData)
--    DebugLog("创建角色信息");
--    DebugLog(characterData);

    --id
    local id = characterData.id;
    
    --特殊id
    if(id == nil or self:IsSpecialId(id))then
        LogError(characterData);
        return;
    end

--    if(self.list[id])then
--        LogError("创建角色失败，id重复：" ..  tostring(id));
--        LogError(characterData);
--        return;
--    end

    --角色模型ID
    local modelId = characterData.model;

    local go = CSAPI.CreateGO("Character");
    local luaCharacter = ComUtil.GetLuaTable(go);
    luaCharacter.InitData(characterData);
    luaCharacter.Init(modelId);

    self.list[id] = luaCharacter;
    EventMgr.Dispatch(EventType.Character_Create,luaCharacter);
    
    return luaCharacter;
end

--移除角色
function this:Remove(character)
    if(not character)then
        return;
    end
    
    local id = character.GetID();

    if(character == self.list[id])then
        EventMgr.Dispatch(EventType.Character_Removed,character);
        self.list[id] = nil;
    end    
end

--清理
function this:Clean()
    for _,v in pairs(self.list)do
        if(v ~= nil)then
            v.Remove();
        end
    end
    self.list = {};
    self.deads = {};
    self:ClearTransformState();
end

----角色加入死亡列表
--function this:AddDeadCharacter(character)
--    if(character == nil)then
--        return;
--    end

--    self.deads = self.deads or {};

--    local deadData = {};
--    deadData.id = character.GetID();
--    deadData.teamId = character.GetTeam();
--    deadData.cfgId = character.GetCfgID();

--    self.deads[deadData.id] = deadData;

--    --LogError("添加死亡角色");
--    --LogError(deadData);
--end
----角色从死亡列表移除
--function this:RemoveDeadCharacter(id)   
--    if(self.deads and id)then  
--        self.deads[id] = nil;
--    end
----end
----获取死亡列表
--function this:GetDeadsByTeam(teamId)
--    --LogError("获取死亡列表");
--    --LogError(self.deads);
--    local deadList = {};
--    if(self.deads)then
--        for id,deadData in pairs(self.deads)do
--            if(TeamUtil:IsEnemy(deadData.teamId) == false)then
--                deadList[id] = deadData;
--            end
--        end
--    end
--    return deadList;
--end

--预加载一组角色
function this:Preload(arr,callBack)
    if(arr == nil)then
        --LogError("预加载角色数组为空！");
        if(callBack ~= nil)then
            callBack();
        end
        return;
    end

    ResUtil:LoadCharacterAbs(arr,callBack);
end



--预加载角色
--datas:后端发过来的角色数据
function this:PreloadCharacters(datas,func,caller)
    if(datas == nil)then
        LogError("预加载角色失败！无效数据");
    end

    local modelIds = {};
    for _,data in pairs(datas)do
        local modelId = data.characterData.model;
        table.insert(modelIds,modelId);
    end

    local callBack = FuncUtil:ApplyCallBackFunc(func,caller);

    CharacterMgr:Preload(modelIds,callBack.OnCallBack);
end

function this:PreloadByCfgId(id)
    local cfg = Cfgs.CardData:GetByID(id) or Cfgs.MonsterData:GetByID(id);
    if(cfg)then
        --LogError("预加载模型：" .. cfg.name);
        CharacterMgr:Preload({cfg.model});
    end
end

--创建角色
--datas:后端发过来的角色数据
function this:CreateCharacters(datas)
    local list = {};

    for _,data in pairs(datas) do
        --队伍编号
        local teamId = data.teamId;
        teamId = TeamUtil:ToClient(teamId);

        local character = self:Create(data.characterData);    
        if(character)then
            character.uid = data.uid;
            character.SetTeam(teamId);
            character.ResetAngle();
            local isPutIn =  character.PutIn();         
            if(isPutIn == false)then
                LogError("位置被占用，无法放入新角色");
                --LogError("角色数据");
                --Log(data);
            end
            table.insert(list,character);
            
            local transformState = self:GetTransformState(character.GetID());               
            if(transformState)then
                character.SetTransformState(transformState);
            end
        else
            if(not data.characterData or not self:IsSpecialId(data.characterData.id))then
                LogError("创建角色过程中出现错误，数据如下！！！");
                LogError(datas);
            end
        end
    end     
    return list;     
end


--加载模型资源
function this:LoadModel(cfgModel,resParentGO,callBack)
    self:LoadModelBaseAB(cfgModel);
  
    local abName = cfgModel.ab_name or cfgModel.name;
    local res = abName .. "/" .. (StringUtil:IsEmpty(cfgModel.skin) and cfgModel.name or cfgModel.skin);
--    LogError(cfgModel);
--    LogError(res)
    ResUtil:LoadCharacterRes(res,0,0,0,resParentGO,callBack);
end

--按顺序加载模型资源list:{cfg=cfgModel,parentGO=resParentGO,callBack=callBack}
function this:LoadModelByOrder(list,delayTime)
    if list then
        local isLoading=true;
        delayTime=delayTime or 10;
        local coroFunc=coroutine.create(function(coro)
                for k,v in ipairs(list) do
                    isLoading=true;
                    self:LoadModel(v.cfg,v.parentGO,function(go)
                        isLoading=false;
                        if v.callBack then
                            v.callBack(go);
                        end
                        -- Log(TimeUtil:GetTime());
                        if coro~=nil and coroutine.status(coro)=="suspended" then
                            FuncUtil:Call(function()
                                coroutine.resume(coro);
                            end,nil,delayTime);
                        end
                    end);
                    if isLoading then
                        coroutine.yield();
                    end
                end
            end);
        coroutine.resume(coroFunc,coroFunc);
    end
end

function this:LoadModelBaseAB(cfgModel)
    if(cfgModel == nil or StringUtil:IsEmpty(cfgModel.ab_name))then
        return;
    end

    local abName = ResUtil:GenCharacterABName(cfgModel.ab_name);
    CSAPI.LoadABsByOrder({abName},nil,false,false);
end

--获取标记partSign的所有部位
function this:GetPartCharacters(partSign,ignorePartCharacter)
    if(StringUtil:IsEmpty(partSign))then
        return;
    end
    local partCharacters = nil;
    local list = self:GetAll();
    if(list)then
        for _,character in pairs(list)do
            if(character.GetPartSign() == partSign and character ~= ignorePartCharacter)then
                partCharacters = partCharacters or {};
                table.insert(partCharacters,character);
            end
        end
    end
    return partCharacters;
end
--同步部位状态
function this:SyncPartState(partSign,state,ignorePartCharacter)
    local partCharacters = self:GetPartCharacters(partSign,ignorePartCharacter);
    if(partCharacters)then
        for _,character in ipairs(partCharacters)do
            character.SyncPartState(state);
        end
    end
end

function this:SetTransformState(id,state)
    self.transformStates = self.transformStates or {};
    self.transformStates[id] = state;
end
function this:GetTransformState(id)
    return self.transformStates and self.transformStates[id];
end
function this:ClearTransformState()
    self.transformStates = nil;
end

return this;