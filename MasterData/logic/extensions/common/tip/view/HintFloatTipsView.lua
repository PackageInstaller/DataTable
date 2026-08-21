-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/tip/view/HintFloatTipsView.lua

module("logic.extensions.common.tip.view.HintFloatTipsView", package.seeall)

local M = class("HintFloatTipsView", ViewComponent)

function M:buildUI()
	self._bindList = {
		self:getGo("hint_float_tips_-304461046"),
		self:getGo("hint_float_tips_1393211256"),
		self:getGo("hint_float_tips_986625833"),
		self:getGo("hint_float_tips_824732044"),
		self:getGo("hint_float_tips_2086801880"),
		self:getGo("hint_float_tips_-187641983"),
		self:getGo("hint_float_tips_-304461046"),
		self:getGo("hint_float_tips_40979534"),
		self:getGo("hint_float_tips_95630808")
	}
	self._left_hint = self:getGo("hint_float_tips_-301612930")
	self._leftTxtTitle = self:getText("hint_float_tips_-1700066069")
	self._leftTxtDesc = self:getText("hint_float_tips_-1110539727")
	self._leftClick = self:getBtn("hint_float_tips_-1849661990")
	self._leftIcon = self:getImage("hint_float_tips_-889399932")
	self._leftCommonBg = self:getGo("hint_float_tips_-1238043529")
	self._leftMonumentIcon = self:getImage("hint_float_tips_-6718096")
	self._right_hint = self:getGo("hint_float_tips_330569976")
	self._rightTxtTitle = self:getText("hint_float_tips_-1699027951")
	self._rightTxtDesc = self:getText("hint_float_tips_-1886263396")
	self._rightClick = self:getBtn("hint_float_tips_-784115706")
	self._rightIcon = self:getImage("hint_float_tips_1067524915")
	self._rightCommonBg = self:getImage("hint_float_tips_607174273")
	self._rightMonumentIcon = self:getImage("hint_float_tips_485342092")
	self._guiAnimation = goutil.addComponentOnce(self._left_hint, ComponentType.Animation)
end

function M:bindEvents()
	self._leftClick:AddClickListener(self._onClick, self)
	self._rightClick:AddClickListener(self._onClick, self)
end

function M:unbindEvents()
	self._leftClick:RemoveClickListener()
	self._rightClick:RemoveClickListener()
end

function M:onEnter()
	local data = self:getFirstParam()
	local iconType = CommEnum.TipsIconType.Common
	local useLeftItem = false
	local iconName = data.iconName

	if data.anchor ~= CommEnum.AnchorEnum.TopRight or data.anchor == CommEnum.AnchorEnum.Right or data.anchor == CommEnum.AnchorEnum.BottomRight then
		useLeftItem = true
	end

	if data.iconType then
		iconType = data.iconType
	end

	local fixPosX = data.posX or 0
	local fixPosY = data.PosY or 0
	local isCommonIcon = iconType == CommEnum.TipsIconType.Common
	local isMonumentIcon = iconType == CommEnum.TipsIconType.Monument

	goutil.setActive(self._left_hint, useLeftItem)
	goutil.setActive(self._right_hint, not useLeftItem)
	goutil.setActive(self._leftCommonBg.gameObject, isCommonIcon)
	goutil.setActive(self._leftIcon.gameObject, isCommonIcon)
	goutil.setActive(self._leftMonumentIcon.gameObject, isMonumentIcon)
	goutil.setActive(self._rightCommonBg.gameObject, isCommonIcon)
	goutil.setActive(self._rightIcon.gameObject, isCommonIcon)
	goutil.setActive(self._rightMonumentIcon.gameObject, isMonumentIcon)

	local bindGo = self._bindList[(data.anchor and data.anchor or 0) + 1]

	goutil.addChildToParent(useLeftItem and self._left_hint or self._right_hint, bindGo)

	if useLeftItem then
		self._leftTxtTitle.text = data.title
		self._leftTxtDesc.text = StringUtil.getShortName(data.content, 42) or ""

		Astral.TransformUtil.SetLocalPos(self._left_hint.transform, fixPosX, fixPosY, 0)
		IconLoader.setSprite(self._leftIcon, IconType.SideIcon, iconName)
		IconLoader.setSprite(self._leftMonumentIcon, IconType.SideIcon, iconName)
	else
		self._rightTxtTitle.text = data.title
		self._rightTxtDesc.text = StringUtil.getShortName(data.content, 42) or ""

		Astral.TransformUtil.SetLocalPos(self._right_hint.transform, fixPosX, fixPosY, 0)
		IconLoader.setSprite(self._rightIcon, IconType.SideIcon, iconName)
		IconLoader.setSprite(self._rightMonumentIcon, IconType.SideIcon, iconName)
	end
end

function M:_onClick()
	print("undefine method")
end

function M:onExit()
	return
end

return M
