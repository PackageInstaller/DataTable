-- chunkname: @modules/logic/versionactivity1_3/jialabona/view/JiaLaBoNaMapViewAnim.lua

module("modules.logic.versionactivity1_3.jialabona.view.JiaLaBoNaMapViewAnim", package.seeall)

local JiaLaBoNaMapViewAnim = class("JiaLaBoNaMapViewAnim", BaseView)

function JiaLaBoNaMapViewAnim:onInitView()
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function JiaLaBoNaMapViewAnim:addEvents()
	return
end

function JiaLaBoNaMapViewAnim:removeEvents()
	return
end

function JiaLaBoNaMapViewAnim:_editableInitView()
	self._checkTaskMO = Activity120TaskMO.New()
	self._viewAnimator = self.viewGO:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
	self._rewardAnimator = self:_findAnimator("RightTop/ani")
	self._swicthSceneAnimator = self:_findAnimator("#go_excessive")
	self._path1Mterials = self:_findUIMeshMaterIals("Map/Path1/path_go1")
	self._path2Mterials = self:_findUIMeshMaterIals("Map/Path2/path_go1")
	self._pathMaterialDict = {
		[JiaLaBoNaEnum.Chapter.One] = self._path1Mterials,
		[JiaLaBoNaEnum.Chapter.Two] = self._path2Mterials
	}
	self._propertyBlock = UnityEngine.MaterialPropertyBlock.New()

	self:_initPathAnimParams()
end

function JiaLaBoNaMapViewAnim:_findAnimator(path)
	local go = gohelper.findChild(self.viewGO, path)

	return go:GetComponent(JiaLaBoNaEnum.ComponentType.Animator)
end

function JiaLaBoNaMapViewAnim:_findUIMeshMaterIals(path)
	local go = gohelper.findChild(self.viewGO, path)
	local carray = go:GetComponentsInChildren(JiaLaBoNaEnum.ComponentType.UIMesh, true)
	local luaList = self:getUserDataTb_()

	RoomHelper.cArrayToLuaTable(carray, luaList)

	local materials = self:getUserDataTb_()

	for i, uiMesh in ipairs(luaList) do
		local material = uiMesh.material

		if material then
			table.insert(materials, material)
		end
	end

	return materials
end

function JiaLaBoNaMapViewAnim:onOpen()
	self.addEventCb(self, JiaLaBoNaController.instance, JiaLaBoNaEvent.SelectEpisode, self._onSelectEpisode, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshRewardAnim, self)
	self:_refreshUI()
	self:refreshPathPoin()
	self._viewAnimator:Play(UIAnimationName.Open)
end

function JiaLaBoNaMapViewAnim:_onSelectEpisode()
	self:_refreshRewardAnim()
end

function JiaLaBoNaMapViewAnim:_refreshUI()
	self:_refreshRewardAnim()
end

function JiaLaBoNaMapViewAnim:_refreshRewardAnim()
	local isHas = self:_isHasReward()

	if self._lastIsHasReward ~= isHas then
		self._lastIsHasReward = isHas

		self._rewardAnimator:Play(isHas and "loop" or "idle")
	end
end

function JiaLaBoNaMapViewAnim:onClose()
	return
end

function JiaLaBoNaMapViewAnim:playViewAnimator(viewName)
	self._viewAnimator:Play(viewName, 0, 0)
end

function JiaLaBoNaMapViewAnim:onDestroyView()
	if self._pathTweenId then
		ZProj.TweenHelper.KillById(self._pathTweenId)

		self._pathTweenId = nil
	end
end

function JiaLaBoNaMapViewAnim:_isHasReward()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity120)

	if taskDict ~= nil then
		local taskCfgList = Activity120Config.instance:getTaskByActId(Va3ChessEnum.ActivityId.Act120)
		local mo = self._checkTaskMO

		for _, taskCfg in ipairs(taskCfgList) do
			mo:init(taskCfg, taskDict[taskCfg.id])

			if mo:alreadyGotReward() then
				return true
			end
		end
	end

	return false
end

JiaLaBoNaMapViewAnim.SWIRCH_SCENE_BLOCK_KEY = "JiaLaBoNaMapViewAnim_switchScene_Key"

function JiaLaBoNaMapViewAnim:switchScene(isNext)
	local tempStart = isNext == true

	if self._isLastSwitchStart ~= tempStart then
		self._isLastSwitchStart = tempStart

		gohelper.setActive(self._goexcessive, true)
		self._swicthSceneAnimator:Play(tempStart and "story" or "hard")

		if not self._isSwitchSceneStartBlock then
			self._isSwitchSceneStartBlock = true

			UIBlockMgr.instance:startBlock(JiaLaBoNaMapViewAnim.SWIRCH_SCENE_BLOCK_KEY)
		else
			TaskDispatcher.cancelTask(self._onHideSwitchScene, self)
		end

		TaskDispatcher.runDelay(self._onHideSwitchScene, self, 1)
	end
end

function JiaLaBoNaMapViewAnim:_onHideSwitchScene()
	self._isSwitchSceneStartBlock = false

	UIBlockMgr.instance:endBlock(JiaLaBoNaMapViewAnim.SWIRCH_SCENE_BLOCK_KEY)
end

function JiaLaBoNaMapViewAnim:_initPathAnimParams()
	self._pathConsDict = {}

	local actId = Va3ChessEnum.ActivityId.Act120
	local tActivity120Config = Activity120Config.instance

	for chapterId, paramsList in pairs(JiaLaBoNaEnum.ChapterPathAnimParam) do
		local episodeCfgList = tActivity120Config:getChapterEpisodeList(actId, chapterId)

		if episodeCfgList then
			local preCfgList = tActivity120Config:getChapterEpisodeList(actId, chapterId - 1)
			local nextCfgList = tActivity120Config:getChapterEpisodeList(actId, chapterId + 1)
			local consList = {}

			self._pathConsDict[chapterId] = consList

			if preCfgList and #preCfgList > 0 then
				self:_addPathAnimParams(consList, paramsList, preCfgList[#preCfgList], false)
			end

			for index, episodeCfg in ipairs(episodeCfgList) do
				self:_addPathAnimParams(consList, paramsList, episodeCfg, true)
			end

			if nextCfgList and #nextCfgList > 0 then
				self:_addPathAnimParams(consList, paramsList, nextCfgList[1], false)
			end
		end
	end
end

function JiaLaBoNaMapViewAnim:_addPathAnimParams(consList, paramsList, episodeCfg, isEpisode)
	local index = #consList + 1

	if index <= #paramsList then
		local consData = {
			pathParams = paramsList[index],
			isEpisode = isEpisode,
			episodeCfg = episodeCfg
		}

		table.insert(consList, consData)
	end
end

function JiaLaBoNaMapViewAnim:_getPathPatams(chapterId)
	local consList = self._pathConsDict[chapterId]
	local index = 0
	local curCon

	if consList then
		local tActivity120Model = Activity120Model.instance

		for i, conData in ipairs(consList) do
			if tActivity120Model:isEpisodeClear(conData.episodeCfg.id) or conData.episodeCfg.preEpisode == 0 or tActivity120Model:isEpisodeClear(conData.episodeCfg.preEpisode) and JiaLaBoNaHelper.isOpenChapterDay(conData.episodeCfg.chapterId) then
				index = i
				curCon = conData
			end
		end
	end

	if curCon then
		return curCon.pathParams, index
	end

	return nil, index
end

function JiaLaBoNaMapViewAnim:refreshPathPoin()
	for chapterId, materials in pairs(self._pathMaterialDict) do
		local params, index = self:_getPathPatams(chapterId)

		if params and index > 0 then
			self:_setPathMaterialsValue(materials, params[2])
		else
			self:_setPathMaterialsValue(materials, 1)
		end
	end
end

function JiaLaBoNaMapViewAnim:playPathAnim()
	local actId = Va3ChessEnum.ActivityId.Act120
	local curEpisodeId = Activity120Model.instance:getCurEpisodeId()
	local episodeCfg = Activity120Config.instance:getEpisodeCo(actId, curEpisodeId)

	if episodeCfg then
		local params, index = self:_getPathPatams(episodeCfg.chapterId)

		if params and index > 0 then
			self:_playPathAnim(self._pathMaterialDict[episodeCfg.chapterId], params)
		end
	end
end

function JiaLaBoNaMapViewAnim:_playPathAnim(materials, params)
	if not materials or not params then
		return
	end

	if self._tweenMaterials and self._tweenParams then
		self:_onPathFinish()
	end

	if self._pathTweenId then
		ZProj.TweenHelper.KillById(self._pathTweenId)

		self._pathTweenId = nil
	end

	self._tweenMaterials = materials
	self._tweenParams = params
	self._pathTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, JiaLaBoNaEnum.AnimatorTime.ChapterPath or 1, self._onPathFrame, self._onPathFinish, self, nil, EaseType.Linear)
end

function JiaLaBoNaMapViewAnim:_onPathFrame(t)
	local tempVale = self._tweenParams[1] + (self._tweenParams[2] - self._tweenParams[1]) * t

	self:_setPathMaterialsValue(self._tweenMaterials, tempVale)
end

function JiaLaBoNaMapViewAnim:_onPathFinish()
	local tempVale = self._tweenParams[2]
	local materials = self._tweenMaterials

	self._tweenMaterials = nil
	self._tweenParams = nil

	self:_setPathMaterialsValue(materials, tempVale)
end

function JiaLaBoNaMapViewAnim:_setPathMaterialsValue(materials, value)
	local vector = Vector4.New(value, 0.01, 0, 0)

	for i, material in ipairs(materials) do
		material:SetVector("_DissolveControl", vector)
	end
end

return JiaLaBoNaMapViewAnim
