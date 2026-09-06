-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aocore/QiCoreView.lua

module("logic.extensions.aocore.QiCoreView", package.seeall)

local QiCoreView = class("QiCoreView", ViewComponent)
local resPath = "effect/prefabs/story/story_mofang/fx_mofang_story_03.prefab"

function QiCoreView:ctor()
	QiCoreView.super.ctor(self)
end

function QiCoreView:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	GameUtil.addClickHandler(self._btnJump, self._onClickJump, self)
end

function QiCoreView:unbindEvents()
	self._closeButton:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnJump)
end

function QiCoreView:buildUI()
	QiCoreView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._modelCam = goutil.findChild(self.mainGO, "modelCam")
	self._container = goutil.findChild(self._modelCam, "uiroot/container")
	self._ovalmove = self._container:GetComponent("UIOvalMove")
	self._rawImage = goutil.findChildComponent(self.mainGO, "rawImage", typeof(UnityEngine.UI.RawImage))
	self._rectTrans = self._rawImage:GetComponent(typeof(UnityEngine.RectTransform))
	self._btnJump = self:getGo("btnJump")
end

function QiCoreView:destroyUI()
	return
end

function QiCoreView:onEnter()
	QiCoreView.super.onEnter(self)

	self._cellClickCallBackMap = {}

	self._modelCam.transform:SetParent(nil)

	local petMo = BagModel.instance:getFirstPet()

	self._maxZdl = RoleModel.instance:getMaxPower()
	self.curPetMo = petMo
	self.maxPetMo = FightingPowerFormula.instance:getRealMaxFightingPowerPetMo(petMo.raceId)
	self._curViewDatas = AocoreConfig.instance:getQiCoreCfgList()

	print("active = " .. tostring(self._ovalmove.gameObject.activeInHierarchy))

	self._ovalmove._r = 210
	self._ovalmove._R = 545
	self._ovalmove._angleOffset = 7

	self._ovalmove:CreateObjs(#self._curViewDatas)
	self._ovalmove:RefreshAll(self._updateCell, self)
	self._ovalmove:CenterOn(0)
	GlobalDispatcher:addListener("guide_core_at", self.onPauseAt, self)
	goutil.setActive(self._rawImage.gameObject, false)
	getres(resPath, self._onResLoaded, self)

	if EscortModel.instance:IsPickupEscort() then
		local joystickView = VirtualJoystickModel.instance:getJoystickView()

		if joystickView then
			joystickView:setEnable(false)
		end
	end

	GlobalDispatcher:addListener(GlobalNotify.OnViewOpen, self.checkUp, self)
	GlobalDispatcher:addListener(GlobalNotify.OnViewClose, self.checkUp, self)
	self:_showPower()
end

function QiCoreView:_showPower(res)
	local zdl = 0
	local maxZdl = 0

	for i, cfg in ipairs(self._curViewDatas) do
		local jumpId = cfg.powerId
		local cfg = HandbookConfig.instance:getPowerCheckDetailCfg(jumpId)

		if cfg then
			local attrMo = self.curPetMo.attrMo
			local attr = attrMo[cfg.value]
			local maxMo = self.maxPetMo.attrMo
			local attr2 = maxMo[cfg.value]

			if cfg.value == "assistAttr" then
				zdl = Mathf.Ceil(PetAssistModel.instance:GetTotalPowerCount() / 5)

				local count = #PetAssistConfig.instance:getPetTeamCfgs()

				maxZdl = Mathf.Ceil(AttrMo.calcFightPowerByAttrs(attr2))
			else
				zdl = AttrMo.calcFightPowerByAttrs(attr)
				maxZdl = AttrMo.calcFightPowerByAttrs(attr2)
			end

			local sliderValue = Mathf.Ceil(math.min(1, zdl / math.max(maxZdl, 1)) * 1000) / 1000
		else
			local allPet, curValue = PetbookModel.instance:getFilterPetList()
			local maxValue = #allPet

			maxValue = maxValue > 0 and maxValue or 1

			local sliderValue = Mathf.Ceil(math.min(1, curValue / maxValue) * 1000) / 1000
		end
	end
end

function QiCoreView:_onResLoaded(res)
	if res and res.IsSuccess then
		res:Retain()
		print("resLoaded")

		local go = goutil.create("mofang_container", false)

		self._res = res
		self._go = go

		local mofang = goutil.cloneAndSetParent(res:GetMainAsset(), go.transform)

		Framework.TransformUtil.SetPos(go.transform, 2000, 0, 0)
		Framework.TransformUtil.SetLocalScale(mofang.transform, 1, 1, 1)
	end
end

function QiCoreView:onPauseAt(param)
	print(">>>>>>>>>>>>>>>>>>>>>>>>       QiCoreView:onEnterFinished()     ", param)
	self._ovalmove:CenterOn(checknumber(param) - 1)
	self._ovalmove:IsPause(true)
end

function QiCoreView:onEnterFinished()
	GlobalModel.instance:visibleSceneHUDs(false)
end

function QiCoreView:onExit()
	QiCoreView.super.onExit(self)
	GlobalModel.instance:visibleSceneHUDs(true)

	self._curViewDatas = nil

	GlobalDispatcher:removeListener("guide_core_at", self.onPauseAt, self)
	removeresl(resPath, self._onResLoaded, self)

	if self._res then
		self._res:Release()
	end

	self._res = nil

	if not goutil.isNil(self._go) then
		goutil.destroy(self._go)
	end

	self._go = nil

	self._modelCam.transform:SetParent(self.mainGO.transform)
	self._ovalmove:RefreshAll(self._clearCell, self)

	self._cellClickCallBackMap = nil
end

function QiCoreView:_onDivineEvolveInfoGet()
	local isRed = self:_isShowBirthdayTag(375)

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_AOCORE_DIVINE, isRed)
end

function QiCoreView:_clearCell(cell, idx)
	cell = goutil.findChild(cell, "container")

	local redPoint = goutil.findChild(cell, "imgPoint")

	RedPointController.instance:unregRedPoint(redPoint)
end

function QiCoreView:checkUp()
	return
end

function QiCoreView:getGuideGo()
	return self._modelCam
end

function QiCoreView:onExitFinished()
	return
end

function QiCoreView:_updateCell(parent, idx)
	local data = self._curViewDatas[idx + 1]

	parent.transform.name = "aohe_" .. idx + 1

	local cell = goutil.findChild(parent, "container")
	local _imgIcon = goutil.findChildComponent(cell, "imgIcon", "UIImageSpriteChange")
	local _goLock = goutil.findChild(cell, "lock")
	local _txtLock = goutil.findChildComponent(cell, "lock/txtLock", "Text")
	local _redpoint = goutil.findChild(cell, "imgPoint")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local nameBg = goutil.findChild(cell, "nameBg")
	local birthdayTag = goutil.findChild(cell, "birthdayTag")
	local _funcId = data.funcId
	local isLock = not FuncOpenModel.instance:getFuncIsOpen(_funcId)

	goutil.setActive(_goLock, isLock)

	local _cfg = FuncOpenConfig.instance:getFunctionOpenById(_funcId)
	local func = self._cellClickCallBackMap[data.id]

	if func == nil then
		func = GameUtil.handler(self._onClickCell, self, _cfg, data)
		self._cellClickCallBackMap[data.id] = func
	end

	GameUtil.addClickHandler(cell, func)
	_imgIcon:ChangeSprite(data.icon)

	if _cfg ~= nil then
		_txtLock.text = not string.nilorempty(_cfg.lockedTips) and _cfg.lockedTips or FuncOpenController.instance:getConditionLockTips(_cfg.openCondition)

		local repointId = data.redpointID

		if not isLock and repointId then
			if type(repointId) == "table" then
				RedPointController.instance:regRedPoint(_redpoint, unpack(repointId))
			else
				RedPointController.instance:regRedPoint(_redpoint, repointId)
			end
		else
			goutil.setActive(_redpoint, false)
		end

		goutil.setActive(nameBg, true)
	else
		goutil.setActive(_goLock, false)
		goutil.setActive(_redpoint, false)
		goutil.setActive(nameBg, false)
	end

	local zdl, maxZdl, sliderValue = 0, 0, 0
	local jumpId = data.powerId
	local detailCfg = HandbookConfig.instance:getPowerCheckDetailCfg(jumpId)

	if detailCfg then
		local attrMo = self.curPetMo.attrMo
		local attr = attrMo[detailCfg.value]
		local maxMo = self.maxPetMo.attrMo
		local attr2 = maxMo[detailCfg.value]

		if detailCfg.value == "assistAttr" then
			zdl = Mathf.Ceil(PetAssistModel.instance:GetTotalPowerCount() / 5)

			local count = #PetAssistConfig.instance:getPetTeamCfgs()

			maxZdl = Mathf.Ceil(AttrMo.calcFightPowerByAttrs(attr2))
		else
			zdl = AttrMo.calcFightPowerByAttrs(attr)
			maxZdl = AttrMo.calcFightPowerByAttrs(attr2)
		end

		sliderValue = Mathf.Ceil(math.min(1, zdl / math.max(maxZdl, 1)) * 1000) / 1000
	else
		local allPet, curValue = PetbookModel.instance:getFilterPetList()
		local maxValue = #allPet

		maxValue = maxValue > 0 and maxValue or 1
		sliderValue = Mathf.Ceil(math.min(1, curValue / maxValue) * 1000) / 1000
	end

	txtName.text = data.name .. " <color=#20b376>" .. sliderValue * 100 .. "%</color>"

	goutil.setActive(nameBg, not string.nilorempty(txtName.text))

	if data.funcId == 375 then
		RedPointController.instance:regRedPoint(birthdayTag, RedPointModel.ID_AOCORE_DIVINE)
	end
end

function QiCoreView:_isShowBirthdayTag(funcId)
	if funcId == 375 then
		local divineList = DivineEvolveController.instance:getDivineMainList()

		if #divineList == 0 then
			return false
		else
			for i, v in ipairs(divineList) do
				if v.raceId == 14000 or v.raceId == 10145 then
					local cfg = EvolveConfig.instance:getDivineEvolveCfg(checknumber(v.raceId))

					if cfg then
						local isChanllenge = DivineEvolveModel.instance:isFinishEvolveCondition(cfg.newRaceId)

						if not isChanllenge then
							return true
						end
					end
				end
			end
		end
	end

	return false
end

function QiCoreView:_onClickCell(cfg, data)
	print("click cell")

	if cfg then
		FuncOpenController.instance:onClickFunc(cfg)
		SurveyController.instance:reportBehavior(200482, data.id)
	else
		FloatWordMgr.instance:show(ConstString.NotRelease)
	end
end

function QiCoreView:_onClickClose()
	self:close()
end

function QiCoreView:_onClickJump()
	UIStateManager.instance:push(ViewName.StrongerTabMainView, 4, 1)
end

return QiCoreView
