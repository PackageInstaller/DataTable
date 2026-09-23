local reward = nil
function Refresh(_reward)
    reward = _reward
    if reward then
        local clickCB = nil;
        local goodsData = nil;
        if reward.c_id and reward.type == RandRewardType.EQUIP then
            goodsData = EquipMgr:GetEquip(reward.c_id);
            if goodsData:GetType() == EquipType.Material then
                clickCB = GridClickFunc.OpenInfoSmiple
            else
                clickCB = GridClickFunc.EquipDetails
            end
        else
            goodsData, clickCB = GridFakeData(reward)
            if goodsData:GetType() == ITEM_TYPE.SEL_BOX then
                clickCB = GridClickFunc.OpenInfoShort
            end
        end
        if not item then
            item = ResUtil:CreateRewardByData(goodsData, gridParent.transform);
        else
            item.Refresh(goodsData)
        end
        item.SetCount(reward.num);
        item.SetClickCB(clickCB);
        if reward.type == RandRewardType.CARD then
            item.SetClickState(false)
        end
    end
end