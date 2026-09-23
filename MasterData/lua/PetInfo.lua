--宠物信息

local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg=Cfgs.CfgPet:GetByID(cfgId);
        if self.cfg==nil then
            LogError("CfgPet中找不到对应ID："..tostring(cfgId).."的配置信息");
        end
        if self.cfg.feedReward then
            self.feedRewardCfg=Cfgs.CfgPetFeedReward:GetByID(self.cfg.feedReward);
        else
            LogError("CfgPet中未配置feedReward值！");
        end
        if self.cfg.word then
            self.wordCfg=Cfgs.CfgPetWord:GetByID(self.cfg.word);
        end
    end
end

function this:SetData(_d)
    self.data=_d;
    --初始化当前阶段的奖励
    if self.data then
        self:InitCfg(self.data.id);
    end
    self:CountAttr();
end

function this:GetData()
    return self.data or nil;
end

function this:GetID()
    return self.cfg and self.cfg.id or 0;
end

function this:GetNO()
    return self.cfg and self.cfg.sort or 0;
end

function this:GetNONumb()
    local num=self.cfg and self.cfg.sort or 1
    local str="";
    if num>9 then
        str=LanguageMgr:GetByID(62037)..num;
    else
        str=LanguageMgr:GetByID(62037).."0"..num;
    end
    return str;
end

--返回气泡状态列表
function this:GetEmojis()
    local emojiCfgs=nil;
    for k, v in ipairs(Cfgs.CfgPetState:GetAll()) do
        if v.attribute then
            local isPass=false;
            for _, val in ipairs(v.attribute) do
               isPass=self:CheckAttr(val,v.judge,v.value);
               if isPass~=true then
                    break;
               end
            end
            if isPass then
                emojiCfgs=emojiCfgs or {};
                table.insert(emojiCfgs,v);
            end
        end
    end
    return emojiCfgs;
end

--根据条件类型和运算符判断值是否符合条件
function this:CheckAttr(_attrType,_optionType,_percent)
    local isPass=false;
    if _attrType==nil or _optionType==nil or _percent==nil then
        return isPass;
    end
    local currPercent=0;
    if _attrType==PetStateAttrType.Happy then
        currPercent=self:GetHappyPercent();
    elseif _attrType==PetStateAttrType.Wash then
        currPercent=self:GetWashPercent();
    elseif _attrType==PetStateAttrType.Food then
        currPercent=self:GetFoodPercent();
    elseif _attrType==PetStateAttrType.Life then
        currPercent=self:GetExpPercent();
    end
    if _optionType==PetStateOption.Greater then
        isPass=math.floor(currPercent*100)>_percent;
    elseif _optionType==PetStateOption.GreaterOrEqual then
        isPass=math.floor(currPercent*100)>=_percent;
    elseif _optionType==PetStateOption.Equal then
        isPass=math.floor(currPercent*100)==_percent;
    elseif _optionType==PetStateOption.Less then
        isPass=math.floor(currPercent*100)<_percent;
    elseif _optionType==PetStateOption.LessOrEqual then
        isPass=math.floor(currPercent*100)<=_percent;
    end
    return isPass;
end

function this:GetDefaultAction()
    --根据时间点获取默认状态
    local time=TimeUtil:GetBJTime();
    local tab=TimeUtil:GetTimeHMS(time)
    if tab and (tab.hour==12 or tab.hour>23 or tab.hour<6) then
        return PetTweenType.sleep;
    end
    return PetTweenType.idle;
end

function this:GetExpPercent()
    return self:GetStageExp()/self:GetMaxExp();
end

function this:GetExpPercentDesc()
    return math.floor(100*self:GetExpPercent()+0.5).."%";
end

--返回默认动作
function this:GetCurrAction()
    --判断是否在运动中
    local sport=self:GetSport();
    if sport and sport~=0 then
        --根据运动中的数据获取状态
        if sport==PetSportType.Move then
            return PetTweenType.walk
        elseif sport==PetSportType.Run then
            return PetTweenType.sport
        end
    end
    return self:GetDefaultAction();
end

--返回当前宠物运动持续时长（秒钟）
function this:GetKeepTime()
    -- return self.data and self.data.keep_time or 0;
    if self.data and self.data.keep_time and self:GetCurrSportStartTime()~=0 then
        local sTime=self:GetCurrSportStartTime()+self.data.keep_time;
        local time=TimeUtil:GetTime()
        if sTime>time then
            return sTime-time;
        end
        -- local kTime=self.data.keep_time
        -- if sTime~=0 and kTime~=0 then
        --     local time=TimeUtil:GetTime()-sTime;
        --     return kTime-time;
        -- end
    end
    return 0
end

--返回当前运动开始时间
function this:GetCurrSportStartTime()
    return self.data and self.data.start_time or 0;
end

--返回当前运动场景，为0时则没有运动
function this:GetScene()
    return self.data and self.data.scene or 0;
end

--返回养成阶段
function this:GetStage()
    local exp=self:GetStageExp();
    if self.feedRewardCfg then
        for k,v in ipairs(self.feedRewardCfg.infos) do
            if v.feedNum>exp then
                return v.index;
            end
        end
    end
    return 0;
end

function this:GetStageReward(stage)
    if self.feedRewardCfg and self.feedRewardCfg.infos and self.feedRewardCfg.infos[stage] then
        return self.feedRewardCfg.infos[stage].reward;
    end
    return nil;
end

--返回当前经验值相对于目标阶段的百分比
function this:GetStagePercent(stage)
    local percent=0;
    local stageExp=self:GetStageExp();
    if self.feedRewardCfg and stageExp>0 then
        local upExp=0;
        for k,v in ipairs(self.feedRewardCfg.infos) do
            if stage==v.index then
                percent=stageExp/(v.feedNum-upExp);
                break;
            end
            stageExp=stageExp-(v.feedNum-upExp)>0 and stageExp-(v.feedNum-upExp) or 0;
            upExp=v.feedNum;
            if stageExp==0 then
                break;
            end
        end
    end
    return percent;
end

--返回当前阶段相对总经验的百分比
function this:GetStageTips(stage)
    local percent="0%";
    if self.feedRewardCfg then
        local upExp=0;
        for k,v in ipairs(self.feedRewardCfg.infos) do
            if stage==v.index then
                percent=math.floor(v.feedNum/self.feedRewardCfg.infos[#self.feedRewardCfg.infos].feedNum*100).."%";
                break;
            end
        end
    end
    return percent;
end

--返回养成值
function this:GetStageExp()
    return self.data and self.data.feed or 0;
end

--是否领取过该阶段的奖励了
function this:IsStageRevice(stage)
    if stage and self.data and self.data.idx>=stage then
        return true;
    end
    return false;
end

function this:GetMaxExp()
    local exp=0;
    if self.feedRewardCfg then
        exp=self.feedRewardCfg.infos[self:GetMaxStage()].feedNum;
    end
    return exp;
end

--返回最大养成阶段
function this:GetMaxStage()
    return self.feedRewardCfg and #self.feedRewardCfg.infos or 0;
end

function this:GetPrefabPath()
    return self.cfg and self.cfg.prefabName or nil;
end

function this:GetSceneName()
    local sport=self:GetSport();
    local sceneName=nil;
    if sport and sport~=0 then
        local scene=self:GetScene();
        local cfg=Cfgs.CfgPetSport:GetByID(scene);
        sceneName=cfg.picture;
    end
    if sceneName==nil or sceneName=="" then
        return self.cfg and self.cfg.scene or "bg_89";
    end
    return sceneName;
end

--名字
function this:GetName()
    return self.cfg and self.cfg.name or "";
end

function this:GetItem()
    return self.cfg.item and self.cfg.item or nil;
end

--是否解锁该宠物
function this:IsLock()
    local isLock=true;
    local pet=PetActivityMgr:GetPet(self:GetID());
    if pet and pet:GetData()~=nil then
        isLock=false;
    end
    -- if self.cfg and self.cfg.item then
    --     local item=BagMgr:GetData(self.cfg.item);
    --     if item and item:GetCount()>0 then
    --         isLock=false;
    --     end
    -- end
    return isLock;
end

function this:GetIcon()
    return self.cfg and self.cfg.picture or nil;
end

function  this:GetTxt()
    return self.cfg and self.cfg.getTxt or nil;
end

--返回动画名称
function this:GetTweenName(petTween)
    if petTween ~=nil and petTween~="" then
        local cfg=Cfgs.CfgPetRes:GetByID(self:GetID());
        if cfg and cfg[petTween] then
            return cfg[petTween],cfg[petTween.."Pos"] 
        end
    end
    return  nil;
end

--返回播放时循环次数
function this:GetTweenCount(petTween)
    if petTween ~=nil and petTween~="" then
        local cfg=Cfgs.CfgPetRes:GetByID(self:GetID());
        if cfg and cfg[petTween.."Time"] then
            return cfg[petTween.."Time"]
        end
    end
    return -1;
end

--返回运动类型
function this:GetSport()
    if self.data==nil or self.data.sport==nil or self.data.sport==0 then
        return 0;
    end
    if self:GetKeepTime()<=0 then
        self:CountAttr();
        self.data.sport=0;
    end
    return self.data.sport;
end

function this:GetLastTime()
    return self.data and self.data.last_time or 0;
end

function this:GetNextCountTime()
    if self.data then
        return self:GetLastTime()+self:GetIntervalTime();
    else
        return 0;
    end
end

--计算当前能力值
function this:CountAttr()
    if self.data==nil then
        -- self.nowHappy=0
        -- self.nowWash=0
        -- self.nowFood=0
        do return end
    end
    self.data=GCalHelp:CalPetAbility(self.data,TimeUtil:GetTime());
    -- LogError("养成值："..tostring(self:GetStageExp()))
    -- local time=TimeUtil:GetTime();
    -- local lastTime=self:GetLastTime();
    -- if lastTime>=time then
    --     do return end;
    -- end
    -- local intervalTime=self:GetIntervalTime();
    -- local num=math.floor((time-lastTime)/intervalTime);
    -- if num>0 then
    --     self.nowHappy=self.data.happy-num*self:GetHappyDown()>0 and self.data.happy-num*self:GetHappyDown() or 0;
    --     self.nowWash=self.data.wash-num*self:GetWashDown()>0 and self.data.wash*self:GetWashDown()-num or 0;
    --     self.nowFood=self.data.food-num*self:GetFoodDown()>0 and self.data.food*self:GetFoodDown()-num or 0;
    -- end
end

--返回值刷新间隔时间
function this:GetIntervalTime()
    return self.cfg and self.cfg.interval or 30;
end

function this:GetHappyDown()
    return self.cfg and self.cfg.happyDown or 1;
end

function this:GetFoodDown()
    return self.cfg and self.cfg.foodDown or 1;
end

function this:GetWashDown()
    return self.cfg and self.cfg.washDown or 1;
end

function this:GetHappy()
    -- return self.nowHappy or 0;
    return self.data and self.data.happy or 0;
end

function this:GetHappyPercent()
    local num=self:GetHappy()/self:GetFullHappy()
    if num~=0 and math.floor(num*100)==0 then
        return 0.01
    else
        return num
    end
end

function this:GetWash()
    -- return self.nowWash or 0;
    return self.data and self.data.wash or 0;
end

function this:GetWashPercent()
    -- return self:GetWash()/self:GetFullWash();
    local num=self:GetWash()/self:GetFullWash()
    if num~=0 and math.floor(num*100)==0 then
        return 0.01
    else
        return num
    end
end

function this:GetFood()
    -- return self.nowFood or 0;
    return self.data and self.data.food or 0;
end

function this:GetFoodPercent()
    -- return self:GetFood()/self:GetFullFood();
    local num=self:GetFood()/self:GetFullFood()
    if num~=0 and math.floor(num*100)==0 then
        return 0.01
    else
        return num
    end
end

function this:GetFullHappy()
    return self.cfg and self.cfg.happyMax or 100;
end

function this:GetFullFood()
    return self.cfg and self.cfg.foodMax or 100;
end

function this:GetFullWash()
    return self.cfg and self.cfg.washMax or 100;
end

function this:GetWordInfo(tweenType,triggerType)
    if tweenType and self.wordCfg then
        local num=CSAPI.RandomInt(1,100);
        local key=num%2==1 and "word1" or "word2"
        for k, v in ipairs(self.wordCfg.infos) do
            if v.animation and v.animation==tweenType and v.trigger==triggerType then
                return v[key],v.time,v.holdTime;
            end
        end
    end
    return nil;
end

function this:GetHoldTime(tweenType)
    if tweenType and self.wordCfg then
        for k, v in ipairs(self.wordCfg.infos) do
            if v.animation and v.animation==tweenType and v.holdTime~=nil then
                return v.holdTime;
            end
        end
    end
end

return this;