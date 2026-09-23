local this = {}

this.keyList = { -- 光环可用的属性类型
    attack = 1,
    maxhp = 2,
    defense = 3,
    speed = 4,
    crit_rate = 5,
    crit = 6,
    hit = 7,
    resist = 8,
    career = 20,
    attack_fixed = 44,
    maxhp_fixed = 45,
    defense_fixed = 46
}

this.fixedList = { -- 固定显示数值的属性类型
    speed = 4,
    attack_fixed = 44,
    maxhp_fixed = 45,
    defense_fixed = 46
}

-- 卡牌是否满足光环解锁条件
function this.IsCondUnLock(cardData, haloLv, haloConditionID)
    local haloCondition = HaloLockCondition.New();
    haloCondition:InitCfg(haloConditionID);
    return haloCondition:IsPass(cardData, haloLv);
end

function this.GetPropertyEnumCfg(key)
    local id = this.keyList[key];
    if id ~= nil then
        return Cfgs.CfgCardPropertyEnum:GetByID(id);
    end
end

function this.GetPropertyValueStr(key, _num)
    local str = ""
    if key and _num then
        if this.fixedList[key] then
            str = tostring(_num);
        else
            str = string.match((tonumber(_num) * 100), "%d+") .. "%"
        end
    end
    return str;
end

-- 返回光环的所有属性说明（包含未解锁的） hasLock : 属性加锁时是否返回
function this.CountHaloAddtion(curHaloInfo, cardData, val1Color, val2Color, val1Color2, val2Color2, hasLock)
    -- 根据装备跟当前等级获取加成属性
    local list = {};
    if curHaloInfo then
        local ls = curHaloInfo:GetAdditionFormat();
        for k, v in ipairs(ls) do
            table.insert(list, {
                cfg = v.cfg,
                addtive = v.addtive,
                addtiveNum = v.addtiveNum,
                val1Color = val1Color,
                val2Color = val2Color
            });
        end
        if hasLock and #ls < curHaloInfo:GetMaxAttrNum() then
            local attr = curHaloInfo:GetLockAttr();
            if attr ~= nil then
                -- 插入加锁的词条
                table.insert(list, {
                    cfg = HaloUtil.GetPropertyEnumCfg(attr.key),
                    attrCfg=attr.cfg,
                    addtive = HaloUtil.GetPropertyValueStr(attr.key,attr.addtive),
                    addtiveNum = attr.addtive,
                    val1Color = val1Color,
                    val2Color = val2Color,
                    isLock=true,
                    lockStr=LanguageMgr:GetByID(1033)..attr.cfg.index,
                });
            end
        end
    end
    return list;
end

return this;
