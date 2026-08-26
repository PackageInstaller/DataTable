-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotResultView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotResultView", package.seeall)

local V1a6_CachotResultView = class("V1a6_CachotResultView", BaseView)

function V1a6_CachotResultView:onInitView()
	self._goresult = gohelper.findChild(self.viewGO, "#go_result")
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#go_result/#simage_levelbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_result/#btn_close")
	self._gosuccess = gohelper.findChild(self.viewGO, "#go_result/left/#go_success")
	self._txtending = gohelper.findChildText(self.viewGO, "#go_result/left/#txt_ending")
	self._gofailed = gohelper.findChild(self.viewGO, "#go_result/left/#go_failed")
	self._txtroom = gohelper.findChildText(self.viewGO, "#go_result/left/#txt_room")
	self._txtlevel = gohelper.findChildText(self.viewGO, "#go_result/left/#txt_level")
	self._txtmode = gohelper.findChildText(self.viewGO, "#go_result/left/#txt_mode")
	self._goscore = gohelper.findChild(self.viewGO, "#go_result/right/#go_score")
	self._txtscore = gohelper.findChildText(self.viewGO, "#go_result/right/#go_score/#txt_score")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#go_result/right/#scroll_view")
	self._gomemberitem = gohelper.findChild(self.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem")
	self._txtmembernum = gohelper.findChildText(self.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem/title/titlebg/txt/#txt_membernum")
	self._gorolehead = gohelper.findChild(self.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem/container/#go_rolehead")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem")
	self._txtcollectionnum = gohelper.findChildText(self.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem/title/titlebg/txt/#txt_collectionnum")
	self._gocollection = gohelper.findChild(self.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem/container/#go_collection")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#go_result/#simage_title")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_result/#simage_title/#txt_title")
	self._simagecg = gohelper.findChildSingleImage(self.viewGO, "#go_result/left/#go_success/#simage_cg")
	self._godoubletag = gohelper.findChild(self.viewGO, "#go_result/right/#go_score/#go_doubletag")
	self._goempty = gohelper.findChild(self.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_collectionitem/container/#go_empty")
	self._txtmax = gohelper.findChildText(self.viewGO, "#go_result/right/#go_score/#txt_max")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V1a6_CachotResultView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V1a6_CachotResultView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotResultView:_editableInitView()
	self._goHeroScrollContent = gohelper.findChild(self.viewGO, "#go_result/right/#scroll_view/Viewport/Content/#go_memberitem/container")
end

function V1a6_CachotResultView:onUpdateParam()
	return
end

function V1a6_CachotResultView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_clearing_unfold)
	self:refreshUI()
end

function V1a6_CachotResultView:refreshUI()
	local rogueEndInfo = V1a6_CachotModel.instance:getRogueEndingInfo()

	if rogueEndInfo then
		if not rogueEndInfo._isFinish then
			local isFinish = false

			gohelper.setActive(self._gosuccess, isFinish)
			gohelper.setActive(self._gofailed, not isFinish)
			self:refreshHeroGroup(rogueEndInfo)
			self:refreshChallengeInfo(rogueEndInfo)
			self:refreshCollections(rogueEndInfo)
		end
	end
end

function V1a6_CachotResultView:refreshHeroGroup(rogueEndInfo)
	if rogueEndInfo then
		if not rogueEndInfo._heros then
			local heroList = {}

			table.sort(heroList, self.heroListSortFunc)
			gohelper.CreateObjList(self, self._refreshSingleHero, heroList, self._goHeroScrollContent, self._gorolehead)

			if heroList then
				self._txtmembernum.text = #heroList or 0
			end
		end
	end
end

function V1a6_CachotResultView.heroListSortFunc(a, b)
	return b < a
end

function V1a6_CachotResultView:_refreshSingleHero(obj, heroId, index)
	local icon = gohelper.findChildImage(obj, "image_icon")
	local heroCfg = HeroConfig.instance:getHeroCO(heroId)

	if heroCfg then
		local skinConfig = FightConfig.instance:getSkinCO(heroCfg.skinId)

		gohelper.getSingleImage(icon.gameObject):LoadImage(ResUrl.roomHeadIcon(skinConfig.retangleIcon))
	end
end

function V1a6_CachotResultView:refreshCollections(rogueEndInfo)
	local collectionList = rogueEndInfo and rogueEndInfo._collections

	if collectionList then
		for k, collectionId in ipairs(collectionList) do
			local collection = gohelper.cloneInPlace(self._gocollection, "collectionItem_" .. k)

			gohelper.setActive(collection, true)

			local icon = gohelper.findChildSingleImage(collection, "simage_icon")
			local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(collectionId)

			if collectionCfg then
				icon.curImageUrl = nil

				icon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. collectionCfg.icon))
			end
		end
	end

	if collectionList then
		if not #collectionList then
			local collectionNum = 0

			gohelper.setActive(self._goempty, collectionNum <= 0)

			self._txtcollectionnum.text = collectionNum
		end
	end
end

function V1a6_CachotResultView:refreshChallengeInfo(rogueEndInfo)
	if rogueEndInfo then
		self:refreshScoreInfo(rogueEndInfo._score, rogueEndInfo._doubleScore)
		self:refreshRoomInfo(rogueEndInfo._roomNum, rogueEndInfo._roomId)
		self:refreshDifficultyInfo(rogueEndInfo._difficulty)
		self:refreshEndingInfo(rogueEndInfo._ending)
	end
end

function V1a6_CachotResultView:refreshScoreInfo(score, doubleScore)
	score = score or 0
	doubleScore = doubleScore or 0

	local rogueStateInfo = V1a6_CachotModel.instance:getRogueStateInfo()
	local isScoreFull = self:checkScoreIsFull(rogueStateInfo)
	local isAllStageUnlock = self:checkIsUnlockAllStage(rogueStateInfo)
	local scoreTxtInfo = ""

	if doubleScore > 0 then
		local singleScore = Mathf.Clamp(score - doubleScore, 0, score)

		scoreTxtInfo = string.format("%s(+%s)", singleScore, doubleScore)
	else
		scoreTxtInfo = isScoreFull and score <= 0 and "0(MAX)" or string.format("%s", score)
	end

	gohelper.setActive(self._godoubletag, doubleScore > 0)

	self._txtscore.text = scoreTxtInfo

	self:refreshMaxScoreTips(isScoreFull, isAllStageUnlock)
end

function V1a6_CachotResultView:checkScoreIsFull(rogueStateInfo)
	if rogueStateInfo then
		if not rogueStateInfo.scoreLimit then
			local scoreLimit = 0

			if rogueStateInfo then
				if not rogueStateInfo.totalScore then
					local totalScore = 0

					return scoreLimit <= totalScore
				end
			end
		end
	end
end

function V1a6_CachotResultView:checkIsUnlockAllStage(rogueStateInfo)
	return (rogueStateInfo or nil) and (not rogueStateInfo.nextStageSecond or tonumber(rogueStateInfo.nextStageSecond) < 0)
end

function V1a6_CachotResultView:refreshMaxScoreTips(isScoreFull, isAllStageUnlock)
	gohelper.setActive(self._txtmax.gameObject, isScoreFull)

	if isScoreFull then
		self._txtmax.text = isAllStageUnlock and luaLang("v1a6_cachotresultview_unlockAndMax") or luaLang("v1a6_cachotresultview_lockAndMax")
	end
end

function V1a6_CachotResultView:refreshDifficultyInfo(difficulty)
	if lua_rogue_difficulty.configDict then
		if lua_rogue_difficulty.configDict then
			if not lua_rogue_difficulty.configDict.title then
				local difficultyTitle = ""
				local tag = {
					difficulty,
					difficultyTitle
				}

				self._txtmode.text = GameUtil.getSubPlaceholderLuaLang(luaLang("cachotresultview_selectdifficult"), tag)
			end
		end
	end
end

function V1a6_CachotResultView:refreshRoomInfo(roomNum, roomId)
	if lua_rogue_room.configDict then
		if lua_rogue_room.configDict then
			self._txtlevel.text = lua_rogue_room.configDict.name or ""
		end

		self._txtroom.text = formatLuaLang("v1a6_cachotresultview_roomNum", roomNum or 0)
	end
end

function V1a6_CachotResultView:refreshEndingInfo(endingId)
	local endingCfg = lua_rogue_ending.configDict[endingId]

	if endingCfg then
		self._txtending.text = tostring(endingCfg.title)

		self._simagecg:LoadImage(ResUrl.getV1a6CachotIcon(endingCfg.resultIcon))
	end

	gohelper.setActive(self._txtending.gameObject, endingCfg ~= nil)
end

function V1a6_CachotResultView:onClose()
	V1a6_CachotModel.instance:clearRogueEndingInfo()

	if not LoginController.instance:isEnteredGame() then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Cachot then
		local levelId = GameSceneMgr.instance:getCurScene():getCurLevelId()

		if levelId ~= 90001 then
			ViewMgr.instance:closeView(ViewName.V1a6_CachotRoomView)
			V1a6_CachotController.instance:openV1a6_CachotMainView()
			AudioBgmManager.instance:modifyBgmAudioId(AudioBgmEnum.Layer.Cachot, AudioEnum.Bgm.CachotMainScene)
			GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, 90001, true, true)
		end
	end
end

function V1a6_CachotResultView:onDestroyView()
	return
end

return V1a6_CachotResultView
