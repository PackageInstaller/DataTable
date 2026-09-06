-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tips/view/ImageTipsView.lua

module("logic.extensions.tips.view.ImageTipsView", package.seeall)

local ImageTipsView = class("ImageTipsView", ViewComponent)

function ImageTipsView:buildUI()
	ImageTipsView.super.buildUI(self)

	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "txtDesc")
	self._imgRule = goutil.findChild(self.mainGO, "imgRule")
	self._customInput = UICustomInput.Get(self.mainGO)
end

function ImageTipsView:bindEvents()
	ImageTipsView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function ImageTipsView:unbindEvents()
	ImageTipsView.super.unbindEvents(self)
	self._customInput:RemoveListener()
end

function ImageTipsView:onEnter()
	ImageTipsView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._title = params[1] or "提示"
	self._desc = params[2] or ""
	self._imagePath = params[3]
	self._txtTitle.text = self._title
	self._txtDesc.text = self._desc

	local path = self._imagePath

	self:_loadBigBg(self._imgRule, path, false)
end

function ImageTipsView:onExit()
	ImageTipsView.super.onExit(self)
	self:_unLoadBigBg(self._imgRule)
end

function ImageTipsView:_loadBigBg(bgGo, path, isSetNativeSize)
	if not string.nilorempty(path) and bgGo then
		local spriteType = uGuiUtil.SpriteType.BigBg
		local spriteName = string.format("%s.png", path)

		local function func()
			if isSetNativeSize then
				bgGo:GetComponent(goutil.Type_UIImage):SetNativeSize()
			end
		end

		uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
	else
		self:_unLoadBigBg(bgGo)
	end
end

function ImageTipsView:_unLoadBigBg(bgGo)
	uGuiUtil.clearImage(bgGo)
end

function ImageTipsView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

return ImageTipsView
