--商店推荐页配置
local this = {}

function this.New()
    this.__index = this.__index or this
    local tab = {}
    setmetatable(tab, this)
    return tab
end

function this:SetCfg(cfgId)
    if (cfgId == nil) then
        LogError("初始化商品推荐数据失败！无效配置id")
    end
    if (self.cfg == nil) then
        self.cfg = Cfgs.CfgShopReCommend:GetByID(cfgId)
        if (self.cfg == nil) then
            LogError("找不到商品推荐数据！id = " .. cfgId)
        end
    end
end

function this:GetCfgID() return self.cfg and self.cfg.id or nil end

-- 返回显示类型
function this:GetShowType() return self.cfg and self.cfg.showType or 1 end


function this:GetImg()
    local idx=self:GetIndex();
    if self.cfg and self.cfg.img and #self.cfg.img>=idx then
        return self.cfg.img[idx]
    end
    return nil;
end

function this:GetJumpID()
    local idx=self:GetIndex();
    if self.cfg and self.cfg.sJumpID and #self.cfg.sJumpID>=idx then
        return self.cfg.sJumpID[idx]
    end
    return nil;
end

function this:GetCommID()
    local idx=self:GetIndex();
    if self.cfg and self.cfg.commID and #self.cfg.commID>=idx then
        return self.cfg.commID[idx]
    end
    return nil;
end

--判断当前的购买下标
function this:GetIndex()
    local idx=1;
    local cfg=self.cfg;
    if cfg and cfg.commID then
        local tempIdx=1;
        for k, v in ipairs(cfg.commID) do
            local comm=ShopMgr:GetFixedCommodity(v);
            local buyNum=-1
            if self.cfg and self.cfg.buyNum and k<=#self.cfg.buyNum then
                buyNum=self.cfg.buyNum[k]
            end
            if comm and ((buyNum~=-1 and comm:GetBuyCount()>=buyNum) or (buyNum==-1 and comm:IsOver())) then
                tempIdx=k;
            end
        end
        if tempIdx~=-1 then
            idx=tempIdx+1>=#cfg.commID and #cfg.commID or tempIdx+1;
        else
            idx=1;
        end
    end
    return idx;
end

function this:GetTabID()
    return self.cfg and self.cfg.group or nil;
end

function this:GetStartTime()
    local time = 0;
	if self.cfg and self.cfg.startTime ~= "" and self.cfg.startTime ~= nil then
		time = TimeUtil:GetTimeStampBySplit(self.cfg.startTime)
	end
	return time;
end

function this:GetEndTime()
    local time = 0;
	if self.cfg and self.cfg.endTime ~= "" and self.cfg.endTime ~= nil then
		time = TimeUtil:GetTimeStampBySplit(self.cfg.endTime)
	end
	return time;
end

function this:GetSort()
    return self.cfg and self.cfg.sort or 1000;
end

--返回当前推荐商品是否已经购买过
function this:IsBuy()
    local isBuy=false;
    local idx=self:GetIndex();
    local commId=nil;
    local buyNum=-1;
    if self.cfg and self.cfg.commID and idx<=#self.cfg.commID then
        commId=self.cfg.commID[idx]
    end
    if self.cfg and self.cfg.buyNum and idx<=#self.cfg.buyNum then
        buyNum=self.cfg.buyNum[idx]
    end
    if commId then
        local comm=ShopMgr:GetFixedCommodity(commId);
        if comm and ((buyNum~=-1 and comm:GetBuyCount()>buyNum) or  (buyNum==-1 and comm:IsOver()) or (comm:GetType()==CommodityItemType.MonthCard and comm:GetMonthCardCanBuy()~=true)) then
            isBuy=true;
        end
    end
    return isBuy;
end

-- 返回当前时间段该推荐是否显示
function this:GetNowTimeCanShow()
    local canShow = true
    local currTime = TimeUtil:GetTime()
    local beginTime = self:GetStartTime()
    local endTime = self:GetEndTime()
    if (beginTime ~= 0 and currTime < beginTime) or
        (endTime ~= 0 and currTime >= endTime) then canShow = false end
    return canShow
end

--返回跳转信息
function this:GetJumpInfo()
    local jumpInfo=nil;
    local jumpId=self:GetJumpID();
    local commId=self:GetCommID();
    if jumpId~=nil then
        local jumpCfg=Cfgs.CfgJump:GetByID(jumpId);
        if jumpCfg==nil then
            LogError("读取跳转表错误！未找到跳转ID："..tostring(jumpId).."对应的数据！");
            do return end
        end
        if jumpCfg.val1 and jumpCfg.val1 ~= 0 and jumpCfg.val2 == nil and jumpCfg.val3 == nil then -- 打开单个商店
            jumpInfo={
                id=jumpId,
                commId=commId,
                shopId=jumpCfg.val1,
            }
        else
            jumpInfo={
                id=jumpId,
                commId=commId,
                shopId=jumpCfg.val2,
                topId=jumpCfg.val3,--二级页签ID
            }
        end
    else --根据商品ID进行跳转
        if commId then
            local comm=ShopMgr:GetFixedCommodity(commId);
            if comm and comm:GetNowTimeCanBuy() then
                if comm:IsOver() then
                    LanguageMgr:ShowTips(15125);
                else
                    jumpInfo={
                        commId=commId,
                        shopId=comm:GetShopID(),
                        topId=comm:GetTabID(),--二级页签ID
                    }
                end
            else
                LanguageMgr:ShowTips(15007);
            end
        end
    end
    return jumpInfo;
end

--返回自动换页时间
function this:GetChangeTime()
    return  self.cfg and self.cfg.changeTimer or 5;
end

return this