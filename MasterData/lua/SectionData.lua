--章节数据
local this = {};

function this.New()
	this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins, this);		
	return ins;
end

--设置配置
function this:Init(targetCfg)
	self.cfg = targetCfg;
end
--获取配置
function this:GetCfg()
	return self.cfg;
end

--获取ID
function this:GetID()
	return self.cfg.id;
end
--获取名称
function this:GetName()
	return self.cfg.name;
end

function this:GetMapName()
	return self.cfg.mName
end

--章节分类
function this:GetGroup()
	return self.cfg and self.cfg.group;
end

--返回章节索引
function this:GetIndex()
	return self.cfg.index;
end

function this:GetChaperName()
	return self.cfg.chapter;
end

function this:GetOName()
	return self.cfg.oName;
end

function this:GetEName()
	return self.cfg.eName;
end

function this:GetNameImg()
	return self.cfg.nameImg;
end

function this:GetIcon()
	return self.cfg.icon;
end

function this:GetSectionBG()
	return self.cfg.sBg;
end

--获取状态
function this:GetState(type)
	local id = self:GetID();
	local isOpen = false;
	local isComplete = true;
	type = type == nil and 1 or type;
	local state = 0;
	local cfgs = Cfgs.MainLine:GetGroup(id);--cfgMainLine.type为1表示普通难度副本
	if(cfgs) then
		for _, cfgMainLine in ipairs(cfgs) do
			if(cfgMainLine.type == type) then --筛选难度
				local dungeonData = DungeonMgr:GetDungeonData(cfgMainLine.id);
				if(isOpen == false) then
					if(DungeonMgr:IsDungeonOpen(cfgMainLine.id)) then
						isOpen = true;				
					end
				end
				
				if(dungeonData == nil or dungeonData:IsOpen() == false or dungeonData:IsPass() == false) then
					isComplete = false;				
				end
				if(isOpen and isComplete == false) then
					break;
				end
			end
		end
	else
		isOpen = false;
		isComplete = false;
	end
	if(isOpen and isComplete) then
		state = 2;
	elseif(isOpen) then
		state = 1;
	else
		state = 0;
	end
	
	return state;
end

--获取副本配置
function this:GetDungeonCfgs(hardLv)
	if(self:GetSectionType() == SectionType.MainLine) then
		--获取主线副本
		local allDungeonCfgs = self:GetAllDungeonCfgs();
		if(allDungeonCfgs) then
			return allDungeonCfgs[hardLv];
		end
	else
		--获取每日副本
		return Cfgs.MainLine:GetGroup(self:GetID());
	end
	
	return nil;
end

--获取副本配置
function this:GetAllDungeonCfgs()
	if(self.dungeonCfgs == nil) then
		self.dungeonCfgs = {};
		local cfgGroup = Cfgs.MainLine:GetGroup(self:GetID());
		if(cfgGroup) then
			for _, tmpCfg in ipairs(cfgGroup) do
				if tmpCfg.type == eDuplicateType.SubLine or tmpCfg.type == eDuplicateType.Teaching then --支线或教程,判断前置关卡是困难还是简单，并添加到对应数组
				-- if tmpCfg.type == eDuplicateType.SubLine then
					local cfg = Cfgs.MainLine:GetByID(tmpCfg.preChapterID[1]);
					if cfg then
						table.insert(self.dungeonCfgs[cfg.type], tmpCfg);
					end
				else
					self.dungeonCfgs[tmpCfg.type] = self.dungeonCfgs[tmpCfg.type] or {};
					-- self.dungeonCfgs[tmpCfg.type][tmpCfg.id] = tmpCfg; 
					table.insert(self.dungeonCfgs[tmpCfg.type], tmpCfg);
				end
			end
		end
	end
	
	return self.dungeonCfgs;
end

--返回最后一个开启的关卡配置信息
function this:GetLastOpenDungeon()
	local dungeonCfg = nil;
	local cfgGroup = Cfgs.MainLine:GetGroup(self:GetID());
	if(cfgGroup) then
		for _, tmpCfg in ipairs(cfgGroup) do
			if tmpCfg.type == eDuplicateType.MainNormal then --只判断普通难度的主线本
				local dungeonData = DungeonMgr:GetDungeonData(tmpCfg.id);
				if(dungeonData ~= nil and dungeonData:IsOpen() == true) then
					if dungeonData:IsPass() and tmpCfg.lasChapterID then
						dungeonCfg = Cfgs.MainLine:GetByID(tmpCfg.lasChapterID[1]);
					else
						dungeonCfg = tmpCfg
					end
				elseif tmpCfg.preChapterID then
					local preData = DungeonMgr:GetDungeonData(tmpCfg.preChapterID[1]);
					if preData ~= nil and preData:IsPass() == true then
						dungeonCfg = tmpCfg;
						break;
					end
				end
			end
		end
	end
	return dungeonCfg;
end

--返回完成百分比 只有普通难道
function this:GetCompletePercent()
	local count = 0;
	local total = 0;
	local cfgGroup = Cfgs.MainLine:GetGroup(self:GetID());
	if(cfgGroup) then
		for _, tmpCfg in ipairs(cfgGroup) do
			if tmpCfg.type == eDuplicateType.MainNormal then --支线,判断前置关卡是困难还是简单，并添加到对应数组
				total = total + 1;
				local dungeonData = DungeonMgr:GetDungeonData(tmpCfg.id);
				if(dungeonData ~= nil and dungeonData:IsOpen() == true and dungeonData:IsPass() == true) then
					count = count + 1;
				end
			end
		end
	end
	return math.floor((count / total) * 100);
end

--返回完成百分比 包含教程 支线
function this:GetCompletePercentByAll(type)
	type = type or 1
	local count = 0;
	local total = 0;
	local cfgGroup= Cfgs.DungeonGroup:GetGroup(self:GetID());
	if(cfgGroup) then
		for _, tmpCfg in ipairs(cfgGroup) do
			local cfgIDs = type == eDuplicateType.MainNormal and tmpCfg.dungeonGroups or tmpCfg.hDungeonGroups
			if cfgIDs then
				for _, cfgID in ipairs(cfgIDs) do
					total = total + 1
					local dungeonData = DungeonMgr:GetDungeonData(cfgID);
					if(dungeonData ~= nil and dungeonData:IsOpen() == true and dungeonData:IsPass() == true) then
						count = count + 1;
					end
				end
			end			
		end
	end
	return math.floor((count / total) * 100);
end

--获取章节类型
function this:GetSectionType()
	return self.cfg.group;
end

--获取具体类型
function this:GetType()
	return self.cfg.type;
end

--返回星级奖励信息,没有则返回空, type:当前关卡的难度类型
function this:GetStarRewards()
	local type = DungeonMgr:GetDungeonHardLv(self:GetID())
	local cfg = nil;
	if self.cfg.starRewardID and self.cfg.starRewardID[type] then
		cfg = Cfgs.CfgSectionStarReward:GetByID(self.cfg.starRewardID[type]);
	end
	return cfg;
end

--返回星级奖励id
function this:GetStarRewardID()
	local type = DungeonMgr:GetDungeonHardLv(self:GetID())
	if self.cfg.starRewardID then
		return self.cfg.starRewardID[type]
	end
end

--返回背景图片
function this:GetBG()
	local str = nil
	if self.cfg and self.cfg.bg and self.cfg.bg[1] then
		str = self.cfg.bg[1]
	end
	return str;
end

function this:GetBGs()
	return self.cfg and self.cfg.bg
end

function this:GetBGType()
	return self.cfg and self.cfg.bgType
end

function this:GetBGPosZ()
	return self.cfg and self.cfg.bgPosZ or 15.2
end

function this:GetBGInfo()
	local info = self.cfg and self.cfg.bgInfo
	if info then
		info.width = info.width or 1920
	end
	return info
end

function this:GetDesc()
	return self.cfg and self.cfg.desc or "";
end

function this:GetLockDesc()
	return self.cfg and self.cfg.lock_desc or "";
end
function this:GetHardLockDesc()
	return self.cfg and self.cfg.hardLock_desc or "";
end

function this:GetOpenTime()
	return self.cfg and self.cfg.openTime or nil;
end

function this:GetPassDesc()
	local type = DungeonMgr:GetDungeonHardLv(self:GetID())
	if type == 1 then
		return self.cfg and self.cfg.passDesc
	else
		return self.cfg and self.cfg.diffPassDesc
	end
	
end

function this:GetNextOpenDesc()
	return self.cfg and self.cfg.nextOpenDesc
end

--副本开启
function this:GetOpen()
	local _state,_str = self:GetOpenState()
	local _isOpen = _state > 0
	return _isOpen, _str, _state
end

--副本开启状态 0：未通关某个关卡 -1：日常本未到开启时间 -2：活动未到开启时间
function this:GetOpenState()
	local openState = 1
	local lockStr = ""
	if self.cfg then
		if self.cfg.conditions then
			local isOpen = true
			isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.section, self.cfg.id)
			if not isOpen then
				openState = 0
			end
		end
		if self.openInfo == nil then
			self.openInfo = DungeonMgr:GetActiveOpenInfo2(self:GetID())
		end
		if self:GetSectionType() == SectionType.Daily and openState > 0 then
			local isOpen,isNextOpen = DungeonMgr:IsDailyOpenTime(self.cfg.openTime)
			openState = isOpen and 1 or -1
			if not isOpen then --下一天开启
				openState = isNextOpen and -1.5 or -1
			end
			lockStr = self.cfg.lock_desc
		elseif self:GetSectionType() == SectionType.Activity then --活动没有未开启显示
			if not self:IsResident() then
				local isActiveOpen = self.openInfo and self.openInfo:IsOpen()
				if openState > 0 then
					openState = isActiveOpen and 1 or -2
					lockStr = LanguageMgr:GetTips(24003)
				else
					openState = isActiveOpen and openState or -2
					lockStr = isActiveOpen and lockStr or LanguageMgr:GetTips(24003)
				end
			end
		elseif self:GetSectionType() == SectionType.MainLine and self.openInfo then
			local isActiveOpen = self.openInfo:IsOpen()
			if openState > 0 then
				openState = isActiveOpen and 1 or -2
				lockStr = LanguageMgr:GetTips(24003)
			else
				openState = isActiveOpen and openState or -2
				lockStr = isActiveOpen and lockStr or LanguageMgr:GetTips(24003)
			end
		elseif self:GetSectionType() == SectionType.Colosseum then
			local isActiveOpen = self.openInfo and self.openInfo:IsOpen()
			if openState > 0 then
				openState = isActiveOpen and 1 or -2
				lockStr = LanguageMgr:GetTips(24003)
			else
				openState = isActiveOpen and openState or -2
				lockStr = isActiveOpen and lockStr or LanguageMgr:GetTips(24003)
			end
		end
	end
	return openState, lockStr
end

--掉落奖励
function this:GetFallRewards()
	return self.cfg and self.cfg.fallRewards
end

-- function this:GetBGM()
-- 	return self.cfg and self.cfg.bgm
-- end

--获取不开启是否隐藏
function this:GetLockShow()
	return self.cfg and self.cfg.fade
end

function this:GetDailyType()
	return self.cfg and self.cfg.dailyEnumID
end

function this:GetMultiID()
	return self.cfg and self.cfg.multiId
end

--角色活动轮盘区域数
function this:GetTurnNum()
	return self.cfg and self.cfg.turnNum
end

--角色活动轮盘背景
function this:GetTurnImg()
	return self.cfg and self.cfg.turnImg
end

--角色活动右侧背景
function this:GetTurnIcon()
	return self.cfg and self.cfg.turnIcon
end

--进入选关时播放的剧情id
function this:GetStoryID()
	return self.cfg and self.cfg.story
end

function this:GetInfo(index)
	index = index or 1
	return self.cfg and self.cfg.info and self.cfg.info[index]
end

function this:GetInfos()
	return self.cfg and self.cfg.info
end

--界面名
function this:GetPath()
	local info = self:GetInfo()
	local viewKey = ""
	if info and info.view then
		viewKey = info.view
	end
	return viewKey
end

--红点路径
function this:GetRedPath()
	local info = self:GetInfo()
	local path = "Common/Red2"
	if info and info.red then
		path = info.red
	end
	return path
end

function this:GetExploreId()
	local info = self:GetInfo()
	return info and info.exploreId
end

function this:GetDescKey()
	return self.cfg and self.cfg.descKey or ""
end

function this:IsShowOnly()
	return self.cfg and self.cfg.onlyOne and self.cfg.onlyOne == 1
end

function this:GetOpenInfo()
	if self.openInfo == nil then
		self.openInfo = DungeonMgr:GetActiveOpenInfo2(self:GetID())
	end
	return self.openInfo
end

--常驻
function this:IsResident()
	return self.cfg and self.cfg.specType and self.cfg.specType == 1
end

--任务类型
function this:GetTaskType()
	local info = self:GetInfo()
	return info and info.taskType 
end

function this:GetBGM()
	local info = self:GetInfo()
	return info and info.bgm or ""
end

function this:GetShopId()
	local info = self:GetInfo()
	return info and info.shopId
end

--获取信息字段对应内容
function this:GetInfoContent(key)
	if key == nil or key == "" then
		return
	end
	local info = self:GetInfo()
	return info and info[key]
end
---------------------------------------------门票购买---------------------------------------------
function this:GetBuyCount()
	return self.cfg and self.cfg.DungeonArachnidDailyBuy or 0
end

function this:GetBuyCost()
	return self.cfg and self.cfg.DungeonArachnidDailyCost
end

function this:GetBuyGets()
	return self.cfg and self.cfg.DungeonArachnidGets
end
---------------------------------------------试炼---------------------------------------------
--列表图标
function this:GetIcon1()
	return self.cfg.icon1;
end
--切页图标
function this:GetIcon2()
	return self.cfg.icon2;
end
--角标图标
function this:GetIcon3()
	return self.cfg.icon3;
end

---------------------------------------------排行榜---------------------------------------------
function this:GetRankType(index)
	local info = self:GetInfo(index)
	return info and info.rankType 
end

function this:GetRankIcon(index)
	local info = self:GetInfo(index)
	return info and info.rankIcon or "" 
end

function this:GetRankTitle(index)
	local info = self:GetInfo(index)
	if info and info.rankId then
		return LanguageMgr:GetByID(info.rankId)
	end
	return ""
end

function this:GetRankDesc(index)
	local info = self:GetInfo(index)
	if info and info.rankDes then
		return LanguageMgr:GetByID(info.rankDes)
	end
	return ""
end

function this:GetRankDesc2(index)
	local info = self:GetInfo(index)
	if info and info.rankDes2 then
		return LanguageMgr:GetByID(info.rankDes2)
	end
	return ""
end

function this:GetRankReward(index)
	local info = self:GetInfo(index)
	return info and info.rankReward or ""
end

function this:GetRankView(index)
	local info = self:GetInfo(index)
	return (info and info.rankView) or 1
end

function this:GetRankListInfo()
	local infos = self:GetInfos()
	local info = {}
	if infos and #infos > 0 then
		for i, v in ipairs(infos) do
			if v.rankType or v.rankReward then
				table.insert(info,{id = v.rankType or v.rankReward,desc1 = self:GetRankDesc(i),desc2 = self:GetRankDesc2(i),title = self:GetRankTitle(i),rankType = self:GetRankType()})
			end
		end
	end
	return info
end
---------------------------------------------历战---------------------------------------------
function this:IsChain()
	return self.cfg and self.cfg.isChain ~= nil
end
---------------------------------------------爬塔---------------------------------------------
function this:GetTowerNum()
	if self.cfg and self.cfg.finishRewardInfo then
		local reward = self.cfg.finishRewardInfo[2]
		return reward and reward[2]
	end
	return 0
end
return this; 