local this = {};

local talkInfo = nil;
local allRoleInfos = nil;
local roleInfos = nil

function this.New()
    this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins,this);	    
	return ins;
end

--初始化配置
function this:InitCfg(cfgId)
	talkInfo = nil;
	allRoleInfos = nil;
	roleInfos = nil;
	if(cfgId == nil) then
		LogError("初始化对话数据失败！无效配置id");		
	end
	if(self.cfg == nil) then		
		self.cfg = Cfgs.CfgDateStory:GetByID(cfgId);
		if(self.cfg == nil) then		
			LogError("找不到对话数据！id = " .. tostring(cfgId));	
		end
	end
end

function this:GetID()
	return self.cfg.id;
end

--返回对话内容
function this:GetContent()
	local str = "";
	if self.cfg and self.cfg.content then
		str = self.cfg.content;
		if self.cfg.specialType and #self.cfg.specialType > 0 then
			local tab = {}
			local sex = PlayerClient:GetSex()
			for i, v in ipairs(self.cfg.specialType) do
				if v == 1 then --姓名
					table.insert(tab, PlayerClient:GetName())
				elseif v == 2 then --代称
					table.insert(tab, LanguageMgr:GetByID(sex == 1 and 19005 or 19006))
				elseif v == 3 then 
					table.insert(tab, LanguageMgr:GetByID(sex == 1 and 19007 or 19008))
				elseif v == 4 then 
					table.insert(tab, LanguageMgr:GetByID(sex == 1 and 19009 or 19010))
				end
			end
			str = StringUtil:ReplacePlaceholders(str, tab)
		else
			str = str:gsub("%%s",PlayerClient:GetName())
		end
		if self:IsLeader() then
			local strs = StringUtil:Split(str ,"<sp>");
			if #strs > 1 then
				local sex = PlayerClient:GetSex()
				str = strs[sex]
			end
		end
	end
	return str;
end

--返回图片内容
function this:GetImgContents()
	local imgs = self.cfg and self.cfg.imgContent;
	local paths = nil;
	if imgs ~= nil then
		paths = {};
		for k, v in ipairs(imgs) do
			local isFind = false;
			for _, val in pairs(PlotColorImg) do
				if val.type == v then
					isFind = true;
					table.insert(paths, val.type);
					break;
				end
			end
			local pointIdx = string.find(v, "[.]");
			local folderName = v;
			if pointIdx then
				folderName = string.sub(v, 1, pointIdx - 1);
			end
			if self.cfg and self.cfg.imgType and self.cfg.imgType == 1 then
				if k < 3 then
					isFind = true
					if PlayerClient:GetSex() == k then
						isFind = false
					end
				end
			end
			if isFind == false then
				table.insert(paths, string.format("UIs/Plot/%s/%s", folderName, v));
			end
		end
	end
	return paths;
end

--返回Cg延迟时间
function this:GetImgDelay()
	local delay = 0;
	if self.cfg.imgContent ~= nil and self.cfg.imgDelay then
		delay = self.cfg.imgDelay or 2;
	end
	return delay;
end

--返回
function this:GetImgChangeType()
	return self.cfg and self.cfg.imgChangeType or 0;
end

function this:GetTag()
	return self.cfg and self.cfg.talkRoleTag;
end

--返回发言者ID
function this:GetTalkID()
	return self.cfg and self.cfg.talkRoleID;
end

function this:IsTalkID(key)
	local talkIDs = self:GetTalkID();
	local talkTags = self:GetTag() or {}
	local tag = 1
	if talkIDs then
		for k, v in ipairs(talkIDs) do
			tag = talkTags[k] or tag
			if key == v .. "_" .. tag then
				return true;
			end
		end
	end
	return false;
end

--返回发言者名字
function this:GetTalkName()
	local talkName = "";
	if self.cfg and self.cfg.talk then
		talkName = string.format(self.cfg.talk, tostring(PlayerClient:GetName()));
	end
	return talkName;
end

--返回发言者英文名字
function this:GetTalkEnName()
	local talkName = "";
	if self.cfg and self.cfg.talk_en then
		talkName = string.format(self.cfg.talk_en, tostring(PlayerClient:GetName()));
	end
	return talkName
end

function this:GetRoleInfos()
	if self.cfg and self.cfg.roleInfos ~= nil then
		return self.cfg.roleInfos	
	end
	return nil
end

--返回是否隐藏对话框
function this:IsHideBox()
	local isHide = false;
	if self.cfg and self.cfg.isHideBox ~= nil then
		isHide = true;
	end
	return isHide;
end

--返回发言者信息
function this:GetTalkInfo()
	if talkInfo == nil then
		talkInfo = RoleImgInfo.New();
		talkInfo:InitCfg(self:GetTalkID() [1]);
	end
	return talkInfo;
end

--返回语音文件名称
function this:GetSoundFileName()
	
end

--返回是否显示头像
function this:GetShowIcon()
	if self.cfg and self.cfg.showIcon then
		return self.cfg.showIcon == 1
	end
	return false;
end

--返回所有参与者的信息
function this:GetAllRoleInfos()
	return self.cfg and self.cfg.roleInfos or nil;
end

--返回所有对话选项
function this:GetOptions()
	if self.options == nil then
		local optionsId = self.cfg and self.cfg.nextId or {};
		if #optionsId > 1 then
			self.options = {}
			for i = 1, #optionsId do
				local option = LovePlusStoryData.New();
				option:InitCfg(optionsId[i]);
				table.insert(self.options, option);
			end
		else
			self.options = nil;
		end
	end
	return self.options;
end

--返回下一段对话的对象
function this:GetNextPlotInfo()
	local nextIds = self.cfg and self.cfg.nextId or {- 1};
	local nextId = nextIds[1]
	local cond = self:GetCondition()
	if cond and not LovePlusMgr:CheckIsAchieved(cond) then
		nextId = cond[3]
	end
	local next = nil;
	if nextId == - 1 then
		return nil
	else
		next = this.New();
		next:InitCfg(nextId);
	end
	return next;
end

--角色立绘是否显示遮罩
function this:HasMask()
	local masks = {0,0,0}
	if(self.cfg and self.cfg.mask and #self.cfg.mask>0)then
		for i,v in ipairs(self.cfg.mask)do
			masks[i] = v
		end
	end
	return masks;
end

--是否可以跳过
function this:CanJump()
	local canJump = true;
	--带选项，CG画面，特效帧无法跳过
	if self.cfg and self.cfg.nextId and #self.cfg.nextId >1 then
		canJump = false;
	end
	return canJump;
end

--是否显示上一次对话的内容
function this:IsLastContent()
	return self.cfg and self.cfg.isLastContent ~= nil or false;
end

--返回faceID
function this:GetFaceIDs()
	local ids = {- 1, - 1, - 1}
	if self.cfg then
		ids[1] = self.cfg.header_left or ids[1]
		ids[2] = self.cfg.header_center or ids[2]
		ids[3] = self.cfg.header_right or ids[3]
	end
	return ids
end

--返回气泡信息
function this:GetEmojiIDs()
	local ids = {- 1, - 1, - 1}
	if self.cfg then
		ids[1] = self.cfg.emoji_left or ids[1]
		ids[2] = self.cfg.emoji_center or ids[2]
		ids[3] = self.cfg.emoji_right or ids[3]
	end
	return ids
end

--返回特效的配置信息
function this:GetEffectCfg()
	local effectCfg = nil;
	if self.cfg and self.cfg.effectID then
		effectCfg = Cfgs.PlotEffect:GetByID(self.cfg.effectID);
	end
	return effectCfg;
end

--是否回忆
function this:IsGray()
	local isGray = false;
	if self.cfg and self.cfg.grayEffect then
		isGray = true;
	end
	return isGray;
end

function this:GetCameraInfo()
	return self.cfg and self.cfg.cameraInfo or nil;
end

function this:GetBGM()
	return self.cfg.bgm or nil;
end

function this:GetKey()
	return "PlotData";
end

function this:GetBlur()
	if self.cfg == nil then
		return - 1, - 1, - 1
	end
	local starBlur = self.cfg.starBlur or 0
	local endBlur = self.cfg.endBlur or 0
	local blurTime = self.cfg.blurTime or 0
	return starBlur, endBlur, blurTime
end

--强制自动状态
function this:GetForceAutoTime()
	return self.cfg and self.cfg.forceAutoTime
end

--文字出现在中间状态
function this:IsCenter()
	local isCenter = false
	if self.cfg and self.cfg.isCenter then
		isCenter = self.cfg.isCenter == 1
	end
	return isCenter
end

--文字出现在左侧状态
function this:IsLeft()
	return self.cfg and self.cfg.isCenter and self.cfg.isCenter == 2
end

--获取眨眼次数
function this:GetBlinkNum()
	return self.cfg and self.cfg.blink
end

--获取眨眼动画时间
function this:GetBlinkTime()
	local blinkTime = 1 --睁开闭合的时间为一次
	local blinkNum = self:GetBlinkNum() or 0
	return blinkNum * blinkTime
end

function this:GetShowStory()
	return self.cfg and self.cfg.showStory
end

function this:GetClearRoles()
	return self.cfg and self.cfg.clearRoles
end

--视频信息
function this:GetVideoInfo()
	return self.cfg and self.cfg.video
end

------------------------------------------音效-------------------------------------------
--获取音效时间 
function this:GetSoundTime()
	local cfgSound = Cfgs.Sound:GetByKey(self:GetSoundKey())
	return cfgSound and cfgSound.playTime
end

--获取音效key
function this:GetSoundKey()
	return self.cfg and self.cfg.soundFile
end

--获取场景音效key
function this:GetEffSoundInfos()
	local infos = {}
	if(self.cfg and self.cfg.effSoundInfos) then
		infos = self.cfg.effSoundInfos
		table.sort(infos, function(a, b)
			local delayA = a.delay or 0
			local delayB = b.delay or 0
			return delayA < delayB;
		end)
	end
	return infos
end

function this:GetEffSoundTime()
	local delayTime = 1 --音效播放时间单位
	local infos = self:GetEffSoundInfos()
	if(infos) then
		for i, v in ipairs(infos) do
			local delay = v.delay and v.delay + 1 or 1
			delayTime = delayTime > delay and delayTime or delay
		end
	else
		delayTime = 0;
	end
	return delayTime
end

--是否有单次音效
function this:IsEffSoundByInfo()
	local infos = self:GetEffSoundInfos()
	if(infos) then
		for i, v in ipairs(infos) do
			if(not v.type or v.type == 1) then
				return true
			end
		end
	end
	return false
end

--是否有循环音效
function this:IsLoopSoundByInfo()
	local infos = self:GetEffSoundInfos()
	if(infos) then
		for i, v in ipairs(infos) do
			if(v.type == 2) then
				return true
			end
		end
	end
	return false
end

--玩家角色
function this:IsLeader()
	return self.cfg and self.cfg.isLeader ~= nil
end

--头像渐变
function this:IsIconGradient()
	return self.cfg and self.cfg.useGradient == 1
end
------------------------------------------流程-------------------------------------------

function this:GetType()
	return self.cfg and self.cfg.storyType
end

function this:IsSavePoint()
	return self.cfg and self.cfg.savePoint
end

function this:IsHighLight()
	return self.cfg and self.cfg.highLight
end

--出现条件
function this:GetCondition()
	return self.cfg and self.cfg.appearcondition
end

function this:GetNodeId()
	return self.cfg and self.cfg.paragraph
end

return this; 

