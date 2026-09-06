-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powercrystal/view/PowerCrystalView.lua

module("logic.extensions.powercrystal.view.PowerCrystalView", package.seeall)

local PowerCrystalView = class("PowerCrystalView", TableViewComponent)
local rolePosList = {
	Vector2.New(274, 138.5),
	Vector2.New(45, -45.5),
	Vector2.New(506, -45.5),
	Vector2.New(115, -250),
	(Vector2.New(435.5, -250))
}

function PowerCrystalView:ctor()
	PowerCrystalView.super.ctor(self)

	self.model = PowerCrystalModel.instance
	self.roleObj = {}
	self.roleItemList = {}
end

function PowerCrystalView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function PowerCrystalView:destroyUI()
	PowerCrystalView.super.destroyUI(self)
end

function PowerCrystalView:onExitFinished()
	PowerCrystalView.super.onExitFinished(self)
end

function PowerCrystalView:onEnterFinished()
	PowerCrystalView.super.onEnterFinished(self)
end

function PowerCrystalView:unbindEvents()
	PowerCrystalView.super.unbindEvents(self)
end

function PowerCrystalView:bindEvents()
	PowerCrystalView.super.bindEvents(self)
end

function PowerCrystalView:onExit()
	PowerCrystalView.super.onExit(self)

	local viewMgr = ViewMgr.instance

	if viewMgr:isOpen(ViewName.MainTopGoldView) then
		viewMgr:close(ViewName.MainTopGoldView)
	end

	removetimer(self.resetEffect, self)
	self:clearStaticEffect()
	self:resetEffect()

	for _, v in pairs(self.roleObj) do
		RoleObjectPool.instance:removeRole(v)
	end

	self.roleObj = {}

	BubbleController.instance:CloseView(ViewName.bubble)
	self._closeButton:RemoveClickListener()
	self._goBtnTips:RemoveClickListener()
	self.unregisterNotify(self, GlobalNotify.OnMaterialCountChange, self._refreshPetView, self)
	PowerCrystalController.instance:unregisterLocalNotify(PowerCrystalModel.RefreshMainView, self._refreshView, self)
	PowerCrystalController.instance:unregisterLocalNotify(PowerCrystalModel.PlayMoveEffect, self._playMoveEffect, self)
	GlobalDispatcher:removeListener(GlobalNotify.PetBattleChange, self._refreshPetView, self)
	self._posAction:RemoveListener()
	PowerCrystalModel.instance:checkRedDot()
end

function PowerCrystalView:buildUI()
	PowerCrystalView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
	self._goBtnTips = self:getBtn("btnTips")
	self._roleItemCell = self:getGo("itemCon/roleItem")
	self._item_parent = self:getGo("itemCon").transform
	self._goldBarCon = self:getGo("goldBarCon")
	self._effect = self:getGo("point_line").transform
	self._rectTransform = self.mainGO:GetComponent("RectTransform")

	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	self._ori_effect_pos = goutil.screenToLocalPos(uiCamera:WorldToScreenPoint(GameUtil.getPos(self._effect)), self._rectTransform)
	self._posAction = self._effect:GetComponent("TweenPosition")
	self._posAction.time = 0.01
	self._posAction.from = self._ori_effect_pos
	self._txtTipNum = goutil.findChildTextComponent(self.mainGO, "txtTipNum")
	self._point_star = self:getGo("point_star").transform
	self._point_star_daiji = self:getGo("point_star_daiji").transform
	self._txtTips.text = "最低级的力量勇士决定槽位中精灵的等级"

	self:_initRoleItem()
end

function PowerCrystalView:onEnter()
	PowerCrystalView.super.onEnter(self)

	local btn_list = {
		{
			showAdd = false,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.PowerStone
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btn_list)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._goBtnTips:AddClickListener(self._onClickTips, self)
	self.registerNotify(self, GlobalNotify.OnMaterialCountChange, self._refreshPetView, self)
	PowerCrystalController.instance:registerLocalNotify(PowerCrystalModel.PlayMoveEffect, self._playMoveEffect, self)
	PowerCrystalController.instance:registerLocalNotify(PowerCrystalModel.RefreshMainView, self._refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PetBattleChange, self._refreshPetView, self)
	self._posAction:AddListener(self._onFlyFinishCallBack, self)
	self:_refreshView()
	printError("有人打开了力量水晶界面")
end

function PowerCrystalView:_onClickClose()
	self:close()
end

function PowerCrystalView:_onClickTips()
	ViewMgr.instance:open(ViewName.RulesView, "powercrystal")
end

function PowerCrystalView:_initRoleItem()
	GameUtil.SetActive(self._roleItemCell, true)

	for i = 1, 5 do
		local go = goutil.cloneAndSetParent(self._roleItemCell, self._item_parent)

		self.roleItemList[i] = GameUtil.AddLuaOnce(go, PowerCrystalRoleItem)
	end

	GameUtil.SetActive(self._roleItemCell, false)
end

function PowerCrystalView:_setshowRoleData()
	local list = self.model:getLeaderpetids()
	local new_list = {}

	for _, petId in ipairs(list) do
		local info = BagPetsFacade.instance:getPetInfo(petId)

		if info then
			table.insert(new_list, info)
		end
	end

	for i = 1, 5 do
		local item = self.roleItemList[i]

		item:setPosition(rolePosList[i].x, rolePosList[i].y)
		item:setData(new_list[i], i)
	end
end

function PowerCrystalView:_refreshPetView()
	self._curViewDatas = self.model:getSlotInfos()
	self._txtTipNum.text = "已共鸣精灵数量：" .. self.model:FormatUpPetStr()

	self._tableview:ReloadData()
end

function PowerCrystalView:_numInView()
	return PowerCrystalConfig.instance:getSlotMaxNum()
end

function PowerCrystalView:_updateCell(view, cell, data)
	local item = GameUtil.AddLuaOnce(cell, PowerCrystalPetItem)

	item:setMo(data, cell.data)
end

function PowerCrystalView:_refreshView()
	self:_refreshPetView()
	self:_setshowRoleData()
end

function PowerCrystalView:_playMoveEffect(endPos, slotId)
	self:resetEffect()

	self._openSlotId = slotId

	local function doLineMove()
		local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

		endPos = uiCamera:WorldToScreenPoint(endPos)
		endPos = goutil.screenToLocalPos(endPos, self._rectTransform)
		endPos.x = endPos.x + 50
		endPos.y = endPos.y - 50
		self.isDirty = true
		self._posAction.to = endPos

		self._posAction:Begin()
		settimer(1, self.resetEffect, self)
	end

	local function xianLoadFinish()
		if self._eff then
			self._eff:setParent(self._effect)
			self._eff:setLocalPos(0, 0, 0)
			self._eff:setScale(1)

			local trailRenderer = self._eff.effGo:GetComponentInChildren(typeof(UnityEngine.TrailRenderer))

			if trailRenderer then
				trailRenderer:Clear()
			end

			local order = UGUIToolHelper.GetNodeCanvansSortingOrder(self._effect.gameObject)

			self._eff:setSortingOrder(order + 1)
			doLineMove()
		end
	end

	local function baoLoadFinish()
		if self._eff2 then
			self._eff2:setParent(self._point_star)
			self._eff2:setLocalPos(0, 0, 0)
			self._eff2:setScale(1)
		end
	end

	local function baoFinishCallBack()
		self._eff = UIEffectManager.instance:playEffect(self, "fx_ui_liliangshuijing/fx_ui_lilianghshuijing_xian.prefab", self._effect, 0, 0, false, nil, nil, xianLoadFinish)
	end

	self._eff2 = UIEffectManager.instance:playEffect(self, "fx_ui_liliangshuijing/fx_ui_lilianghshuijing_bao.prefab", self._point_star, 0, 0, false, nil, baoFinishCallBack, baoLoadFinish)
end

function PowerCrystalView:_onFlyFinishCallBack()
	if not self.isDirty then
		return
	end

	self.isDirty = false

	self:firePlaySlotEffec()
end

function PowerCrystalView:playStaticEffect()
	self:clearStaticEffect()

	local function loadFinish()
		if self.effect_static then
			self.effect_static:setParent(self._point_star_daiji)
			self.effect_static:setLocalPos()
			self.effect_static:setScale(1)
		end
	end

	self.effect_static = UIEffectManager.instance:playEffect(self, "fx_ui_liliangshuijing/fx_ui_liliangshuijing_daiji.prefab", self._point_star_daiji, 0, 0, true, nil, nil, loadFinish)
end

function PowerCrystalView:clearStaticEffect()
	if self.effect_static then
		UIEffectManager.instance:stopEffect(self.effect1)

		self.effect_static = nil
	end
end

function PowerCrystalView:firePlaySlotEffec()
	GlobalDispatcher:dispatch(GlobalNotify.PetBattleChange)
	PowerCrystalController.instance:localNotify(PowerCrystalModel.PlaySlotEffect, self._openSlotId)
end

function PowerCrystalView:resetEffect()
	removetimer(self.resetEffect, self)
	GameUtil.setLocalPos(self._effect, self._posAction.from.x, self._posAction.from.y, self._posAction.from.z)

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	if self._eff2 then
		UIEffectManager.instance:stopEffect(self._eff2)

		self._eff2 = nil
	end
end

return PowerCrystalView
