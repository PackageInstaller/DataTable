-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/view/VersionActivity1_3DungeonMapSceneElements.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonMapSceneElements", package.seeall)

local VersionActivity1_3DungeonMapSceneElements = class("VersionActivity1_3DungeonMapSceneElements", DungeonMapSceneElements)

function VersionActivity1_3DungeonMapSceneElements:_editableInitView()
	VersionActivity1_3DungeonMapSceneElements.super._editableInitView(self)

	self._dailyElementList = self:getUserDataTb_()
	self._dailyElementMats = self:getUserDataTb_()
	self._tweenList = {}
	self._matKey = UnityEngine.Shader.PropertyToID("_MainCol")
end

function VersionActivity1_3DungeonMapSceneElements:onOpen()
	self.activityDungeonMo = self.viewContainer.versionActivityDungeonBaseMo

	VersionActivity1_3DungeonMapSceneElements.super.onOpen(self)
	self.addEventCb(self, VersionActivity1_3DungeonController.instance, VersionActivity1_3DungeonEvent.SelectChangeDaily, self._onSelectChangeDaily, self)
	self.addEventCb(self, VersionActivity1_3DungeonController.instance, VersionActivity1_3DungeonEvent.LoadSameScene, self._onLoadSameScene, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnInitElements, self._initElements, self)
end

function VersionActivity1_3DungeonMapSceneElements:_onLoadSameScene()
	self:_checkTryFocusDaily()
end

function VersionActivity1_3DungeonMapSceneElements:_onSelectChangeDaily(episodeId)
	for k, tweenInfo in pairs(self._tweenList) do
		if tweenInfo.tweenId then
			ZProj.TweenHelper.KillById(tweenInfo.tweenId)

			tweenInfo.tweenId = nil
		end

		if tweenInfo.to == 0 then
			tweenInfo.comp:hide()
		end
	end

	local oldComp, newComp

	for k, comp in pairs(self._dailyElementList) do
		if comp:getVisible() then
			oldComp = comp
		end

		comp:setWenHaoGoVisible(false)

		if k == episodeId then
			comp:show()

			newComp = comp
		else
			comp:hide()
		end
	end

	if not oldComp or not newComp or oldComp == newComp then
		return
	end

	self:_tweenAlpha(oldComp, 1, 0)
	self:_tweenAlpha(newComp, 0, 1)
end

function VersionActivity1_3DungeonMapSceneElements:_tweenAlpha(comp, from, to)
	comp:show()

	local tweenInfo = self._tweenList[comp]

	if not tweenInfo then
		self:_cloneMats(comp)

		tweenInfo = {}
		self._tweenList[comp] = tweenInfo
		tweenInfo.comp = comp
		tweenInfo.mats = self._dailyElementMats[comp]
		tweenInfo.color = Color.white
	end

	tweenInfo.from = from
	tweenInfo.to = to
	tweenInfo.tweenId = ZProj.TweenHelper.DOTweenFloat(tweenInfo.color.a, to, 0.5, self._tweenFrame, self._tweenFinish, self, tweenInfo, EaseType.Linear)
end

function VersionActivity1_3DungeonMapSceneElements:_tweenFrame(value, tweenInfo)
	tweenInfo.color.a = value

	local mats = tweenInfo.mats

	if not mats then
		return
	end

	for k, mat in pairs(mats) do
		mat:SetColor(self._matKey, tweenInfo.color)
	end
end

function VersionActivity1_3DungeonMapSceneElements:_tweenFinish(tweenInfo)
	local comp = tweenInfo.comp

	tweenInfo.color.a = tweenInfo.to

	if tweenInfo.to == 0 then
		comp:hide()
	end

	local mats = tweenInfo.mats

	if not mats then
		return
	end

	for k, mat in pairs(mats) do
		mat:SetColor(self._matKey, tweenInfo.color)
	end
end

function VersionActivity1_3DungeonMapSceneElements:_cloneMats(comp)
	local go = comp:getItemGo()

	if gohelper.isNil(go) then
		return
	end

	if self._dailyElementMats[comp] then
		return
	end

	local matList = {}
	local meshRenderer = go:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))

	for index = 0, meshRenderer.Length - 1 do
		local mat = meshRenderer[index].material
		local cloneMat = UnityEngine.Object.Instantiate(mat)

		meshRenderer[index].material = cloneMat

		table.insert(matList, cloneMat)
	end

	self._dailyElementMats[comp] = matList
end

function VersionActivity1_3DungeonMapSceneElements:_setEpisodeListVisible(value)
	VersionActivity1_3DungeonMapSceneElements.super._setEpisodeListVisible(self, value)

	local remainNum, _ = Activity126Model.instance:getRemainNum()

	for k, comp in pairs(self._dailyElementList) do
		if comp:getVisible() then
			comp:setWenHaoGoVisible(remainNum > 0)
		end
	end
end

function VersionActivity1_3DungeonMapSceneElements:_getElements(mapId)
	local result = {}

	if self.activityDungeonMo.mode == VersionActivityDungeonBaseEnum.DungeonMode.Hard then
		return result
	end

	local list = DungeonMapModel.instance:getAllElements()

	for i, v in pairs(list) do
		local cfg = DungeonConfig.instance:getChapterMapElement(v)

		if self.activityDungeonMo.mode ~= VersionActivityDungeonBaseEnum.DungeonMode.Hard and cfg.type == DungeonEnum.ElementType.DailyEpisode and mapId >= cfg.mapId and self.activityDungeonMo.episodeId ~= VersionActivity1_3DungeonEnum.ExtraEpisodeId then
			local id = tonumber(cfg.param)
			local dailyConfig = id and lua_activity126_episode_daily.configDict[id]

			if dailyConfig then
				table.insert(result, cfg)
			end
		elseif cfg.mapId == mapId then
			table.insert(result, cfg)
		end
	end

	return result
end

function VersionActivity1_3DungeonMapSceneElements:_showElements(mapId)
	if not self._sceneGo or self._lockShowElementAnim then
		return
	end

	if VersionActivity1_3DungeonController.instance.directFocusDaily then
		self._skipShowElementAnim = true
	end

	local elementsList = self:_getElements(mapId)
	local newElements = DungeonMapModel.instance:getNewElements()
	local animElements = {}
	local normalElements = {}

	for i, config in ipairs(elementsList) do
		if config.type ~= DungeonEnum.ElementType.DailyEpisode then
			if config.showCamera == 1 and not self._skipShowElementAnim and (newElements and tabletool.indexOf(newElements, config.id) or self._forceShowElementAnim) then
				table.insert(animElements, config.id)
			else
				table.insert(normalElements, config)
			end
		end
	end

	self:_showElementAnim(animElements, normalElements)
	DungeonMapModel.instance:clearNewElements()
end

function VersionActivity1_3DungeonMapSceneElements:_addElement(elementConfig)
	if self._elementList[elementConfig.id] then
		return
	end

	local go = UnityEngine.GameObject.New(tostring(elementConfig.id))

	gohelper.addChild(self._elementRoot, go)

	local elementComp = MonoHelper.addLuaComOnceToGo(go, DungeonMapElement, {
		elementConfig,
		self._mapScene,
		self
	})

	self._elementList[elementConfig.id] = elementComp

	if elementConfig.type == DungeonEnum.ElementType.DailyEpisode then
		self._dailyElementList[tonumber(elementConfig.param)] = elementComp

		elementComp:hide()
	end

	if elementComp:showArrow() then
		local itemPath = self.viewContainer:getSetting().otherRes[5]
		local itemGo = self:getResInst(itemPath, self._goarrow)
		local rotationGo = gohelper.findChild(itemGo, "mesh")
		local rx, ry, rz = transformhelper.getLocalRotation(rotationGo.transform)
		local arrowClick = gohelper.getClick(gohelper.findChild(itemGo, "click"))

		arrowClick:AddClickListener(self._arrowClick, self, elementConfig.id)

		self._arrowList[elementConfig.id] = {
			go = itemGo,
			rotationTrans = rotationGo.transform,
			initRotation = {
				rx,
				ry,
				rz
			},
			arrowClick = arrowClick
		}

		self:_updateArrow(elementComp)
	end
end

function VersionActivity1_3DungeonMapSceneElements:_onAddAnimElementDone()
	local dailyEpisodeId = Activity126Model.instance:getShowDailyId()
	local comp = self._dailyElementList[dailyEpisodeId]

	if comp then
		comp:show()

		local remainNum, _ = Activity126Model.instance:getRemainNum()

		comp:setWenHaoGoVisible(remainNum > 0)
	end

	if not ViewMgr.instance:isOpen(ViewName.VersionActivity1_3DungeonChangeView) then
		self:_checkTryFocusDaily()
	end
end

function VersionActivity1_3DungeonMapSceneElements:_checkTryFocusDaily()
	if self._tryFocusDaily then
		self:focusDaily()

		self._tryFocusDaily = nil
	end
end

function VersionActivity1_3DungeonMapSceneElements:focusDaily()
	self._tryFocusDaily = true

	if self.viewContainer.viewParam and self.viewContainer.viewParam.showDaily then
		return
	end

	for k, comp in pairs(self._dailyElementList) do
		if comp:getVisible() then
			self._tryFocusDaily = nil

			self:clickElement(comp:getElementId())

			return
		end
	end
end

function VersionActivity1_3DungeonMapSceneElements:_onCloseViewFinish(viewName)
	if viewName == ViewName.VersionActivity1_3DungeonChangeView then
		self:_checkTryFocusDaily()
	end
end

function VersionActivity1_3DungeonMapSceneElements:onClose()
	for k, tweenInfo in pairs(self._tweenList) do
		if tweenInfo.tweenId then
			ZProj.TweenHelper.KillById(tweenInfo.tweenId)

			tweenInfo.tweenId = nil
		end
	end
end

return VersionActivity1_3DungeonMapSceneElements
