-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/view/GuessBoxRuleView.lua

module("logic.extensions.guessbox.view.GuessBoxRuleView", package.seeall)

local GuessBoxRuleView = class("GuessBoxRuleView", ViewComponent)

function GuessBoxRuleView:ctor()
	GuessBoxRuleView.super.ctor(self)
end

function GuessBoxRuleView:buildUI()
	GuessBoxRuleView.super.buildUI(self)

	self._ruleBg = goutil.findChild(self.mainGO, "ruleBg")
	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnLeft = goutil.findChild(self.mainGO, "btnLeft")
	self._btnRight = goutil.findChild(self.mainGO, "btnRight")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
end

function GuessBoxRuleView:bindEvents()
	GuessBoxRuleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnLeft, function()
		self:turnPage(-1)
	end, self)
	GameUtil.addClickHandler(self._btnRight, function()
		self:turnPage(1)
	end, self)
end

function GuessBoxRuleView:unbindEvents()
	GuessBoxRuleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnLeft)
	GameUtil.rmClickHandler(self._btnRight)
end

function GuessBoxRuleView:destroyUI()
	GuessBoxRuleView.super.destroyUI(self)
end

function GuessBoxRuleView:onEnter()
	GuessBoxRuleView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())
	self._gbRuleCfg = GuessBoxConfig.instance:getGbRuleCfg(self._activityId)
	self._curPageId = 1
	self._maxPageId = #self._gbRuleCfg

	self:_onUpdatePlaneUI()
end

function GuessBoxRuleView:onExit()
	GuessBoxRuleView.super.onExit(self)
	uGuiUtil.clearImage(self._ruleBg)
	GlobalDispatcher:dispatch(GlobalNotify.SuppressGameToStartGame)
end

function GuessBoxRuleView:_onUpdatePlaneUI()
	if not self._gbRuleCfg[self._curPageId] then
		local gbRuleData = {}
		local isInHomePage = self._curPageId == 1
		local isInLastPage = self._curPageId == self._maxPageId

		GameUtil.SetActive(self._btnLeft, not isInHomePage)
		GameUtil.SetActive(self._btnRight, not isInLastPage)
		GameUtil.SetActive(self._btnClose, isInLastPage)

		if not string.nilorempty(gbRuleData.txtRule) and self._txtTip then
			self._txtTip.text = gbRuleData.txtRule
		end

		local path = gbRuleData.picturePath
		local bgGo = self._ruleBg

		if not string.nilorempty(path) and bgGo then
			local spriteType = uGuiUtil.SpriteType.BigBg
			local spriteName = string.format("ui/bigbg/%s.png", path)

			local function func()
				return
			end

			uGuiUtil.setSpriteToImage(bgGo, spriteType, spriteName, func)
		end
	end
end

function GuessBoxRuleView:turnPage(pageNum)
	local num = self._curPageId + pageNum

	num = Mathf.Clamp(num, 0, self._maxPageId)
	self._curPageId = num

	self:_onUpdatePlaneUI()
end

return GuessBoxRuleView
