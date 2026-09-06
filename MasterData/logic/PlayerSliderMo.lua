-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/PlayerSliderMo.lua

module("logic.extensions.helpdragonmom.view.PlayerSliderMo", package.seeall)

local PlayerSliderMo = class("PlayerSliderMo")

function PlayerSliderMo:ctor(rootGo)
	self.mainGO = rootGo
	self._recycleGo = goutil.findChild(self.mainGO, "recycle")
	self._playerSlider = Framework.SliderAdapter.GetFrom(self.mainGO, "tableview/viewport/content/progressSlider")

	self._playerSlider:SetValue(0)

	self._playerContentRectTrans = goutil.findChild(self.mainGO, "tableview/viewport/content"):GetComponent(goutil.Type_RectTransform)
	self._playercell = goutil.findChild(self.mainGO, "playercell")
	self._playerScrollRectTrans = goutil.findChild(self.mainGO, "tableview"):GetComponent(goutil.Type_RectTransform)
	self._playerScrollRect = self._playerScrollRectTrans.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._sliderMask = goutil.findChild(self.mainGO, "playerslidermask")

	goutil.setActive(self._playercell, false)
	goutil.setActive(self._sliderMask, false)

	self._playerSliderRectTrans = self._playerSlider.gameObject:GetComponent(goutil.Type_RectTransform)

	local px, py = Framework.TransformUtil.GetAnchoredPos(self._playerSliderRectTrans, 0, 0)

	self._playerSliderStartOffset = px
	self._playerSliderEndOffset = 50
	self._playerWidthSpace = 150
	self._recyclePlayerGoList = {}
	self._playerItemList = {}
end

function PlayerSliderMo:onEnter()
	self:_playSliderAnimation()
	self:_clearReward()
	self:_initPlayerReward()
end

function PlayerSliderMo:onExit()
	self:_clearReward()
end

function PlayerSliderMo:initParam(param, isSkipSliderAnimation)
	self._view = param.view
	self._prizeCfgs = param.prizeCfgs
	self._getPlayerProgress = param.getPlayerProgress
	self._getNeedScoreByRewardCfg = param.getNeedScoreByRewardCfg
	self._getPrizeByRewardCfg = param.getPrizeByRewardCfg
	self._isPlayerRewardCanGet = param.isPlayerRewardCanGet
	self._isPlayerRewardGeted = param.isPlayerRewardGeted
	self._sendGainPlayerPrizeReq = param.sendGainPlayerPrizeReq
	self._playerSliderCellClass = param.playerSliderCellClass or PlayerSliderCell
	self._bHideCellBg = param.bHideCellBg

	if param.playerSliderEndOffset ~= nil then
		self._playerSliderEndOffset = checknumber(param.playerSliderEndOffset)
	end

	if param.playerWidthSpace ~= nil then
		self._playerWidthSpace = checknumber(param.playerWidthSpace)
	end

	self._isSkipSliderAnimation = isSkipSliderAnimation or param.isSkipSliderAnimation
	self._getRewardTip = param.getRewardTip
	self._parseGetProgress = param.parseGetProgress
	self._initCellFunc = param.initCellFunc
	self._updateCellFunc = param.updateCellFunc
	self._effPath = param.effPath
end

function PlayerSliderMo:initSlider()
	self:onEnter()
	self:updatePlayerReward()
	self:relocation()
end

function PlayerSliderMo:_playSliderAnimation()
	if self._isSkipSliderAnimation then
		return
	end

	local name = "playerslider" .. self._view.__cname

	printInfo("test 播放玩家进度条name = ", name)

	local isPlayed = GameUtil.getUserData(name)

	self._isPlaySliderAnim = not isPlayed

	goutil.setActive(self._sliderMask, not isPlayed)

	if not self._isPlaySliderAnim then
		return
	end

	local function onComplete()
		goutil.setActive(self._sliderMask, false)
	end

	GameUtil.saveUserData(name, true)

	self._sequence = GameUtil.playSliderAnimation(self._playerScrollRect, onComplete)
end

function PlayerSliderMo:_clearReward()
	for i, v in ipairs(self._playerItemList) do
		self:_recyclePlayerRewardGo(v:getGo())
		v:clear()
	end

	table.clear(self._playerItemList)
end

function PlayerSliderMo:_initPlayerReward()
	table.clear(self._playerItemList)

	if not self._prizeCfgs then
		local cfgs = {}
		local count = #cfgs
		local totalContentLength = self:_setPlayerContentLength(count)
		local posY = 5
		local posX = self._playerSliderStartOffset

		for i, v in ipairs(cfgs) do
			posX = posX + self._playerWidthSpace

			local go = self:_getPlayerRewardGo()

			go.name = "playercell" .. i

			goutil.addChildToParent(go, self._playerContentRectTrans.transform)
			Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, posY)

			local cls = GameUtil.AddLuaOnce(go, self._playerSliderCellClass)
			local callbackParams = {}

			callbackParams.isPlayerRewardCanGet = self._isPlayerRewardCanGet
			callbackParams.isPlayerRewardGeted = self._isPlayerRewardGeted
			callbackParams.sendGainPlayerPrizeReq = self._sendGainPlayerPrizeReq
			callbackParams.parseGetProgress = self._parseGetProgress
			callbackParams.initCellFunc = self._initCellFunc
			callbackParams.updateCellFunc = self._updateCellFunc
			callbackParams.effPath = self._effPath
			callbackParams.bHideCellBg = self._bHideCellBg
			callbackParams.normalizedPos = self:_caculateNormalizedPosition(posX, totalContentLength, goutil.getWidth(self._playerScrollRectTrans))
			callbackParams.needScore = self._getNeedScoreByRewardCfg(v)
			callbackParams.prize = self._getPrizeByRewardCfg and self._getPrizeByRewardCfg(v) or nil

			if self._getRewardTip then
				callbackParams.getRewardTip = self._getRewardTip
			end

			cls:init(v, self._view, self._playerScrollRectTrans, callbackParams)
			table.insert(self._playerItemList, cls)
		end

		self:_setPlayerScore()
	end
end

function PlayerSliderMo:updatePlayerReward()
	for i, v in ipairs(self._playerItemList) do
		v:update()
	end

	self:_setPlayerScore()
end

function PlayerSliderMo:updateAndRelocationReward()
	self:updatePlayerReward()
	self:relocation()
end

function PlayerSliderMo:relocation()
	for i, v in ipairs(self._playerItemList) do
		local isGeted, isCanGet = v:getRewardState()

		if isCanGet then
			self._playerScrollRect.horizontalNormalizedPosition = i == 1 and 0 or v:getNormalizedPos()

			return
		end

		if not isGeted then
			self._playerScrollRect.horizontalNormalizedPosition = i == 1 and 0 or v:getNormalizedPos()

			return
		end
	end

	self._playerScrollRect.horizontalNormalizedPosition = 1
end

function PlayerSliderMo:_caculateNormalizedPosition(curLength, totalLength, fixedWidth)
	if totalLength <= fixedWidth then
		return 0
	end

	local realTotalLength = totalLength - fixedWidth

	realTotalLength = realTotalLength > 0 and realTotalLength or 1

	local offset = -50
	local result = (curLength + offset) / realTotalLength

	return result <= 1 and result or 1
end

function PlayerSliderMo:_setPlayerContentLength(rewardCount)
	local sliderLength = rewardCount * self._playerWidthSpace
	local contentTotalLength = self._playerSliderStartOffset + sliderLength + self._playerSliderEndOffset

	goutil.setWidth(self._playerContentRectTrans, contentTotalLength)
	goutil.setWidth(self._playerSliderRectTrans, sliderLength)

	return contentTotalLength
end

function PlayerSliderMo:_getPlayerRewardGo()
	local count = #self._recyclePlayerGoList

	if count > 0 then
		local go = table.remove(self._recyclePlayerGoList, count)

		goutil.setActive(go, true)

		return go
	else
		local go = goutil.cloneAndSetParent(self._playercell, self._recycleGo.transform, "playercell")

		goutil.setActive(go, true)

		return go
	end
end

function PlayerSliderMo:_recyclePlayerRewardGo(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		goutil.addChildToParent(go, self._recycleGo)
		table.insert(self._recyclePlayerGoList, go)
	end
end

function PlayerSliderMo:_setPlayerScore()
	local curScore = self._getPlayerProgress()
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

	print(progress)
	self._playerSlider:SetValue(checknumber(progress))
end

return PlayerSliderMo
