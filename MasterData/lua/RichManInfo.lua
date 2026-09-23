local this = {}

function this.New()
    this.__index = this.__index or this;
    local tab = {};
    setmetatable(tab, this);
    return tab
end

function this:InitCfg(cfgId)
    if cfgId then
        self.cfg = Cfgs.cfgMonopoly:GetByID(cfgId)
        if self.cfg == nil then
            LogError("大富翁活动表：cfgMonopoly中未找到ID：" .. tostring(cfgId) .. "对应的数据");
        end
    end
end

function this:SetData(_data)
	self.data=_data;
	if self.data~=nil then
		self:InitCfg(self.data.cfgId);
		self:InitGridsInfo();
	end
end

function this:GetCfg()
	return self.cfg or nil;
end

function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

function this:GetData()
	return self.data;
end

function this:InitGridsInfo()
	--读取配置中的格子信息
	local mapId = nil
	if self.data and self.data.mapId then
		mapId = self.data.mapId
	elseif self.cfg and self.cfg.Temp then
		mapId = self.cfg.Temp[1]
	end
	if mapId then
		self.mapInfo = RichManMapInfo.New()
		self.mapInfo:InitCfg(mapId)
	else
		LogError("大富翁活动：无法初始化地图，mapId为空")
	end
end

--更新投掷后的数据
function this:UpdateData(_proto)
	if _proto then
		local isReset=false;
		self.data.sort=_proto.sort;
		if self.data.mapId~=_proto.mapId then
			isReset=true;
		end
		self.data.mapId=_proto.mapId;
		self.data.eventList=_proto.eventList;
		self.data.throwCnt=_proto.throwCnt;		
		if isReset then
			self:InitGridsInfo();
		end
	end
end

function this:GetOpenTime()
	return self.cfg and self.cfg.openTime or nil;
end

function this:GetCloseTime()
	return self.cfg and self.cfg.closeTime or nil;
end

function this:GetOpenTimeStamp()
	local time=0;
	if self:GetOpenTime()~=nil then
		time=TimeUtil:GetTimeStampBySplit(self:GetOpenTime())
	end
	return time;
end

function this:GetCloseTimeStamp()
	local time=0;
	if self:GetCloseTime()~=nil then
		time=TimeUtil:GetTimeStampBySplit(self:GetCloseTime())
	end
	return time;
end


function this:OpenShop()
	if self.cfg and self.cfg.shopID then
		CSAPI.OpenView("ShopView",self.cfg.shopID);
	end
end

function this:GetPos()
	if self.data and self.data.sort then
		return self.data.sort;
	end
	return 0;
end

function this:GetThrowCnt()
	if self.data and self.data.throwCnt then
		return self.data.throwCnt
	end
	return 0;
end

function this:GetTaskGroup()
	return self.cfg and self.cfg.nGroup or nil
end

--返回普通骰子信息
function this:GetNormalDice()
	local diceInfo=nil;
	if self.cfg and self.cfg.normalDice then
		diceInfo=BagMgr:GetFakeData(self.cfg.normalDice);
	end
	return diceInfo;
end

--返回普通骰子信息
function this:GetSpecialDice()
	local diceInfo=nil;
	if self.cfg and self.cfg.specialDice then
		diceInfo=BagMgr:GetFakeData(self.cfg.specialDice);
	end
	return diceInfo;
end

--返回当前站在的格子信息
function this:GetCurPosGridInfo()
	if self.data and self.data.sort then
		return self:GetGridInfoByID(self.data.sort);
	end
end

--返回指定sort的格子信息
function this:GetGridInfoByID(sort)
	return self.mapInfo and self.mapInfo:GetGridInfoByID(sort)
end

--返回格子关联的下一个格子的信息 sort:指定格子顺序
function this:GetNextPosGridInfo(sort)
	if not self.mapInfo then return end
	if sort==nil then --默认获取当前格子的下一格
		local curInfo=self:GetCurPosGridInfo();
		sort=curInfo and curInfo:GetSort()+1 or 2; --当前没有格子信息则默认获取第二格的信息
	else
		sort=sort==self:GetMaxStepNum() and 1 or sort+1;
	end
	return self.mapInfo:GetGridBySort(sort)
end

--返回控制角色的配置信息
function this:GetCtrlRole()
	if self.cfg and self.cfg.roleId then
		local card=RoleMgr:GetData(self.cfg.roleId);
		-- local card=RoleMgr:GetData(40310);
		if card~=nil then
			return card:GetModelCfg();
		else
			--获取基础配置信息
			local card=RoleMgr:GetFakeData(self.cfg.roleId);
			return card:GetModelCfg();
		end
	end
end

function this:EnterScene()
	local sceneID=self:GetSceneID();
	if sceneID==nil then
		LogError("大富翁活动："..tostring(self:GetID()).."未配置场景ID！");
		do return end
	end
	local cfg=Cfgs.scene:GetByID(sceneID);
	if cfg~=nil then
		EventMgr.Dispatch(EventType.Scene_Load, cfg.key);
	end
end

function this:GetSceneID()
	return self.cfg and self.cfg.sceneId or nil;
end

function this:GetBGM()
	return self.cfg and self.cfg.view or nil;
end

function this:GetMapInfo()
	return self.mapInfo;
end

function this:GetEventList()
	local list=nil;
	if self.data and self.data.eventList then
		for k, v in ipairs(self.data.eventList) do
			list=list or {}
			local event=RichManGridEvent.New();
			event:InitCfg(v)
			table.insert(list,event);
		end
	end
	return list;
end

--返回当前的Task的奖励和条件信息{{奖励物品id，数量,类型}，条件}
function this:GetCurrTask()
	if self.mapInfo==nil then
		return nil;
	end
	local gridInfo=self.mapInfo:GetGridBySort(1);
	if gridInfo~=nil then
		return {{id=gridInfo:GetValue1()[1],num=gridInfo:GetValue2()[1],type=2},gridInfo:GetValue3()[1]};
	else
		LogError("未获取到对应的整圈奖励信息！");
	end
	return nil;
end

--返回格子数量
function this:GetAllGridsNum()
	return self.mapInfo and self.mapInfo:GetAllGridsNum() or 0
end

--单圈完成的最大步数
function this:GetMaxStepNum()
	return self.mapInfo and self.mapInfo:GetMaxStepNum() or 0
end

function this:GetCoinGoods()
	if self.cfg and self.cfg.coin then
		return BagMgr:GetFakeData(self.cfg.coin);
	end
	return nil;
end

function this:GetPreviewRange()
	if self.cfg then
		return self.cfg.previewRange;
	end
	return nil;
end

function this:GetPlayDistance()
	if self.cfg then
		return self.cfg.playDistance;
	end
	return -35;
end

function this:GetCameraDistance()
	if self.cfg then
		return self.cfg.cameraDistance;
	end
	return -35;
end


return this;
