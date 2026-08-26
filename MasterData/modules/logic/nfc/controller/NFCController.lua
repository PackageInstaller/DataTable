-- chunkname: @modules/logic/nfc/controller/NFCController.lua

module("modules.logic.nfc.controller.NFCController", package.seeall)

local NFCController = class("NFCController", BaseController)

function NFCController:onInit()
	self._isInit = false
end

function NFCController:onInitFinish()
	return
end

function NFCController:addConstEvents()
	return
end

function NFCController:reInit()
	self._isInit = false
end

function NFCController:_initHandleFunc()
	self.NFCHandleFunction = {
		[NFCEnum.NFCVFunctionType.BGMSwitch] = self.handleBGMSwitchRead,
		[NFCEnum.NFCVFunctionType.PlayerCard] = self.handlePlayerCardRead
	}
	self.NFCViewDic = {
		[ViewName.BGMSwitchView] = NFCEnum.NFCVFunctionType.BGMSwitch,
		[ViewName.NewPlayerCardContentView] = NFCEnum.NFCVFunctionType.PlayerCard,
		[ViewName.PlayerView] = NFCEnum.NFCVFunctionType.PlayerCard
	}
end

function NFCController:onNFCRead(msg)
	if msg == nil then
		logNormal("参数为空")

		return
	end

	if not LoginController.instance:isEnteredGame() then
		logNormal("没有进入游戏")

		return
	end

	if GameSceneMgr.instance:isClosing() then
		logNormal("切换场景中")

		return
	end

	if GameSceneMgr.instance:isLoading() then
		logNormal("加载场景中")

		return
	end

	if VirtualSummonScene.instance:isOpen() then
		logNormal("抽卡场景")

		return
	end

	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.Main then
		logNormal("不在主场景")

		return
	end

	if StoryModel.instance:isPlayingVideo() or StoryModel.instance:isSpecialVideoPlaying() or LimitedRoleController.instance:isPlaying() then
		logNormal("播放视频中")

		return
	end

	if GuideController.instance:isGuiding() or GuideModel.instance:isDoingClickGuide() then
		logNormal("引导中")

		return
	end

	local urlParams = WebViewController.urlParse(msg)

	if not urlParams then
		logNormal("未读取出参数")

		return
	end

	if not urlParams.ver or not urlParams.id then
		logNormal("卡片缺少版本号和id")

		return
	end

	local version = tonumber(urlParams.ver)

	if not version or not NFCEnum.NFCVersionDic[version] then
		logNormal("卡片版本信息错误")

		return
	end

	local param = urlParams.id
	local nfcRecognizeId = tonumber(param)
	local nfcConfig = NFCConfig.instance:getNFCRecognizeCo(nfcRecognizeId)

	if not nfcConfig then
		logNormal("找不到nfc表")

		return
	end

	if self._isInit == false then
		self:_initHandleFunc()

		self._isInit = true
	end

	if not OpenModel.instance:isFunctionUnlock(nfcConfig.type) then
		GameFacade.showToast(nfcConfig.unlockId)

		return
	end

	local type = nfcConfig.type
	local handleFunc = self.NFCHandleFunction[type]

	if handleFunc == nil then
		logNormal("找不到对应的nfc处理方法, type:" .. type)

		return
	end

	self._curNFCCardId = nfcConfig.id

	handleFunc(self, nfcConfig)
end

function NFCController:handleBGMSwitchRead(nfcConfig)
	if not self:isInMainView(nfcConfig.type) then
		GameFacade.showToast(nfcConfig.notMainTipsId)

		return
	end

	local isBGMUnFinished = GuideModel.instance:isGuideFinish(BGMSwitchEnum.BGMGuideId)

	if not isBGMUnFinished then
		logNormal("BGM界面引导未完成")

		return
	end

	local isBgmSwitchOpen = ViewMgr.instance:isOpen(ViewName.BGMSwitchView)

	if not isBgmSwitchOpen then
		local isThumbnail = ViewMgr.instance:isOpen(ViewName.MainThumbnailView)

		BGMSwitchController.instance:openBGMSwitchView(isThumbnail)
		BGMSwitchModel.instance:setEggHideState(true)
	end

	local bgmId = nfcConfig.param
	local bgmInfo = BGMSwitchModel.instance:getBgmInfo(bgmId)

	if not bgmInfo then
		GameFacade.showToast(nfcConfig.unclaimedId)

		return
	end

	self._curBgmId = bgmId

	if not isBgmSwitchOpen then
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onBgmSwitchViewOpen, self)
	else
		local currentBgmId = BGMSwitchModel.instance:getCurBgm()

		if currentBgmId ~= nil and bgmId == currentBgmId then
			logNormal("正在播放该BGM")

			return
		end

		self:setCurBGM(self._curBgmId, true)
	end
end

function NFCController:onBgmSwitchViewOpen(viewName)
	if viewName == ViewName.BGMSwitchView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onBgmSwitchViewOpen, self)
		self:setCurBGM(self._curBgmId)
	end
end

function NFCController:setCurBGM(bgmId, focus)
	BGMSwitchModel.instance:setCurBgm(bgmId)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, bgmId, focus)
end

function NFCController:handlePlayerCardRead(nfcConfig)
	local isGuideFinished = GuideModel.instance:isGuideFinish(PlayerCardEnum.PlayerCardGuideId)

	if not isGuideFinished then
		logNormal("旅券集界面引导未完成")

		return
	end

	local targetThemeId = tonumber(nfcConfig.param)

	if not targetThemeId then
		logNormal("nfc表参数错误")

		return
	end

	local isPlayerCardOpen = ViewMgr.instance:isOpen(ViewName.NewPlayerCardContentView)

	if not isPlayerCardOpen then
		if not self:isInMainView(nfcConfig.type) then
			GameFacade.showToast(nfcConfig.notMainTipsId)

			return
		end

		self:openNewPlayerCardContentView()
	else
		local viewParam = PlayerCardController.instance:getCurViewParam()
		local isSelf = viewParam and tonumber(viewParam.userId) == tonumber(PlayerModel.instance:getMyUserId())

		if not isSelf then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullViewFinish, self.onNewPlayerCardContentViewClose, self)
		end

		local allOpenList = ViewMgr.instance:getOpenViewNameList()
		local needOpenList = {}

		for i = 1, #allOpenList do
			local viewName = allOpenList[i]

			if viewName ~= ViewName.NewPlayerCardContentView then
				table.insert(needOpenList, viewName)
			else
				if isSelf then
					table.insert(needOpenList, viewName)
				end

				break
			end
		end

		ViewMgr.instance:closeAllViews(needOpenList)
	end
end

function NFCController:onNewPlayerCardContentViewOpen(viewName)
	if viewName == ViewName.NewPlayerCardContentView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onNewPlayerCardContentViewOpen, self)
		self:checkTheme(self._curNFCCardId)
	end
end

function NFCController:openNewPlayerCardContentView()
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onNewPlayerCardContentViewOpen, self)
	PlayerCardController.instance:openPlayerCardView()
end

function NFCController:onNewPlayerCardContentViewClose(viewName)
	if viewName == ViewName.NewPlayerCardContentView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullViewFinish, self.onNewPlayerCardContentViewClose, self)
		self:openNewPlayerCardContentView()
	end
end

function NFCController:checkTheme(nfcRecognizeId)
	local nfcConfig = NFCConfig.instance:getNFCRecognizeCo(nfcRecognizeId)

	if not nfcConfig then
		logNormal("找不到nfc表")

		return
	end

	if nfcConfig.unclaimedId == nil or nfcConfig.unclaimedId == 0 then
		return
	end

	local targetThemeId = tostring(nfcConfig.param)

	if ItemModel.instance:getItemCount(targetThemeId) <= 0 then
		GameFacade.showToast(nfcConfig.unclaimedId)
	end
end

function NFCController:isInMainView(type)
	local openViews = ViewMgr.instance:getOpenViewNameList()
	local openFullView = {}

	for _, v in ipairs(openViews) do
		local setting = ViewMgr.instance:getSetting(v)

		if v ~= ViewName.MainView and self.NFCViewDic[v] ~= type and setting.viewType == ViewType.Full and setting.layer ~= UILayerName.Message then
			table.insert(openFullView, v)
		end
	end

	return (#openFullView > 0 or nil) and false
end

function NFCController:_startBlack()
	return
end

function NFCController:_endBlack()
	return
end

NFCController.instance = NFCController.New()

return NFCController
