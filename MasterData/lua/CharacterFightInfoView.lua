
function Awake()
    hpBar = ComUtil.GetCom(goHp,"BarBase");  
    shieldBar = ComUtil.GetCom(goShield,"BarBase");  
    spBar = ComUtil.GetCom(goSp,"BarBase");    
    --tmSp = ComUtil.GetCom(sp,"TextMesh");   
    xpBar = ComUtil.GetCom(xp,"BarBase");    
--    tmName = ComUtil.GetCom(goName,"TextMesh");   
--    tmLv = ComUtil.GetCom(lv,"TextMesh");   
    SetActionState(false);

    
    SetShowState(true);  
end


function OnInit()
    InitListener();
end
function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Character_FightInfo_Show,OnFightInfoShowStateChanged);   
end
function OnDestroy()
    eventMgr:ClearListener();
end
--头顶信息显示状态切换
function OnFightInfoShowStateChanged(state)   
    SetShowState(state);
end
function SetActionState(actionState)
    CSAPI.SetGOActive(arrow,actionState);
end


function SetShowState(state)
    CSAPI.SetGOActive(nodes,state);
end

--设置HP
function SetHp(curr,max,immediately)    
    local value = curr / max;   
    hpBar:SetProgress(value,immediately ~= nil);
end
--设置护盾HP
function SetHpShield(curr,max,immediately)    
    local value = curr / max;   
    shieldBar:SetProgress(value,immediately ~= nil);
end


--设置SP
function SetSp(curr,max,immediately)
    if(isShowXp)then
        CSAPI.SetGOActive(sp,false);   
        return;
    end
     
    CSAPI.SetGOActive(sp,curr ~= nil);    
    if(curr == nil)then
        return;
    end

    --tmSp.text = curr .. "/" .. max
    local value = curr / max;      
    spBar:SetProgress(value,immediately ~= nil);
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
    xpBar:SetFullProgress(curr,max,immediately ~= nil);
end 

--设置名称
function SetName(name)
    --tmName.text = name or "不配拥有名称";
end
--设置数据
function SetData(data)
    ResUtil.IconCommon:LoadSR(armor,"armor_" .. (data.career or 1));
    --tmLv.text = (data.level or 1) .. "";
end
    


--获取buff节点
function GetBuffNode()
    return buffNode;
end