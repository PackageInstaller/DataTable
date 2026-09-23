local this = {}
--皮肤商店使用的皮肤信息
function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId==nil then
        LogError("初始化皮肤信息失败！无效配置id");	
        return
    end
    if self.cfg==nil then
        self.cfg=Cfgs.CfgSkinInfo:GetByID(cfgId);
        if(self.cfg == nil) then		
			LogError("找不到皮肤信息配置！id = " .. cfgId);	
		end
    end
    if self.modelCfg==nil then
        self.modelCfg=Cfgs.character:GetByID(cfgId)
        if(self.modelCfg == nil) then		
			LogError("找不到模型配置！id = " .. cfgId);	
		end
    end
end

function this:GetModelCfg()
    return self.modelCfg
end

function this:GetSkinName()
    return self.modelCfg and self.modelCfg.desc or "";
end

function this:GetRoleName()
    return self.modelCfg and self.modelCfg.key or "";
end

function this:GetModelID()
    return self.modelCfg and self.modelCfg.id or nil;
end

function this:GetSeasonID()
    return self.cfg and self.cfg.season or nil;
end

function this:GetSeasonCfg()
    local sId=self:GetSeasonID();
    if sId~=nil then
        return Cfgs.CfgSkinSeasonEnum:GetByID(sId);
    end
    return nil;
end

function this:GetSetID()
    return self.cfg and self.cfg.setID or nil
end

function this:GetSetCfg()
    local sId=self:GetSetID();
    if sId~=nil then
        return Cfgs.CfgSkinSetInfo:GetByID(sId);
    end
    return nil;
end

function this:GetSort()
    return self.cfg and self.cfg.sort or nil
end

--活动跳转ID，如果有值则跳转到对应界面
function this:GetBuyInfo()
    return self.modelCfg and self.modelCfg.getCondition or nil
end

--获得途径类型和描述
function this:GetWayInfo(isShort)
    --读取跳转表的多语言ID
    local wayType=nil;
    local info=self:GetBuyInfo();
    local wayTips=nil;
    if info~=nil then
        local jumpCfg=Cfgs.CfgJump:GetByID(info[1]);
        if jumpCfg then
            wayTips=LanguageMgr:GetByID(jumpCfg.tag);
            if jumpCfg.tag==18054 then
                wayType=SkinGetType.Archive;
                wayTips=LanguageMgr:GetByID(18054);
            elseif jumpCfg.tag==18053 then
                wayType=SkinGetType.Store
                wayTips=LanguageMgr:GetByID(18053);
            elseif jumpCfg.tag==18055 then
                wayType=SkinGetType.Other;
                wayTips=LanguageMgr:GetByID(18055);
            end
        end
    else
        wayType=SkinGetType.None;
        if isShort then
            wayTips=LanguageMgr:GetByID(18057)
        else
            wayTips=LanguageMgr:GetByID(18056);
        end
    end
    return wayType,wayTips;
end

function this:GetDesc()
    return self.modelCfg and self.modelCfg.model_desc or ""
end

function this:GetSkinDesc()
    return self.modelCfg and self.modelCfg.skin_desc or ""
end

function this:GetChangeInfo()
    local modelCfg=self:GetModelCfg();
    local list=nil;
    if modelCfg and modelCfg.changeShowBtn then
        list={};
        for i=1,#modelCfg.changeShowBtn,2 do
            local type=modelCfg.changeShowBtn[i+1]==nil and SkinChangeResourceType.Spine or modelCfg.changeShowBtn[i+1];
            table.insert(list,{cfg=Cfgs.character:GetByID(modelCfg.changeShowBtn[i]),type=type});
        end
    end
    return list;
end

--是否有入场动画
function this:HasEnterTween()
    local has=false
    local modelCfg=self:GetModelCfg();
    if modelCfg and modelCfg.hadAni==1 then
        has=true;
    end
    return has
end

--是否有L2d
function this:HasL2D()
    local has=false
    local modelCfg=self:GetModelCfg();
    if modelCfg and modelCfg.l2dName then
        has=true;
    end
    return has
end

--是否包含模型
function this:HasModel()
    local has=false
    local modelCfg=self:GetModelCfg();
    if modelCfg and modelCfg.hadModel then
        has=modelCfg.hadModel==1;
    end
    return has
end

function this:HadLive2D()
    local has=nil --表示没找到
    local modelCfg=self:GetModelCfg();
    if modelCfg and modelCfg.hadLive2D then
        has=modelCfg.hadLive2D;
    end
    return has
end

--是否包含特殊标签
function this:HasSpecial()
    local has=false
    local modelCfg=self:GetModelCfg();
    if modelCfg and modelCfg.hadSpecial then
        has=modelCfg.hadSpecial==1;
    end
    return has
end

--- 1.正常的图（售前隐藏，需要判断在售时间+是否拥有）
-- 2.和谐的图（售前隐藏，售后常驻显示）
-- 3.一定隐藏
function this:GetHideType()
    return self.cfg and self.cfg.hideType or false;
end

function this:GetCardHead()
    return self.modelCfg and self.modelCfg.Card_head or nil;
end

--返回当前限时的Tag Icon名 
function this:GetTagIcons()
    local icons=nil;
    local hadL2d=self:HadLive2D();
    local oStr="img_07_"
    local lIds=nil;
    if self:HasSpecial() then
        icons=icons or {};
        lIds=lIds or {}
        table.insert(icons,oStr.."03");
        table.insert(lIds,18146);
    end
    if self:HasModel() then
        icons=icons or {};
        lIds=lIds or {}
        table.insert(icons,oStr.."04");
        table.insert(lIds,18145);
    end
    if hadL2d~=nil then
        local iconName=nil;
        local lId=nil;
        if hadL2d==1 then
            iconName="02";
            lId=18142
        elseif hadL2d==2 then
            iconName="06";
            lId=18143
        elseif hadL2d==3 then
            iconName="05";
            lId=18144
        end
        icons=icons or {};
        lIds=lIds or {}
        table.insert(icons,oStr..iconName);
        table.insert(lIds,lId);
    end
    return icons,lIds;
end

function this:GetCardCfg()
    local cfg=nil
    if self.modelCfg~=nil then
        cfg=Cfgs.CardData:GetByID(self.modelCfg.card_id);
    end
    return cfg;
end

--返回对应卡牌的品质
function this:GetSortQuality()
    local cfg=self:GetCardCfg();
    local quality = cfg and cfg.quality or 1;
    return quality > 6 and 6 or quality
end

--返回对应卡牌所属阵营
function this:GetCamp()
    local cfg=self:GetCardCfg();
    return cfg and cfg.nClass or 1
end

--购买后显示奖励框时的提示
function this:GetShowTips(isBuy)
    local unlockVoice=self:UnlockVoice();
    local str=nil;
    if unlockVoice then
        local voiceCfg=Cfgs.Sound:GetByID(unlockVoice[1]);
        local name=""
        if voiceCfg~=nil then
            local model2=Cfgs.character:GetByID(voiceCfg.model);
            -- if RoleSkinMgr:CheckModelsIsGet({voiceCfg.model})~=true then --不管获不获得都弹
            --     return str;
            -- end
            name=model2.key
        end
        str=LanguageMgr:GetByID(isBuy==true and 18202 or 18204,name,self:GetSkinName(),self:GetRoleName());
    end
    return str;
end

--购买后解锁的语音ID
function this:UnlockVoice()
    local modelCfg=self:GetModelCfg();
    if modelCfg and modelCfg.unlockVoice then
        if #modelCfg.unlockVoice>1 then
            return modelCfg.unlockVoice[PlayerClient:GetSex()];--1是男，2是女
        end
        return modelCfg.unlockVoice[1];
    end
end

return this;