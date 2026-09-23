
function Awake()
    hpBar = ComUtil.GetCom(goHp,"BarBase");  
    hpBar0 = ComUtil.GetCom(goHp0,"BarBase");  
    shieldBar = ComUtil.GetCom(goShield,"BarBase");  
    spBar = ComUtil.GetCom(goSp,"BarBase");    
    --spBar0 = ComUtil.GetCom(goSp0,"BarBase");    
    --tmSp = ComUtil.GetCom(sp,"TextMesh");   
    xpBar = ComUtil.GetCom(xp,"BarBase");    
    
    actionEnter = ComUtil.GetCom(enterAction,"ActionBase");  
    --txtLv = ComUtil.GetCom(lv,"Text");   

    Init();
end

function Init()
    if(isInited)then
        return;
    end
    isInited = 1;

    local goBuff = ResUtil:CreateUIGO("Fight/Buff",buffNode.transform);
    buffView = ComUtil.GetLuaTable(goBuff);

    SetActionState(false);
    SetShowState(true);  
  
    UpdateBuffShield();   

    InitListener();
end


function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Character_FightInfo_Show,OnFightInfoShowStateChanged);   
    eventMgr:AddListener(EventType.Character_HeadInfo_Scale_State,SetScaleState);  
    eventMgr:AddListener(EventType.Input_Select_Target_Character_Changed,OnInputSelectTargetCharacterChanged);           
end
function OnRecycle()
    eventMgr:ClearListener();
    eventMgr = nil;

    buffView = nil;

    isInited = nil;
    currState = nil;

    SetHPLockState();
end

--头顶信息显示状态切换
function OnFightInfoShowStateChanged(state)
    if(state and target and target.IsHided())then
        SetShowState(false);
        return;
    end
    SetShowState(state);    
end
function Set(character)
    Init();

    target = character;
    
    --设置信息界面
    target.SetInfoView(this);
    
    InitFollow();

    UpdateTeam();

    UpdateShieldType();

     UpdateBossFlag();
end

function UpdateBossFlag()
    local isBoss = target and target.GetCharacterType() == CardType.Boss;   
    CSAPI.SetGOActive(goBoss,isBoss);
end

function UpdateShieldType()
    local res = "UIs/Fight/shield" .. (target and target.GetCareer() or "1") .. ".png";
    CSAPI.LoadImg(imgShieldType, res,false,nil,true);
end

function UpdateTeam()
--    local res = "UIs/Fight/" .. (target and target.IsEnemy() and "red_hp" or "our_hp") .. ".png";
--    CSAPI.LoadImg(goHp, res,false,nil,true);
--    CSAPI.LoadImg(goHp0, res,false,nil,true);
end

function InitFollow()
    CSAPI.AddUISceneElement(nodes,target.GetPartGO(3));
end

--设置行动箭头显示状态
function SetActionState(state) 
    actionState = state;
    if(arrow)then
        CSAPI.SetGOActive(arrow,state);
    end    
--    if(actionState)then
--        if(not arrowGo)then
--            local parentGo = target and target.GetPartGO(3);
--            if(parentGo)then
--                ResUtil:CreateEffect("common/arrow",0,0.5,0,parentGo); 
--            end
--        end 
--    else
--        if(arrowGo)then
--            CSAPI.RemoveGO(arrowGo);
--            arrowGo = nil;  
--        end 
--    end 
end

function OnInputSelectTargetCharacterChanged(characters)
    if(not target)then
        return;
    end
    if(not characters)then
        SetTargetState(false);
    else
        local state = characters[target.GetID()] and true or false;
        SetTargetState(state);
    end
end

function SetTargetState(state)
    if(not target)then
        return;
    end

    local targetState = state and not actionState;
    if(arrowSelf)then
        CSAPI.SetGOActive(arrowSelf,targetState and not target.IsEnemy());
    end  
    if(arrowEnemy)then
        local arrowEnemyState = targetState and target.IsEnemy();

        CSAPI.SetGOActive(arrowEnemy,arrowEnemyState);

        UpdateRestrainState(arrowEnemyState);
    end   
end

function UpdateRestrainState(state)
    if(state)then
        local myShieldType,myShieldCount = GetShield();
        local skillCareer = FightClient:GetSelSkillCareer();
--        LogError("myShieldType:" .. tostring(myShieldType));
--        LogError("myShieldCount:" .. tostring(myShieldCount));
        if(skillCareer)then
            if(skillCareer ~= myShieldType)then
                --形成克制
                CSAPI.SetGOActive(restrain,true);
            end

            return;
        end
    end

    CSAPI.SetGOActive(restrain,false);
end


function GetShield()
    if(not target)then
        return;
    end
    local shieldType,shieldCount = target.GetShield();
    if(not shieldType)then
        shieldType = target and target.GetCareer() or 1;
    end    
    return shieldType,shieldCount;
end

function SetShowState(state,noAction,noActionDelay)
    CSAPI.SetGOActive(nodes,state);    
    --LogError("state:" .. tostring(state) .. ",noAction:" .. tostring(noActionDelay) .. ",currState:" .. tostring(currState) .. ",noActionDelay:" .. tostring(noActionDelay));
    if(state and not currState and not noAction )then
        --LogError("aa");
        if(not IsNil(actionEnter))then
            local delay = noActionDelay and 0 or CSAPI.RandomInt(600, 750);
            actionEnter.delay = delay;
            actionEnter:Play();

            ActiveSpFull(false);
            UpdateSpFullEff(delay + 100);
        end
    end

    currState = state;
end

function SetScaleState(state)
    --LogError(tostring(state));
    local targetScale = state and 1 or 0.001;
    CSAPI.SetScale(nodes,targetScale,targetScale,targetScale);
end

--锁住hp更新
function SetHPLockState(key)
    lockKey = key;
end

--设置HP
function SetHp(curr,max,immediately,onlyFakeBar,key)
    if(lockKey and lockKey ~= key)then
        return;
    end    
    --LogError(curr .. " / " .. max);
    local value = curr / max;   
    if(not onlyFakeBar)then
        hpBar:SetProgress(value,immediately ~= nil);
    end
    hpBar0:SetProgress(value,immediately ~= nil);
end
--设置护盾HP
function SetHpShield(curr,max)    
    local hasShield = curr and curr > 0 and max and max > 0;
    CSAPI.SetGOActive(shieldBg,hasShield);
    
    if(not hasShield)then
        return;
    end
    --LogError("护盾：" .. tostring(curr) .. "/" .. tostring(max));
    local value = curr / max;   
    shieldBar:SetProgress(value,true);
end


--设置SP
function SetSp(curr,max,immediately)    
    if(isShowXp)then
        CSAPI.SetGOActive(sp,false);   
        return;
    end
   
    
    if(curr == nil)then
        return;
    end
    if(curr > 0)then
        CSAPI.SetGOActive(sp,true);  
    end  

    local value = curr / max;    
    if(not IsNil(spBar))then  
        spBar:SetProgress(value,immediately ~= nil);
    end

    isSpFull = value and value >= 1;

    if(isSpFull and lastSpFullState ~= isSpFull)then
        spFullEff = 1;

        if(currState)then
            ActiveSpFull(true);
        end
    else
        if(not isSpFull)then
            ActiveSpFull(false);
        end
    end
    lastSpFullState = isSpFull;
    --CSAPI.SetGOActive(spFull,(value and value >= 1) and true or false);
end

function UpdateSpFullEff(delay)
    if(delay)then
        FuncUtil:Call(function()
            --local state = isSpFull and true or false; 
            ActiveSpFull();
        end,nil,delay);
    else
        ActiveSpFull(isSpFull and true or false);
    end
end

function ActiveSpFull(state) 
    if(state == nil)then
        if(isSpFull)then
            state = true; 
        else    
            state = false; 
        end
    end
    if(spFull)then
        CSAPI.SetGOActive(spFull,state);
        if(state and spFullEff)then
            CSAPI.SetGOActive(spFull1,true);
            spFullEff = nil;
        else
            CSAPI.SetGOActive(spFull1,false);
        end
    end
end

   --设置XP
function SetXp(curr,max,immediately)
    isShowXp = curr and max and max > 0;
    CSAPI.SetGOActive(xp,isShowXp);    
    if(not isShowXp)then
        return;
    end

--    local y = isShowSp and -0.4 or -0.2;
--    CSAPI.SetLocalPos(xp,0,y,0);

    max = max or 1;
    if(xpBar)then
        --curr = curr and curr + 1 or 0;
        curr = curr and curr or 0;
        xpBar:SetFullProgress(curr,max,immediately ~= nil);
    end
end 

--设置名称
function SetName(name)
    if(txtName == nil)then
        txtName = ComUtil.GetCom(goName,"Text");   
    end
    if(txtName)then
        txtName.text = name or "不配拥有名称";
    end
    
end
--设置数据
function SetData(data)
    --ResUtil.IconCommon:Load(armor,"armor_" .. (data.career or 1));
    local isArmor1 = data.career and data.career == 1;
    CSAPI.SetGOActive(armor1,isArmor1);
    CSAPI.SetGOActive(armor2,not isArmor1);
    --txtLv.text = (data.level or 1) .. "";
end
    
--更新Buff
function UpdateBuff()
    local buffs = nil;
    if(target)then
        buffs = target.GetBuffs();
    end
    if(buffView)then
        buffView.UpdateBuff(buffs);
    end
    UpdateBuffShield();
end

function UpdateBuffShield()
    local myShieldType,myShieldCount = GetShield();     
    local state = (myShieldType and myShieldCount) and true or false;
    CSAPI.SetGOActive(buffShield,state);
    if(state)then
        local targetBuffShield = myShieldType == 1 and buffShield1 or buffShield2;
        CSAPI.SetGOActive(buffShield1,buffShield1 == targetBuffShield);
        CSAPI.SetGOActive(buffShield2,buffShield2 == targetBuffShield);

        CSAPI.SetText(buffShieldCount,tostring(myShieldCount));
    end
end

--function ShowHint()
--    local headGO = target.GetPartGO(3);
--    local footGO = target.GetPartGO(1);
--    local x1,y1,z1 = CSAPI.GetPos(headGO);
--    local x2,y2,z2 = CSAPI.GetPos(footGO);
--    local deltaH = (y1 or 0) - (y2 or 0);

--    local x,y,z = CSAPI.GetPos(nodes);
--    y = y - (deltaH + 0.1) * 11;
--    EventMgr.Dispatch(EventType.Guide_Hint,{x = x,y = y,z = z});
--end

function ShowHint()
    local footGO = target.gameObject;

    local x,y,z = CSAPI.GetPosScene2UI(footGO);
    --LogError(x .. "," .. y .. "," .. z);
    EventMgr.Dispatch(EventType.Guide_Hint,{x = x,y = y,z = z,ui_pos = 1});
end