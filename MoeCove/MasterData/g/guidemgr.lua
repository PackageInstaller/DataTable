---@class GuideMgr 新手引导管理类
local GuideMgr = class("GuideMgr")
local BattleCore = require "BattleCore"

function GuideMgr:ctor()
	self:Init()
end

function GuideMgr:Init()
	--多组引导数据映射表 key: 引导组id, value: 引导数据
	---@type table<number, {guideId: number, stepId: number, isStopOn: boolean, stepIndex: number, isActive: boolean}>
	self.guideGroupMap = {}

	--当前界面是否存在待触发的引导
	---@type boolean
	self.guideOnCurrPanel = false

	--用于兼容的临时变量
	self.nowStoryName = ""
end

--引导初始化
function GuideMgr:InitUserGuideData()
	if GV.SkipUsrGuide then
		self:SkipUsrGuide()
		return
	end

	self:initGuideInfoMap()
	local guideIdMap = Me:getGuideInfoMap()
	
	--遍历所有引导组，注册所有激活的引导
	for groupId, completedGuideId in pairs(guideIdMap) do
		local guideId = 0
		if completedGuideId == 0 then
			--该组还未开始，获取第一个引导
			guideId = self:GetGuideFristByGroupId(groupId)
		else
			--该组已有进度，检查是否有下一个引导
			local nextGuideId = Config.GetGuideMainInfo(completedGuideId).NextGuide
			if nextGuideId ~= 0 then
				guideId = nextGuideId
			end
		end
		
		if guideId ~= 0 then
			local guideMainData = Config.GetGuideMainInfo(guideId)
			if guideMainData then
				--判断是否中断开启
				local stepIndex = 1
				local isStopOn = false
				local stepId = 0
				local canStopOn = true
				local stopSteps = guideMainData.StopSteps
				local stopOpenCon = guideMainData.StopStepCon
				if stopOpenCon ~= 0 then--条件判断
					canStopOn = Me:getLevelIsPassed(stopOpenCon)
				end
				if stopSteps and canStopOn then
					isStopOn = true
					stepId = stopSteps[stepIndex]
				else
					stepId = guideMainData.Steps[stepIndex]
				end
				
				--注册该组引导
				self.guideGroupMap[groupId] = {
					guideId = guideId,
					stepId = stepId,
					isStopOn = isStopOn,
					stepIndex = stepIndex,
					isActive = true
				}
				
				LuaLogger.ds(">>>>>>注册引导组<<<<<<<", groupId, guideId, stepId)
			end
		end
	end
end

--初始化新手引导数据
function GuideMgr:initGuideInfoMap()
	local guideInfo = Config.GetAllConfig("GuideMainTable")
	local guideIdMap = Me:getGuideInfoMap()
	for _, value in pairs(guideInfo) do
		if not guideIdMap[value.Group] then
			guideIdMap[value.Group] = 0
		end
	end
end

--根据引导组id来寻找首个id
---@param groupId number 引导组id
---@return number 首位引导id
function GuideMgr:GetGuideFristByGroupId(groupId)
	local temp = {}
    local guideInfo = Config.GetAllConfig("GuideMainTable")
    for _, v in pairs(guideInfo) do
        if v.Group == groupId then
            table.insert(temp, v)
        end
    end
    table.sort(temp, function(a,b)
       return a.id < b.id
    end)
    return temp[1].id
end

--剧情播放完成专用检测引导是否开启
function GuideMgr:StartGuideAVGTrigger()
	for groupId, guideData in pairs(self.guideGroupMap) do
		if guideData.isActive then
			local stepInfo = Config.GetGuideStepInfo(guideData.stepId)
			if stepInfo then
				local stepCondition = stepInfo.Condition
				for _, v in pairs(stepCondition) do
					local openType = v[1]
					if openType == 3 then--对应剧情播放完成后
						local openParam = v[2]
						local doTrigger = v[3] and true or false--是否需要主动触发
						if openParam == self.nowStoryName and doTrigger then
							self:StartGuideTrigger()
						end
					end
				end
			end
		end
	end
end

--根据当前界面检测引导是否开启
---@param panelName string|nil 界面名称 
function GuideMgr:StartGuideTrigger(panelName)
	if not panelName then
		panelName = UIMgr:getCurUIName()
	end
	
	local hasGuideOnCurrPanel = false
	
	--遍历所有激活的引导组
	for groupId, guideData in pairs(self.guideGroupMap) do
		if guideData.isActive then
			local stepInfo = Config.GetGuideStepInfo(guideData.stepId)
			if stepInfo then
				local canOpen, isOnCurrPanel = self:CheckGuideCondition(groupId, stepInfo, panelName)
				
				if canOpen then
					self:StartUserGuide(panelName, stepInfo, guideData)
					-- 找到一个可触发的引导后返回，避免同时触发多个
					if isOnCurrPanel then
						self.guideOnCurrPanel = true
					end
					return
				end
			end
		end
	end
	
	self.guideOnCurrPanel = hasGuideOnCurrPanel
end

--检查引导条件
---@param groupId number 引导组id
---@param stepInfo table 步骤信息
---@param panelName string 界面名称
---@return boolean, boolean 是否可以开启, 是否在当前界面
function GuideMgr:CheckGuideCondition(groupId, stepInfo, panelName)
	local canOpen = true
	local isOnCurrPanel = false
	local stepCondition = stepInfo.Condition

	if stepInfo.Complete == 6 then	--关卡完成类型
		return false, false
	end
	
	for _, v in pairs(stepCondition) do
		local openType = v[1]
		local openParam = v[2]
		if openType == 1 then--是否通过某关卡
			if not Me:getLevelIsPassed(openParam) then
				canOpen = false
			end
		elseif openType == 2 then--当前所在界面
			if openParam ~= panelName then
				canOpen = false
			else
				isOnCurrPanel = true
			end
		elseif openType == 3 then--对应剧情播放完成后
			if openParam ~= self.nowStoryName then
				canOpen = false
			else
				self.nowStoryName = ""
			end
		elseif openType == 4 then--关卡回合数
			local battleMgr = BattleCore:getBattleMgr()
			local round = battleMgr:getCurrentRound()
			if openParam ~= round then
				canOpen = false
			end
		elseif openType == 5 then--功能开启时
			local functionState = Me:getFunctionOpenStateById(openParam)
			if functionState ~= GE.FunctionOpenState.Open then
				return false, false
			end
		elseif openType == 6 then--当前所处某关卡内
			local battleMgr = BattleCore:getBattleMgr()
			local cfg = battleMgr:getLevelConfig()
			if not cfg or cfg.id ~= openParam then
				canOpen = false
			end
		elseif openType == 7 then--关卡当前选中角色
			local battleMgr = BattleCore:getBattleMgr()
			local roleCid = battleMgr:getSelectedRole() and battleMgr:getSelectedRole().cid or 0
			if openParam ~= roleCid then
				canOpen = false
			end
		elseif openType == 8 then--是否在一次抽卡后
			if not RaffleMgr:getIsComplete() then
				canOpen = false
			end
		elseif openType == 9 then--指挥官等级大于
			if Me.level < openParam then
				canOpen = false
			end
		end
	end
	
	return canOpen, isOnCurrPanel
end

--开始引导
function GuideMgr:StartUserGuide(nowPanelName, stepInfo, guideData)
	local nowOpenPanel = UIMgr:getUIData(nowPanelName)
	if nowOpenPanel then
		nowOpenPanel.ui.userGuidePanel.userGuidePanel:doUserGuide(stepInfo, guideData)
	end
end

--战斗完成引导记录
function GuideMgr:BattleFinishSetGuide()
	--遍历所有激活的引导组
	for groupId, guideData in pairs(self.guideGroupMap) do
		if guideData.isActive then
			local stepInfo = Config.GetGuideStepInfo(guideData.stepId)
			if stepInfo and stepInfo.Complete == 6 then
				local stepCondition = stepInfo.Condition
				for _, v in pairs(stepCondition) do
					local openType = v[1]
					local openParam = v[2]
					if openType == 1 then--通关关卡判断
						local levelData = Me:getLevelDataByid(openParam)
						if levelData and levelData.state == GE.LevelStateType.Finish then
							self:SetNextStepData(groupId)
						else
							-- 重置步骤索引
							guideData.stepIndex = 0
							self:SetNextStepData(groupId)
						end
					end
				end
			end
		end
	end
end

--设置下一步数据
---@param groupId number 引导组id
function GuideMgr:SetNextStepData(groupId)
	local guideData = self.guideGroupMap[groupId]
	if not guideData then
		return
	end
	
	guideData.stepIndex = guideData.stepIndex + 1
	local guideMainData = Config.GetGuideMainInfo(guideData.guideId)
	local stepId = 0
	
	if guideData.isStopOn then
		if not guideMainData.StopSteps then
			guideData.isStopOn = false
			stepId = guideMainData.Steps[guideData.stepIndex]
		else
			stepId = guideMainData.StopSteps[guideData.stepIndex]
		end
	else
		stepId = guideMainData.Steps[guideData.stepIndex]
	end
	
	local nextGuideId = guideMainData.NextGuide

	if not stepId then
		--保存完成的引导id
		local data = {
			guideType = groupId,
			guideId = guideData.guideId,
		}
		Me:changeGuideIDReq(data)
		
		--判断是否还有下一段引导id
		if nextGuideId ~= 0 then
			local newGuideMData = Config.GetGuideMainInfo(nextGuideId)
			local newStepIndex = 1
			local newStepId = newGuideMData.Steps[newStepIndex]
			
			--更新为新引导
			guideData.guideId = nextGuideId
			guideData.stepId = newStepId
			guideData.stepIndex = newStepIndex
			guideData.isStopOn = false
			guideData.isActive = true
		else
			--该组引导结束
			guideData.isActive = false
		end
	else
		guideData.stepId = stepId
	end
end

--本次布阵操作是若处于引导状态下则触发下一步
function GuideMgr:IsInFormationGuide()
	--遍历所有激活的引导组
	for groupId, guideData in pairs(self.guideGroupMap) do
		if guideData.isActive then
			local stepInfo = Config.GetGuideStepInfo(guideData.stepId)
			if stepInfo and stepInfo.Complete == 8 then
				local nowOpenPanel = UIMgr:getUIData("FormationPanel")
				if nowOpenPanel then
					local needTrigger = false
					local stepCondition = stepInfo.Condition
					local levelConfig = nowOpenPanel.ui._clientBattleMgr:getLevelConfig()
					for _, conditionData in pairs(stepCondition) do
						local openType = conditionData[1]
						local openParam = conditionData[2]
						if openType == 6 and levelConfig and levelConfig.id == openParam then
							needTrigger = true
							break
						end
					end
					if needTrigger then
						nowOpenPanel.ui.userGuidePanel.userGuidePanel:doSetNextGuide()
						nowOpenPanel.ui.userGuidePanel.userGuidePanel.arrowLine:SetActive(false)
						self:StartGuideTrigger()
						return
					end
				else
					LuaLogger.ws(">>>>FormationPanel not open<<<<")
				end
			end
		end
	end
end

--设置故事完成后激活引导的故事id
function GuideMgr:SetAfterGuideStoryName(storyName)
	self.nowStoryName = storyName
end

--跳过引导
function GuideMgr:SkipUsrGuide()
	local guideInfo = Config.GetAllConfig("GuideMainTable")
    for _, guideConfig in pairs(guideInfo) do
        if guideConfig.NextGuide == 0 then
			local data = {
				guideType = guideConfig.Group,
				guideId = guideConfig.id,
			}
			Me:changeGuideIDReq(data)
		end
    end
end

--获取当前引导步骤id（兼容方法，返回第一个激活的引导步骤id）
---@param groupId number|nil 引导组id，不传则返回第一个激活的
function GuideMgr:GetNowStepId(groupId)
	if groupId then
		local guideData = self.guideGroupMap[groupId]
		return guideData and guideData.stepId or 0
	end
	
	--兼容模式：返回第一个激活的引导步骤id
	for _, guideData in pairs(self.guideGroupMap) do
		if guideData.isActive then
			return guideData.stepId
		end
	end
	return 0
end

--设置当前引导步骤id
---@param stepId number 步骤id
---@param groupId number|nil 引导组id，不传则设置第一个激活的
function GuideMgr:SetNowStepId(stepId, groupId)
	if groupId then
		local guideData = self.guideGroupMap[groupId]
		if guideData then
			guideData.stepId = stepId
		end
		return
	end
	
	--兼容模式：设置第一个激活的引导步骤id
	for _, guideData in pairs(self.guideGroupMap) do
		if guideData.isActive then
			guideData.stepId = stepId
			return
		end
	end
end

--获取当前引导id（兼容方法，返回第一个激活的引导id）
---@param groupId number|nil 引导组id，不传则返回第一个激活的
function GuideMgr:GetNowGuideId(groupId)
	if groupId then
		local guideData = self.guideGroupMap[groupId]
		return guideData and guideData.guideId or 0
	end
	
	--兼容模式：返回第一个激活的引导id
	for _, guideData in pairs(self.guideGroupMap) do
		if guideData.isActive then
			return guideData.guideId
		end
	end
	return 0
end

--设置当前引导id
---@param guideId number 引导id
---@param groupId number|nil 引导组id，不传则设置第一个激活的
function GuideMgr:SetNowGuideId(guideId, groupId)
	if groupId then
		local guideData = self.guideGroupMap[groupId]
		if guideData then
			guideData.guideId = guideId
		end
		return
	end
	
	--兼容模式：设置第一个激活的引导id
	for _, guideData in pairs(self.guideGroupMap) do
		if guideData.isActive then
			guideData.guideId = guideId
			return
		end
	end
end

--获取当前界面是否存在待触发的引导
function GuideMgr:GetGuideOnCurrPanel()
	return self.guideOnCurrPanel
end

function GuideMgr:Clear()
	self:Init()
end


return GuideMgr