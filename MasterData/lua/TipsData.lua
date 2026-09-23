local this = {};

function this.New()
	this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins, this);		
	return ins;
end

function this:InitCfg(cfgKey)
	
    local newCfg = cfgKey and Cfgs.CfgTipsSimpleChinese:GetByKey(cfgKey);
    if(not newCfg)then
        LogError("初始化物品配置失败！无效配置id:" .. tostring(cfgKey));		
    end

    self.cfg = newCfg;
--    if(self.cfg == nil) then	
--        self.cfg = newCfg;
--	  end
end

--设置参数
function this:SetParam(param)
    self.params=param;
    -- print(self.params);
    -- if param and type(param)=="table" and #param>0 then
    --     self.params={};
    --     for k,v in pairs(param) do
    --         table.insert(self.params,self:GetParamStrByData(v));
    --     end
    -- else
    --     self.params=nil;
    -- end
end

function this:GetKey()
    return self.cfg and self.cfg.key or nil;
end

--返回参数
function this:GetParam()
    if self.params~=nil then
        return self.params;
    end
    return nil;
end

--返回提示所属的模块
function this:GetFunType()
    return self.cfg and self.cfg.nFunType or 0;
end

--返回表中的固定参数
function this:GetArg1()
    return self.cfg and self.cfg.arg1 or nil;
end

--返回显示类型
function this:GetShowType()
    return self.cfg and self.cfg.nShowType or 1;
end

--返回提示正文
function this:GetContent()
    if self.params then
        -- return CSAPI.FormatString(self.cfg.sStr,self.params);
        local str=self.cfg.sStr;
        local content=self.cfg.sStr;
        if string.match(str,"{%d+}") then
            for v in string.gmatch(str,"{%d+}") do
                local index=string.match(v,"%d+");
                -- LogError(index)
                local param=self:GetParamStrByData(self.params[tonumber(index)])
                content=string.gsub(content,"{%d+}",param,1);
            end
        else
            for k,v in ipairs(self.params) do
                local param=self:GetParamStrByData(v);
                content=string.gsub(content,"{}",param,1);
            end
        end
        return content;
    else
        return self.cfg.sStr;
    end
end

--获取参数字符串
function this:GetParamStrByData(data)
    local str="";
    if data then
        --还需要判定当前的显示框是否是奖励框
        local item=nil;
        if data.type==TipAargType.OnlyParm then--只读参数
            str=data.param;
        elseif data.type==TipAargType.EmptyParm then   --代表参数为空
            str="";
        elseif data.type==TipAargType.ItemId then   --代表为物品ID
            item=BagMgr:GetData(tonumber(data.param));
            str=item and item:GetName() or "";
        elseif data.type==TipAargType.CardId then--代表为卡牌ID
            item=RoleMgr:GetData(tonumber(data.param));
            str=item and item:GetName() or "";
        elseif data.type==TipAargType.EquipId then--代表为装备ID
            -- item=BagMgr:GetData(tonumber(data.param));
            -- str=item and item:GetName() or "";
        elseif data.type==TipAargType.DupId then --副本id
            item=Cfgs.MainLine:GetByID(tonumber(data.param));
            str=item and item.name or ""
        elseif data.type==TipAargType.Role  then --卡牌id
            item=Cfgs.CfgCardRole:GetByID(data.param);
            str=item and item.sAliasName or ""
        elseif data.type==TipAargType.SectionId  then --章节id
            item =Cfgs.Section:GetByID(tonumber(data.param))
            str=item and item.name or ""
        else    --不对的参数类型
            LogError("不支持的参数类型:"..tostring(data.type));
        end
    end
    return str;
end

return this;