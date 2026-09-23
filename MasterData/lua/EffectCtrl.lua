
function Awake()
    if(pathCom)then
        csCom = ComUtil.GetCom(pathCom,"ResizePath");
    end
end

function Init(fireBall)
    local fb = fireBall;
    if(fb)then        
        if(IsNil(csCom))then
            LogError("特效对象" .. gameObject.name .. "不存在组件ResizePath");
        else
            local cfgFb = fb.GetCfg();
            local fightAction = fb.GetFightAction();

            if(fightAction and cfgFb)then
                    
                if(cfgFb.path_index and cfgFb.path_index > 0)then
                    local hitTarget = cfgFb.path_index == 100 and fb.GetHitTarget();
                    if(hitTarget)then                           
                        local x,y,z = hitTarget.GetPos();
                        SetTarget(x,y,z,true);
                    else                           
                        if(cfgFb.path_index == 200)then
                            local targets = fightAction:GetDebuffCharacters();
                            if(targets)then
                                for _,target in pairs(targets)do
                                    local x,y,z = target.GetPos();
                                    SetTarget(x,y,z,true);
                                    break;
                                end
                            else
                                LogError("特效对象" .. gameObject.name .. "设置路径失败。找不到Debug目标，path_index设置为200为debug目标");
                            end
                        elseif(cfgFb.path_index == 300)then--敌方场地中点
                            local actorCharacter = fightAction:GetActorCharacter();
                            local originTeamId = actorCharacter.GetTeam();
                            local teamId = TeamUtil:GetOpponent(originTeamId);
                            local x,y,z = FightGroundMgr:GetCenter(teamId);
                            SetTarget(x,y,z,true);
                        else                            
                            local targets = fightAction:GetDamageTargetByIndex(cfgFb.path_index);
                            if(targets)then
                                local x,y,z = targets[1].GetPos();
                                SetTarget(x,y,z,true);
                            else
                                LogError("特效对象" .. gameObject.name .. "设置路径失败。找不到目标段的攻击目标：" .. cfgFb.path_index);
                            end
                        end
                    end
                else
                    local pathTargetData = cfgFb.path_target;
                    if(pathTargetData)then
                        local x,y,z = fightAction:Calculate(pathTargetData);
                        SetTarget(x,y,z);
                    else
                        LogError("特效对象" .. gameObject.name .. "未设置路径目标path_target");
                    end
                end
            end
        end
    end
end

function SetTarget(x,y,z,faceToTarget)
    if(faceToTarget)then      
        CSAPI.FaceToTarget(gameObject,x,y,z);
    end
    --LogError(x .. "," ..y .. "," .. z .. " : " .. tostring(faceToTarget));
    csCom:SetTarget(x,y,z);
end
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
pathCom=nil;
end
----#End#----