local this = {};

function this:Handle(data)
    local fightAction = FightActionMgr:Apply(FightActionType.Cure,data);   
    return fightAction;
end

----处理治疗
--function this:Handle(data,outputData)
--    local targetId = data.id;
--    local cures = data.datas;
--    if(targetId == nil)then
--        LogError("治疗API找不到有效id！");
--        LogError(data);
--    end
--    if(cures == nil)then
--        LogError("治疗API找不到有效治疗数据！");
--        LogError(data);
--    end

--    outputData[targetId] = outputData[targetId] or {};
--    local targetDatas = outputData[targetId];

--    for _,v in ipairs(cures)do
--        v.api = APIType.Cure;
--        table.insert(targetDatas,v);
--    end
--end

return this;