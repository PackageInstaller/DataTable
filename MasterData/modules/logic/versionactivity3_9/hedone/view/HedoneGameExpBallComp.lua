-- chunkname: @modules/logic/versionactivity3_9/hedone/view/HedoneGameExpBallComp.lua

module("modules.logic.versionactivity3_9.hedone.view.HedoneGameExpBallComp", package.seeall)

local HedoneGameExpBallComp = class("HedoneGameExpBallComp", LuaCompBase)

function HedoneGameExpBallComp:ctor(params)
	if params then
		self._endX = params.endX or 0
	end

	if params then
		self._endY = params.endY or 0
	end

	self._endScale = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.ExpBallEndScale, false, true) or 0
end

function HedoneGameExpBallComp:init(go)
	self.viewGO = go
	self._trans = self.viewGO.transform
	self._goExpBallItem = gohelper.findChild(go, "#go_exp")
	self._expBallItemPool = {}
	self._usingExpBallItemDict = {}
end

function HedoneGameExpBallComp:addExpBall(exp, x, y)
	if not exp or exp <= 0 then
		return
	end

	local expBallItem = self:_getExpBallItem()

	if not expBallItem then
		return
	end

	local ballSize = 1
	local startX = tonumber(x) or 0
	local startY = tonumber(y) or 0

	transformhelper.setLocalPosXY(expBallItem.trans, startX, startY)

	expBallItem.exp = tonumber(exp) or 0
	expBallItem.startX = startX
	expBallItem.startY = startY

	local expBallSizeList = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.ExpBallSize, false, true, "#")

	for i = 1, #expBallSizeList do
		if expBallItem.exp < expBallSizeList[i] then
			break
		end

		ballSize = i
	end

	local name = string.format("v3a9_hedone_expball_%s", ballSize)

	UISpriteSetMgr.instance:setV3a9HedoneSprite(expBallItem.icon, name, true)
	expBallItem.idleAnim:Rewind()
	expBallItem.idleAnim:Play()

	expBallItem.canvasGroup.alpha = 1
	self._usingExpBallItemDict[expBallItem] = true

	AudioMgr.instance:trigger(AudioEnum3_9.Hedone.play_ui_heduonie3_9_ballfall)
end

function HedoneGameExpBallComp:_getExpBallItem()
	if #self._expBallItemPool > 0 then
		return table.remove(self._expBallItemPool)
	end

	local go = gohelper.cloneInPlace(self._goExpBallItem, "expBallItem")

	if gohelper.isNil(go) then
		return
	end

	local expBallItem = self:getUserDataTb_()

	expBallItem.go = go
	expBallItem.trans = go.transform
	expBallItem.icon = gohelper.findChildImage(go, "#image_icon")
	expBallItem.canvasGroup = gohelper.onceAddComponent(go, gohelper.Type_CanvasGroup)
	expBallItem.idleAnim = expBallItem.icon:GetComponent(typeof(UnityEngine.Animation))

	expBallItem.idleAnim:Stop()

	expBallItem.animEventWrap = expBallItem.icon:GetComponent(typeof(ZProj.AnimationEventWrap))

	expBallItem.animEventWrap:AddEventListener("beginFly", self._onExpBallBeginFly, {
		self = self,
		expBallItem = expBallItem
	})

	return expBallItem
end

function HedoneGameExpBallComp._onExpBallBeginFly(params)
	local self = params and params.self
	local expBallItem = params and params.expBallItem

	if not self or not expBallItem then
		return
	end

	if expBallItem.tweenId then
		ZProj.TweenHelper.KillById(expBallItem.tweenId)

		expBallItem.tweenId = nil
	end

	if not self._endX or not self._endY then
		self:_onExpBallTweenFinish(expBallItem)
	else
		local flyTime = HedoneConfig.instance:getHedoneConst(HedoneEnum.ConstId.ExpBallFlyTime, false, true)

		expBallItem.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, flyTime, self._onExpBallTween, self._onExpBallTweenFinish, self, expBallItem)
	end

	AudioMgr.instance:trigger(AudioEnum3_9.Hedone.play_ui_heduonie3_9_ballfly)
end

function HedoneGameExpBallComp:_onExpBallTween(value, expBallItem)
	if not expBallItem then
		return
	end

	local x = expBallItem.startX + (self._endX - expBallItem.startX) * value
	local y = expBallItem.startY + (self._endY - expBallItem.startY) * value

	transformhelper.setLocalPosXY(expBallItem.trans, x, y)

	local startScale = 1
	local scale = startScale + (self._endScale - startScale) * value

	transformhelper.setLocalScale(expBallItem.trans, scale, scale, 1)
end

function HedoneGameExpBallComp:_onExpBallTweenFinish(expBallItem)
	HedoneGameController.instance:playerAddExp((expBallItem or nil) and (expBallItem.exp or 0))
	self:_recycleExpBallItem(expBallItem)
end

function HedoneGameExpBallComp:_recycleExpBallItem(expBallItem)
	if not expBallItem or not self._usingExpBallItemDict[expBallItem] then
		return
	end

	if expBallItem.tweenId then
		ZProj.TweenHelper.KillById(expBallItem.tweenId)

		expBallItem.tweenId = nil
	end

	expBallItem.canvasGroup.alpha = 0

	transformhelper.setLocalScale(expBallItem.trans, 1, 1, 1)

	self._usingExpBallItemDict[expBallItem] = nil
	self._expBallItemPool[#self._expBallItemPool + 1] = expBallItem
end

function HedoneGameExpBallComp:recycleAllExpBallItem()
	for floatItem, _ in pairs(self._usingExpBallItemDict) do
		self:_recycleExpBallItem(floatItem)
	end
end

function HedoneGameExpBallComp:onDestroy()
	self:recycleAllExpBallItem()
end

return HedoneGameExpBallComp
