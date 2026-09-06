-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collectclothes/view/CollectClothesMainView.lua

module("logic.extensions.collectclothes.view.CollectClothesMainView", package.seeall)

local CollectClothesMainView = class("CollectClothesMainView", TableViewComponent)

function CollectClothesMainView:_getPath()
	return {
		cellPath = "prizeCol/prizeScrollCell",
		viewPath = "prizeCol/prizeScrollView"
	}
end

function CollectClothesMainView:ctor()
	CollectClothesMainView.super.ctor(self)
end

function CollectClothesMainView:unbindEvents()
	CollectClothesMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnRide)
	self._drag:RemoveDragListener()
	self._btnRLeft:RemoveClickListener()
	self._btnRRight:RemoveClickListener()
end

function CollectClothesMainView:bindEvents()
	CollectClothesMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnRide, self._onClickRide, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._btnRLeft:AddClickListener(function()
		self:_onClickBtnR(true)
	end, self)
	self._btnRRight:AddClickListener(function()
		self:_onClickBtnR(false)
	end, self)
end

function CollectClothesMainView:buildUI()
	CollectClothesMainView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txtTime")
	self._goRole = self:getGo("modsFrame")
	self._rolePoint = goutil.findChild(self._goRole, "con")
	self._modelBG = goutil.findChild(self._goRole, "bg")

	goutil.setActive(self._modelBG, false)

	self._photoEff = AvatarPhotoShow.Get(self._rolePoint)

	self._photoEff:setRawWidthAndHeight(1280, 720)
	self._photoEff:setCameraPosition(1.25, 1.31, -6)
	self._photoEff:setCamSize(1.6)
	self._photoEff:setRTAdjust(1, 1, 1, 0.007)

	self._btnRide = self:getBtn("btnRide")
	self._txtRide = self:getTxt("btnRide/txtRide")
	self._drag = Framework.UIDragTrigger.Get(self:getGo("middle/drag"))
	self._btnRRight = self:getBtn("middle/btnRRight")
	self._btnRLeft = self:getBtn("middle/btnRLeft")
end

function CollectClothesMainView:onExit()
	CollectClothesMainView.super.onExit(self)

	self._bShowing = false

	CollectClothesController.instance:unregisterLocalNotify(CollectClothesController.E_InfoRes, self.updateView, self)
	CollectClothesController.instance:unregisterLocalNotify(CollectClothesController.E_GainPrizeRes, self.updateView, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateDressInfo, self.updateView, self)

	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)
		self._avatar:removeListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)

		self._avatar = nil
	end

	self._photoEff:clear()

	self._avatarMo = nil
	self._activityId = nil
end

function CollectClothesMainView:onEnter()
	CollectClothesMainView.super.onEnter(self)

	self._bShowing = true

	CollectClothesController.instance:registerLocalNotify(CollectClothesController.E_InfoRes, self.updateView, self)
	CollectClothesController.instance:registerLocalNotify(CollectClothesController.E_GainPrizeRes, self.updateView, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateDressInfo, self.updateView, self)

	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.COLLECT_CLOTHES_ACTIVITY)

	if cfg then
		self._activityId = cfg.activityId
	end

	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.COLLECT_CLOTHES_ACTIVITY, self._activityId)

	if not activityConf or not GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))
		self:close()

		return
	end

	local collectclothesActivityConf = CollectClothesConfig.instance:getActConf(self._activityId)

	self._bLoadingMount = false
	self._bMount = true
	self._array = CollectClothesConfig.instance:getCollectionConfigs(collectclothesActivityConf.collectPlanId)
	self._prizeConf = CollectClothesConfig.instance:getPrizeConfig(collectclothesActivityConf.prizePlanId)

	if DressModel.instance:getIsInitData() then
		self:updateView()
	else
		DressController.instance:sendGetNotoutInfoReq(self.updateView, self)
	end

	CollectClothesAgent.instance:sendPM_CollectClothesInfoReq(self._activityId)
	MountController.instance:getMountInfo(function()
		CollectClothesModel.instance.bLoadMountData = true

		if self._bShowing then
			self:updateView()
		end
	end)
	self:_initActivityTimeText()
	self:_initAvatar()
end

function CollectClothesMainView:updateView()
	if DressModel.instance:getIsInitData() and CollectClothesModel.instance.bInitData and CollectClothesModel.instance.bLoadMountData then
		self:_updateData()
	end
end

function CollectClothesMainView:_initActivityTimeText()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.COLLECT_CLOTHES_ACTIVITY, self._activityId)
	local startDate = GameUtil.time2date(startTime)
	local endDate = GameUtil.time2date(endTime)

	self._txtTime.text = string.format("活动时间：%02d.%02d 5:00-%02d.%02d 5:00", startDate.month, startDate.day, endDate.month, endDate.day)
end

function CollectClothesMainView:_initAvatar()
	self._avatarMo = nil
	self._mountId = nil

	local clothesArray = {}
	local gender = RoleModel.instance:getGender()

	for _, conf in ipairs(self._array) do
		if conf.type == 1 then
			for _, clothId in ipairs(conf.collections) do
				local dressCfg = DressConfig.instance:getDressCfgById(clothId)

				if dressCfg.clothesGender == GameEnum.Gender.Neutral or dressCfg.clothesGender == gender then
					table.insert(clothesArray, clothId)
				end
			end
		elseif conf.type == 2 then
			self._mountId = conf.collections[1]
		end
	end

	local matType, id, _ = MaterialMgr.getMatParams(self._prizeConf.prize)

	self._bgId = -1

	if matType == MatType.Cloth then
		self._bgId = id
	end

	if self._bgId > 0 then
		table.insert(clothesArray, self._bgId)
	end

	local mountId = 0

	if self._bMount then
		mountId = self._mountId
	end

	self._bLoadingMount = true
	self._avatarMo = DressModel.instance:getAvatarMoByGrCosAndMount(gender, clothesArray, mountId)
	self._avatar = AvatarsMgrNew.instance:getAvatarByMo(self._avatarMo)

	self._avatar:addListener(AvatarNotify.OnAvatarLoaded, self._onAvatarLoaded, self)
	self._photoEff:addShowAvatarEffect(self._avatar)
end

function CollectClothesMainView:_setMount(bMount)
	if not bMount then
		self._avatarMo.mount = nil
	else
		self._avatarMo.mount = self._mountId
	end

	self._avatarMo.isMount = bMount
	self._bLoadingMount = true

	self._avatar:updateByMo(self._avatarMo)
end

function CollectClothesMainView:_updateRideBtnState()
	self._txtRide.text = self._bMount and lang("取消骑乘") or lang("骑 乘")
end

function CollectClothesMainView:_onAvatarLoaded(avatar)
	if self._avatar == avatar then
		self._bMount = self._avatar.mountCtrl:getCurIsMount()

		self:_updateRideBtnState()

		self._bLoadingMount = false
	end
end

local DT_Prize = 1
local DT_Require = 2

function CollectClothesMainView:_updateData()
	local arrayResult = {}

	table.insert(arrayResult, {
		dataType = DT_Prize,
		data = self._prizeConf
	})

	for i, v in ipairs(self._array) do
		table.insert(arrayResult, {
			dataType = DT_Require,
			data = v
		})
	end

	self:updateListData(arrayResult)
end

function CollectClothesMainView:_updateCell(view, cell, data)
	local dataType = data.dataType
	local conf = data.data
	local model = CollectClothesModel.instance
	local icon = goutil.findChild(cell, "icon")
	local txtTitle = goutil.findChildTextComponent(cell, "txtTitle")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local prog = goutil.findChild(cell, "prog")
	local txtProg = goutil.findChildTextComponent(cell, "prog/txtProg")
	local btnGet = goutil.findChild(cell, "btns/btnGet")
	local btnGoto = goutil.findChild(cell, "btns/btnGoto")
	local receivedGo = goutil.findChild(cell, "btns/receivedGo")
	local txtReceive = goutil.findChildTextComponent(cell, "btns/receivedGo/text")
	local periodType = GameUtil.getTimePeriodType(conf.startTime, conf.endTime)

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(GameUtil.asBtn(btnGet))
	GameUtil.rmClickHandler(GameUtil.asBtn(btnGoto))
	GameUtil.SetActive(prog, dataType == DT_Prize)

	txtTitle.text = conf.title
	txtDesc.text = conf.desc

	uGuiUtil.setSpriteToImage(icon, uGuiUtil.SpriteType.BigBg, self:_getIconPath(conf.icon))

	if dataType == DT_Prize then
		local progress = model:getTotalProgress(self._array)
		local bHasGainPrize = model:isGainPrize(conf.prizeId)

		txtProg.text = langPara("收集进度：%d/%d", progress, conf.num)

		GameUtil.SetActive(btnGet, not bHasGainPrize)
		GameUtil.SetGray(btnGet, progress < conf.num)
		GameUtil.SetActive(btnGoto, false)
		GameUtil.SetGray(btnGoto, false)
		GameUtil.SetActive(receivedGo, bHasGainPrize)

		if bHasGainPrize then
			txtReceive.text = lang("已领取")
		end

		GameUtil.addClickHandler(GameUtil.asBtn(btnGet), function()
			if progress >= conf.num then
				CollectClothesAgent.instance:sendPM_CollectClothesGainPrizeReq(self._activityId, conf.prizeId)
			end
		end)
	else
		local bHasCollect = model:isHasCollectGroup(conf)

		GameUtil.SetActive(btnGet, false)
		GameUtil.SetActive(btnGoto, not bHasCollect)
		GameUtil.SetActive(receivedGo, bHasCollect)

		if bHasCollect then
			txtReceive.text = lang("已获得")

			GameUtil.SetGray(btnGoto, false)
		else
			GameUtil.SetGray(btnGoto, periodType == GameUtil.beforeTimePeriod or periodType == GameUtil.afterTimePeriod)
		end

		GameUtil.addClickHandler(GameUtil.asBtn(btnGoto), function()
			if periodType ~= GameUtil.beforeTimePeriod and periodType ~= GameUtil.afterTimePeriod then
				GotoMgr.gotoByString(conf.jumpTo)
			end
		end)
	end

	GameUtil.addClickHandler(icon, function()
		if not string.nilorempty(conf.prize) then
			CommonTipsMgr.instance:openTipsByConfStr(icon, conf.prize)
		end
	end)
end

function CollectClothesMainView:_getIconPath(simplePath)
	return string.format("ui/icon/%s.png", simplePath)
end

function CollectClothesMainView:_clearTableview(cell)
	local icon = goutil.findChild(cell, "icon")
	local btnGet = goutil.findChild(cell, "btns/btnGet")
	local btnGoto = goutil.findChild(cell, "btns/btnGoto")

	uGuiUtil.clearImage(icon)
	GameUtil.rmClickHandler(GameUtil.asBtn(btnGet))
	GameUtil.rmClickHandler(GameUtil.asBtn(btnGoto))
	GameUtil.rmClickHandler(icon)
end

function CollectClothesMainView:_onClickRide()
	if not self._bLoadingMount then
		self:_setMount(not self._bMount)
	end
end

function CollectClothesMainView:_onDrag(eventData)
	self:_setAvatarRotation(eventData.delta.x)
end

function CollectClothesMainView:_onClickBtnR(isLeft)
	self:_setAvatarRotation(isLeft and -12 or 12)
end

function CollectClothesMainView:_setAvatarRotation(delta)
	local localRotation = self._photoEff:getTargetContainerLocalRotation()

	if localRotation then
		local localRotationT = Quaternion.Euler(0, -0.5 * delta * 1, 0) * localRotation
		local eulerAngles = localRotationT.eulerAngles

		self._photoEff:setTargetContainerLocalRotation(0, eulerAngles.y, 0)
	end
end

return CollectClothesMainView
