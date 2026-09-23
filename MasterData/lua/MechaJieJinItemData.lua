-- 解禁 机神
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(_data, _isOpen, _isUse)
    self.data = _data
    self.isOpen = _isOpen
    self.isUse = _isUse
end

-- 技能id 
function this:GetSkillID()
    return self.data[1]
end

-- 怪物id
function this:GetMonsterCfgID()
    return RoleTool.GetMonsterIDBySkillID(self.data[1])
end

-- open,desc
function this:CheckIsOpen()
    local str = ""
    if (not self.isOpen) then
        local id = self.data[2]
        local b, _str = MenuMgr:CheckConditionIsOK({id})
        str = _str
    else 
        str = self:GetModelCfg().model_desc
    end
    return self.isOpen, str
end

function this:GetModelID()
    return self:GetCfg().model
end

function this:CheckIsUse()
    return self.isUse
end

function this:GetCfg()
    if (not self.cfg) then
        self.cfg = Cfgs.MonsterData:GetByID(self:GetMonsterCfgID())
    end
    return self.cfg
end
function this:GetModelCfg()
    if (not self.modelCfg) then
        local model = self:GetCfg().model
        self.modelCfg = Cfgs.character:GetByID(model)
    end
    return self.modelCfg
end
function this:GetName()
    return self:GetModelCfg().key
end

function this:GetSetStr()
    return self:GetModelCfg().desc
end


return this
