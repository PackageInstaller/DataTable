local this = {}
--光环站位信息
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
	if cfgId then
        self.cfg=Cfgs.cfgHaloCoordinate:GetByID(cfgId);
    end
    if self.cfg==nil then
        LogError("cfgHaloCoordinate中找不到对应ID："..tostring(cfgId).."的配置信息");
    end
end

--data:{id=coorId,haloId=haloID,lv=lockLevel}
function this:SetData(_d)
	self.data=_d;
	if self.data then
		self:InitCfg(_d.id);
	end
end

function this:GetCfg()
	return self.cfg;
end

function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

function this:GetCoord()
	return self.cfg and self.cfg.coordinate or nil
end

function this:GetIcon()
	return self.cfg and self.cfg.gridsIcon or nil
end

function this:LoadIcon(go)
	local iconName=self:GetIcon();
	if iconName~=nil then
		ResUtil.RoleSkillGrid:Load(go, iconName)
	end
end

function this:GetLockLv()
	return self.data and self.data.lv or 1;
end

function this:GetHaloID()
	return self.data and self.data.haloID or nil;
end

return this;