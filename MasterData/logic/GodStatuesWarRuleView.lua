-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarRuleView.lua

module("logic.extensions.newfamily.view.war.GodStatuesWarRuleView", package.seeall)

local GodStatuesWarRuleView = class("GodStatuesWarRuleView", ViewComponent)

function GodStatuesWarRuleView:ctor()
	GodStatuesWarRuleView.super.ctor(self)
end

function GodStatuesWarRuleView:bindEvents()
	GodStatuesWarRuleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickCloseBtn, self)
	self._leftBtn:AddClickListener(function()
		self:_onClickLeftRightBtn(true)
	end, self)
	self._rightBtn:AddClickListener(function()
		self:_onClickLeftRightBtn(false)
	end, self)
end

function GodStatuesWarRuleView:unbindEvents()
	GodStatuesWarRuleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
end

function GodStatuesWarRuleView:onExit()
	GodStatuesWarRuleView.super.onExit(self)
	uGuiUtil.clearImage(self._iconGo)
end

function GodStatuesWarRuleView:destroyUI()
	GodStatuesWarRuleView.super.destroyUI(self)
end

function GodStatuesWarRuleView:buildUI()
	GodStatuesWarRuleView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._iconGo = self:getGo("iconGo")
	self._leftBtn = self:getBtn("leftBtn")
	self._rightBtn = self:getBtn("rightBtn")
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "descGo/descTxt")
	self._descTxt.text = ""
end

function GodStatuesWarRuleView:onEnter()
	GodStatuesWarRuleView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._seasonId = checknumber(params[1])
	self._allCfgs = GodStatuesWarConfig.instance:getNfbRulesCfg(self._seasonId)
	self._allCfgs = self._allCfgs or {}

	if self._allCfgs then
		self._allCount = #self._allCfgs or 0
	end

	self._curIndex = 1

	self:_showRuleViewByIndex()
end

function GodStatuesWarRuleView:_onClickCloseBtn()
	self:close()
end

function GodStatuesWarRuleView:_onClickLeftRightBtn(isLeft)
	if isLeft and self._curIndex <= 1 then
		return
	end

	if not isLeft and self._curIndex >= self._allCount then
		return
	end

	if isLeft then
		self._curIndex = self._curIndex - 1 or self._curIndex + 1
	end

	self:_showRuleViewByIndex()
end

function GodStatuesWarRuleView:_showRuleViewByIndex()
	local cfg = self._allCfgs[self._curIndex]

	if cfg == nil or string.nilorempty(cfg.icon) then
		return
	end

	self._descTxt.text = cfg.desc

	uGuiUtil.setSpriteToImage(self._iconGo, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/familynesttower/%s.png", cfg.icon))

	if self._curIndex <= 1 then
		uGuiUtil.setImageGrayState(self._leftBtn.gameObject, true)

		return
	end

	if self._curIndex >= self._allCount then
		uGuiUtil.setImageGrayState(self._rightBtn.gameObject, true)

		return
	end

	uGuiUtil.setImageGrayState(self._leftBtn.gameObject, false)
	uGuiUtil.setImageGrayState(self._rightBtn.gameObject, false)
end

return GodStatuesWarRuleView
