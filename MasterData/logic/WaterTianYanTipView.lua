-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/watertianyan/view/WaterTianYanTipView.lua

module("logic.extensions.watertianyan.view.WaterTianYanTipView", package.seeall)

local WaterTianYanTipView = class("WaterTianYanTipView", ViewComponent)

function WaterTianYanTipView:ctor()
	WaterTianYanTipView.super.ctor(self)
end

function WaterTianYanTipView:buildUI()
	WaterTianYanTipView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._changeSprite = self:getGo("imgTitle"):GetComponent(ComponentType.UIImageSpriteChange)
	self._buffIcon = self:getGo("bgIcon2/buffIcon")
	self._txtName = self:getTxt("txtName")
	self._txtSubTitle1 = self:getTxt("buff1/txtSubTitle")
	self._txtDesc1 = self:getTxt("buff1/txtDesc")
	self._buff2 = self:getGo("buff2")
	self._txtSubTitle2 = self:getTxt("buff2/txtSubTitle")
	self._txtDesc2 = self:getTxt("buff2/txtDesc")
end

function WaterTianYanTipView:bindEvents()
	WaterTianYanTipView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function WaterTianYanTipView:unbindEvents()
	WaterTianYanTipView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function WaterTianYanTipView:onEnter()
	WaterTianYanTipView.super.onEnter(self)

	local params = self:getOpenParam()

	self._viewType = params[1]
	self._activityId = params[2]
	self._buffItemId = params[3]
	self._level = checknumber(params[4])

	self:_initGo()

	self._cfgBuff = WaterTianYanConfig.instance:getBuffCfgByBuffItemId(self._activityId, self._buffItemId, self._level)

	if not self._cfgBuff then
		return
	end

	if self._viewType == WaterTianYanModel.TipUnlock then
		self._changeSprite:SetState(0)
		self:_initViewType1()
	elseif self._viewType == WaterTianYanModel.TipLevelup then
		self._changeSprite:SetState(1)
		self:_initViewType2()
	end
end

function WaterTianYanTipView:onExit()
	WaterTianYanTipView.super.onExit(self)
	self:_clearIcon()
end

function WaterTianYanTipView:_initGo()
	goutil.setActive(self._buff2, false)
end

function WaterTianYanTipView:_initViewType1()
	self:_initIcon()

	self._txtSubTitle1.text = self._cfgBuff.buffName
	self._txtDesc1.text = self._cfgBuff.desc
	self._txtName.text = self._cfgBuff.buffName
end

function WaterTianYanTipView:_initViewType2()
	self:_initIcon()
	goutil.setActive(self._buff2, true)

	local preLevel = Mathf.Max(self._level - 1, 1)
	local cfgPreBuff = WaterTianYanConfig.instance:getBuffCfgByBuffItemId(self._activityId, self._buffItemId, preLevel)

	if cfgPreBuff then
		self._txtSubTitle1.text = cfgPreBuff.buffName
		self._txtDesc1.text = cfgPreBuff.desc
	end

	self._txtSubTitle2.text = self._cfgBuff.buffName
	self._txtDesc2.text = self._cfgBuff.desc
end

function WaterTianYanTipView:_initIcon()
	uGuiUtil.setSpriteToImage(self._buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(self._cfgBuff.buffIcon))
end

function WaterTianYanTipView:_clearIcon()
	uGuiUtil.clearImage(self._buffIcon)
end

return WaterTianYanTipView
