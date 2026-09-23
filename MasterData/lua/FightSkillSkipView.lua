--回合切换界面


function OnInit()
    InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Fight_Skill_Skip,OnFightSkipStateChanged);    
    eventMgr:AddListener(EventType.Fight_Skill_Skip_Next,OnFightSkipNext);      
end
function OnDestroy()
    eventMgr:ClearListener();
end

function OnFightSkipStateChanged(state) 
    if(_G.no_fight_skill_skip)then
        return;
    end

    if(g_FightMgr and IsPvpSceneType(g_FightMgr.type))then
        return;
    end

    if(g_GuideFightSkipShow and FightClient:IsNewPlayerFight())then
        return;
    end

    if(state and autoSkipNext)then        
        OnClickSkip();
        return;
    end
    FightClient.Intheamplificationmove=state;
    CSAPI.SetGOActive(btnSkip,state);
end

function OnFightSkipNext()
    SetSkipNext(1);

    FuncUtil:Call(SetMaskState,nil,1200,true);
end
function SetSkipNext(skipNext)
    autoSkipNext = skipNext;
    FightActionMgr:SetAutoSkipNext(skipNext);
end

function SetMaskState(state)
    if(bg)then
        CSAPI.SetGOActive(bg,state);
    end
end

function OnClickSkip()
    CSAPI.SetGOActive(btnSkip,false);
  
    SetMaskState(true)
    CSAPI.ClearTimeScaleCtrl();
    CSAPI.SetTimeScaleLockState(true);    

    FuncUtil:Call(DelaySkip,nil,350);   

    EventMgr.Dispatch(EventType.Fight_Skill_Skip); 
    CSAPI.StopExceptTag("bgm");

    EventMgr.Dispatch(EventType.Fight_SkipCast2); 
end

function DelaySkip()
    FireBallMgr:ClearFBEffs();
    FightActionMgr:ApplySkip(SkipComplete);
end


function SkipComplete()
    if(transAni == nil)then
        transAni = ComUtil.GetCom(transition,"Animator");
    end
    if(transAni)then
        transAni:SetTrigger("complete");
    end

    ShowSkillResult();

    --FuncUtil:Call(ShowSkillResult,nil,800);
    FuncUtil:Call(Complete,nil,700);

    EventMgr.Dispatch(EventType.Fight_Skill_Skip_Complete,nil,true);     
end

function ShowSkillResult()
    local fa = FightActionMgr.curr;
    if(not fa or not fa.GetTargetCharacters)then
        return;
    end
    local targets = fa:GetTargetCharacters();
    if(targets)then
        local showTotalDamage = nil;
        for _,target in pairs(targets)do
            if(target)then
                local damageFloatDatas = target.GetFloatDatas();
                if(damageFloatDatas)then
                    showTotalDamage = true;
                    local originPos = target.GetOriginPos();
                    local x,y,z = originPos[1],originPos[2],originPos[3];
                    --local x,y,z = target.GetPos();
                    FuncUtil:Call(ResUtil.CreateEffect,ResUtil,400,"common_hit/common_hit1",x,0,z);
                    FuncUtil:Call(ApplySkipFloatDatas,nil,450,target);
                end
            end
        end

        if(showTotalDamage)then
           FuncUtil:Call(EventMgr.Dispatch,nil,500,EventType.Fight_Damage_Reshow);
        end
    end
end

function ApplySkipFloatDatas(target)
    if(target)then
        target.ApplyHit();
        target.ApplySkipFloatDatas();
    end
end

function Complete()
    SetMaskState(false);
    SetSkipNext();
end
