local CharacterFireBall = require "CharacterFireBall";
local CharacterCameraAction = require "CharacterCameraAction";
local CharacterFightActionPlayer = require "CharacterFightActionPlayer";
local CharacterMove = require "CharacterMove";
local CharacterBuff = require "CharacterBuff";
local CharacterBuffEff = require "CharacterBuffEff";

--行为完成标志，用于控制动画控制器
local moveReachTrigger = "moveReachTrigger";
--转身速度
local rotateSpeed = 2000;

data = nil;
--角色配置
cfgModel = nil;
--队伍ID
teamId = nil;


--自定义动画控制器
cAnimator = nil;

--旋转组件
comRotate = nil;

--状态机
stateMachine = nil;

--动画控制器
animator = nil;
--受击盒
--bodyCollider = nil;

--技能
skillList = nil;

hpMax = nil;
hp = nil;

spMax = nil;
sp = nil;

xpMax = nil;
xp = nil;

--FireBall模块
fbModule = nil;
--镜头控制模块
caModule = nil;
--FightActionPlayer模块
fapModule = nil;
--移动模块
--moveModule = nil;
--buff模块
buffModule = nil;
--buff特效模块
beModule = nil;

--战斗信息
infoView = nil;

--隐藏状态
local isHide = false;

function Awake()    
    stateMachine = StateMachine.New();
    fbModule = CharacterFireBall.New();
    caModule = CharacterCameraAction.New();
    fapModule = CharacterFightActionPlayer.New();
    --moveModule = CharacterMove.New();
    buffModule = CharacterBuff.New();
    beModule = CharacterBuffEff.New();

    comRotate = ComUtil.GetCom(gameObject,"ActionRotateTo");
end

--初始化角色
function Init(modelId)       
    cfgModel = Cfgs.character:GetByID(modelId);

    InitModules();

    --加载模型
    CharacterMgr:LoadModel(cfgModel,resParentGO,OnResLoadComplete);
end
function InitModules()
    --初始化状态机
    stateMachine:Init(this);
    --FireBall模块初始化      
    fbModule:Init(this);
    --镜头控制模块初始化
    caModule:Init(this);
    --FightActionPlayer模块初始化
    fapModule:Init(this);
    --移动模块
    --moveModule:Init(this);
    --Buff模块
    buffModule:Init(this);
    --Buff特效模块
    beModule:Init(this);
end


--替换模型
function ReplacedModel(modelId,goModel)
    buffEffNode = nil;
    RemoveOverLoadEff();
    cfgModel = Cfgs.character:GetByID(modelId);
    
    InitModules();
 
    CSAPI.SetParent(goModel,resParentGO);
    OnResLoadComplete(goModel);     

    EventMgr.Dispatch(EventType.Fight_Time_Line_Refresh);
end

function SetMatKeywordState(key,state)
    if(IsNil(matCtrl))then
        return;
    end
    matCtrl:SetKeyworkState(key,state);
end
function SetMatFloat(propertyName,value)
    if(IsNil(matCtrl))then
        return;
    end
--    matCtrl:ResetColor("_SRimColor");
--    matCtrl:ResetFloat("_SRimThreshold");
--    matCtrl:ResetFloat("_SRimSmooth");
--    matCtrl:ResetFloat("_SRimPower");
    matCtrl:SetFloat(propertyName,value);    
end


--初始化数据
function InitData(characterData)
    data = characterData;

    if(data == nil)then
        LogError("初始化角色失败，数据无效");
        return;
    end

    InitSkills(data.skills);  
    UpdateHp(data.hp,data.maxhp,true);
    UpdateXp(data.xp,data.maxxp,true);
    UpdateSp(data.sp,data.maxsp,true); 

    --InitFlip();
end
--初始化翻转
function InitFlip()
    local xScale = IsEnemy() and -1 or 1;
    CSAPI.SetScale(resParentGO,xScale,1,1);    
end
--清理翻转
function ClearFlip()
    CSAPI.SetScale(resParentGO,1,1,1);    
end

function GetFlipScale()
    local x,y,z = CSAPI.GetScale(resParentGO);
    return x;
end

--设置翻转
function SetOverTurn(state)      
    isOverTurn = state;
    --LogError(GetModelName() .. ":" .. tostring(state));
    if(state)then      
        local angle = TeamUtil:GetTeamAngle(teamId);       
        CSAPI.SetAngle(gameObject,0,angle,0);
        CSAPI.SetScale(resParentGO,1,1,1);
    else
        InitFlip();
        ResetAngle(speed);
    end
end

--设置/取消受击状态的翻转缩放（复杂原因，不得不这么弄）
function SetHitState(state)
    if(state)then
        local angle = TeamUtil:GetTeamAngle(teamId);       
        CSAPI.SetAngle(gameObject,0,angle - 180,0);
        CSAPI.SetScale(resParentGO,-1,1,1);
    else
        SetOverTurn(false);
    end  
end

function GetOverTurnAngle()
    if(isOverTurn)then
        return TeamUtil:GetTeamAngle(teamId);
    end

    return 0;
end

--初始化技能
function InitSkills(skills)
    --DebugLog("初始化技能========");
    --DebugLog(skills);
    if(skills == nil)then
        return;
    end
    skillList = {};
    for _,v in pairs(skills) do
        local cfgSkill = Cfgs.skill:GetByID(v);
        if(cfgSkill == nil)then
            --LogError("找不到技能配置，id：" .. v);
        else            
            table.insert(skillList,cfgSkill);-- skillList[cfgSkill.id] = cfgSkill;
        end
    end
end

function UpdateSkill(skillData)
    if(skillData == nil)then
        return;
    end

    skillDatas = skillDatas or {};
    skillDatas[skillData.skillID] = skillData;    
end
--替换技能
function ChangeSkill(changeData)
    if(not skillList or not changeData)then
        return;
    end

    for i,cfgSkill in ipairs(skillList)do
        if(cfgSkill.id == changeData.oldSkillID)then
            local newCfgSkill = Cfgs.skill:GetByID(changeData.newSkillID);
            if(newCfgSkill == nil)then
                LogError("找不到技能配置，id：" .. changeData.newSkillID);
            end      
            skillList[i] = newCfgSkill;
            break;
        end
    end
end

function GetSkillCostData(skillId)
    if(skillId == nil)then
        return;
    end
    return skillDatas and skillDatas[skillId];
end


--创建战斗信息界面（头顶信息）
function SetInfoView(view)    
    infoView = view;
    infoView.SetData(data);
    infoView.SetName(data.name or "");

    UpdateHp(data.hp,data.maxhp,true);
    UpdateXp(data.xp,data.maxxp,true);
    UpdateSp(data.sp,data.maxsp,true);
end

function GetInfoView()
    return infoView;
end

function SetInfoViewShowState(state)
--    if(infoView)then
--        infoView.SetShowState(state);
--    end
end

function ShowHint()
    if(infoView)then
        infoView.ShowHint();
    end
end

function GetSpInfo()
    if data then
        return sp,spMax;
    end
    return 0,0;
end

--获取角色拥有的技能
function GetSkill(skillId)
    for _,v in pairs(skillList) do
        if(v.id == skillId)then
            return v;
        end
    end
    return nil;
end

--获取角色拥有的技能
function GetSkillByCastId(castId)
    for _,v in pairs(skillList) do
        if(v.type_id == castId)then
            return v;
        end
    end
    return nil;
end

--是否我的角色
function IsMine()
    return uid ~= nil and uid == PlayerClient:GetID();
end

--获取ID
function GetID()
    return data and data.id or 0;
end
--获取配置id
function GetCfgID()   
    return data ~= nil and data.cfgId;
end
--获取配置
function GetCfg()    
    if(cfg == nil)then
        local cfgId = GetCfgID();
        if(cfgId ~= nil)then
            cfg = Cfgs.CardData:GetByID(cfgId);
            if(cfg == nil)then
                cfg = Cfgs.MonsterData:GetByID(cfgId);
            end
        else
            LogError("获取角色配置失败，配置ID无效！！！");
        end
    end

    return cfg;
end
--是否禁止复活
function IsReliveBan()
    return cfg and cfg.isRisen;
end

--获取模型配置
function GetCfgModel()
    return cfgModel;
end
--获取模型ID
function GetModelID()
    if(cfgModel == nil)then
        return 0;
    end
    return cfgModel.id;
end
--获取模型名称
function GetModelName()
    if(cfgModel == nil)then
        return "";
    end
    return cfgModel.name;
end
--获取占位信息
function GetPlaceHolderInfo()
    return placeholderInfo;
end 
--获取绝对占位
function GetGrids()
    return  data and data.grids;
end

--获取坐标
function GetCoord()
    return rowIndex,colIndex;
end

function GetLv()
    return data and data.level or 1;
end
--获取名称
function GetName()
    return data ~= nil and data.name or "无名";
end
--获取角色类型
function GetCharacterType()
    return data ~= nil and data.type;
end

function ApplyPutIn(grids)
    PutOut();
    data.grids = grids;
    PutIn();
end

--放入战区
function PutIn()
    rowIndex,colIndex = nil;
    if(data ~= nil and data.grids ~= nil)then
        local info = data.grids;
        placeholderInfo = {};
        for _,v in ipairs(info)do
            if(rowIndex == nil or colIndex == nil)then
                rowIndex = v[1];
                colIndex = v[2];
            end

            local posInfo = {v[1] - rowIndex + 1,v[2] - colIndex + 1};
            table.insert(placeholderInfo,posInfo); 
        end
    end

    local putState = FightGroundMgr:PutIn(this,rowIndex,colIndex,GetTeam());  
    
    local x,y,z = GetPos();
    originPos = {x,y,z};
    --LogError(originPos);
    return putState; 
end
function PutOut()
    FightGroundMgr:PutOut(this);
end


--设置队伍
function SetTeam(id)
    teamId = id;

    --测试镜像翻转用的
    if(_G.testFlip)then
        teamId = TeamUtil:GetOpponent(teamId);
    end
    if(infoView)then
        infoView.UpdateTeam();
    end

    InitFlip();
end
--获取队伍id
function GetTeam()
    return teamId;
end
--是否敌人
function IsEnemy()
    if(teamId ~= nil)then
        return TeamUtil:IsEnemy(teamId);
    end

    return false;
end

--设置角度
function SetAngle(angle,speed)    
    if(IsNil(comRotate))then
        return;
    end
    speed = speed or rotateSpeed;
    comRotate:RotateToTargetAngle(0,angle,0,speed);
    --LogError(GetModelName() .. ":angle:" .. tostring(angle));
end
--面向指定目标
function FaceTo(go,speed)
    speed = speed or rotateSpeed;
    local x,y,z = CSAPI.GetPos(go);
    if(IsEnemy())then
        local x0,y0,z0 = GetPos();

        x = 2 * x0 - x;
        z = 2 * z0 - z;
    end

    comRotate:FaceToPoint(x,0,z,speed);
end

--重置角度
function ResetAngle(speed)
    if(speed)then
        SetAngle(0,speed);
    else
        CSAPI.SetAngle(gameObject,0,0,0);
    end
end
--复位
function ResetPlace(fadeToIdle)
    if(IsNil(gameObject))then
        --LogError("角色对象被移除了！！！无法复位");
        return;
    end
    --LogError(GetModelName() .. ":重置位置")
    transform:SetParent(nil);
    SetPos(originPos[1],originPos[2],originPos[3]);
    ResetAngle();
    
    ApplyIdle(fadeToIdle);

    CSAPI.SetScale(gameObject,1,1,1);
end

--获取方向
function GetDir()
    local teamId = GetTeam();
    return TeamUtil:GetTeamDir(teamId);
--    if(IsNil(resParentGO))then
--        return 1;
--    end
--    local x,y,z = CSAPI.GetScale(resParentGO);  
--    return x > 0 and -1 or 1;
end

function FixGoScale(go)
    local xScale = GetFlipScale();
    CSAPI.SetScale(go,xScale,1,1);
end

--角色资源加载完成
function OnResLoadComplete(go)
    if(not IsNil(goModel))then    
        CSAPI.SetScale(goModel,0,0,0);
        CSAPI.RemoveGO(goModel,2);
    end

    goModel = go;

    --Log("加载角色完成：" .. go.name);
    cAnimator = ComUtil.GetComInChildren(go,"CAnimator");
    animator = cAnimator.animator;   
    goAnimator = animator.gameObject;
    cAnimator.onStateEnter = OnStateEnter;

    matCtrl = ComUtil.GetCom(go,"MaterialCtrl"); 

    modelLua = ComUtil.GetLuaTable(goAnimator);

    LoadEffAdditionPacks();
    PreloadExtendRes();
    
    if(infoView)then
        infoView.InitFollow();
    end
end

--入场震屏
function ApplyEnterShake()
    ApplyStateCameraShakes("enter");
end
function ApplyStateCameraShakes(stateName)
    local stateData = GetCastStateData(stateName);

    local cameraShakes = stateData and stateData.camera_shakes;
    if(not cameraShakes)then
        return;
    end
   
    for _,shakeData in ipairs(cameraShakes)do
        local delay = shakeData.delay or 0;
        FuncUtil:Call(ApplyShake,nil,delay,shakeData);
    end
end
function ApplyShake(shakeData)
    local decayValue = shakeData.decay_value;
    decayValue = decayValue and decayValue * 0.01 or 0.8;
    CameraMgr:ApplyShake(shakeData.time,shakeData.hz,shakeData.range,shakeData.range,shakeData.range,shakeData.shake_dir and gameObject,decayValue);
end

function SetLayer(layer,originLayer)
    matCtrl:SetLayer(layer,originLayer or -1);
end

--加载特效附加包
function LoadEffAdditionPacks()
    local effAdditionPacks = GetCastStateData("eff_addition_pack");
    if(effAdditionPacks)then
        local abNames = {};
        for _,effAdditionPack in pairs(effAdditionPacks)do
            effAdditionPack = string.lower(effAdditionPack);
            local packName = "";
            if(not StringUtil:IsEmpty(effAdditionPack))then
                if(string.find(effAdditionPack,"prefabs_"))then
                    packName = effAdditionPack;
                else
                    packName = "prefabs_effects_" .. effAdditionPack;
                end
            
                table.insert(abNames,packName);
            end
        end
        --LogError(abNames);
        if(abNames and #abNames > 0)then
            CSAPI.LoadABsByOrder(abNames);
        end
    end
end

--预加载扩展资源（召唤、合体、变装）
function PreloadExtendRes()
    local cfgCard = GetCfg();
    if(not cfgCard)then
        return;    
    end

    local idArr = {};
    if(cfgCard.summon)then
        CharacterMgr:PreloadByCfgId(cfgCard.summon);
    end
    if(cfgCard.fit_result)then
        CharacterMgr:PreloadByCfgId(cfgCard.fit_result);
    end
    if(cfgCard.tTransfo)then
        for _,id in ipairs(cfgCard.tTransfo)do
            CharacterMgr:PreloadByCfgId(id);
        end
    end
end

function ApplyKeepState()
    local keepStateName = GetKeepState();
   
    if(keepStateName)then
        return keepStateName;
    end
end
function GetKeepState()
    if(modelLua)then
        return modelLua.GetKeepState();
    end
    return nil;
end

--设置保持动作的激活状态
function SetActiveKeepState(state)
    --LogError(GetModelName() .. "设置保持动作激活状态" .. tostring(state));
    if(modelLua)then
        if(modelLua.IsActiveKeepState() == state)then
            return;
        end
        modelLua.SetActiveKeepState(state);

--        if(not state)then
--            ApplyIdle();
--        end
    end
end

--状态变化
function OnStateEnter(stateHash)
    stateMachine:OnStateEnter(stateHash);
    fbModule:OnStateEnter(stateHash);
    caModule:OnStateEnter(stateHash);
    --moveModule:OnStateEnter(stateHash);

    if(stateEnterFuncs ~= nil)then       
        for _,v in pairs(stateEnterFuncs) do
            if(v ~= nil)then
                v(stateHash);           
            end
        end        
    end
end

------------------------------------------------------------------------------------------

--技能结束
function MoveEnd()
    if(moveData == nil)then
        return;
    end
    moveData.playComplete = true;
    ApplyMoveComplete(); 
end

--死亡结束
function DeadEnd()    
    if(isDeadEnd)then
        return;
    end
    isDeadEnd = true;
    ShowDeadEffect();

    if(GetBGM())then
        FightClient:TryPlayCharacterBGM();
    end
end
function IsDeadEnd()
    return isDeadEnd;
end
function ShowDeadEffect()
    
    if(isDeadEffectShowed)then
        return;
    end
    isDeadEffectShowed = 1;

    local deadType = cfgModel.dead_type;
 
    if(deadType)then
        if(deadType == 1)then
            CSAPI.ApplyAction(gameObject,"action_dead_shader");
            CSAPI.ApplyAction(gameObject,"action_dead1");
            
            local x,y,z = GetPos();
            FuncUtil:Call(ResUtil.CreateEffect,ResUtil,0,"common/dead1",x,0.5,z);
            --ResUtil:CreateEffect("common/dead1",0,0,0,gameObject);
            FuncUtil:Call(DeadRemove,nil,300);

            FuncUtil:Call(
                function()
                    local deadSounds = {"grenade_exploImpac_1","grenade_exploImpac_2"}
                    local index = CSAPI.RandomInt(1, #deadSounds);        
	                CSAPI.PlaySound("fight/effect/explosion_.acb",deadSounds[index],false,false,nil,nil,nil,nil);
                end,nil,200);
        elseif(deadType == 2)then
            --死亡类型2
            --CSAPI.ApplyAction(gameObject,"action_dead_shader");
            CSAPI.ApplyAction(gameObject,"action_dead_2");
            local x,y,z = GetPos();
            ResUtil:CreateEffect("common/dead2",x,y,z);         

            FuncUtil:Call(DeadRemove,nil,700);
            CSAPI.PlaySound("fight/effect/fourth.acb","Death_dissipates",false,false,nil,nil,nil,nil);
        elseif(deadType == 3)then
            CSAPI.ApplyAction(gameObject,"action_dead_shader");
            CSAPI.ApplyAction(gameObject,"action_dead3");
            ResUtil:CreateEffect("common/dead_suixing",0,0,0,gameObject);         

            FuncUtil:Call(DeadRemove,nil,2000);
        elseif(deadType == 100)then
            local deadTime = 1500;
            local deadData = GetCastStateData("dead");
            if(deadData)then
                deadTime = deadData.play_time;
            end
            deadTime = deadTime or 1500;

            FuncUtil:Call(DeadRemove,nil,deadTime);
        end
    else
        --默认死亡类型
        CSAPI.ApplyAction(gameObject,"action_dead_shader");
        CSAPI.ApplyAction(gameObject,"action_dead");
        ResUtil:CreateEffect("common/dead_transfer",0,0,0,gameObject);         

        FuncUtil:Call(DeadRemove,nil,2000);
    end
end


------------------------------------------------------------------------------------------

--应用受击数据，扣血等
function ApplyHitData(hitData)   
    if(hitData == nil)then
        return;
    end

    if(hitData.miss)then
        local floatFontRes = IsEnemy() and "Fight/FloatMiss" or "Fight/FloatMiss_Red";
        CreateFloatFont("MissDamage",nil,floatFontRes);
        return;
    end

    local damage = hitData.hpDamage or 0;
    if(damage > 0)then
        CreateDamageValue(damage,hitData.crit,hitData.restrain,hitData.isReal);       
    end
    local shieldDamage = hitData.shieldDamage or 0;
    if(shieldDamage > 0)then
        FuncUtil:Call(CreateFloatValue,nil,10,"Damage",shieldDamage);    
        --FuncUtil:Call(CreateFloatValue,nil,10,"Damage","@" .. shieldDamage);    
--        LogError("有护盾吸收伤害");
--        LogError(hitData);
    end
    if(hitData.death)then
        SetDeadState(true);        
    end

    if(damage > 0 or shieldDamage > 0)then
        local currHP = GetHpInfo();
        if(hitData.hp < currHP)then
            UpdateHp(hitData.hp,hitData.maxhp);  
        end
    end
    
    if(not hitData.dont_play_sound)then
        if(cfgModel and cfgModel.s_hit)then
            local currTime = CSAPI.GetTime();
            if(not lastPlayHitTime or currTime - lastPlayHitTime > 2)then
                lastPlayHitTime = currTime;
                --CSAPI.PlayRandSound({"Dirwolf_14"},true,"no_tag");
                --LogError(cfgModel.s_hit);            
                CSAPI.PlayRandSound(cfgModel.s_hit,true,"hit");
            end        
        end
    end
end

--播放行动时声音
function PlayActionSound()   
    if(not cfgModel)then
        return;
    end

    --自动战斗中，不播放角色语音
    if(FightClient:IsAutoFight())then
        return;
    end

    CSAPI.PlayRandSound(cfgModel.s_turn,true);
end


--设置牢笼伤害
function SetCageDamage(damageValue)
    cageDamage = damageValue;
end
--显示牢笼伤害
function ShowCageDamage()
    if(cageDamage)then
        CreateDamageValue(cageDamage);
        EventMgr.Dispatch(EventType.Fight_Damage_Show_State,true);
        EventMgr.Dispatch(EventType.Fight_Damage_Update,cageDamage);
    end
end

function SetDeadState(deadState)
    isDead = deadState;
    if(isDead)then
        PutOut();
    end
end
--治疗
function ApplyCureData(cureData)
    if(cureData == nil)then
        return;
    end
       

    if(infoView)then
        infoView.SetShowState(true,true,true);
    end

    UpdateHp(cureData.hp);
    --    UpdateHp(cureData.hp,nil,true,true);  
    --    FuncUtil:Call(UpdateHp,nil,1000,cureData.hp);  
    
    if(cureData.add and cureData.add > 0)then
        CreateFloatValue("CureValue",cureData.add,GetFloatNode());               
    end
end


--创建伤害飘字
function CreateDamageValue(value,isCrit,restrain,isReal)
    if(value <= 0)then
        return;
    end

    local res = "Damage" .. (isCrit and "_Crit" or "");
--    if(not IsEnemy())then
--        res = res .. "_Enemy";
--    end
    local color = nil;
    if(restrain)then
        --color = restrain == 1 and "FF6719" or "F753FF";
        res = res .. "_" .. tostring(restrain);
    end
    if(isReal)then
        --color = "FF0000";
        res = "Damage_Red";
    end
    CreateFloatValue(res,value,nil,color);
end

function GetCareer()
    return data and data.career or 1;    
end

function CreateFloatValue(res,value,floatNode,color)   
    floatNode = floatNode or gameObject; 
    local floatData = {go = floatNode,res = res,value = value,color = color};


    local currTime = CSAPI.GetTime();
    local nextCanCreateTime = lastCreateNumTime and (lastCreateNumTime + 0.1) or 0;
    local delay = nil;      
  
    if(currTime > nextCanCreateTime)then
        lastCreateNumTime = currTime;
        delay = 0;
    else
        lastCreateNumTime = nextCanCreateTime;
        delay = math.floor((nextCanCreateTime - currTime) * 1000);            
    end

    FuncUtil:Call(EventMgr.Dispatch,nil,delay,EventType.Fight_Float_Num,floatData);
    --EventMgr.Dispatch(EventType.Fight_Float_Num,floatData);    

    AddSkipFloatData(floatData);
end


function AddSkipFloatData(floatData)
    floatDatas = floatDatas or {};
    table.insert(floatDatas,floatData);        
end
function GetFloatDatas()
    return floatDatas;
end
function ClearFloatDatas()
    floatDatas = nil;
end
function ApplySkipFloatDatas()
    if(not floatDatas)then
        return;
    end
    for i,floatData in ipairs(floatDatas)do
        local delay = (i - 1) * 50;
        FuncUtil:Call(EventMgr.Dispatch,nil,delay,EventType.Fight_Float_Num,floatData);
    end 
    floatDatas = nil;
end



--创建飘字
function CreateFloatFont(key,value,floatFontRes,content)
    --LogError(key);

    local cfg = Cfgs.FloatFont:GetByKey(key);    
    if(cfg or content)then
        local currTime = CSAPI.GetTime();
        local nextCanCreateTime = lastCreateTime and (lastCreateTime + 0.5) or 0;
        local delay = nil;
        local floatData = {go = GetFloatNode(),key = key,value = value,floatFontRes = floatFontRes,content = content};
  
        if(currTime > nextCanCreateTime)then
            lastCreateTime = currTime;
            if(cfg)then
                delay = cfg.delay or 0;
            end
        else
            lastCreateTime = nextCanCreateTime;
            delay = math.floor((nextCanCreateTime - currTime) * 1000);            
        end

        if(delay)then
            FuncUtil:Call(EventMgr.Dispatch,nil,delay,EventType.Fight_Float_Font,floatData);
        else
            EventMgr.Dispatch(EventType.Fight_Float_Font,floatData);
        end
    end
end


--获取hp信息
function GetHpInfo()
    local targetMax = hpMax or (data and data.maxhp) or 1;
    local targetHp = hp or 0;
    local buffLeftHp = 0;--GetBuffHp() or 0;
    --targetMax = targetMax + buffLeftHp;

    return targetHp,targetMax,buffLeftHp;
end
function AddMaxHp(val)
    hpMax = (hpMax or 0) + val;
end

function SetHPLock(hpLockState)
    hpLock = hpLockState;
end
--更新信息：HP
function UpdateHp(curr,max,immediately,onlyFakeBar)
    --[[ if(IsEnemy())then
        LogError("id" .. GetID() .. ":" .. "更新HP" .. tostring(curr));
    end ]]
    if(hpLock)then
        return;
    end

    hpMax = max or hpMax or 1;
    if(curr)then    
        hp = curr >= 0 and curr or 0;
    end    
    
    if(infoView ~= nil)then
       infoView.SetHp(hp,hpMax,immediately,onlyFakeBar);

       local buffLeftHp,buffMaxHp = GetBuffHp();
       if(buffLeftHp <= 0)then
            buffLeftHp = 0;       
       end
       --LogError("剩余buff HP");
--       if(buffLeftHp > 0)then
--            buffMaxHp = buffMaxHp or buffLeftHp;      
--            if(buffLeftHp > buffMaxHp)then
--                buffMaxHp = buffLeftHp;
--            end    
--       else
--            buffMaxHp = nil;
--       end    

       --LogError("aaa:" .. tostring(buffLeftHp) .. "/" .. tostring(buffMaxHp));
       infoView.SetHpShield(buffLeftHp,buffMaxHp or 1,immediately);   
    end

    ApplyChanged();
end
--更新信息：SP
function UpdateSp(curr,max,immediately)
    --LogError(GetModelName() .. "curr sp:" .. curr);

    spMax = max or spMax or g_SpMax;
    sp = curr;
    if(infoView ~= nil)then
       infoView.SetSp(sp,spMax,immediately);
    end

    ApplyChanged();
end
--更新信息：XP
function UpdateXp(curr,max,immediately)
    xpMax = max or xpMax;
    xp = curr;
    
    if(infoView ~= nil)then
       infoView.SetXp(xp,xpMax,immediately);
    end

    ApplyChanged();
end
--设置行动标志（头顶的箭头）
function SetActionState(actionState)
    if(infoView ~= nil)then
       infoView.SetActionState(actionState);
    end
end

function ApplyChanged()
    if(applyChangedEvent)then
        return;
    end
    applyChangedEvent = 1;
    FuncUtil:Call(DispathChangedEvent,nil,10);
end

function DispathChangedEvent()
    EventMgr.Dispatch(EventType.Character_FightInfo_Changed,this);

    applyChangedEvent = nil;
end


--更新Buff
function UpdateBuff(buff)
    buffModule:UpdateBuff(buff);
    UpdateHp();
    if(infoView)then
        infoView.UpdateBuff();
    end
    ApplyChanged();

    UpdateStunState();
end
--移除Buff
function RemoveBuff(buff)   
    buffModule:RemoveBuff(buff);
    UpdateHp();
     if(infoView)then
        infoView.UpdateBuff();
    end
    ApplyChanged();

    UpdateStunState();
end
--获取Buffs
function GetBuffs()
    return buffModule:GetBuffs();
end

--获取护盾
function GetShield()
    local buffs = GetBuffs();
    if(buffs)then
        for _,buff in pairs(buffs)do
           local shieldType,shieldCount = buff:GetShield();
           if(shieldType and shieldCount)then
                return shieldType,shieldCount;
           end
       end
    end
end
--更新眩晕状态
function UpdateStunState()
    local stunState = IsStunState()

    if(stateMachine)then
        stateMachine:SetStunState(stunState);
    end
end

function IsStunState()
    local buffs = GetBuffs();
    local stunState = 0;
    if(buffs)then
        for _,buff in pairs(buffs)do
           local cfg = buff:GetCfg();
           if(cfg.stun_state and cfg.stun_state ~= 0)then
               stunState = cfg.stun_state;
           end
       end
    end

    return stunState and stunState ~= 0;
end

function GetModelPos()
    local targetPos = nil;
    if(modelLua)then
        targetPos = modelLua.GetModelPos();
    end
    if(not targetPos)then
        targetPos = gameObject;
    end
    return targetPos;
end

--获取buff节点
function GetBuffNode()
    return infoView.GetBuffNode();
end
--获取buff特效挂载点
function GetBuffEffNode(buffEffNodeName)   
    if(modelLua and buffEffNodeName)then
        local tmpBuffNode = modelLua.GetBuffEffNode(buffEffNodeName);
        if(tmpBuffNode)then
            return tmpBuffNode;
        end
    end

    if(buffEffNode == nil)then
        buffEffNode = modelLua and modelLua.GetBuffEffNode();
        if(buffEffNode == nil)then
            buffEffNode = goAnimator or gameObject;
        end 
    end  

    return buffEffNode;
end
--设置buff显示状态
function SetBuffEffShowState(state)
     local targetNode = modelLua and modelLua.GetBuffEffNode();
    if(targetNode)then
        CSAPI.SetLocalPos(targetNode,0,0,state and 0 or -1000);
    end 

    if(modelLua)then
        modelLua.SetBuffNodesState(state);
    end
end

--设置角色身上特效显示状态
function SetEffShowState(state)
    if(effShowState ~= nil and effShowState == state)then
        return;
    end     

    SetBuffEffShowState(state);
end

--添加buff特效
function ApplyBuffEff(key,caller)
    return beModule:ApplyBuffEff(key,caller);
end
--移除buff特效
function RemoveBuffEff(be)
    if(beModule)then
        beModule:RemoveBuffEff(be);
    end
end


--进入指定状态
function EnterState(stateName,fadeTime)
    local currTime = CSAPI.GetTime();
    if(lastEnterStateTime and lastEnterStateTime == currTime)then
        --LogError(GetModelName() .. "----------------------------" .. stateName);
        return;
    end
    lastEnterStateTime = currTime;


    PlayState(stateName,fadeTime);    
    --[[ if(GetID() == 9)then
        LogError(GetModelName() .. "-------enter state----------" .. stateName);
    end ]]
    PlayPartState(stateName);
end
function PlayState(stateName,fadeTime)
    --fadeTime = 0.2;
    --LogError(GetModelName() .. "进入状态：" .. tostring(stateName));
   
    local currTime = CSAPI.GetTime();
    if(lastPlayStateTime and lastPlayStateTime == currTime)then
        return;
    end
    lastPlayStateTime = currTime;

    if(animator ~= nil)then
        if(fadeTime)then
            animator:CrossFade(stateName,fadeTime);            
        else
            animator:Play(stateName);
        end
    end
end

--获取部位标记
function GetPartSign()    
    return cfgModel and cfgModel.part_sign;
end
function PlayPartState(state)
    local partSign = GetPartSign();
    if(StringUtil:IsEmpty(partSign))then
        return;
    end
    --LogError(GetModelName() .. ":" .. state);
    --return;
    --FuncUtil:Call(function()
    --    CharacterMgr:SyncPartState(partSign,state);
    --end,nil,100)
    CharacterMgr:SyncPartState(partSign,state);
    RefreshParts();
end

function SyncPartState(state)
    --LogError("a:" .. state );
    if(IsPartState(state))then
        --LogError("b:" .. state );
        PlayState(state);
    end
end
function IsPartState(state)
    local partStates = cfgModel and cfgModel.part_states;
    --LogError(partStates);
    if(partStates)then
        for _,partState in ipairs(partStates)do
            if(partState == state)then
                return true;
            end
        end
    end
end

function PlayPartHitState(hitType)
    local partSign = GetPartSign();
    if(StringUtil:IsEmpty(partSign))then
        return;
    end

    local partCharacters = CharacterMgr:GetPartCharacters(partSign,this);
    if(partCharacters)then
        for _,character in ipairs(partCharacters)do
            character.SyncPartHit(hitType);
        end
    end

    RefreshParts();
end
function SyncPartHit(hitType)
    if(stateMachine)then
        stateMachine:Hit(hitType);
    end
end

function RefreshParts()
    local partSign = GetPartSign();
    if(StringUtil:IsEmpty(partSign))then
        return;
    end
    local partCharacters = CharacterMgr:GetPartCharacters(partSign,this);
    if(partCharacters)then
        for _,character in ipairs(partCharacters)do
            myParts = myParts or {};
            if(myParts[character] == nil)then
                myParts[character] = character;
            end
        end
    end
end

--是否分体角色
function IsPart()
    local partSign = GetPartSign();
    return not StringUtil:IsEmpty(partSign);
end
--是否主体
function IsMainPart()
    if(IsPart())then
        return cfgModel and not cfgModel.dead_retain;
    end
end

--显示全部部位
function ShowParts()
    local partSign = GetPartSign();
    if(StringUtil:IsEmpty(partSign))then
        return;
    end
    RefreshParts();
    if(myParts)then
        for _,myPart in pairs(myParts)do
            if(myPart)then
                myPart.SetShowState(true,true);
            end
        end
    end
end



--是否冰冻状态
function IsIceState()
    return buffModule and buffModule:GetBuffByCfgId(3005);--冰冻buff id
end

--受击
function ApplyHit(hitType)
    --冰冻中
    if(IsIceState())then
        return;
    end
    
    --技能中，不可中断
    if(fapModule:IsPlaying())then
        return;
    end


    local hitType = hitType or 0;

    --CSAPI.ApplyAction(gameObject,"DamageBlink");
    if(matCtrl)then
        if(hitType == 0)then
            matCtrl:DamageBlink(200);
        else
            matCtrl:DamageBlink(60,4,60);
        end
    else
        --LogError(string.format("角色%s不存在材质控制组件MaterialCtrl",GetModelName()));
    end
    if(stateMachine)then
        stateMachine:Hit(hitType);
    end
    PlayPartHitState(hitType);


    if(infoView)then
        infoView.SetShowState(true,true,true);        
    end

    EventMgr.Dispatch(EventType.Character_Hited,GetID());
    --SetFace("hurt",500);
end

--表情
function SetFace(faceName,time)
    if(modelLua)then
        modelLua.SetFace(faceName,time)
    end
end

--停顿
function ApplyPause(time)
    if(time == nil)then
        return;
    end
    cAnimator:ApplyPause(time);
end
--是否死亡
function IsDead()
    return isDead;
end
--死亡
function PlayDead()
    isDeadPlayed = 1;
    --if(IsDead())then   
    PutOut();        
    stateMachine:Dead();
    RemoveInfoView();
--    if(not IsReliveBan())then
--        CharacterMgr:AddDeadCharacter(this);
--    end
    Clean();
    if(cfgModel)then
        CSAPI.PlayRandSound(cfgModel.s_death,true);
    end

    EventMgr.Dispatch(EventType.Character_Dead,GetID());
    --end    

    local deadType = cfgModel.dead_type;
    if(deadType and (deadType == 2 or deadType >= 100))then
        ShowDeadEffect();
    end

    PlayDeadParts();
end

function GetBodySize()
    return cfgModel and cfgModel.body_size;
end


function Clean()
    if(beModule ~= nil)then
        beModule:Clean();
    end
    if(buffModule ~= nil)then
        buffModule:ApplyRemoveAll();
    end
end

function IsDeadPlayed()
    return isDeadPlayed;
end

--复活
function Relive()
    stateMachine:Relive();
end


--获取技能状态数据
function GetCastStateData(castName)
    return stateMachine:GetCastStateData(castName);  
end
--获取技能镜头数据
function GetCastCameraData(castName)
    return caModule:GetCameraData(castName);
end

function GetCameraAddHeight()
    if(cameraAddHeight == nil)then
        cameraAddHeight = GetCastStateData("camera_dis_fix") or 0;
    end
    return cameraAddHeight;
end

--获取位置
function GetPos()
    --LogError("获取角色位置" .. GetID());
    if(IsNil(gameObject))then
        return 0,0,0;
    end

    return CSAPI.GetPos(gameObject);
end
function SetPos(x,y,z)
    --LogError(GetModelName() .. ":设置位置")
    CSAPI.SetPos(gameObject,x,y,z);
end

function GetOriginPos()
    return originPos;
end

--获取部位位置
--1：脚
--2：身
--3：头
function GetPartPos(partIndex)
    local targetPart = GetPartGO(partIndex);
    if(IsNil(targetPart))then
        return 0,0,0;
    end

    local x,y,z = CSAPI.GetPos(targetPart);
    if(IsHided())then
        y = y + 1000;
    end     

    return x,y,z;
end

--获取部位
--1：脚
--2：身
--3：头
function GetPartGO(partIndex)
    local goPart = nil;
    if(modelLua)then
        goPart = modelLua.GetPartGO(partIndex);
    end
    return goPart or gameObject;
end

--飘字节点
function GetFloatNode()   
    local modelPos = GetModelPos();    
    if(modelPos)then
        return modelPos;
    else
        if(IsHided())then
            return goAnimator;
        end
        return GetBuffEffNode();
    end

    
end

--播放FightAction
function PlayFightAction(fightAction,callBack)
    SetSkipSkill(false);
    fapModule:Play(fightAction,callBack);
end

function GetFightAction()
    return fapModule.fightAction;
end

--获取选择限制
function GetSelLimits()
    return buffModule:GetSelLimits();
end
--获取护盾生命值
function GetBuffHp()    
    local buffLeftHp,buffMaxHp;
    if(buffModule)then
        buffLeftHp,buffMaxHp = buffModule:GetHp();
    end
    buffLeftHp = buffLeftHp or 0;
    buffMaxHp = buffMaxHp or 0;
    return buffLeftHp,buffMaxHp;
end


----移动
--function ApplyMove(data)
--    if(moveData ~= nil)then
--        LogError("角色移动中=================");
--        LogError(moveData);
--        LogError(data);
--        return;
--    end      

--    moveData = data;

--    if(moveData == nil)then
--        LogError("移动数据无效！");
--        return;
--    end          

--    moveModule:ApplyMove(moveData,OnMoveReach);

--    --播放移动状态
--    animator:ResetTrigger(moveReachTrigger);
--    animator:Play(moveData.state);   

----    LogError("角色移动到目标位置=================");
----    LogError(moveData);
--end
--到达目标点
function OnMoveReach()
    if(moveData == nil)then
        return;
    end
    moveData.reach = true;
    animator:SetTrigger(moveReachTrigger);
    ApplyMoveComplete(); 
end

function ApplyMoveComplete()
    if(moveData == nil or  moveData.playComplete == nil or  moveData.reach == nil)then
        return;
    end

    if(moveData ~= nil)then
        --LogError("移动完成，回调");
        --LogError("moveData");
        local callBack = moveData.callBack;
        local caller = moveData.caller;
        moveData = nil;

        if(callBack ~= nil)then        
            callBack(caller);
        end
    end
end

--胜利
function ApplyWin()
    if(IsDead())then
        return;
    end


    SetOverLoadEffState(false);
    SetMatKeywordState("_SRIM_LIGHT",false);

    stateMachine:Win();  
    --SetFace("smile");
end

function ApplyIdle(fadeToIdle)
    if(IsDead())then
        return;
    end

    --SetBuffEffShowState(true);

    keepStateName = ApplyKeepState();
    if(keepStateName)then
        FuncUtil:Call(EnterKeepState,nil,50);
    else
        --LogError(GetModelName() .. "进入待机");
        if(not IsStunState())then--非眩晕状态
            EnterState("idle",fadeToIdle and 0.1);
        end
    end
end

function EnterKeepState()
    if(keepStateName)then
        EnterState(keepStateName);
    end
    keepStateName = nil;
end

--function DelayIdle()
--    if(idleStateName)then
--        EnterState(idleStateName);
--    end
--    idleStateName = nil;
--end

--设置技能状态替换
function SetReplaceCastState(oldCastState,newCastState)
    replaceCastStates = replaceCastStates or {};
    replaceCastStates[oldCastState] = newCastState;
end
--获取技能状态替换
function GetReplaceCastState(castName)
    local newCastName = replaceCastStates and castName and replaceCastStates[castName] or castName;
    return newCastName;
end

--使用技能
function ApplyCast(castName)
    --LogError(GetModelName() .. "使用技能：" .. tostring(castName));
    --idleStateName = nil;

    castName = GetReplaceCastState(castName);

    stateMachine:Cast(castName);

    --fbModule:CreateCastPreFB(castName);
    --SetFace("attack");
end

function ApplyCastPreFB(castName)
    if(fbModule)then
        fbModule:CreateCastPreFB(castName);
    end
end

function SetSkipSkill(skipSkill)
    isSkipShowSkill = skipSkill;
end
function IsSkipSkill()
    return isSkipShowSkill;
end



--召唤出场
function ApplySummon()    
    
    --ApplyCharacterAction("summon_material");
    --ApplyCharacterAction("action_summon");
   
    --FireBallMgr:CreateCommon(this,"summon");
end

function SetSummonState(state)
    summonState = state;
end

function SetComboEffShowState(state)
    local comboEff = modelLua and modelLua.comboEff;
    if(comboEff)then
        CSAPI.SetGOActive(comboEff,state);
    end
end

function ApplyCharacterAction(characterActionName)
    local go = CreateGO(characterActionName);
    if(not IsNil(go))then
        local action = ComUtil.GetCom(go,"ActionBase");
        if(action)then
            action.target = gameObject;
            action:Play();
        end
    end
end

function CreateGO(res,x,y,z)
    local targetCfgModel = GetCfgModel();
    if(not targetCfgModel)then
        return;
    end
    local modelName = targetCfgModel.ab_name or targetCfgModel.name;
    local res = ResUtil:GenCharacterRes(modelName .. "/" .. res);
    --LogError(res);
    local go = CSAPI.CreateGO(res,x or 0,y or 0,z or 0);
    FixGoScale(go);

    return go;
end

--获取FireBall数据
function GetFireBallDataByKey(fbKey)  
    return fbModule:GetFireBallDataByKey(fbKey);
end

--设置显示状态
function SetShowState(isShow,isForce,playEff,commonEff,effData)
    if(isShow == not IsHided() and not isForce)then
        return;
    end

    if(IsNil(shadow))then
        shadow = nil;
    else
        SetShadowState(isShow);
        --CSAPI.SetGOActive(shadow,isShow);
    end

    --playEff = true;
    --[[ if(GetID() == 10)then
        LogError("id=" .. GetID() .. "," .. GetModelName() .. "设置显示状态：" .. (isShow and "是" or "否"));
    end ]]
    isHide = not isShow;
    if(goAnimator)then
        y = isShow and 0 or -1000;
        if(isHide)then
            if(playEff)then     
                if(not commonEff)then           
                    FuncUtil:Call(DelayHide,nil,commonEff and 300 or 200);
                end
            else
                CSAPI.SetLocalPos(goAnimator,0,y,0);
            end            
        else
            if(playEff)then
                FuncUtil:Call(DelayShow,nil,50);
            else
                CSAPI.SetLocalPos(goAnimator,0,y,0);
            end              
        end
    end
    if(playEff)then
        PlayShowEff(isShow,commonEff,effData);               
    end
    if(isShow and isDisappear)then
        PlayShowEff(true,true,effData);
    end

--    if not isShow then
--        SetInfoViewShowState(false);
--    end
end
function SetShadowState(state)
    if(not IsNil(shadow))then
        CSAPI.SetGOActive(shadow,state);
    end
end

function DelayHide()
    if(isHide and goAnimator)then
        CSAPI.SetLocalPos(goAnimator,0,1000,0);
    end
end

function DelayShow()
    if(not isHide and goAnimator)then
        CSAPI.SetLocalPos(goAnimator,0,0,0);
    end
end

function PlayShowEff(isShow,commonEff,effData)    
   
    local actionName = isShow and "action_character_appear" or "action_character_disappear";
    if(commonEff)then
        actionName = actionName .. "_common";

        if(not isShow)then
            isDisappear = 1;
        else
            isDisappear = nil;
        end
    else
        actionName = effData and effData.action or actionName;
    end

    CSAPI.ApplyAction(gameObject,actionName);    

    local modelPos = GetModelPos();    
    
    --LogError("bb");
    if(commonEff)then
        local particleActionName = isShow and "action_character_appear_particle" or "action_character_disappear_particle";
        CSAPI.ApplyAction(gameObject,particleActionName);   
    else
        local targetEff = effData and effData.eff;
        --LogError(targetEff);
        if(targetEff == "null")then
            return;
        end

        if(isShow)then
            local x,y,z = GetPos();
            targetEff = targetEff or "common/character_appear";
            ResUtil:CreateEffect(targetEff,x,0,z);
        else    
            local x,y,z = CSAPI.GetPos(modelPos);
            targetEff = targetEff or "common/character_disappear";                       
            ResUtil:CreateEffect(targetEff,x,0,z);
            --LogError(GetModelName());
        end

--        local soundActionName = isShow and "lokotunjailurus_recruit_move_02" or "lokotunjailurus_recruit_move_01";
--        CSAPI.PlaySound("fight/effect/lokotunjailurus.acb",soundActionName,false,false,nil,nil,nil,nil,100);
    end

   
end

function IsModelOffset()
    local modelPos = GetModelPos(); 
    local x1,y1,z1 = CSAPI.GetPos(modelPos); 
    local x2,y2,z2 = GetPos();    
    
    if(math.abs(x1 - x2) > 1 or math.abs(z1 - z2) > 1)then
--        LogError("x1:" .. x1);
--        LogError("x2:" .. x2);
--        LogError("z1:" .. z1);
--        LogError("z2:" .. z2);
--        LogError(GetModelName() .. "model offset");
        return true;
    end        
end


function DelayResetModel()
    if(summonState)then
        return;
    end
    CSAPI.ApplyAction(gameObject,"action_character_show_shader");
end


function DelayHideModel()
    if(goAnimator and IsHided())then
        CSAPI.SetGOActive(goAnimator,false);
    end
end

function IsHided()
    return isHide;
end

--获取变身状态
function GetTransformState()
    return transformState or 0; 
end
--设置变身状态
function SetTransformState(targetTransformState)
    transformState = targetTransformState; 
end
--获取可变身数据
function GetTransDatas()
    if(transDatas == nil)then
        local cfgCharacter = GetCfg();
        local transInfo = cfgCharacter.tTransfo;
        if(transInfo)then
            transDatas = {};
            table.insert(transDatas,{id = GetID(),cfgId = GetCfgID(),modelId = GetModelID(),index = 0});
            for index,transId in ipairs(transInfo)do
                local cfgTrans = Cfgs.Transform:GetByID(transId);

                local transData = {};
                transData.id = GetID();
                transData.cfgId = GetCfgID();
                transData.modelId = cfgTrans.model;
                transData.index = index;                          
                table.insert(transDatas,transData);
            end
        end
     end

     return transDatas;
end


--是否可以合体
function IsCanCombo()    
    local comboRanges = GetComboRangeLimit();     
    return comboRanges and #comboRanges > 0;
end

--获取可合体角色
function GetComboTargets()
    local cfgCharacter = GetCfg();
    local unite = cfgCharacter.unite;
    --LogError(unite);
    local list = nil;
    if(unite ~= nil)then
        local uniteList = {};
        for _,v in ipairs(unite)do
            uniteList[v] = 1;
        end
     
        local all = CharacterMgr:GetAll();
        for id,targetCharacter in pairs(all) do
            if(targetCharacter ~= nil and targetCharacter.IsMine())then
                --LogError("cfg id：" .. targetCharacter.GetCfgID());
                if(uniteList[targetCharacter.GetCfgID()] ~= nil)then
                    local targetSP,targetSPMax = targetCharacter.GetSpInfo()
                    --不在判定SP
                    --if(targetSP and targetSP >= 100)then--sp100以上
                        list = list or {};
                        list[id] = 1;
                    --end
                end
            end
        end
    end
   
    return list;
end

--获取合体范围限制
function GetComboRangeLimit()
    local range_limit = nil;
 
    --合体技能范围限制
  --  local cfgCharacter = GetCfg();
  --[[   local comboId = cfgCharacter.fit_result;
    if(comboId == nil)then
        LogError("没有合体结果" .. cfgCharacter.id);
    end ]]

--    local cfgMonster = Cfgs.MonsterData:GetByID(comboId);
--    if(cfgMonster == nil)then
--        --LogError("找不到合体角色" .. comboId);
--        --Tips.ShowTips("no unite target");
--    end

    local comboTargets = GetComboTargets();
    if(comboTargets == nil)then        
        return nil;
    end

    for id,_ in pairs(comboTargets)do
        local character = CharacterMgr:Get(id);
           
        
        local grids = character.GetGrids();  
        if(grids)then
            for _,grid in ipairs(grids)do
                range_limit = range_limit or {};  
                table.insert(range_limit,grid);
            end
        end
    end
    --LogError(range_limit);
    return range_limit;
end


function RemoveAfterDeadAni()
    if(isDeadEnd)then
        return;
    else
        FuncUtil:Call(function()
            Remove();
        end,nil,3000);
    end
end

--死亡移除
function DeadRemove()
    if(cfgModel and cfgModel.dead_retain)then--保留部位的尸体，让主体移除
        RemoveInfoView();
        return;
    end
    Remove();
end

--移除
function Remove()
    if(isRemoved)then
        return;
    end

    if(IsNil(gameObject))then
        return;
    end
    isRemoved = 1;
    isDeadEnd = true;
    SetFace("");
    SetShowState(true,true);
    Clean();
    CharacterMgr:Remove(this);
    RemoveOverLoadEff();
    CSAPI.RemoveGO(gameObject);
    RemoveInfoView();
    
    RemoveParts();
end
function RemoveParts()
    local partSign = GetPartSign();
    if(StringUtil:IsEmpty(partSign))then
        return;
    end

    if(cfgModel and cfgModel.dead_retain)then--移除部位的尸体
        return;
    end

    if(myParts)then
        for _,myPart in pairs(myParts)do
            if(myPart and myPart.IsDead())then
                myPart.Remove();
            end
        end
    end
end

function PlayDeadParts()
    local partSign = GetPartSign();
    if(StringUtil:IsEmpty(partSign))then
        return;
    end

    if(not IsMainPart())then--非主体
        return;
    end

    if(myParts)then
        for _,myPart in pairs(myParts)do
            if(myPart)then
                myPart.EnterState("dead_part");
            end
        end
    end
end

 --移除头顶信息框
function RemoveInfoView()

    if(infoView ~= nil)then
        CSAPI.RemoveGO(infoView.gameObject); 
        infoView = nil;
    end
end

--销毁
function OnDestroy()
    isRemoved = 1;

    data = nil;
    
    stateMachine = nil;
    fbModule = nil;
    fightAction = nil;
    --moveModule = nil;

    gameObject = nil;
    transform = nil;
    cAnimator = nil;
    animator = nil;

    this = nil;
    --LogError("角色被移除" .. GetID());
end

function UpdateFlag(flagData)    
    if(flagData and flagData.key)then
        flagDatas = flagDatas or {};
        flagDatas[flagData.key] = flagData;
        if(infoView)then
            infoView.UpdateBuff();
        end
    end
    --LogError(flagDatas);
    --EventMgr.Dispatch(EventType.Fight_Flag_Changed,GetID());
end

function DelFlag(flagData)
    if(flagDatas)then
        flagDatas[flagData.key] = nil;
        if(infoView)then
            infoView.UpdateBuff();
        end
        --EventMgr.Dispatch(EventType.Fight_Flag_Changed,GetID());
    end    
end

function GetFlagData(key)
    return flagDatas and flagDatas[key];
end


function SetOverloadState(state,noSound)  
    if(overloadState == state)then
        return;
    end

    if(state)then
        local x,y,z = GetPos();
        ResUtil:CreateEffect("overload/qc_overload_effect",x,y,z);
        SetOverLoadEffState(true,noSound);
        CSAPI.PlaySound("fight/effect/fourth.acb","overload");            
            
        SetMatKeywordState("_SRIM_LIGHT",true);
        CSAPI.ApplyAction(gameObject,"action_overload_on");

        local cfgModel = GetCfgModel();
        CSAPI.PlayRandSound(cfgModel.s_overload,true);
    else
        SetOverLoadEffState(false);
        SetMatKeywordState("_SRIM_LIGHT",false);
    end

    overloadState = state;
end
function GetOverloadState()
    return overloadState;
end


--设置overload状态特效
function SetOverLoadEffState(state,noSound)  
    --LogError("overload:" .. tostring(state));
 
    if(state and not overloadEff)then
        local x,y,z = GetPos();
                
        overloadEff = ResUtil:CreateEffectImmediately("overload/qc_overload_hit",x,y,z);
        local targetNode = nil;
        local modelPosNode = GetModelPos();
        if(modelPosNode)then
            if(modelPosNode.transform.parent)then
                targetNode = modelPosNode.transform.parent.gameObject;
            else
                targetNode = modelPosNode;
            end
        else
            targetNode = gameObject;
        end
        CSAPI.SetParent(overloadEff,targetNode,false);
    end
    
    if(overloadEff)then
        CSAPI.SetGOActive(overloadEff,state);

        if(not noSound)then      
            PlayOverloadSound(state);
        end

    end
end

function PlayOverloadSound(state)
    if(state)then
        CSAPI.PlaySound("fight/effect/fourth.acb","overloading");
    else
        CSAPI.StopTargetSound("fight/effect/fourth.acb","overloading");
    end
end

function RemoveOverLoadEff()
    if(overloadEff)then
        CSAPI.RemoveGO(overloadEff);
        overloadEff = nil;
        --CSAPI.PlaySound("fight/effect/fourth.acb","overloading");
        CSAPI.StopTargetSound("fight/effect/fourth.acb","overloading");
    end
end

--怒气
function UpdateFury(val,max)
    fury = val;
    furyMax = max or furyMax;
end
function GetFury()
    local p = 0;
    if(fury and furyMax)then
        p = fury / furyMax;
    end
    return fury,furyMax,p;
end

function SetEquipSkills(infos)
    equipSkills=infos;
end

function GetEquipSkills()
    return equipSkills;
end

-------------专属BGM-------------
--是否BGM
function GetBGM(key)
    key = key or "robotBgm";
    local cfg = GetCfgModel();
    return cfg and cfg[key];
end


--[[ function Update()
     if(CS.UnityEngine.Input.GetKeyDown(CS.UnityEngine.KeyCode.D))then
        LogError(GetModelName());
     end
 end  ]]