local this = {};

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

function this:Init(_data)
    self.data = _data
    self.cfg = Cfgs.MainLine:GetByID(self:GetID())
end

function this:GetID()
    return self.data and self.data.id or 0
end

function this:GetDungeonCfg()
    return self.cfg
end

function this:IsOpen()
    local dungeonData = DungeonMgr:GetDungeonData(self.cfg.id)
    if dungeonData and dungeonData:IsPass() then
        if self.data and self.data.isOpenModUp then
            return true
        end
    end
    return false
end

function this:GetLockStr()
    if self.cfg and self.cfg.modUpOpenId then
        local cfgOpen = Cfgs.CfgModUpOpenType:GetByID(self.cfg.modUpOpenId)
        return cfgOpen and cfgOpen.sDescription or ""
    end
    return ""
end

function this:GetResetTime()
    return self.data and self.data.modUpResetTime or -1
end

function this:GetCount()
    local max = self.cfg.modUpCnt
    if max > 0 then
        local cur = self.data and self.data.modUpCount or 0
        return max - cur
    end
    return -1
end

return this