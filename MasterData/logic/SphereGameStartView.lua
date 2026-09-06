-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarycake/view/spheregame/SphereGameStartView.lua

module("logic.extensions.anniversarycake.view.spheregame.SphereGameStartView", package.seeall)

local SphereGameStartView = class("SphereGameStartView", ViewComponent)
local SliderAnim = "spheregameslideranim1"

function SphereGameStartView:ctor()
	SphereGameStartView.super.buildUI(self)

	self._recycleWorldGoList = {}
	self._recyclePlayerGoList = {}
	self._worldItemList = {}
	self._playerItemList = {}
end

function SphereGameStartView:buildUI()
	SphereGameStartView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnStart = self:getBtn("btnStart")
	self._btnTip = self:getBtn("btnTip")
	self._recycleGo = self:getGo("recycle")
	self._bg = self:getGo("bg")
	self._btnMake = self:getBtn("pageBtns/btnMake")
	self._btnEat = self:getBtn("pageBtns/btnEat")
	self._imgBtnMake = self:getGo("pageBtns/btnMake/img")
	self._imgBtnEat = self:getGo("pageBtns/btnEat/img")
	self._txtTime = self:getTxt("time/txtTime")

	local pathPrefix = "worldPrize/prize/progressPrize/viewport/"

	self._worldSlider = self:getSlider(pathPrefix .. "content/progBar")
	self._worldContentRectTrans = self:getGo(pathPrefix .. "content"):GetComponent(goutil.Type_RectTransform)
	self._worldcell = self:getGo("worldPrize/prize/worldcell")
	self._txtWorldScore = self:getTxt("worldPrize/prize/score/txtScore")
	self._progressPrizeTrans = self:getGo("worldPrize/prize/progressPrize"):GetComponent(goutil.Type_RectTransform)
	self._worldPrizeRectTrans = self:getGo("worldPrize"):GetComponent(goutil.Type_RectTransform)
	self._worldEffectRange = self:getGo("worldEffectRange"):GetComponent(goutil.Type_RectTransform)
	self._btnWorld = self:getBtn("worldPrize/btnWorld")
	self._worldArrow = self:getGo("worldPrize/btnWorld/arrow")
	self._effectBtnWorld = self:getGo("worldPrize/btnWorld/effect")
	self._worldRedPoint = self:getGo("worldPrize/btnWorld/redPoint")

	goutil.setActive(self._worldcell, false)

	self._worldSliderRectTrans = self._worldSlider.gameObject:GetComponent(goutil.Type_RectTransform)

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._worldSliderRectTrans, 0, 0)

	self._worldSliderStartOffset = y
	self._worldSliderEndOffset = 50
	self._worldWidthSpace = 150
	self._playerSlider = self:getSlider("playerReward/tableview/viewport/content/progressSlider")
	self._playerContentRectTrans = self:getGo("playerReward/tableview/viewport/content"):GetComponent(goutil.Type_RectTransform)
	self._playercell = self:getGo("playerReward/playercell")
	self._txtPlayerScore = self:getTxt("playerReward/txtPlayerScore")
	self._playerScrollRectTrans = self:getGo("playerReward/tableview"):GetComponent(goutil.Type_RectTransform)
	self._playerScrollRect = self._playerScrollRectTrans.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._sliderMask = self:getGo("playerslidermask")

	goutil.setActive(self._playercell, false)

	self._playerSliderRectTrans = self._playerSlider.gameObject:GetComponent(goutil.Type_RectTransform)

	local px, py = Framework.TransformUtil.GetAnchoredPos(self._playerSliderRectTrans, 0, 0)

	self._playerSliderStartOffset = py
	self._playerSliderEndOffset = 50
	self._playerWidthSpace = 150
	self._txtSpecial = self:getTxt("special/txt")
	self._itemSpecial = self:getGo("special/item")
	self._txtNum = self:getTxt("txtNum")
end

function SphereGameStartView:bindEvents()
	SphereGameStartView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnTip:AddClickListener(self._onClickTip, self)
	self._btnWorld:AddClickListener(self._onClickWorld, self)
	self._btnMake:AddClickListener(self._onClickMake, self)
	self._btnEat:AddClickListener(self._onClickEat, self)
end

function SphereGameStartView:unbindEvents()
	SphereGameStartView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnWorld:RemoveClickListener()
	self._btnMake:RemoveClickListener()
	self._btnEat:RemoveClickListener()
end

function SphereGameStartView:onEnter()
	SphereGameStartView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ACGetMakeCakeInfoRes, self._onGetMakeCakeInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ACGainMakeCakeWorldPrizeRes, self._onGainMakeCakeWorldPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ACGainMakeCakePersonalPrizeRes, self._onGainMakeCakePersonalPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ACGetEatCakeInfoRes, self.onGetEatCakeInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ACGainEatCakePrizeRes, self.onGainEatCakePrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.ACGainEatCakeWorldPrizeRes, self.onGainEatCakeWorldPrizeRes, self)

	self._curPage = checknumber(self:getFirstParam())
	self._curCakeMo = self:_getCakeMo()
	self._activityId = MakeCakeModel.instance:getActivityId()

	local isInTime = ActivityDefineController.instance:isInActivityTimeById(GameEnum.ActivityType.AnniversaryCake, self._activityId)

	if not isInTime then
		self:_showCloseTip()

		return
	end

	self:_changeTab(self._curPage)
	self:_initWorldState()
	self:_initSliderAnimInfo()
	self:_playSliderAnimation()
	self:_loadSideBarEffect()
	self:_initActivityTime()
end

function SphereGameStartView:onExit()
	SphereGameStartView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ACGetMakeCakeInfoRes, self._onGetMakeCakeInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ACGainMakeCakeWorldPrizeRes, self._onGainMakeCakeWorldPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ACGainMakeCakePersonalPrizeRes, self._onGainMakeCakePersonalPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ACGetEatCakeInfoRes, self.onGetEatCakeInfoRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ACGainEatCakePrizeRes, self.onGainEatCakePrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.ACGainEatCakeWorldPrizeRes, self.onGainEatCakeWorldPrizeRes, self)
	self:_clearReward()
	self:_removeTween()
	self:_resetCakeMo()
	self:_clearBg()
	self:_removeEffect()
	self:_removeSideBarEffect()
end

function SphereGameStartView:_onClickClose()
	self:close()
end

function SphereGameStartView:_onClickStart()
	local curLeftCount = self._curCakeMo:getCurLeftGameCount()

	if curLeftCount > 0 then
		UIStateManager.instance:updateParms(ViewName.SphereGameStartView, {
			self._curPage
		})
		self._curCakeMo:openGame()
	else
		FloatWordMgr.instance:show("已经没有游戏次数了")
	end
end

function SphereGameStartView:_onClickTip()
	UIStateManager.instance:open(ViewName.RulesView, "ANNIVERSARYCAKE")
end

function SphereGameStartView:_onClickWorld()
	self:_changeWorldState()
end

function SphereGameStartView:_onClickMake()
	if self._curPage == 0 then
		return
	end

	self:_changeTab(0)
end

function SphereGameStartView:_onClickEat()
	if self._curPage == 1 then
		return
	end

	self:_changeTab(1)
end

function SphereGameStartView:_onGetMakeCakeInfoRes()
	self:_updateWorldReward()
	self:_updatePlayerReward()
	self:_updateGameCount()
end

function SphereGameStartView:_onGainMakeCakeWorldPrizeRes()
	self:_updateWorldReward()
end

function SphereGameStartView:_onGainMakeCakePersonalPrizeRes()
	self:_updatePlayerReward()
end

function SphereGameStartView:onGetEatCakeInfoRes()
	self:_updateWorldReward()
	self:_updatePlayerReward()
	self:_updateGameCount()
end

function SphereGameStartView:onGainEatCakePrizeRes()
	self:_updatePlayerReward()
end

function SphereGameStartView:onGainEatCakeWorldPrizeRes()
	self:_updateWorldReward()
end

function SphereGameStartView:_isCanOpen(pageIndex)
	if pageIndex == 1 then
		local timestamp = GameUtil.string2time(MakeCakeModel.instance:getEatCakeStartTime())

		return timestamp <= ServerTime.now()
	end

	return true
end

function SphereGameStartView:_changeTab(pageIndex)
	if not self:_isCanOpen(pageIndex) then
		FloatWordMgr.instance:show("该玩法将于4月15号05：00开启")

		self._curPage = 0
	else
		self._curPage = pageIndex
	end

	self._curCakeMo = self:_getCakeMo()

	if self._curPage == 0 then
		goutil.setActive(self._imgBtnMake, true)
		goutil.setActive(self._imgBtnEat, false)
	else
		goutil.setActive(self._imgBtnMake, false)
		goutil.setActive(self._imgBtnEat, true)
	end

	self:_setPage()
end

function SphereGameStartView:_setPage()
	self:_clearReward()
	self:_initWorldReward()
	self:_initPlayerReward()
	self:_showSpecialReward()
	self:_updateGameCount()
	self:_loadBg()
	self:_loadEffect()
	self:_updateWorldRedPoint()

	if self._curCakeMo:isCanSendReq() then
		self._curCakeMo:sendGetInfoReq(self._activityId)
	end
end

function SphereGameStartView:_loadBg()
	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, self._curCakeMo:getBgPath())
end

function SphereGameStartView:_clearBg()
	uGuiUtil.clearImage(self._bg)
end

function SphereGameStartView:_resetCakeMo()
	if self._cakeMo then
		self._cakeMo:reset()
	end

	if self._eatMo then
		self._eatMo:reset()
	end
end

function SphereGameStartView:_getCakeMo()
	self._cakeMo = self._cakeMo or MakeCakeMo.New()
	self._eatMo = self._eatMo or EatCakeMo.New()

	if self._curPage == 0 then
		return self._cakeMo
	else
		return self._eatMo
	end
end

function SphereGameStartView:_clearReward()
	for i, v in ipairs(self._worldItemList) do
		self:_recycleWorldRewardGo(v:getGo())
		v:clear()
	end

	for i, v in ipairs(self._playerItemList) do
		self:_recyclePlayerRewardGo(v:getGo())
		v:clear()
	end

	table.clear(self._worldItemList)
	table.clear(self._playerItemList)
end

function SphereGameStartView:_getWorldRewardGo()
	local count = #self._recycleWorldGoList

	if count > 0 then
		local go = table.remove(self._recycleWorldGoList, count)

		goutil.setActive(go, true)

		return go
	else
		local go = goutil.cloneAndSetParent(self._worldcell, self._recycleGo.transform, "worldcell")

		goutil.setActive(go, true)

		return go
	end
end

function SphereGameStartView:_recycleWorldRewardGo(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		goutil.addChildToParent(go, self._recycleGo)
		table.insert(self._recycleWorldGoList, go)
	end
end

function SphereGameStartView:_getPlayerRewardGo()
	local count = #self._recyclePlayerGoList

	if count > 0 then
		local go = table.remove(self._recyclePlayerGoList, count)

		goutil.setActive(go, true)

		return go
	else
		local go = goutil.cloneAndSetParent(self._playercell, self._recycleGo.transform, "worldcell")

		goutil.setActive(go, true)

		return go
	end
end

function SphereGameStartView:_recyclePlayerRewardGo(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		goutil.addChildToParent(go, self._recycleGo)
		table.insert(self._recyclePlayerGoList, go)
	end
end

function SphereGameStartView:_setWorldScore()
	self._txtWorldScore.text = string.format(lang("makecake_tip1"), self._curCakeMo:getWorldProgress())

	local curScore = self._curCakeMo:getWorldProgress()
	local cfgs = MakeCakeConfig.instance:getPrizeCfgList(self._curCakeMo:getWorldPrizePlanId())
	local count = #cfgs
	local unitNum = 1 / count
	local weightPercent = 0

	for i, v in ipairs(cfgs) do
		if curScore <= v.needScore then
			if i == 1 then
				weightPercent = unitNum * (i - 1) + unitNum * (curScore / v.needScore)
			else
				weightPercent = unitNum * (i - 1) + unitNum * ((curScore - cfgs[i - 1].needScore) / (v.needScore - cfgs[i - 1].needScore))

				break
			end
		elseif i == count then
			weightPercent = 1
		end
	end

	local progress = Mathf.Clamp(weightPercent, 0, 1)

	self._worldSlider:SetValue(progress)
end

function SphereGameStartView:_initWorldReward()
	table.clear(self._worldItemList)

	local cfgs = MakeCakeConfig.instance:getPrizeCfgList(self._curCakeMo:getWorldPrizePlanId())
	local count = #cfgs

	self:_setWorldContentLength(count)

	local posX = 126
	local posY = self._worldSliderStartOffset

	for i, v in ipairs(cfgs) do
		posY = posY + self._worldWidthSpace

		local go = self:_getWorldRewardGo()

		go.name = "worldcell" .. i

		goutil.addChildToParent(go, self._worldContentRectTrans.transform)
		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, posY)

		local cls = GameUtil.AddLuaOnce(go, SGWorldCell)

		cls:init(v, self, self._worldEffectRange, self._curCakeMo)
		table.insert(self._worldItemList, cls)
	end

	self:_setWorldScore()
end

function SphereGameStartView:_updateWorldReward()
	for i, v in ipairs(self._worldItemList) do
		v:update()
	end

	self:_setWorldScore()
	self:_updateWorldRedPoint()
end

function SphereGameStartView:_setWorldContentLength(rewardCount)
	local sliderLength = rewardCount * self._worldWidthSpace
	local contentTotalLength = self._worldSliderStartOffset + sliderLength + self._worldSliderEndOffset

	goutil.setHeight(self._worldContentRectTrans, contentTotalLength)
	goutil.setWidth(self._worldSliderRectTrans, sliderLength)
end

function SphereGameStartView:_setPlayerContentLength(rewardCount)
	local sliderLength = rewardCount * self._playerWidthSpace
	local contentTotalLength = self._playerSliderStartOffset + sliderLength + self._playerSliderEndOffset

	goutil.setWidth(self._playerContentRectTrans, contentTotalLength)
	goutil.setWidth(self._playerSliderRectTrans, sliderLength)
end

function SphereGameStartView:_setPlayerScore()
	self._txtPlayerScore.text = string.format(self._curPage == 0 and lang("makecake_tip2") or "当前积分：<color=#FFFCFEFF>%d</color>", self._curCakeMo:getPersonalScore())

	local curScore = self._curCakeMo:getPersonalScore()
	local cfgs = MakeCakeConfig.instance:getPrizeCfgList(self._curCakeMo:getPlayerPrizePlanId())
	local count = #cfgs
	local unitNum = 1 / count
	local weightPercent = 0

	for i, v in ipairs(cfgs) do
		if curScore <= v.needScore then
			if i == 1 then
				weightPercent = unitNum * (i - 1) + unitNum * (curScore / v.needScore)

				break
			end

			weightPercent = unitNum * (i - 1) + unitNum * ((curScore - cfgs[i - 1].needScore) / (v.needScore - cfgs[i - 1].needScore))

			break
		elseif i == count then
			weightPercent = 1
		end
	end

	local progress = Mathf.Clamp(weightPercent, 0, 1)

	self._playerSlider:SetValue(progress)
end

function SphereGameStartView:_initPlayerReward()
	table.clear(self._playerItemList)

	local cfgs = MakeCakeConfig.instance:getPrizeCfgList(self._curCakeMo:getPlayerPrizePlanId())
	local count = #cfgs

	self:_setPlayerContentLength(count)

	local posY = 5
	local posX = self._playerSliderStartOffset

	for i, v in ipairs(cfgs) do
		posX = posX + self._playerWidthSpace

		local go = self:_getPlayerRewardGo()

		go.name = "playercell" .. i

		goutil.addChildToParent(go, self._playerContentRectTrans.transform)
		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, posY)

		local cls = GameUtil.AddLuaOnce(go, SGPlayerCell)

		cls:init(v, self, self._playerScrollRectTrans, self._curCakeMo)
		table.insert(self._playerItemList, cls)
	end

	self:_setPlayerScore()
end

function SphereGameStartView:_updatePlayerReward()
	for i, v in ipairs(self._playerItemList) do
		v:update()
	end

	self:_setPlayerScore()
end

function SphereGameStartView:_initSliderAnimInfo()
	local isPlayed = GameUtil.getUserData(SliderAnim)

	self._isPlaySliderAnim = not isPlayed

	goutil.setActive(self._sliderMask, not isPlayed)
end

function SphereGameStartView:_playSliderAnimation()
	if not self._isPlaySliderAnim then
		return
	end

	local function onComplete()
		goutil.setActive(self._sliderMask, false)
	end

	GameUtil.saveUserData(SliderAnim, true)

	self._sequence = GameUtil.playSliderAnimation(self._playerScrollRect, onComplete)
end

function SphereGameStartView:_removeTween()
	if self._sequence then
		self._sequence:Kill(false)

		self._sequence = nil
	end
end

function SphereGameStartView:_initWorldState()
	self._isOpen = false

	self:_clearWorldTween()
	Framework.TransformUtil.SetAnchoredPos(self._worldPrizeRectTrans, 182, 60)
	Framework.TransformUtil.SetLocalRotation(self._worldArrow.transform, 0, 0, 0)
end

function SphereGameStartView:_changeWorldState()
	self:_clearWorldTween()

	if self._isOpen then
		self._isOpen = false

		local targetPos = Vector2.New(182, 60)

		self._worldTween = self._worldPrizeRectTrans:DOAnchorPos(targetPos, 0.2)

		Framework.TransformUtil.SetLocalRotation(self._worldArrow.transform, 0, 0, 0)
	else
		self._isOpen = true

		local targetPos = Vector2.New(-22, 60)

		self._worldTween = self._worldPrizeRectTrans:DOAnchorPos(targetPos, 0.2)

		Framework.TransformUtil.SetLocalRotation(self._worldArrow.transform, 0, 0, 180)
	end
end

function SphereGameStartView:_clearWorldTween()
	if self._worldTween then
		self._worldTween:Kill()
	end
end

function SphereGameStartView:_showSpecialReward()
	local desc = self._curCakeMo:getSpecialDesc()
	local prize = self._curCakeMo:getSpecialReward()

	MaterialMgr.setCellByCfg(prize, self._itemSpecial)

	self._txtSpecial.text = desc
end

function SphereGameStartView:_clearSpecialReward()
	MaterialMgr.resetAll(self._itemSpecial)
end

function SphereGameStartView:_updateGameCount()
	local curLeftCount = self._curCakeMo:getCurLeftGameCount()

	self._txtNum.text = string.format(lang("makecake_tip3"), curLeftCount)
end

function SphereGameStartView:_showCloseTip()
	local title = lang("tip")
	local text = lang("outtime")

	local function func()
		self:_onClickClose()
	end

	TipsFacade.instance:openTipWindowNoX(title, text, func, btnText)
end

function SphereGameStartView:_loadEffect()
	self:_removeEffect()

	if self._curPage == 0 then
		if not SphereGameStartViewPresentor.EffectPath1 then
			local path = SphereGameStartViewPresentor.EffectPath2
			local uiEffect = UIEffectManager.instance:playEffect(self, path, self._bg.transform, 0, 0, true, false)

			uiEffect:setParent(self._bg.transform)
			uiEffect:setScale(1)
			uiEffect:setLocalPos(0, 0, 0)

			self._bgEffect = uiEffect
		end
	end
end

function SphereGameStartView:_removeEffect()
	if self._bgEffect then
		UIEffectManager.instance:stopEffect(self._bgEffect)

		self._bgEffect = nil
	end
end

function SphereGameStartView:_loadSideBarEffect()
	self:_removeSideBarEffect()

	local path = SphereGameStartViewPresentor.EffectPath3
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._effectBtnWorld.transform, 0, 0, true, false)

	uiEffect:setParent(self._effectBtnWorld.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 0, 0)

	self._sideBarEffect = uiEffect
end

function SphereGameStartView:_removeSideBarEffect()
	if self._sideBarEffect then
		UIEffectManager.instance:stopEffect(self._sideBarEffect)

		self._sideBarEffect = nil
	end
end

function SphereGameStartView:_updateWorldRedPoint()
	goutil.setActive(self._worldRedPoint, self._curPage == 0 and MakeCakeModel.instance:isAllMakeCakeWorldPrizeCanGet() or MakeCakeModel.instance:isAllEatCakeWorldPrizeCanGet())
end

function SphereGameStartView:_initActivityTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.AnniversaryCake, self._activityId)

	self._txtTime.text = string.format("%s：%s", lang("activitytime"), GameUtil.getTimeTxt(startTime, endTime, GameEnum.TimeTxt.CN_M_D_H))
end

return SphereGameStartView
