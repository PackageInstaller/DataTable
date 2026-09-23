--参与者信息
local this={}

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end


--初始化配置
function this:InitCfg(cfgId)
    if(cfgId == nil)then
        LogError("初始化参与者信息失败！无效配置id");        
    end

    if(self.cfg == nil)then   
        self.cfg = Cfgs.RoleImgInfo:GetByID(cfgId);
        if(self.cfg == nil)then        
            LogError("找不到参与者信息！id = " .. cfgId);  
        end
    end
end

function this:GetID()
    return self.cfg and self.cfg.id;
end

--返回模型表ID
function this:GetModelID()
    return self.cfg and self.cfg.characterID;
end

--返回立绘人物名称
function this:GetRoleName()
    return self.cfg and self.cfg.roleName;
end

--返回立绘位置
function this:GetRoleImgPos()
    local imgPos=self.cfg and self.cfg.roleImgPos;
    local pos=nil;
    if imgPos~=nil then
        pos={};
        pos[PlotAlign.Left]=imgPos.pos[1];
        pos[PlotAlign.Center]=imgPos.pos[2];
        pos[PlotAlign.Right]=imgPos.pos[3];
    end
    return pos;
end

function this:GetMaskSize()
    return self.cfg and self.cfg.maskSize or {736,1080};
end

function this:GetMaskOffset()
    return self.cfg and self.cfg.maskOffset or {0,0};
end

--返回立绘缩放
function this:GetScale()
    return self.cfg and self.cfg.scale or 1;
end

--返回头像
function this:GetIcon()
    local iconName=nil;
    if  self:GetModelID()~=nil then
        local modelCfg=Cfgs.character:GetByID(self:GetModelID());
        iconName=modelCfg.icon;
    end
    return iconName;
end

function this:GetGradientInfo()
    return self.cfg and self.cfg.gradientInfo
end

function this:GetIconGradient()
    return self.cfg and self.cfg.IconGradient
end

-- function this:GetIcon2()
--     local iconName=nil;
--     if  self:GetModelID()~=nil then
--         local modelCfg=Cfgs.character:GetByID(self:GetModelID());
--         iconName=modelCfg.icon;
--     end
--     return iconName;
-- end

return this;


