--角色物品数据

local this =oo.class(GridDataBase);
--设置角色物品信息
function this:Init(characterData)
    if characterData then
        self.data = characterData;
        self:InitCfg(self.data.cfgId);

        local modelId = self.data.modelId or (self.cfg and self.cfg.model);
        if(modelId)then
            self:InitModel(modelId);
        end
    end
end
--初始化配置
function this:InitCfg(cfgId)
    if(cfgId == nil)then
        LogError("初始化物品配置失败！无效配置id");        
    end

    if(self.cfg == nil)then        
        self.cfg = Cfgs.CardData:GetByID(cfgId);
        if(self.cfg == nil)then        
            self.cfg = Cfgs.MonsterData:GetByID(cfgId);
            if(self.cfg == nil)then        
                LogError("找不到怪物配置！id = " .. cfgId);    
            end
        end        
    end
end

--初始化模型配置
function this:InitModel(modelId)
    if(modelId == nil)then
        return;
    end
    self.cfgModel = Cfgs.character:GetByID(modelId);
end

--获取id
function this:GetID()
    return self.data.id or -1;
end
--获取数据
function this:GetData()
    return self.data;
end
--获取配置
function this:GetCfg()
    return self.cfg;
end
--获取类型
function this:GetType()
    return self.cfg and self.cfg.type or 0;
end

--获取类型
function this:GetName()
    return self.cfg and self.cfg.name .. "";
end
--获取数量
function this:GetCount()
    return 1;
end
--获取等级
function this:GetLv()
    return self.data.lv or 1;
end
--获取品质
function this:GetQuality()
    return self.cfg and self.cfg.quality or 1;
end
--获取图标
function this:GetIcon()
    if(self.cfgModel)then
        return self.cfgModel.head or self.cfgModel.name;
    end

    return nil;
end

--获取模型配置
function this:GetModelCfg()
    return self.cfgModel;
end
--获取占位
function this:GetPlaceHolderInfo()
    if(self.placeHolderInfo == nil)then
        if(self.cfg.grids)then
            local cfgFormation = Cfgs.MonsterFormation:GetByID(self.cfg.grids);
            if(cfgFormation)then
                self.placeHolderInfo  = {};
                for _,v in ipairs(cfgFormation.coordinate)do
                    table.insert(self.placeHolderInfo,{v[1] + 1,v[2] + 1});
                end
            else
                LogError("MonsterFormation找不到占位数据" .. self.cfg.grids);
            end
        else
            self.placeHolderInfo = {{1,1}};
        end
    end

    return self.placeHolderInfo;
end

function this:GetClassType()
    return "CharacterGoodsData"
end

function this:GetIconLoader()
    return ResUtil.Card
end

return this;