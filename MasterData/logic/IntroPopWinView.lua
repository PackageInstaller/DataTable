-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/storysummary/view/IntroPopWinView.lua

module("logic.extensions.storysummary.view.IntroPopWinView", package.seeall)

local IntroPopWinView = class("IntroPopWinView", ViewComponent)

function IntroPopWinView:ctor()
	IntroPopWinView.super.ctor(self)
end

function IntroPopWinView:buildUI()
	IntroPopWinView.super.buildUI(self)

	self._mask = goutil.findChild(self.mainGO, "mask")
	self._bigBg = goutil.findChild(self.mainGO, "bigBg")
	self._topCol = goutil.findChild(self.mainGO, "topCol")
	self._chapterPre = goutil.findChild(self.mainGO, "topCol/chapterPre")
	self._numChangeGroup = goutil.findChild(self.mainGO, "topCol/num"):GetComponent(ComponentType.UIImageSpriteChange)
	self._ctCanvasGroup = goutil.findChild(self.mainGO, "contentCol"):GetComponent(ComponentType.CanvasGroup)
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "contentCol/txtTitle")
	self._txtDesc = goutil.findChildTextComponent(self.mainGO, "contentCol/txtDesc")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "contentCol/txtTips")

	GameUtil.SetActive(self._mask, true)
end

function IntroPopWinView:bindEvents()
	IntroPopWinView.super.bindEvents(self)
	GameUtil.addClickHandler(self._mask, self._onClickMask, self)
end

function IntroPopWinView:unbindEvents()
	IntroPopWinView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._mask)
end

function IntroPopWinView:destroyUI()
	IntroPopWinView.super.destroyUI(self)
end

function IntroPopWinView:onEnter()
	IntroPopWinView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	if not params[1] then
		local info = {}

		self._titleStr = info.titleStr
		self._descStr = info.descStr
		self._num = info.num
		self._gotoStr = info.gotoStr
		self._bigBgPath = info.bigBgPath

		self:_onUpdateUI()
		self:_startAnim()
	end
end

function IntroPopWinView:onExit()
	IntroPopWinView.super.onExit(self)
	uGuiUtil.clearImage(self._bigBg)
end

function IntroPopWinView:_onUpdateUI()
	local isNeedBigBg = not string.nilorempty(self._bigBgPath)

	if isNeedBigBg then
		local path = string.format("ui/bigbg/%s.png", self._bigBgPath)

		uGuiUtil.setSpriteToImage(self._bigBg, uGuiUtil.SpriteType.BigBg, path)
	end

	local isNeedTitle = not string.nilorempty(self._titleStr)

	GameUtil.SetActive(self._txtTitle.gameObject, isNeedTitle)

	self._txtTitle.text = self._titleStr or ""

	local isNeedDesc = not string.nilorempty(self._descStr)

	GameUtil.SetActive(self._txtDesc.gameObject, isNeedDesc)

	self._txtDesc.text = self._descStr or ""

	local isNeedNum = not string.nilorempty(self._num)

	GameUtil.SetActive(self._topCol, isNeedNum)

	if isNeedNum then
		self._numChangeGroup:SetState(self._num)
	end
end

function IntroPopWinView:_startAnim()
	self._isCanClickMask = false
	self._ctCanvasGroup.alpha = 0

	self:_topColAnim()
end

function IntroPopWinView:_topColAnim()
	local function finishHandler()
		self:_contentAnim()
	end

	local startVec = Vector3.New(-500, 0, 0)
	local tarVec = Vector3.New(0, 0, 0)
	local duration = 0.3
	local EaseType = UnityTweens.EaseType.easeOutSine

	UnityTweens.UITweenFadeIn.StartTween(self._topCol, duration, EaseType)
	UnityTweens.TweenPosition.StartTween(self._topCol, startVec, tarVec, duration, EaseType):AddListener(finishHandler, self)
end

function IntroPopWinView:_contentAnim()
	local function finishHandler()
		self._ctCanvasGroup.alpha = 1
		self._isCanClickMask = true
	end

	local duration = 0.8
	local EaseType = UnityTweens.EaseType.easeOutSine

	UnityTweens.UITweenFadeIn.StartTween(self._contentCol, duration, EaseType):AddListener(finishHandler, self)
end

function IntroPopWinView:_onClickMask()
	if not self._isCanClickMask then
		return
	end

	local isNeedGo = not string.nilorempty(self._gotoStr)

	if isNeedGo then
		GotoMgr.gotoByString(self._gotoStr)
	else
		self:close()
	end
end

return IntroPopWinView
