--副本道具

function Awake()
    action = ComUtil.GetCom(gameObject,"ActionBase");
end

--初始化道具
function InitProp(propId)
    local cfgGridProp = BattleMgr:GetPropSetting(propId);
   
    SetCfg(cfgGridProp);
    if(cfgGridProp)then      
        if(not StringUtil:IsEmpty(cfgGridProp.res))then          
            local x = cfgGridProp.offset_x and (cfgGridProp.offset_x * 0.01) or 0;
            local y = cfgGridProp.offset_y and (cfgGridProp.offset_y * 0.01) or 0;
            local z = cfgGridProp.offset_z and (cfgGridProp.offset_z * 0.01) or 0;
            
            ResUtil:CreateGridProp(cfgGridProp.res,x,y,z,resParentGO,nil,OnResLoaded);
            
            local angle = cfgGridProp.angle;
            if(angle)then
                CSAPI.SetAngle(resParentGO,0,angle,0);
            end
            if(cfgGridProp.flip)then
                CSAPI.SetScale(resParentGO,-1,1,1);
            end
        end
    else
        LogError("找不到关卡道具配置" .. propId);
    end    
end

--移动
function MoveTo(targetGridId,pathGos)   
    if(targetGridId == nil)then
        return;
    end

    if(pathGos)then
        local startGridGo = pathGos[1];
    else
        LogError("移动角色失败！！！路径无效");
    end

    currGridId = targetGridId;

    action:SetPath(pathGos,false);
    action:Play();
end

--出生特效
function ApplyBorn()
    if(isBorn)then
        return;
    end
    isBorn = 1;
    if(IsUsefull() or IsBox())then
        BattleMgr:CreateEff("Grid_VFX_2Op_Indicator_Item",GetCurrGridId());
    end 
end
function SetShowState(isShow)  
    if(luaRes and luaRes.UpdateActiveState)then
        CSAPI.SetGOActive(resParentGO,true);
        luaRes.UpdateActiveState(isShow);
    else
        CSAPI.SetGOActive(resParentGO,isShow);
    end
end

--设置迷雾状态
function SetMistState(state)
    SetShowState(state);
end

--设置数据
function SetData(targetData)
    data = targetData;

    if(IsTriggerActive())then
        SetShowState(false);  
    end
end
--更新数据
function UpdateData(targetData)
   data = targetData;
  
   if(targetData.pos and targetData.pos ~= GetCurrGridId())then
        SetToGrid(targetData.pos);
   end

   if(IsDead())then
       Remove();    
   end  
    if(IsTriggerBlock())then
    
        SetShowState(not IsTriggerActive());          

        BattleMgr:RefreshCharacterMoveRange();
    end
end
--获取数据
function GetData()
    return data;
end
--获取ID
function GetId()
    return data and data.oid;
end
--是否新刷出来的对象
function IsNew()
    return data and data.bIsNew;
end
--获取类型
function GetType()
    return data.type;
end

--设置配置
function SetCfg(targetCfg)
    cfg = targetCfg;
end
--获取配置
function GetCfg()
    return cfg;
end

--是否机关障碍
function IsTriggerBlock()
    return cfg and cfg.type == ePropType.Block;
end
--机关障碍是否激活
function IsTriggerActive()
    if(IsTriggerBlock() and data and data.state == eDungeonCharState.Active)then
        return true;
    end
    return false;
end

--是否阻拦玩家角色
--0：都不阻拦
--1：阻拦怪物
--2：阻拦玩家
--3：阻拦全部
function IsBlockCharacter(targetCharacter)
    if(not targetCharacter)then
        return false;
    end

    if(IsInHole())then--在坑洞里
        return false;
    end

    local isPlayer = targetCharacter.GetType() == eDungeonCharType.MyCard;
    local canFly = targetCharacter.CanFly();

    if(IsTriggerActive())then
        return false;
    end

    --LogError(canFly);
    local isBlock = false;
    if(cfg)then
        isBlock = cfg.eBlockState == 3 or (cfg.eBlockState == 2 and isPlayer) or (cfg.eBlockState == 1 and not isPlayer);--类型判断是否阻拦

        if(not isBlock)then
            
            --地空类型判断是否阻拦        
            local blockSetting = GetBlockSetting();
            if(blockSetting)then
                if((blockSetting == eBlockType.Ground and not canFly) or (blockSetting == eBlockType.Fly and canFly))then
                    isBlock = true;
                end
            end

            return isBlock;
        end
    end

    return isBlock;
end
--是否可破坏
function IsCanDestroy()
    return cfg and cfg.eCanDestroy;
end
--是否可推动
function IsCanPush()
    return cfg and cfg.type == ePropType.PushBox and not IsInHole();
end
--是否在坑中
function IsInHole()
   local grid = GetCurrGrid();
   if(grid and grid.GetHoleType() == eMapGridHoleType.Shallow)then
       return true;
   end
end
--获取阻拦设置
function GetBlockSetting()
    return cfg and cfg.eBlockSetting;
end

--设置到指定格子处
function SetToGrid(gridId)
    currGridId = gridId;
    local grid = BattleMgr:GetGrid(gridId);
    if(grid)then
        local x,y,z = grid.GetPos();
        CSAPI.SetPos(gameObject,x,y + 0.5,z);

        if(IsTransferStage())then
            local grid = BattleMgr:GetGrid(gridId);
            grid.SetActiveState(true);
        end
    end

    ApplyBorn();
end
--获取当前所在位置
function GetCurrGridId()
    return currGridId;
end
--获取当前所在格子
function GetCurrGrid()
    return BattleMgr:GetGrid(GetCurrGridId());
end

--是否战斗中
function IsFighting()
    return data and data.state == eDungeonCharState.Fighting;
end
--是否死亡
function IsDead()
    return data and data.state == eDungeonCharState.Death;
end

function UpdateState(state)
    if(data)then
        data.state = state;
    end
end

function Remove()
    BattleCharacterMgr:RemoveCharacter(GetId());
    
    if(luaRes and luaRes.RemoveRes)then
        luaRes.RemoveRes(DelteGO);
    else
        DelteGO();   
    end
end

function DelteGO()
    CSAPI.RemoveGO(gameObject);
end

function ApplyShake()
    if(cfg and cfg.shake_time)then
        local shakeDelay = cfg.shake_delay or 0;
        FuncUtil:Call(BattleMgr.ApplyShake,BattleMgr,shakeDelay,cfg.shake_time, cfg.shake_range);
    end
end

function ApplyUse(data,completeCallBack,caller)
    
    local character = BattleCharacterMgr:GetCharacter(data.oid);   

--    LogError(data);
--    LogError(cfg);
    if(cfg)then 
        local floatContent = cfg.float_content;
        if(cfg.float_content_id)then
            floatContent = LanguageMgr:GetTips(cfg.float_content_id);
        end
        if(floatContent)then    
            if(character and character.CreateFloatFont)then       
                --LogError("pp1");          
                character.CreateFloatFont(floatContent);
            end
        end
    end

    if(cfg and cfg.use_sound)then 
       CSAPI.PlayUISound(cfg.use_sound);
    end
    

    if(luaRes and luaRes.ApplyOpen)then
        luaRes.ApplyOpen();
    else
        local getEff = cfg and cfg.get_eff;
        if(getEff and currGridId and currGridId > 0)then
            CreateEff(getEff,currGridId);     
        end
    end
  
    --传送
    if(IsTransfer())then      
        local targetPosId = data.tParam and data.tParam.pos;
        local isTransferStage = IsTransferStage();
        if(isTransferStage)then           
            local grid = BattleMgr:GetGrid(currGridId);
            grid.SetActiveState(false);
        end
        BattleMgr:ApplyTransfer(data.oid,currGridId,targetPosId,isTransferStage,completeCallBack,caller,isTransferStage and this or nil);
       
        return;
    end

   
    
    if(data.type == ePropType.Box or data.type == ePropType.DisposableBox or data.type == ePropType.SecendBox)then--宝箱
        local rewards = data.tParam and data.tParam.reward;

        if(rewards)then

            if BattleMgr.battleData then
                BattleMgr.battleData.nBox=data.tParam.nBox;
            end
            EventMgr.Dispatch(EventType.Battle_BoxNum_Change,{
                type=DungeonStarType.BoxNum,
                num=data.tParam.nBox,
            });
            CSAPI.SetPos(resParentGO,0,-1000,0);
            --FuncUtil:Call(CSAPI.OpenView,nil,1500,"RewardPanel", {rewards});
            CSAPI.DisableInput(100);  
            --LogError("临时打印信息，如果卡住请联系前端，其他情况忽略：副本宝箱内容\n==============" .. table.tostring(rewards,true));        
            UIUtil:OpenReward( {rewards,closeCallBack = completeCallBack,caller = caller});
            if(BattleMgr:GetAIMoveState())then
                FuncUtil:Call(EventMgr.Dispatch,nil,1500,EventType.RewardPanel_Post_Close);
            end
            
            return;
        else
            LogError("box error\n" .. table.tostring(data,true));
            --LogError(data);
        end
    elseif(data.type == ePropType.Rand)then--随机道具
        local targetPropId = data.tParam and data.tParam.nPropID;
        local cfgTargetProp = BattleMgr:GetPropSetting(targetPropId); 
        SetCfg(cfgTargetProp);

        if(character)then            
            character.CreateFloatFont(cfgTargetProp.float_content);
        end

    elseif(data.type == ePropType.Damage or data.type == ePropType.DamagePercent)then
        local atkTarget = BattleCharacterMgr:GetCharacter(data.oid);   
        if(atkTarget)then
            atkTarget.ApplyHit();
        end                
        ApplyShake();
    elseif(data.type == ePropType.AttackObj)then
        --固定攻击范围机关
        --local atkEff = cfg.clientParam[1];
        local hitEff = cfg and cfg.get_eff;
        
        if(atkCom == nil)then
            atkCom = ComUtil.GetLuaTableInChildren(resParentGO);
        end
        if(atkCom)then
            atkCom.ActiveEff(true);
        end

        local atkTargets = data.tParam and data.tParam.targets;
        --受击
        if(atkTargets)then
            for _,target in ipairs(atkTargets)do
                local atkTarget = BattleCharacterMgr:GetCharacter(target);   
                if(atkTarget)then
                    atkTarget.ApplyHit();
                    ApplyShake();
                    local gridId = atkTarget.GetCurrGridId();
                    CreateEff(hitEff,gridId);

                    if(cfg and cfg.float_content)then 
                        atkTarget.CreateFloatFont(cfg.float_content);
                    end
                end                
            end
        end
    elseif(data.type == ePropType.WarmingPoised or data.type == ePropType.Rockfall)then--红蓝炮台攻击     

        local atkTargets = data.tParam and data.tParam.targets;
        local delayCallBack = false;

        local isWarmingPoised = data.type == ePropType.WarmingPoised;
         --受击
        --LogError(atkTargets);
        if(atkTargets)then
             if(atkCom == nil)then
                atkCom = ComUtil.GetLuaTableInChildren(resParentGO);
            end

            
            --isWarmingPoised = false;
            if(atkCom and isWarmingPoised)then
                atkCom.ActiveEff(true);
            end            
            
            local resEff = isWarmingPoised and "battle/LaserExpEffect";
            local characterHitDelayTime = not isWarmingPoised and 300; 
            
            for _,target in ipairs(atkTargets)do
                local atkTarget = BattleCharacterMgr:GetCharacter(target);  
                if(atkTarget)then
                    FuncUtil:Call(ApplyCharacterHit,nil,200,atkTarget,resEff,characterHitDelayTime);  
                    delayCallBack = true;
                end                
            end                       
        end
        --切换范围
        local changeRangeId = data.tParam and data.tParam.changeRange;
        if(changeRangeId)then
            local effName = (not isWarmingPoised) and "G_03_RockFallWarning1";
            if (delayCallBack) then
                FuncUtil:Call(ChangeRange,nil,500,changeRangeId,effName);  
            else
                ChangeRange(changeRangeId,effName);
            end            
        end       

        local triggerRange = data.tParam and data.tParam.triggerRange;
        if(triggerRange)then
            local effName = "rock_fall";
            ChangeRange(triggerRange,effName,true,true);
        end
              
        local nextRangeId = data.tParam and data.tParam.nextRange;
        if(nextRangeId)then
            if (delayCallBack) then
                FuncUtil:Call(ChangeRange,nil,500,nextRangeId,"dungeon_warning_next",true);  
            else
                ChangeRange(nextRangeId,"dungeon_warning_next",true);
            end            
        end

        

        if(delayCallBack)then
            FuncUtil:Call(completeCallBack,caller,1000);  
            return;
        end
    elseif(data.type == ePropType.WarmingThunderA)then--落雷
     
        local range = data.tParam and data.tParam.currRange;
        local groupId = cfg.ranges and cfg.ranges[range];
        if(not groupId)then
            LogError("ePropType.WarmingThunderA:not group Id\n" .. table.tostring(data));
        else
            BattleMgr:CreateGridEffsInRange(groupId,"thunder_attack")
        end
        
        ApplyShake();

        local atkTargets = data.tParam and data.tParam.targets;
        if(atkTargets and #atkTargets > 0)then
            AttackTargets(atkTargets,completeCallBack,caller,200,1000);
            return;
        end
        
    elseif(data.type == ePropType.AttackObjRand)then
        --随机攻击范围机关
        local isWarning = data.tParam and data.tParam.isWarn;
        local atkRange = data.tParam and data.tParam.range;
        local atkTargets = data.tParam and data.tParam.targets;
        
        local callBack = isWarning and OnWarnEffCreated or nil;

        local atkEff = isWarning and cfg.warn_eff or cfg.get_eff;
        if(atkRange)then
            for _,gridId in ipairs(atkRange)do
                CreateEff(atkEff,gridId,callBack);
            end
        end

        --受击
        if(atkTargets)then
            for _,target in ipairs(atkTargets)do
                local atkTarget = BattleCharacterMgr:GetCharacter(target);   
                if(atkTarget)then
                    atkTarget.ApplyHit();
                    ApplyShake();
                end
            end
        end

        --移除预警特效
        if(not isWarning)then
            RemoveWarningEffs();
            
            FuncUtil:Call(completeCallBack,caller,1000);  
            return;       
        end    
    elseif(data.type == ePropType.MonsterTrigger)then--随机道具 
        
        local tParam = data.tParam;
        if(tParam)then
            if(tParam.enterFight)then
                local character = GetTriggerTarget();
                if(character)then
                    local targetPos = tParam.pos;
                    BattleMgr:SetFightCheck(targetPos);

                    local pathGos = {};
                    
                    local path = BattleMgr:GetPath(character.GetCurrGridId(),targetPos);
                    for _,grid in ipairs(path)do
                        table.insert(pathGos,grid.gameObject);
                    end              
                    character.SetToFighting();
                    character.MoveTo(targetPos,pathGos,completeCallBack,caller);
                end
                return;
            else
                local dir = tParam.currdir;
                UpdateTriggerTargetDir(dir);
            end
        end    
    elseif(data.type == ePropType.AttackBackB)then--击退陷阱B 
        local tParam = data.tParam;
        if(tParam and tParam.warning)then
            --攻击预警
            if(luaRes and luaRes.ApplyWarning)then
                luaRes.ApplyWarning();
            end
        else
            --攻击表现
            if(luaRes and luaRes.ApplyAtk)then
                luaRes.ApplyAtk();
            end
        end        
        
        local targetPos = tParam.despos;
        if(targetPos)then
            local targetIDs = data.tParam and data.tParam.targetIDs;

            if(targetIDs)then
                for targetIndex,targetID in ipairs(targetIDs)do
                    local character = BattleCharacterMgr:GetCharacter(targetID); 

                    if(character)then
                        
                     
                        local hitCallBack = function()                                                
                            BattleMgr:RefreshCharacterMoveRange();
                            if(completeCallBack)then
                                --LogError("完成回调");
                                completeCallBack(caller);
                                completeCallBack = nil;
                            end
                        end

                        local path = BattleMgr:GetPath(character.GetCurrGridId(),targetPos);
                        if(path and #path > 0)then
                            local pathGos = {};
                            for _,grid in ipairs(path)do
                                table.insert(pathGos,grid.gameObject);
                            end  

                            FuncUtil:Call(function ()
                                character.MoveTo(targetPos,pathGos,hitCallBack,nil,true);
                                character.ApplyHit();
                            end,nil,350);
                        else
                           hitCallBack();       
                           character.ApplyHit();  
                        end
                        --LogError("击退");

                        
                        
                    else
                        LogError("no character");
                    end 
                end                    
                return;                             
            end
        end  
    end
    

    if(completeCallBack)then
        completeCallBack(caller);
    end
end


function AttackTargets(atkTargets,completeCallBack,caller,hitDelay,callBackDelay)
    local delayCallBack = false;
        --受击
    if(atkTargets)then
        for _,target in ipairs(atkTargets)do
            local atkTarget = BattleCharacterMgr:GetCharacter(target);   
                
            if(atkTarget)then
                FuncUtil:Call(ApplyCharacterHit,nil,hitDelay,atkTarget);  
                delayCallBack = true;
            end
        end

        if(delayCallBack)then
            FuncUtil:Call(completeCallBack,caller,callBackDelay);  
            return true;
        end
    end
end

function ApplyCharacterHit(character,effectName,hitDelay)
    if(effectName)then
        local x,y,z = CSAPI.GetPos(character.gameObject);
        if(effectName)then
            ResUtil:CreateEffect(effectName,x,y,z);
        end
    end

    if(hitDelay)then
        FuncUtil:Call(CharacterHit,nil,hitDelay,character); 
    else
        CharacterHit(character);
    end    
end

function CharacterHit(character)
    character.ApplyHit();
    ApplyShake(); 
    if(cfg and cfg.float_content)then 
        character.CreateFloatFont(cfg.float_content);
    end
end


--红蓝炮台切换范围
function ChangeRange(changeRangeId,effName,dontClear,dontSave)
    if(not cfg )then
        LogError("ChangeRange:not cfg");
        return;
    end
    local groupId = cfg.ranges and cfg.ranges[changeRangeId];
    if(not groupId)then
        LogError("ChangeRange:not group Id " .. tostring(changeRangeId));
        return;
    end

    local gridIds = BattleMgr:GetGridGroup(groupId);
    if(not gridIds)then
        LogError("ChangeRange:not grid ids");
        return;
    end

    ChangeGridWarningObjs(gridIds,effName,dontClear,dontSave);
end

--切换格子预警对象
function ChangeGridWarningObjs(gridIds,effName,dontClear,dontSave)
    if(not dontClear)then
        RemoveWarningEffs();
    end

    if(not gridIds)then
        return;
    end

    for _,gridId in ipairs(gridIds)do
        --if(not BattleMgr:IsInMist(gridId))then
            CreateEff(effName or "dungeon_warning",gridId,function(go)
                if(not dontSave)then
                    OnWarnEffCreated(go,gridId);
                end
            end)
        --end
    end
end

function OnDestroy()  
    RemoveWarningEffs();

    BattleCharacterMgr:RemoveCharacter(GetId());
end

function RemoveWarningEffs()  
    if(warnEffs)then        
        for _,warnEff in pairs(warnEffs)do
            if(not IsNil(warnEff))then
                CSAPI.RemoveGO(warnEff);
            end
        end

        warnEffs = nil;
    end  
end

function UpdateWarningEffsShowState(mistGridId)
    if(warnEffs)then        
        for gridId,warnEff in pairs(warnEffs)do
            local isShow = not BattleMgr:IsInMist(gridId,mistGridId);
            CSAPI.SetLocalPos(warnEff,0,isShow and 0.5 or 1000,0);
        end
    end 
end

--创建攻击特效（机关陷阱）
function CreateEff(effName,gridId,callBack)
    if(not effName)then
        return;
    end

    effName = "battle/" .. effName;

    local grid = BattleMgr:GetGrid(gridId);
    if(not grid)then
        LogError("无法在指定位置创建特效" .. effName .. ",位置=" .. tostring(gridId));
        return;
    end
    ResUtil:CreateEffect(effName, 0,0.5,0,grid.gameObject,callBack);
end

function OnResLoaded(go)
    if(not IsNil(go))then
        luaRes = ComUtil.GetLuaTable(go);
    end
end

function GetLuaRes()
    return luaRes;
end

function OnWarnEffCreated(go,gridId)   
    warnEffs = warnEffs or {};
    if(gridId)then
        warnEffs[gridId] = go;
    else
        table.insert(warnEffs,go);
    end
    if(IsNil(gameObject))then
        CSAPI.RemoveGO(go);
    else
        UpdateWarningEffsShowState();
    end
end

function IsCanPass(targetCharacter)
    
    if(IsInHole())then--在坑洞里
        return true;
    end

    if(IsTriggerActive())then
        return true;
    end

    if(cfg and cfg.bIsCanPass)then
        if(cfg.type == ePropType.Damage or cfg.type == ePropType.DamagePercent)then
            local canFly = targetCharacter.CanFly();
            local paramState = cfg.param[1];
            if(paramState == 1 or (paramState == 2 and not canFly) or (paramState == 3 and canFly))then
                return flase;
            else
                return true;   
            end
        else
            return true;       
        end
    end

    return false;
end

--是否传送台
function IsTransferStage()
    if(GetType() == eDungeonCharType.Prop)then
        return cfg and cfg.type == ePropType.TransferStage or cfg.type == ePropType.TransferStageRand;
    end
end

--是否传送点
function IsTransfer()
    if(GetType() == eDungeonCharType.Prop)then
        return cfg and cfg.type == ePropType.TransferDoor or cfg.type == ePropType.TransferDoorRand or cfg.type == ePropType.TransferStage or cfg.type == ePropType.TransferStageRand;
    end
end

function IsAttackObj()
    if(GetType() == eDungeonCharType.Prop)then
        return cfg and cfg.type == ePropType.AttackObj;
    end
end

--是否一次性道路
function IsOneWay()
    if(GetType() == eDungeonCharType.Prop)then
        return cfg and cfg.type == ePropType.OnceWay;
    end
end
--哨兵道具
function IsMonsterTrigger()
    if(GetType() == eDungeonCharType.Prop)then
        return cfg and cfg.type == ePropType.MonsterTrigger;
    end
end


function IsUsefull()
    local state = cfg and 
    (cfg.type == ePropType.AddHp or cfg.type == ePropType.AddHpPercent or cfg.type == ePropType.Rand  or cfg.type == ePropType.AddNp);
    return state;
end

function IsBox()
    local state = cfg and 
    (cfg.type == ePropType.Box or cfg.type == ePropType.DisposableBox or cfg.type == ePropType.SecendBox);
    return state;
end

function IsTrigger()
    local state = cfg and cfg.type == ePropType.Trigger;
    return state;
end

function GetTriggerTarget()
    if(not IsMonsterTrigger())then
        return;
    end

    if(not triggerTargetId)then
        local characters = BattleCharacterMgr:GetAll();
        for id,character in pairs(characters)do
            if(character.GetType() == eDungeonCharType.MonsterGroup and character.GetCurrGridId() == GetCurrGridId())then
                triggerTargetId = id;
                character.SetTriggerPropId(GetId());
                break;
            end
        end
    end
    return BattleCharacterMgr:GetCharacter(triggerTargetId);
end

function UpdateTriggerTargetDir(dir)
    if(not dir)then
        return;
    end

    local character = GetTriggerTarget();
    if(not character)then
        return;
    end

    local x,y,z = CSAPI.GetPos(character.gameObject);
    if(dir == 1)then
        z = z + 1;
    elseif(dir == 2)then
        x = x + 1;
    elseif(dir == 3)then
        z = z - 1;
    elseif(dir == 4)then
        x = x - 1;
    else
        return;
    end

    CSAPI.SetPos(gameObject,x,y,z);
    character.FaceTo(gameObject);
end

--是否陷阱
function IsTap()
    if(GetType() == eDungeonCharType.Prop)then
        return cfg and cfg.type == ePropType.Damage or cfg.type == ePropType.DamagePercent;
    end
end

function GetTapType()
    return cfg and cfg.param[1] or 1;
end
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
resParentGO=nil;
end
----#End#----