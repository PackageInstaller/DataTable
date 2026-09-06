-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/DressactivityshopView.lua

module("logic.extensions.dressactivityshop.view.DressactivityshopView", package.seeall)

local DressactivityshopView = class("DressactivityshopView", ViewComponent)
local json = require("cjson")

function DressactivityshopView:ctor()
	DressactivityshopView.super.ctor(self)
end

function DressactivityshopView:buildUI()
	DressactivityshopView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnHelp = self:getBtn("btnHelp")
	self._modelCam = self:getGo("modelCam")
	self._rolePoint = self:getGo("modelCam/rolePoint")

	if not self._avatar then
		self._avatar = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Player)

		self._avatar:setParent(self._rolePoint.transform)
		self._avatar:setLayer(SceneLayer.UI3D_Value)
		self._avatar:addListener(AvatarNotify.OnAvatarLoaded, self._OnAvatarLoaded, self)
	end

	self._drag = Framework.UIDragTrigger.Get(self:getGo("middle/drag"))
	self._btnSit = self:getBtn("AniPreShow/btnSit")
	self._btnDance = self:getBtn("AniPreShow/btnDance")
	self._btnSalute = self:getBtn("AniPreShow/btnSalute")
	self._btnGreet = self:getBtn("AniPreShow/btnGreet")
	self._singles = {}
	self._suitItems = {}
	self._hasBuyState = {}

	for i = 1, 4 do
		local go = self:getGo("single/item" .. i)
		local cell = {}

		cell.go = go
		cell.btn = GameUtil.asBtn(goutil.findChild(go, "btn"))
		cell.txt = goutil.findChildTextComponent(go, "btn/Text")
		cell.mark = goutil.findChild(go, "mark")
		cell.icon = goutil.findChild(go, "icon")
		cell.cfg = nil
		self._singles[i] = cell
		self._hasBuyState[i] = false
		self._singles[i] = cell
		cell = {}
		go = self:getGo("suit/item" .. i)
		cell.go = go
		cell.mark = goutil.findChild(go, "mark")
		cell.cell = goutil.findChild(go, "cell")
		self._suitItems[i] = cell
	end

	self._btnBuy = self:getBtn("suit/btnBuy")
	self._txtBuySuit = self:getTxt("suit/btnBuy/Text")
	self._txtDiscount = self:getTxt("suit/txtDiscount/txt")
	self._goDiscount = self:getGo("suit/txtDiscount")
	self._changeGroup = self:getGo("slogan/img"):GetComponent("UIChangeGroup")
	self._btnRRight = self:getBtn("middle/btnRRight")
	self._btnRLeft = self:getBtn("middle/btnRLeft")
end

function DressactivityshopView:bindEvents()
	DressactivityshopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnHelp:AddClickListener(self._onClickBtnHelp, self)
	self._btnSit:AddClickListener(self._onClickBtnSit, self)
	self._btnDance:AddClickListener(self._onClickBtnDance, self)
	self._btnSalute:AddClickListener(self._onClickBtnSalute, self)
	self._btnGreet:AddClickListener(self._onClickBtnGreet, self)
	self._drag:AddDragListener(self._onDrag, self)

	for i = 1, 4 do
		self._singles[i].btn:AddClickListener(function()
			self:_onClickBtnBuySingle(i)
		end, self)
	end

	self._btnBuy:AddClickListener(self._onClickBtnBuySuit, self)
	self._btnRLeft:AddClickListener(function()
		self:_onClickBtnR(true)
	end, self)
	self._btnRRight:AddClickListener(function()
		self:_onClickBtnR(false)
	end, self)
end

function DressactivityshopView:unbindEvents()
	DressactivityshopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
	self._btnSit:RemoveClickListener()
	self._btnSalute:RemoveClickListener()
	self._btnGreet:RemoveClickListener()
	self._btnDance:RemoveClickListener()
	self._drag:RemoveDragListener()

	for i = 1, 4 do
		self._singles[i].btn:RemoveClickListener()
	end

	self._btnBuy:RemoveClickListener()
	self._btnRLeft:RemoveClickListener()
	self._btnRRight:RemoveClickListener()
end

function DressactivityshopView:destroyUI()
	DressactivityshopView.super.destroyUI(self)

	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)
		self._avatar:removeListener(AvatarNotify.OnAvatarLoaded, self._OnAvatarLoaded, self)

		self._avatar = nil
	end
end

function DressactivityshopView:onEnter()
	DressactivityshopView.super.onEnter(self)
	GlobalModel.instance:visibleSceneHUDs(false)
	LightMgr.instance:setLightParam(LightMgr.LightType.UILight)
	goutil.addChildToParent(self._modelCam)

	self._curActId = nil
	self._isOnEnterFinish = false

	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
	PayTrussAgent.instance:sendPM_PayTrussGetInfoReq(self._handleGetInfo, self)
	GlobalDispatcher:addListener(PayTrussAgent.PM_PayTrussNotifyPaySucRes, self.handlePaySucRes, self)
	self._changeGroup:SetState(RoleModel.instance:getGender())
end

function DressactivityshopView:onEnterFinished()
	DressactivityshopView.super.onEnterFinished(self)

	if self._avatar and self.avatarMo then
		self.avatarMo:setDefaultState()
		self._avatar:updateByMo(self.avatarMo)
	end

	self._isOnEnterFinish = true
end

function DressactivityshopView:onExit()
	DressactivityshopView.super.onExit(self)
	goutil.addChildToParent(self._modelCam, self.mainGO)
	GlobalModel.instance:visibleSceneHUDs(true)
	LightMgr.instance:setLightForNormalScene()
	ClockMgr.instance:removeListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
	GlobalDispatcher:removeListener(PayTrussAgent.PM_PayTrussNotifyPaySucRes, self.handlePaySucRes, self)

	for i = 1, 4 do
		MaterialMgr.resetAll(self._suitItems[i].cell)
	end
end

function DressactivityshopView:onExitFinished()
	DressactivityshopView.super.onExitFinished(self)
end

function DressactivityshopView:_onDrag(eventData)
	if self._avatar then
		self._avatarGo = self._avatarGo or self._avatar:getGameObject()
	end

	if self._avatarGo then
		local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * self._avatarGo.transform.localRotation
		local eulerAngles = localRotation.eulerAngles

		Framework.TransformUtil.SetLocalRotation(self._avatarGo.transform, 0, eulerAngles.y, 0)
	end
end

function DressactivityshopView:_onClickBtnHelp()
	ViewMgr.instance:open(ViewName.RulesView, "dressActivityShopView")
end

function DressactivityshopView:_onClickBtnDance()
	self:_resetAvatarAniState()
	self._avatar.animatorCtrl:setTrigger(AnimatorHash.animDance)
end

function DressactivityshopView:_onClickBtnSit()
	self:_resetAvatarAniState()
	self._avatar.animatorCtrl:setTrigger(AnimatorHash.animSit)
end

function DressactivityshopView:_onClickBtnSalute()
	self:_resetAvatarAniState()
	self._avatar.animatorCtrl:setTrigger(AnimatorHash.animSalute)
end

function DressactivityshopView:_onClickBtnGreet()
	self:_resetAvatarAniState()
	self._avatar.animatorCtrl:setTrigger(AnimatorHash.animGreet)
end

function DressactivityshopView:_OnAvatarLoaded()
	self._avatar.animatorCtrl:setBool(UnityEngine.Animator.StringToHash("ui"), false)
end

function DressactivityshopView:_onClickBtnR(isLeft)
	if self._avatar then
		self._avatarGo = self._avatarGo or self._avatar:getGameObject()
	end

	if self._avatarGo then
		local localRotation = self._avatarGo.transform.localRotation
		local addAngle = isLeft and 30 or -30
		local eulerAngles = localRotation.eulerAngles

		Framework.TransformUtil.SetLocalRotation(self._avatarGo.transform, 0, eulerAngles.y + addAngle, 0)
	end
end

function DressactivityshopView:_onClickBtnBuySingle(ID)
	if self._hasBuyState[ID] then
		FloatWordMgr.instance:show("已拥有该服装")

		return
	end

	local cfg = self._singles[ID].cfg

	if cfg then
		local para = {
			id = ID
		}

		json.encode(para)
		PayController.instance:pay(cfg.payGoodsId, GameEnum.PaySubGoodsType.DRESSACTIVITY, self._curActId, json.encode(para))
	end
end

function DressactivityshopView:_onClickBtnBuySuit()
	local cfg = self._curSuitCfg

	if cfg then
		local para = {
			id = -1
		}

		json.encode(para)
		PayController.instance:pay(cfg.payGoodsId, GameEnum.PaySubGoodsType.DRESSACTIVITY, self._curActId, json.encode(para))
	elseif self._hasAllOwn then
		FloatWordMgr.instance:show("已拥有所有售卖服装")
	else
		FloatWordMgr.instance:show("不满足购买套装要求")
	end
end

function DressactivityshopView:_resetAvatarAniState()
	self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animDance)
	self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animGreet)
	self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animSalute)
	self._avatar.animatorCtrl:resetTrigger(AnimatorHash.animSit)
	self._avatar.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.idle"))
end

function DressactivityshopView:_dailyReset()
	if self._curActId and not ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.DressActivityShop, self._curActId) then
		FloatWordMgr.instance:show("活动时间结束")
		self:close()

		return
	end
end

function DressactivityshopView:_handleGetInfo(msg)
	if self._curActId ~= checkint(msg.activityId) then
		self._curActId = checkint(msg.activityId)

		for _, id in ipairs(msg.hasPurchasedIds or {}) do
			self._hasBuyState[checkint(id)] = true
		end

		self:_updateViewByCfg()
	end

	self:_updateViewByState()
end

function DressactivityshopView:_updateViewByCfg()
	self.avatarMo = DressModel.instance:getAvatarMoByOrigin(SceneMainPlayer.instance.userVar)

	self.avatarMo:resetUIState()

	local cfgs = DressActivityShopConfig.instance:getSingleCfgByActId(self._curActId)

	for i = 1, 4 do
		local cfg = cfgs[i]

		self._singles[i].cfg = cfg

		if cfg then
			local conent = MaterialMgr.changeItemStrArr(cfg.giftContent)[1]

			if conent then
				MaterialMgr.resetAll(self._suitItems[i].cell)
				MaterialMgr.setCellByCfg(conent, self._suitItems[i].cell)

				local dressCfg = MaterialMgr.getMatCfgByStr(conent)

				self.avatarMo:setDataByCfgId(dressCfg.partId)
			end

			self._singles[i].txt.text = "￥ " .. PayConfig.instance:getPayMoneyYuan(cfg.payGoodsId)
		end
	end

	if self._isOnEnterFinish and self._avatar and self.avatarMo then
		self.avatarMo:setDefaultState()
		self._avatar:updateByMo(self.avatarMo)
	end
end

function DressactivityshopView:_updateViewByState()
	self._curSuitCfg = nil
	self._hasOwnIds = {}

	for i = 1, 4 do
		goutil.setActive(self._suitItems[i].mark, self._hasBuyState[i])
		goutil.setActive(self._singles[i].mark, self._hasBuyState[i])

		if self._hasBuyState[i] then
			table.insert(self._hasOwnIds, i)
		end
	end

	local cfg = DressActivityShopConfig.instance:getSuitCfgByActIdAndHasOwnTab(self._curActId, self._hasOwnIds)

	if cfg then
		self._curSuitCfg = cfg
		self._txtBuySuit.text = "￥ " .. PayConfig.instance:getPayMoneyYuan(cfg.payGoodsId)

		goutil.setActive(self._goDiscount, true)

		self._txtDiscount.text = "套装" .. cfg.showDiscount .. "折"
	else
		self._txtBuySuit.text = "<size=28>无法优惠购买</size>"

		goutil.setActive(self._goDiscount, false)
	end

	if #self._hasOwnIds == 4 then
		self._txtBuySuit.text = "已购买"
		self._hasAllOwn = true
	end
end

function DressactivityshopView:handlePaySucRes(status, msg)
	if status == 0 then
		local buyid = checkint(msg.buyId)

		if buyid == -1 then
			for i = 1, 4 do
				self._hasBuyState[i] = true
			end
		else
			self._hasBuyState[buyid] = true
		end

		self:_updateViewByState()
	end
end

return DressactivityshopView
