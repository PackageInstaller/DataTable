-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/ChapterRewardView.lua

module("logic.extensions.plotcopy.view.ChapterRewardView", package.seeall)

local ChapterRewardView = class("ChapterRewardView", ViewComponent)

function ChapterRewardView:buildUI()
	self._rewardParent = self:getGo("rewardParent")

	local go = self:getResInstance("ui/views/plotcopy/chapterreward.prefab")

	go.name = "chapterreward"

	Framework.TransformUtil.SetLocalPos(go.transform, 0, 0, 0)
	goutil.addChildToParent(go, self._rewardParent)

	self._txtDesc = self:getTxt("rewardParent/chapterreward/count/txtDesc")
	self._txtDesc1 = self:getTxt("rewardParent/chapterreward/count/txtDesc1")
	self._slider = self:getSlider("rewardParent/chapterreward/progress/slider")
	self._content = self:getGo("rewardParent/chapterreward/progress/slider/content")
	self._item = self:getGo("rewardParent/chapterreward/item")

	self._item:SetActive(false)

	self._progress = self:getGo("rewardParent/chapterreward/progress")
	self._btnReward = self:getBtn("rewardParent/chapterreward/btnReward")
	self._noGo = self:getGo("rewardParent/chapterreward/btnReward/no")
	self._yesGo = self:getGo("rewardParent/chapterreward/btnReward/yes")
end

function ChapterRewardView:bindEvents()
	self._btnReward:AddClickListener(self._onClickReward, self)
end

function ChapterRewardView:unbindEvents()
	self._btnReward:RemoveClickListener()
end

function ChapterRewardView:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.CopyGainChapterPrizeRes, self._onGainChapterPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CopyRefreshReward, self._refreshRewardShow, self)
	GlobalDispatcher:addListener(GlobalNotify.CopyGainPreciousBoxPrizeRes, self._onGainPreciousBoxPrizeRes, self)

	local chapterId = self:getFirstParam()

	self._isHaveReward = false

	self:_refreshRewardShow(chapterId)
end

function ChapterRewardView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CopyGainChapterPrizeRes, self._onGainChapterPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CopyRefreshReward, self._refreshRewardShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.CopyGainPreciousBoxPrizeRes, self._onGainPreciousBoxPrizeRes, self)
	self:_reset()
end

function ChapterRewardView:_reset()
	if self._itemGos then
		for k, v in pairs(self._itemGos) do
			v.itemBtn:RemoveClickListener()
			MaterialMgr.resetAll(v.icon)
		end

		self._itemGos = nil
	end

	goutil.clearChildren(self._content)
	self:_removeEffect()
end

function ChapterRewardView:_refreshRewardShow(chapterId)
	self._chapterId = chapterId

	local curFinishCount, chapterTotalCount = PlotCopyModel.instance:getPerfectFinishCount(chapterId)

	self:_reset()
	self:_setChapterProgress(curFinishCount, chapterTotalCount)
	self:_setSliderProgress(curFinishCount, chapterTotalCount, chapterId)
	self:_refreshBtnReward()
end

function ChapterRewardView:_onGainPreciousBoxPrizeRes()
	self:_refreshRewardShow(self._chapterId)
end

function ChapterRewardView:_setChapterProgress(curFinishCount, chapterTotalCount)
	self._txtDesc.text = curFinishCount .. "/"
	self._txtDesc1.text = chapterTotalCount
end

function ChapterRewardView:_setSliderProgress(curFinishCount, chapterTotalCount, chapterId)
	if chapterTotalCount <= 0 then
		return
	end

	local percent = curFinishCount / chapterTotalCount

	self._slider:SetValue(percent)

	local cfgChapter = CopyConfig.instance:getChapter(chapterId)

	if not cfgChapter or cfgChapter.progressReward == 0 then
		self._progress:SetActive(false)

		return
	end

	self._progress:SetActive(true)

	local cfgStrategys = CopyConfig.instance:getRewardStrategys(cfgChapter.progressReward)
	local width = self._slider:GetComponent(goutil.Type_RectTransform).rect.width

	self._itemGos = {}
	self._itemDatas = {}

	local index = 0

	for k, v in ipairs(cfgStrategys) do
		if chapterTotalCount >= v.condition then
			index = index + 1

			local go = goutil.cloneAndSetParent(self._item, self._content.transform, "item" .. index)

			go:SetActive(true)

			local percentSelf = v.condition / chapterTotalCount

			Framework.TransformUtil.SetLocalPos(go.transform, width * percentSelf, 0, 0)

			local elementGos = {}

			table.insert(self._itemGos, elementGos)

			elementGos.parentGo = go
			elementGos.parentGoRect = go:GetComponent(goutil.Type_RectTransform)
			elementGos.icon = goutil.findChild(go, "icon")
			elementGos.effect = goutil.findChild(go, "effect")
			elementGos.geted = goutil.findChild(go, "geted")
			elementGos.txtNum = goutil.findChild(go, "txtNum"):GetComponent(goutil.Type_UIText)
			elementGos.mask = goutil.findChild(go, "mask")
			elementGos.itemBtn = Framework.ButtonAdapter.Get(go)

			local curIndex = index - 1

			elementGos.itemBtn:AddClickListener(function()
				local isGeted = PlotCopyModel.instance:isChapterRewardGain(chapterId, curIndex)

				if isGeted then
					FloatWordMgr.instance:show("奖励已领取")

					return
				else
					local isCanGet = PlotCopyModel.instance:isCanGetChapterReward(chapterId, curIndex)

					if not isCanGet then
						FloatWordMgr.instance:show("请先完成指定数量关卡")

						return
					end
				end

				PlotCopyController.instance:sendGainChapterPrizeReq(chapterId, curIndex)
			end)

			elementGos.txtNum.text = v.condition

			MaterialMgr.setCellByCfg(v.reward, elementGos.icon)
		end
	end

	self:_updateRewardState(chapterId)
	self:_initEffect()
end

function ChapterRewardView:_onGainChapterPrizeRes(chapterId)
	self:_updateRewardState(chapterId)
	self:_refreshBtnReward()
end

function ChapterRewardView:_updateRewardState(chapterId)
	for i, v in ipairs(self._itemGos) do
		local isGeted = PlotCopyModel.instance:isChapterRewardGain(chapterId, i - 1)

		if isGeted then
			v.effect:SetActive(false)
			v.geted:SetActive(true)
			v.mask:SetActive(true)
		else
			local isCanGet = PlotCopyModel.instance:isCanGetChapterReward(chapterId, i - 1)

			if isCanGet then
				v.effect:SetActive(true)
				v.geted:SetActive(false)
				v.mask:SetActive(true)
			else
				v.effect:SetActive(false)
				v.geted:SetActive(false)
				v.mask:SetActive(false)
			end
		end
	end
end

function ChapterRewardView:_initEffect()
	self._effects = self._effects or {}

	for i, v in ipairs(self._itemGos) do
		local effectRectTrans = v.parentGoRect
		local effect = UIEffectManager.instance:playEffect(self, "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab", v.effect.transform, 0, 0, true, false, nil, function(target, eff)
			eff:setClipping(effectRectTrans)
		end)

		effect:setParent(v.effect.transform)
		effect:setScale(1)
		table.insert(self._effects, effect)
	end
end

function ChapterRewardView:_removeEffect()
	if self._effects then
		for k, v in pairs(self._effects) do
			UIEffectManager.instance:stopEffect(v)
		end

		self._effects = nil
	end
end

function ChapterRewardView:_onClickReward()
	if self._isHaveReward then
		UIStateManager.instance:open(ViewName.ChapterRewardGetView, self._chapterId)
	else
		FloatWordMgr.instance:show("没有奖励可领取")
	end
end

function ChapterRewardView:_refreshBtnReward()
	local rewardList = PlotCopyModel.instance:getChapterRewardCfgs()
	local isHaveReward = #rewardList > 0

	self._isHaveReward = isHaveReward

	goutil.setActive(self._noGo, not isHaveReward)
	goutil.setActive(self._yesGo, isHaveReward)
end

return ChapterRewardView
