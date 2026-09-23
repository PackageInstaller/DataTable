--战场角色
function Awake()
    action = ComUtil.GetCom(gameObject,"ActionBase");
    action:AddEnterLastGridCallBack(OnEnterLastGrid);
    action:AddEnterGridCallBack(OnEnterGrid);
    action:AddNextGridCallBack(OnNextGrid);    
    mgr = BattleMgr
    if SceneMgr:IsRogueMapDungeon() then
        mgr = RogueMapBattleMgr
    end
    FaceTo(mgr:GetCamera());
end

--初始化角色
function Init(modelId)    
    if(not modelId)then
        LogError("初始化战棋模型失败！！！模型为空");
        return;
    end
    --获取角色配置
    cfgModel = Cfgs.character:GetByID(modelId);   
    if(cfgModel == nil)then
        LogError("找不到模型数据！！！" .. tostring(modelId));
        return;
    end

    if(cfgModel.monsterSize)then
        SetScale(cfgModel.monsterSize);
    end

    CharacterMgr:LoadModel(cfgModel,resParentGO,OnResLoadComplete)  
  
    if(cfgModel.jumpHeight)then
        myJumpHeight = cfgModel.jumpHeight * 0.25;
    else
        myJumpHeight = nil;
    end
end
--设置缩放
function SetScale(size)
    local scale = size and size * 0.01 or 1;
    CSAPI.SetScale(resParentGO,scale,scale,scale);
end

--更新战斗显示
function UpdateFightShow()
    local isFighting = IsFighting();

    local type = GetType();

    if(infoView)then
        infoView.SetFightState(isFighting);
        if data.damage and type then
            infoView.SetMonsterHp(data.damage,isFighting==false);
        end
    end

--    if(not IsFighting() and GetType() == eDungeonCharType.MonsterGroup)then
--        SetShowState(true);
--    end
end

function SetShowState(isShow,ignoreTypeCheck)
    --LogError("name：" .. cAnimator.gameObject.name ..  ",show：" .. tostring(isShow));

    local targetShowState = isShow and not IsInviside();

    local type = GetType();
    if(not ignoreTypeCheck)then
        if(type == eDungeonCharType.MyCard)then
            return;
        end
    end
    CSAPI.SetLocalPos(posNode,0,targetShowState and 0 or 1000,0);

    if(infoView)then
        infoView.SetShowState(targetShowState);      
    end
end

--设置迷雾状态
function SetMistState(state)
    SetShowState(state);
end

function SetIceState(targetIceState,playEff)
    if(not cAnimator == nil)then
        return;
    end

     if(iceState == nil)then
        iceState = false;
    end
    if(targetIceState == iceState)then
        return;
    end

    iceState = targetIceState;
    local playEffStr = playEff and "" or "_NoEff";
    if(iceState)then
        FuncUtil:Call(function()
            CSAPI.ApplyAction(cAnimator.gameObject,"ActionFrostTrapStart" .. playEffStr); 
        end,nil,100);        
    else
        CSAPI.ApplyAction(cAnimator.gameObject, "ActionFrostTrapRecover" .. playEffStr);
    end
end

function GetIceState()
    return iceState;
end

--角色资源加载完成
function OnResLoadComplete(go)
    --Log("加载角色完成：" .. go.name);    
    --cAnimator = go:GetComponent("CAnimator");
    cAnimator = ComUtil.GetCom(go,"CAnimator");
    animator = cAnimator.animator; 

    UpdateIceEff(false);
end
--出生特效
function ApplyBorn()
    if(GetType() == eDungeonCharType.MonsterGroup and not IsInviside())then
        if(not mgr:IsInMist(currGridId))then
            mgr:CreateEff("monster_born",currGridId);
        end
    end 
end
--受击动作
function ApplyHit()
    if(not IsNil(animator))then
        animator:SetInteger("hitType",1);
        animator:SetTrigger("hitTrigger");
        CSAPI.PlayRandSound(cfgModel.s_hit,true,"hit");
    end
end
--设置动作状态
function SetMoveState(state)
    if(isSlide)then        
        if(not IsNil(cAnimator))then
            if(not lastJump)then
                cAnimator:ApplyPause(state and 3000 or 0);
            end
        end
        if(state)then
            return;
        end
    end

    if(not IsNil(animator))then
        SetPlayMoveSoundState(state);
        animator:SetBool("move",state) 
        if(state)then
            animator:Play("move");  
        end
    end
end
--设置数据
function SetData(targetData)  
    --LogError(targetData);
    data = targetData;

    if(IsFighting() and GetType() == eDungeonCharType.MonsterGroup)then
        SetShowState(false);
    end

    UpdateIceEff(false);
end

function UpdateBuffData(buffDatas)
--    local myBuffDatas = GetBuffDatas();

--    if(buffDatas)then
--        for k,buffData in pairs(buffDatas)do            
--            myBuffDatas[k] = buffData;
--        end
--    end
    if(data)then
        data.buffData = buffDatas;
    end
    UpdateIceEff(true);

    if(infoView)then
        infoView.UpdateBuff(this);
    end
end



function UpdateIceEff(playEff)
    local iceCount = GetIceBuffCount();
    SetIceState(iceCount > 0,playEff)
end

function GetBuffDatas()
    if(not data)then
        return;
    end
    data.buffData = data.buffData or {};
    return data.buffData;
end

function GetBuffData(key)
    local myBuffDatas = GetBuffDatas();
    return myBuffDatas and myBuffDatas[key];
end

--获取冰冻剩余回合
function GetIceBuffCount()
    local iceBuffData = GetBuffData("IceBuff");
    return iceBuffData and iceBuffData.nIceCount or 0;
end

--获取解毒草层数
function GetToxicideBuffCount()
    local buffData = GetBuffData("ToxicideBuff");
    return buffData and buffData.nBuffCount or 0;
end
--获取毒雾层数
function GetSmogBuffCount()
    local buffData = GetBuffData("SmogBuff");
    return buffData and buffData.nBuffCount or 0;
end

function LoadBottomRes(resName)
    local res = "UIs/Battle/" .. resName .. ".png";
    CSAPI.LoadSRInModule(bottom,res);
end

--更新数据
function UpdateData(targetData)
    data = targetData;
    UpdateFightShow();
    
    if(GetType() == eDungeonCharType.MyCard)then
        EventMgr.Dispatch(EventType.Battle_Character_Update,this);  
          
        if (IsDead()) then
            mgr:RefreshCharacterMoveRange();
            EventMgr.Dispatch(EventType.Battle_My_Character_Dead,this);  
        end        
    end
   
   if(targetData.pos and targetData.pos ~= GetCurrGridId())then
        SetToGrid(targetData.pos);
        mgr:RefreshCharacterMoveRange();
   end

   if(IsDead())then
        if(infoView)then
            infoView.Remove();
        end

        if(mgr:IsBatting() and TryPlayDead())then
            FuncUtil:Call(DeadEnd,nil,2000);
            --DeadEnd();
        else
            Remove();    
        end        
   end  
end
--尝试播放死亡动作
function TryPlayDead() 
    if(not IsNil(animator))then
        animator:SetBool("dead",true);
        animator:SetTrigger("deadTrigger");
    end
    return true;
end


--死亡结束
function DeadEnd()    
    if(isDeadEnd)then
        return;
    end
    isDeadEnd = true;

    local deadType = cfgModel.dead_type;

    if(deadType)then
        CSAPI.ApplyAction(gameObject,"action_dead_shader");
        CSAPI.ApplyAction(gameObject,"action_dead1");

        local x,y,z = CSAPI.GetPos(gameObject);
        FuncUtil:Call(ResUtil.CreateEffect,ResUtil,400,"common/dead1",x,y,z);
        --ResUtil:CreateEffect("common/dead1",0,0,0,gameObject);
        FuncUtil:Call(Remove,nil,500);

        FuncUtil:Call(
            function()
                local deadSounds = {"grenade_exploImpac_1","grenade_exploImpac_2"}
                local index = CSAPI.RandomInt(1, #deadSounds);        
	            CSAPI.PlaySound("fight/effect/explosion_.acb",deadSounds[index],false,false,nil,nil,nil,nil);
            end,nil,400);
    else
        --默认死亡类型
        CSAPI.ApplyAction(gameObject,"action_dead_shader");
        CSAPI.ApplyAction(gameObject,"action_dead");
        ResUtil:CreateEffect("common/dead_transfer",0,0,0,gameObject);         

        FuncUtil:Call(Remove,nil,1000);
    end
end

function GetData()
    return data;
end

function GetId()
    return data and data.oid;
end

function IsNew()
    return data and data.bIsNew;
end

function GetType()
    return data and data.type;
end


function SetCfg(targetCfg)
    cfg = targetCfg;
    if(IsInviside())then        
        SetShowState(false);
    end
end

function GetCfg()
    return cfg;
end

--是否隐身怪
function IsInviside()
    return not isAppear and cfg and cfg.inviside;
end
function SetAppear()
    --LogError("appear");

    isAppear = 1;
    FuncUtil:Call(SetShowState,nil,50,true);
    --SetShowState(true);
    animator:Play("enter");
    ResUtil:CreateEffect("battle/monster_appear_enter_eff",0,0.5,0,gameObject);
end

function SetTeamNO(no)
    teamNO = no;
    if infoView then
        infoView.SetTeamNO(teamNO);
    end
    LoadBottomRes("w_team" .. no)
end
function GetTeamNO()
    return teamNO;
end

function SetMoveStep(step)   
    moveStep = step;
end
function GetMoveStep()   
    return moveStep or 0;
end

function SetJumpStep(step)   
    jumpStep = step;
end
function GetJumpStep()   
    return jumpStep or 0;
end

--设置到指定格子处
function SetToGrid(gridId)
    currGridId = gridId;
    --LogError(GetId() .. ":" .. tostring(GetCurrGridId()))
    local grid = mgr:GetGrid(gridId);
    if(not grid)then
        LogError("设置角色位置失败，找不到目标格子" .. tostring(gridId));
        return;
    end
    local x,y,z = grid.GetPos();
    CSAPI.SetPos(gameObject,x,y + 0.5,z);
end

--处理滑动
--xDir:1上，-1下
--yDir:1右，-1左
--iceSlide：冰面滑动
function HandleSlide(xDir,yDir,iceSlide)
    local startGrid = GetCurrGrid();
    local currGrid = startGrid;   

    local slidePathGos = {};
    local targetGridId = nil;
    local bans,targetBans = mgr:GetGridBans(this);    


    local monsterGrids = {};

    --剔除可破坏、可推动的道具
    local allCharacters = BattleCharacterMgr:GetAll();       
    if(allCharacters)then           
        for _,tmpCharacter in pairs(allCharacters)do
           if(tmpCharacter.GetType() == eDungeonCharType.MonsterGroup)then
                if(tmpCharacter.IsFighting())then
                    targetBans = targetBans or {};
                    targetBans[tmpCharacter.GetCurrGridId()] = 1;
                end
                monsterGrids[tmpCharacter.GetCurrGridId()] = 1;
           end
           if(tmpCharacter.GetType() == eDungeonCharType.Prop)then    
                monsterGrids[tmpCharacter.GetCurrGridId()] = 1;            
                if(tmpCharacter.IsCanDestroy() or tmpCharacter.IsCanPush())then
                    targetBans = targetBans or {};
                    targetBans[tmpCharacter.GetCurrGridId()] = 1;
                end
            end

        end
    end

  
    for i = 1,100 do
        if(not currGrid)then
            break;
        end

        local gridId = currGrid.GetID();
        
        if((not targetBans or not targetBans[gridId]) or currGrid == startGrid)then--该格不可作为目标，滑动中不可通过，滑动结束
            table.insert(slidePathGos,currGrid.gameObject);
            targetGridId = gridId;
        else
            --LogError("不可作为目标" .. gridId);
            break;
        end

        if(monsterGrids and monsterGrids[targetGridId])then--遇怪，滑动结束                
            --LogError("遇怪" .. gridId);     
            slideHitMonster = 1;       
            break;
        end 

        if((not bans or not bans[gridId]) or currGrid == startGrid)then--该格不可通过，滑动结束
            
        else
            --LogError("不可通过" .. gridId);
            break;
        end 

        if(iceSlide and currGrid.GetType() ~= eMapGridType.Ice)then--冰面滑动，当前的格子已不是冰面，滑动结束
            --LogError("非冰面单位" .. gridId);
            break;
        end

        --刷新滑动方向
        if(currGrid.GetType() == eMapGridType.Slide)then
            local dir = currGrid.GetDir();           
            if(dir == 1)then
                xDir = 1;
                yDir = 0;
            elseif(dir == 2)then
                xDir = 0;
                yDir = 1;
            elseif(dir == 3)then
                xDir = -1;
                yDir = 0;
            elseif(dir == 4)then
                xDir = 0;
                yDir = -1;
            end
        end

        --滑动下一格
        local nextGrid = currGrid.GetNearGrid(xDir,yDir);  
        if(not nextGrid)then
            --LogError("没有下一格" .. gridId);
            break;
        elseif(currGrid.Height() ~= nextGrid.Height())then--高度不满足
            --LogError("高度不一致" .. gridId);
            break;
        elseif(not nextGrid.GetValidState())then--无效格子
            break;
        end      
        currGrid = nextGrid;
    end

    if(#slidePathGos > 1)then
--       for _,go in ipairs(slidePathGos)do
--          LogError(go.name);
--       end 
       MoveTo(targetGridId,slidePathGos,moveCallBack,moveCaller,true)         
    else
        HandleMoveComplete();
    end

end

--获取当前所在位置
function GetCurrGridId()
    return currGridId;
end
--获取当前所在格子
function GetCurrGrid()
    return mgr:GetGrid(GetCurrGridId());
end

--移动
function MoveTo(targetGridId,pathGos,callBack,caller,slide)   
    --LogError("move to" .. targetGridId);
    if(IsInviside())then
       SetAppear();       
       FuncUtil:Call(DoMoveTo,nil,1500,targetGridId,pathGos,callBack,caller,slide);
       return;
    end    
    if(GetType() == eDungeonCharType.MonsterGroup and not slide)then
        local currGridId = GetCurrGridId();
        if(not mgr:IsInMist(currGridId))then
            mgr:CreateEff("Grid_VFX_2Op_Indicator_Enemy",currGridId);
        end
        FuncUtil:Call(DoMoveTo,nil,1000,targetGridId,pathGos,callBack,caller,slide);

        if(GetTriggerPropId() and infoView)then--截击怪
            infoView.SetSentryState(2);
        end
    else
        DoMoveTo(targetGridId,pathGos,callBack,caller,slide);  
    end
end

function DoMoveTo(targetGridId,pathGos,callBack,caller,slide)  

    if(targetGridId == nil)then
        return;
    end

    if(pathGos)then
        local startGridGo = pathGos[1];
        _,currHeight,_ = CSAPI.GetPos(startGridGo);
    else
        LogError("移动角色失败！！！路径无效");
    end

    SetMonsterState(1)

    movePathGos = pathGos;
    isSlide = slide;

    currGridId = targetGridId;
    --LogError(GetId() .. ":" .. tostring(GetCurrGridId()));

    moveCaller = caller;
    moveCallBack = callBack;

    SetMoveState(true);  
    --LogError("开始移动"); 
    action:SetPath(pathGos,not isSlide);
    action:Play();--OnMoveCompleteCallBack);  
end
--进入最后一格
function OnEnterLastGrid()    
    SetMoveState(false);
    local delayTime;
    if(IsFighting() or slideHitMonster)then
        delayTime = PlayFightAction();
        slideHitMonster = nil;
    end
    if(delayTime)then
        FuncUtil:Call(OnMoveCompleteCallBack,nil,delayTime + 1200);
    else
        OnMoveCompleteCallBack();
    end
end



function PlayFightAction()
    if(isPlayed)then
        return;
    end
    local fightTarget = nil;
    local allCharacters = BattleCharacterMgr:GetAll();
    if(allCharacters)then
        for _,tmpCharacter in pairs(allCharacters)do
            local gridId = tmpCharacter.GetCurrGridId();          
            if(tmpCharacter ~= this and gridId == GetCurrGridId())then
                if(not tmpCharacter.IsDead())then             
                    fightTarget = tmpCharacter;
                    break;
                end
            end
        end
    end
    
    if(fightTarget and fightTarget:GetType() ~= eDungeonCharType.Prop)then
        isPlayed = 1;
        
        if(fightTarget.IsInviside() or IsInviside())then
           if(IsInviside())then
                SetAppear();                
           end
           if(fightTarget.IsInviside())then
                fightTarget.SetAppear();
           end

           local delayTime = 1500;
           FuncUtil:Call(ApplyFightFaceState,nil,delayTime,fightTarget);
           return delayTime;
        else
            ApplyFightFaceState(fightTarget);            
        end        
    end
end

function ApplyFightFaceState(fightTarget)
    CSAPI.ApplyAction(posNode,"action_battle_fight");    
    CSAPI.ApplyAction(fightTarget.posNode,"action_battle_fight");

    if(fightTarget and fightTarget.action)then
        fightTarget.action:RotateToFaceCamera(gameObject);
    end

    ResUtil:CreateEffect("common_hit/common_hit1",0,-0.5,0,gameObject);
    CSAPI.PlayUISound("ui_go_into_action");
end

--更新格子拖尾效果
function UpdateGridTrailEffState(grid,isMove)
--    if(GetType() == eDungeonCharType.MyCard)then
--    end
    
    --停止其他类型格子的拖尾特效
    if(gridTrailEffs)then
        for gridType,eff in pairs(gridTrailEffs)do
            if(not grid or grid.GetType() ~= grid)then
                eff.Stop();
            end
        end
    end

    if(not grid)then
        return;
    end

    local targetEff;
    targetEff = gridTrailEffs and gridTrailEffs[grid.GetType()];
    if(targetEff)then
        if(isMove)then
            targetEff.PlayMove();
        else
            targetEff.PlayIdle();
        end
    else
        CreateGridTrailEff(grid.GetType());
    end
end


function CreateGridTrailEff(gridType)
    if(not gridType)then
        return;
    end
    if(not gridTrailEffArr)then
        gridTrailEffArr = {};
        gridTrailEffArr[eMapGridType.Ice] = "battle/grid_trail_ice";
    end
    local path = gridTrailEffArr and gridTrailEffArr[gridType];
    if(not path)then
        return;
    end
    ResUtil:CreateEffect(path, 0,0,0,gameObject,function(go)
        local lua = ComUtil.GetLuaTable(go);
        gridTrailEffs = gridTrailEffs or {};
        gridTrailEffs[gridType] = lua;
    end);
end

function FaceTo(go)    
    if(not IsNil(action))then
        action:RotateToFaceCamera(go);
    end
end

function OnMoveCompleteCallBack()       
    SetMonsterState(2)

    local currGrid = GetCurrGrid();   
    if(currGrid)then
        if(currGrid.GetType() == eMapGridType.Slide)then
            FuncUtil:Call(HandleSlide,nil,10);  
            return;      
        elseif(currGrid.GetType() == eMapGridType.Ice)then            
            if(movePathGos and #movePathGos > 1)then
                local lastGo = movePathGos[#movePathGos - 1];
                local lastGrid = ComUtil.GetLuaTable(lastGo);
                local xDir = currGrid.x - lastGrid.x;
                local yDir = currGrid.y - lastGrid.y;

                --LogError(xDir .. ":" .. yDir);

                FuncUtil:Call(HandleSlide,nil,10,xDir,yDir,true);
                --HandleSlide(xDir,yDir,true);
                return;
            end             
        end    
    end

    HandleMoveComplete();
end
--处理移动完成
function HandleMoveComplete()
    if(moveCallBack)then
        local caller = moveCaller;
        local callBack = moveCallBack;

        moveCaller = nil;
        moveCallBack = nil;

        callBack(caller);        
    end

    UpdateFightShow();

    local grid = GetCurrGrid();
    if(grid)then
        UpdateGridTrailEffState(grid,false);
    end
end



--进入新的一格
function OnEnterGrid(goGrid)
    if(IsNil(goGrid))then
        return;
    end
    
    local lua = ComUtil.GetLuaTable(goGrid);
    if(lua)then
        lua.PlayAni(GetType() == eDungeonCharType.MonsterGroup);        
    end    

    local grid = mgr:GetGridByGO(goGrid);
    if(grid)then
        local gridId = grid.GetID();
        if(not mgr:IsInMist(gridId))then
            UpdateGridTrailEffState(grid,true);
        end        

        if(GetType() == eDungeonCharType.MyCard)then
            --LogError(gridId);
            mgr:UpdateCharactersMistState(gridId);--更新迷雾显示
        end
    end
end

--下一格
function OnNextGrid(goGrid)
    if(IsNil(goGrid))then
        return;
    end

    if(isSlide)then
        return;
    end

    local x,y,z = CSAPI.GetPos(goGrid);
    --LogError(tostring(myJumpHeight));
    --myJumpHeight = 0.5;
    if(myJumpHeight and currHeight and math.abs(currHeight - y) >= myJumpHeight)then
        animator:Play("jump",-1,0);
        action:SetJumpState();
        lastJump = 1;
    else   
        if(lastJump)then 
            animator:Play("move");  
        end
        lastJump = nil;
    end
    currHeight = y;
end


--设置战斗
function SetToFighting()
    if(data)then
        data.state = eDungeonCharState.Fighting;
    end
end
--是否战斗中
function IsFighting()
    return data and data.state == eDungeonCharState.Fighting;
end
--是否死亡
function IsDead()
    return data and data.state == eDungeonCharState.Death;
end
--是否可以飞行
function CanFly()
    local cfgCharacter = GetCfg();
    return cfgCharacter and cfgCharacter.nMoveType == eMoveType.Fly;
end

function CanPushObj()
    return 1;--HasPower(1);
end
function CanDestroyObj()
    return 1;--HasPower(2);
end
function HasPower(id)
    local fbSkills = cfg.fbSkills;
    if(fbSkills)then
        for _,fbSkill in ipairs(fbSkills)do
            if(fbSkill == id)then
                return true;
            end
        end
    end
end

--移动类型
function GetMoveType()
    local cfgCharacter = GetCfg();
    return cfgCharacter and cfgCharacter.nMoveType;
end
--是否忽略水面额外消耗
function IsIgonreWaterCost()
    return (GetMoveType() == eMoveType.Water) or (GetMoveType() == eMoveType.Fly) or (GetMoveType() == eMoveType.Float)
end


function UpdateState(state)
    if(data)then
        data.state = state;
    end
end

function SetInfoView(lua)
    infoView = lua;
    infoView.SetFightState(IsFighting());
    infoView.UpdateBuff(this);
    UpdateMonsterInfo();

    if(GetType() == eDungeonCharType.MonsterGroup and IsFighting())then
        infoView.SetShowState(false);     
    end
end 

function SetLv(lv)
    showLv = lv;
end

--更新怪物信息
function UpdateMonsterInfo()
    if(GetType() ~= eDungeonCharType.MonsterGroup)then
        return;
    end
    if(infoView and cfg and data)then
        -- infoView.SetMonsterInfo(cfg.type,showLv);
        local nInterval = cfg.nInterval;
        if(GetTriggerPropId())then--截击状态不显示行动间隔回合
            nInterval = nil;
        end
        infoView.SetMonsterInfo(cfg.type,data.nIntervaloff or 0,nInterval, showLv);
        if data.damage and cfg.type then
            infoView.SetMonsterHp(data.damage,IsFighting()==false);
        end

        local bottomRes = "monster1";
        if(cfg.type == 2)then
            bottomRes = "monster2";
        elseif(cfg.type == 3)then
            bottomRes = "w_monster3";            
        end
        LoadBottomRes(bottomRes);
    end
end


function IsBoss()
    return cfg and cfg.type == 3;
end

function SetSelectState(isSel)
    if(infoView)then
        infoView.SetSelectState(isSel);
    end
end

function Remove()
    BattleCharacterMgr:RemoveCharacter(GetId());
    CSAPI.RemoveGO(gameObject);
end


function CreateFloatFont(content)   
    if(infoView)then
        infoView.CreateFloatFont({content = content});
    end
end

function OnDestroy()
    if(GetIceState())then
        SetIceState(false);
    end

    SetPlayMoveSoundState(false);

    cAnimator = nil;
    animator = nil;
    BattleCharacterMgr:RemoveCharacter(GetId());
end

function SetMonsterState( index )
    local state = index or 0
    if cfg and cfg.type and infoView then
        infoView.SetState(state)
    end
end

function SetPlayMoveSoundState(state)
   
    local sound = cfgModel and cfgModel.s_move;
    if(sound)then
        if(playState == state)then
            return;
        end
        playState = state;
        if(playState)then
            CSAPI.PlaySound("fight/effect/move.acb",sound);
        else
            CSAPI.StopTargetSound("fight/effect/move.acb",sound);
        end
    end
end

--设置控制该角色的机关
function SetTriggerPropId(id)
    triggerPropId = id;

    if(triggerPropId and infoView)then
        infoView.SetSentryState(1);
    end
end
--获取控制该角色的机关
function GetTriggerPropId()
    return triggerPropId;
end