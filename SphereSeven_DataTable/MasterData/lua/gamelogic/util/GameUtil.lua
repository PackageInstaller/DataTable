
local GameUtil={}

local GrowthAttrType = {
    Hp = 1,
    Atk = 2,
    Def = 3,
    MagicDef = 4,
    Speed = 5,
    Crit = 6,
    CritDamage = 7,
    EAcc = 8,
    ERist = 9,
    Acc = 10,
    Eva = 11,
}

AttrNameTypeTable = {
    Hp = NumericType.MaxHp,
    Atk = NumericType.Atk,
    Def = NumericType.Def,
    MagicDef = NumericType.MagicDef,
    Speed = NumericType.Speed,
    Crit = NumericType.Cri,
    CritDamage = NumericType.CriDamage,
    EAcc = NumericType.EAcc,
    ERist = NumericType.ERist,
    Acc = NumericType.Acc,
    Eva = NumericType.Pry,
}

function GameUtil.GetAttrTypeBaseFromName(AttrName)
    if AttrNameTypeTable[AttrName] == nil then
        return 0
    end
    return AttrNameTypeTable[AttrName] * 10 + 1
end

function GameUtil.GetAttrTypeAddFromName(AttrName)
    if AttrNameTypeTable[AttrName] == nil then
        Logger.LogError("GetAttrTypeAddFromName, invalid attribute name: " .. AttrName)
        return 0
    end
    return AttrNameTypeTable[AttrName] * 10 + 2
end

return GameUtil