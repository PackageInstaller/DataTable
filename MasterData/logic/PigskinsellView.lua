-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/PigskinsellView.lua

module("logic.extensions.firstcharge.view.PigskinsellView", package.seeall)

local PigskinsellView = class("PigskinsellView", ViewComponent)

function PigskinsellView:buildUI()
	PigskinsellView.super.buildUI(self)

	self._rayTrigger = self:getGo("petCom/rayTrigger")
	self._drag = Framework.UIDragTrigger.Get(self._rayTrigger)
	self._btnBubble = GameUtil.asBtn(self._rayTrigger)
	self._bubblePos = self:getGo("petCom/pos")
	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnMore = self:getBtn("btnMore")
	self._items = {}

	for i = 1, 3 do
		local item = {}

		item.go = self:getGo("item" .. i)
		item.btn = GameUtil.asBtn(item.go)
		item.icon = goutil.findChild(item.go, "icon")
		item.matStr = nil
		item.txtNum = goutil.findChildTextComponent(item.go, "txtNum")
		self._items[i] = item
	end

	self._txtTime = self:getTxt("txtTime")
	self._txtPrize = self:getTxt("btnBuy/Text")
	self._photoEff = AvatarPhotoShow.Get(self:getGo("petCom"))
end

function PigskinsellView:bindEvents()
	PigskinsellView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
	self._btnBubble:AddClickListener(self._playBubble, self)
	self._btnMore:AddClickListener(self._onClickJump, self)

	for i = 1, 3 do
		self._items[i].btn:AddClickListener(function()
			self:_onClickItem(i)
		end, self)
	end

	self._drag:AddDragListener(self._onDrag, self)
end

function PigskinsellView:unbindEvents()
	PigskinsellView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnBubble:RemoveClickListener()
	self._btnMore:RemoveClickListener()

	for i = 1, 3 do
		self._items[i].btn:RemoveClickListener()
	end

	self._drag:RemoveDragListener()
end

function PigskinsellView:onEnter()
	PigskinsellView.super.onEnter(self)

	self._curPetCfg = PigraiseController.instance.curSellCfg

	if not self._curPetCfg then
		TipsFacade.instance:openCommonTips("当前活动已经结束")

		return self:close()
	end

	self._funcId = self._curPetCfg.funcId
	self._sellPetId = self._curPetCfg.petId
	self._avatarSktId = PigraiseConfig.instance:getPetCfgById(self._sellPetId).modelId

	if not self._curPetCfg.camPos then
		self._avatar = AvatarsMgrNew.instance:getAvatarAndMoByCfgId(self._avatarSktId)

		self._photoEff:setRawWidthAndHeight(512, 512)
		self._photoEff:setCameraPosition(checknumber(self._curPetCfg.camPos[1]), checknumber(self._curPetCfg.camPos[2]), checknumber(self._curPetCfg.camPos[3]))
		self._photoEff:setCamSize(self._curPetCfg.camSize or 0.56)

		self._goodsId = self._curPetCfg.goodsId
		self._goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._goodsId)

		GlobalDispatcher:addListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)

		local prizes = MaterialMgr.changeItemStrArr(self._goodsCfg.content)

		for i = 1, 3 do
			self._items[i].matStr = prizes[i]

			MaterialMgr.clearIcon(self._items[i].icon)
			MaterialMgr.updateItemByStr(self._items[i].icon, prizes[i])

			local matType, matId, matNum = MaterialMgr.getMatParams(prizes[i])

			self._items[i].txtNum.text = "x" .. matNum
		end

		local costMoney = PayConfig.instance:getPayMoneyYuan(self._goodsCfg.originalGoodsId)

		if costMoney ~= 0 then
			self._txtPrize.text = costMoney .. "元"
		else
			local matType, id, matNum = MaterialMgr.getMatParams(self._goodsCfg.originalGoodsId)
			local costName = MaterialMgr.getMaterialsName(matType, id)

			self._txtPrize.text = matNum .. costName
		end

		self:_preSecReset()
		settimer(1, self._preSecReset, self)
		self._photoEff:addShowAvatarEffect(self._avatar)

		self._isPlayBubble = false
		self.effResPath = "fx_ui_liuliuchong/fx_ui_mengjizhengyi.prefab"
		self._playEff = UIEffectManager.instance:playEffect(self, self.effResPath, nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self.mainGO.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)

		local funcOpenCfg = FuncOpenConfig.instance:getFunctionOpenById(checknumber(self._funcId))
		local times = string.split(funcOpenCfg.openTime, "#")
		local timeStart = GameUtil.string2time(times[1])
		local timeEnd = GameUtil.string2time(times[2])

		self._txtTime.text = langPara("活动时间 %s-%s", GameUtil.formatTimeStamp("%m月%d号", timeStart), GameUtil.formatTimeStamp("%m月%d号 %H:%M", timeEnd))
	end
end

function PigskinsellView:onExit()
	PigskinsellView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.NotifyPayShopItemBuySucRes, self.handlePayShopItemBuySucRes, self)
	removetimer(self._preSecReset, self)
	self:_finishPlayBubble()

	for i = 1, 3 do
		MaterialMgr.clearIcon(self._items[i].icon)
	end

	self._photoEff:clear()

	if self._playEff then
		UIEffectManager.instance:stopEffect(self._playEff)

		self._playEff = nil
	end

	if self._avatar then
		AvatarsMgrNew.instance:removeAvatar(self._avatar)

		self._avatar = nil
	end
end

function PigskinsellView:_onClickBtnBuy()
	self:_finishPlayBubble()

	if self._hasBuy then
		self:close()
		UIStateManager.instance:push(ViewName.PigskinselectView)

		return
	end

	local data = {
		id = self._goodsId,
		times = self._hasBuyTimes
	}

	UIStateManager.instance:push(ViewName.PayShopMibaoBuyView, data)
end

function PigskinsellView:_onClickItem(id)
	self:_finishPlayBubble()

	if self._items[id].matStr and self._items[id].go then
		CommonTipsMgr.instance:openTipsByConfStr(self._items[id].go, self._items[id].matStr)
	end
end

function PigskinsellView:handlePayShopItemBuySucRes(status, msg)
	if status == 0 then
		self:_preSecReset()
	end
end

function PigskinsellView:_preSecReset()
	local isOpen = FuncOpenModel.instance:getFuncIsOpen(self._funcId)

	if not isOpen then
		TipsFacade.instance:openCommonTips("当前活动已经结束")
		self:close()

		return
	end

	self._hasBuyTimes = PayShopModel.instance:getMibaoBuyTimesById(self._goodsId)
	self._hasBuy = self._hasBuyTimes > 0

	if self._hasBuy then
		self._txtPrize.text = lang("去穿戴")
	end
end

function PigskinsellView:_onDrag(eventData)
	local avatarGo = self._avatar:getGameObject()

	if avatarGo then
		local localRotation = Quaternion.Euler(0, -0.5 * eventData.delta.x * 1, 0) * avatarGo.transform.localRotation
		local eulerAngles = localRotation.eulerAngles

		Framework.TransformUtil.SetLocalRotation(avatarGo.transform, 0, eulerAngles.y, 0)
	end
end

function PigskinsellView:_playBubble()
	self:_finishPlayBubble()

	if not self._isPlayBubble then
		local cfg = PigraiseConfig.instance:getPetCfgById(self._sellPetId)
		local newstr = cfg and cfg.talk

		if newstr then
			self._isPlayBubble = true

			BubbleController.instance:OpenView(newstr, self._bubblePos.transform.position, true)
			settimer(2.5, self._finishPlayBubble, self, false)
		end
	end
end

function PigskinsellView:_finishPlayBubble()
	BubbleController.instance:CloseView()

	self._isPlayBubble = false

	removetimer(self._finishPlayBubble, self)
end

function PigskinsellView:_onClickJump()
	GotoMgr.gotoByString("mibao#Shimoshenlin4")
end

return PigskinsellView
