-- chunkname: @modules/logic/scene/view/LoadingView.lua

module("modules.logic.scene.view.LoadingView", package.seeall)

local LoadingView = class("LoadingView", BaseView)

function LoadingView:ctor()
	self._totalWeight = 0
end

function LoadingView:onInitView()
	self.root = gohelper.findChild(self.viewGO, "root")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._iconList = self:getUserDataTb_()

	for i = 1, 3 do
		local icon = gohelper.findChildSingleImage(self.viewGO, "root/center/image_pic" .. i)

		table.insert(self._iconList, icon)
	end

	self._txttip = gohelper.findChildText(self.viewGO, "root/center/#txt_tip")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function LoadingView:onOpen()
	gohelper.setActive(self.viewGO, true)
	gohelper.setSibling(self.viewGO, 2)
	self._simagebg:LoadImage(ResUrl.getLoadingBg("full/bg_loading"))

	self._enableClose = false
	self._waitClose = false

	self._animator:Play(UIAnimationName.Open, 0, 0)
	TaskDispatcher.runDelay(self._onDelayStartAudio, self, 0.8)
	self:_setIcon()
	self:_setRandomText()
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.AgainOpenLoading, self._againOpenLoading, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.DelayCloseLoading, self._delayCloseLoading, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.SetManualClose, self._setManualClose, self)
	self.addEventCb(self, GameSceneMgr.instance, SceneEventName.ManualClose, self._manualClose, self)
end

function LoadingView:setlineWidth()
	local leftOffset = 242
	local rightOffset = 115
	local halfScreenWidth = UnityEngine.Screen.width / 2
	local lineWidth = halfScreenWidth - leftOffset - rightOffset

	for i = 1, 2 do
		local str1 = string.format("duan_xian%s", i)
		local str2 = string.format("xian%s", i)
		local duanxianTrs = gohelper.findChild(self.root, str1).transform
		local xianTrs = gohelper.findChild(self.root, str2).transform

		recthelper.setWidth(duanxianTrs, lineWidth)
		recthelper.setWidth(xianTrs, lineWidth)
	end
end

function LoadingView:_onDelayStartAudio()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_loading_scene)
end

function LoadingView:onClose()
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomHelper.logEnd("关闭loading")
	end

	gohelper.setActive(self.viewGO, false)
	self._simagebg:UnLoadImage()
	TaskDispatcher.cancelTask(self._errorCloseLoading, self)
	TaskDispatcher.cancelTask(self._waitClose, self)
	TaskDispatcher.cancelTask(self._onDelayStartAudio, self)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.AgainOpenLoading, self._againOpenLoading, self)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.DelayCloseLoading, self._delayCloseLoading, self)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.SetManualClose, self._setManualClose, self)
	self.removeEventCb(self, GameSceneMgr.instance, SceneEventName.ManualClose, self._manualClose, self)
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self.loadingAnimEnd, self)
end

function LoadingView:_againOpenLoading()
	logNormal("loading打开状态下，又调用了打开loading，取消计时，继续走")
	TaskDispatcher.cancelTask(self._errorCloseLoading, self)
end

function LoadingView:_setIcon()
	local fitIcons = self:_getFitIcons()
	local iconCo = self:_getRandomCO(fitIcons)

	if iconCo then
		local resName = iconCo.pic

		for i, v in ipairs(self._iconList) do
			v:LoadImage(ResUrl.getLoadingBg(resName .. "_" .. i))
		end
	end
end

function LoadingView:_getFitIcons()
	local sceneType = LoadingView.getLoadingSceneType(self.viewParam)
	local iconCos = SceneConfig.instance:getLoadingIcons()
	local fits = {}

	for _, v in pairs(iconCos) do
		local scenes = string.splitToNumber(v.scenes, "#")

		for _, scene in pairs(scenes) do
			if scene == sceneType then
				table.insert(fits, v)
			end
		end
	end

	return fits
end

function LoadingView:_setRandomText()
	local textCoList = self:_getFitTips()
	local txtCo = self:_getRandomCO(textCoList)

	self._txttip.text = txtCo and txtCo.content or ""
end

function LoadingView.getLoadingSceneType(sceneType)
	local type = LoadingEnum.LoadingSceneType.Other

	if sceneType == SceneType.Main then
		type = LoadingEnum.LoadingSceneType.Main
	elseif sceneType == SceneType.Summon then
		type = LoadingEnum.LoadingSceneType.Summon
	elseif sceneType == SceneType.Room then
		type = LoadingEnum.LoadingSceneType.Room
	elseif sceneType == SceneType.Explore then
		type = LoadingEnum.LoadingSceneType.Explore
	end

	return type
end

function LoadingView:_getFitTips()
	local sceneType = LoadingView.getLoadingSceneType(self.viewParam)
	local level = PlayerModel.instance:getPlayerLevel()
	local fits = {}

	for _, v in pairs(SceneConfig.instance:getLoadingTexts()) do
		local scenes = string.splitToNumber(v.scenes, "#")

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

function LoadingView:_getRandomCO(list)
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

function LoadingView:_errorCloseLoading()
	local sceneType = GameSceneMgr.instance:getCurSceneType()
	local sceneId = GameSceneMgr.instance:getCurSceneId()
	local isLoading = GameSceneMgr.instance:isLoading()

	logError(string.format("loading超时，关闭loading看看 sceneType_%d sceneId_%d isLoading_%s", sceneType or -1, sceneId or -1, isLoading and "true" or "false"))
	self:_delayCloseLoading()
end

function LoadingView:_delayCloseLoading()
	if not self._needManualClose then
		self:_closeLoading()
	else
		logNormal("暂时无法关闭loading，设置了手动关闭")
	end
end

function LoadingView:_closeLoading()
	self._animator:Play("loading_close")
	TaskDispatcher.cancelTask(self._onDelayStartAudio, self)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_loading_scene)

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Room then
		RoomHelper.logElapse("进入小屋场景完成，开始关闭loading")
	end

	TaskDispatcher.runDelay(self.closeThis, self, 1)
	TaskDispatcher.runDelay(self.loadingAnimEnd, self, 0.5)
end

function LoadingView:loadingAnimEnd()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.LoadingAnimEnd)
end

function LoadingView:_setManualClose()
	logNormal(Time.time .. " LoadingView:_setManualClose")

	self._needManualClose = true
end

function LoadingView:_manualClose()
	logNormal(Time.time .. " LoadingView:_manualClose")

	self._needManualClose = nil

	self:_closeLoading()
end

return LoadingView
