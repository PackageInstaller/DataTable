-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LionculturemeanView.lua

module("logic.extensions.lionculture.view.LionculturemeanView", package.seeall)

local LionculturemeanView = class("LionculturemeanView", ViewComponent)

function LionculturemeanView:ctor()
	LionculturemeanView.super.ctor(self)
end

function LionculturemeanView:unbindEvents()
	LionculturemeanView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnGoNext:RemoveClickListener()
end

function LionculturemeanView:bindEvents()
	LionculturemeanView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule3")
	end, self)
	self._btnGoNext:AddClickListener(self.goNextLevel, self)
end

function LionculturemeanView:buildUI()
	LionculturemeanView.super.buildUI(self)

	self._closeButton = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._btnGoNext = self:getBtn("game/btnNext")
	self._btnGoNextText = self:getTxt("game/btnNext/Text")
	self._picture = self:getGo("game/pictureInfoGo/picture")
	self._tipsObj = self:getGo("game/tips")
	self._messageObj = self:getGo("game/message")
	self._errorObj = self:getGo("game/errorTips")
	self._nameText = self:getTxt("game/message/name/txt")
	self._descText = self:getTxt("game/message/desc/Viewport/txt")
	self._faceBtns = {}

	for i = 1, 6 do
		self._faceBtns[i] = self:getBtn("game/pictureCell/pictureCell_" .. i)

		self._faceBtns[i]:AddClickListener(function()
			self:clickFace(i)
		end)
	end
end

function LionculturemeanView:onExit()
	LionculturemeanView.super.onExit(self)
	uGuiUtil.clearImage(self._picture)
end

function LionculturemeanView:onEnter()
	LionculturemeanView.super.onEnter(self)

	self.openList = LioncultureModel.instance:getNumBit(LioncultureModel.instance.gameLevels[2])
	self.allOver = #self.openList == 0

	self:initFaces()

	if self.allOver then
		self:overShow()

		return
	end

	LioncultureController.instance:sendPM_WakingLionGameStartGameReq(2)
	self:goNextLevel()

	self.typeConfig = LioncultureConfig.instance:getGameData(LioncultureModel.instance.activityId, 2)

	if not GameUtil.getUserData(ViewName.LionculturemeanView) then
		UIStateManager.instance:push(ViewName.LionculturetipView, self.typeConfig.desc)
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule3")
		GameUtil.saveUserData(ViewName.LionculturemeanView, true)
	end
end

function LionculturemeanView:initFaces()
	for i = 1, 6 do
		local config = LioncultureConfig.instance:getGameIntentionCfg(i)
		local obj = self._faceBtns[i].gameObject

		goutil.findChildTextComponent(obj, "txtName").text = config.name

		local img = goutil.findChild(obj, "pictureCon")

		uGuiUtil.setSpriteToImage(img, uGuiUtil.SpriteType.BigBg, GameUrl.getLionEmojiUrl(config.face))

		if not self.allOver then
			goutil.findChild(obj, "pass"):SetActive(not TableUtil.isHad(self.openList, i))
		end
	end
end

function LionculturemeanView:setPic(faceid)
	self.curFace = faceid

	local config = LioncultureConfig.instance:getGameIntentionCfg(faceid)

	uGuiUtil.setSpriteToImage(self._picture, uGuiUtil.SpriteType.BigBg, GameUrl.getLionCultureUrl(config.pic))
end

function LionculturemeanView:clickFace(index)
	for i = 1, 6 do
		local obj = self._faceBtns[i].gameObject

		goutil.findChild(obj, "select"):SetActive(i == index)
	end

	local config = LioncultureConfig.instance:getGameIntentionCfg(index)

	self._nameText.text = config.name
	self._descText.text = config.desc

	if self.allOver then
		self:setPic(index)

		return
	end

	self._tipsObj:SetActive(false)

	local isOk = self.curFace == index

	self._messageObj:SetActive(isOk)
	self._errorObj:SetActive(not isOk)

	if isOk and not GameUtil.getUserData(ViewName.LionculturemeanView .. "game" .. index) then
		GameUtil.saveUserData(ViewName.LionculturemeanView .. "game" .. index, true)
		UIEffectManager.instance:stopEffect(self._finishEffect)

		self._finishEffect = self:_showEffect(self._picture)
	end

	if not isOk then
		return
	end

	local obj = self._faceBtns[index].gameObject

	goutil.findChild(obj, "pass"):SetActive(true)
	self._btnGoNext.gameObject:SetActive(true)
	LioncultureModel.instance:setNumBit(index)
	LioncultureController.instance:sendPM_WakingLionGameEndGameReq(2, index)

	self.openList = LioncultureModel.instance:getNumBit(LioncultureModel.instance.gameLevels[2])
	self.allOver = #self.openList == 0

	if self.allOver then
		self._btnGoNextText.text = "全部完成"
	end
end

function LionculturemeanView:goNextLevel()
	if self.allOver then
		self:close()

		return
	end

	self:setPic(self.openList[math.random(1, #self.openList)])
	self._btnGoNext.gameObject:SetActive(false)
	self._tipsObj:SetActive(true)
	self._messageObj:SetActive(false)
	self._errorObj:SetActive(false)
end

function LionculturemeanView:overShow()
	self._btnGoNext.gameObject:SetActive(false)
	self._tipsObj:SetActive(false)
	self._messageObj:SetActive(true)
	self._errorObj:SetActive(false)
	self:clickFace(1)
end

function LionculturemeanView:_showEffect(go, func)
	local effect = UIEffectManager.instance:playEffect(self, "20230120/xingshiwenhua/fx_ui_xingshiwenhua_cg.prefab", go, 0, 0, false, false, func)

	effect:setParent(go.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)

	return effect
end

return LionculturemeanView
