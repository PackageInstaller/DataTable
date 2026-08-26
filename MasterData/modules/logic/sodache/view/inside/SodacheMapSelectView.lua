-- chunkname: @modules/logic/sodache/view/inside/SodacheMapSelectView.lua

module("modules.logic.sodache.view.inside.SodacheMapSelectView", package.seeall)

local SodacheMapSelectView = class("SodacheMapSelectView", BaseView)

function SodacheMapSelectView:onInitView()
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "#go_mapcontent/#go_mapItems/mapitem/#go_location/#txt_locationname")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "#go_mapcontent/#go_mapItems/mapitem/#go_location/#txt_desc")
	self._simagemapbg = gohelper.findChildSingleImage(self.viewGO, "#simage_mapbg")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normalmask")
	self._gohard = gohelper.findChild(self.viewGO, "#go_difficultymask")
	self._mapItemRoot = gohelper.findChild(self.viewGO, "#go_mapcontent/#go_mapItems")
	self._gotypecontainer = gohelper.findChild(self.viewGO, "#go_ticketcontainer")
	self._gotypeitem = gohelper.findChild(self.viewGO, "#go_ticketcontainer/types/item")
	self._gocoin = gohelper.findChild(self.viewGO, "#go_topright/currencyview")
	self._goswitch = gohelper.findChild(self.viewGO, "#go_switchmodecontainer")
	self._btnSwitchMode = gohelper.findChildButtonWithAudio(self.viewGO, "#go_switchmodecontainer/#btn_click")
	self._goSimpleSelect = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_simple")
	self._goHardSelect = gohelper.findChild(self.viewGO, "#go_switchmodecontainer/#go_hard")
	self._animHard = gohelper.findComponentAnim(self._gohard)
	self._animSwitch = gohelper.findComponentAnim(self._goswitch)

	self._animHard:Play("close", 0, 1)
	self._animHard:Update(0)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheMapSelectView:addEvents()
	self._btnSwitchMode:AddClickListener(self.switchMode, self)
end

function SodacheMapSelectView:removeEvents()
	self._btnSwitchMode:RemoveClickListener()
end

function SodacheMapSelectView:_editableInitView()
	MonoHelper.addNoUpdateLuaComOnceToGo(self._gocoin, SodacheCurrencyComp, {
		bagType = SodacheEnum.BagType.Outside
	})

	self._pos = self:getUserDataTb_()

	gohelper.setActive(self._gotypeitem, false)

	for i = 1, 4 do
		local pos = gohelper.findChild(self.viewGO, "#go_ticketcontainer/types/pos" .. i)

		self._pos[i] = gohelper.clone(self._gotypeitem, pos, "Pos" .. i)

		recthelper.setAnchor(self._pos[i].transform, 0, 0)
		gohelper.setActive(self._pos[i], false)
	end
end

function SodacheMapSelectView:onOpen()
	gohelper.setActive(self._gohard, true)

	self._isRookie = SodacheUtil.isRookie()

	gohelper.setActive(self._goswitch, not self._isRookie and SodacheUtil.isOpen(SodacheEnum.OpenId.HardMode))

	if self._isRookie then
		self:setMode(SodacheEnum.MapType.Rookie)
	else
		self:setMode(SodacheEnum.MapType.Simple)
	end
end

function SodacheMapSelectView:switchMode()
	if self._isRookie then
		return
	end

	if self._selectMode ~= SodacheEnum.MapType.Hard then
		if not SodacheUtil.isOpen(SodacheEnum.OpenId.HardMode) then
			return
		end

		self._toMode = SodacheEnum.MapType.Hard
	else
		self._toMode = SodacheEnum.MapType.Simple
	end

	UIBlockHelper.instance:startBlock("SodacheMapSelectView_SwitchMode", 0.167)
	self._animSwitch:Play("refresh", 0, 0)
	ZProj.TweenHelper.DOAnchorPosX(self._gotypecontainer.transform, 400, 0.167)
	TaskDispatcher.runDelay(self._delaySwitchMode, self, 0.167)
end

function SodacheMapSelectView:_delaySwitchMode()
	ZProj.TweenHelper.DOAnchorPosX(self._gotypecontainer.transform, -347.7, 0.3)
	self:setMode(self._toMode)

	self._toMode = nil
end

function SodacheMapSelectView:setMode(mode)
	gohelper.setActive(self._goSimpleSelect, mode ~= SodacheEnum.MapType.Hard)
	gohelper.setActive(self._goHardSelect, mode == SodacheEnum.MapType.Hard)
	gohelper.setActive(self._gonormal, mode ~= SodacheEnum.MapType.Hard)
	self._animHard:Play(mode == SodacheEnum.MapType.Hard and "open" or "close")

	self._selectMode = mode

	SodacheController.instance:dispatchEvent(SodacheEvent.MapTypeSelectChange, mode)
	self:_onMapItemChange()
end

function SodacheMapSelectView:_onMapItemChange()
	local co = SodacheConfig.instance:getCopyCo(self._selectMode)

	self._txtname.text = co.name
	self._copyCo = co

	if not co then
		return
	end

	self._txtdesc.text = co.desc

	self._simagemapbg:LoadImage(ResUrl.getSodacheSingleBg(co.image, "map"))

	self._costCoins = {}
	self._itemAnim = self._itemAnim or self:getUserDataTb_()

	tabletool.clear(self._itemAnim)

	local arr = string.splitToNumber(co.price, "#") or {}

	self._selectId = nil

	if #arr == 1 then
		gohelper.setActive(self._pos[2], true)
		self:_createTypeItem(self._pos[2], arr[1], 1)
	else
		for i = 1, 4 do
			gohelper.setActive(self._pos[i], true)
			self:_createTypeItem(self._pos[i], arr[i], i)
		end
	end
end

function SodacheMapSelectView:_createTypeItem(obj, data, index)
	local co = lua_sodache_tickets.configDict[data]

	if not co then
		return
	end

	local select = gohelper.findChild(obj, "selected")
	local bg = gohelper.findChildImage(obj, "selected/bg")
	local name = gohelper.findChildTextMesh(obj, "selected/#txt_name")
	local desc = gohelper.findChildTextMesh(obj, "selected/#txt_desc")
	local cost = gohelper.findChildTextMesh(obj, "selected/#txt_cost")
	local costIcon = gohelper.findChildImage(obj, "selected/#txt_cost/#image_icon")
	local unselect = gohelper.findChild(obj, "unselect")
	local bg2 = gohelper.findChildImage(obj, "unselect/bg")
	local name2 = gohelper.findChildTextMesh(obj, "unselect/#txt_name")
	local desc2 = gohelper.findChildTextMesh(obj, "unselect/#txt_desc")
	local cost2 = gohelper.findChildTextMesh(obj, "unselect/#txt_cost")
	local costIcon2 = gohelper.findChildImage(obj, "unselect/#txt_cost/#image_icon")
	local btn = gohelper.findChildButtonWithAudio(obj, "#btn_click")
	local costCoin = 0

	if not string.nilorempty(co.price) then
		local arr = string.splitToNumber(co.price, ":")

		costCoin = arr and arr[2] or 0
	end

	name.text = co.name
	desc.text = co.tips
	name2.text = co.name
	desc2.text = co.tips

	local coinCount = SodacheUtil.getItemCount(SodacheEnum.CurrencyId.Coin)

	if coinCount < costCoin then
		local costDesc = string.format("<color=#E5482B>-%d</color>", costCoin)

		cost.text = costDesc
		cost2.text = costDesc
	else
		cost.text = -costCoin
		cost2.text = -costCoin
	end

	gohelper.setActive(select, true)
	gohelper.setActive(unselect, true)
	UISpriteSetMgr.instance:setSodache2Sprite(costIcon, SodacheUtil.getCurrencyIcon())
	UISpriteSetMgr.instance:setSodache2Sprite(costIcon2, SodacheUtil.getCurrencyIcon())
	UISpriteSetMgr.instance:setSodache2Sprite(bg, co.pic)
	UISpriteSetMgr.instance:setSodache2Sprite(bg2, co.pic)

	self._costCoins[co.id] = costCoin
	self._itemAnim[co.id] = gohelper.findComponentAnim(obj)

	self._itemAnim[co.id]:Play("unselect", 0, 1)
	self:removeClickCb(btn)
	self.addClickCb(self, btn, self._onClickType, self, co.id)
end

function SodacheMapSelectView:_onClickType(id)
	if not self._copyCo then
		return
	end

	if self._copyCo.functionId > 0 and not SodacheUtil.isOpen(self._copyCo.functionId) then
		return
	end

	if self._selectId ~= id then
		if self._itemAnim[self._selectId] then
			self._itemAnim[self._selectId]:Play("unselect")
		end

		self._selectId = id

		if self._itemAnim[self._selectId] then
			self._itemAnim[self._selectId]:Play("select")
		end

		return
	end

	local haveCoin = SodacheUtil.getItemCount(SodacheEnum.CurrencyId.Coin)
	local costCoin = self._costCoins[id]

	if costCoin <= 0 then
		self:_onEnterMap()
	elseif costCoin <= haveCoin then
		GameFacade.showMessageBox(MessageBoxIdDefine.SodacheMessageId373001, MsgBoxEnum.BoxType.Yes_No, self._onEnterMap, nil, nil, self, nil, nil, SodacheUtil.getCurrencyName(), costCoin)
	else
		GameFacade.showToast(ToastEnum.SodacheToastId373001, SodacheUtil.getCurrencyName())
	end
end

function SodacheMapSelectView:_onEnterMap()
	SodacheInsideRpc.instance:sendSodacheInsideEnterScene(self._copyCo.id, self._selectId)
end

function SodacheMapSelectView:onClose()
	TaskDispatcher.cancelTask(self._delaySwitchMode, self)
end

return SodacheMapSelectView
