--副本道具

--初始化道具
function InitProp(propId)
    local cfgGridProp = Cfgs.GridProp:GetByID(propId);
    SetCfg(cfgGridProp);
    if(cfgGridProp)then      
        if(not StringUtil:IsEmpty(cfgGridProp.res))then           
            ResUtil:CreateGridProp(cfgGridProp.res,0,0,0,resParentGO,cfgGridProp.resDir);
            
            local angle = cfgGridProp.angle;
            if(angle)then
                CSAPI.SetAngle(resParentGO,0,angle,0);
            end
        end
    else
        LogError("找不到关卡道具配置" .. propId);
    end
end

function SetShowState(isShow)    
end

--设置数据
function SetData(targetData)
    data = targetData;

    SetShowState(not IsFighting());
end
--更新数据
function UpdateData(targetData)
    data = targetData;
   
   if(IsDead())then
       Remove();    
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

--设置到指定格子处
function SetToGrid(gridId)
    currGridId = gridId;

    local mapGrid = MapMgr:GetGrid(gridId);
    if(mapGrid == nil)then
        return;
        --LogError("无法将战棋目标设置到格子" .. gridId);
    end

    local pos = mapGrid:GetData().pos;
    CSAPI.SetLocalPos(gameObject,pos[1],pos[2] + 0.5,pos[3]);
end
--获取当前所在位置
function GetCurrGridId()
    return currGridId;
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
    CSAPI.RemoveGO(gameObject);
end

function ApplyUse(data,completeCallBack,caller)
     
    local character = BattleCharacterMgr:GetCharacter(data.oid);   

    if(cfg and cfg.float_font)then
        if(character)then             
            character.CreateFloatFont(cfg.float_font);
        end
    end
    local getEff = cfg and cfg.get_eff;
    if(getEff)then
        BattleMgr:CreateEff(getEff,currGridId);       
    end

  
    --传送
    if(IsTransfer())then      
        local targetPosId = data.tParam and data.tParam.pos;
        local isTransferStage = IsTransferStage();
        if(isTransferStage)then           
            local mapGridItem = BattleMgr:GetMapGridItem(currGridId);
            mapGridItem.SetEnableState(false);
        end
        BattleMgr:ApplyTransfer(data.oid,currGridId,targetPosId,isTransferStage,completeCallBack,caller,isTransferStage and this or nil);
       
        return;
    end

   
    --随机道具
    if(data.type == ePropType.Box)then
        local rewards = data.tParam and data.tParam.reward;
        if BattleMgr.battleData then
            BattleMgr.battleData.nBox=data.tParam.nBox;
        end
        EventMgr.Dispatch(EventType.Battle_BoxNum_Change,{
            type=DungeonStarType.BoxNum,
            num=data.tParam.nBox,
        });
        
        --FuncUtil:Call(CSAPI.OpenView,nil,1500,"RewardPanel", {rewards});
        UIUtil:OpenReward( {rewards});
    elseif(data.type == ePropType.Rand)then
        local targetPropId = data.tParam and data.tParam.nPropID;
        local cfgTargetProp = Cfgs.GridProp:GetByID(targetPropId); 
        SetCfg(cfgTargetProp);
    elseif(data.type == ePropType.AttackObj)then
        --固定攻击范围机关
        --local atkEff = cfg.clientParam[1];
        local hitEff = cfg.clientParam[1];

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

                    local gridId = atkTarget.GetCurrGridId();
                    BattleMgr:CreateEff(hitEff,gridId);
                end                
            end
        end
    elseif(data.type == ePropType.AttackObjRand)then
        --随机攻击范围机关
        local isWarning = data.tParam and data.tParam.isWarn;
        local atkRange = data.tParam and data.tParam.range;
        local atkTargets = data.tParam and data.tParam.targets;
        
        local effIndex = isWarning and 2 or 1;
        local callBack = isWarning and OnWarnEffCreated or nil;

        if(cfg.clientParam)then

            local atkEff = cfg.clientParam[effIndex];
            if(atkRange)then
                for _,gridId in ipairs(atkRange)do
                    BattleMgr:CreateEff(atkEff,gridId,callBack);
                end
            end
        end

        --受击
        if(atkTargets)then
            for _,target in ipairs(atkTargets)do
                local atkTarget = BattleCharacterMgr:GetCharacter(target);   
                if(atkTarget)then
                    atkTarget.ApplyHit();
                end
            end
        end

        --移除预警特效
        if(not isWarning)then
            RemoveWarningEffs();
            
            FuncUtil:Call(completeCallBack,caller,1000);  
            return;       
        end       
    end
    

    if(completeCallBack)then
        completeCallBack(caller);
    end
end

function OnDestroy()  
    RemoveWarningEffs();

    BattleCharacterMgr:RemoveCharacter(GetId());
end

function RemoveWarningEffs()  
    if(warnEffs)then        
        for _,warnEff in ipairs(warnEffs)do
            if(not IsNil(warnEff))then
                CSAPI.RemoveGO(warnEff);
            end
        end

        warnEffs = nil;
    end  
end

function OnWarnEffCreated(go)   
    warnEffs = warnEffs or {};
    table.insert(warnEffs,go);

    if(IsNil(gameObject))then
        CSAPI.RemoveGO(go);
    else
       
    end
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