-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jieshenevent/view/JieShenEventPlaceView.lua

module("logic.extensions.jieshenevent.view.JieShenEventPlaceView", package.seeall)

local JieShenEventPlaceView = class("JieShenEventPlaceView", ViewComponent)

function JieShenEventPlaceView:ctor()
	JieShenEventPlaceView.super.ctor(self)
end

function JieShenEventPlaceView:unbindEvents()
	JieShenEventPlaceView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function JieShenEventPlaceView:bindEvents()
	JieShenEventPlaceView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function JieShenEventPlaceView:buildUI()
	JieShenEventPlaceView.super.buildUI(self)

	self._btnClose = self:getGo("info_2/btnClose")
	self._txtDesc = self:getTxt("info_4/descTableview/viewport/content/txtDesc")
	self._petCon = self:getGo("info_3/petCon")
	self._txtName = self:getTxt("info_2/imgName/txtName")
	self._info_1 = self:getGo("info_1")
	self._canvasGroup_info_1 = self._info_1:GetComponent(ComponentType.CanvasGroup)
	self._info_2 = self:getGo("info_2")
	self._canvasGroup_info_2 = self._info_2:GetComponent(ComponentType.CanvasGroup)
	self._info_3 = self:getGo("info_3")
	self._canvasGroup_info_3 = self._info_3:GetComponent(ComponentType.CanvasGroup)
	self._info_4 = self:getGo("info_4")
	self._canvasGroup_info_4 = self._info_4:GetComponent(ComponentType.CanvasGroup)
end

function JieShenEventPlaceView:onExit()
	JieShenEventPlaceView.super.onExit(self)
	uGuiUtil.clearImage(self._petCon)
	UnityTweens.TweenSequence.StopTween(self.mainGO)
end

function JieShenEventPlaceView:onEnter()
	JieShenEventPlaceView.super.onEnter(self)

	local params = self:getOpenParam()
	local activityId = checknumber(params[1])
	local placeId = checknumber(params[2])
	local cfg = JieShenEventConfig.instance:getPlaceCfg(activityId, placeId)
	local showRaceId = cfg.raceId
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(showRaceId))

	if not modelCo then
		printError("t_model id not exist:" .. raceId)

		return
	end

	uGuiUtil.clearImage(self._petCon)
	uGuiUtil.setSpriteToImage(self._petCon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))

	self._txtDesc.text = cfg.desc
	self._txtName.text = cfg.name
	self._canvasGroup_info_2.alpha = 0
	self._canvasGroup_info_4.alpha = 0

	GameUtil.setAnchoredPos(self._info_1, 41.5, -523.5)
	GameUtil.setAnchoredPos(self._info_3, -840, 5)

	local tween1 = UnityTweens.TweenPosition.Create(self._info_1, Vector3.New(41.5, -523.5), Vector3.New(41.5, -25.5, 0), 0.5, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)
	local tween2 = UnityTweens.TweenPosition.Create(self._info_3, Vector3.New(-840, 5), Vector3.New(-295.5, 5, 0), 0.5, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)
	local tween3 = UnityTweens.UITweenFadeIn.Create(self._info_2, 0.5)
	local tween4 = UnityTweens.UITweenFadeIn.Create(self._info_4, 0.5)

	self._tween = UnityTweens.TweenSequence.StartTween(self.mainGO, tween1, tween2, tween3, tween4)
end

return JieShenEventPlaceView
