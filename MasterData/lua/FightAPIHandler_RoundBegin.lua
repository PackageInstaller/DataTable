local this = {};

--添加角色
function this:Handle(data)   
    if(not data)then
        return;
    end      
    
    local datas = data.datas;
    --LogError(datas);
    if(not datas)then
        return;
    end
    local leftDatas = nil;
    for i,targetData in ipairs(datas)do
        if(leftDatas)then
            table.insert(leftDatas,targetData);
            datas[i] = {};
        end    
        if(targetData.death)then--有角色死亡，后续数据插入死亡表现后
            leftDatas = leftDatas or {};
--            LogError("拆分=========================");
--            LogError(datas);
        end            
    end
      
    FightActionUtil:PushServerDatas(datas)
   
    local fa = FightActionMgr:Apply(FightActionType.DeadChecker);
    FightActionMgr:Push(fa);

    if(leftDatas)then
--        local leftApiData = { api = data.api,datas = leftDatas};
--        local leftFa = 

--        FightActionMgr:Push(leftFa);
--        LogError("前部数据");
--        LogError(datas);
--        LogError("加入剩余数据");
--        LogError(leftDatas);
        FightActionUtil:PushServerDatas(leftDatas);        
    end
end

return this;