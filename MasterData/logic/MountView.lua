-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mount/view/MountView.lua

module("logic.extensions.mount.view.MountView", package.seeall)

local MountView = class("MountView", ViewComponent)
local MAX_POTENTIAL_STATE = 3
local MAX_LIGHT_NUM = 5
local TAB_ALL = 1
local TAB_ATTR = 2
local TAB_NOT_ATTR = 3

function MountView:ctor()
	MountView.super.ctor(self)
end

local RideName = {
	"取消骑乘",
	"骑乘",
	"解锁",
	"前往"
}
local RideIcon = {
	"com_icon_zuoqi",
	"com_icon_zuoqi",
	"com_icon_76",
	"com_icon_75"
}
local MountItemId = {
	levelup = 901,
	breach = 902
}

function MountView:buildUI()
	MountView.super.buildUI(self)

	self.btnClose = self:getGo("topleft/btnClose")
	self.btnRide = self:getBtn("btnRide")
	self.txt_name = goutil.findChildTextComponent(self.mainGO, "name/txtName")
	self._rideIcon = self:getGo("btnRide/icon"):GetComponent(ComponentType.UIImageSpriteChange)
	self.goCultivateOnce = self:getGo("btnCultivateOnce")
	self.goCultivateTimes = self:getGo("btnCultivateTimes")
	self.goBreach = self:getGo("btnBreach")
	self.goMountShow = self:getGo("avatarRoot")
	self.btnCultivateOnce = self:getBtn("btnCultivateOnce")
	self.btnCultivateTimes = self:getBtn("btnCultivateTimes")
	self.btnBreach = self:getBtn("btnBreach")
	self.btnTips = self:getBtn("tipBtn")
	self.btnMarkUp = self:getBtn("btnMarkUp")
	self.btnGoFight = self:getBtn("btnGoFight")
	self.btnInvite = self:getBtn("btnInvite")
	self.goFightRedPoint = self:getGo("btnGoFight/imgRed")
	self.txtOnce = goutil.findChildTextComponent(self.mainGO, "btnCultivateOnce/txtVal")
	self.txtTimes = goutil.findChildTextComponent(self.mainGO, "btnCultivateTimes/txtVal")
	self.txtRide = goutil.findChildTextComponent(self.mainGO, "btnRide/txtRide")
	self.txtCultivateTimes = goutil.findChildTextComponent(self.mainGO, "btnCultivateTimes/txtCultivate")
	self.txtBreach = goutil.findChildTextComponent(self.mainGO, "btnBreach/txtVal")
	self.txtBottom = self:getTxt("txtBottom")
	self.txtGoFight = self:getTxt("txtGoFight")
	self.goFightValue = self:getGo("goFightValue/imgNum"):GetComponent(typeof(UIImgNumeralText))
	self.curRideState = 1

	local scrollerGo = self:getGo("ScrollView")
	local cellGo = self:getGo("tabStar")

	self._tableview = ScrollerList.create(scrollerGo, cellGo, GameUtil.handler(self._updateCell, self))
	self._sliders = {}

	for i = 1, 4 do
		local attr = {}

		attr.go = goutil.findChild(self.mainGO, "attribute/attr" .. i)
		attr._sliderVal = goutil.findChildComponent(attr.go, "bloodbar", "Slider")
		attr._txtVal = goutil.findChildTextComponent(attr.go, "txtVal")
		attr._txtName = goutil.findChildTextComponent(attr.go, "txtName")
		attr._txtBarrage = goutil.findChildTextComponent(attr.go, "txtBarrage")
		attr._goBarrage = goutil.findChild(attr.go, "txtBarrage")
		attr._icon = GameUtil.getUIImageSpriteChange(goutil.findChild(attr.go, "icon"))

		table.insert(self._sliders, attr)
	end

	self._tabSelect = {}

	table.insert(self._tabSelect, self:getGo("btns/btnAll"))
	table.insert(self._tabSelect, self:getGo("btns/btnAttr"))
	table.insert(self._tabSelect, self:getGo("btns/btnNoAttr"))

	self._currSelectTab = TAB_ALL
	self._potentials = {}

	for i = 1, 5 do
		local potential = {}

		potential.ball = goutil.findChildComponent(self.mainGO, "potency/ball" .. i, "UIImageSpriteChange")
		potential.line = goutil.findChildComponent(self.mainGO, "potency/line" .. i, "UIImageSpriteChange")

		table.insert(self._potentials, potential)
	end

	self.txtNumLevelupItem = goutil.findChildTextComponent(self.mainGO, "levelupItem/txtNum")
	self.btnLevelupItemAdd = self:getBtn("levelupItem/btnAdd")
	self.txtNumBreachItem = goutil.findChildTextComponent(self.mainGO, "breachItem/txtNum")
	self.btnBreachItemAdd = self:getBtn("breachItem/btnAdd")
	self._Btn_Left = self:getGo("btn_Left")
	self._Btn_Right = self:getGo("btn_Right")
	self._leftLp = self._Btn_Left:GetComponent("UILongPressed")
	self._rightLp = self._Btn_Right:GetComponent("UILongPressed")
	self._drag = Framework.UIDragTrigger.Get(self:getGo("Drag"))
	self.tweeners = {}
	self.rpGoUnlock = self:getGo("btnRide/imgRed")
	self.rpGoCulOnce = self:getGo("btnCultivateOnce/imgRed")
	self.rpGoCulTimes = self:getGo("btnCultivateTimes/imgRed")
	self.rpGoCulBreach = self:getGo("btnBreach/imgRed")

	self:_buildBkgview()

	self._txtSpeed = self:getTxt("txtSpeed")
	self._tipsTeamMount = self:getGo("tipsTeamMount")
end

function MountView:_buildBkgview()
	local prefab = self._viewPresentor:getPrefab(MountPresentor.MountViewBkgView)

	self._bkgViewGo = goutil.clone(prefab)
	self._avatarRoot = goutil.findChild(self._bkgViewGo, "avatarRoot/avatar")
end

function MountView:bindEvents()
	MountView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnTips, self.onClickTips, self)
	GameUtil.addClickHandler(self.btnClose, self._close, self)
	GameUtil.addClickHandler(self.btnRide, self.onClickRide, self)
	GameUtil.addClickHandler(self.btnCultivateOnce, self.onClickLevelUpOnce, self)
	GameUtil.addClickHandler(self.btnCultivateTimes, self.onClickLevelUpTen, self)
	GameUtil.addClickHandler(self.btnBreach, self.onClickBreach, self)
	GameUtil.addClickHandler(self.btnInvite, self.onClickInvite, self)
	GameUtil.addClickHandler(self.btnMarkUp, self.onClickMarkUp, self)
	GameUtil.addClickHandler(self.btnGoFight, self.onClickGoFight, self)
	GameUtil.addClickHandler(self.btnLevelupItemAdd, self.onClickLevelupItem, self)
	GameUtil.addClickHandler(self.btnBreachItemAdd, self.onClickBreachItem, self)
	GameUtil.addClickHandler(self._Btn_Left, GameUtil.handler(self.onRoleTrun, self, -2))
	GameUtil.addClickHandler(self._Btn_Right, GameUtil.handler(self.onRoleTrun, self, 2))
	self._rightLp:AddToggledListener(function(tar, isUp)
		self:onRoleTrun(2)
	end, self)
	self._leftLp:AddToggledListener(function(tar, isUp)
		self:onRoleTrun(-2)
	end, self)
	self._drag:AddDragListener(self._onDrag, self)

	for i, v in ipairs(self._tabSelect) do
		GameUtil.addClickHandler(v, GameUtil.handler(self._onClickTab, self, i))
	end
end

function MountView:unbindEvents()
	MountView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnTips)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnRide)
	GameUtil.rmClickHandler(self.btnCultivateOnce)
	GameUtil.rmClickHandler(self.btnCultivateTimes)
	GameUtil.rmClickHandler(self.btnBreach)
	GameUtil.rmClickHandler(self.btnMarkUp)
	GameUtil.rmClickHandler(self.btnGoFight)
	GameUtil.rmClickHandler(self.btnLevelupItemAdd)
	GameUtil.rmClickHandler(self.btnBreachItemAdd)
	GameUtil.rmClickHandler(self._Btn_Left)
	GameUtil.rmClickHandler(self._rightLp)
	GameUtil.rmClickHandler(self._leftLp)
	GameUtil.rmClickHandler(self.btnInvite)
	self._drag:RemoveDragListener()

	for i, v in ipairs(self._tabSelect) do
		GameUtil.rmClickHandler(v)
	end
end

function MountView:_close()
	self._viewPresentor._openParam = nil

	MountView.super.close(self)
end

function MountView:destroyUI()
	if self._bkgViewGo then
		goutil.destroy(self._bkgViewGo)

		self._bkgViewGo = nil
	end

	MountView.super.destroyUI(self)
end

function MountView:onEnter()
	MountView.super.onEnter(self)
	self._bkgViewGo:SetActive(true)
	GlobalModel.instance:visibleSceneHUDs(false)
	SceneMainPlayer.instance:forceSyncMountState()

	local openPara = self:getOpenParam()

	self._openMountId = openPara and openPara[1] or nil
	self.selectMountId = MountModel.instance:getSelectMountId()

	GlobalDispatcher:addListener(GlobalNotify.MountInfo, self.refreshAll, self)
	GlobalDispatcher:addListener(GlobalNotify.MountAttributeShow, self.showBarrage, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateDressInfoDaily, self._updateDressInfoDaily, self)
	GlobalDispatcher:addListener(GlobalNotify.OnMaterialItemChange, self._updateMaterial, self)
	GlobalDispatcher:addListener(GlobalNotify.MountAttrActive, self._refreshFightInfo, self)
	self:_onClickTab(TAB_ATTR)

	if checknumber(self._openMountId) > 0 then
		self.selectMountId = self._openMountId
	elseif MountController.instance:getIfLock(self._mountCfgs[1].id) then
		self.selectMountId = self._mountCfgs[1].id
	end

	MountModel.instance:setSelectMountId(self.selectMountId)

	for i = 1, 4 do
		GameUtil.SetActive(self._sliders[i]._goBarrage, false)
	end

	Framework.TransformUtil.SetLocalRotation(self._avatarRoot.transform, 0, 0, 0)

	self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

	self._avatar:setParent(self._avatarRoot.transform)
	self._avatar:setLayer(SceneLayer.UI3D_Value)
	self._avatar:setOwnerUserId(RoleModel.instance:getUserId())
	self._avatar:addListener(AvatarNotify.OnMountLoaded, self._onMountLoaded, self)

	self.avatarMo = DressModel.instance:getAvatarMoByOrigin(SceneMainPlayer.instance.userVar)
	self.avatarMo.mount = self.selectMountId
	self.avatarMo.isMount = true

	self._avatar:updateByMo(self.avatarMo)
	self:refreshRideState()
	self:refreshRide()
	MountController.instance:getMountInfo(function(msg)
		MountModel.instance:initMountInfo(msg)
		self:refreshAll()
	end)
	RedPointController.instance:regRedPoint(self.goFightRedPoint, RedPointModel.ID_MOUNT_ARRAY)
end

function MountView:_onClickTab(index)
	self._currSelectTab = index

	for i, v in ipairs(self._tabSelect) do
		local go = goutil.findChild(v, "bg")

		if i == index then
			GameUtil.setUIImageSpriteIdx(go, 1)
		else
			GameUtil.setUIImageSpriteIdx(go, 0)
		end
	end

	self:refreshTabs()
	self._tableview:MoveCellInView(0, false)
end

function MountView:refreshTabs()
	if self._mountAllCfgs == nil then
		self._mountAllCfgs = MountController.instance:getAllMounts()
	end

	local curId = checknumber(MountModel.instance:getCurMountId())

	self._mountCfgs = {}

	for k, v in pairs(self._mountAllCfgs) do
		if self._currSelectTab == TAB_ALL then
			table.insert(self._mountCfgs, v)
		elseif self._currSelectTab == TAB_ATTR then
			if not string.nilorempty(v.sqContent) then
				table.insert(self._mountCfgs, v)
			end
		elseif self._currSelectTab == TAB_NOT_ATTR and string.nilorempty(v.sqContent) then
			table.insert(self._mountCfgs, v)
		end
	end

	table.sort(self._mountCfgs, function(a, b)
		local alock = MountController.instance:getIfLock(a.id)
		local block = MountController.instance:getIfLock(b.id)
		local aAssist = MountModel.instance:getIsActive(a.id)
		local bAssist = MountModel.instance:getIsActive(b.id)
		local aCanUnlock = MountController.instance:getIfCanUnlock(a.id)
		local bCanUnlock = MountController.instance:getIfCanUnlock(b.id)

		if aCanUnlock ~= bCanUnlock then
			return aCanUnlock
		end

		if curId == a.id then
			return true
		end

		if curId == b.id then
			return false
		end

		if aAssist ~= bAssist then
			return aAssist
		elseif alock ~= block then
			return alock
		else
			return a.id < b.id
		end
	end)
	self._tableview:reloadData(self._mountCfgs)
end

function MountView:onEnterFinished()
	MountView.super.onEnterFinished(self)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
end

function MountView:onExit()
	self._avatar:removeListener(AvatarNotify.OnMountLoaded, self._onMountLoaded, self)
	MountView.super.onExit(self)

	for k, tween in pairs(self.tweeners) do
		if tween then
			tween:Kill(false)

			tween = nil
		end
	end

	AvatarsMgrNew.instance:removeAvatar(self._avatar)

	self._avatar = nil
	self.avatarMo = nil

	self._tableview:dispose()
	LightMgr.instance:setLightForNormalScene()
	table.clear(self._mountCfgs)
end

function MountView:onExitFinished()
	self._bkgViewGo:SetActive(false)
	GlobalModel.instance:visibleSceneHUDs(true)
	MountView.super.onExitFinished(self)
	GlobalDispatcher:removeListener(GlobalNotify.MountInfo, self.refreshAll, self)
	GlobalDispatcher:removeListener(GlobalNotify.MountAttributeShow, self.showBarrage, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateDressInfoDaily, self._updateDressInfoDaily, self)
	GlobalDispatcher:removeListener(GlobalNotify.OnMaterialItemChange, self._updateMaterial, self)
	GlobalDispatcher:removeListener(GlobalNotify.MountAttrActive, self._refreshFightInfo, self)
end

function MountView:_updateCell(view, cell, data)
	local unlock = MountController.instance:getIfLock(data.id)
	local txtStarName = goutil.findChildTextComponent(cell, "txtStarName")
	local select = goutil.findChild(cell, "select")
	local lock = goutil.findChild(cell, "lock")
	local tabImg = cell.gameObject:GetComponent("UIImageSpriteChange")
	local redPoint = goutil.findChild(cell, "imgRed")
	local tag = goutil.findChild(cell, "tag")
	local txtTag = goutil.findChildTextComponent(cell, "tag/txt")
	local imgQuality = goutil.findChild(cell, "quality"):GetComponent("UIImageSpriteChange")
	local assist = goutil.findChild(cell, "assist")
	local tagteam = goutil.findChild(cell, "tagteam")

	imgQuality:SetState(data.quality)
	tabImg:SetState(data.id - 1)

	txtStarName.text = data.name

	GameUtil.SetActive(tag, false)

	if not string.nilorempty(data.sqContent) then
		GameUtil.SetActive(tag, true)

		txtTag.text = data.sqContent
	end

	GameUtil.SetActive(lock, not unlock)
	GameUtil.SetActive(select, data.id == self.selectMountId)
	GameUtil.rmClickHandler(cell)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onClickTab, self, data, cell.data))

	local retUnlock, retCultivate, retBreach = MountController.instance:checkMountRedpoint(data.id)

	GameUtil.SetActive(redPoint, retUnlock or retCultivate or retBreach)
	GameUtil.SetActive(assist, MountModel.instance:getIsActive(data.id))
	GameUtil.SetActive(tagteam, data.isTeamMount)
end

function MountView:refreshAll()
	self:refreshTabs()

	self.txt_name.text = MountModel.instance:getName(self.selectMountId)

	self:refreshRideState()
	self:refreshAttr()
	self:refreshRide()
	self._tableview:refresh()
	self:refreshRedPoint()
	self:_updateSpeed()

	self.txtNumLevelupItem.text = MaterialModel.instance:getMaterialsNumber(MatType.Item, MountItemId.levelup)
	self.txtNumBreachItem.text = MaterialModel.instance:getMaterialsNumber(MatType.Item, MountItemId.breach)

	self:_refreshFightInfo()
end

function MountView:_updateTransform()
	local mountCo = MountConfig.instance:getMountCo(self.selectMountId)

	if mountCo then
		local x, y, z = 0, 0, 0
		local scale = 1

		if mountCo.position then
			x = mountCo.position[1] or 0
			y = mountCo.position[2] or 0
			z = mountCo.position[3] or 0
		end

		scale = mountCo.scale

		if mountCo.scale == 0 then
			scale = 1
		end

		Framework.TransformUtil.SetLocalPos(self._avatarRoot.transform, x, y, z)
		Framework.TransformUtil.SetLocalScale(self._avatarRoot.transform, scale, scale, scale)
	end
end

function MountView:_updateSpeed()
	local mountCo = MountConfig.instance:getMountCo(self.selectMountId)

	self._txtSpeed.text = "移动速度+" .. math.floor(((mountCo.speed or nil) and mountCo.speed) * 100) .. "%"
end

function MountView:refreshAttr()
	local curAtt = MountModel.instance:getCurAtt(self.selectMountId)
	local lockMo = MountModel.instance:getLockmountsById(self.selectMountId)
	local level = lockMo and checknumber(lockMo.level) or 0
	local mountCo = MountConfig.instance:getMountCo(self.selectMountId)

	if checknumber(mountCo.levelUpPlan) > 0 then
		if lockMo then
			local attMaxList = MountModel.instance:getAttMax(self.selectMountId, level)

			for i, attr in ipairs(self._sliders) do
				print(i, v)

				local type = attMaxList[i].type
				local curVal = curAtt[i].value
				local maxVal = checknumber(attMaxList[i].value)

				attr._sliderVal.value = checknumber(curVal / maxVal)
				attr._txtVal.text = tostring(curVal) .. "/" .. tostring(maxVal)
				attr._txtName.text = ConstString.Attr[type]

				attr._icon:SetState(checknumber(type) - 1)
			end
		else
			local attMaxList = MountModel.instance:getAttMax(self.selectMountId, 1)

			for i = 1, 4 do
				local type = attMaxList[i].type
				local maxVal = checknumber(attMaxList[i].value)

				self._sliders[i]._sliderVal.value = 0
				self._sliders[i]._txtVal.text = "0/0"
				self._sliders[i]._txtName.text = ConstString.Attr[type]

				self._sliders[i]._icon:SetState(checknumber(type) - 1)
			end
		end

		local IfReachAttLimit = MountController.instance:getIfReachAttLimit(self.selectMountId)

		GameUtil.SetActive(self.goCultivateOnce, not IfReachAttLimit and (self.curRideState == 1 or self.curRideState == 2))
		GameUtil.SetActive(self.goCultivateTimes, not IfReachAttLimit and (self.curRideState == 1 or self.curRideState == 2))
		GameUtil.SetActive(self.goBreach, IfReachAttLimit and level ~= MountModel.instance:getMaxLevel(self.selectMountId))

		if self.curRideState == 3 or self.curRideState == 4 then
			self.txtBottom.text = "坐骑未解锁"

			GameUtil.SetActive(self.txtBottom.gameObject, true)
		elseif IfReachAttLimit and level == MountModel.instance:getMaxLevel(self.selectMountId) then
			self.txtBottom.text = "已达到上限"

			GameUtil.SetActive(self.txtBottom.gameObject, true)
		else
			GameUtil.SetActive(self.txtBottom.gameObject, false)
		end

		if not IfReachAttLimit and lockMo then
			local canNum = MountController.instance:canCultivateTime(self.selectMountId)

			if canNum == 0 or canNum > 10 then
				canNum = 10
			end

			local hasNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, MountItemId.levelup)
			local consume = MountModel.instance:getlevelUpConsume(self.selectMountId, level)
			local arr = string.split(consume, ":")
			local useNum = checknumber(arr[3])

			self.txtOnce.text = hasNum .. "/" .. useNum
		elseif IfReachAttLimit and lockMo then
			local hasNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, MountItemId.breach)
			local consume = MountModel.instance:getBreachConsume(self.selectMountId, level)

			if consume then
				local arr = string.split(consume, ":")
				local useNum = checknumber(arr[3])

				self.txtBreach.text = hasNum .. "/" .. useNum
			end
		end
	else
		for i, attr in ipairs(self._sliders) do
			attr._sliderVal.value = 0
			attr._txtVal.text = "0/0"
		end

		GameUtil.SetActive(self.goCultivateOnce, false)
		GameUtil.SetActive(self.goCultivateTimes, false)
		GameUtil.SetActive(self.goBreach, false)
		GameUtil.SetActive(self.goNotUnlock, false)
		GameUtil.SetActive(self.txtBottom.gameObject, true)

		self.txtBottom.text = "该坐骑没有属性加成"
	end

	for i = 1, 5 do
		local state = self:getPotentialState(i, level)

		self._potentials[i].ball:SetState(state)

		if self._potentials[i].line then
			self._potentials[i].line:SetState(state)
		end
	end
end

function MountView:getPotentialState(index, level)
	local res = 0

	for i = MAX_POTENTIAL_STATE, 0, -1 do
		if level >= index + i * MAX_LIGHT_NUM then
			res = i + 1

			break
		end
	end

	return res
end

function MountView:onClickTab(data, index)
	self.selectMountId = data.id

	MountModel.instance:setSelectMountId(self.selectMountId)
	self:refreshAll()
	self._tableview:MoveCellInView(index - 1)
end

function MountView:refreshRide()
	self.avatarMo.mount = self.selectMountId

	local playerGo = self._avatar:getGameObject()

	if playerGo then
		self._avatar:updateByMo(self.avatarMo)

		if self.curRideState == 2 then
			goutil.setActive(playerGo, false)
		else
			goutil.setActive(playerGo, true)
			self._avatar.mountCtrl:updateMountingLayer()
		end
	end
end

function MountView:refreshRideState()
	local unlock = MountController.instance:getIfLock(self.selectMountId)
	local curMountId = MountModel.instance:getCurMountId()

	self.curRideState = unlock and (curMountId == self.selectMountId and 1 or 2) or MountController.instance:getIfCanUnlock(self.selectMountId) and 3 or 4
	self.txtRide.text = RideName[self.curRideState]

	self._rideIcon:ChangeSprite(RideIcon[self.curRideState])

	local mountCo = MountConfig.instance:getMountCo(self.selectMountId)

	goutil.setActive(self.btnInvite.gameObject, false)

	if mountCo and mountCo.isTeamMount and self.curRideState == 1 then
		goutil.setActive(self.btnInvite.gameObject, true)
	end

	goutil.setActive(self._tipsTeamMount, mountCo and mountCo.isTeamMount)
end

function MountView:showBarrage(property)
	local curAttrList = MountModel.instance:getCurAtt(self.selectMountId)

	if curAttrList then
		for i = 1, #curAttrList do
			for k, v in pairs(property) do
				if curAttrList[i].type == v.propertyType then
					GameUtil.SetActive(self._sliders[i]._goBarrage, true)

					if self.tweeners[i] then
						self.tweeners[i]:Kill(false)

						self.tweeners[i] = nil
					end

					self.tweeners[i] = TweenUtil.ValueTo(1, 0, 2, function(val)
						self._sliders[i]._txtBarrage.text = "+" .. v.propertyValue
					end, function()
						self.tweeners[i] = nil

						GameUtil.SetActive(self._sliders[i]._goBarrage, false)
					end, self)
				end
			end
		end
	end
end

function MountView:onClickRide()
	if self.curRideState == 1 then
		if MountModel.instance:isTeamMountFull() then
			local friendName = MountModel.instance:getTeamMountMateName()
			local tipTxts = string.format("您当前与%s骑乘双人坐骑，是否离开当前队伍且取消骑乘当前坐骑？", friendName)

			local function okFunc()
				if MountModel.instance:isTeamMountMember() then
					MountController.instance:sendMountLeaveTeamReq()
				end

				MountController.instance:mountChange(0)
				FloatWordMgr.instance:show("已取消当前骑乘")
			end

			TipsFacade.instance:openPopupWindow(lang("tip"), tipTxts, okFunc)
		else
			MountController.instance:mountChange(0)
			FloatWordMgr.instance:show("已取消当前骑乘")
		end
	elseif self.curRideState == 2 then
		if MountModel.instance:isTeamMountFull() then
			local friendName = MountModel.instance:getTeamMountMateName()
			local tipTxts = string.format("您当前与%s骑乘双人坐骑，是否离开当前队伍且乘坐新坐骑？", friendName)

			local function okFunc()
				if MountModel.instance:isTeamMountMember() then
					MountController.instance:sendMountLeaveTeamReq()
				end

				MountController.instance:mountChange(self.selectMountId)
				FloatWordMgr.instance:show("已成功骑乘")
			end

			TipsFacade.instance:openPopupWindow(lang("tip"), tipTxts, okFunc)
		else
			MountController.instance:mountChange(self.selectMountId)
			FloatWordMgr.instance:show("已成功骑乘")
		end
	elseif self.curRideState == 3 then
		MountController.instance:mountUnlock(self.selectMountId, function()
			return
		end)
	elseif self.curRideState == 4 then
		local consume = MountModel.instance:getActivationItem(self.selectMountId)
		local hasJump = false

		if not string.nilorempty(consume) then
			local arr = string.split(consume, ":")
			local cfg = MaterialMgr.getMatCfg(checknumber(arr[1]), checknumber(arr[2]))

			if cfg and not string.nilorempty(cfg.source) then
				MaterialMgr.openGetSourceByStr(consume)

				hasJump = true
			end
		end

		if not hasJump then
			FloatWordMgr.instance:show(self._mountAllCfgs[self.selectMountId].accessTip)
		end
	end

	self:refreshRideState()
	self:refreshRide()
end

function MountView:onClickLevelUpOnce()
	MountController.instance:levelup(self.selectMountId, 1)
end

function MountView:onClickLevelUpTen()
	local realTimes = MountController.instance:canCultivateTime(self.selectMountId)

	if realTimes == 0 then
		local mo = MountModel.instance:getLockmountsById(self.selectMountId)

		if mo then
			local consume = MountModel.instance:getlevelUpConsume(self.selectMountId, mo.level)

			MountController.instance:collectItem(consume)
		end
	else
		UIStateManager.instance:push(ViewName.MountCultivateView, self.selectMountId, self._mountCfgs)
	end
end

function MountView:onClickBreach()
	MountController.instance:breach(self.selectMountId)
end

function MountView:onClickMarkUp()
	local mountCo = MountConfig.instance:getMountCo(self.selectMountId)

	if checknumber(mountCo.levelUpPlan) > 0 then
		MountController.instance:openMarkUp(self.selectMountId)
	else
		FloatWordMgr.instance:show("当前坐骑没有突破加成")
	end
end

function MountView:onClickGoFight()
	UIStateManager.instance:push(ViewName.MountChooseView)
end

function MountView:onClickLevelupItem()
	local item = MatType.Item .. ":" .. MountItemId.levelup

	MountController.instance:collectItem(item)
end

function MountView:onClickBreachItem()
	local item = MatType.Item .. ":" .. MountItemId.breach

	MountController.instance:collectItem(item)
end

function MountView:onClickTips()
	local ruleCo = RulesConfig.instance:getRuleCo("mountrule")
	local title = tostring((not ruleCo.title or nil) and 0)

	if not title or title == "0" or #title == 0 then
		title = lang("tip")
	end

	TipsFacade.instance:openTipWindowNoX(title, ruleCo.rules)
end

function MountView:_onDrag(eventData)
	self:onRoleTrun(eventData.delta.x)
end

function MountView:onRoleTrun(deltaX)
	local localRotation = Quaternion.Euler(0, -0.5 * deltaX * 1, 0) * self._avatarRoot.transform.localRotation
	local eulerAngles = localRotation.eulerAngles

	Framework.TransformUtil.SetLocalRotation(self._avatarRoot.transform, 0, eulerAngles.y, 0)
end

function MountView:refreshRedPoint(...)
	local ifLock = MountController.instance:getIfLock(self.selectMountId)
	local retUnlock = false
	local retCultivate = false
	local retBreach = false

	if ifLock then
		local IfReachAttLimit = MountController.instance:getIfReachAttLimit(self.selectMountId)
		local lockMo = MountModel.instance:getLockmountsById(self.selectMountId)

		if lockMo then
			if not lockMo.level then
				local level = 0

				if IfReachAttLimit then
					if level ~= MountModel.instance:getMaxLevel(self.selectMountId) then
						local hasNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, MountItemId.breach)
						local consume = MountModel.instance:getBreachConsume(self.selectMountId, level)

						if consume then
							local arr = string.split(consume, ":")
							local useNum = checknumber(arr[3])

							if useNum <= hasNum then
								retBreach = true
							end
						end
					end
				else
					local hasNum = MaterialModel.instance:getMaterialsNumber(MatType.Item, MountItemId.levelup)
					local consume = MountModel.instance:getlevelUpConsume(self.selectMountId, level)
					local arr = string.split(consume, ":")
					local use_num = checknumber(arr[3])

					if use_num <= hasNum then
						retCultivate = true
					end
				end
			end
		end
	else
		retUnlock = MountController.instance:getIfCanUnlock(self.selectMountId)
	end

	goutil.setActive(self.rpGoUnlock, retUnlock)
	goutil.setActive(self.rpGoCulOnce, retCultivate)
	goutil.setActive(self.rpGoCulTimes, retCultivate)
	goutil.setActive(self.rpGoCulBreach, retBreach)
end

function MountView:_onMountLoaded()
	self:_updateTransform()

	local playerGo = self._avatar:getGameObject()

	if playerGo then
		goutil.setActive(playerGo, self.curRideState ~= 2)
	end
end

function MountView:_updateDressInfoDaily()
	self.avatarMo = DressModel.instance:getAvatarMoByOrigin(SceneMainPlayer.instance.userVar)
	self.avatarMo.mount = self.selectMountId
	self.avatarMo.isMount = true

	self._avatar:updateByMo(self.avatarMo)
	self:refreshRideState()
	self:refreshRide()
end

function MountView:_updateMaterial(mo)
	if mo then
		local matId = mo.id

		if MountController.instance:checkMatId(matId) then
			self._tableview:refresh()
			self:refreshRedPoint()
			self:refreshRideState()
		end
	end
end

function MountView:_refreshFightInfo()
	local zdl = MountModel.instance:getMountZDL()
	local activeNum = MountModel.instance:getActiveMountNum()

	self.goFightValue:SetNum(zdl)

	self.txtGoFight.text = string.format("<color=#20b376>%s</color>/%s", activeNum, MountConfig.instance:getMountLimitNum())
end

function MountView:_getAttrMountNum()
	if self._mountNum == nil then
		local allList = MountController.instance:getAllMounts()

		self._mountNum = 0

		for k, v in pairs(allList) do
			if not string.nilorempty(v.sqContent) then
				self._mountNum = self._mountNum + 1
			end
		end
	end

	return self._mountNum
end

function MountView:onClickInvite()
	if MountModel.instance:isTeamMountFull() then
		FloatWordMgr.instance:show("坐骑已满员，无法邀请")

		return
	end

	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("当前正在护送")

		return
	end

	UIStateManager.instance:push(ViewName.TeamMountInviteView)
end

return MountView
