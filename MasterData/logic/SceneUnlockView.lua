-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/unlock/view/SceneUnlockView.lua

module("logic.extensions.unlock.view.SceneUnlockView", package.seeall)

local SceneUnlockView = class("SceneUnlockView", ViewComponent)

function SceneUnlockView:buildUI()
	SceneUnlockView.super.buildUI(self)

	self._canvasGroup = self.mainGO:GetComponent("CanvasGroup")
	self._background = self:getGo("RawImage"):GetComponent("RawImage")
	self._textScene = self:getGo("Text"):GetComponent("Text")
	self._textTask = self:getGo("Text1"):GetComponent("Text")
	self._closeButton = self:getBtn("blurBg")
	self._blurBg = goutil.findChildComponent(self.mainGO, "blurBg", "StaticBluredScreen")
	self._tweenIn = self.mainGO:GetComponent(UnityTweensType.UITweenFadeIn)

	local clickClose = self:getGo("ClickClose"):GetComponent("Text")

	clickClose.text = lang("click_close")
end

function SceneUnlockView:onEnter()
	self._tweenIn:AddListener(self._onTweenInFinish, self)

	self._resLoader = MultiResLoader.New()
	self._canvasGroup.alpha = 0

	local tips = self:getFirstParam()
	local texts = string.split(tips, "\n")

	self._textScene.text = "<color=#32385e>" .. texts[1] .. "</color>"

	if not texts[2] then
		self._textTask.text = ""

		Framework.TransformUtil.SetLocalPos(self._textScene.transform, 0, 0, 0)
	else
		Framework.TransformUtil.SetLocalPos(self._textScene.transform, 0, 26, 0)

		self._textTask.text = "<color=#32385e>" .. texts[2] .. "</color>"
	end

	self._closeButton:AddClickListener(self._onClickMask, self)

	self._texturePath = StoryConst.StoryPath_Assets .. "xgnkq_cjjiesuo_di.png"

	self._resLoader:addResPath(self._texturePath)
	self._resLoader:load(self._onImageResourcesLoaded, nil, self)
	self._blurBg:Release()
	self._blurBg:Capture()
end

function SceneUnlockView:onExit()
	self._isTweenFinished = nil

	self._tweenIn:RemoveListener()

	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end

	self._closeButton:RemoveClickListener()
	self._blurBg:Release()
end

function SceneUnlockView:_onImageResourcesLoaded(loader)
	local texture
	local res = self._resLoader:getResource(self._texturePath)

	if res then
		self._background.texture = res:GetMainAsset()
	end

	self._background:SetNativeSize()
	self._tweenIn:Stop()
	self._tweenIn:Begin()
end

function SceneUnlockView:_onClickMask()
	if self._isTweenFinished then
		self:close()
	end
end

function SceneUnlockView:_onTweenInFinish()
	self._isTweenFinished = true
end

return SceneUnlockView
