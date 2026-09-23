local this = {};

function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.Damage,data);   
    return fightAction;
end


----处理伤害
--function this:Handle(data,outputData)
--    local targetId = data.id;
--    local damages = data.datas;
--    if(targetId == nil)then
--        LogError("伤害API找不到有效id！");
--        LogError(data);
--    end
--    if(damages == nil)then
--        LogError("伤害API找不到有效伤害数据！");
--        LogError(data);
--    end

--    outputData[targetId] = outputData[targetId] or {};
--    local targetDatas = outputData[targetId];
--    local targetOrder = data.order;
--    for _,v in ipairs(damages)do
--        v.api = APIType.Damage;
--        v.death = data.death;
--        v.type = data.type;
--        v.order = targetOrder;
--        table.insert(targetDatas,v);
--    end
----    local damageCount = #damages;
----    local orderKey = "orderDamageNums";
----    outputData[orderKey] = outputData[orderKey] or {};
----    local orders = outputData[orderKey];
----    orders[targetOrder] = orders[targetOrder] or 0;
----    orders[targetOrder] = math.max(orders[targetOrder],damageCount);
--end

return this;