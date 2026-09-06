-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lionculture/view/LioncultureshapeView.lua

module("logic.extensions.lionculture.view.LioncultureshapeView", package.seeall)

local LioncultureshapeView = class("LioncultureshapeView", ViewComponent)

function LioncultureshapeView:ctor()
	LioncultureshapeView.super.ctor(self)
end

function LioncultureshapeView:unbindEvents()
	LioncultureshapeView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnGoNext:RemoveClickListener()
end

function LioncultureshapeView:bindEvents()
	LioncultureshapeView.super.bindEvents(self)
	self._closeButton:AddClickListener(function()
		self:close()
	end, self)
	self._btnTip:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule2")
	end, self)
	self._btnGoNext:AddClickListener(self.goNextLevel, self)
end

function LioncultureshapeView:buildUI()
	LioncultureshapeView.super.buildUI(self)

	self._closeButton = self:getBtn("leftTop/btnClose")
	self._btnTip = self:getBtn("leftTop/btnTip")
	self._mask = self:getGo("game/mask")
	self._smallImage = self:getGo("game/preview/picture/pictureCon")
	self._partImage = self:getGo("game/pictureInfoGo/picture")
	self._partNode = self:getGo("game/introduceCell")
	self._partNodeLine = self:getGo("game/introduceCell/line")
	self._partText = self:getTxt("game/introduceCell/desc/contentBg/txtContent")
	self._nameText = self:getTxt("game/gameview/nowpicture/picture/txtName")
	self._numText = self:getTxt("game/gameview/level/txtLevel")
	self._percentText = self:getTxt("game/gameview/progress/txtProgress")
	self._gameObj = self:getGo("game/gameview")
	self._finishObj = self:getGo("game/finish")
	self._overObj = self:getGo("game/allFinish")
	self._name2Text = self:getTxt("game/finish/message/name/txt")
	self._descText = self:getTxt("game/finish/message/desc/Viewport/txtDesc")
	self._lastText = self:getTxt("game/finish/tips/txt")
	self._btnGoNext = self:getBtn("game/finish/btnContinue")
	self._goNextText = self:getTxt("game/finish/btnContinue/Text")
	self._name3Text = self:getTxt("game/allFinish/message/name/txt")
	self._desc3Text = self:getTxt("game/allFinish/message/desc/Viewport/txt")
	self._colorBtns = {}

	for i = 1, 6 do
		self._colorBtns[i] = self:getBtn("game/gameview/color/color_" .. i)

		self._colorBtns[i]:AddClickListener(function()
			self:partClik(i)
		end)
	end

	self._showBtns = {}

	for i = 1, 6 do
		self._showBtns[i] = self:getBtn("game/allFinish/pictureCell/pictureCell_" .. i)

		self._showBtns[i]:AddClickListener(function()
			self:showClik(i)
		end)
	end
end

function LioncultureshapeView:onExit()
	LioncultureshapeView.super.onExit(self)
	UnityTweens.TweenEmpty.StopTween(self._partImage)
	UIEffectManager.instance:stopEffect(self._effect)
	uGuiUtil.clearImage(self._smallImage)
	uGuiUtil.clearImage(self._partImage)

	for i = 1, self.partCount do
		uGuiUtil.clearImage(self._colorBtns[i].gameObject)
	end
end

function LioncultureshapeView:onEnter()
	LioncultureshapeView.super.onEnter(self)

	if LioncultureModel.instance.gameFinishs[1] then
		self:overShow()

		return
	else
		self._overObj:SetActive(false)
	end

	LioncultureController.instance:sendPM_WakingLionGameStartGameReq(1)

	self.totelLevel = LioncultureConfig.instance:getGameShapeTotel()
	self.curPart = 1

	self:setLevel(LioncultureModel.instance.gameLevels[1] + 1)

	self.typeConfig = LioncultureConfig.instance:getGameData(LioncultureModel.instance.activityId, 1)

	if not GameUtil.getUserData(ViewName.LioncultureshapeView) then
		UIStateManager.instance:push(ViewName.LionculturetipView, self.typeConfig.desc)
		UIStateManager.instance:push(ViewName.RulesView, "lionculture_rule2")
		GameUtil.saveUserData(ViewName.LioncultureshapeView, true)
	end

	goutil.setActive(self._mask, false)
end

function LioncultureshapeView:setLevel(level)
	self.curLevel = level

	self._gameObj:SetActive(true)
	self._finishObj:SetActive(false)
	self._partNode:SetActive(true)

	local config = LioncultureConfig.instance:getGameShapeCfg(level)

	self.partCount = LioncultureConfig.instance:getGameShapePartCount(level)

	uGuiUtil.setSpriteToImage(self._smallImage, uGuiUtil.SpriteType.BigBg, GameUrl.getLionCultureUrl(config.pic))

	self._nameText.text = config.name
	self._numText.text = string.format("当前第：<color=#20B376FF>%d</color>/%d只", level, self.totelLevel)

	for i = 1, 6 do
		self._colorBtns[i].gameObject:SetActive(i <= self.partCount)
	end

	self.randomSeq = LioncultureModel.instance:getRandomSeq(self.partCount)

	for i = 1, self.partCount do
		local partCfg = LioncultureConfig.instance:getGameShapePartCfg(level, self.randomSeq[i])

		uGuiUtil.setSpriteToImage(self._colorBtns[i].gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getLionCultureUrl(partCfg.colorImg))
	end

	self:setPart(1)
	self:btnSelect(0)
end

function LioncultureshapeView:setPart(index)
	self.curPart = index

	local config = LioncultureConfig.instance:getGameShapePartCfg(self.curLevel, index)

	uGuiUtil.setSpriteToImage(self._partImage, uGuiUtil.SpriteType.BigBg, GameUrl.getLionCultureUrl(config.img))

	self._percentText.text = string.format("<color=#BEB9A6FF>完成度:</color>%d%%", (index - 1) / self.partCount * 100)
	self._partText.text = string.format("醒狮%s", config.name)

	GameUtil.setWidth(self._partNodeLine, config.pos[1])
	GameUtil.setHeight(self._partNodeLine, config.pos[2])
end

function LioncultureshapeView:partClik(index)
	self:btnSelect(index)

	if self.randomSeq[index] ~= self.curPart then
		UnityTweens.TweenShakePosition.StartTween(self._partImage, Vector3.New(8, 8, 0), 1)

		return
	end

	self.curPart = self.curPart + 1

	if self.curPart <= self.partCount then
		self:setPart(self.curPart)

		return
	end

	UIEffectManager.instance:stopEffect(self._effect)

	self._effect = self:_showEffect(self._partImage)

	self:levelOK()
end

function LioncultureshapeView:btnSelect(index)
	for i = 1, self.partCount do
		goutil.findChild(self._colorBtns[i].gameObject, "select"):SetActive(index == i)
	end
end

function LioncultureshapeView:levelOK()
	self._gameObj:SetActive(false)
	self._finishObj:SetActive(true)
	self._partNode:SetActive(false)
	goutil.setActive(self._mask, false)

	local config = LioncultureConfig.instance:getGameShapeCfg(self.curLevel)

	self._name2Text.text = config.name
	self._descText.text = config.desc
	self._lastText.text = string.format("还有<color=#20B376FF>%d</color>个狮头等待上色", self.totelLevel - self.curLevel)

	if self.curLevel == self.totelLevel then
		self._goNextText.text = "全部完成"
	end

	uGuiUtil.setSpriteToImage(self._partImage, uGuiUtil.SpriteType.BigBg, GameUrl.getLionCultureUrl(config.img))
	LioncultureController.instance:sendPM_WakingLionGameEndGameReq(1, self.curLevel)
end

function LioncultureshapeView:goNextLevel()
	if self.curLevel >= self.totelLevel then
		self:close()

		return
	end

	self.curLevel = self.curLevel + 1

	if self.curLevel <= self.totelLevel then
		self:setLevel(self.curLevel)
	end
end

function LioncultureshapeView:overShow()
	self._gameObj:SetActive(false)
	self._overObj:SetActive(true)
	self._finishObj:SetActive(false)
	self._partNode:SetActive(false)

	for i = 1, 6 do
		local config = LioncultureConfig.instance:getGameShapeCfg(i)
		local img = goutil.findChild(self._showBtns[i].gameObject, "pictureCon")

		uGuiUtil.setSpriteToImage(img, uGuiUtil.SpriteType.BigBg, GameUrl.getLionCultureUrl(config.img))
	end

	self:showClik(1)
end

function LioncultureshapeView:showClik(index)
	local config = LioncultureConfig.instance:getGameShapeCfg(index)

	self._name3Text.text = config.name
	self._desc3Text.text = config.desc

	uGuiUtil.setSpriteToImage(self._partImage, uGuiUtil.SpriteType.BigBg, GameUrl.getLionCultureUrl(config.img))
	uGuiUtil.setSpriteToImage(self._smallImage, uGuiUtil.SpriteType.BigBg, GameUrl.getLionCultureUrl(config.pic))

	for i = 1, 6 do
		goutil.findChild(self._showBtns[i].gameObject, "select"):SetActive(index == i)
	end
end

function LioncultureshapeView:_showEffect(go, func)
	local effect = UIEffectManager.instance:playEffect(self, "20230120/xingshiwenhua/fx_ui_xingshiwenhua_cg.prefab", go, 0, 0, false, false, func)

	effect:setParent(go.transform)
	effect:setLocalPos(0, 0, 0)
	effect:setScale(1)

	return effect
end

return LioncultureshapeView
