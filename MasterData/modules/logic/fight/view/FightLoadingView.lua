-- chunkname: @modules/logic/fight/view/FightLoadingView.lua

module("modules.logic.fight.view.FightLoadingView", package.seeall)

local FightLoadingView = class("FightLoadingView", BaseView)

function FightLoadingView:onInitView()
	self._gocanvasgroup = gohelper.findChild(self.viewGO, "#go_canvasgroup")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "#go_canvasgroup/center/name/#txt_namecn")
	self._gonameen = gohelper.findChild(self.viewGO, "#go_canvasgroup/center/name/#txt_namecn/eye/#go_nameEn")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_canvasgroup/center/name/#txt_namecn/eye/#go_nameEn/#txt_nameen")
	self._txtContent = gohelper.findChildText(self.viewGO, "#go_canvasgroup/center/tips/#txt_describe")
	self._simagenamebg = gohelper.findChildSingleImage(self.viewGO, "#go_canvasgroup/center/#simage_namebg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightLoadingView:addEvents()
	return
end

function FightLoadingView:removeEvents()
	return
end

function FightLoadingView:_editableInitView()
	self._simagenamebg:LoadImage(ResUrl.getFightLoadingIcon("bg_biaotiheiying"))

	self._canvasGroup = self._gocanvasgroup:GetComponent(typeof(UnityEngine.CanvasGroup))

	PostProcessingMgr.instance:setBlurWeight(1)

	self._scene = GameSceneMgr.instance:getCurScene()

	self._scene.director:registerCallback(FightSceneEvent.OnPrepareFinish, self._delayClose, self)
end

function FightLoadingView:onOpen()
	self._sceneId = self.viewParam
	self._sceneConfig = self._sceneId and lua_scene.configDict[self._sceneId]

	self:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Mapopen)
end

function FightLoadingView:_refreshUI()
	self:_setRandomText()

	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam and fightParam.episodeId

	if episodeId then
		::label_6_0::

		local episodeConfig = DungeonConfig.instance:getEpisodeCO(episodeId)

		if episodeConfig and episodeConfig.type == DungeonEnum.EpisodeType.WeekWalk then
			local mapId = WeekWalkModel.instance:getCurMapId()

			if not WeekWalkModel.isShallowMap(mapId) then
				local mapInfo = WeekWalkModel.instance:getCurMapInfo()
				local sceneConfig = lua_weekwalk_scene.configDict[mapInfo.sceneId]

				self:_setName(sceneConfig.typeName, "LIMBO")

				return
			end
		end

		if self._sceneConfig then
			self:_setName(self._sceneConfig.name, self._sceneConfig.nameen)
		end
	end
end

function FightLoadingView:_setName(cnName, enName)
	local nameEnWidth = GameUtil.getTextWidthByLine(self._txtnamecn, cnName, 120) / 2 + 100

	recthelper.setWidth(self._gonameen.transform, nameEnWidth)

	self._txtnamecn.text = cnName
	self._txtnameen.text = enName
end

function FightLoadingView:_delayClose()
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.3, self._onFrame, self._onFinish, self, nil, EaseType.Linear)
end

function FightLoadingView:onClose()
	return
end

function FightLoadingView:_onFrame(value)
	self._canvasGroup.alpha = value
end

function FightLoadingView:_onFinish()
	self:closeThis()
end

function FightLoadingView:onDestroyView()
	self._scene.director:unregisterCallback(FightSceneEvent.OnPrepareFinish, self._delayClose, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	PostProcessingMgr.instance:setBlurWeight(1)
	self._simagenamebg:UnLoadImage()
end

function FightLoadingView:_setRandomText()
	local textCoList = self:_getFitTips()
	local txtCo = self:_getRandomCO(textCoList)

	if txtCo then
		self._txtContent.text = txtCo.content
	end
end

function FightLoadingView:_getFitTips()
	local sceneType = LoadingView.getLoadingSceneType(SceneType.Fight)
	local level = PlayerModel.instance:getPlayerLevel()
	local fits = {}

	for _, v in pairs(SceneConfig.instance:getLoadingTexts()) do
		local scenes = FightStrUtil.instance:getSplitToNumberCache(v.scenes, "#")

		for _, scene in pairs(scenes) do
			if scene == sceneType then
				if level == 0 then
					table.insert(fits, v)
				elseif level >= v.unlocklevel then
					table.insert(fits, v)
				end
			end
		end
	end

	return fits
end

function FightLoadingView:_getRandomCO(list)
	local totalWeight = 0

	for _, co in ipairs(list) do
		totalWeight = totalWeight + co.weight
	end

	local rand = math.floor(math.random() * totalWeight)

	for _, co in ipairs(list) do
		if rand < co.weight then
			return co
		else
			rand = rand - co.weight
		end
	end

	local count = #list

	if count > 1 then
		local randIndex = math.random(1, count)

		return list[randIndex]
	elseif count == 1 then
		return list[1]
	end
end

return FightLoadingView
