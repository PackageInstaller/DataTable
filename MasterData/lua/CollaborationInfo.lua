--回归绑定活动信息
local this={}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg=Cfgs.CfgBindActive:GetByID(cfgId);
        if self.cfg==nil then
            LogError("CfgBindActive中找不到对应ID："..tostring(cfgId).."的配置信息");
            do return end
        end
        self.stageCfg=Cfgs.CfgBindActiveStage:GetByID(cfgId);
        if self.stageCfg==nil then
            LogError("CfgBindActiveStage中找不到对应ID："..tostring(cfgId).."的配置信息");
            do return end
        end
    end
end

function this:SetData(data)
    self.openTime=nil;
    self.closeTime=nil;
    if data then
       if data.activeId then
            self:InitCfg(data.activeId);
       end
       if data.code and data.code~="" and self.cfg then --设置玩家类型
            local strs=StringUtil:split(data.code, "_");
            if strs and #strs>1 then
                for k,v in pairs(self.cfg.infos) do
                    if tostring(v.codePrefix)==strs[1] then
                        self.typeCfg=v;
                        self.plrType=k;
                        break;
                    end
                end
            end
       end
    end
    self.data=data;
end

function this:GetData()
    return self.data;
end

function this:GetID()
    return self.cfg and self.cfg.id or nil;
end

function this:GetName()
    return self.cfg and self.cfg.name or nil;
end

function this:GetPlrNum()
    return self.cfg and self.cfg.needPlrNum or 0;
end

function this:GetBindTypes()
    return self.cfg and self.cfg.bindTypes or nil;
end

--返回绑定奖励
function this:GetBindReward()
    return self.cfg and self.cfg.reward or nil;
end

--返回活动开始时间
function this:GetStartTime()
    return self.cfg and self.cfg.startTime or nil;
end

--返回活动结束时间
function this:GetEndTime()
    return self.cfg and self.cfg.endTime or nil;
end

--返回准备时间（分）
function this:GetPreTime()
    return self.cfg and self.cfg.preTime or 0;
end

--返回准备时间描述
function this:GetPreTimeDesc()
    local openTime=self:GetPreTimeStamp()
    if openTime then
        local tab=TimeUtil:GetTimeTab(openTime-TimeUtil:GetTime());
        return LanguageMgr:GetByID(61027,tab[1],tab[2],tab[3]);
    end
end

--返回准备时间结束的时间戳
function this:GetPreTimeStamp()
    local openTime=TimeUtil:GetTimeStampBySplit(self:GetStartTime());
    local preTime=self:GetPreTime();
    if preTime~=0 then
        openTime=openTime+preTime*60;
    end
    return openTime;
end

function this:GetStartTimeStamp()
    if self.openTime==nil and self:GetStartTime()~=nil and self:GetStartTime()~="" then
        self.openTime=TimeUtil:GetTimeStampBySplit(self:GetStartTime())
    end
    return self.openTime or 0;
end

function this:GetEndTimeStamp()
    if self.closeTime==nil and self:GetEndTime()~=nil and self:GetEndTime()~=""  then
        self.closeTime=TimeUtil:GetTimeStampBySplit(self:GetEndTime())
    end
    return self.closeTime or 0;
end

--是否开启
function this:IsOpen()
    local isOpen = false;
	local currentTime = TimeUtil:GetTime();
    local openTime=self:GetStartTimeStamp();
    local closeTime=self:GetEndTimeStamp();
	if openTime == 0 and closeTime == 0 then
		isOpen = true;
	elseif (openTime==0 or currentTime >= openTime) and (closeTime==0 or currentTime < closeTime) then
		isOpen = true;
	end
	return isOpen;
end 

function this:IsReadyTime()
    return self:GetPreTime()~=0 and TimeUtil:GetTime()<self:GetPreTimeStamp() or false;
end

--根据玩家类型获取不同的扩展信息（奖励、邀请码前缀）
function this:GetOtherInfoByType(memberType,key)
    local info =nil;
    if memberType and key and self.cfg then
        if self.cfg.infos[memberType] then
            info=self.cfg.infos[memberType][key]
        end
    end
    return info;
end

function this:GetDesc()
    -- return self.cfg and self.cfg.desc or nil;
    return LanguageMgr:GetByID(61002);
end

--返回绑定的其它玩家信息,人数不满上限的时候无法领取任务奖励
function this:GetBindPlayers()
    if self.data and self.data.plrs then
        return self.data.plrs
    end
    return nil;
end

--返回玩家类型
function this:GetPlrType()
    return self.plrType;
end

--是否完成绑定步骤（绑定人数是否等于活动人数上限-1）
function this:IsBindOver()
    local isBindOver=false;
    local needNum=self:GetPlrNum();
    if self.data and self.data.plrs then
        isBindOver=#self.data.plrs==(needNum-1) and true or false;
    end
    return isBindOver;
end

--返回申请次数
function this:GetApplyCnt()
    if self.data and self.data.applyCnt then
        return self.data.applyCnt 
    end
    return 0
end

--返回申请次数重置时间
function this:GetApplyResetTime()
    if self.data and self.data.applyResetTime then
        return self.data.applyResetTime 
    end
    return 0
end

--返回邀请码
function this:GetCode()
    local code=nil;
    if self.data and self.data.code then
        code=self.data.code
    end
    return code;
end

--返回UI上展示的邀请码
function this:GetCodeDesc()
    local codeStr=self:GetCode();
    if codeStr~=nil and codeStr~="" then
        local strs=StringUtil:split(codeStr, "_");
        if  self:GetPlrType()==eBindActivePlrType.Return then
            codeStr=LanguageMgr:GetByID(61028)
        elseif self:GetPlrType()==eBindActivePlrType.Acitve then
            codeStr=LanguageMgr:GetByID(61029)
        end
        if strs and #strs>1 then
            codeStr=codeStr..strs[2]
        end
    else
        codeStr=""
    end
    return codeStr;
end

--返回当前限制道具领取的数量
function this:GetLimitGoodsNum(goodsId)
    local num=0;
    if goodsId and self.data and self.data.taskGets then
        for k,v in pairs(self.data.taskGets) do
            if v.items and v.items[goodsId] then
                num=num+v.items[goodsId];
            end
        end
    end
    return num;
end

--是否超过限制道具的领取数量
function this:IsLimitFull()
    local limitInfo=self:GetLimitInfo()
    if limitInfo then
        local currNum=self:GetLimitGoodsNum(limitInfo[2]);
        if limitInfo[1]~=eBindLimitType.UnLimit and limitInfo[3]~=nil and limitInfo[3]<=currNum then
            return true
        end
    end
    return false;
end

--返回当前限制道具最大领取数量信息
function this:GetLimitInfo()
    if self.typeCfg then
        return self.typeCfg.taskRewardLimit;
    end
    return nil;
end

--打开对应商店
function this:GoShop()
    if self.typeCfg then
        CSAPI.OpenView("ShopView",self.typeCfg.shopid);
    end
end

--返回当前阶段
function this:GetStage()
    if self.data and self.data.stage then
        return self.data.stage
    else
        return 1;
    end
end

--是否最大阶段
function this:IsFullStage()
    local stage=self:GetStage()
    if self.stageCfg and stage>#self.stageCfg.infos then
        return true        
    end
    return false;
end

--返回当前阶段完成的任务数量
function this:GetStageTaskNum()
    return self.data and self.data.doneTaskNum or 0;
end

--返回当前阶段升级的配置信息
function this:GetCurrStageCfg()
    local currStage=self:GetStage()
    if self.stageCfg then
        if  #self.stageCfg.infos>=currStage then
            return self.stageCfg.infos[currStage]
        else
            return self.stageCfg.infos[#self.stageCfg.infos]
        end
    end
    return nil
end

function this:GetStageCfg()
    return self.stageCfg;
end

function this:GetStageCanRevice()
    local stage=self:GetStage()
    if self.stageCfg and stage>#self.stageCfg.infos then
        return false        
    end
    local taskNum=self:GetStageTaskNum();
    local cfg=self:GetCurrStageCfg();
    if cfg and cfg.nCount<=taskNum then
        return true;
    end
    return false;
end

function this:GetApplyLimit()
    return self.cfg and self.cfg.applyLimit or 0;
end

function this:CheckCodeFormat(code)
    if code and code~="" then
        local type=string.match(code,"%d+");
        local type2=string.match(self.data.code,"%d+");
        if type~=nil and  type2~=nil then
            for k,v in pairs(self.cfg.infos) do
                if tostring(v.codePrefix)==type and  type~=type2 then
                    return true
                end
            end
        end
    end
    return false;
end

return this;