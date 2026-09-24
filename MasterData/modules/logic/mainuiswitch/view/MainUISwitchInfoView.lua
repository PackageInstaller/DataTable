-- chunkname: @modules/logic/mainuiswitch/view/MainUISwitchInfoView.lua

module("modules.logic.mainuiswitch.view.MainUISwitchInfoView", package.seeall)

local MainUISwitchInfoView = class("MainUISwitchInfoView", BaseView)

function MainUISwitchInfoView:onInitView()
	self._gomiddle = gohelper.findChild(self.viewGO, "middle")
	self._gomainUI = gohelper.findChild(self.viewGO, "middle/#go_mainUI")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_equip")
	self._goshowing = gohelper.findChild(self.viewGO, "right/start/#go_showing")
	self._goLocked = gohelper.findChild(self.viewGO, "right/start/#go_Locked")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "right/start/#btn_close")
	self._scrollcard = gohelper.findChildScrollRect(self.viewGO, "right/mask/#scroll_card")
	self._goSceneName = gohelper.findChild(self.viewGO, "left/LayoutGroup/layout/#go_SceneName")
	self._txtSceneName = gohelper.findChildText(self.viewGO, "left/LayoutGroup/layout/#go_SceneName/#txt_SceneName")
	self._txtTime = gohelper.findChildText(self.viewGO, "left/LayoutGroup/layout/#go_Time/#txt_Time")
	self._btnnamecheck = gohelper.findChildButtonWithAudio(self.viewGO, "left/LayoutGroup/#go_HideBtn/#btn_Hide")
	self._txtSceneDescr = gohelper.findChildText(self.viewGO, "left/#txt_SceneDescr")
	self._btnshow = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_show")
	self._goSceneLogo4 = gohelper.findChild(self.viewGO, "left/#go_SceneLogo4")
	self._goSceneLogo = gohelper.findChild(self.viewGO, "left/#go_SceneLogo")
	self._txtSceneLogo = gohelper.findChildText(self.viewGO, "left/#go_SceneLogo/titlebg/#txt_SceneLogo")
	self._weatherRoot = gohelper.findChild(self.viewGO, "left/#go_weatherRoot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainUISwitchInfoView:addEvents()
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnnamecheck:AddClickListener(self._btnHideOnClick, self)
	self._btnshow:AddClickListener(self._btnshowOnClick, self)
	self.addEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.MaskHeroMoveFinish, self._onMaskHeroMoveFinish, self)
end

function MainUISwitchInfoView:removeEvents()
	self._btnequip:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnnamecheck:RemoveClickListener()
	self._btnshow:RemoveClickListener()
	self.removeEventCb(self, MainUISwitchController.instance, MainUISwitchEvent.MaskHeroMoveFinish, self._onMaskHeroMoveFinish, self)
end

function MainUISwitchInfoView:_btnHideOnClick()
	if self._hideTime and Time.time - self._hideTime < 0.2 then
		return
	end

	self._hideTime = Time.time
	self._showUI = not self._showUI

	gohelper.setActive(self._goleft, self._showUI and self._isCanShowLeft)
	gohelper.setActive(self._goright, self._showUI)
	gohelper.setActive(self._btnshow.gameObject, not self._showUI)
	gohelper.setActive(self._goMask, self._showUI)
	TaskDispatcher.cancelTask(self._onPreviewSwitchUIVisible, self)

	if self._showUI then
		self:_playSwitchAnim()
		self._blurmaskAnimator:Play("open", 0, 0)
	end

	self:_onPreviewSwitchUIVisible()
end

function MainUISwitchInfoView:_onPreviewSwitchUIVisible()
	MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.PreviewSwitchUIVisible, self._showUI)
end

function MainUISwitchInfoView:_playSwitchAnim()
	gohelper.setActive(self.viewGO, false)
	gohelper.setActive(self.viewGO, true)

	local animName = self._showUI and "switch1" or "switch2"

	self._rootAnimator:Play(animName, 0, 0)
end

function MainUISwitchInfoView:_onMaskHeroMoveFinish(visible)
	if not visible then
		self:_playSwitchAnim()
	end
end

function MainUISwitchInfoView:_btnshowOnClick()
	if not self._showUI then
		if MainUISwitchController.instance:isClickEagle() then
			MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.ClickEagle)

			return
		end

		if MainUISwitchController.instance:isClickObj("#btn_bird") then
			MainUISwitchController.instance:dispatchEvent(MainUISwitchEvent.ClickBird, self.viewName)

			return
		end
	end

	self:_btnHideOnClick()
end

function MainUISwitchInfoView:_btnequipOnClick()
	self._equipBtnAnimatorPlayer:Play("click", self._equipCb, self)
end

function MainUISwitchInfoView:_equipCb()
	MainUISwitchController.instance:setCurMainUIStyle(self._selectSkinId, self._showSceneStatus, self)
end

function MainUISwitchInfoView:_showSceneStatus()
	local sceneStatus = MainUISwitchModel.getUIStatus(self._selectSkinId)
	local isShow = self.viewParam.isAmplify == nil
	local isUnlock = sceneStatus == MainSceneSwitchEnum.SceneStutas.Unlock
	local isEquip = self._selectSkinId == MainUISwitchModel.instance:getCurUseUI()

	gohelper.setActive(self._btnequip, isShow and isUnlock and not isEquip)
	gohelper.setActive(self._goshowing, isShow and isUnlock and isEquip)
	gohelper.setActive(self._goLocked, isShow and not isUnlock)
	self:_updateSceneInfo()
end

function MainUISwitchInfoView:_btncloseOnClick()
	if self._isClosing then
		return
	end

	self._rootAnimator:Play("close", 0, 0)
	TaskDispatcher.runDelay(self.closeThis, self, 0.334)

	self._isClosing = true
end

function MainUISwitchInfoView:_editableInitView()
	self._rootAnimator = self.viewGO:GetComponent("Animator")
	self._equipBtnAnimatorPlayer = SLFramework.AnimatorPlayer.Get(self._btnequip.gameObject)
	self._goleft = gohelper.findChild(self.viewGO, "left")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._goMask = gohelper.findChild(self.viewGO, "MaskBG")

	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)
end

function MainUISwitchInfoView:onOpen()
	self._showUI = true
	self._selectSkinId = self.viewParam.SkinId
	self._isCanShowLeft = true

	if self.viewParam and self.viewParam.isNotShowLeft == true then
		self._isCanShowLeft = false
	end

	self:_showSceneStatus()

	if not self.viewParam.noInfoEffect then
		self._rootAnimator:Play("info", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_get_scene)
	end

	if not self._goblurmask then
		self._goblurmask = self:getResInst(self.viewContainer:getSetting().otherRes[2], self._gomiddle)
		self._blurmaskAnimator = self._goblurmask:GetComponent(typeof(UnityEngine.Animator))
	end

	gohelper.setActive(self._goleft, self._showUI and self._isCanShowLeft)
	gohelper.setActive(self._goMask, self._showUI)
end

function MainUISwitchInfoView:onOpenFinish()
	gohelper.setActive(self.viewGO, false)
	gohelper.setActive(self.viewGO, true)

	local openAni = self.viewParam and self.viewParam.isAmplify and "open2" or "open1"

	self._rootAnimator:Play(openAni, 0, 0)
end

function MainUISwitchInfoView:_updateSceneInfo()
	if self.viewParam then
		if not self.viewParam.sceneId then
			local sceneId = MainSceneSwitchModel.instance:getCurSceneId()

			MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.ShowPreviewSceneInfo, sceneId)

			if self.viewParam then
				local goodsId = self.viewParam.goodsId
				local name, desc, timeStr = "", "", ""

				if goodsId then
					local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodsId)
					local goodsCo = StoreConfig.instance:getGoodsConfig(goodsId)

					if decorateConfig then
						self._txtSceneLogo.text = decorateConfig.typeName
						desc = decorateConfig.desc
					end

					if goodsCo then
						name = goodsCo.name
					end

					local hasSceneGoods = DecorateModel.instance:hasSceneGoods(goodsId)

					if hasSceneGoods then
						self._weatherSwitchControlComp = self._weatherSwitchControlComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._weatherRoot, WeatherSwitchControlComp)

						self._weatherSwitchControlComp:updateScene(sceneId, MainSceneSwitchCameraDisplayController.instance)
					end

					gohelper.setActive(self._goSceneLogo4, false)
					gohelper.setActive(self._goSceneLogo, true)
					gohelper.setActive(self._weatherRoot, hasSceneGoods)
				else
					local config = lua_scene_ui.configDict[self._selectSkinId]

					if config then
						local itemId = config.itemId
						local itemConfig = lua_item.configDict[itemId]

						if itemConfig then
							name = itemConfig.name
							desc = itemConfig.desc

							if config.defaultUnlock == 1 then
								local info = PlayerModel.instance:getPlayinfo()
								local time = TimeUtil.timestampToString5(ServerTime.timeInLocal(info.registerTime / 1000))

								timeStr = string.format(luaLang("receive_time"), time)
							else
								local itemMo = ItemModel.instance:getById(itemId)

								if itemMo and itemMo.quantity > 0 and itemMo.lastUpdateTime then
									local time = TimeUtil.timestampToString5(ServerTime.timeInLocal(itemMo.lastUpdateTime / 1000))

									timeStr = string.format(luaLang("receive_time"), time)
								end
							end
						end
					end

					gohelper.setActive(self._goSceneLogo4, true)
					gohelper.setActive(self._goSceneLogo, false)
					gohelper.setActive(self._weatherRoot, false)
				end

				self._txtSceneName.text = name
				self._txtSceneDescr.text = desc
				self._txtTime.text = timeStr
			end
		end
	end
end

function MainUISwitchInfoView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self._onPreviewSwitchUIVisible, self)
end

return MainUISwitchInfoView
