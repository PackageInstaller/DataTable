local this = {}

-- 合并相同的物品
function this.SetShrink(_rewards)
    local _datas = {}
    local _newDatas = {}
    local _newDatas2 = {} -- 标签
    for i, v in ipairs(_rewards) do
        if (v.type == nil) then -- 没有type则视作物品
            v.type = RandRewardType.ITEM
        end
        local reward = this.GetReward(v)
        local isMat = false
        if v.c_id ~= nil then
            local equipData = EquipMgr:GetEquip(v.c_id)
            if equipData and equipData:GetType() == EquipType.Material then
                isMat = true
            end
        end
        if v.tag == nil then -- 区分标签物品
            if ((v.type == RandRewardType.ITEM) or isMat) then
                _newDatas[v.type] = _newDatas[v.type] or {}
                if (_newDatas[v.type][v.id]) then
                    _newDatas[v.type][v.id].num = _newDatas[v.type][v.id].num + v.num
                else
                    _newDatas[v.type][v.id] = reward
                end
            else
                table.insert(_datas, reward)
            end
        else
            if ((v.type == RandRewardType.ITEM) or isMat) then
                _newDatas2[v.type] = _newDatas2[v.type] or {}
                if (_newDatas2[v.type][v.id]) then
                    _newDatas2[v.type][v.id].num = _newDatas2[v.type][v.id].num + v.num
                else
                    _newDatas2[v.type][v.id] = reward
                end
            else
                table.insert(_datas, reward)
            end
        end
    end
    for i, v in pairs(_newDatas) do
        for n, m in pairs(v) do
            table.insert(_datas, m)
        end
    end
    for i, v in pairs(_newDatas2) do
        for n, m in pairs(v) do
            table.insert(_datas, m)
        end
    end

    _datas = SortMgr:Sort(19, _datas)

    return _datas
end

--检查是否存在素材芯片或者经验物品
function this.CheckChipExpInfo(_rewards)
    local expGoods=nil;
    local num=0;
    local hasExp=false;
    if _rewards then
        for k, v in ipairs(_rewards) do
            if (v.type == nil) then -- 没有type则视作物品
                v.type = RandRewardType.ITEM
            end
            if (v.type == RandRewardType.ITEM) then
                local cfg = Cfgs.ItemInfo:GetByID(v.id);
                if cfg.type==ITEM_TYPE.EQUIP_MATERIAL then
                    local equip= EquipData({cfgid=cfg.dy_value1});
                    local info=equip:GetMaterialInfo();
                    num=info.exp*v.num+num;
                end
            elseif v.type == RandRewardType.EQUIP then
                local equipData = EquipMgr:GetEquipByCfgID(v.id)
                if equipData==nil then
                    local data = {}
                    data.cfgid = v.id
                    data.level =  0
                    equipData = EquipData(data);
                end
                if equipData and equipData:GetType() == EquipType.Material then
                    local info=equipData:GetMaterialInfo();
                    num=info.exp*v.num+num;
                end
            end
        end
        hasExp=num>0 and true or hasExp;
        if num>0 then
            expGoods=BagMgr:GetFakeData(ITEMS_ID.EQUIP_EXP,num);
        end
    end
    return expGoods,hasExp;
end


function this.GetReward(v)
    local reward = {}
    reward.type = v.type
    reward.num = v.num
    reward.id = v.id
    reward.c_id = v.c_id
    -- reward.tips = v.tips
    reward.tag = v.tag
    return reward
end

-- type:ITEM_TAG
function this.GetTips(_type)
    local str = ""
    if _type == ITEM_TAG.FirstPass then
        str = LanguageMgr:GetByID(21106)
    elseif _type == ITEM_TAG.ThreeStar then
        str = LanguageMgr:GetByID(21107)
    elseif _type == ITEM_TAG.Chance then
        str = LanguageMgr:GetByID(15088)
    elseif _type == ITEM_TAG.LittleChance then
        str = LanguageMgr:GetByID(15089)
    elseif _type == ITEM_TAG.TimeLimit then
        str = LanguageMgr:GetByID(15123)
        str = StringUtil:SetByColor(str, "FFFFFF")
    elseif _type == ITEM_TAG.Other then
        str = LanguageMgr:GetByID(320030)
    end
    return str
end

-- 特殊掉落
function this.GetSpecialReward(sectionID)
    local cfg = Cfgs.CfgSpecialDrops:GetByID(sectionID)
    local isFixed = false
    if cfg then
        if cfg.isHide then --不显示
            return nil, isFixed
        end
        if cfg.DropsStartTime and cfg.DropsEndTime then
            isFixed = cfg.isEntryPoint ~= nil
            local begTime = TimeUtil:GetTimeStampBySplit(cfg.DropsStartTime) or 0
            local endTime = TimeUtil:GetTimeStampBySplit(cfg.DropsEndTime) or 0
            local curTime = TimeUtil:GetTime() or 0
            if curTime > begTime and curTime <= endTime and cfg.DropID then
                if cfg.DropID and #cfg.DropID > 0 then
                    local rewards = {}
                    for i, id in ipairs(cfg.DropID) do
                        local cfgItem = Cfgs.CfgDropItem:GetByID(id)
                        if cfgItem then
                            table.insert(rewards, {cfgItem.DropItemID})
                        end
                    end
                    return rewards, isFixed
                end
            end
        end
    end
    return nil, isFixed
end

return this
