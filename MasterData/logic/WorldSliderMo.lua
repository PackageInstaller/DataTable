-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/helpdragonmom/view/WorldSliderMo.lua

module("logic.extensions.helpdragonmom.view.WorldSliderMo", package.seeall)

local WorldSliderMo = class("WorldSliderMo")

function WorldSliderMo:ctor(rootGo)
	self.mainGO = rootGo
	self._recycleGo = goutil.findChild(self.mainGO, "recycle")

	local pathPrefix = "worldPrize/prize/progressPrize/viewport/"

	self._worldSlider = Framework.SliderAdapter.GetFrom(self.mainGO, pathPrefix .. "content/progBar")
	self._worldContentRectTrans = goutil.findChild(self.mainGO, pathPrefix .. "content"):GetComponent(goutil.Type_RectTransform)
	self._worldcell = goutil.findChild(self.mainGO, "worldPrize/prize/worldcell")
	self._txtWorldScore = goutil.findChildTextComponent(self.mainGO, "worldPrize/prize/score/txtScore")
	self._progressPrizeTrans = goutil.findChild(self.mainGO, "worldPrize/prize/progressPrize"):GetComponent(goutil.Type_RectTransform)
	self._progressPrizeScroll = self._progressPrizeTrans.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._worldPrizeRectTrans = goutil.findChild(self.mainGO, "worldPrize"):GetComponent(goutil.Type_RectTransform)
	self._worldEffectRange = goutil.findChild(self.mainGO, "worldEffectRange"):GetComponent(goutil.Type_RectTransform)
	self._btnWorld = Framework.ButtonAdapter.GetFrom(self.mainGO, "worldPrize/btnWorld")
	self._worldArrow = goutil.findChild(self.mainGO, "worldPrize/btnWorld/arrow")
	self._effectBtnWorld = goutil.findChild(self.mainGO, "worldPrize/btnWorld/effect")
	self._worldRedPoint = goutil.findChild(self.mainGO, "worldPrize/btnWorld/redPoint")

	goutil.setActive(self._worldcell, false)

	self._worldSliderRectTrans = self._worldSlider.gameObject:GetComponent(goutil.Type_RectTransform)

	local x, y = Framework.TransformUtil.GetAnchoredPos(self._worldSliderRectTrans, 0, 0)

	self._worldSliderStartOffset = y
	self._worldSliderEndOffset = 50
	self._worldWidthSpace = 150
	self._recycleWorldGoList = {}
	self._worldItemList = {}
end

function WorldSliderMo:bindEvents()
	if self._btnWorld then
		self._btnWorld:AddClickListener(self._onClickWorld, self)
	end
end

function WorldSliderMo:unbindEvents()
	if self._btnWorld then
		self._btnWorld:RemoveClickListener()
	end
end

function WorldSliderMo:onEnter()
	self:_initWorldState()
	self:_loadSideBarEffect()
	self:_clearReward()
	self:_initWorldReward()
end

function WorldSliderMo:onExit()
	self:_clearReward()
	self:_removeSideBarEffect()
end

function WorldSliderMo:_onClickWorld()
	self:_changeWorldState()
end

function WorldSliderMo:initParam(param)
	self._prizeCfgs = param.prizeCfgs
	self._view = param.view
	self._isShowDefaultPos = param.isShowDefaultPos
	self._getWorldProgress = param.getWorldProgress
	self._getNeedScoreByRewardCfg = param.getNeedScoreByRewardCfg
	self._isWorldRewardCanGet = param.isWorldRewardCanGet
	self._isWorldRewardGeted = param.isWorldRewardGeted
	self._isAnyWorldRewardCanGet = param.isAnyWorldRewardCanGet
	self._sendGainWorldPrizeReq = param.sendGainWorldPrizeReq
	self._getPrizeByRewardCfg = param.getPrizeByRewardCfg
	self._getPrizeText = param.getPrizeText
	self._getScoreTxtByCfg = param.getScoreTxtByCfg
	self._worldWidthSpace = param.elementSpacing or self._worldWidthSpace
	self._isUpToBottom = param.isUpToBottom

	if param.worldSliderEndOffset ~= nil then
		self._worldSliderEndOffset = param.worldSliderEndOffset
	end

	if not goutil.isNil(param.txtWorldScore) then
		self._txtWorldScore = param.txtWorldScore
	end

	self._prizeDataList = {}

	if self._isUpToBottom then
		for i = #self._prizeCfgs, 1, -1 do
			table.insert(self._prizeDataList, self._prizeCfgs[i])
		end
	else
		for i = 1, #self._prizeCfgs do
			table.insert(self._prizeDataList, self._prizeCfgs[i])
		end
	end
end

function WorldSliderMo:_clearReward()
	for i, v in ipairs(self._worldItemList) do
		self:_recycleWorldRewardGo(v:getGo())
		v:clear()
	end

	table.clear(self._worldItemList)
end

function WorldSliderMo:_getWorldRewardGo()
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

function WorldSliderMo:_recycleWorldRewardGo(go)
	if not goutil.isNil(go) then
		goutil.setActive(go, false)
		goutil.addChildToParent(go, self._recycleGo)
		table.insert(self._recycleWorldGoList, go)
	end
end

function WorldSliderMo:_initWorldReward()
	table.clear(self._worldItemList)

	local cfgs = self._prizeDataList
	local count = #cfgs
	local totalContentLength = self:_setWorldContentLength(count)
	local posX = 126
	local posY = self._worldSliderStartOffset

	for i, v in ipairs(cfgs) do
		local score = self._getNeedScoreByRewardCfg(v)

		if score == 0 then
			-- block empty
		else
			posY = posY + self._worldWidthSpace
		end

		local go = self:_getWorldRewardGo()

		go.name = "worldcell" .. i

		goutil.addChildToParent(go, self._worldContentRectTrans.transform)
		Framework.TransformUtil.SetAnchoredPos(go:GetComponent(goutil.Type_RectTransform), posX, posY)

		local cls = GameUtil.AddLuaOnce(go, WorldSliderCell)
		local callbackParams = {}

		callbackParams.isWorldRewardCanGet = self._isWorldRewardCanGet
		callbackParams.isWorldRewardGeted = self._isWorldRewardGeted
		callbackParams.sendGainWorldPrizeReq = self._sendGainWorldPrizeReq
		callbackParams.normalizedPos = self:_caculateNormalizedPosition(posY, totalContentLength, goutil.getHeight(self._progressPrizeTrans))
		callbackParams.prize = self._getPrizeByRewardCfg and self._getPrizeByRewardCfg(v) or nil
		callbackParams.progress = self._getNeedScoreByRewardCfg(v)
		callbackParams.progressTxt = self._getScoreTxtByCfg and self._getScoreTxtByCfg(v) or nil

		cls:init(v, self._view, self._worldEffectRange, callbackParams)
		table.insert(self._worldItemList, cls)
	end

	self:_setWorldScore()
end

function WorldSliderMo:updateWorldReward()
	for i, v in ipairs(self._worldItemList) do
		v:update()
	end

	self:_setWorldScore()
	self:_updateWorldRedPoint()
end

function WorldSliderMo:_setWorldContentLength(rewardCount)
	local sliderLength = rewardCount * self._worldWidthSpace
	local contentTotalLength = self._worldSliderStartOffset + sliderLength + self._worldSliderEndOffset

	goutil.setHeight(self._worldContentRectTrans, contentTotalLength)
	goutil.setWidth(self._worldSliderRectTrans, sliderLength)

	return contentTotalLength
end

function WorldSliderMo:_setWorldScore()
	self._txtWorldScore.text = self._getPrizeText and self._getPrizeText() or string.format("当前能量:\n<color=#F8D200FF>%d</color>", self._getWorldProgress())

	local curScore = self._getWorldProgress()
	local cfgs = self._prizeDataList
	local count = #cfgs
	local unitNum = 1 / count
	local weightPercent = 0

	if cfgs[1] then
		local startNeedScore = self._getNeedScoreByRewardCfg(cfgs[1])

		for i, v in ipairs(cfgs) do
			local needScore = self._getNeedScoreByRewardCfg(v)

			if curScore <= needScore then
				if i == 1 then
					weightPercent = cfgs[1] == 0 and 0 or unitNum * (i - 1) + unitNum * (curScore / needScore)
				else
					if cfgs[1] == 0 then
						weightPercent = unitNum * (i - 2) + unitNum * ((curScore - self._getNeedScoreByRewardCfg(cfgs[i - 1])) / (self._getNeedScoreByRewardCfg(v) - self._getNeedScoreByRewardCfg(cfgs[i - 1])))

						break
					end

					weightPercent = unitNum * (i - 1) + unitNum * ((curScore - self._getNeedScoreByRewardCfg(cfgs[i - 1])) / (self._getNeedScoreByRewardCfg(v) - self._getNeedScoreByRewardCfg(cfgs[i - 1])))

					break
				end
			elseif i == count then
				weightPercent = 1
			end
		end

		local progress = Mathf.Clamp(weightPercent, 0, 1)

		self._worldSlider:SetValue(progress)
	end
end

function WorldSliderMo:_initWorldState()
	self:_clearWorldTween()

	if not self._isShowDefaultPos then
		self._isOpen = false

		GameUtil.setAnchoredPos(self._worldPrizeRectTrans, 182, 60)
		GameUtil.setLocalRotation(self._worldArrow, 0, 0, 180)
	else
		self._isOpen = true

		GameUtil.setAnchoredPos(self._worldPrizeRectTrans, -22, 60)
		GameUtil.setLocalRotation(self._worldArrow, 0, 0, 0)
	end
end

function WorldSliderMo:_changeWorldState()
	self:_clearWorldTween()

	if self._isOpen then
		self._isOpen = false

		local targetPos = Vector2.New(182, 60)

		self._worldTween = self._worldPrizeRectTrans:DOAnchorPos(targetPos, 0.2)

		GameUtil.setLocalRotation(self._worldArrow, 0, 0, 180)
	else
		self._isOpen = true

		local targetPos = Vector2.New(-22, 60)

		self._worldTween = self._worldPrizeRectTrans:DOAnchorPos(targetPos, 0.2)

		GameUtil.setLocalRotation(self._worldArrow, 0, 0, 0)
	end
end

function WorldSliderMo:_clearWorldTween()
	if self._worldTween then
		self._worldTween:Kill()
	end
end

function WorldSliderMo:_loadSideBarEffect()
	self:_removeSideBarEffect()

	local path = "20220401/caijingling/fx_ui_kelingqu_cjl.prefab"

	if self._effectBtnWorld then
		local effParent = self._effectBtnWorld.transform

		if not goutil.isNil(effParent) then
			local uiEffect = UIEffectManager.instance:playEffect(self._view, path, effParent, 0, 0, true, false)

			uiEffect:setParent(effParent)
			uiEffect:setScale(1)
			uiEffect:setLocalPos(0, 0, 0)

			self._sideBarEffect = uiEffect
		end
	end
end

function WorldSliderMo:_removeSideBarEffect()
	if self._sideBarEffect then
		UIEffectManager.instance:stopEffect(self._sideBarEffect)

		self._sideBarEffect = nil
	end
end

function WorldSliderMo:_updateWorldRedPoint()
	if self._isAnyWorldRewardCanGet then
		local isShowRedPoint = self._isAnyWorldRewardCanGet()

		GameUtil.SetActive(self._worldRedPoint, self._isAnyWorldRewardCanGet)
	end
end

function WorldSliderMo:relocation()
	local startIdx = 0
	local endIdx = 0
	local duce = 1
	local fitPos = 0
	local lastPos = 0

	if self._isUpToBottom then
		startIdx = #self._worldItemList
		endIdx = 1
		fitPos = 1
		lastPos = 1
		duce = -1
	else
		startIdx = 1
		endIdx = #self._worldItemList
		fitPos = 0
		lastPos = 0
		duce = 1
	end

	for i = startIdx, endIdx, duce do
		local v = self._worldItemList[i]
		local isGeted, isCanGet = v:getRewardState()

		if isCanGet then
			fitPos = v:getNormalizedPos()

			break
		end

		if not isGeted then
			fitPos = lastPos

			break
		end

		lastPos = v:getNormalizedPos()
	end

	self._progressPrizeScroll.verticalNormalizedPosition = fitPos
end

function WorldSliderMo:_caculateNormalizedPosition(curLength, totalLength, fixedWidth)
	if totalLength <= fixedWidth then
		return 0
	end

	local realTotalLength = totalLength - fixedWidth

	realTotalLength = realTotalLength > 0 and realTotalLength or 1

	local offset = -50
	local result = (curLength + offset) / realTotalLength

	return result <= 1 and result or 1
end

return WorldSliderMo
