-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/suppressgame/view/game/bury/CopyBuryGameEggView.lua

module("logic.extensions.suppressgame.view.game.bury.CopyBuryGameEggView", package.seeall)

local CopyBuryGameEggView = class("CopyBuryGameEggView", ViewComponent)

function CopyBuryGameEggView:unbindEvents()
	CopyBuryGameEggView.super.unbindEvents(self)
	self._btnEgg:RemoveClickListener()
end

function CopyBuryGameEggView:bindEvents()
	CopyBuryGameEggView.super.bindEvents(self)
	self._btnEgg:AddClickListener(self._onClickEgg, self)
end

function CopyBuryGameEggView:onExit()
	CopyBuryGameEggView.super.onExit(self)
	self._multiLoader:clear()

	self._multiLoader = nil

	goutil.destroy(self._eggIns, true)
	UIEffectManager.instance:stopEffect(self._eggEffect)
	GameUtil.unloadMultiResLoaderResource(loader)

	if self._multiLoader then
		GameUtil.unloadMultiResLoaderResource(self._multiLoader)

		self._multiLoader = nil
	end
end

function CopyBuryGameEggView:buildUI()
	CopyBuryGameEggView.super.buildUI(self)

	self._bouns = self:getGo("bouns")
	self._btnEgg = self:getBtn("egg")
	self._items = self:getGo("items")
	self._txtCountDown = self:getTxt("countdown/txtTime")
	self._countdown = self:getGo("countdown")
	self._imgNum = self:getGo("egg/imgNum"):GetComponent(typeof(UIImgNumeralText))

	self._btnEgg.gameObject:SetActive(false)
	self._countdown:SetActive(true)

	self._eggPoint = self:getGo("egg/eggPoint")
end

function CopyBuryGameEggView:onEnter()
	CopyBuryGameEggView.super.onEnter(self)

	self._inGaming = false

	self._imgNum:SetText(0)
	self._bouns:SetActive(true)
	self._countdown:SetActive(false)
	settimer(2, self._startGame, self)

	local activityId = BuryGameModel.instance:getActivityId()
	local cfg = BuryGameConfig.instance:getCfgById(activityId)

	self._specialPrizePlanId = cfg.specialPrizePlan
	self._multiLoader = MultiResLoader.New()

	local url = "effect/prefabs/ui/fx_ui_yirenzhixia/yirenzhixia_dan/dan-ui_p.prefab"

	self._multiLoader:addResPath(url, true)
	self._multiLoader:load(self._onAllLoaded, self._onOneLoaded, self)
end

function CopyBuryGameEggView:_onOneLoaded(res)
	if res.IsSuccess then
		self._eggIns = goutil.clone(res:GetAsset(nil, nil))

		local trans = self._eggIns.transform

		goutil.addChildToParent(trans, self._eggPoint)
		Framework.TransformUtil.SetLocalPos(trans, 0, 0, 0)
		Framework.TransformUtil.SetLocalScale(trans, 1, 1, 1)

		self._sg = self._eggIns:GetComponentInChildren(typeof(Spine.Unity.SkeletonGraphic))
	end
end

function CopyBuryGameEggView:_startGame()
	self._inGaming = true

	self._btnEgg.gameObject:SetActive(true)
	self._countdown:SetActive(true)
	removetimer(self._startGame, self)

	self._gainedPrizeNum = 0

	self._bouns:SetActive(false)

	self._tickedTime = 0
	self._gainedPrizeDict = {}
	self._duration = checknumber(BuryGameConfig.instance:getConstantValue("t5"))

	settimer(0, self._onTicking, self)
	self:_onTicking()
end

function CopyBuryGameEggView:_onTicking()
	local deltaTime = UnityEngine.Time.deltaTime

	self._tickedTime = self._tickedTime + deltaTime

	local remainingTime = math.max(self._duration - self._tickedTime)

	self._txtCountDown.text = math.ceil(remainingTime)

	if remainingTime <= 0 then
		removetimer(self._onTicking, self)
		self:close()
		GlobalDispatcher:dispatch(GlobalNotify.BuryResumeGame, self._gainedPrizeNum)
	end
end

function CopyBuryGameEggView:_playAnimation()
	local sg = self._sg

	if sg then
		local clipName = "2"

		sg.startingAnimation = clipName

		sg.AnimationState:SetAnimation(0, clipName, false)
		sg:Update(0)
	end
end

function CopyBuryGameEggView:_onClickEgg()
	self:_playAnimation()

	if not self._inGaming then
		return
	end

	self:_playAnimation()

	local url = "fx_ui_yirenzhixia/yirenzhixia_dan/fx_ui_yirenzhixia_danda.prefab"

	self._eggEffect = UIEffectManager.instance:playEffect(self, url, self.mainGO, 0, 0, false, nil, nil, function(o, eff)
		eff:setParent(self.mainGO.transform)
		eff:setScale(1)
		eff:setPos()
	end)

	local maxNum = checknumber(BuryGameConfig.instance:getConstantValue("MAX_SPECIAL_PRIZE_COUNT"))

	self._gainedPrizeNum = Mathf.Clamp(self._gainedPrizeNum + 1, 0, maxNum)

	self._imgNum:SetText(string.format("%d", self._gainedPrizeNum))
end

return CopyBuryGameEggView
