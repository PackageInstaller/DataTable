-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeelpetinfoView.lua

module("logic.extensions.goodfeel.view.GoodfeelpetinfoView", package.seeall)

local GoodfeelpetinfoView = class("GoodfeelpetinfoView", ViewComponent)

function GoodfeelpetinfoView:ctor()
	GoodfeelpetinfoView.super.ctor(self)
end

function GoodfeelpetinfoView:buildUI()
	GoodfeelpetinfoView.super.buildUI(self)

	local root = self:getGo("mask/root")

	self._rootTween = root:GetComponent(UnityTweensType.TweenPosition)
	self._nameText = goutil.findChildTextComponent(root, "nameText")
	self._descText = goutil.findChildTextComponent(root, "descScorll/descText")
	self._shengaoText = goutil.findChildTextComponent(root, "shengaoText")
	self._tizhongText = goutil.findChildTextComponent(root, "tizhongText")
	self._aihaoText = goutil.findChildTextComponent(root, "aihaoText")
	self._xinggeText = goutil.findChildTextComponent(root, "xinggeText")
	self._xingzuoText = goutil.findChildTextComponent(root, "xingzuoText")
	self._cvText = goutil.findChildTextComponent(root, "cvText")
	self._shengriText = goutil.findChildTextComponent(root, "shengriText")
end

function GoodfeelpetinfoView:bindEvents()
	GoodfeelpetinfoView.super.bindEvents(self)
end

function GoodfeelpetinfoView:unbindEvents()
	GoodfeelpetinfoView.super.unbindEvents(self)
end

function GoodfeelpetinfoView:destroyUI()
	GoodfeelpetinfoView.super.destroyUI(self)
end

function GoodfeelpetinfoView:onEnter()
	GoodfeelpetinfoView.super.onEnter(self)
	GlobalDispatcher:addListener(GoodFeelModel.ChangePetShow, self._onChangePetShow, self)
	self:_updateView()
	self:_doMove()
end

function GoodfeelpetinfoView:onEnterFinished()
	GoodfeelpetinfoView.super.onEnterFinished(self)
end

function GoodfeelpetinfoView:onExit()
	GoodfeelpetinfoView.super.onExit(self)
	self._rootTween:Stop()
	GlobalDispatcher:removeListener(GoodFeelModel.ChangePetShow, self._onChangePetShow, self)
end

function GoodfeelpetinfoView:onExitFinished()
	GoodfeelpetinfoView.super.onExitFinished(self)
end

function GoodfeelpetinfoView:_updateView()
	self._raceId, self._skinId = GoodFeelModel.instance:getPetShowViewCurrRaceId()

	local cfg = HandbookConfig.instance:getPetDetailsCfgById(self._raceId)

	if cfg then
		local co = CharacterConfig.instance:getPetCo(self._raceId)
		local cvName = PetSkinConfig.instance:getSkinCvName(self._raceId)
		local name = PetSkinConfig.instance:getPetSkinName(self._skinId)
		local infoCo = CharacterConfig.instance:getPetInfoCo(self._raceId)

		self._nameText.text = name or "未知"
		self._cvText.text = cvName or "未知"
		self._shengaoText.text = cfg.height
		self._tizhongText.text = cfg.weight
		self._aihaoText.text = cfg.hobby
		self._xingzuoText.text = cfg.sign
		self._xinggeText.text = cfg.character

		if infoCo then
			self._descText.text = infoCo.introduce or "未知"
		end

		self._descText.transform.sizeDelta = Vector2.New(332, self._descText.preferredHeight)
		self._shengriText.text = cfg.birthday

		local month, day

		for k, v in string.gmatch(cfg.birthday, "(%d+)") do
			if month == nil then
				month = k
			elseif day == nil then
				day = k
			end
		end

		self._xingzuoText.text = month and day and GameUtil.getAstro(month, day) or "?"
	end
end

function GoodfeelpetinfoView:_onChangePetShow()
	self:_updateView()
end

function GoodfeelpetinfoView:_doMove()
	local isFromGift = self:getFirstParam()

	if isFromGift then
		self._rootTween:Begin()
	else
		GameUtil.setAnchoredPos(self._rootTween.gameObject, self._rootTween.to.x, self._rootTween.to.y)
	end
end

return GoodfeelpetinfoView
