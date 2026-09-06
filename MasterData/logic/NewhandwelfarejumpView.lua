-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewhandwelfarejumpView.lua

module("logic.extensions.newhandwelfare.view.NewhandwelfarejumpView", package.seeall)

local NewhandwelfarejumpView = class("NewhandwelfarejumpView", ViewComponent)

function NewhandwelfarejumpView:ctor()
	NewhandwelfarejumpView.super.ctor(self)
end

function NewhandwelfarejumpView:unbindEvents()
	NewhandwelfarejumpView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnPassport:RemoveClickListener()
	self._btnFirstCharge:RemoveClickListener()
	self._btnShop:RemoveClickListener()
end

function NewhandwelfarejumpView:bindEvents()
	NewhandwelfarejumpView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnPassport:AddClickListener(self._onClickbtnPassport, self)
	self._btnFirstCharge:AddClickListener(self._onClickbtnFirstCharge, self)
	self._btnShop:AddClickListener(self._onClickbtnShop, self)
end

function NewhandwelfarejumpView:buildUI()
	NewhandwelfarejumpView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnPassport = self:getBtn("btnPassport")
	self._btnFirstCharge = self:getBtn("btnFirstCharge")
	self._btnShop = self:getBtn("btnShop")
	self._txtTime = goutil.findChildTextComponent(self.mainGO, "time/txtTime")
	self._imgChange1 = self:getGo("btnFirstCharge/img"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgChange2 = self:getGo("btnPassport/img"):GetComponent(ComponentType.UIImageSpriteChange)
	self._imgChange3 = self:getGo("btnShop/img"):GetComponent(ComponentType.UIImageSpriteChange)
end

function NewhandwelfarejumpView:onExit()
	NewhandwelfarejumpView.super.onExit(self)
end

function NewhandwelfarejumpView:onEnter()
	NewhandwelfarejumpView.super.onEnter(self)

	self._periodId = NewhandwelfareModel.instance:getPeriodId()
	self._periodCfg = NewhandwelfareConfig.instance:getPeriodCfg(self._periodId)

	self:_setIcons()
end

function NewhandwelfarejumpView:_onClickbtnClose()
	self:close()
end

function NewhandwelfarejumpView:_onClickbtnPassport()
	GlobalDispatcher:dispatch(TabFrameWorkController.NotifyTabframeworkviewJumpByName, TabFrameWorkEnum.FrameIds_XinShouTeHui, ViewName.NewhandprivilegeTabView)

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:_onClickbtnClose()
	end
end

function NewhandwelfarejumpView:_onClickbtnFirstCharge()
	if FuncOpenModel.instance:getFuncIsOpen(118) then
		FuncOpenController.instance:openFunc(118)
	else
		FuncOpenController.instance:openFunc(989)
	end

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:_onClickbtnClose()
	end
end

function NewhandwelfarejumpView:_onClickbtnShop()
	local goodsId = self._periodCfg.newHandGoodsId

	PayShopController.instance:buyShopItemWithTips(goodsId)

	if not ViewSetting.instance:isFullScreen(self._viewPresentor.viewName) then
		self:_onClickbtnClose()
	end
end

function NewhandwelfarejumpView:_setIcons()
	local name1 = NewhandwelfareConfig.instance:getJumpViewResName(self._periodId, 1)
	local name2 = NewhandwelfareConfig.instance:getJumpViewResName(self._periodId, 2)
	local name3 = NewhandwelfareConfig.instance:getJumpViewResName(self._periodId, 3)

	if name1 then
		self._imgChange1:ChangeSprite(name1)
	end

	if name2 then
		self._imgChange2:ChangeSprite(name2)
	end

	if name3 then
		self._imgChange3:ChangeSprite(name3)
	end
end

return NewhandwelfarejumpView
