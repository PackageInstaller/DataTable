-- chunkname: @modules/logic/versionactivity2_1/lanshoupa/view/LanShouPaMapViewAnim.lua

module("modules.logic.versionactivity2_1.lanshoupa.view.LanShouPaMapViewAnim", package.seeall)

local LanShouPaMapViewAnim = class("LanShouPaMapViewAnim", BaseView)

function LanShouPaMapViewAnim:onInitView()
	self._goexcessive = gohelper.findChild(self.viewGO, "#go_excessive")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LanShouPaMapViewAnim:addEvents()
	return
end

function LanShouPaMapViewAnim:removeEvents()
	return
end

function LanShouPaMapViewAnim:_editableInitView()
	self._checkTaskMO = Activity164TaskMO.New()
	self._viewAnimator = self.viewGO:GetComponent(LanShouPaEnum.ComponentType.Animator)
	self._rewardAnimator = self:_findAnimator("RightTop/ani")
	self._swicthSceneAnimator = self:_findAnimator("#go_excessive")
	self._path1Mterials = self:_findUIMeshMaterIals("Map/Path1/path_go1")
	self._path2Mterials = self:_findUIMeshMaterIals("Map/Path2/path_go1")
	self._pathMaterialDict = {
		[LanShouPaEnum.Chapter.One] = self._path1Mterials,
		[LanShouPaEnum.Chapter.Two] = self._path2Mterials
	}
	self._propertyBlock = UnityEngine.MaterialPropertyBlock.New()

	self:_initPathAnimParams()
end

function LanShouPaMapViewAnim:_findAnimator(path)
	local go = gohelper.findChild(self.viewGO, path)

	return go:GetComponent(LanShouPaEnum.ComponentType.Animator)
end

function LanShouPaMapViewAnim:_findUIMeshMaterIals(path)
	local go = gohelper.findChild(self.viewGO, path)
	local carray = go:GetComponentsInChildren(LanShouPaEnum.ComponentType.UIMesh, true)
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

function LanShouPaMapViewAnim:onOpen()
	self.addEventCb(self, LanShouPaController.instance, LanShouPaEvent.SelectEpisode, self._onSelectEpisode, self)
	self.addEventCb(self, TaskController.instance, TaskEvent.UpdateTaskList, self._refreshRewardAnim, self)
	self:_refreshUI()
	self:refreshPathPoin()
	self._viewAnimator:Play(UIAnimationName.Open)
end

function LanShouPaMapViewAnim:_onSelectEpisode()
	self:_refreshRewardAnim()
end

function LanShouPaMapViewAnim:_refreshUI()
	self:_refreshRewardAnim()
end

function LanShouPaMapViewAnim:_refreshRewardAnim()
	local isHas = self:_isHasReward()

	if self._lastIsHasReward ~= isHas then
		self._lastIsHasReward = isHas

		self._rewardAnimator:Play(isHas and "loop" or "idle")
	end
end

function LanShouPaMapViewAnim:onClose()
	return
end

function LanShouPaMapViewAnim:playViewAnimator(viewName)
	self._viewAnimator:Play(viewName, 0, 0)
end

function LanShouPaMapViewAnim:onDestroyView()
	if self._pathTweenId then
		ZProj.TweenHelper.KillById(self._pathTweenId)

		self._pathTweenId = nil
	end
end

function LanShouPaMapViewAnim:_isHasReward()
	local taskDict = TaskModel.instance:getAllUnlockTasks(TaskEnum.TaskType.Activity164)

	if taskDict ~= nil then
		local taskCfgList = Activity164Config.instance:getTaskByActId(ChessGameEnum.ActivityId.Act164)
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

LanShouPaMapViewAnim.SWIRCH_SCENE_BLOCK_KEY = "LanShouPaMapViewAnim_switchScene_Key"

function LanShouPaMapViewAnim:switchScene(isNext)
	local tempStart = isNext == true

	if self._isLastSwitchStart ~= tempStart then
		self._isLastSwitchStart = tempStart

		gohelper.setActive(self._goexcessive, true)
		self._swicthSceneAnimator:Play(tempStart and "story" or "hard")

		if not self._isSwitchSceneStartBlock then
			self._isSwitchSceneStartBlock = true

			UIBlockMgr.instance:startBlock(LanShouPaMapViewAnim.SWIRCH_SCENE_BLOCK_KEY)
		else
			TaskDispatcher.cancelTask(self._onHideSwitchScene, self)
		end

		TaskDispatcher.runDelay(self._onHideSwitchScene, self, 1)
	end
end

function LanShouPaMapViewAnim:_onHideSwitchScene()
	self._isSwitchSceneStartBlock = false

	UIBlockMgr.instance:endBlock(LanShouPaMapViewAnim.SWIRCH_SCENE_BLOCK_KEY)
end

function LanShouPaMapViewAnim:_initPathAnimParams()
	self._pathConsDict = {}

	local actId = ChessGameEnum.ActivityId.Act164
	local tActivity164Config = Activity164Config.instance

	for chapterId, paramsList in pairs(LanShouPaEnum.ChapterPathAnimParam) do
		local episodeCfgList = tActivity164Config:getChapterEpisodeList(actId, chapterId)

		if episodeCfgList then
			local preCfgList = tActivity164Config:getChapterEpisodeList(actId, chapterId - 1)
			local nextCfgList = tActivity164Config:getChapterEpisodeList(actId, chapterId + 1)
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

function LanShouPaMapViewAnim:_addPathAnimParams(consList, paramsList, episodeCfg, isEpisode)
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

function LanShouPaMapViewAnim:_getPathPatams(chapterId)
	local consList = self._pathConsDict[chapterId]
	local index = 0
	local curCon

	if consList then
		local tActivity164Model = Activity164Model.instance

		for i, conData in ipairs(consList) do
			if tActivity164Model:isEpisodeClear(conData.episodeCfg.id) or conData.episodeCfg.preEpisode == 0 or tActivity164Model:isEpisodeClear(conData.episodeCfg.preEpisode) and LanShouPaHelper.isOpenChapterDay(conData.episodeCfg.chapterId) then
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

function LanShouPaMapViewAnim:refreshPathPoin()
	for chapterId, materials in pairs(self._pathMaterialDict) do
		local params, index = self:_getPathPatams(chapterId)

		if params and index > 0 then
			self:_setPathMaterialsValue(materials, params[2])
		else
			self:_setPathMaterialsValue(materials, 1)
		end
	end
end

function LanShouPaMapViewAnim:playPathAnim()
	local actId = ChessGameEnum.ActivityId.Act164
	local curEpisodeId = Activity164Model.instance:getCurEpisodeId()
	local episodeCfg = Activity164Config.instance:getEpisodeCo(actId, curEpisodeId)

	if episodeCfg then
		local params, index = self:_getPathPatams(episodeCfg.chapterId)

		if params and index > 0 then
			self:_playPathAnim(self._pathMaterialDict[episodeCfg.chapterId], params)
		end
	end
end

function LanShouPaMapViewAnim:_playPathAnim(materials, params)
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
	self._pathTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, LanShouPaEnum.AnimatorTime.ChapterPath or 1, self._onPathFrame, self._onPathFinish, self, nil, EaseType.Linear)
end

function LanShouPaMapViewAnim:_onPathFrame(t)
	local tempVale = self._tweenParams[1] + (self._tweenParams[2] - self._tweenParams[1]) * t

	self:_setPathMaterialsValue(self._tweenMaterials, tempVale)
end

function LanShouPaMapViewAnim:_onPathFinish()
	local tempVale = self._tweenParams[2]
	local materials = self._tweenMaterials

	self._tweenMaterials = nil
	self._tweenParams = nil

	self:_setPathMaterialsValue(materials, tempVale)
end

function LanShouPaMapViewAnim:_setPathMaterialsValue(materials, value)
	local vector = Vector4.New(value, 0.01, 0, 0)

	for i, material in ipairs(materials) do
		material:SetVector("_DissolveControl", vector)
	end
end

return LanShouPaMapViewAnim
