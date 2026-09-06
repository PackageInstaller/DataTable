-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/SunranResultView.lua

module("logic.extensions.sunranbattle.view.SunranResultView", package.seeall)

local SunranResultView = class("SunranResultView", ViewComponent)

function SunranResultView:ctor()
	SunranResultView.super.ctor(self)
end

function SunranResultView:bindEvents()
	SunranResultView.super.bindEvents(self)
	GameUtil.asBtn(self._closeGo):AddClickListener(self._onClickCloseBtn, self)
end

function SunranResultView:unbindEvents()
	SunranResultView.super.unbindEvents(self)
	GameUtil.asBtn(self._closeGo):RemoveClickListener()
end

function SunranResultView:onExit()
	return
end

function SunranResultView:destroyUI()
	SunranResultView.super.destroyUI(self)

	local sigBig = self._sprineImaGo:GetComponent("ImageBigBG")

	if sigBig then
		sigBig:ClearImage()
	end
end

function SunranResultView:buildUI()
	SunranResultView.super.buildUI(self)

	self._closeGo = self:getGo("closeGo")
	self._sprineImaGo = self:getGo("sprineIma")
	self._oldNumTxt = self:getGo("oldNumTxt"):GetComponent("UIImgNumeralText")
	self._newNumTxt = self:getGo("newNumTxt"):GetComponent("UIImgNumeralText")
	self._addNumTxt = goutil.findChildTextComponent(self.mainGO, "addNumGo/addNumTxt")
	self._bubbleTxt = goutil.findChildTextComponent(self.mainGO, "bubbleGo/bubbleTxt")
	self._addNumTxt.text = ""
	self._bubbleTxt.text = ""
end

function SunranResultView:onEnter()
	SunranResultView.super.onEnter(self)

	self._endInfo = self._viewPresentor:getFirstParam()

	if self._endInfo == nil or not self._endInfo.isBest then
		printError("sr---挑战    SunranResultView:onEnter()   参数传入有误！")

		return
	end

	local stageCfg = SunranBattleConfig.instance:getBattleStageCfg(self._endInfo.seasonId, self._endInfo.stageId)

	if stageCfg then
		uGuiUtil.setSpriteToImage(self._sprineImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(stageCfg.bestElves))
	end

	self._oldNumTxt:SetNum(self._endInfo.oldScore)
	self._newNumTxt:SetNum(self._endInfo.score)

	self._addNumTxt.text = "+" .. ((self._endInfo.score > self._endInfo.oldScore or nil) and self._endInfo.score - self._endInfo.oldScore)

	if stageCfg then
		self._bubbleTxt.text = stageCfg.bestBubble or ""
	end

	local num = #tostring(self._endInfo.oldScore)
	local deltaX = self._oldNumTxt.horizontalSpace * 0.5 * (num - 1)

	Framework.TransformUtil.SetLocalPos(self._oldNumTxt.transform, -178 - deltaX, -9, 0)
end

function SunranResultView:_onClickCloseBtn()
	self:close()
	SunranBattleModel.instance:resetBattleEndInfo()
end

return SunranResultView
