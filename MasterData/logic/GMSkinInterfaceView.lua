-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/gmskininterface/GMSkinInterfaceView.lua

module("logic.extensions.gm.view.gmskininterface.GMSkinInterfaceView", package.seeall)

local GMSkinInterfaceView = class("GMSkinInterfaceView", ViewComponent)
local SkinType_Pet = 1
local SkinType_Poster = 2
local SkinType_Independent = 3

function GMSkinInterfaceView:buildUI()
	GMSkinInterfaceView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "leftTop/btnClose")
	self._testCol = {}

	if self._testCol then
		local mainGo = goutil.findChild(self.mainGO, "testCol")

		self._testCol._mainGo = mainGo
		self._testCol._testView = goutil.findChild(mainGo, "testView")
		self._testCol._txtTest = goutil.findChildTextComponent(mainGo, "testView/Viewport/Content")
		self._testCol._btnSwitchDraw = goutil.findChild(mainGo, "btnSwitchDraw")
		self._testCol._txtBtnSwitchDraw = goutil.findChildTextComponent(mainGo, "btnSwitchDraw/txt")
		self._testCol._btnSwitchCompType = goutil.findChild(mainGo, "btnSwitchCompType")
		self._testCol._dropdown = goutil.findChild(mainGo, "dropdown")
		self._testCol._dropdownComp = DropDownAdapter.Get(self._testCol._dropdown)
	end

	self._ctrlCol = {}

	if self._ctrlCol then
		local mainGo = goutil.findChild(self.mainGO, "ctrlCol")

		self._ctrlCol._mainGo = mainGo
		self._ctrlCol._btnScaleAdd = goutil.findChild(mainGo, "btnScaleAdd")
		self._ctrlCol._btnScaleLess = goutil.findChild(mainGo, "btnScaleLess")
		self._ctrlCol._joystickBg = goutil.findChild(mainGo, "joystickview/joystickArea/joystickbackground")
		self._ctrlCol._virtualJoystick = goutil.addComponentOnce(self._ctrlCol._joystickBg, typeof(VirtualJoystick))
		self._ctrlCol._joystickCtrl = goutil.findChildComponent(mainGo, "joystickview", typeof(ClickToShowJoystick))

		GameUtil.SetActive(self._ctrlCol._joystickCtrl.gameObject, true)
		GameUtil.SetActive(self._ctrlCol._joystickBg, true)
	end

	self._spineCol = {}

	if self._spineCol then
		local mainGo = goutil.findChild(self.mainGO, "spineCol")

		self._spineCol._mainGo = mainGo
		self._spineCol._spineInterface = goutil.findChild(mainGo, "spineInterface")
		self._spineCol._CompType_SkeletonGraphic = goutil.findChild(mainGo, "CompType_SkeletonGraphic")
		self._spineCol._spineRoot = goutil.findChild(mainGo, "CompType_SkeletonGraphic/spineRoot")
		self._spineCol._CompType_SkeletonAnimation = goutil.findChild(mainGo, "CompType_SkeletonAnimation")
		self._spineCol._spineImage = goutil.findChild(mainGo, "CompType_SkeletonAnimation/spineImage")
		self._petPhotoShow = PetPhotoShow.Get(self._spineCol._spineImage)

		self._petPhotoShow:setCallBackOnEffLoadedAfter(GameUtil.handler(self._onReloadSpineInterfaceCompOfSkeletonAnimation, self))
		self._petPhotoShow:setCallBackOnEffUnloadBefore(GameUtil.handler(self._onUnReloadSpineInterfaceCompOfSkeletonAnimation, self))
	end

	self._extendView = goutil.findChild(self.mainGO, "extendView")
	self._bagstartToggle = self:getGo("testCol/bagstartToggle")
	self._checkboxBagstart = self:getGo("testCol/bagstartToggle/checkbox")
	self._btnShowTest = self:getGo("btnShowTest")
end

function GMSkinInterfaceView:bindEvents()
	GMSkinInterfaceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._testCol._btnSwitchDraw, self._onClickBtnSwitchDraw, self)
	GameUtil.addClickHandler(self._testCol._btnSwitchCompType, self._onClickBtnSwitchCompType, self)
	GameUtil.addClickHandler(self._ctrlCol._btnScaleAdd, function()
		self:_onClickBtnCtrlScale(true)
	end, self)
	GameUtil.addClickHandler(self._ctrlCol._btnScaleLess, function()
		self:_onClickBtnCtrlScale(false)
	end, self)
	GameUtil.addClickHandler(self._btnShowTest, self._onClickBtnShowTest, self)
	GameUtil.addClickHandler(self._bagstartToggle, self._onClickBagstartToggle, self)
	self._ctrlCol._virtualJoystick:AddDownListener(self._onJoystickDown, self)
	self._ctrlCol._virtualJoystick:AddUpListener(self._onJoystickUp, self)
	self._ctrlCol._virtualJoystick:AddDragListener(self._onJoystickDrag, self)
end

function GMSkinInterfaceView:unbindEvents()
	GMSkinInterfaceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._testCol._btnSwitchDraw)
	GameUtil.rmClickHandler(self._testCol._btnSwitchCompType)
	GameUtil.rmClickHandler(self._ctrlCol._btnScaleAdd)
	GameUtil.rmClickHandler(self._ctrlCol._btnScaleLess)
	GameUtil.rmClickHandler(self._btnShowTest)
	GameUtil.rmClickHandler(self._bagstartToggle)
	self._ctrlCol._virtualJoystick:RemoveUpListener()
	self._ctrlCol._virtualJoystick:RemoveDragListener()
end

function GMSkinInterfaceView:onEnter()
	GMSkinInterfaceView.super.onEnter(self)

	self._isBoxDrawUi = self._isBoxDrawUi or false

	self:_setSwitchCompType(SpineEnum.CompType_SkeletonGraphic)
	self:_onUpdateUI()
	self:_startTicking()
	self.addGEvent(self, MsEnum.Notify_SpineInterfaceBagExtension, self._notify_SpineInterfaceBagExtension, self)
end

function GMSkinInterfaceView:onExit()
	GMSkinInterfaceView.super.onExit(self)
	self:_onClearUI()

	if self._spineComp then
		self._spineComp:unload()
	end
end

function GMSkinInterfaceView:_onUpdateUI()
	self:_onUpdateDropdownUI()
	self:_updateSpineCompUIShow()
	self:_onUpdateBtnSwitchDrawUI()
	self:_refreshSkipStartAni()
end

function GMSkinInterfaceView:_onClearUI()
	self:_unLoadSpine()
	self:_stopTicking()
	self:_onClearDropdownUI()
end

function GMSkinInterfaceView:_notify_SpineInterfaceBagExtension(eventParams)
	if self._spineComp then
		self._extendViewPresentor = self._spineComp:openExtension(self._extendView, self._viewPresentor, eventParams)
	end
end

function GMSkinInterfaceView:_closeSpineInterfaceExtension()
	if self._extendViewPresentor then
		ViewMgr.instance:close(self._extendViewPresentor.viewName)

		self._extendViewPresentor = nil
	end
end

function GMSkinInterfaceView:_loadSpine(skinId, skinType, compType)
	self:_unLoadSpine()

	if compType == SpineEnum.CompType_SkeletonGraphic then
		self:_loadSpineBySkeletonGraphic(skinId, skinType)
	elseif compType == SpineEnum.CompType_SkeletonAnimation then
		self:_loadSpineBySkeletonAnimation(skinId, skinType)
	end

	self:_updateSpineCompUIShow()
end

function GMSkinInterfaceView:_unLoadSpine()
	self:_unLoadSpineBySkeletonGraphic()
	self:_unLoadSpineBySkeletonAnimation()
end

function GMSkinInterfaceView:_loadSpineBySkeletonGraphic(skinId, skinType)
	if skinType == SkinType_Pet then
		local modelCfg = CharactorFacade.instance:getPetDisplayModelUIPosAndScale(skinId)

		if not modelCfg[1] then
			if not modelCfg[2] then
				local y = 0

				if not modelCfg[3] then
					local scale = 1
					local callBack = GameUtil.handler(self._onReloadSpineInterfaceCompOfSkeletonGraphic, self, skinId)

					self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._spineCol._spineRoot, scale, callBack, true, modelCfg[1], y)
				end
			end
		end
	elseif skinType == SkinType_Poster then
		local callBack = GameUtil.handler(self._onReloadSpineInterfaceCompOfSkeletonGraphic, self, skinId)

		self._role = RoleObjectPool.instance:addPosterToParent(self._role, skinId, true, self._spineCol._spineRoot, nil, callBack)
	end
end

function GMSkinInterfaceView:_unLoadSpineBySkeletonGraphic()
	self:_onUnReloadSpineInterfaceCompOfSkeletonGraphic()

	self._role = RoleObjectPool.instance:removeRole(self._role)
end

function GMSkinInterfaceView:_onReloadSpineInterfaceCompOfSkeletonGraphic(skinId, spineGo, loader)
	local spineGoRect = spineGo:GetComponent(goutil.Type_RectTransform)

	self._spineComp = SpineInterfaceComp.reloadSpineGo(self._spineComp, self._spineCol._spineInterface, skinId, spineGo, spineGoRect)

	self:_setSwitchBoundingBoxDrawUi(self._isBoxDrawUi)
end

function GMSkinInterfaceView:_onUnReloadSpineInterfaceCompOfSkeletonGraphic()
	self:_closeSpineInterfaceExtension()

	if self._spineComp then
		self._spineComp:unload()
	end
end

function GMSkinInterfaceView:_loadSpineBySkeletonAnimation(skinId, skinType)
	if skinType == SkinType_Pet then
		self._petPhotoShow:showPetEffect(skinId, true, 3, nil)
		self._petPhotoShow:showShadow(true)
	elseif skinType == SkinType_Poster then
		self._petPhotoShow:showPetPoster(skinId, true)
	end
end

function GMSkinInterfaceView:_unLoadSpineBySkeletonAnimation()
	self:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()

	if self._petPhotoShow then
		self._petPhotoShow:clear()
	end
end

function GMSkinInterfaceView:_onReloadSpineInterfaceCompOfSkeletonAnimation(photoShow)
	self._spineComp = SpineInterfaceComp.reloadPhotoShow(self._spineComp, self._spineCol._spineInterface, photoShow, true)

	if photoShow and photoShow._showLihui then
		self:_setSwitchBoundingBoxDrawUi(self._isBoxDrawUi)
	end
end

function GMSkinInterfaceView:_onUnReloadSpineInterfaceCompOfSkeletonAnimation()
	self:_closeSpineInterfaceExtension()

	if self._spineComp then
		self._spineComp:unload()
	end
end

function GMSkinInterfaceView:_onClickBtnSwitchDraw()
	if self._spineComp == nil then
		return
	end

	self:_setSwitchBoundingBoxDrawUi(not self._isBoxDrawUi)
end

function GMSkinInterfaceView:_setSwitchBoundingBoxDrawUi(isStart)
	if self._spineComp == nil then
		return
	end

	self._isBoxDrawUi = isStart

	self:_onUpdateBtnSwitchDrawUI()
	GlobalDispatcher:dispatch(GlobalNotify.SpineInterFaceBoundingBoxDrawUi, self._isBoxDrawUi)
end

function GMSkinInterfaceView:_onUpdateBtnSwitchDrawUI()
	self._testCol._txtBtnSwitchDraw.text = self._isBoxDrawUi and "停止描边" or "开启描边"
end

function GMSkinInterfaceView:_onClickBtnSwitchCompType()
	if self._compType == SpineEnum.CompType_SkeletonGraphic then
		self:_setSwitchCompType(SpineEnum.CompType_SkeletonAnimation)
	elseif self._compType == SpineEnum.CompType_SkeletonAnimation then
		self:_setSwitchCompType(SpineEnum.CompType_SkeletonGraphic)
	end
end

function GMSkinInterfaceView:_setSwitchCompType(compType)
	if compType == self._compType then
		return
	end

	self._compType = compType

	self:_onUpdateUI()
end

function GMSkinInterfaceView:_updateSpineCompUIShow()
	if self._compType == SpineEnum.CompType_SkeletonGraphic then
		GameUtil.SetActive(self._spineCol._CompType_SkeletonGraphic, true)
		GameUtil.SetActive(self._spineCol._CompType_SkeletonAnimation, false)
	elseif self._compType == SpineEnum.CompType_SkeletonAnimation then
		GameUtil.SetActive(self._spineCol._CompType_SkeletonGraphic, false)
		GameUtil.SetActive(self._spineCol._CompType_SkeletonAnimation, true)
	end
end

function GMSkinInterfaceView:_startTicking()
	settimer(0, self._onTicking, self)
end

function GMSkinInterfaceView:_stopTicking()
	removetimer(self._onTicking, self)
end

function GMSkinInterfaceView:_onTicking()
	local str = {}
	local strIndex = 1

	str[strIndex] = "---> 监测中 <---\n"

	if self._spineComp then
		strIndex = strIndex + 1
		str[strIndex] = "\n"

		if self._compType == SpineEnum.CompType_SkeletonGraphic then
			str[strIndex] = str[strIndex] .. string.format("\n当前加载方式：%s", "SkeletonGraphic")
		elseif self._compType == SpineEnum.CompType_SkeletonAnimation then
			str[strIndex] = str[strIndex] .. string.format("\n当前加载方式：%s", "SkeletonAnimation")
		end

		strIndex = strIndex + 1
		str[strIndex] = "\n"
		str[strIndex] = self._spineComp:isForbidOp() and str[strIndex] .. string.format("\n是否禁止操作： <color=#eb4624>禁止</color>") or str[strIndex] .. string.format("\n是否禁止操作： <color=#20b376>允许</color>")
		strIndex = strIndex + 1
		str[strIndex] = "\n\n参数："

		for _, paramMgrType in pairs(MsEnum.ParamMgrType) do
			local paramMoList = self._spineComp:getParamMoList(paramMgrType)
			local strLines = {}
			local dataType

			for paramId, paramMo in ipairs(paramMoList) do
				local value = self._spineComp:getParamValue(paramMgrType, paramId)

				if paramMo:getDataType() == MsEnum.DataType.Bool then
					table.insert(strLines, string.format("\n%s-%s: %s", paramMgrType, paramId, value))
				else
					table.insert(strLines, string.format("\n%s-%s: %s(%s~%s)", paramMgrType, paramId, value, paramMo:getMinOfDefault(), paramMo:getMaxOfDefault()))
				end
			end

			for _, v in ipairs(strLines) do
				str[strIndex] = str[strIndex] .. v
			end
		end

		strIndex = strIndex + 1
		str[strIndex] = "\n\n行为层："

		for _, fsm in ipairs(self._spineComp:getFsmList()) do
			local curState = fsm:getCurState()
			local value = string.format("\nlayer=%s - (%s) -> %s", curState._behaviorLayerId, curState._behaviorId, curState:getNextStateId())

			str[strIndex] = str[strIndex] .. value
		end
	end

	local fs = ""

	for i = 1, #str do
		fs = fs .. str[i]
	end

	self._testCol._txtTest.text = fs
end

function GMSkinInterfaceView:_onUpdateDropdownUI()
	self:_onClearDropdownUI()

	self._dropdownInfoList = {}

	local dataList = SpineInterfaceConfig.instance:getMsBaseDataList()

	for _, data in ipairs(dataList) do
		local skinType = SkinType_Independent
		local petName
		local skinData = PetSkinConfig.instance:getPetSkinCfg(data.skinId)

		if skinData then
			petName = skinData.skinName
			skinType = SkinType_Pet
		else
			local posterData = PetSkinConfig.instance:getPosterModelCo(data.skinId)

			if posterData then
				petName = posterData.name
				skinType = SkinType_Poster
			end
		end

		if skinType ~= SkinType_Independent then
			local info = {}

			info.skinId = data.skinId
			info.data = data
			info.petName = petName
			info.skinType = skinType

			table.insert(self._dropdownInfoList, info)
		end
	end

	local dropdownComp = self._testCol._dropdownComp

	dropdownComp:AddOnValueChanged(self._onValueChanged, self)
	dropdownComp:AddOptions("选择精灵")

	for _, info in ipairs(self._dropdownInfoList) do
		dropdownComp:AddOptions(string.format("%s - %s", info.petName, info.skinId))
	end

	dropdownComp:SetValue(dropdownComp:GetValue())
	self:_onValueChanged(dropdownComp:GetValue())
end

function GMSkinInterfaceView:_onClearDropdownUI()
	local dropdownComp = self._testCol._dropdownComp

	if dropdownComp then
		dropdownComp:RemoveOnValueChanged()
		dropdownComp:ClearOptions()
	end
end

function GMSkinInterfaceView:_onValueChanged(value)
	local info = self._dropdownInfoList[value]
	local skinId = checknumber(info and info.skinId)

	if skinId > 0 then
		self:_loadSpine(skinId, info.skinType, self._compType)
	else
		self:_unLoadSpine()
	end
end

function GMSkinInterfaceView:_onClickBtnCtrlScale(isToAdd)
	self._x, self._y = Framework.TransformUtil.GetLocalScale(self._spineCol._mainGo.transform, 0, 0, 0)

	if isToAdd then
		GameUtil.setLocalScale(self._spineCol._mainGo, self._x + 0.1, self._y + 0.1)
	else
		GameUtil.setLocalScale(self._spineCol._mainGo, self._x - 0.1, self._y - 0.1)
	end
end

function GMSkinInterfaceView:_onJoystickDown()
	GameUtil.SetActive(self._ctrlCol._joystickBg, true)
end

function GMSkinInterfaceView:_onJoystickUp()
	GameUtil.SetActive(self._ctrlCol._joystickBg, false)
end

function GMSkinInterfaceView:_onJoystickDrag(x, y)
	x, y = GameUtil.normalize(x, y, 0)
	self._x, self._y = Framework.TransformUtil.GetLocalPos(self._spineCol._mainGo.transform, 0, 0, 0)

	GameUtil.setLocalPos(self._spineCol._mainGo, self._x - x * 30, self._y - y * 30)
end

function GMSkinInterfaceView:_onClickBtnShowTest()
	GameUtil.SetActive(self._testCol._mainGo, not GameUtil.GetActive(self._testCol._mainGo))
end

function GMSkinInterfaceView:_onClickBagstartToggle()
	local skip = BagPetSkinController.instance:getAutoSkipStartAni()

	BagPetSkinController.instance:setAutoSkipStartAni(not skip)
	self:_refreshSkipStartAni()
end

function GMSkinInterfaceView:_refreshSkipStartAni()
	local skip = BagPetSkinController.instance:getAutoSkipStartAni()

	GameUtil.SetActive(self._checkboxBagstart, skip)
end

return GMSkinInterfaceView
