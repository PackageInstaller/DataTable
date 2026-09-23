--宠物活动管理类
local this = MgrRegister("PetActivityMgr")

function this:Init()
    self:Clear()
    self.pets={}
    self.headsData={
        {id=PetHeadType.All,lId=62009},
        {id=PetHeadType.Food,lId=62010,type=PetItemType.Food},
        {id=PetHeadType.Wash,lId=62011,type=PetItemType.Wash,condId=1,lID=42014},
        {id=PetHeadType.Toy,lId=62012,type=PetItemType.Toy,condId=2,lID=42015},
    }
    for k,v in ipairs(Cfgs.CfgPet:GetAll()) do
        local pet=PetInfo.New();
        pet:InitCfg(v.id);
        self.pets[v.id]=pet;
    end
    self.unLockNum=0;
    self.reviceNum=0;
    self.unLockPetList=FileUtil.LoadByPath("PetActivity");--已解锁的宠物列表，读取本地缓存
    if self.unLockPetList==nil then
        self.unLockPetList={};
        for k,v in pairs(self.pets) do
            if v:IsLock()~=true or v:GetItem()==g_DefaultPet then
                self:AddUnLockPetList(v:GetID());
            end
        end
    end
    SummerProto:PetInfo();
end

function this:AddUnLockPetList(pid)
    self.unLockPetList=self.unLockPetList or {}
    if pid then
        local has=false;
        for k,v in ipairs(self.unLockPetList) do
            if v==pid then
                has=true;
                break;
            end
        end
        if has~=true then
            table.insert(self.unLockPetList,pid);
            self:ChecekRedInfo();
        end
    end
end

function this:OnActivityDataRet(proto)
    if proto then
        self.unLockNum=0;
        self.reviceNum=0;
        if proto.info then
            for k,v in ipairs(proto.info) do
                self:OnPetUpdate(v);
            end
        end
        self:SetCurrPet(proto.cur_pet);
        if proto.locked then
            for k, v in ipairs(proto.locked) do
                self:UpdateUnLockList(v);
            end
        end
        if proto.gained then
            for k, v in ipairs(proto.gained) do
                self:UpdateReviceList(v);
            end
        end
        self:UpdateNextRandom(proto);
        self:SetHasRandReward(proto.haveReward);
    end
end

function this:UpdateNextRandom(proto)
    if proto then
        self.tNextRandom=proto.tNextRandom;
    end
end

function this:GetPet(id)
    if id and self.pets and self.pets[id] then
        local pet=self.pets[id];
        return self.pets[id];
    else
        return nil;
    end
end

function this:CountPetAttr(id)
    if id and self.pets and self.pets[id] then
        self.pets[id]:CountAttr();
    end
end

function this:SetCurrPet(id)
    if id and self.pets and self.pets[id] then
        self.currPet=self.pets[id];
    else
        self.currPet=nil;
    end
end

--更新宠物领取信息
function this:UpdatePetRevice(proto)
    local curPet=self:GetCurrPetInfo();
    if curPet==nil then
        LogError("UpdatePetRevice Error:curPet is Nil");
        do return end
    end
    if proto==nil or proto.idx==nil then
        LogError("UpdatePetRevice Error:proto is Nil");
        do return end
    end
    local data=curPet:GetData();
    data.idx=proto.idx
    curPet:SetData(data);
    self.pets[curPet:GetID()]=curPet;
end

function this:UpdatePetGiftRevice(proto)
    local curPet=self:GetCurrPetInfo();
    if curPet==nil then
        LogError("UpdatePetRevice Error:curPet is Nil");
        do return end
    end
    if proto==nil or proto.reward_time==nil then
        LogError("UpdatePetRevice Error:proto is Nil");
        do return end
    end
    local data=curPet:GetData();
    data.reward_time=proto.reward_time
    curPet:SetData(data);
    self.pets[curPet:GetID()]=curPet;
end

function this:UpdateUnLockList(id)
    self.bookUnLockList[id]=1;
    self.unLockNum=self.unLockNum+1;
end

function this:UpdateReviceList(id)
    self.bookReviceList[id]=1;
    self.reviceNum=self.reviceNum+1;
end

function this:OnSwitchPet(proto)
    if proto and proto.cur_pet then
        PetActivityMgr:SetCurrPet(proto.cur_pet);
        --更新下次随机礼物时间
        self.tNextRandom=proto.tNextRandom;
    end
end

function this:OnPetUpdate(sPet)
    if sPet and self.pets and self.pets[sPet.id] then
        local pet=self.pets[sPet.id];
        pet:SetData(sPet);
        self.pets[sPet.id]=pet;
    elseif sPet then
        self.pets =self.pets or {}
        local pet=PetInfo.New();
        pet:InitCfg(sPet.id);
        pet:SetData(sPet);
        self.pets[sPet.id]=pet;
    end
end

function this:GetCurrPetInfo()
    return self.currPet or nil;
end

--返回下次宠物状态变更的时间戳
function this:GetEmotionChangeTimestamp()
    local timestamp=nil;
    local pet=self:GetCurrPetInfo();
    if pet then
        if self.emotionTimestamp then
            timestamp=self.emotionTimestamp+pet:GetIntervalTime();
        else
            timestamp=TimeUtil:GetTime()+pet:GetIntervalTime();
        end
        self.emotionTimestamp=timestamp;
    end
    return timestamp;
end

function this:GetAllSportInfos()
    local list={};
    for k,v in ipairs(Cfgs.CfgPetSport:GetAll()) do
        local info=PetSportInfo.New();
        info:InitCfg(v.id);
        table.insert(list,info);
    end
    return list;
end

function this:GetAllPets()
    local list=nil;
    if self.pets then
        list={}
        for k,v in pairs(self.pets) do
            table.insert(list,v);
        end
        table.sort(list,function(a,b)
            return a:GetNO()<b:GetNO();
        end);
    end
    return list;
end

--根据类型获取宠物道具
function this:GetPetItemDataByType(cType)
    local datas=BagMgr:GetDataByType(ITEM_TYPE.PROP,PROP_TYPE.PetItem);
    if datas then--二次筛选
        local list={};
        local cfgId=nil;
        for k,v in ipairs(datas) do
            cfgId=v:GetDyVal2();
            if cfgId then
                local item=PetItemData.New();
                item:InitCfg(cfgId);
                if cType==nil then
                    table.insert(list,item);
                elseif item:GetCfg() and item:GetType2()==cType then
                    table.insert(list,item);
                elseif item:GetCfg()==nil then
                    LogError("CfgPetItem中找不到对应ID："..tostring(cfgId).."的配置信息");                    
                end
            end     
        end
        if #list>0 then
            table.sort(list,function(a,b)
                if a:GetSort()==b:GetSort() then
                    return a:GetID()<b:GetID();
                else
                    return a:GetSort()<b:GetSort();
                end
            end);
        end
        datas=list;
    end
    return datas
end

function this:GetPetCommodityByType(cType)
    local pageData=ShopMgr:GetPageByID(908);
    if pageData==nil then
        return {};
    end
    local datas=pageData:GetCommodityInfos(true);
    if cType~=nil then--二次筛选
        local list={};
        local cfgId=nil;
        local cL=nil;
        for k,v in ipairs(datas) do
            cL=v:GetCommodityList()
            if cL then
                cfgId=cL[1].data:GetDyVal2();
                if cfgId then
                    local cfg=Cfgs.CfgPetItem:GetByID(cfgId);
                    if cfg and cfg.type==cType then
                        table.insert(list,v);
                    elseif cfg==nil then
                        LogError("CfgPetItem中找不到对应ID："..tostring(cfgId).."的配置信息");                    
                    end
                end     
            end
        end
        datas=list;
    end
    if datas then
        table.sort(datas,function(a,b)
            if a:GetSort()==b:GetSort() then
                return a:GetID()<b:GetID();
            else
                return a:GetSort()<b:GetSort();
            end
        end);
    end
    return datas,pageData;
end

--返回图鉴信息列表
function this:GetArchiveInfo(headType)
    if self.archives==nil then
        self.archives={}
        for k,v in pairs(Cfgs.CfgPetArchive:GetAll()) do
            local info=PetArchiveInfo.New();
            info:InitCfg(v.id);
            table.insert(self.archives,info);
        end
        table.sort(self.archives,function(a,b)
            return a:GetNO()<b:GetNO();
        end);
    end
    return  self.archives;
end

--返回图鉴奖励信息列表
function this:GetArchiveRewardInfo()
    if self.archiveRewards==nil then
        self.archiveRewards={}
        for k,v in pairs(Cfgs.CfgPetArchiveReward:GetAll()) do
            local info=PetArchiveRewardInfo.New();
            info:InitCfg(v.id);
            table.insert(self.archiveRewards,info);
        end
        table.sort(self.archiveRewards,function(a,b)
            return a:GetID()<b:GetID();
        end);
    end
    return self.archiveRewards;
end

--道具是否解锁
function this:ItemIsLock(id)
    local isLock=true;
    if id and self.bookUnLockList and self.bookUnLockList[id] then
        isLock=false;
    end
    return isLock;
end

--图鉴奖励是否领取
function this:BookIsLock(id)
    local isLock=true;
    if id and self.bookReviceList and self.bookReviceList[id] then
        isLock=false
    end
    return isLock
end

function this:SetDisUse(isDis)
    self.isDisState=isDis;
end

function this:GetDisUse()
    return self.isDisState or false;
end

function this:GetHeadsData()
    local list={};
    for k,v in ipairs(self.headsData) do
        if v.condId then
            local cfg=Cfgs.CfgPetOpenConditionMore:GetByID(v.condId);
            if cfg then
                v.isLock=not MenuMgr:CheckConditionIsOK(cfg.conditions);
            end
        end
        table.insert(list,v);
    end
    return list;
end

function this:CheckCanSport(petID,sprotInfo,sportType)
    if petID and sprotInfo and sportType then
        local pet=self:GetPet(petID);
        local lID=0;
        if pet then
            local washChange=sprotInfo:GetWashChange(sportType);
            local happyChange=sprotInfo:GetHappyChange(sportType);
            local foodChange=sprotInfo:GetFoodChange(sportType);
            if happyChange and happyChange<0 and pet:GetHappy()<math.abs(happyChange) then
                lID=42012
            elseif washChange and washChange<0 and pet:GetWash()<math.abs(washChange) then
                lID=42011
            elseif foodChange and foodChange<0 and pet:GetFood()<math.abs(foodChange) then
                lID=42010
            end
            if lID==0 then
                return true;
            else
               Tips.ShowTips(LanguageMgr:GetTips(42005,LanguageMgr:GetTips(lID)));
            end
        end
    end
    return false;
end

function this:GetUnLockNum()
    return self.unLockNum or 0;
end

function this:GetReviceNum()
    return self.reviceNum or 0;
end

function this:GetNextRewardTime()
    return self.tNextRandom or 0;
end

function this:SetHasRandReward(hasReward)
    self.haveReward=hasReward;
end

function this:HasRandReward()
    return self.haveReward or false;
end

--返回红点消息
function this:ChecekRedInfo()
    local redInfo=nil
    local list=self:GetArchiveRewardInfo();
    if list then
        for k,v in ipairs(list) do
            if v:GetState()==2 then
                redInfo=redInfo or {};
                redInfo.hasBook=true;
                break;
            end
        end
    end
    if self.pets and self.unLockPetList ~= nil then
        for k, v in pairs(self.pets) do
            if v:IsLock() ~= true then
                local has = false;
                for _, val in pairs(self.unLockPetList) do
                    if v:GetID() == val then
                        has = true;
                        break
                    end
                end
                if has ~= true then
                    redInfo = redInfo or {};
                    redInfo.newPets = redInfo.newPets or {};
                    table.insert(redInfo.newPets, v:GetID());
                end
            end
        end
    end
    if self.haveReward or (self.tNextRandom>0 and TimeUtil:GetTime()>=self.tNextRandom) then
        redInfo=redInfo or {};
        redInfo.hasRand=true;
        if self.pets then
            for k,pet in pairs(self.pets) do
                for i=1,pet:GetStage() do
                    local val=pet:GetStagePercent(i);
                    if val>=1 and pet:IsStageRevice(i)~=true then
                        redInfo.hasFeed=true;
                        break;
                    end
                end
            end
        end
    end
    RedPointMgr:UpdateData(RedPointType.ActiveEntry16,redInfo);
end

--是否视为idle状态
function this:IsIdleState(state)
    if state==PetTweenType.idle or state==PetTweenType.move then
        return true;
    end
end

--返回宠物运动中下一次更新属性时间戳
function this:GetPetSportIntervalTimeStamp(pet)
    if pet then
        local scene=pet:GetScene();
        if scene~=0 then
            local sportInfo=PetSportInfo.New();
            sportInfo:InitCfg(scene);
            if sportInfo then
                return pet:GetCurrSportStartTime()+sportInfo:GetIntervalTime();
            end
        end
    end
    return 0;
end

function this:SaveUnLockList()
    FileUtil.SaveToFile("PetActivity",self.unLockPetList); --存储解锁列表
end

function this:IsOver()
    local cfg=Cfgs.CfgActiveEntry:GetByID(16);
    local curTime=TimeUtil:GetTime();
    local begTime,endTime=nil,nil;
    if cfg then
        begTime=cfg.begTime and TimeUtil:GetTimeStampBySplit(cfg.begTime) or nil;
        endTime=cfg.endTime and TimeUtil:GetTimeStampBySplit(cfg.endTime) or nil;
    end
    if (begTime == nil or curTime > begTime) then
        if (endTime == nil or curTime < endTime) then
            return false
        end
    end
    return true
end

function this:Clear()
    self.currPet=nil;
    self.pets=nil;
    self.archiveRewards=nil;
    self.archives=nil;
    self.headsData=nil;
    self.bookUnLockList={};
    self.bookReviceList={};
    self.unLockNum=0;
    self.reviceNum=0;
    self.tNextRandom=0;
    self.haveReward=false;
    self.isDisState=false;
    self.emotionTimestamp=nil;
    self.unLockPetList=nil;
end

function this:MenuLTime()
    local begTime,endTime
    local cfg = Cfgs.CfgActiveEntry:GetByID(16);
    if cfg then
        begTime = cfg.begTime and TimeUtil:GetTimeStampBySplit(cfg.begTime) or nil;
        endTime = cfg.endTime and TimeUtil:GetTimeStampBySplit(cfg.endTime) or nil;
    end
    return begTime,endTime
end

return this;