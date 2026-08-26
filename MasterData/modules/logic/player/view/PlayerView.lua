-- chunkname: @modules/logic/player/view/PlayerView.lua

module("modules.logic.player.view.PlayerView", package.seeall)

local PlayerView = class("PlayerView", BaseView)

function PlayerView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bgroot")
	self._txtentryday = gohelper.findChildText(self.viewGO, "leftside/playerinfo/#txt_entryday")
	self._txtepisodeprogress = gohelper.findChildText(self.viewGO, "leftside/txtContainer/progress/#txt_episodeprogress")
	self._txtepisodeprogressen = gohelper.findChildText(self.viewGO, "leftside/txtContainer/progress/#txt_episodeprogressen")
	self._simageheadicon = gohelper.findChildSingleImage(self.viewGO, "leftside/playerinfo/headframe/#simage_headicon")
	self._btnheadicon = gohelper.findChildButtonWithAudio(self.viewGO, "leftside/playerinfo/headframe/#simage_headicon")
	self._goframenode = gohelper.findChild(self.viewGO, "leftside/playerinfo/headframe/#simage_headicon/#go_framenode")
	self._txtlevel = gohelper.findChildText(self.viewGO, "leftside/playerinfo/lv/#txt_level")
	self._txtexp = gohelper.findChildText(self.viewGO, "leftside/playerinfo/#txt_exp")
	self._imageexp = gohelper.findChildSlider(self.viewGO, "leftside/playerinfo/#slider_exp")
	self._txtplayerid = gohelper.findChildText(self.viewGO, "leftside/playerinfo/#txt_playerid")
	self._btnplayerid = gohelper.findChildButtonWithAudio(self.viewGO, "leftside/playerinfo/#txt_playerid/#btn_playerid")
	self._txtname = gohelper.findChildText(self.viewGO, "leftside/playerinfo/#txt_name")
	self._gosignature = gohelper.findChild(self.viewGO, "leftside/playerinfo/signature")
	self._txtsignature = gohelper.findChildText(self.viewGO, "leftside/playerinfo/signature/scroll/viewport/#txt_signature")
	self._btnsignature = gohelper.findChildButtonWithAudio(self.viewGO, "leftside/playerinfo/signature/#btn_signature")
	self._btnshowcharacterA1 = gohelper.findChildButtonWithAudio(self.viewGO, "showcharacters/showcharacter1/#btn_Add")
	self._btnshowcharacterA2 = gohelper.findChildButtonWithAudio(self.viewGO, "showcharacters/showcharacter2/#btn_Add")
	self._btnshowcharacterA3 = gohelper.findChildButtonWithAudio(self.viewGO, "showcharacters/showcharacter3/#btn_Add")
	self._btnshowcharacterB1 = gohelper.findChildButtonWithAudio(self.viewGO, "showcharacters/showcharacter1/#btn_Character")
	self._btnshowcharacterB2 = gohelper.findChildButtonWithAudio(self.viewGO, "showcharacters/showcharacter2/#btn_Character")
	self._btnshowcharacterB3 = gohelper.findChildButtonWithAudio(self.viewGO, "showcharacters/showcharacter3/#btn_Character")
	self._btnmodifyname = gohelper.findChildButtonWithAudio(self.viewGO, "leftside/playerinfo/#txt_name/#btn_modifyname")
	self._btncollection = gohelper.findChildButton(self.viewGO, "collection")
	self._btncloseCollectText = gohelper.findChildButton(self.viewGO, "collection/#btn_closeCollectText")
	self._btnchangebg = gohelper.findChildButton(self.viewGO, "btn_changebg/#btn_changebg")
	self._gochangebgreddot = gohelper.findChild(self.viewGO, "btn_changebg/#go_reddot")
	self._gocollectbg = gohelper.findChild(self.viewGO, "collection/newbg")
	self._goAssistReward = gohelper.findChild(self.viewGO, "#go_gather")
	self._btnGetAssistReward = gohelper.findChildButtonWithAudio(self.viewGO, "#go_gather/#btn_click")

	gohelper.setActive(self._goAssistReward, false)

	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._loader = MultiAbLoader.New()
	self._btnplayercard = gohelper.findChildButtonWithAudio(self.viewGO, "btn_personalcard/#btn_changebg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerView:addEvents()
	self._btnplayercard:AddClickListener(self._btnplayercardOnClick, self)
	self._btnplayerid:AddClickListener(self._btnplayeridOnClick, self)
	self._btnsignature:AddClickListener(self._btnsignatureOnClick, self)
	self._btnshowcharacterA1:AddClickListener(self._showHeroClick, self, 1)
	self._btnshowcharacterA2:AddClickListener(self._showHeroClick, self, 2)
	self._btnshowcharacterA3:AddClickListener(self._showHeroClick, self, 3)
	self._btnshowcharacterB1:AddClickListener(self._showHeroClick, self, 1)
	self._btnshowcharacterB2:AddClickListener(self._showHeroClick, self, 2)
	self._btnshowcharacterB3:AddClickListener(self._showHeroClick, self, 3)
	self._btnheadicon:AddClickListener(self._changeIcon, self)
	self._btncollection:AddClickListener(self._showCollectionText, self)
	self._btncloseCollectText:AddClickListener(self._hideCollectionText, self)
	self._btnmodifyname:AddClickListener(self._btnmodifynameOnClick, self)
	self._btnchangebg:AddClickListener(self._btnchangebgOnClick, self)
	self._btnGetAssistReward:AddClickListener(self._btnGetAssistRewardOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self, LuaEventSystem.Low)
	PlayerController.instance:registerCallback(PlayerEvent.ChangePlayerinfo, self.updateBg, self)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self.resetBg, self)
end

function PlayerView:removeEvents()
	self._btnplayercard:RemoveClickListener()
	self._btnplayerid:RemoveClickListener()
	self._btnsignature:RemoveClickListener()
	self._btnshowcharacterA1:RemoveClickListener()
	self._btnshowcharacterA2:RemoveClickListener()
	self._btnshowcharacterA3:RemoveClickListener()
	self._btnshowcharacterB1:RemoveClickListener()
	self._btnshowcharacterB2:RemoveClickListener()
	self._btnshowcharacterB3:RemoveClickListener()
	self._btnheadicon:RemoveClickListener()
	self._btncollection:RemoveClickListener()
	self._btncloseCollectText:RemoveClickListener()
	self._btnmodifyname:RemoveClickListener()
	self._btnchangebg:RemoveClickListener()
	self._btnGetAssistReward:RemoveClickListener()

	if self._playerSelf then
		self.removeEventCb(self, PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, self._refreshIsHasAssistReward, self)
	end

	PlayerController.instance:unregisterCallback(PlayerEvent.ChangePlayerinfo, self.updateBg, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self.resetBg, self)
end

function PlayerView:_btnplayercardOnClick()
	if not self._info then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.PlayerCard) then
		PlayerCardController.instance:openPlayerCardView({
			userId = self._info.userId,
			hideHomeBtn = self.viewParam.hideHomeBtn
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.PlayerCard))
	end
end

function PlayerView:_btnplayeridOnClick()
	self._txtplayerid.text = self._info.userId

	ZProj.UGUIHelper.CopyText(self._txtplayerid.text)

	self._txtplayerid.text = string.format("ID:%s", self._info.userId)

	GameFacade.showToast(ToastEnum.ClickPlayerId)
end

function PlayerView:_btnsignatureOnClick()
	ViewMgr.instance:openView(ViewName.Signature)
end

function PlayerView:_btnmodifynameOnClick()
	ViewMgr.instance:openView(ViewName.PlayerModifyNameView)
end

function PlayerView:_btnchangebgOnClick()
	PostProcessingMgr.instance:setBlurWeight(0)
	self:_closeAndDelayOpenView(ViewName.PlayerChangeBgView, {
		bgComp = self._bgComp
	})
end

function PlayerView:_closeAndDelayOpenView(viewName, param)
	if not self._playerSelf then
		return
	end

	ShaderKeyWordMgr.disableKeyWord("_CLIPALPHA_ON")
	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
	self._viewAnim:Play(UIAnimationName.Close, 0, 0)

	self._openViewData = {
		viewName,
		param
	}

	UIBlockMgr.instance:startBlock("PlayerViewDelayOpenView")
	TaskDispatcher.runDelay(self._delayOpenView, self, 0.12)
end

function PlayerView:_delayOpenView()
	UIBlockMgr.instance:endBlock("PlayerViewDelayOpenView")
	ViewMgr.instance:openView(unpack(self._openViewData))
end

function PlayerView:resetBg(viewName)
	if viewName == ViewName.PlayerChangeBgView then
		self._bgComp.go.transform:SetParent(self.viewGO.transform, false)
		self._bgComp.go.transform:SetSiblingIndex(0)
		self:updateBg()
	end
end

function PlayerView:_changeIcon()
	if self._playerSelf then
		ViewMgr.instance:openView(ViewName.IconTipView)
	end
end

function PlayerView:_showHeroClick(index)
	self:_closeAndDelayOpenView(ViewName.ShowCharacterView, {
		notRepeatUpdateAssistReward = true
	})
end

function PlayerView:_btnGetAssistRewardOnClick()
	if not self._playerSelf then
		return
	end

	PlayerController.instance:getAssistReward()
end

function PlayerView:_editableInitView()
	gohelper.addUIClickAudio(self._btnsignature.gameObject, AudioEnum.UI.play_ui_hero_sign)
	gohelper.addUIClickAudio(self._btnshowcharacterA1.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(self._btnshowcharacterA2.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(self._btnshowcharacterA3.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(self._btnshowcharacterB1.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(self._btnshowcharacterB2.gameObject, AudioEnum.UI.play_ui_hero_card_click)
	gohelper.addUIClickAudio(self._btnshowcharacterB3.gameObject, AudioEnum.UI.play_ui_hero_card_click)

	self._collectionfulls = self:getUserDataTb_()
	self._collectiontxt = self:getUserDataTb_()

	for i = 1, 5 do
		self._collectionfulls[i] = gohelper.findChildImage(self.viewGO, "collection/collection" .. i .. "/#image_full")
		self._collectiontxt[i] = gohelper.findChildText(self.viewGO, "collection/collection" .. i .. "/#txt_progress")
	end

	self._bgComp = MonoHelper.addLuaComOnceToGo(self._gobg, PlayerBgComp)

	UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
end

function PlayerView:onUpdateParam()
	self:onOpen()
end

function PlayerView:onOpenFinish()
	self._viewAnim.enabled = true
end

function PlayerView:onOpen()
	self._info = self.viewParam.playerInfo
	self._playerSelf = self.viewParam.playerSelf

	self:_initPlayerCardinfo(self._info)
	self:_initPlayerbassinfo(self._info)
	self:_initPlayerOtherinfo(self._info)
	self:_initPlayerShowCard(self._info.showHeros)
	self:_hideCollectionText()

	if self._playerSelf then
		self.addEventCb(self, PlayerController.instance, PlayerEvent.PlayerbassinfoChange, self._initPlayerbassinfo, self)
		self.addEventCb(self, PlayerController.instance, PlayerEvent.SetShowHero, self._initPlayerShowCard, self)
		self.addEventCb(self, PlayerController.instance, PlayerEvent.RenameFlagUpdate, self._refreshRenameStatus, self)
		self.addEventCb(self, PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, self._refreshIsHasAssistReward, self)

		self._btnheadicon.button.enabled = true

		self:updateAssistReward()

		local updateFrequency = CommonConfig.instance:getConstNum(ConstEnum.AssistRewardUpdateFrequency)

		TaskDispatcher.cancelTask(self.updateAssistReward, self)
		TaskDispatcher.runRepeat(self.updateAssistReward, self, updateFrequency)
	else
		self.removeEventCb(self, PlayerController.instance, PlayerEvent.PlayerbassinfoChange, self._initPlayerbassinfo, self)
		self.removeEventCb(self, PlayerController.instance, PlayerEvent.SetShowHero, self._initPlayerShowCard, self)
		self.removeEventCb(self, PlayerController.instance, PlayerEvent.RenameFlagUpdate, self._refreshRenameStatus, self)

		self._btnheadicon.button.enabled = false

		gohelper.setActive(self._goAssistReward, false)
	end

	RedDotController.instance:addRedDot(self._gochangebgreddot, RedDotEnum.DotNode.PlayerChangeBgNew)
	gohelper.setActive(self._gochangebgreddot, self._playerSelf)
	gohelper.setActive(self._btnsignature.gameObject, self._playerSelf)

	self._isGamePad = SDKNativeUtil.isGamePad()

	gohelper.setActive(self._gosignature.gameObject, self._isGamePad == false)
	self:_refreshRenameStatus()
	self:updateBg()
end

function PlayerView:updateAssistReward()
	if not self._playerSelf then
		return
	end

	PlayerController.instance:updateAssistRewardCount()
end

function PlayerView:updateBg()
	if ViewMgr.instance:isOpen(ViewName.PlayerChangeBgView) then
		return
	end

	local info = PlayerModel.instance:getPlayinfo()

	if not self.viewParam.playerSelf and self.viewParam.playerInfo then
		info = self.viewParam.playerInfo

		self._bgComp:setPlayerInfo(self.viewParam.playerInfo, self.viewParam.heroCover)
	end

	local bgCo = PlayerConfig.instance:getBgCo(info.bg)

	self._bgComp:showBg(bgCo)
	gohelper.setActive(self._gocollectbg, bgCo.item ~= 0)
end

function PlayerView:_initPlayerbassinfo(info)
	self._txtname.text = info.name
	self._txtplayerid.text = string.format("ID:%s", info.userId)

	local signature = info.signature

	if string.nilorempty(signature) then
		local randomSignatureArr = string.split(CommonConfig.instance:getConstStr(ConstEnum.RoleRandomSignature), "#")

		if randomSignatureArr and #randomSignatureArr > 0 then
			signature = randomSignatureArr[math.random(1, #randomSignatureArr)]
		end
	end

	self._txtsignature.text = signature

	gohelper.setActive(self._txtsignature.gameObject, true)

	self._txtentryday.text = TimeUtil.timestampToString3(ServerTime.timeInLocal(info.registerTime / 1000))

	local portraitId = info.portrait
	local config = lua_item.configDict[portraitId]

	self._liveHeadIcon = self._liveHeadIcon or IconMgr.instance:getCommonLiveHeadIcon(self._simageheadicon)

	self._liveHeadIcon:setLiveHead(portraitId)

	local effectArr = string.split(config.effect, "#")

	if #effectArr > 1 then
		if config.id == tonumber(effectArr[#effectArr]) then
			gohelper.setActive(self._goframenode, true)

			if not self.frame then
				local framePath = "ui/viewres/common/effect/frame.prefab"

				self._loader:addPath(framePath)
				self._loader:startLoad(self._onLoadCallback, self)
			end
		end
	else
		gohelper.setActive(self._goframenode, false)
	end
end

function PlayerView:_onLoadCallback()
	local framePrefab = self._loader:getFirstAssetItem():GetResource()

	gohelper.clone(framePrefab, self._goframenode, "frame")

	self.frame = gohelper.findChild(self._goframenode, "frame")

	local img = self.frame:GetComponent(gohelper.Type_Image)

	img.enabled = false

	local iconwidth = recthelper.getWidth(self._simageheadicon.transform)
	local framenodewidth = recthelper.getWidth(self.frame.transform)
	local scale = 1.41 * (iconwidth / framenodewidth)

	transformhelper.setLocalScale(self.frame.transform, scale, scale, 1)
end

function PlayerView:_initPlayerCardinfo(info)
	local AllRareNNHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(1)
	local AllRareNHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(2)
	local AllRareRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(3)
	local AllRareSRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(4)
	local AllRareSSRHeroCount = HeroConfig.instance:getAnyOnlineRareCharacterCount(5)

	if AllRareNNHeroCount > 0 then
		local heroRareNNPercent = math.min(info.heroRareNNCount / AllRareNNHeroCount or 1, 1)

		if AllRareNHeroCount > 0 then
			local heroRareNPercent = math.min(info.heroRareNCount / AllRareNHeroCount or 1, 1)

			if AllRareRHeroCount > 0 then
				local heroRareRPercent = math.min(info.heroRareRCount / AllRareRHeroCount or 1, 1)

				if AllRareSRHeroCount > 0 then
					local heroRareSRPercent = math.min(info.heroRareSRCount / AllRareSRHeroCount or 1, 1)

					if AllRareSSRHeroCount > 0 then
						local heroRareSSRPercent = math.min(info.heroRareSSRCount / AllRareSSRHeroCount or 1, 1)

						self._collectionfulls[1].fillAmount = heroRareNNPercent
						self._collectionfulls[2].fillAmount = heroRareNPercent
						self._collectionfulls[3].fillAmount = heroRareRPercent
						self._collectionfulls[4].fillAmount = heroRareSRPercent
						self._collectionfulls[5].fillAmount = heroRareSSRPercent
						self._collectiontxt[1].text = string.format("%s%%", heroRareNNPercent * 100 - heroRareNNPercent * 100 % 0.1)
						self._collectiontxt[2].text = string.format("%s%%", heroRareNPercent * 100 - heroRareNPercent * 100 % 0.1)
						self._collectiontxt[3].text = string.format("%s%%", heroRareRPercent * 100 - heroRareRPercent * 100 % 0.1)
						self._collectiontxt[4].text = string.format("%s%%", heroRareSRPercent * 100 - heroRareSRPercent * 100 % 0.1)
						self._collectiontxt[5].text = string.format("%s%%", heroRareSSRPercent * 100 - heroRareSSRPercent * 100 % 0.1)
					end
				end
			end
		end
	end
end

function PlayerView:_showCollectionText()
	for _, text in ipairs(self._collectiontxt) do
		gohelper.setActive(text.gameObject, true)
	end

	gohelper.setActive(self._btncloseCollectText.gameObject, true)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function PlayerView:_hideCollectionText()
	for _, text in ipairs(self._collectiontxt) do
		gohelper.setActive(text.gameObject, false)
	end

	gohelper.setActive(self._btncloseCollectText.gameObject, false)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function PlayerView:_initPlayerOtherinfo(info)
	self._txtepisodeprogress.text = ""
	self._txtepisodeprogressen.text = ""

	local episodeId = info.lastEpisodeId
	local episodeConfig = episodeId and lua_episode.configDict[episodeId]

	if episodeConfig then
		local chapterCO = DungeonConfig.instance:getChapterCO(episodeConfig.chapterId)

		if chapterCO.type == DungeonEnum.ChapterType.Simple then
			episodeConfig = lua_episode.configDict[episodeConfig.normalEpisodeId]
		end

		if episodeConfig then
			self._txtepisodeprogress.text = string.format("《%s %s》", DungeonController.getEpisodeName(episodeConfig), episodeConfig.name)
			self._txtepisodeprogressen.text = episodeConfig.name_En
		end
	end

	local level = info.level

	self._txtlevel.text = level

	local exp_now = info.exp
	local exp_max = 0

	if level < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		exp_max = PlayerConfig.instance:getPlayerLevelCO(level + 1).exp
	else
		exp_max = PlayerConfig.instance:getPlayerLevelCO(level).exp
		exp_now = exp_max
	end

	self._txtexp.text = exp_now .. "/" .. exp_max

	self._imageexp:SetValue(exp_now / exp_max)
end

function PlayerView:_initPlayerShowCard(showHeros)
	for i = 1, 3 do
		local showcharacter = gohelper.findChild(self.viewGO, "showcharacters/showcharacter" .. i)

		self:_showcharacterinfo(showHeros[i], showcharacter)
	end
end

local breakImgValue = {
	0.23,
	0.42,
	0.59,
	0.78,
	1
}

function PlayerView:_showcharacterinfo(info, item)
	local empty = gohelper.findChild(item, "#btn_Add")
	local character = gohelper.findChild(item, "#btn_Character")

	if info and info ~= 0 and info.heroId and info.heroId ~= "0" and info.heroId ~= 0 then
		if self._playerSelf then
			info = HeroModel.instance:getByHeroId(info.heroId)
		end

		gohelper.setActive(empty.gameObject, false)
		gohelper.setActive(character.gameObject, true)

		local rare = gohelper.findChildImage(item, "#btn_Character/charactercarditem/#simage_cardrare")
		local effect1 = gohelper.findChild(item, "#btn_Character/charactercarditem/#simage_cardrare/r")
		local effect2 = gohelper.findChild(item, "#btn_Character/charactercarditem/#simage_cardrare/sr")
		local effect3 = gohelper.findChild(item, "#btn_Character/charactercarditem/#simage_cardrare/ssr")
		local level = gohelper.findChildText(item, "#btn_Character/charactercarditem/#txt_level")
		local iconGO = gohelper.findChild(item, "#btn_Character/charactercarditem/iconmask/#simage_icon")
		local commonHeroCard = CommonHeroCard.create(iconGO, self.viewName)
		local breakImg = gohelper.findChildImage(item, "#btn_Character/charactercarditem/lvProgress/#image_breakprogress")
		local effectTab = {}

		table.insert(effectTab, effect1)
		table.insert(effectTab, effect2)
		table.insert(effectTab, effect3)

		local heroConfig = HeroConfig.instance:getHeroCO(info.heroId)
		local skinconfig = SkinConfig.instance:getSkinCo(info.skin)

		UISpriteSetMgr.instance:setPlayerRareBgSprite(rare, "rare_" .. CharacterEnum.Color[heroConfig.rare])
		commonHeroCard:onUpdateMO(skinconfig)

		level.text = HeroConfig.instance:getShowLevel(info.level)

		if info.exSkillLevel then
			breakImg.fillAmount = breakImgValue[info.exSkillLevel] or 0
		end

		for i = 1, 3 do
			gohelper.setActive(effectTab[i], i == heroConfig.rare - 2)
		end

		self:_showCharacterRankInfo(info, item)
	else
		gohelper.setActive(empty.gameObject, true)
		gohelper.setActive(character.gameObject, false)
	end

	if not self._playerSelf then
		gohelper.setActive(empty, false)
	end
end

function PlayerView:_showCharacterRankInfo(info, item)
	local heroConfig = HeroConfig.instance:getHeroCO(info.heroId)
	local rankObj = gohelper.findChild(item, "#btn_Character/charactercarditem/rankobj")
	local rankGOs = {}

	for i = 1, 3 do
		local rankGO = gohelper.findChild(rankObj, "rank" .. i)

		table.insert(rankGOs, rankGO)
	end

	for i = 1, 3 do
		local rankGO = rankGOs[i]

		gohelper.setActive(rankGO, i == info.rank - 1)
	end
end

function PlayerView:_refreshRenameStatus()
	gohelper.setActive(self._btnmodifyname.gameObject, self._playerSelf and self._isGamePad == false)
end

function PlayerView:_refreshIsHasAssistReward()
	if self._playerSelf then
		local isFriendUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend)
		local isHasAssistReward = PlayerModel.instance:isHasAssistReward()

		gohelper.setActive(self._goAssistReward, isFriendUnlock and isHasAssistReward)
	else
		gohelper.setActive(self._goAssistReward, false)
	end
end

function PlayerView:_onCloseFullView(viewName)
	if self._viewAnim then
		ShaderKeyWordMgr.disableKeyWord("_CLIPALPHA_ON")
		UnityEngine.Shader.EnableKeyword("_CLIPALPHA_ON")
		self._viewAnim:Play(UIAnimationName.Open, 0, 0)
	end
end

function PlayerView:onClose()
	PostProcessingMgr.instance:setBlurWeight(1)
	TaskDispatcher.cancelTask(self._delayOpenView, self)
	UIBlockMgr.instance:endBlock("PlayerViewDelayOpenView")
	TaskDispatcher.cancelTask(self.updateAssistReward, self)
end

function PlayerView:onDestroyView()
	self._simageheadicon:UnLoadImage()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	UnityEngine.Shader.DisableKeyword("_CLIPALPHA_ON")
end

return PlayerView
