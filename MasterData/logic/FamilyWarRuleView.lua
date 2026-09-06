-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarRuleView.lua

module("logic.extensions.newfamily.view.war.FamilyWarRuleView", package.seeall)

local FamilyWarRuleView = class("FamilyWarRuleView", ViewComponent)

function FamilyWarRuleView:ctor()
	FamilyWarRuleView.super.ctor(self)
end

function FamilyWarRuleView:bindEvents()
	FamilyWarRuleView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self._onClickCloseBtn, self)
	self._leftBtn:AddClickListener(function()
		self:_onClickLeftRightBtn(true)
	end, self)
	self._rightBtn:AddClickListener(function()
		self:_onClickLeftRightBtn(false)
	end, self)
end

function FamilyWarRuleView:unbindEvents()
	FamilyWarRuleView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()
end

function FamilyWarRuleView:onExit()
	FamilyWarRuleView.super.onExit(self)
	uGuiUtil.clearImage(self._iconGo)
end

function FamilyWarRuleView:destroyUI()
	FamilyWarRuleView.super.destroyUI(self)
end

function FamilyWarRuleView:buildUI()
	FamilyWarRuleView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._iconGo = self:getGo("iconGo")
	self._leftBtn = self:getBtn("leftBtn")
	self._rightBtn = self:getBtn("rightBtn")
	self._descTxt = goutil.findChildTextComponent(self.mainGO, "descGo/descTxt")
	self._descTxt.text = ""
end

function FamilyWarRuleView:onEnter()
	FamilyWarRuleView.super.onEnter(self)

	self._isOpenFamilyWar = self:getFirstParam()
	self._allCfgs = FamilyWarConfig.instance:getFamilyBattleRulesCfgs()

	if self._allCfgs then
		self._allCount = #self._allCfgs or 0
	end

	self._curIndex = 1

	self:_showRuleViewByIndex()
end

function FamilyWarRuleView:_onClickCloseBtn()
	local isOpen = self._isOpenFamilyWar

	self:close()

	if isOpen then
		FamilyWarController.instance:openFamilyWarMianView()
	end
end

function FamilyWarRuleView:_onClickLeftRightBtn(isLeft)
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

function FamilyWarRuleView:_showRuleViewByIndex()
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

return FamilyWarRuleView
