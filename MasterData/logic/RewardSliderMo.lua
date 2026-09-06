-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/luckyskinlottery/view/RewardSliderMo.lua

module("logic.extensions.luckyskinlottery.view.RewardSliderMo", package.seeall)

local RewardSliderMo = class("RewardSliderMo", WorldSliderMo)

function RewardSliderMo:ctor(rootGo)
	RewardSliderMo.super.ctor(self, rootGo)

	self._worldWidthSpace = 100
end

function RewardSliderMo:_initWorldReward()
	table.clear(self._worldItemList)

	local cfgs = self._prizeCfgs
	local count = #cfgs
	local totalContentLength = self:_setWorldContentLength(count)
	local posX = 87
	local posY = self._worldSliderStartOffset

	for i, v in ipairs(cfgs) do
		posY = posY + self._worldWidthSpace

		local go = self:_getWorldRewardGo()
		local item_1 = goutil.findChild(go, "item_1")
		local item_2 = goutil.findChild(go, "item_2")
		local txtScroe = goutil.findChildTextComponent(go, "txtScore")

		go.name = "worldcell" .. i

		goutil.addChildToParent(go, self._worldContentRectTrans.transform)
		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, posY)

		local clsItem_1 = GameUtil.AddLuaOnce(item_1, RewardSliderCell)
		local clsItem_2 = GameUtil.AddLuaOnce(item_2, RewardSliderCell)
		local callbackParams = self:_setParams(posY, totalContentLength, self._getPrizeByRewardCfg(v)[1], v.bigReardShowRate, v)
		local callbackParams2 = self:_setParams(posY, totalContentLength, self._getPrizeByRewardCfg(v)[2], v.normalReardShowRate, v)

		clsItem_1:init(v, self._view, self._worldEffectRange, callbackParams, true)
		clsItem_2:init(v, self._view, self._worldEffectRange, callbackParams2, false)
		table.insert(self._worldItemList, clsItem_1)
		table.insert(self._worldItemList, clsItem_2)

		txtScroe.text = self._getNeedScoreByRewardCfg(v)
	end

	self:_setWorldScore()
end

function RewardSliderMo:_setParams(posY, totalContentLength, prize, rate, v)
	local callbackParams = {}

	callbackParams.isWorldRewardCanGet = self._isWorldRewardCanGet
	callbackParams.isWorldRewardGeted = self._isWorldRewardGeted
	callbackParams.sendGainWorldPrizeReq = self._sendGainWorldPrizeReq
	callbackParams.normalizedPos = self:_caculateNormalizedPosition(posY, totalContentLength, goutil.getHeight(self._progressPrizeTrans))
	callbackParams.prize = prize
	callbackParams.rate = rate
	callbackParams.progress = self._getNeedScoreByRewardCfg(v)

	return callbackParams
end

function RewardSliderMo:_setWorldScore()
	self._txtWorldScore.text = self._getPrizeText and self._getPrizeText() or string.format("当前能量:\n<color=#F8D200FF>%d</color>", self._getWorldProgress())

	local curScore = self._getWorldProgress()
	local cfgs = self._prizeCfgs
	local count = #cfgs
	local unitNum = 1 / count
	local weightPercent = 0

	for i, v in ipairs(cfgs) do
		if curScore <= self._getNeedScoreByRewardCfg(v) then
			if i == 1 then
				do
					local value = self._getNeedScoreByRewardCfg(v)

					if value == 0 then
						weightPercent = unitNum * i

						break
					end

					weightPercent = unitNum * (i - 1) + unitNum * (curScore / value)
				end

				break
			end

			do
				local curValue = curScore - self._getNeedScoreByRewardCfg(cfgs[i - 1])
				local wholeValue = self._getNeedScoreByRewardCfg(v) - self._getNeedScoreByRewardCfg(cfgs[i - 1])

				if wholeValue == 0 then
					weightPercent = unitNum * i

					break
				end

				weightPercent = unitNum * (i - 1) + unitNum * (curValue / wholeValue)
			end

			break
		elseif i == count then
			weightPercent = 1
		end
	end

	local progress = Mathf.Clamp(weightPercent, 0, 1)

	self._worldSlider:SetValue(progress)
end

function RewardSliderMo:_clearReward()
	for i, v in ipairs(self._worldItemList) do
		self:_recycleWorldRewardGo(v:getGo().transform.parent.gameObject)
		v:clear()
	end

	table.clear(self._worldItemList)
end

function RewardSliderMo:_recycleWorldRewardGo(go)
	if not goutil.isNil(go) and go.activeSelf then
		goutil.setActive(go, false)
		goutil.addChildToParent(go, self._recycleGo)
		table.insert(self._recycleWorldGoList, go)
	end
end

return RewardSliderMo
