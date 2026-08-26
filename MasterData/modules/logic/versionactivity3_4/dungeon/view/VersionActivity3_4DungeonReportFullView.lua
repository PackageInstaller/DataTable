-- chunkname: @modules/logic/versionactivity3_4/dungeon/view/VersionActivity3_4DungeonReportFullView.lua

module("modules.logic.versionactivity3_4.dungeon.view.VersionActivity3_4DungeonReportFullView", package.seeall)

local VersionActivity3_4DungeonReportFullView = class("VersionActivity3_4DungeonReportFullView", BaseView)

function VersionActivity3_4DungeonReportFullView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._scrolltips = gohelper.findChildScrollRect(self.viewGO, "Right/#scroll_tips")
	self._txtdec = gohelper.findChildText(self.viewGO, "Right/#scroll_tips/Viewport/Content/#txt_dec")
	self._gofinish = gohelper.findChild(self.viewGO, "Right/#go_finish")
	self._txtunfinish = gohelper.findChildText(self.viewGO, "Right/#txt_unfinish")
	self._goitem = gohelper.findChild(self.viewGO, "Left/#go_item")
	self._simagepic = gohelper.findChildSingleImage(self.viewGO, "Left/#go_item/#simage_pic")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "Progress/#slider_progress")
	self._goSliderFG = gohelper.findChild(self.viewGO, "Progress/#slider_progress/Fill Area/#go_SliderFG")
	self._gorewarditem = gohelper.findChild(self.viewGO, "Progress/SliderPoint/#go_rewarditem")
	self._txtprogress = gohelper.findChildText(self.viewGO, "Progress/bg/#txt_progress")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_4DungeonReportFullView:addEvents()
	return
end

function VersionActivity3_4DungeonReportFullView:removeEvents()
	return
end

function VersionActivity3_4DungeonReportFullView:_editableInitView()
	gohelper.setActive(self._goitem, false)

	self._txtdec.text = ""

	gohelper.setActive(self._txtdec, false)
end

function VersionActivity3_4DungeonReportFullView:onUpdateParam()
	return
end

function VersionActivity3_4DungeonReportFullView:onOpen()
	self._acceptedRewardNum = self.viewParam
	self._initRewardNum = self.viewParam
	self._curFinishRewardNum = 0
	self._progressList = {
		0.18,
		0.35,
		0.51,
		0.67,
		0.83,
		1
	}
	self._descUnlockAnimator = self:getUserDataTb_()
	self._itemUnlockList = self:getUserDataTb_()

	self:_initItems()
	self:_initRewardItems()
	self._sliderprogress:SetValue(self._progressList[self._acceptedRewardNum] or 0)
	AudioMgr.instance:trigger(AudioEnum3_4.VersionActivity3_4.ui_mln_details_open)
end

function VersionActivity3_4DungeonReportFullView:onOpenFinish()
	if self._curFinishRewardNum <= self._acceptedRewardNum then
		return
	end

	TaskDispatcher.cancelTask(self._delayPlayUnlockAnim, self)
	TaskDispatcher.cancelTask(self._delayGetBonus, self)

	local time = 1

	TaskDispatcher.runDelay(self._delayPlayUnlockAnim, self, 0.5)
	TaskDispatcher.runDelay(self._delayGetBonus, self, time)
	UIBlockHelper.instance:startBlock("VersionActivity3_4DungeonReportFullView open", time)

	if not self._progressList[self._acceptedRewardNum] then
		if not self._progressList[self._curFinishRewardNum] then
			local to = 0

			self._tweenId = ZProj.TweenHelper.DOTweenFloat(self._progressList[self._acceptedRewardNum], to, time, self._onTweenFrame, nil, self, nil, EaseType.Linear)
		end
	end
end

function VersionActivity3_4DungeonReportFullView:_onTweenFrame(value)
	self._sliderprogress:SetValue(value)
end

function VersionActivity3_4DungeonReportFullView:_delayGetBonus()
	if self._curFinishRewardNum > self._acceptedRewardNum then
		Activity113Rpc.instance:sendGetAct113MilestoneBonusRequest(VersionActivity3_4Enum.ActivityId.Dungeon, self._getBonusCallback, self)
	end
end

function VersionActivity3_4DungeonReportFullView:_delayPlayUnlockAnim()
	for i, v in ipairs(self._descUnlockAnimator) do
		gohelper.setActive(v, true)
		v:Play("unlock", 0, 0)
	end

	for i, v in ipairs(self._itemUnlockList) do
		v.animator:Play("unlock", 0, 0)
	end
end

function VersionActivity3_4DungeonReportFullView:_getBonusCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self._acceptedRewardNum = msg.acceptedRewardId

		self:_initRewardItems()

		local dataList = {}

		for index = self._initRewardNum + 1, self._acceptedRewardNum do
			local rewardConfig = VersionActivity3_4DungeonConfig.instance:getChapterReward(index)

			if rewardConfig then
				local rewardParams = string.splitToNumber(rewardConfig.reward, "#")
				local materialData = MaterialDataMO.New()

				materialData:initValue(rewardParams[1], rewardParams[2], rewardParams[3])
				table.insert(dataList, materialData)
			end
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, dataList)
	end
end

function VersionActivity3_4DungeonReportFullView.indexOfByKey(array, value, key, begin)
	for i = begin or 1, #array do
		if array[i][key] == value then
			return i
		end
	end
end

function VersionActivity3_4DungeonReportFullView:_initItems()
	local sortList = {}

	for i, v in ipairs(lua_v3a2_chapter_report.configList) do
		local isFinish = DungeonMapModel.instance:elementIsFinished(v.element)

		if isFinish then
			local time = DungeonMapModel.instance:getRecordInfo(v.element)
			local var_13_1 = {
				v.element
			}

			var_13_1[2] = tonumber(time) or 0

			table.insert(sortList, var_13_1)
		end
	end

	table.sort(sortList, function(a, b)
		if a[2] == b[2] then
			return a[1] < b[1]
		else
			return a[2] < b[2]
		end
	end)

	local count = 0

	for i, v in ipairs(lua_v3a2_chapter_report.configList) do
		local go = gohelper.cloneInPlace(self._goitem)

		gohelper.setActive(go, true)

		local img = gohelper.findChildSingleImage(go, "#simage_pic")
		local emptyGo = gohelper.findChild(go, "empty")
		local isFinish = DungeonMapModel.instance:elementIsFinished(v.element)

		gohelper.setActive(emptyGo, not isFinish)
		gohelper.setActive(img, isFinish)

		if isFinish then
			count = count + 1
			self._curFinishRewardNum = count

			if not string.nilorempty(v.res) then
				img:LoadImage(string.format("singlebg/v3a2_dungeon_singlebg/%s.png", v.res))
			end

			local descGo = gohelper.cloneInPlace(self._txtdec.gameObject)
			local txt = gohelper.findChildText(descGo, "")

			txt.text = v.desc

			local sortIndex = VersionActivity3_4DungeonReportFullView.indexOfByKey(sortList, v.element, 1) or 0

			if sortIndex > self._acceptedRewardNum then
				local animator = descGo:GetComponent("Animator")

				table.insert(self._descUnlockAnimator, animator)
				gohelper.setActive(emptyGo, true)
				table.insert(self._itemUnlockList, {
					emptyGo = emptyGo,
					img = img,
					animator = go:GetComponent("Animator")
				})
			else
				gohelper.setActive(descGo, true)
			end
		end
	end

	local isAllFinish = count == #lua_v3a2_chapter_report.configList

	gohelper.setActive(self._gofinish, isAllFinish)
	gohelper.setActive(self._txtunfinish, not isAllFinish)

	self._txtprogress.text = string.format("%d/%d", count, #lua_v3a2_chapter_report.configList)
end

function VersionActivity3_4DungeonReportFullView:_initRewardItems()
	self._clickCacheList = self._clickCacheList or self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onRewardItemShow, lua_v3a2_chapter_report.configList, self._gorewarditem.transform.parent.gameObject, self._gorewarditem)
end

function VersionActivity3_4DungeonReportFullView:_onRewardItemShow(obj, data, index)
	local txtIndex = gohelper.findChildText(obj, "txt_index")

	txtIndex.text = "0" .. index

	local rewardConfig = lua_v3a2_chapter_reward.configDict[index]
	local rewardParams = string.splitToNumber(rewardConfig.reward, "#")
	local txtNum = gohelper.findChildText(obj, "txt_rewardcount")

	txtNum.text = "x" .. rewardParams[3]

	local img = gohelper.findChildSingleImage(obj, "go_icon")
	local _, icon = ItemModel.instance:getItemConfigAndIcon(rewardParams[1], rewardParams[2])

	img:LoadImage(icon)

	if data.id <= self._curFinishRewardNum then
		local go_canget = gohelper.findChild(obj, "go_canget")
		local go_hasget = gohelper.findChild(obj, "go_hasget")
		local hasAccepted = self._acceptedRewardNum >= data.id

		gohelper.setActive(go_canget, not hasAccepted)
		gohelper.setActive(go_hasget, hasAccepted)
	end
end

function VersionActivity3_4DungeonReportFullView:_addBtnClick(btnclick, data, index)
	local item = self._clickCacheList[btnclick]

	if not item then
		item = {
			clickListener = btnclick
		}
		self._clickCacheList[btnclick] = item

		btnclick.AddClickListener(btnclick, self._onBtnClick, self, btnclick)
	end

	item.data = data
	item.index = index
end

function VersionActivity3_4DungeonReportFullView:_onBtnClick(btnclick)
	return
end

function VersionActivity3_4DungeonReportFullView:onClose()
	if self._clickCacheList then
		for i, v in pairs(self._clickCacheList) do
			v.clickListener:RemoveClickListener()
		end
	end

	TaskDispatcher.cancelTask(self._delayPlayUnlockAnim, self)
	TaskDispatcher.cancelTask(self._delayGetBonus, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function VersionActivity3_4DungeonReportFullView:onDestroyView()
	return
end

return VersionActivity3_4DungeonReportFullView
