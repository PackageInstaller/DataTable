-- chunkname: @modules/logic/survival/view/map/SurvivalShrinkView.lua

module("modules.logic.survival.view.map.SurvivalShrinkView", package.seeall)

local SurvivalShrinkView = class("SurvivalShrinkView", BaseView)

function SurvivalShrinkView:onInitView()
	self._txtCountDown = gohelper.findChild(self.viewGO, "Top/#go_countdown/#txt_countdown")
	self._goprocess = gohelper.findChild(self.viewGO, "Top/#go_process")
	self._goprocessitem = gohelper.findChild(self.viewGO, "Top/#go_process/#go_slider")
	self._goicon1 = gohelper.findChild(self.viewGO, "Top/#go_process/#go_icon1")
	self._goicon2 = gohelper.findChild(self.viewGO, "Top/#go_process/#go_icon2")
	self._gotips = gohelper.findChild(self.viewGO, "Top/#go_tips")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "Top/#btn_tips")
	self._goshrinkTips = gohelper.findChildAnim(self.viewGO, "Top/#go_tips/#go_restTips")
	self._txtshrinkTips = gohelper.findChildTextMesh(self.viewGO, "Top/#go_tips/#go_restTips/#txt_restTips")
	self._goshrinkArrow = gohelper.findChild(self.viewGO, "Top/#go_tips/#go_restTips/arrow")
	self._gorestTips = gohelper.findChildAnim(self.viewGO, "Top/#go_tips/#go_shrinkTips")
	self._txtrestTips = gohelper.findChildTextMesh(self.viewGO, "Top/#go_tips/#go_shrinkTips/#txt_shrinkTips")
	self._gorestArrow = gohelper.findChild(self.viewGO, "Top/#go_tips/#go_shrinkTips/arrow")
end

function SurvivalShrinkView:addEvents()
	self._btntips:AddClickListener(self._showHideTips, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnDerivedUpdate, self._OnTimeChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShrinkInfoUpdate, self._OnTimeChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapGameTimeUpdate, self._OnTimeChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapCostTimeUpdate, self._OnTimeChange, self)
end

function SurvivalShrinkView:removeEvents()
	self._btntips:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnDerivedUpdate, self._OnTimeChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShrinkInfoUpdate, self._OnTimeChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapGameTimeUpdate, self._OnTimeChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapCostTimeUpdate, self._OnTimeChange, self)
end

function SurvivalShrinkView:_OnTimeChange()
	self:_refreshGameTime()
	self:_onCostTimeUpdate()
end

function SurvivalShrinkView:onOpen()
	if self._flashTxtComp then
		return
	end

	self._flashTxtComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._txtCountDown, SurvivalFlashTxtComp)
	self._processWidth = recthelper.getWidth(self._goprocess.transform)
	self._icon1Width = recthelper.getWidth(self._goicon1.transform)
	self._icon2Width = recthelper.getWidth(self._goicon2.transform)
	self._isShowTips = true
	self._goshrinkTips.keepAnimatorStateOnDisable = true
	self._gorestTips.keepAnimatorStateOnDisable = true

	gohelper.setActive(self._gotips, true)
	gohelper.setActive(self._goicon1, false)
	gohelper.setActive(self._goicon2, false)
	gohelper.setActive(self._goprocessitem, false)

	self._icon1Pool = self:getUserDataTb_()
	self._icon2Pool = self:getUserDataTb_()
	self._sliderPool = self:getUserDataTb_()
	self._icon1Inst = self:getUserDataTb_()
	self._icon2Inst = self:getUserDataTb_()
	self._sliderInst = self:getUserDataTb_()

	self:_refreshGameTime()
end

function SurvivalShrinkView:_showHideTips()
	self._isShowTips = not self._isShowTips

	if self._isShowTips then
		if self._curIsSafe then
			self._gorestTips:Play("open", 0, 0)
		else
			self._goshrinkTips:Play("open", 0, 0)
		end
	else
		TaskDispatcher.cancelTask(self._delayPlayTipsOpen, self)

		if self._curIsSafe then
			self._gorestTips:Play("close", 0, 0)
		else
			self._goshrinkTips:Play("close", 0, 0)
		end
	end
end

function SurvivalShrinkView:_refreshGameTime()
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local countDown = sceneMo.currMaxGameTime - sceneMo.gameTime
	local hour = math.floor(countDown / 60)
	local min = math.fmod(countDown, 60)

	self._flashTxtComp:setNormalTxt(string.format("%d:%02d", hour, min))

	local datas = {}
	local curTime = sceneMo.addTime

	for i, v in ipairs(sceneMo.safeZone) do
		if curTime < v.startTime then
			table.insert(datas, {
				isSafe = true,
				startTime = curTime,
				endTime = v.startTime
			})
		end

		table.insert(datas, {
			startTime = v.startTime,
			endTime = v.endTime
		})

		curTime = v.endTime
	end

	if curTime < sceneMo.currMaxGameTime then
		table.insert(datas, {
			isSafe = true,
			startTime = curTime,
			endTime = sceneMo.currMaxGameTime
		})
	end

	tabletool.revert(datas)

	local width = self._processWidth

	for k, v in ipairs(datas) do
		v.startTime, v.endTime = sceneMo.currMaxGameTime - v.endTime, sceneMo.currMaxGameTime - v.startTime

		if k ~= 1 then
			width = v.isSafe and width - self._icon2Width or width - self._icon1Width
		end
	end

	self:inPoolAllItems()

	local curIsSafe = false
	local curIcon
	local nextTime = 0

	self._totalSliderWidth = width
	self._sliderDatas = datas
	self._sliderGos = self._sliderGos or self:getUserDataTb_()

	for k, v in ipairs(datas) do
		local icon
		local sliderGo = self:createItem(self._sliderPool, self._sliderInst, self._goprocessitem)

		self:setSlider(sliderGo, width, v)

		self._sliderGos[k] = sliderGo

		if countDown > v.startTime and countDown <= v.endTime then
			curIsSafe = v.isSafe or false
			nextTime = v.startTime
			curIcon = (k ~= 1 or nil) and (v.isSafe and self:createItem(self._icon2Pool, self._icon2Inst, self._goicon2) or self:createItem(self._icon1Pool, self._icon1Inst, self._goicon1))
		end
	end

	if self._curIsSafe == nil then
		self._gorestTips:Play(curIsSafe and "open" or "close", 0, 1)
		self._goshrinkTips:Play(not curIsSafe and "open" or "close", 0, 1)
	elseif self._curIsSafe ~= curIsSafe then
		TaskDispatcher.cancelTask(self._delayPlayTipsOpen, self)

		if self._isShowTips then
			if curIsSafe then
				self._goshrinkTips:Play("close", 0, 0)
				self._gorestTips:Play("close", 0, 1)
			else
				self._gorestTips:Play("close", 0, 0)
				self._goshrinkTips:Play("close", 0, 1)
			end

			TaskDispatcher.runDelay(self._delayPlayTipsOpen, self, 0.167)
		end
	end

	self._curIsSafe = curIsSafe

	local firstInfo = sceneMo.safeZone[1]

	AudioMgr.instance:setState(AudioMgr.instance:getIdFromString("dl_music"), AudioMgr.instance:getIdFromString((firstInfo and firstInfo.round == 1 and firstInfo.startTime > sceneMo.gameTime or nil) and "explore"))

	local nextHour = math.floor(nextTime / 60)
	local nextMin = math.fmod(nextTime, 60)

	if curIsSafe then
		self._txtrestTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_mainview_beginshrink"), string.format("%d:%02d", nextHour, nextMin))
	else
		self._txtshrinkTips.text = curIcon and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survival_mainview_endshrink"), string.format("%d:%02d", nextHour, nextMin)) or luaLang("survival_mainview_lastshrink")
	end

	gohelper.setActive(self._gorestArrow, curIcon and true or false)
	gohelper.setActive(self._goshrinkArrow, curIcon and true or false)

	if curIcon then
		ZProj.UGUIHelper.RebuildLayout(self._goprocess.transform)
		self:setTransY(self._gorestArrow.transform, curIcon)
		self:setTransY(self._goshrinkArrow.transform, curIcon)
	end
end

function SurvivalShrinkView:_delayPlayTipsOpen()
	if not self._isShowTips then
		return
	end

	if self._curIsSafe then
		self._gorestTips:Play("open", 0, 0)
	else
		self._goshrinkTips:Play("open", 0, 0)
	end
end

function SurvivalShrinkView:setTransY(trans, target)
	local localPos = trans.parent:InverseTransformPoint(target.transform.position)
	local x, y, z = transformhelper.getLocalPos(trans)

	transformhelper.setLocalPos(trans, localPos.x, y, z)
end

function SurvivalShrinkView:inPoolAllItems()
	self:inPoolItem(self._icon1Pool, self._icon1Inst)
	self:inPoolItem(self._icon2Pool, self._icon2Inst)
	self:inPoolItem(self._sliderPool, self._sliderInst)
end

function SurvivalShrinkView:inPoolItem(pool, inst)
	for i = #inst, 1, -1 do
		table.insert(pool, inst[i])
		gohelper.setActive(inst[i], false)

		inst[i] = nil
	end
end

function SurvivalShrinkView:createItem(pool, inst, newObj)
	local obj = table.remove(pool)

	obj = obj or gohelper.cloneInPlace(newObj)

	gohelper.setActive(obj, true)
	gohelper.setAsLastSibling(obj)
	table.insert(inst, obj)

	return obj
end

function SurvivalShrinkView:_onCostTimeUpdate()
	if not self._totalSliderWidth then
		return
	end

	for k, v in ipairs(self._sliderDatas) do
		self:setSlider(self._sliderGos[k], self._totalSliderWidth, v)
	end

	if SurvivalMapModel.instance.showCostTime == 0 then
		self._flashTxtComp:setFlashTxt()
	else
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local countDown = sceneMo.currMaxGameTime - sceneMo.gameTime - SurvivalMapModel.instance.showCostTime

		if countDown < 0 then
			countDown = 0
		end

		local hour = math.floor(countDown / 60)
		local min = math.fmod(countDown, 60)

		self._flashTxtComp:setFlashTxt(string.format("%d:%02d", hour, min))
	end
end

function SurvivalShrinkView:setSlider(obj, totalWidth, data)
	local slider = gohelper.findChildImage(obj, "#image_slider")
	local imageCost = gohelper.findChildImage(obj, "#image_cost")
	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local sliderWidth = (data.endTime - data.startTime) / (sceneMo.currMaxGameTime - sceneMo.addTime) * totalWidth

	recthelper.setWidth(obj.transform, sliderWidth)

	local countDown = sceneMo.currMaxGameTime - sceneMo.gameTime
	local costTime = countDown - SurvivalMapModel.instance.showCostTime

	slider.fillAmount = countDown >= data.endTime and 1 or countDown <= data.startTime and 0 or (countDown - data.startTime) / (data.endTime - data.startTime)

	local width, offset = 0, 0

	if costTime < data.endTime and countDown > data.startTime and costTime ~= countDown then
		width = (math.min(data.endTime, countDown) - math.max(data.startTime, costTime)) / (data.endTime - data.startTime) * sliderWidth
		offset = (math.max(data.startTime, costTime) - data.startTime) / (data.endTime - data.startTime) * sliderWidth
	end

	recthelper.setWidth(imageCost.transform, width)
	recthelper.setAnchorX(imageCost.transform, offset)
end

function SurvivalShrinkView:onDestroyView()
	TaskDispatcher.cancelTask(self._delayPlayTipsOpen, self)
end

return SurvivalShrinkView
