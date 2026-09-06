-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/MyCardView.lua

module("logic.extensions.roleinfo.view.MyCardView", package.seeall)

local MyCardView = class("MyCardView", ViewComponent)

function MyCardView:ctor()
	MyCardView.super.ctor(self)

	self._lastUserId = false
end

function MyCardView:bindEvents()
	MyCardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._Btn_Right, GameUtil.handler(self.onRoleTrun, self, 2))
	GameUtil.addClickHandler(self._Btn_Left, GameUtil.handler(self.onRoleTrun, self, -2))
	GameUtil.addClickHandler(self._Btn_Mount, self._onClickMount, self)
	self._rightLp:AddToggledListener(function(tar, isUp)
		self:onRoleTrun(2)
	end, self)
	self._leftLp:AddToggledListener(function(tar, isUp)
		self:onRoleTrun(-2)
	end, self)
end

function MyCardView:unbindEvents()
	MyCardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._Btn_Right, self)
	GameUtil.rmClickHandler(self._Btn_Left, self)
	GameUtil.rmClickHandler(self._Btn_Mount, self)
end

function MyCardView:buildUI()
	MyCardView.super.buildUI(self)

	self.goldBarCon = goutil.findChild(self.mainGO, "goldBarCon")
	self._Btn_Left = self:getGo("Nego_Middle/Nego_UI/Btn_Left")
	self._Btn_Right = self:getGo("Nego_Middle/Nego_UI/Btn_Right")
	self._leftLp = self._Btn_Left:GetComponent("UILongPressed")
	self._rightLp = self._Btn_Right:GetComponent("UILongPressed")
	self._camera = self:getGo("Camera")
	self._parentNode = self:getGo("Camera/ParentNode")
	self._drag = Framework.UIDragTrigger.Get(self:getGo("Drag"))

	local _Nego_Middle = self:getGo("Nego_Middle")

	self._Nego_Character = goutil.findChild(_Nego_Middle, "Nego_Base/Nego_Character").gameObject
	self._Nego_ClickCharacter = goutil.findChild(_Nego_Middle, "Nego_Base/Nego_ClickCharacter").gameObject
	self._Btn_Mount = self:getGo("btnMount")
	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
	self._modelBG = goutil.findChild(self._modelCam, "bg")
	self._middleBG = goutil.findChild(self._modelCam, "middleBg")
	self._rolePoint = goutil.findChild(self._modelCam, "rolePoint/parent")
	self._rolePointAvatarPlayer = self:getGo("modelCam/rolePoint/parent/rolePointAvatarPlayer")
	self._middleBgAvatarPlayer = self:getGo("modelCam/middleBg/middleBgAvatarPlayer")
	self._bgAvatarPlayer = self:getGo("modelCam/bg/bgAvatarPlayer")
	self._goRoles = {}
	self._resRoles = {}
	self._titlePoint = self:getGo("titlePoint")
	self._titleEffView = TilteEffView.Get(self._titlePoint, self)
	self.redpointGo = self:getGo("btnMount/redPoint")
	self._mountLock = self:getGo("btnMount/imgLock")
	self._exteriorskinCon = self:getGo("exteriorskinCon")
	self._petShowViewCon = self:getGo("petShowViewCon")
end

function MyCardView:destroyUI()
	MyCardView.super.destroyUI(self)

	self._lastUserId = false
end

function MyCardView:onEnter()
	MyCardView.super.onEnter(self)
	GlobalModel.instance:visibleSceneHUDs(false)
	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self.checkUp, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self.checkUp, self)
	GlobalDispatcher:addListener(GlobalNotify.TitleUpdate, self.setupTitle, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.onRoleVisualEvent, self._onVisualEvent, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateDressInfoDaily, self._updateDressInfoDaily, self)
	self.addGEvent(self, GlobalNotify.MyCardSetBtnMount, self._onSetBtnMount, self)
	self.addGEvent(self, GlobalNotify.CardInfoUpdate, self._OnClickAnyFunc, self)
	self.addGEvent(self, GlobalNotify.UpdateExterior, self._setExteriorUI, self)
	self.addGEvent(self, GlobalNotify.LoadAllUniquePropsRes, self._setExteriorUI, self)
	self.addGEvent(self, GlobalNotify.CardInfoOpenPetShowSeletView, self._onOpenBegPetColView, self)
	RedPointController.instance:regRedPoint(self.redpointGo, RedPointModel.ID_MOUNT_ENTRANCE)
	Framework.TransformUtil.SetLocalRotation(self._rolePoint.transform, 0, 180, 0)
	Framework.TransformUtil.SetLocalScale(self._rolePoint.transform, 200, 200, 200)

	self._goRoles = {}
	self._resRoles = {}

	self:setRoleView3()
	self:_showGoldBar()
	self:refresh()
	self:_updateRedpoint()
	RoleController.instance:addClockListener()
	BattleStartAnimController.instance:sendPM_LoadAllUniquePropsReq()
end

function MyCardView:_showGoldBar()
	MainUIController.instance:showSkinGlodBar(self.goldBarCon, self._viewPresentor)
end

function MyCardView:_setExteriorUI()
	local exteriorCfg = ExteriorController.instance:getExteriorCfg()
	local skinName = exteriorCfg.skinPath
	local viewParams = self._viewPresentor._openParam

	self:showTabAt(self._exteriorskinCon, skinName, self._avatar, GameUtil.unpack10(viewParams))
end

function MyCardView:setRoleView3()
	self._drag:AddDragListener(self._onDrag, self)
	CameraAdaptiveMgr.instance:addAdaptiveResolution(self._modelCam)

	self._modelCam.transform.parent = nil

	if not self._avatar then
		self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

		self._avatar:addListener(AvatarNotify.OnAvatarLoaded, self._updateAvatarPosition, self)
		self._avatar:setParent(self._rolePointAvatarPlayer.transform)
		self._avatar:setLayer(SceneLayer.UI3D_Value)
		self._avatar:setOwnerUserId(RoleModel.instance.curCardInfo.userId)
	end

	self._lastUserId = RoleModel.instance.curCardInfo.userId

	local avatarMo = self:_updateAvatarMo()

	self._avatar:updateByMo(avatarMo)
	self._avatar:updateExtBgParent(self._bgAvatarPlayer, self._middleBgAvatarPlayer, self)
end

function MyCardView:_updateAvatarMo()
	local curCardInfo = RoleModel.instance.curCardInfo
	local gender = curCardInfo.gender
	local clothes = curCardInfo.clothes
	local mountId = curCardInfo.mountId
	local illusionCutePetRace = curCardInfo.illusionCutePetRace
	local skeId = DressModel.instance:getSkeIdByGender(gender)
	local avatarMo

	if checknumber(illusionCutePetRace) > 0 then
		avatarMo = DressModel.instance:getAvatarPlayerMo(skeId, clothes, 0)
		skeId = DressModel.instance:getSkeIdByPetRace(illusionCutePetRace)

		local temp = {}
		local bgId, spId

		if avatarMo then
			bgId = avatarMo:getDataByType(AvatarDataType.UIBG)
			spId = avatarMo:getDataByType(AvatarDataType.UISpine)
		end

		if bgId then
			table.insert(temp, bgId)
		end

		if spId then
			table.insert(temp, spId)
		end

		avatarMo = DressModel.instance:getAvatarPlayerMo(skeId, temp, 0)
	else
		avatarMo = DressModel.instance:getAvatarPlayerMo(skeId, clothes, mountId)
	end

	return avatarMo
end

function MyCardView:_updateAvatarPosition(avatar)
	if self._avatar == avatar then
		Framework.TransformUtil.SetLocalPos(self._rolePoint.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(self._rolePoint.transform, 200, 200, 200)

		if self._avatar.avatarmo.mount then
			local mountCo = MountConfig.instance:getMountCo(self._avatar.avatarmo.mount)

			if mountCo and mountCo.roleview_position then
				Framework.TransformUtil.SetLocalPos(self._rolePoint.transform, mountCo.roleview_position[1] or 0, mountCo.roleview_position[2] or 0, mountCo.roleview_position[3] or 0)
			end

			if mountCo and mountCo.scale_ifmt then
				local scaleParam = checknumber(mountCo.scale_ifmt)

				if scaleParam > 0 then
					Framework.TransformUtil.SetLocalScale(self._rolePoint.transform, scaleParam, scaleParam, scaleParam)
				end
			end
		end
	end
end

function MyCardView:_loadRole()
	if self._isRoleLoading then
		return
	end

	self._isRoleLoading = true
	self._resRoles[self._resPath] = nil

	getres(self._resPath, self._onRoleLoaded, self, ResType.AssetBundle, true)
end

function MyCardView:_onEffectLoaded(go, res)
	self._charactorGo = go

	Framework.TransformUtil.SetLocalRotation(go.transform, 0, 180, 0)
end

function MyCardView:_getInstance(path)
	local res = self._resLoader:getResource(path)

	if res then
		local prefab = res:GetMainAsset()

		if prefab then
			return goutil.clone(prefab)
		end
	end

	return nil
end

function MyCardView:onEnterFinished()
	MyCardView.super.onEnterFinished(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
end

function MyCardView:onExit()
	self._titleEffView:clear()
	GlobalModel.instance:visibleSceneHUDs(true)
	MyCardView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewOpen, self.checkUp, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnViewClose, self.checkUp, self)
	GlobalDispatcher:removeListener(GlobalNotify.TitleUpdate, self.setupTitle, self)
	GlobalDispatcher:removeListener(GlobalNotify.onRoleVisualEvent, self._onVisualEvent, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateDressInfoDaily, self._updateDressInfoDaily, self)
	RedPointController.instance:unregRedPoint(self.redpointGo)
	RoleController.instance:removeClockListener()
	self._drag:RemoveDragListener()

	self._modelCam.transform.parent = self.mainGO.transform

	CameraAdaptiveMgr.instance:removeAdaptiveResolution(self._modelCam)
	self:_unloadRole()
	RedPointController.instance:unregRedPoint(self.btnSettingRed)
	LightMgr.instance:setLightForNormalScene()

	self._lastUserId = nil
end

function MyCardView:_unloadRole()
	for k, role in pairs(self._goRoles) do
		print("destroy go name = " .. role.name)
		goutil.destroy(role)

		self._goRoles[k] = nil
	end

	for k, res in pairs(self._resRoles) do
		if res == nil then
			rescache:RemoveListener(k, self._onRoleLoaded, self)
		else
			res:Release()

			self._resRoles[k] = nil
		end
	end

	self._goRoles = nil
	self._resRoles = nil
	self._isRoleLoading = false
	self._resPath = nil
	self._charactorGo = nil

	if self._avatar then
		self._avatar:removeListener(AvatarNotify.OnAvatarLoaded, self._updateAvatarPosition, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function MyCardView:unloadCharacter()
	if self._charactorGo then
		goutil.destroy(self._charactorGo, true)

		self._charactorGo = nil
	end

	GameUtil.unloadMultiResLoaderResource(self._resLoader)

	self._resLoader = nil

	if self._roleEffect then
		self._roleEffect:clear()
	end

	self._roleEffect:clear()
end

function MyCardView:onExitFinished()
	MyCardView.super.onExitFinished(self)
end

function MyCardView:_onClickClose()
	if self._isLoadingSpine then
		return
	end

	UIStateManager.instance:popByName(self._viewPresentor.viewName)
end

function MyCardView:_reloadDress()
	self:setRoleView3()
end

function MyCardView:_onDrag(eventData)
	self:onRoleTrun(eventData.delta.x)
end

function MyCardView:onRoleTrun(deltaX)
	local localRotation = Quaternion.Euler(0, -0.5 * deltaX * 1, 0) * self._rolePoint.transform.localRotation
	local eulerAngles = localRotation.eulerAngles

	Framework.TransformUtil.SetLocalRotation(self._rolePoint.transform, 0, eulerAngles.y, 0)
end

function MyCardView:_OnClickAnyFunc(name)
	if self._avatar then
		self._avatar:setVisible(true)
		GameUtil.SetActive(self._rolePointAvatarPlayer, true)
		GameUtil.SetActive(self._middleBgAvatarPlayer, true)
		GameUtil.SetActive(self._bgAvatarPlayer, true)
	end

	if name == ViewName.DressshowView then
		-- block empty
	elseif name == ViewName.CardInfoPetSkinShowView then
		goutil.setActive(self._nodeNego_Left, false)
		goutil.setActive(self._Btn_Mount, false)
		goutil.setActive(self._titlePoint, false)
		goutil.setActive(self._Btn_Left, false)
		goutil.setActive(self._Btn_Right, false)

		if self._avatar then
			self._avatar:setVisible(false)
			GameUtil.SetActive(self._rolePointAvatarPlayer, false)
			GameUtil.SetActive(self._middleBgAvatarPlayer, false)
			GameUtil.SetActive(self._bgAvatarPlayer, false)
		end
	elseif name == ViewName.ExteriorView or name == ViewName.OtherExteriorView then
		goutil.setActive(self._nodeNego_Left, false)
		goutil.setActive(self._titlePoint, false)
		goutil.setActive(self._Btn_Mount, false)
		goutil.setActive(self._Btn_Left, false)
		goutil.setActive(self._Btn_Right, false)

		if self._avatar then
			self._avatar:setVisible(false)
			GameUtil.SetActive(self._rolePointAvatarPlayer, false)
			GameUtil.SetActive(self._middleBgAvatarPlayer, false)
			GameUtil.SetActive(self._bgAvatarPlayer, false)
		end
	else
		goutil.setActive(self._nodeNego_Left, true)
		goutil.setActive(self._titlePoint, true)
		goutil.setActive(self._Btn_Mount, true)
		goutil.setActive(self._Btn_Left, true)
		goutil.setActive(self._Btn_Right, true)

		if self._avatar then
			self._avatar:setVisible(false)
			GameUtil.SetActive(self._rolePointAvatarPlayer, false)
			GameUtil.SetActive(self._middleBgAvatarPlayer, false)
			GameUtil.SetActive(self._bgAvatarPlayer, false)
		end

		if self._avatar then
			self._avatar:setVisible(true)
			GameUtil.SetActive(self._rolePointAvatarPlayer, true)
			GameUtil.SetActive(self._middleBgAvatarPlayer, true)
			GameUtil.SetActive(self._bgAvatarPlayer, true)
		end
	end
end

function MyCardView:_onVisualEvent(name)
	if self.curPresentor ~= nil then
		self.curPresentor:_onVisualEvent(name)
	end
end

function MyCardView:checkUp(name)
	return
end

function MyCardView:refresh()
	self.curMo = RoleModel.instance:getCardInfoMo(RoleModel.CardBelong.My)

	self:setupTitle((RoleModel.instance.curCardInfo.userId == RoleModel.instance:getUserId() or nil) and TitleModel.instance:getCurTitleId())

	local isOpen = FuncOpenModel.instance:getFuncIsOpen(101)

	GameUtil.SetActive(self._mountLock, not isOpen)
end

function MyCardView:setupTitle(id)
	self._titleEffView:setupTitle(id)
end

function MyCardView:_updateRedpoint()
	if self._goTitleRepoint then
		self._goTitleRepoint:SetActive(TitleModel.instance:getRedActiveTotal())
	end
end

function MyCardView:_updateFengkong()
	if not Framework.OSDef.isEditor then
		local btplatformId = BootstrapUtil.getPlatformId()

		if btplatformId == 2 or btplatformId == 10 then
			local needUpgrade = AntiAddictionController.instance:checkNeedUpgrade()

			GameUtil.SetActive(self.btnName, needUpgrade)
			GameUtil.SetActive(self.btnName2, not needUpgrade)
		end
	end
end

function MyCardView:_onClickMount()
	FuncOpenController.instance:openFunc(101)
end

function MyCardView:_onClickBind()
	local url = "http://account.100bt.com/gameBind/index.html"

	UnityWebBridge.registerGetActionListener(function(result)
		UnityWebBridge.unregisterGetActionListener()

		local cb = result.callback
		local tar = result.target

		if tar == "userInfo" then
			local tb = {}

			tb.gameId = SDKManager.getGameId()
			tb.roleId = LoginModel.instance.userId

			UnityWebBridge.registerPostActionListener(function(res)
				UnityWebBridge.unregisterPostActionListener()
			end)
			UnityWebBridge.callbackWebView(cb, tb)
		end
	end)
	UnityWebBridge.openWebView(url, false)
end

function MyCardView:_onClickDressShop()
	FloatWordMgr.instance:show(lang("敬请期待"))
end

function MyCardView:onClickUpgradeAccount()
	AntiAddictionController.instance:gotoUpgradeAccount()
end

function MyCardView:onClickHasUpgrade()
	if SDKManager.getGovAuthStatus() then
		FloatWordMgr.instance:show(lang("您已在本游戏实名"))
	else
		FloatWordMgr.instance:show("正在实名认证中")
	end
end

function MyCardView:onClickSendFlower()
	SendFlowerController.instance:openCharmValueView(self.curMo)
end

function MyCardView:_updateDressInfoDaily()
	local avatarMo = self:_updateAvatarMo()

	if self._avatar then
		self._avatar:updateByMo(avatarMo)
		self._avatar.mountCtrl:updateMountingLayer()
	end
end

function MyCardView:onClickSexChange()
	local leftTime = RoleModel.instance:getNextTransformGenderTime() - ServerTime.now()

	if leftTime > 0 then
		FloatWordMgr.instance:show(langPara("还剩下%s才能再进行性别转换哦~", GameUtil.FormatTimeSymbol(leftTime)))

		return
	end

	UIStateManager.instance:push(ViewName.SexchangetipView)
end

function MyCardView:_onSetBtnMount(bool)
	GameUtil.SetActive(self._Btn_Mount, bool)
end

function MyCardView:_onOpenBegPetColView(list)
	ViewMgr.instance:openAt(self._petShowViewCon, ViewName.BagPetColView, self._viewPresentor, list)
end

return MyCardView
