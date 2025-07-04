---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by daiyi.
--- DateTime: 2019/4/12 15:20
---
local EquipAttrComponent = BaseClass("EquipAttrComponent", Component)
local base = Component

local function GetAttrType(equipAttr)
    if equipAttr == 1 then
        return NumericType.MaxHpAdd
    elseif equipAttr == 2 then
        return NumericType.AtkAdd
    elseif equipAttr == 3 then
        return NumericType.DefAdd
    elseif equipAttr == 4 then
        return NumericType.SpeedAdd
    elseif equipAttr == 5 then
        return NumericType.MaxHpPct
    elseif equipAttr == 6 then
        return NumericType.AtkPct
    elseif equipAttr == 7 then
        return NumericType.DefPct
    elseif equipAttr == 8 then
        return NumericType.SpeedPct
    end
    return 0
end

local function SetBaseAttr(self)
    ---- 普通装备
    --if self.z_equip.Exclusive == 0 then
    --    self.EquipAttrs[GetAttrType(self.z_equip.BaseAttrType[1])] = self.__entity.BaseAttr
    --else --专属装备
    --    for i,v in ipairs(self.z_equip.BaseAttrType) do
    --        self.EquipAttrs[GetAttrType(v)]=self.z_equip.BaseAttrVal[i]
    --    end
    --end
    -- 普通装备
    if self.z_equip.Exclusive == 0 then
        self.EquipAttrs[GetAttrType(self.z_equip.BaseAttrType[1])] = Game.Registry:NewObject("CheatData", self.__entity.BaseAttr)
    else --专属装备
        for i,v in ipairs(self.z_equip.BaseAttrType) do
            self.EquipAttrs[GetAttrType(v)] = Game.Registry:NewObject("CheatData", self.z_equip.BaseAttrVal[i]) 
        end
    end
end

local function LevelAttrAdd(self)
    --if self.z_equip.Exclusive == 0 and self.__entity.Level > 0 then
    --    local attrAdd = 1 + (self.__entity.Level - 1 ) * self.level_attr_add / 100
    --    table.map(self.EquipAttrs,function(k, v)
    --        if self.__entity.Level >= 20 then
    --            return (v * attrAdd < v + self.__entity.Level - 1 and {v + self.__entity.Level - 1} or {v * attrAdd}) [1]
    --        end
    --        return v * attrAdd 
    --    end)
    --end
    if self.z_equip.Exclusive == 0 and self.__entity.Level > 0 then
        local attrAdd = 1 + (self.__entity.Level - 1 ) * self.level_attr_add / 100
        table.map(self.EquipAttrs,function(k, v)
            local val = 0
            if self.__entity.Level >= 20 then
                val = (v:Get() * attrAdd < v:Get() + self.__entity.Level - 1 and {v:Get() + self.__entity.Level - 1} or {v:Get() * attrAdd}) [1]
            else
                val = v:Get() * attrAdd
            end
            v:Set(val)
            return v
        end)
    end
end

local function StarAttrAdd(self)
    --if self.z_equip.Exclusive == 0 then return end
    --local attrAdd = 1 + (self.__entity.Star - 1) * self.star_attr_add / 100
    --table.map(self.EquipAttrs,function(k,v)
    --    return v * attrAdd
    --end)
    if self.z_equip.Exclusive == 0 then return end
    local attrAdd = 1 + (self.__entity.Star - 1) * self.star_attr_add / 100
    table.map(self.EquipAttrs,function(k,v)
        local val = v:Get() * attrAdd
        v:Set(val)
        return v
    end)
end

local function Awake(self)
    base.Awake(self)

    self.EquipAttrs = {}
    self.star_attr_add = table.first(Z_PropAdd,function(v) return v.Name == "EquipStarAttrAdd" end).AttrAdd
    self.level_attr_add = table.first(Z_PropAdd,function(v) return v.Name == "EquipLevelAttrAdd" end).AttrAdd
    self.z_equip = Z_Equip[self.__entity.TemplateId]
    
    SetBaseAttr(self)
    LevelAttrAdd(self)
    StarAttrAdd(self)
end

local function GetAttrDesc(attrType,val) -- 测试用=====
    if attrType == NumericType.MaxHpAdd then
        return "HP+"..val
    elseif attrType == NumericType.AtkAdd then
        return "ATK+"..val
    elseif attrType == NumericType.DefAdd then
        return "DEF+"..val
    elseif attrType == NumericType.SpeedAdd then
        return "SPD+"..val
    elseif attrType == NumericType.MaxHpPct then
        return "HP"..val.."%"
    elseif attrType == NumericType.AtkPct then
        return "ATK"..val.."%"
    elseif attrType == NumericType.DefPct then
        return "DEF"..val.."%"
    elseif attrType == NumericType.SpeedPct then
        return "SPD"..val.."%"
    end
end

local function GetAttrDescs(self)
    --local ret = {}
    --for k,v in pairs(self.EquipAttrs) do
    --    table.insert(ret, GetAttrDesc(k, math.modf(v)))
    --end
    --return ret
    local ret = {}
    for k,v in pairs(self.EquipAttrs) do
        table.insert(ret, GetAttrDesc(k, math.modf(v:Get())))
    end
    return ret
end

local function GetAttr(self)
    --return table.first(self.EquipAttrs)
    local cheat = table.first(self.EquipAttrs)
    return cheat:Get()
end

local function LevelUp(self,level)
    self.__entity.Level = level
    self.EquipAttrs = {}
    SetBaseAttr(self)
    LevelAttrAdd(self)
    StarAttrAdd(self)
end

local function StarUp(self,star)
    self.__entity.Star = star
    self.EquipAttrs = {}
    SetBaseAttr(self)
    LevelAttrAdd(self)
    StarAttrAdd(self)
end

local function Dispose(self)
    base.Dispose(self)
end

EquipAttrComponent.Awake = Awake
EquipAttrComponent.GetAttrDescs = GetAttrDescs
EquipAttrComponent.GetAttr = GetAttr
EquipAttrComponent.LevelUp = LevelUp
EquipAttrComponent.StarUp = StarUp
EquipAttrComponent.Dispose = Dispose


return EquipAttrComponent