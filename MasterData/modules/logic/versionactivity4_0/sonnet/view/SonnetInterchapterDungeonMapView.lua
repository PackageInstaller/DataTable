-- chunkname: @modules/logic/versionactivity4_0/sonnet/view/SonnetInterchapterDungeonMapView.lua

module("modules.logic.versionactivity4_0.sonnet.view.SonnetInterchapterDungeonMapView", package.seeall)

local SonnetInterchapterDungeonMapView = class("SonnetInterchapterDungeonMapView", BaseView)

function SonnetInterchapterDungeonMapView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "#go_v4a0dungeon")
	self._btntask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_main/#go_rightbtns/#btn_task")

	self._btntask:AddClickListener(self._btntaskOnClick, self)

	self._btntaskAnimator = self._btntask:GetComponent("Animator")
	self._taskReddotGo = gohelper.findChild(self._btntask.gameObject, "#go_giftredpoint")
	self._anim = self._goroot:GetComponent("Animator")

	local txt = gohelper.findChildText(self.viewGO, "#go_main/#go_rightbtns/#btn_task/#txt_progress")

	txt.text = ""

	gohelper.setActive(self._btntask, false)
end

function SonnetInterchapterDungeonMapView:_btntaskOnClick()
	SonnetInterchapterController.instance:openTaskView()
end

function SonnetInterchapterDungeonMapView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self.onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self.onCloseViewFinish, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, self.setEpisodeListVisible, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, self._onUpdateDungeonInfo, self)
	self.addEventCb(self, DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, self._loadSceneFinish, self)
	self.addEventCb(self, RedDotController.instance, RedDotEvent.UpdateRelateDotInfo, self._updateReddot, self)
	self.addEventCb(self, SonnetInterchapterController.instance, SonnetInterchapterEvent.FinishElement, self._onFinishElement, self)
	self.addEventCb(self, SonnetInterchapterController.instance, SonnetInterchapterEvent.ClickNewWord, self._onClickNewWord, self)
	self.addEventCb(self, SonnetInterchapterController.instance, SonnetInterchapterEvent.InitWords, self._onInitWords, self)
end

function SonnetInterchapterDungeonMapView:_onInitWords(isPush)
	local oldStatus = self._showBtnVisible

	self:_checkBtnVisible()

	if isPush and not oldStatus and self._showBtnVisible then
		AudioMgr.instance:trigger(SonnetInterchapterEnum.Audio.play_ui_wulu_lucky_bag_prize)
	end
end

function SonnetInterchapterDungeonMapView:_onClickNewWord()
	self:_checkBtnVisible()
end

function SonnetInterchapterDungeonMapView:_onFinishElement()
	self:_checkBtnVisible()
	gohelper.setActive(self._finishElementEffect, false)
	gohelper.setActive(self._finishElementEffect, true)
end

function SonnetInterchapterDungeonMapView:_loadSceneFinish(param)
	self.mapCfg = param[1]
	self.sceneGo = param[2]
	self.mapScene = param[3]
	self.episodeConfig = param.episodeConfig

	self:refreshView()
end

function SonnetInterchapterDungeonMapView:removeEvents()
	return
end

function SonnetInterchapterDungeonMapView:_initBtn()
	self:_checkBtnVisible()

	if self._loader then
		return
	end

	local path = "ui/viewres/dungeon/v4a0_dungeonentrance.prefab"

	self._loader = PrefabInstantiate.Create(self._goroot)

	self._loader:startLoad(path, self._onResLoaded, self)
end

function SonnetInterchapterDungeonMapView:_checkBtnVisible()
	if self._btnGo then
		local list = SonnetInterchapterModel.instance:getAllUnlockWords()
		local isShow = #list > 0

		gohelper.setActive(self._btnGo, isShow)

		self._showBtnVisible = isShow

		if isShow then
			for i, v in ipairs(list) do
				if not SonnetInterchapterController.hasOnceActionKey(SonnetInterchapterEnum.PrefsKey.NewWord, v.id) then
					gohelper.setActive(self._newWordEffect, true)

					return
				end
			end

			gohelper.setActive(self._newWordEffect, false)
		end
	end
end

function SonnetInterchapterDungeonMapView:_updateReddot()
	local showDot = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.SonnetTask, 0)

	gohelper.setActive(self._taskReddotGo, showDot)
	TaskDispatcher.cancelTask(self._showReceiveEffect, self)
	TaskDispatcher.runDelay(self._showReceiveEffect, self, 0.6)
end

function SonnetInterchapterDungeonMapView:_showReceiveEffect()
	local showDot = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.SonnetTask, 0)

	if self._btntaskAnimator then
		self._btntaskAnimator:Play(showDot and "receive" or "open")
	end
end

function SonnetInterchapterDungeonMapView:_onResLoaded()
	self._btnGo = self._loader:getInstGO()
	self._btnEnter = gohelper.findChildButtonWithAudio(self._btnGo, "#btn_click")

	self._btnEnter:AddClickListener(self.onClickEnter, self)

	self._finishElementEffect = gohelper.findChild(self._btnGo, "UIEff_HightLight_light")
	self._newWordEffect = gohelper.findChild(self._btnGo, "UIEff_HightLight_loop")

	self:_checkBtnVisible()
	self:refreshView()
end

function SonnetInterchapterDungeonMapView:refreshView()
	if not self.viewParam then
		return
	end

	self.chapterId = self.viewParam.chapterId

	self:onActStateChange()
	self:_updateInfo()

	if not self:_isShowRoot() then
		return
	end

	if not self._isGetInfo then
		self._isGetInfo = true

		SonnetInterchapterRpc.instance:sendSonnetGetInfoRequest()
	end

	gohelper.setActive(self._btntask, self.chapterId == DungeonEnum.ChapterId.Sonnet)

	if ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) then
		self:_playAnim("close", 0, 1)
	else
		self:_playAnim("open", 0, 0)
		self:_updateReddot()
	end
end

function SonnetInterchapterDungeonMapView:_updateInfo(showFinishEffect)
	return
end

function SonnetInterchapterDungeonMapView:_updateEffect()
	return
end

function SonnetInterchapterDungeonMapView:_updateLightEffect(force)
	return
end

function SonnetInterchapterDungeonMapView:_playAnim(name, value1, value2)
	if self._anim then
		self._anim:Play(name, value1, value2)
	end

	if self._btntaskAnimator then
		self._btntaskAnimator:Play(name, value1, value2)
	end
end

function SonnetInterchapterDungeonMapView:_playAnim2(name, value1, value2)
	if self._anim then
		self._anim:Play(name, value1, value2)
	end

	if self._btntaskAnimator then
		self._btntaskAnimator:Play(name, value1, value2)
	end
end

function SonnetInterchapterDungeonMapView:onOpen()
	if self.episodeConfig then
		self:refreshView()
	end
end

function SonnetInterchapterDungeonMapView:onUpdateParam()
	if self.episodeConfig then
		self:refreshView()
	end
end

function SonnetInterchapterDungeonMapView:onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		gohelper.setActive(self._btntask, false)
		self:_playAnim("close", 0, 0)
	end
end

function SonnetInterchapterDungeonMapView:onCloseViewFinish(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		gohelper.setActive(self._btntask, self.chapterId == DungeonEnum.ChapterId.Sonnet)
		self:_playAnim("open", 0, 0)
		self:_updateReddot()
	end
end

function SonnetInterchapterDungeonMapView:setEpisodeListVisible(value)
	local show = value and self._showRoot

	if not gohelper.isNil(self._btnEnter) then
		self._btnEnter.button.interactable = show
	end

	if show then
		self:_playAnim2("open", 0, 0)
		self:_updateReddot()
		gohelper.setActive(self._btntask, self.chapterId == DungeonEnum.ChapterId.Sonnet)
	else
		self:_playAnim2("close", 0, 0)
		gohelper.setActive(self._btntask, false)
	end
end

function SonnetInterchapterDungeonMapView:_checkShowRoot()
	self._showRoot = self:_isShowRoot()

	if self._showRoot then
		self:_initBtn()
		gohelper.setActive(self._goroot, true)
	else
		gohelper.setActive(self._goroot, false)
	end
end

function SonnetInterchapterDungeonMapView:_isShowRoot()
	return self.chapterId == DungeonEnum.ChapterId.Sonnet
end

function SonnetInterchapterDungeonMapView:onActStateChange()
	self:_checkShowRoot()
end

function SonnetInterchapterDungeonMapView:onClickEnter()
	SonnetInterchapterController.instance:openSonnetInterchapterBookView()
end

function SonnetInterchapterDungeonMapView:onClose()
	self._btntask:RemoveClickListener()

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if self._btnEnter then
		self._btnEnter:RemoveClickListener()
	end

	self._btnGo = nil

	TaskDispatcher.cancelTask(self._showReceiveEffect, self)
end

function SonnetInterchapterDungeonMapView:_onUpdateDungeonInfo()
	return
end

return SonnetInterchapterDungeonMapView
