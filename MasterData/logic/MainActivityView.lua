-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/MainActivityView.lua

module("logic.extensions.mainui.view.MainActivityView", package.seeall)

local MainActivityView = class("MainActivityView", ViewComponent)

function MainActivityView:ctor()
	MainActivityView.super.ctor(self)

	self._activityStatus = 0
	self._topOpenCount = 0
	self._bomRightStatus = 0

	self:addRedPoints()
end

local taskRedpointIDs = {
	1,
	2,
	3,
	4,
	5
}
local needTimerFuncID = {
	2,
	3,
	4,
	11,
	RedPointModel.ID_GetSUPPLY
}

function MainActivityView:addRedPoints()
	MainActivityView.funcIDToRedpointID = {
		{
			RedPointModel.ID_SHOP
		},
		{
			12,
			85,
			10,
			27,
			1006,
			1007,
			1008,
			1009,
			115
		},
		{
			RedPointModel.ID_SEVENSIGN1,
			14,
			70,
			117
		},
		{
			17
		},
		{
			4,
			5,
			23
		},
		{
			9
		},
		{
			RedPointModel.ID_BAG,
			RedPointModel.ID_BAG_PIECE,
			RedPointModel.ID_PET_TITLE_MAIN
		},
		{
			RedPointModel.ID_PETRELATION
		},
		[11] = {
			RedPointModel.ID_EGG
		},
		[22] = {
			6,
			RedPointModel.ID_PK
		},
		[23] = {
			7
		},
		[43] = {
			RedPointModel.ID_LOTTERY
		},
		[44] = {
			23
		},
		[47] = {
			RedPointModel.ID_MATERIALCHALLENGE,
			RedPointModel.ID_PLOTCOPY,
			RedPointModel.ID_TEACHING_DAILY,
			RedPointModel.ID_HOLY_STRIPE_COPY_ENTER
		},
		[35] = {
			15
		},
		[62] = {
			29
		},
		[63] = {
			32
		},
		[64] = {
			RedPointModel.ID_TIME_WHEEL,
			RedPointModel.ID_THRONE,
			RedPointModel.ID_PETASSIST,
			RedPointModel.ID_UPGRADE_NINEPLACE,
			RedPointModel.ID_NINEPLACE_CAN_UNLOCK,
			142
		},
		[95] = {
			RedPointModel.ID_PayShopHUD
		},
		[99] = {
			RedPointModel.ID_Legend
		},
		[111] = {
			RedPointModel.ID_SCRATCH
		},
		[112] = {
			RedPointModel.ID_POPULACELEGEND
		},
		[113] = {
			51
		},
		[118] = {
			RedPointModel.ID_TOFIRSTCHARGE_GIFT
		},
		[989] = {
			RedPointModel.ID_TOFIRSTCHARGE_GIFT_PLUS
		},
		[119] = {
			RedPointModel.ID_YEARCARD2022,
			RedPointModel.ID_YEARCARD_SIGNIN,
			RedPointModel.ID_YEARCARD2023,
			RedPointModel.ID_YEARCARD2023_SIGNIN
		},
		[120] = {
			RedPointModel.ID_MONOPOLY
		},
		[131] = {
			RedPointModel.ID_TREASUREOX
		},
		[145] = {
			40,
			1006,
			1007,
			1008,
			1009,
			RedPointModel.ID_NINEPLACE_BATTLE,
			62
		},
		[150] = {
			64
		},
		[156] = {
			65
		},
		[158] = {
			66
		},
		[170] = {
			RedPointModel.ID_GOODFEEL
		},
		[175] = {
			RedPointModel.ID_TIMECAPSULE
		},
		[171] = {
			73
		},
		[181] = {
			RedPointModel.ID_HOLYCHALL2
		},
		[182] = {
			57,
			80,
			66,
			-22,
			15,
			82,
			42,
			69,
			81,
			RedPointModel.ID_ActivityExchangShop_Summary
		},
		[185] = {
			RedPointModel.ID_VIP
		},
		[186] = {
			15
		},
		[202] = {
			RedPointModel.ID_JigSAW
		},
		[209] = {
			RedPointModel.ID_LUCKYDRAW_ENTRANCE
		},
		[211] = {
			RedPointModel.ID_DREAMTEAM
		},
		[210] = {
			RedPointModel.ID_ACCUMGIFT
		},
		[222] = {
			RedPointModel.ID_DREAMCHAT
		},
		[225] = {
			RedPointModel.ID_PETSEARCH
		},
		[231] = {
			RedPointModel.ID_DREAMISLAND
		},
		[238] = {
			RedPointModel.ID_OPSUMMARY_NEWONE
		},
		[245] = {
			RedPointModel.ID_SCUFFLE_TASK,
			RedPointModel.ID_SCUFFLE_REWARD
		},
		[247] = {
			102
		},
		[249] = {
			RedPointModel.ID_CARD_HOT
		},
		[250] = {
			104
		},
		[262] = {
			RedPointModel.ID_PLAYERRETURN,
			RedPointModel.ID_RETURNTASK1
		},
		[286] = {
			RedPointModel.ID_ONEPEOPLECOPY
		},
		[18] = {
			115
		},
		[274] = {
			120
		},
		[287] = {
			RedPointModel.ID_NUMBERBOMB
		},
		[306] = {
			134
		},
		[311] = {
			RedPointModel.ID_DRESSSHOPADDNEWGOODSITEM
		},
		[313] = {
			RedPointModel.ID_ANLONGCOPY
		},
		[338] = {
			RedPointModel.ID_ImageFragmentCollection
		},
		[339] = TimeLimitedConfig.instance:getCurReturnRedPointIds(),
		[370] = {
			RedPointModel.ID_RECALLTASK1
		},
		[405] = {
			RedPointModel.ID_WUMMONTOWER_REWARDS
		},
		[420] = {
			RedPointModel.ID_PETBLESS
		},
		[427] = {
			RedPointModel.ID_PETNEWNOTICE
		},
		[458] = {
			RedPointModel.ID_NEWHANDWALFARE
		},
		[433] = {
			RedPointModel.ID_PayShopHUD
		},
		[472] = {
			RedPointModel.ID_DRAGONTRAIL_DAILY,
			RedPointModel.ID_DRAGONTRAIL_EXCHANGESHOP,
			197
		},
		[514] = {
			RedPointModel.ID_GODDESS_COLLECT_WHOLELIFE,
			213
		},
		[533] = {
			226
		},
		[623] = TutorSystemController.instance:getRedIdList()
	}

	local cfg = MainActivityConfig.instance:getRedPointCfg()

	if cfg then
		for k, v in pairs(cfg) do
			local lastTb = checktable(MainActivityView.funcIDToRedpointID[v.funcId])
			local temp = checktable(v.redpointIds)
			local map = {}

			for ka, va in pairs(lastTb) do
				map[va] = va
			end

			for kb, vb in pairs(temp) do
				map[vb] = vb
			end

			MainActivityView.funcIDToRedpointID[v.funcId] = TableUtil.toList(map)
		end
	end
end

function MainActivityView:bindEvents()
	self._btnTopArrow:AddClickListener(self._onClickTopArrow, self)
	self._btnBomArrow:AddClickListener(self._onClickBomArrow, self)
end

function MainActivityView:unbindEvents()
	self._btnTopArrow:RemoveClickListener()
	self._btnBomArrow:RemoveClickListener()
end

function MainActivityView:destroyUI()
	for k, v in pairs(self._funcBtns) do
		local btn = Framework.ButtonAdapter.Get(v.go)

		if btn then
			btn:RemoveClickListener()
		end
	end
end

function MainActivityView:buildUI()
	self._btnTopArrow = self:getBtn("Btn_Arrow")
	self._moveNode = self:getGo("Nego_Activity/MoveNode")

	self:buildFuncBtns()

	self._goTaskRedpoint = self:getGo("Nego_TaskAndTeam/Btn_Task/ImgC_RedPoint")
	self._goPlayerRedpoint = self:getGo("Nego_Player/ImgC_Head/ImgC_RedPoint")
	self._effBindGo = self:getGo("effectNode")
	self._btnBomArrow = self:getBtn("rightbom/Btn_Switch")
	self._bottomCenterGo = self:getGo("bottomCenter")
	self._customOpens = self:getGo("customOpens")
	_, self._initY, _ = Framework.TransformUtil.GetLocalPos(self._customOpens.transform, 0, 0, 0)

	self._btnBomArrow:IngoreGlobalClickListener(true)
end

function MainActivityView:buildFuncBtns()
	local dic = FuncOpenConfig.instance:getMainUIFuncs()

	self._funcParents = {
		[GameEnum.MainUIFuncArea.TopRight_1] = self:getGo("Nego_Activity/MoveNode/Btn_Container").transform,
		[GameEnum.MainUIFuncArea.TopRight_2] = self:getGo("Nego_Activity/MoveNode/Btn_Container_2").transform,
		[GameEnum.MainUIFuncArea.BomRight_Vertical] = self:getGo("Nego_Btn2").transform,
		[GameEnum.MainUIFuncArea.BomRight_Horizontal] = self:getGo("Nego_Btn").transform
	}
	self._funcBtns = {}

	local parent, go, cfg

	for k, v in pairs(dic) do
		local cloneGo

		if self._funcParents[k] then
			cloneGo = self._funcParents[k]:GetChild(0).gameObject

			cloneGo:SetActive(false)
		end

		for _, funcId in ipairs(v) do
			cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

			local obj = {}

			if k == GameEnum.MainUIFuncArea.Fixed then
				go = self:getGo(cfg.path)
				obj.redPoint = goutil.findChild(go, "imgPoint")
			else
				go = goutil.cloneAndSetParent(cloneGo, self._funcParents[k], "btn_" .. funcId)
				obj.parentGo = go
				go = go.transform:GetChild(0).gameObject
				go.name = "cell_" .. funcId

				local imgSpriteChange = goutil.findChildComponent(go, "ImgC_Icon", typeof(UIImageSpriteChange))
				local image = imgSpriteChange:GetComponent(goutil.Type_UIImage)

				if image then
					image:SetNativeSize()
				end

				local specialTag = goutil.findChild(go, "ImgC_Icon/specialTag")

				GameUtil.SetActive(specialTag, false)

				local txtName = goutil.findChildTextComponent(go, "TxtC_Name")
				local nameBg = goutil.findChild(go, "nameBg")

				obj.redPoint = goutil.findChild(imgSpriteChange.gameObject, "imgPoint")

				goutil.setActive(nameBg, not cfg.isHideName)

				if txtName then
					txtName.text = cfg.name

					txtName.gameObject:SetActive(cfg.isHideName ~= true)
				end

				if imgSpriteChange then
					imgSpriteChange:ChangeSprite(string.nilorempty(cfg.icon) and "icon_shangcheng" or cfg.icon)
				end

				if k == GameEnum.MainUIFuncArea.BomRight_Horizontal then
					obj.expandGo = goutil.findChild(go, "expandGo")

					local list = self:_isMainExpandFatBtn(funcId)

					if list and #list > 0 then
						GameUtil.SetActive(obj.expandGo, true)
						Framework.TransformUtil.SetLocalRotation(obj.expandGo.transform, 0, 0, 90)
					else
						GameUtil.SetActive(obj.expandGo, false)
					end
				end
			end

			local btn = Framework.ButtonAdapter.Get(go)

			if btn then
				btn:AddClickListener(function()
					self:_onClickFunc(funcId)
				end)
			end

			obj.go = go
			obj.area = checknumber(k)

			if self._funcBtns[funcId] ~= nil then
				self._funcBtns[funcId].nextObj = obj
			else
				self._funcBtns[funcId] = obj
			end
		end
	end
end

function MainActivityView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.UpdateMainUIFuncs, self.onUpdateMainUIFuncs, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnNewFunctionOpen, self._checkFuncNeedOpen, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointUpdate, self._onUpdateRedpoint, self)
	GlobalDispatcher:removeListener(GlobalNotify.TaskDataUpdate, self._onTaskUpdate, self)
	GlobalDispatcher:removeListener(GlobalNotify.FuncOpenFinished, self._onFuncOpenFinished, self)
	GlobalDispatcher:removeListener(GlobalNotify.GetNewAchievement, self._openAchievementTips, self)
	GlobalDispatcher:removeListener(GlobalNotify.GetQilinData, self._updateFuncsOpen, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialCountChange, self._updateLocalRedPoints, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationEnter, self._updateLocalRedPoints, self)
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._updateLocalRedPoints, self)
	GlobalDispatcher:removeListener(GlobalNotify.PET_EQUIP_CHANGES, self._updateLocalRedPoints, self)
	GlobalDispatcher:removeListener(PowerCrystalModel.GetInfoSuccessed, self._updateLocalRedPoints, self)
	GlobalDispatcher:removeListener(GlobalNotify.BagPetsInit, self._updateLocalRedPoints, self)
	GlobalDispatcher:removeListener(GlobalNotify.GetFuncBtnPosReq, self._onGetFuncBtnReq, self)
	GlobalDispatcher:removeListener(GlobalNotify.MainBtnExpandViewClose, self.setMainExpandFatBtn, self)
	GlobalDispatcher:removeListener(GlobalNotify.RedPointSetCommandChange, self._handleRedPointSetCommandChange, self)
	GlobalDispatcher:removeListener(GlobalNotify.MainActivityViewStartFuncFlyAnimMask, self._startFuncFlyAnimMask, self)
	self:_endFuncFlyAnimMask()
	RedPointController.instance:unregRedPoint(self._goPlayerRedpoint)
	removetimer(self.updateTimer, self)
	MainUIFacade.instance:setNeedCheckFunc(true)
	ViewMgr.instance:close(ViewName.AchievementTips)

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	if self._activityEff then
		UIEffectManager.instance:stopEffect(self._activityEff)
	end

	self._activityEff = nil
end

function MainActivityView:onExitFinished()
	return
end

function MainActivityView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.UpdateMainUIFuncs, self.onUpdateMainUIFuncs, self)
	GlobalDispatcher:addListener(GlobalNotify.OnNewFunctionOpen, self._checkFuncNeedOpen, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._onUpdateRedpoint, self)
	GlobalDispatcher:addListener(GlobalNotify.TaskDataUpdate, self._onTaskUpdate, self)
	GlobalDispatcher:addListener(GlobalNotify.FuncOpenFinished, self._onFuncOpenFinished, self)
	GlobalDispatcher:addListener(GlobalNotify.GetNewAchievement, self._openAchievementTips, self)
	GlobalDispatcher:addListener(GlobalNotify.GetQilinData, self._updateFuncsOpen, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialCountChange, self._updateLocalRedPoints, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationEnter, self._updateLocalRedPoints, self)
	GlobalDispatcher:addListener(GlobalNotify.FormationRefresh, self._updateLocalRedPoints, self)
	GlobalDispatcher:addListener(GlobalNotify.PET_EQUIP_CHANGES, self._updateLocalRedPoints, self)
	GlobalDispatcher:addListener(PowerCrystalModel.GetInfoSuccessed, self._updateLocalRedPoints, self)
	GlobalDispatcher:addListener(GlobalNotify.BagPetsInit, self._updateLocalRedPoints, self)
	GlobalDispatcher:addListener(GlobalNotify.GetFuncBtnPosReq, self._onGetFuncBtnReq, self)
	GlobalDispatcher:addListener(GlobalNotify.MainBtnExpandViewClose, self.setMainExpandFatBtn, self)
	GlobalDispatcher:addListener(GlobalNotify.RedPointSetCommandChange, self._handleRedPointSetCommandChange, self)
	GlobalDispatcher:addListener(GlobalNotify.MainActivityViewStartFuncFlyAnimMask, self._startFuncFlyAnimMask, self)
	self:_updateRedpoint()
	RedPointController.instance:regRedPoint(self._goPlayerRedpoint, RedPointModel.ID_PLAYER_INFO, RedPointModel.ID_MOUNT_ENTRANCE, RedPointModel.ID_FEEDBACK, RedPointModel.ID_BADGE_COMPOSE, RedPointModel.ID_First_GameSetViewSharetask, RedPointModel.ID_First_GameSetViewFormBond)

	self.check35 = false
	self.timeIdx = 0

	self:updateTimer()
	settimer(1, self.updateTimer, self)

	self._isFuncFlyAnimMask = false

	self:_onClickTopArrow(true)
	self:_onClickBomArrow(true)
end

function MainActivityView:onEnterFinished()
	self:_updateUI()
	self:_checkFuncNeedOpen()
end

function MainActivityView:_updateFuncsOpen()
	local isGuiding = false

	for funcId, v in pairs(self._funcBtns) do
		local btn = v.go
		local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)
		local isSelfOpen = FuncOpenModel.instance:getFuncIsOpenWithCfg(cfg)
		local lock = goutil.findChild(btn, "imgLock")

		if cfg == nil then
			goutil.setActive(btn, false)
		elseif cfg.form ~= 1 then
			local hasChildDone = false
			local ids = self:_isMainExpandFatBtn(funcId)

			if ids ~= nil and #ids >= 0 then
				for __i, _id in ipairs(ids) do
					hasChildDone = FuncOpenModel.instance:getFuncIsOpen(_id)

					if hasChildDone then
						break
					end
				end
			else
				hasChildDone = true
			end

			local selfAct = isSelfOpen

			goutil.setActive(btn, selfAct)
			goutil.setActive(lock, false)
		elseif cfg.form == 1 then
			goutil.setActive(btn, true)
			goutil.setActive(lock, not isSelfOpen)
		end

		if funcId == 35 and RoleModel.instance:getQilinReceived() then
			goutil.setActive(btn, false)
		end

		if funcId == 118 and not RedPointModel.instance:isActive(RedPointModel.ID_TOFIRSTCHARGE) then
			goutil.setActive(btn, false)
		end

		if funcId == 989 and not RedPointModel.instance:isActive(RedPointModel.ID_TOFIRSTCHARGE_PLUS) then
			goutil.setActive(btn, false)
		end

		if funcId == checknumber(ElfKingPathConfig.instance:getCommonValue("FUNCTION_ID")) and not RedPointModel.instance:isActive(checknumber(ElfKingPathConfig.instance:getCommonValue("RED_POINT_ID"))) then
			goutil.setActive(btn, false)
		end

		if funcId == 131 and not SevenDaysModel.instance:GetFunctionIsOpen() then
			goutil.setActive(btn, false)
		end

		if funcId == 177 and QuestionnaireModel.instance:getSurveyId() <= 0 then
			goutil.setActive(btn, false)
		end

		if funcId == 181 and not RedPointModel.instance:isActive(RedPointModel.ID_HOLYCHALL1) then
			goutil.setActive(btn, false)
		end

		if funcId == 186 and not RedPointModel.instance:isActive(83) then
			goutil.setActive(btn, false)
		end

		if funcId == 249 and not RedPointModel.instance:isActive(RedPointModel.ID_CARD_HOT_SHOW_HUB) then
			goutil.setActive(btn, false)
		end

		if funcId == 214 and (PayShopModel.instance:getMibaoTotalBuyTimesById(FirstChargeModel.instance:getCurPetSkinGoodId()) > 0 or not PayShopController.instance:getIsInitGiftTimes()) then
			goutil.setActive(btn, false)
		end

		if funcId == 283 and (PayShopModel.instance:getMibaoTotalBuyTimesById(8001) > 0 or not PayShopController.instance:getIsInitGiftTimes()) then
			goutil.setActive(btn, false)
		end

		if funcId == 119 then
			self:_setYearCardDynamicName(btn, cfg.isHideName)
		end

		if funcId == 982 then
			self:_setElementSparkDynamicName(btn, cfg.isHideName)
		end

		local animalSellCfg = PigraiseController.instance.curSellCfg

		if animalSellCfg and funcId == animalSellCfg.funcId and (PayShopModel.instance:getMibaoTotalBuyTimesById(animalSellCfg.goodsId) > 0 or not PayShopController.instance:getIsInitGiftTimes()) then
			goutil.setActive(btn, false)
		end

		local isHide = MainUIController.instance:getHudVisible(funcId)

		if isHide ~= nil then
			goutil.setActive(btn, isHide and isSelfOpen)
		end

		if BootstrapPjaqGameConfigMgr.isReview and checkbool(cfg.hideWithReview) then
			goutil.setActive(btn, false)
		end

		local isShow = btn.activeSelf

		goutil.setActive(v.parentGo, isShow)

		local nextObj = v.nextObj
		local guideObj

		if nextObj then
			goutil.setActive(nextObj.go, isShow)
			goutil.setActive(nextObj.parentGo, isShow)

			guideObj = nextObj.parentGo

			if nextObj.parentGo and guideObj.transform.parent.name == "attach" then
				isGuiding = true
			end
		end

		guideObj = v.parentGo

		if v.parentGo and guideObj.transform.parent.name == "attach" then
			isGuiding = true
		end
	end

	if not isGuiding then
		for _, v in ipairs(self._funcParents) do
			local grid = v:GetComponent(typeof(UILayoutSingleLine))

			grid:Layout()
		end
	end

	MainUIController.instance:setBtnsList(self._funcBtns)

	if FuncOpenModel.instance:getFuncIsOpen(118) then
		local btn = self._funcBtns[118]
		local resPath = "fx_ui_shouchong/fx_ui_shouchong.prefab"

		if self._activityEff == nil then
			self._activityEff = UIEffectManager.instance:playEffect(self, resPath, btn.go, 0, 0, true, false, nil, function(target, eff)
				goutil.addChildToParent(eff.effGo, btn.go)
			end)
		end

		self._activityEff:setActive(self._activityStatus == 0)
	elseif self._activityEff then
		self._activityEff:setActive(false)
	end

	if FuncOpenModel.instance:getFuncIsOpen(989) then
		local btn = self._funcBtns[989]
		local resPath = "fx_ui_shouchong/fx_ui_shouchong.prefab"

		if self._activityEff == nil then
			self._activityEff = UIEffectManager.instance:playEffect(self, resPath, btn.go, 0, 0, true, false, nil, function(target, eff)
				goutil.addChildToParent(eff.effGo, btn.go)
			end)
		end

		self._activityEff:setActive(self._activityStatus == 0)
	elseif self._activityEff then
		self._activityEff:setActive(false)
	end
end

function MainActivityView:_handleRedPointSetCommandChange(commandId)
	local commandData = RedPointSetConfig.instance:getRdsCommandData(commandId)

	if commandData.commandType == RedPointSetEnum.CommandTypes_MainHud then
		self:_updateRedpoint()
	end
end

function MainActivityView:_updateRedpoint(funcId)
	if funcId then
		self:_updateSingleRedpoint(funcId, nil)

		return
	end

	for funcId, obj in pairs(self._funcBtns) do
		self:_updateSingleRedpoint(funcId, obj.redPoint)
	end

	local showPoint = false

	for _, id in ipairs(taskRedpointIDs) do
		if RedPointModel.instance:isActive(id) then
			showPoint = true

			break
		end
	end

	goutil.setActive(self._goTaskRedpoint, showPoint)

	local btn = self._funcBtns[35]

	if btn and RedPointModel.instance:isActive(15) then
		local effPath = {
			loop = true,
			goPath = "",
			path = "fx_ui_mangmianban/new/fx_ui_mang_tubiao.prefab"
		}
		local parent = btn.gameObject

		if self._eff == nil then
			self._eff = UIEffectManager.instance:playEffect(self, effPath.path, nil, 0, 0, effPath.loop, nil, function(finishHandlerTarget, eff)
				return
			end, function(finishHandlerTarget, eff)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
			end)

			self._eff:setParent(parent.transform)
			self._eff:setScale(1)
		end

		self._eff:setActive(self._activityStatus == 0)
	elseif self._eff then
		self._eff:setActive(false)
	end

	self:_updateLocalRedPoints()
end

function MainActivityView:_onUpdateRedpoint(funcId)
	self:_updateRedpoint(funcId)
	self:_updateFuncsOpen()
end

function MainActivityView:_updateSingleRedpoint(funcId, redGo)
	local obj = self._funcBtns[funcId]

	if obj == nil or obj.redPoint == nil then
		return
	end

	local isNeedActive = false

	if self:_isNeedCheckRedOfTheFunc(funcId) then
		local ids = self:_isMainExpandFatBtn(funcId)

		if ids == nil or #ids == 0 then
			ids = {
				funcId
			}
		end

		for i = 1, #ids do
			local list = MainActivityView.funcIDToRedpointID[checknumber(ids[i])]

			for _, id in ipairs(list or {}) do
				if RedPointModel.instance:isActive(id) then
					isNeedActive = true

					break
				end
			end
		end
	end

	GameUtil.SetActive(obj.redPoint, isNeedActive)
end

function MainActivityView:_isMainExpandFatBtn(funcId)
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

	if cfg == nil then
		return nil
	end

	local list

	return (not string.nilorempty(cfg.expand) or nil) and string.splitToNumber(cfg.expand, ",")
end

function MainActivityView:_getBtnArea(funcId)
	local result

	if self._funcBtns then
		local obj = self._funcBtns[funcId]

		if obj then
			result = obj.area
		end
	end

	return result
end

function MainActivityView:_isNeedCheckRedOfTheFunc(funcId)
	local area = self:_getBtnArea(funcId)
	local areaKey = GameEnum.MainUIFuncAreaKey[area]

	return (self:_isNeedRedOfTheArea(areaKey))
end

function MainActivityView:_isNeedRedOfTheArea(areaKey)
	local isOn = RedPointSetController.instance:isOnOfMainuiArea(areaKey)

	return not isOn
end

function MainActivityView:setMainExpandFatBtn(funcId)
	local obj = self._funcBtns[funcId]

	if obj == nil or obj.expandGo == nil then
		return
	end

	Framework.TransformUtil.SetLocalRotation(obj.expandGo.transform, 0, 0, 90)
end

function MainActivityView:_updateFuncText()
	local nowTime = ServerTime.nowServerLook()

	if self.check35 then
		local time = RoleModel.instance:getRefreshTime() - nowTime
		local offset = math.max(0, time)

		if not self:_showFuncBtnItemTimer(self._funcBtns[35].go, offset) then
			self.check35 = false
		end
	end

	if self._funcBtns[370] and self._funcBtns[370].go and GameUtil.GetActive(self._funcBtns[370].go) then
		local supTime = 0
		local stime, etime = ActivityDefineController.instance:getStartTimeAndEndTime(RecallTaskModel.instance.openActivityType, RecallTaskModel.instance.openActivityId)

		if nowTime < checknumber(etime) then
			supTime = checknumber(etime) - nowTime
		end

		if supTime <= 604800 then
			self:_showFuncBtnItemTimer(self._funcBtns[370].go, supTime)
		end
	end
end

function MainActivityView:_updateDoubleSign()
	local t = self._funcBtns[2]

	if t and t.go and GameUtil.GetActive(t.go) then
		local specialTag = goutil.findChild(t.go, "ImgC_Icon/specialTag")

		goutil.setActive(specialTag, true)
	end
end

function MainActivityView:_showFuncBtnItemTimer(go, supTime)
	if go == nil then
		return false
	end

	local leftTime = goutil.findChild(go, "linqu")
	local txtName = goutil.findChild(go, "TxtC_Name")
	local txtLeftTime = goutil.findChildTextComponent(leftTime, "Text")

	if checknumber(supTime) > 0 then
		goutil.setActive(txtName.gameObject, false)
		goutil.setActive(leftTime, true)

		txtLeftTime.text = GameUtil.FormatTimeSymbol(supTime, true)

		return true
	else
		txtLeftTime.text = ""

		goutil.setActive(txtName.gameObject, true)
		goutil.setActive(leftTime, false)

		return false
	end
end

function MainActivityView:_onClickFunc(funcId)
	if ViewMgr.instance:isOpen(ViewName.OtherCardView) or ViewMgr.instance:isOpen(ViewName.MyCardView) then
		return
	end

	if RoleController.instance:getIsReqingRoleInfo() then
		return
	end

	local ids = self:_isMainExpandFatBtn(funcId)

	if ids and #ids > 0 then
		local obj = self._funcBtns[funcId]

		if obj == nil or obj.parentGo == nil then
			printError("sr---主界面的展开区功能  MainActivityView:_onClickFunc()   @sunran  funcId = ", funcId)

			return
		end

		local pos = GameUtil.getPos(obj.parentGo)

		if self:openMainBtnExpandView(pos, funcId, ids) and obj.expandGo then
			Framework.TransformUtil.SetLocalRotation(obj.expandGo.transform, 0, 0, -90)
		end

		return
	end

	local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

	FuncOpenController.instance:reportClickBehavior(funcId)
	FuncOpenController.instance:onClickFunc(cfg)
end

function MainActivityView:openMainBtnExpandView(pos, funcId, ids)
	if pos == nil then
		return
	end

	local params = {
		localPos = pos,
		fatFuncId = checknumber(funcId),
		sonFuncIds = ids
	}

	self:showTabAt(self.mainGO, ViewName.MainBtnExpandView, params)

	return true
end

function MainActivityView:_onGetFuncBtnReq(funcId)
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)
	local go
	local funcBtn = self._funcBtns[funcId]

	if funcBtn == nil then
		funcBtn = self._funcBtns[cfg.bindFuncId]
	end

	if funcBtn then
		go = funcBtn.go
	end

	local pos = Vector3.New(0, 0, 0)

	GlobalDispatcher:dispatch(GlobalNotify.GetFuncBtnPosRes, (go ~= nil or nil) and go.transform.position, self)
end

function MainActivityView:updateTimer()
	self:_updateFuncText()

	if self.timeIdx % 3 == 0 then
		self:_updateRedpointRealtime()
		self:_updateDoubleSign()
	end

	if self.timeIdx % 10 == 0 then
		FuncOpenModel.instance:_checkFuncOpen()
	end

	self.timeIdx = self.timeIdx + 1
end

function MainActivityView:onUpdateMainUIFuncs()
	self:_updateUI()
	MainUIController.instance:setBtnsList(self._funcBtns)
end

function MainActivityView:_updateUI()
	self:_updateFuncsOpen()
end

function MainActivityView:_updateRedpointRealtime()
	for _, funcId in ipairs(needTimerFuncID) do
		self:_updateSingleRedpoint(funcId, nil)
	end
end

function MainActivityView:_updateLocalRedPoints()
	local funcId = 9

	if self._funcBtns[funcId] == nil or self._funcBtns[funcId].redPoint == nil then
		return
	end

	GameUtil.SetActive(self._funcBtns[funcId].redPoint, (self:_isNeedCheckRedOfTheFunc(funcId) and BagPetsController.instance:getReady() or nil) and BagModel.instance:getPetBagRedStatus())
end

function MainActivityView:_onClickTopArrow(isForce)
	if not isForce then
		self._activityStatus = (self._activityStatus + 1) % 2
	end

	local isHideTopRight = self._activityStatus ~= 0

	self._moveNode:SetActive(not isHideTopRight)
	self._customOpens:SetActive(not isHideTopRight)
	Framework.TransformUtil.SetLocalRotation(self._btnTopArrow.transform, 0, 0, isHideTopRight and 0 or 180)
end

function MainActivityView:_onClickBomArrow(isForce)
	if not isForce then
		self._bomRightStatus = (self._bomRightStatus + 1) % 2
	end

	local isHideBomRight = self._bomRightStatus ~= 0

	self._funcParents[GameEnum.MainUIFuncArea.BomRight_Horizontal].gameObject:SetActive(not isHideBomRight)
	self._funcParents[GameEnum.MainUIFuncArea.BomRight_Vertical].gameObject:SetActive(not isHideBomRight)
	self._bottomCenterGo.gameObject:SetActive(not isHideBomRight)
	Framework.TransformUtil.SetLocalRotation(self._btnBomArrow.transform, 0, 0, isHideBomRight and 0 or 180)
	GlobalDispatcher:dispatch(GlobalNotify.SpreadButton, self._bomRightStatus ~= 0)
	GlobalDispatcher:dispatch(GlobalNotify.UpdateMainViewSwitchBtnState, self._bomRightStatus == 0)
end

function MainActivityView:_checkFuncNeedOpen()
	if not FuncOpenModel.instance:isDataInited() or not MainUIFacade.instance:getNeedCheckFunc() then
		return
	end

	self:_updateFuncsOpen()
	self:_playFuncFlyAnim()
end

function MainActivityView:_playFuncFlyAnim()
	local funcId = FuncOpenModel.instance:getNeedShowFuncId()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(funcId)

	if funcId then
		if self._isFuncFlyAnimMask then
			FuncOpenModel.instance:dequeueNeedShowFunc()
		elseif cfg.tipsType == 1 then
			if not ViewMgr.instance:isOpen(ViewName.FuncOpen) then
				UIStateManager.instance:open(ViewName.FuncOpen, self._funcBtns)
			end
		elseif cfg.tipsType == 3 then
			FuncOpenModel.instance:dequeueNeedShowFunc()
			FuncOpenController.instance:reportClickBehavior(funcId)
			FuncOpenController.instance:onClickFunc(cfg)
		end
	else
		self:_openAchievementTips()
	end
end

function MainActivityView:_onFuncOpenFinished(funcId)
	self:_updateFuncsOpen()
	self:_openAchievementTips()

	if funcId == 35 then
		FuncOpenController.instance:openFunc(funcId)
	end
end

function MainActivityView:_onTaskUpdate()
	self:_updateRedpoint()
end

function MainActivityView:_openAchievementTips()
	if AchievementModel.instance:getIsNeedShowTips() then
		UIStateManager.instance:open(ViewName.AchievementTips)
	end
end

function MainActivityView:isBtnSwitchOpen()
	return self._bomRightStatus == 0
end

function MainActivityView:_setElementSparkDynamicName(go, isHideName)
	if isHideName then
		return
	end

	local name = ElementSparkController.instance:getTopName()
	local txtName = goutil.findChildTextComponent(go, "TxtC_Name")

	if not string.nilorempty(name) then
		txtName.text = name
	else
		local nameBg = goutil.findChild(go, "nameBg")

		goutil.setActive(nameBg, false)
		goutil.setActive(txtName.gameObject, false)
	end
end

function MainActivityView:_setYearCardDynamicName(go, isHideName)
	local name = YearCardController.instance:getTopName()

	if not string.nilorempty(name) then
		local txtName = goutil.findChildTextComponent(go, "name/TxtC_Name")

		txtName.text = name
	end

	local over = YearCardController.instance:isOverLastYearCard()

	if over then
		local change = go:GetComponent(ComponentType.UIImageSpriteChange)

		if change then
			change:SetState(1)
		end
	end
end

function MainActivityView:_startFuncFlyAnimMask(time)
	self._isFuncFlyAnimMask = true

	settimer(time, self._endFuncFlyAnimMask, self, false)
end

function MainActivityView:_endFuncFlyAnimMask()
	self._isFuncFlyAnimMask = false

	removetimer(self._endFuncFlyAnimMask, self)
end

return MainActivityView
