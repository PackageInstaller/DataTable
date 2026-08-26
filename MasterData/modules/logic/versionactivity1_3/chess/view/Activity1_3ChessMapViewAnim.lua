-- chunkname: @modules/logic/versionactivity1_3/chess/view/Activity1_3ChessMapViewAnim.lua

module("modules.logic.versionactivity1_3.chess.view.Activity1_3ChessMapViewAnim", package.seeall)

local Activity1_3ChessMapViewAnim = class("Activity1_3ChessMapViewAnim", BaseView)

function Activity1_3ChessMapViewAnim:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity1_3ChessMapViewAnim:addEvents()
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.ShowPassEpisodeEffect, self.playPathAnim, self)
	self.addEventCb(self, Activity1_3ChessController.instance, Activity1_3ChessEvent.SetNodePathEffectToPassNode, self.refreshPathToPassNode, self)
end

function Activity1_3ChessMapViewAnim:removeEvents()
	return
end

function Activity1_3ChessMapViewAnim:_editableInitView()
	self._path1Mterials = self:_findUIMeshMaterIals("Map/Path1/path_go")
	self._path2Mterials = self:_findUIMeshMaterIals("Map/Path2/path_go")
	self._pathMaterialDict = {
		self._path1Mterials,
		self._path2Mterials
	}

	self:_initPathAnimParams()
end

function Activity1_3ChessMapViewAnim:_findUIMeshMaterIals(path)
	local go = gohelper.findChild(self.viewGO, path)
	local carray = go:GetComponentsInChildren(typeof(UIMesh), true)
	local luaList = self:getUserDataTb_()

	RoomHelper.cArrayToLuaTable(carray, luaList)

	local materials = self:getUserDataTb_()

	for i, uiMesh in ipairs(luaList) do
		local material = uiMesh.material

		if material then
			materials[#materials + 1] = material
		end
	end

	return materials
end

local ChapterPathAnimParam = {
	{
		{
			1,
			0.89
		},
		{
			0.89,
			0.78
		},
		{
			0.78,
			0.54
		},
		{
			0.54,
			0.27
		},
		{
			0.27,
			0
		}
	},
	{
		{
			1,
			0.89
		},
		{
			0.89,
			0.74
		},
		{
			0.74,
			0.52
		},
		{
			0.52,
			0.24
		},
		{
			0.24,
			0
		}
	}
}

function Activity1_3ChessMapViewAnim:_initPathAnimParams()
	self._pathConsDict = {}

	local actId = Va3ChessEnum.ActivityId.Act122
	local tActivity122Config = Activity122Config.instance

	for chapterId, paramsList in pairs(ChapterPathAnimParam) do
		local episodeCfgList = tActivity122Config:getChapterEpisodeList(actId, chapterId)

		if episodeCfgList then
			local preCfgList = tActivity122Config:getChapterEpisodeList(actId, chapterId - 1)
			local nextCfgList = tActivity122Config:getChapterEpisodeList(actId, chapterId + 1)
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

function Activity1_3ChessMapViewAnim:_addPathAnimParams(consList, paramsList, episodeCfg, isEpisode)
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

function Activity1_3ChessMapViewAnim:onOpen()
	if not self._pathToPassNode then
		self:refreshPathToOpenNode()
	end
end

function Activity1_3ChessMapViewAnim:onSetVisible(visible)
	if visible then
		-- block empty
	end
end

function Activity1_3ChessMapViewAnim:onDestroyView()
	if self._pathTweenId then
		ZProj.TweenHelper.KillById(self._pathTweenId)

		self._pathTweenId = nil
	end
end

function Activity1_3ChessMapViewAnim:refreshPathToOpenNode()
	for chapterId, materials in pairs(self._pathMaterialDict) do
		local params, index = self:_getPathPatams(chapterId)

		if params and index > 0 then
			self:_setPathMaterialsValue(materials, params[2])
		else
			self:_setPathMaterialsValue(materials, 1)
		end
	end
end

function Activity1_3ChessMapViewAnim:refreshPathToPassNode()
	self._pathToPassNode = true

	for chapterId, materials in pairs(self._pathMaterialDict) do
		local params, index = self:_getPathPatams(chapterId)

		if params and index > 0 then
			self:_setPathMaterialsValue(materials, params[1])
		else
			self:_setPathMaterialsValue(materials, 1)
		end
	end
end

function Activity1_3ChessMapViewAnim:playPathAnim()
	self._pathToPassNode = false

	local actId = Va3ChessEnum.ActivityId.Act122
	local curEpisodeId = Activity122Model.instance:getCurEpisodeId()
	local episodeCfg = Activity122Config.instance:getEpisodeCo(actId, curEpisodeId)

	if episodeCfg then
		local params, index = self:_getPathPatams(episodeCfg.chapterId)

		if params and index > 0 then
			self:_playPathAnim(self._pathMaterialDict[episodeCfg.chapterId], params)
		end
	end
end

function Activity1_3ChessMapViewAnim:_playPathAnim(materials, params)
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
	self._pathTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 2, self._onPathFrame, self._onPathFinish, self, nil, EaseType.Linear)
end

function Activity1_3ChessMapViewAnim:_onPathFrame(t)
	local tempVale = self._tweenParams[1] + (self._tweenParams[2] - self._tweenParams[1]) * t

	self:_setPathMaterialsValue(self._tweenMaterials, tempVale)
end

function Activity1_3ChessMapViewAnim:_onPathFinish()
	local tempVale = self._tweenParams[2]
	local materials = self._tweenMaterials

	self._tweenMaterials = nil
	self._tweenParams = nil

	self:_setPathMaterialsValue(materials, tempVale)
end

function Activity1_3ChessMapViewAnim:_setPathMaterialsValue(materials, value)
	local vector = Vector4.New(value, 0.01, 0, 0)

	for i, material in ipairs(materials) do
		material:SetVector("_DissolveControl", vector)
	end
end

function Activity1_3ChessMapViewAnim:_getPathPatams(chapterId)
	local consList = self._pathConsDict[chapterId]
	local index = 0
	local curCon

	if consList then
		for i, conData in ipairs(consList) do
			if conData.isEpisode then
				local curEpisodeOpenNode = Activity122Model.instance:isEpisodeOpen(conData.episodeCfg.id)
				local isNextChapterNode = not conData.isEpisode and Activity1_3ChessController.instance:isChapterOpen(conData.episodeCfg.chapterId)

				if curEpisodeOpenNode or isNextChapterNode then
					index = i
					curCon = conData
				end
			end
		end
	end

	if curCon then
		return curCon.pathParams, index
	end

	return nil, index
end

return Activity1_3ChessMapViewAnim
