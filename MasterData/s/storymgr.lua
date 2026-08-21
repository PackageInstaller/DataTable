
---@class StoryMgr 剧情管理类
local StoryMgr = class("StoryMgr")

function StoryMgr:ctor()
	self:Init()
end

function StoryMgr:Init()
	--当前剧情片段id
	self.nowStoryArraryId = nil
	--当前剧情片段完成回调
	self.nowStoryEndCallBack = nil
	--当前家园剧情片段id
	self.nowHomeStoryArraryId = nil
	--当前家园剧情片段完成回调
	self.nowHomeStoryEndCallBack = nil
	--是否处于家园剧情中
	self.isHomeLandStory = false
	--是否需要弹出家园建筑升级弹窗(配合家园建筑升级动画使用)
	self.needShowHomeLvUpPanel = false
	--家园建筑升级剧情跳过回调
	self.homeLvUpSkipCallback = nil
end

--根据剧情片段id播放剧情
function StoryMgr:playStoryByArraryId(storyArraryId, callBack)
	local storyConfig = Config.GetStoryArraryInfo(storyArraryId)
	if not storyConfig then
		return
	end
	if storyConfig.type == 1 then--3d人物演出
		self:setNowStoryArraryId(storyArraryId)
		self:setNowStoryEndCallBack(callBack)
		LoadingMgr:SetLoadingStart(function()
			StateMgr:ChangeToState(GameFlowState.BattleState)
		end, nil, nil, "StoryMgr")
	elseif storyConfig.type == 2 then--AVG剧情
		UIMgr:popUI("StoryPanel", {storyName = storyConfig.storyArrary[1], callBack = callBack})
	end
end

--片段完成回到游戏场景方法
function StoryMgr:storyArraryEndToGameScene()
	local nowState = StateMgr:GetNowState()
	if nowState == GameFlowState.GameState then
		return
	end
	LoadingMgr:SetLoadingStart(function()
		StateMgr:ChangeToState(GameFlowState.GameState)
	end, nil, nil, "StoryMgr2")
end

--家园剧情入口方法（独立流程，不依赖战斗框架）
function StoryMgr:playHomeStory(storyArraryId, callBack)
	if self.isHomeLandStory == true then
		return
	end
	self.isHomeLandStory = true
	--隐藏主界面
	local mainPanel = UIMgr:getUIData("MainPanel")
	if mainPanel then
		mainPanel.ui:HideAll(true, true)
	end
	--隐藏家园UI
	local coveManager = CoveManager.instance()
	coveManager:SetHomeUICanvasOpen(false)
	--将当前家园人物设置到其他层级不再显示
	local roleList = coveManager:getRoleMgr():GetAllCoveTab()
	for _, coveRole in ipairs(roleList) do
		if UICommonUtils.Checkobj(coveRole._roleObj) then
			self:SetLayerRecursively(coveRole._roleObj, UnityEngine.LayerMask.NameToLayer("HideRole"))
			coveRole:SetTitleActive(false)
		end
	end

	local BaseShowManager = require "BaseShowManager"
	local BaseMap = require "BaseMap"
	local BattleStoryManager = require "BattleStoryManager"

	local showMgr = BaseShowManager:new()
	local map = BaseMap:new()
	local storyMgr = BattleStoryManager.instance()

	--剧情结束回调：清理资源并恢复家园
	storyMgr:setEndCallbackFunc(function()
		showMgr:clearForHomeStory()
		storyMgr:clear()
		map:clear()
		self.isHomeLandStory = false
		if callBack then
			callBack()
		end
		--显示家园UI
		local coveManager = CoveManager.instance()
		coveManager:SetHomeUICanvasOpen(true)
		--主相机相关监听
		local CameraRenderCB = coveManager.cameraObj:GetComponent("CameraRenderCB")
		CameraRenderCB.lateUpdateFunc = function ()
			coveManager:FixedUpdate()
		end
		--将当前家园人物层级恢复显示
		local roleList = coveManager:getRoleMgr():GetAllCoveTab()
		for _, coveRole in ipairs(roleList) do
			if UICommonUtils.Checkobj(coveRole._roleObj) then
				self:SetLayerRecursively(coveRole._roleObj, UnityEngine.LayerMask.NameToLayer("Role"))
				coveRole:SetTitleActive(true)
			end
		end
	end)

	--初始化剧情地图，完成后加载场景根节点
	storyMgr:initHomestory(showMgr, map, storyArraryId, function()
		showMgr:loadPVRoot(function()
			--家园剧情不需要/边界/地面等战斗场景元素
			-- showMgr.sceneEdgesLine:SetActive(false)
			-- showMgr.sceneEdgesWall:SetActive(false)
			-- showMgr.groundObj:SetActive(false)
			--直接触发剧情初始化，绕过战斗状态机
			storyMgr:initStoryData()
		end)
	end)
end


--设置模型所有节点layer信息
function StoryMgr:SetLayerRecursively(obj, layer)
    -- 设置当前对象的Layer
    obj.layer = layer
    -- 遍历所有子对象
    for i = 0, obj.transform.childCount - 1 do
        local child = obj.transform:GetChild(i)
        self:SetLayerRecursively(child.gameObject, layer)  -- 递归调用
    end
end

--设置当前剧情片段id
function StoryMgr:setNowStoryArraryId(storyArraryId)
	self.nowStoryArraryId = storyArraryId
end

--获取当前剧情片段id
function StoryMgr:getNowStoryArraryId()
	return self.nowStoryArraryId
end

--设置当前剧情片段完成回调
function StoryMgr:setNowStoryEndCallBack(callBack)
	self.nowStoryEndCallBack = callBack
end

--获取当前剧情片段完成回调
function StoryMgr:getNowStoryEndCallBack()
	return self.nowStoryEndCallBack
end

--设置当前家园剧情片段id
function StoryMgr:setNowHomeStoryArraryId(storyArraryId)
	self.nowHomeStoryArraryId = storyArraryId
end

--获取当前家园剧情片段id
function StoryMgr:getNowHomeStoryArraryId()
	return self.nowHomeStoryArraryId
end

--设置当前家园剧情片段完成回调
function StoryMgr:setNowHomeStoryEndCallBack(callBack)
	self.nowHomeStoryEndCallBack = callBack
end

--获取当前家园剧情片段完成回调
function StoryMgr:getNowHomeStoryEndCallBack()
	return self.nowHomeStoryEndCallBack
end

--获取当前是否处于家园剧情中
function StoryMgr:getIsHomeLandStory()
	return self.isHomeLandStory
end

--设置是否需要弹出家园建筑升级弹窗(配合家园建筑升级动画使用)
function StoryMgr:setNeedShowHomeLvUpPanel(needShow)
	self.needShowHomeLvUpPanel = needShow
end

--获取是否需要弹出家园建筑升级弹窗
function StoryMgr:getNeedShowHomeLvUpPanel()
	return self.needShowHomeLvUpPanel
end

--设置家园建筑升级剧情跳过回调
function StoryMgr:setHomeLvUpSkipCallback(callback)
	self.homeLvUpSkipCallback = callback
end

--获取家园建筑升级剧情跳过回调
function StoryMgr:getHomeLvUpSkipCallback()
	return self.homeLvUpSkipCallback
end

function StoryMgr:Clear()
	self.nowStoryArraryId = nil
	self.nowStoryEndCallBack = nil
	self.nowHomeStoryArraryId = nil
	self.nowHomeStoryEndCallBack = nil
end

return StoryMgr