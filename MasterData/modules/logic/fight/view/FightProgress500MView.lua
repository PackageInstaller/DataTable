-- chunkname: @modules/logic/fight/view/FightProgress500MView.lua

module("modules.logic.fight.view.FightProgress500MView", package.seeall)

local FightProgress500MView = class("FightProgress500MView", FightBaseView)

function FightProgress500MView:onInitView()
	self.imageBg = gohelper.findChildImage(self.viewGO, "slider/#image_bg")
	self.imageIconBg = gohelper.findChildImage(self.viewGO, "slider/#image_iconbg")
	self.imageIconVxDict = self:getUserDataTb_()

	for i = 1, 5 do
		self.imageIconVxDict[i] = gohelper.findChild(self.viewGO, "slider/#iconbg_loop/#" .. i)
	end

	self.imageIcon = gohelper.findChildImage(self.viewGO, "slider/#image_icon")
	self.imageSliderBg = gohelper.findChildImage(self.viewGO, "slider/#image_sliderbg")
	self.imageSlider = gohelper.findChildImage(self.viewGO, "slider/#image_sliderbg/#image_sliderfg")

	local rectTr = self.imageSlider:GetComponent(gohelper.Type_RectTransform)

	self.progressWidth = recthelper.getWidth(rectTr)
	self.goLoopAnim = gohelper.findChild(self.viewGO, "slider/#image_sliderbg/#sliderfg_loop")
	self.loopAnimRectTr = gohelper.findChildComponent(self.goLoopAnim, "sliderfg_light", gohelper.Type_RectTransform)

	gohelper.setActive(self.goLoopAnim, true)

	self.pointGo = gohelper.findChild(self.viewGO, "slider/#image_sliderbg/pointLayout/#image_point")

	gohelper.setActive(self.pointGo, false)

	self.txtProgress = gohelper.findChildText(self.viewGO, "slider/#txt_progress")
	self.txtTitle = gohelper.findChildText(self.viewGO, "slider/txt_title")
	self.btnClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn")
	self.animPlayer = self.viewGO:GetComponent(gohelper.Type_Animator)

	local commonTipViewPos = gohelper.findChild(self.viewGO, "commontipview_pos")

	self.commonTipViewPosTr = commonTipViewPos:GetComponent(gohelper.Type_RectTransform)
	self.tweenProgress = 0

	self:initThreshold()
end

function FightProgress500MView:addEvents()
	self:com_registClick(self.btnClick, self.onClickProgress)
	self:com_registMsg(FightMsgId.NewProgressValueChange, self.onProgressValueChange)
	self:com_registFightEvent(FightEvent.OnMonsterChange, self.onMonsterChange)
end

function FightProgress500MView:initThreshold()
	local co = lua_fight_const.configDict[55]
	local value = co and co.value

	if string.nilorempty(value) then
		logError("密思海500m最终boss的蓄力条 阈值配置不存在")

		self.threshold = {
			0.25,
			0.5,
			0.75,
			1
		}
	else
		self.threshold = string.splitToNumber(value, "#")

		for index, threshold in ipairs(self.threshold) do
			self.threshold[index] = threshold / 100
		end
	end
end

function FightProgress500MView:onMonsterChange()
	self:refreshUI()
	self.animPlayer:Play("switch", 0, 0)
	AudioMgr.instance:trigger(310010)
end

FightProgress500MView.TweenDuration = 0.5

function FightProgress500MView:onProgressValueChange()
	self:clearTween()

	self.curProgress = self:getCurProgress()
	self.tweenId = ZProj.TweenHelper.DOTweenFloat(self.tweenProgress, self.curProgress, FightProgress500MView.TweenDuration, self.frameCallback, self.doneCallback, self)
end

function FightProgress500MView:frameCallback(value)
	self:directSetProgress(value)
end

function FightProgress500MView:doneCallback()
	self:directSetProgress(self.curProgress)

	self.tweenId = nil
end

function FightProgress500MView:onClickProgress()
	local screenPos = recthelper.uiPosToScreenPos(self.commonTipViewPosTr)
	local title = luaLang("pata_500M_pogress_title")
	local desc = luaLang("pata_500M_pogress_desc")

	FightCommonTipController.instance:openCommonView(title, desc, screenPos)
end

function FightProgress500MView:onOpen()
	self.curProgress = self:getCurProgress()

	self:initPoint()
	self:refreshUI()
end

function FightProgress500MView:initPoint()
	self.thresholdPointList = {}
	self.playedThresholdIndexDict = {}

	local parent = self.pointGo.transform.parent
	local width = recthelper.getWidth(parent)

	for index, threshold in ipairs(self.threshold) do
		local pointItem = self:getUserDataTb_()

		pointItem.go = gohelper.cloneInPlace(self.pointGo)

		table.insert(self.thresholdPointList, pointItem)

		pointItem.image = pointItem.go:GetComponent(gohelper.Type_Image)
		pointItem.animLight = pointItem.go:GetComponent(gohelper.Type_Animation)

		local rectTr = pointItem.go:GetComponent(gohelper.Type_RectTransform)

		recthelper.setAnchorX(rectTr, threshold * width)

		if threshold <= self.curProgress then
			gohelper.setActive(pointItem.go, false)

			self.playedThresholdIndexDict[index] = true
		else
			gohelper.setActive(pointItem.go, true)
		end
	end
end

function FightProgress500MView:refreshUI()
	self.curStageCo = FightHelper.getBossCurStageCo_500M()

	self:refreshPoint()
	self:refreshImageIconVx()
	UISpriteSetMgr.instance:setFightTowerSprite(self.imageBg, self.curStageCo.param4)
	UISpriteSetMgr.instance:setFightTowerSprite(self.imageIconBg, self.curStageCo.param5)
	UISpriteSetMgr.instance:setFightTowerSprite(self.imageIcon, self.curStageCo.param6)
	UISpriteSetMgr.instance:setFightTowerSprite(self.imageSliderBg, self.curStageCo.param7)
	UISpriteSetMgr.instance:setFightTowerSprite(self.imageSlider, self.curStageCo.param8)
	self:clearTween()

	self.curProgress = self:getCurProgress()

	self:directSetProgress(self.curProgress)
end

function FightProgress500MView:directSetProgress(progress)
	self.tweenProgress = progress
	self.txtProgress.text = string.format("%s%%", math.floor(self.tweenProgress * 100))
	self.imageSlider.fillAmount = self.tweenProgress

	recthelper.setWidth(self.loopAnimRectTr, self.progressWidth * self.tweenProgress)
end

function FightProgress500MView:cancelRefreshPointTask()
	TaskDispatcher.cancelTask(self.hidePlayedPoint, self)
end

FightProgress500MView.AnimLightLen = 1

function FightProgress500MView:refreshPoint()
	self:cancelRefreshPointTask()

	if self.curStageCo then
		if not self.curStageCo.param9 then
			local pointIcon = ""

			for index, threshold in ipairs(self.threshold) do
				local pointItem = self.thresholdPointList[index]

				if threshold <= self.curProgress then
					UISpriteSetMgr.instance:setFightTowerSprite(pointItem.image, pointIcon)
					gohelper.setActive(pointItem.go, not self.playedThresholdIndexDict[index])

					if not self.playedThresholdIndexDict[index] then
						self.playedThresholdIndexDict[index] = true

						pointItem.animLight:Play()
						self:cancelRefreshPointTask()
						TaskDispatcher.runDelay(self.hidePlayedPoint, self, FightProgress500MView.AnimLightLen)
					end
				else
					UISpriteSetMgr.instance:setFightTowerSprite(pointItem.image, "fight_tower_point_0")
				end
			end
		end
	end
end

function FightProgress500MView:hidePlayedPoint()
	for index, _ in pairs(self.playedThresholdIndexDict) do
		local pointItem = self.thresholdPointList[index]

		if pointItem then
			gohelper.setActive(pointItem.go, false)
		end
	end
end

function FightProgress500MView:refreshImageIconVx()
	local curLevel = self.curStageCo.level

	for index, goVx in ipairs(self.imageIconVxDict) do
		gohelper.setActive(goVx, index == curLevel)
	end
end

function FightProgress500MView:getCurProgress()
	local progressDic = FightDataHelper.fieldMgr.progressDic
	local data = progressDic and progressDic:getDataByShowId(FightEnum.ProgressId.Progress_500M)

	if not data then
		return 0
	end

	return data.value / data.max
end

function FightProgress500MView:clearTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function FightProgress500MView:onDestroyView()
	self:clearTween()
	self:cancelRefreshPointTask()
end

return FightProgress500MView
