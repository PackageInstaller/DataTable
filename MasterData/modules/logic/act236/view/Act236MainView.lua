-- chunkname: @modules/logic/act236/view/Act236MainView.lua

module("modules.logic.act236.view.Act236MainView", package.seeall)

local Act236MainView = class("Act236MainView", BaseView)

function Act236MainView:onInitView()
	self._txttime = gohelper.findChildText(self.viewGO, "root/limittimebg/#txt_time")
	self._btnhelp = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_help", AudioEnum3_7.Act236.play_ui_common_click)
	self._simageshowPic = gohelper.findChildSingleImage(self.viewGO, "root/showContent/showmask/#simage_showPic")
	self._govideo = gohelper.findChild(self.viewGO, "root/showContent/showmask/#go_video")
	self._goeffect = gohelper.findChild(self.viewGO, "root/showContent/showmask/#go_effect")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/showContent/#btn_check")
	self._gotab = gohelper.findChild(self.viewGO, "root/showContent/#go_tab")
	self._goitem = gohelper.findChild(self.viewGO, "root/showContent/#go_tab/layout/#go_item")
	self._goselect = gohelper.findChild(self.viewGO, "root/showContent/#go_tab/layout/#go_item/#go_select")
	self._txtname = gohelper.findChildText(self.viewGO, "root/showContent/#go_tab/layout/#go_item/#txt_name")
	self._gopointTab = gohelper.findChild(self.viewGO, "root/showContent/#go_pointTab")
	self._gopoint = gohelper.findChild(self.viewGO, "root/showContent/#go_pointTab/layout/#go_point")
	self._btngo = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottomRight/#btn_go", AudioEnum3_7.Act236.play_ui_common_click)
	self._imagefg = gohelper.findChildImage(self.viewGO, "root/bottomRight/progress/#image_fg")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/bottomRight/progress/#txt_num")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/bottomRight/sendreward/#simage_icon")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottomRight/sendreward/#btn_reward", AudioEnum3_7.Act236.play_ui_common_click)
	self._gosendbg = gohelper.findChild(self.viewGO, "root/bottomRight/sendreward/#go_sendbg")
	self._gocanget = gohelper.findChild(self.viewGO, "root/bottomRight/sendreward/#go_canget")
	self._goisget = gohelper.findChild(self.viewGO, "root/bottomRight/sendreward/#go_isget")
	self._txtrewardnum = gohelper.findChildText(self.viewGO, "root/bottomRight/sendreward/numbg/#txt_rewardnum")
	self._goprogressnoramlmask = gohelper.findChild(self.viewGO, "root/rewardContent/#go_progress_noramlmask")
	self._goprogressachievemask = gohelper.findChild(self.viewGO, "root/rewardContent/#go_progress_achievemask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act236MainView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
	self._btngo:AddClickListener(self._btngoOnClick, self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnhelp:AddClickListener(self._btnhelpOnClick, self)
	self.addEventCb(self, Act236Controller.instance, Act236Event.OnInfoUpdate, self.refreshUI, self)
	self.addEventCb(self, Act236Controller.instance, Act236Event.OnGainReward, self.refreshReward, self)
end

function Act236MainView:removeEvents()
	self._btncheck:RemoveClickListener()
	self._btngo:RemoveClickListener()
	self._btnreward:RemoveClickListener()
	self._btnhelp:RemoveClickListener()
	self.removeEventCb(self, Act236Controller.instance, Act236Event.OnInfoUpdate, self.refreshUI, self)
	self.removeEventCb(self, Act236Controller.instance, Act236Event.OnGainReward, self.refreshReward, self)
end

function Act236MainView:_btncheckOnClick()
	local index = self.curTabIndex

	if self.showRewardList[index] ~= nil then
		if not self.showRewardList[index] then
			local rewardParam = self.showRewardList[Act236Enum.FirstShowIndex]

			if rewardParam == nil then
				return
			end

			local type = tonumber(rewardParam[1])
			local itemId = tonumber(rewardParam[2])

			if itemId == Act236Enum.ItemId.SelfSelectSkin then
				local param = {}

				param.type = SkinDiscountCompensateEnum.SelectDisplayType.DisplayOnly
				param.itemId = itemId

				ViewMgr.instance:openView(ViewName.SkinSelfSelectView, param)

				return
			elseif itemId == Act236Enum.ItemId.SelfSelectHero then
				local o = {}

				o.param = {}
				o.param.itemId = itemId
				o.quantity = 0
				o.subType = type
				o.itemId = itemId
				o.type = SkinDiscountCompensateEnum.SelectDisplayType.DisplayOnly

				GiftController.instance:openGiftMultipleHeroChoiceView(o)

				return
			end

			MaterialTipController.instance:showMaterialInfo(type, itemId)
		end
	end
end

function Act236MainView:_btngoOnClick()
	StoreController.instance:checkAndOpenStoreView()
end

function Act236MainView:_btnrewardOnClick()
	self:clickRewardItem(Act236Enum.RewardOffset)
end

function Act236MainView:_btnhelpOnClick()
	local title = CommonConfig.instance:getConstStr(ConstEnum.Act236HelpTitle)
	local desc = CommonConfig.instance:getConstStr(ConstEnum.Act236HelpDesc)

	HelpController.instance:openStoreTipView(desc, title)
end

function Act236MainView:_editableInitView()
	self.rewardItemList = self:getUserDataTb_()
	self.rewardParentGo = gohelper.findChild(self.viewGO, "root/rewardContent/reward")
	self.showContentGo = gohelper.findChild(self.viewGO, "root/showContent")
	self.showContentList = {}
	self.showVideoContentList = {}
	self.showRewardList = {}

	local width = recthelper.getWidth(self._simageshowPic.transform)
	local height = recthelper.getHeight(self._simageshowPic.transform)

	self._videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(self._govideo, nil, true, width, height)
	self.showEffectDic = self:getUserDataTb_()
	self.loader = MultiAbLoader.New()
	self.pointItemTabList = self:getUserDataTb_()
	self.itemTabList = self:getUserDataTb_()

	require("tolua.reflection")
	tolua.loadassembly("Coffee.SoftMaskForUGUI")

	local type = tolua.findtype("Coffee.UISoftMask.SoftMaskable")

	gohelper.onceAddComponent(self._videoPlayer._videoGo, type)

	self._progressCtrl = self.viewGO:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	local vector4 = self._progressCtrl.vector_03

	self.progressVector = Vector4.New(vector4.x, vector4.y, vector4.z, vector4.w)
	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)

	local posX, posY = recthelper.getAnchor(self._goeffect.transform)
	local rotateX, rotateY, rotateZ = transformhelper.getLocalRotation(self._goeffect.transform)

	self.defaultEffectPos = {
		x = posX,
		y = posY
	}
	self.defaultEffectRotate = {
		x = rotateX,
		y = rotateY,
		z = rotateZ
	}
	self.txtCanGet = gohelper.findChild(self.viewGO, "root/bottomRight/sendreward/txt_canget")
end

function Act236MainView:onUpdateParam()
	return
end

function Act236MainView:onOpen()
	self:checkParam()
	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, Act236Enum.TimeRefreshDuration)

	self.isOpen = true

	self.animator:Play("open", 0, 0)
	self:refreshUI()

	self.isOpen = false

	AudioMgr.instance:trigger(AudioEnum3_7.Act236.play_ui_beiai_leichong_open)
end

function Act236MainView:checkParam()
	if not self.viewParam or not self.viewParam.actId then
		logError("3.7 累充活动 缺少活动id")

		return
	end

	if self.viewParam.parent then
		gohelper.addChild(self.viewParam.parent, self.viewGO)
	end

	self.actId = self.viewParam.actId

	Act236Model.instance:setCurActId(self.actId)

	self.infoMo = Act236Model.instance:getInfoMo(self.actId)

	local rewardConfigList = Act236Config.instance:getRewardConfigListById(self.actId)

	self.rewardConfigList = rewardConfigList

	if rewardConfigList then
		self.rewardCount = #rewardConfigList or 0
	end
end

function Act236MainView:refreshUI()
	self:refreshProgress()
	self:refreshReward()

	if self.isOpen then
		self:switchToLast()
	end
end

function Act236MainView:switchToLast()
	if self.rewardConfigList then
		if not #self.rewardConfigList then
			local selectIndex = Act236Enum.FirstShowIndex + Act236Enum.RewardOffset

			self:onSelectReward(selectIndex)
		end
	end
end

function Act236MainView:onSelectReward(index)
	if index == self.curRewardIndex then
		return
	end

	local rewardConfig = self.rewardConfigList[index]

	if not rewardConfig then
		return
	end

	self.curRewardIndex = index

	local showContentList = string.split(rewardConfig.showWindow, "|")
	local showVideoList = string.split(rewardConfig.showVideo, "|")
	local showRewardList = string.split(rewardConfig.showReward, "|")
	local showContent = showContentList ~= nil and next(showContentList) ~= nil

	gohelper.setActive(self.showContentGo, showContent)

	if not showContent then
		return
	end

	local contentIndex = Act236Enum.FirstShowIndex
	local contentCount = #showContentList

	self:refreshListValue(showContentList, self.showContentList, true)
	self:refreshListValue(showRewardList, self.showRewardList, false)
	self:refreshListValue(showVideoList, self.showVideoContentList, false)

	self.showContentCount = contentCount

	self:refreshRewardItemSelect()
	self:refreshTab(contentIndex)
	self:showSingleContent(contentIndex)
end

function Act236MainView:refreshTab(contentIndex)
	if self.showVideoContentList then
		local showVideo = self.showVideoContentList[contentIndex] ~= nil
		local showTab = self.showContentCount > Act236Enum.FirstShowIndex

		gohelper.setActive(self._gotab, showTab and showVideo)
		gohelper.setActive(self._gopointTab, showTab and not showVideo)

		if showTab then
			if showVideo then
				self:refreshItemTab()
			else
				self:refreshPointTab()
				TaskDispatcher.runDelay(self.onMoveNextTab, self, Act236Enum.MoveToNextTime)
			end
		end
	end
end

function Act236MainView:refreshTabSelect(showVideo)
	local showTab = self.showContentCount > Act236Enum.FirstShowIndex

	if showTab then
		if showVideo then
			self:refreshItemTabSelect()
		else
			self:refreshPointTabSelect()
			TaskDispatcher.runDelay(self.onMoveNextTab, self, Act236Enum.MoveToNextTime)
		end
	end
end

function Act236MainView:refreshListValue(paramList, targetList, isNumber)
	tabletool.clear(targetList)

	for _, param in ipairs(paramList) do
		if param and not string.nilorempty(param) then
			local data

			table.insert(targetList, isNumber and string.splitToNumber(param, "#") or string.split(param, "#"))
		end
	end
end

function Act236MainView:refreshRewardItemSelect()
	for index, rewardItem in pairs(self.rewardItemList) do
		gohelper.setActive(rewardItem.goSelect, self.curRewardIndex == index)
	end
end

function Act236MainView:refreshItemTab()
	gohelper.CreateObjList(self, self.onGetItemTab, self.showRewardList, nil, self._goitem)
end

function Act236MainView:onGetItemTab(itemGo, param, index)
	local item

	if not self.itemTabList[index] then
		item = self:getUserDataTb_()
		item.itemGo = itemGo
		item.goSelect = gohelper.findChild(itemGo, "#go_select")
		item.txtname = gohelper.findChildText(itemGo, "#txt_name")
		item.txtname.raycastTarget = false
		item.btnClick = gohelper.findChildButtonWithAudio(itemGo, "#btn_click", AudioEnum3_7.Act236.play_ui_common_click)

		item.btnClick:AddClickListener(self.onItemTabClick, {
			target = self,
			index = index
		})

		self.itemTabList[index] = item
	else
		item = self.itemTabList[index]
	end

	if not string.nilorempty(param[4]) then
		item.txtname.text = param[4]
	else
		logError("累充tab标签缺少标题")

		item.txtname.text = tostring(index)
	end
end

function Act236MainView.onItemTabClick(param)
	local target = param.target
	local index = param.index

	target:clickItemTab(index)
end

function Act236MainView:clickItemTab(index)
	if index ~= self.curTabIndex then
		self:showSingleContent(index)
	else
		TaskDispatcher.cancelTask(self.onMoveNextTab, self)
		TaskDispatcher.runDelay(self.onMoveNextTab, self, Act236Enum.MoveToNextTime)
	end
end

function Act236MainView:refreshItemTabSelect()
	for index, item in ipairs(self.itemTabList) do
		gohelper.setActive(item.goSelect, self.curTabIndex == index)
	end
end

function Act236MainView:refreshPointTab()
	gohelper.CreateObjList(self, self.onGetPointTab, self.showContentList, nil, self._gopoint)
end

function Act236MainView:onGetPointTab(itemGo, param, index)
	local item

	if not self.pointItemTabList[index] then
		item = self:getUserDataTb_()
		item.itemGo = itemGo
		item.goGray = gohelper.findChild(itemGo, "#go_gray")
		item.goLight = gohelper.findChild(itemGo, "#go_light")
		self.pointItemTabList[index] = item
	else
		item = self.pointItemTabList[index]
	end
end

function Act236MainView:refreshPointTabSelect()
	for index, item in ipairs(self.pointItemTabList) do
		gohelper.setActive(item.goGray, self.curTabIndex ~= index)
		gohelper.setActive(item.goLight, self.curTabIndex == index)
	end
end

function Act236MainView:lockScreen(isLock)
	if isLock then
		logNormal("锁屏")
		UIBlockMgr.instance:startBlock(self.viewName)
		TaskDispatcher.runDelay(self.onLockTimeForceEnd, self, Act236Enum.ForceEndLockScreenTime)
	else
		logNormal("不锁屏")
		UIBlockMgr.instance:endBlock(self.viewName)
		TaskDispatcher.cancelTask(self.onLockTimeForceEnd, self)
	end
end

function Act236MainView:onLockTimeForceEnd()
	logError("锁屏超时,强制关闭锁屏")
	self:lockScreen(false)
end

function Act236MainView:showImageContent(contentIndex)
	gohelper.setActive(self._simageshowPic, true)

	local param = self.showContentList[contentIndex]
	local index = param[2]
	local imagePath = "v3a7_cumulativerecharge_3_7_" .. self:_getNumStr(index)

	self._simageshowPic:LoadImage(ResUrl.getAct236SingleBg(imagePath))
end

function Act236MainView:showVideoContent(contentIndex)
	local param = self.showVideoContentList[contentIndex]
	local type = tonumber(param[1])
	local name = param[2]

	gohelper.setActive(self._govideo, type == Act236Enum.DisplayType.Video)
	gohelper.setActive(self._goeffect, type == Act236Enum.DisplayType.Effect)
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayEnd, self)

	if type ~= Act236Enum.DisplayType.Video then
		self._videoPlayer:pause()
	end

	if Act236Enum.EffectOffsetParam[self.curRewardIndex] then
		if not Act236Enum.EffectOffsetParam[self.curRewardIndex][self.curTabIndex] then
			local offsetParam

			if type == Act236Enum.DisplayType.Video then
				if offsetParam then
					if not offsetParam.x then
						local posX = Act236Enum.DefaultValue

						if offsetParam then
							if not offsetParam.y then
								local posY = Act236Enum.DefaultValue

								recthelper.setAnchor(self._govideo.transform, posX, posY)
								self:lockScreen(true)
								self._videoPlayer:loadMedia(name)
								self._videoPlayer:play(name, true, self._videoStatusUpdate, self)
							end
						end
					end
				end
			elseif offsetParam then
				if not offsetParam.x then
					local posX = self.defaultEffectPos.x

					if offsetParam then
						if not offsetParam.y then
							local posY = self.defaultEffectPos.y

							if offsetParam then
								if not offsetParam.rotateX then
									local rotateX = self.defaultEffectRotate.x

									if offsetParam then
										if not offsetParam.rotateY then
											local rotateY = self.defaultEffectRotate.y

											if offsetParam then
												if not offsetParam.rotateZ then
													local rotateZ = self.defaultEffectRotate.z

													recthelper.setAnchor(self._goeffect.transform, posX, posY)
													transformhelper.setLocalRotation(self._goeffect.transform, rotateX, rotateY, rotateZ)

													if not self.showEffectDic[name] then
														self.curParam = param

														self:lockScreen(true)

														local path = self:getEffectPath(name)

														self.loader:addPath(path)
														self.loader:startLoad(self.onEffectLoadFinish, self)
													else
														self:setEffectState(name)
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function Act236MainView:showSingleContent(contentIndex)
	self.curTabIndex = contentIndex

	TaskDispatcher.cancelTask(self.onMoveNextTab, self)

	local showVideo = self.showVideoContentList[contentIndex] ~= nil

	self:refreshTabSelect(showVideo)

	if not self.isOpen then
		TaskDispatcher.cancelTask(self.onSwitchAnimPlayEnd, self)
		self.animator:Play("switch", 0, 0)
		AudioMgr.instance:trigger(AudioEnum3_7.Act236.play_ui_shiji_tv_noise)
		TaskDispatcher.runDelay(self.onSwitchAnimPlayEnd, self, Act236Enum.VideoSwitchTime)
		self:lockScreen(true)
	else
		self:onSwitchAnimPlayEnd()
	end
end

function Act236MainView:onSwitchAnimPlayEnd()
	self:lockScreen(false)
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayEnd, self)

	local contentIndex = self.curTabIndex
	local showVideo = self.showVideoContentList[contentIndex] ~= nil

	self:showImageContent(contentIndex)

	if not showVideo then
		gohelper.setActive(self._govideo, false)
		gohelper.setActive(self._goeffect, false)

		return
	end

	self:showVideoContent(contentIndex)
end

function Act236MainView:_videoStatusUpdate(path, status, errorCode)
	if status == VideoEnum.PlayerStatus.Started or status == VideoEnum.PlayerStatus.Unpaused then
		self:lockScreen(false)
		gohelper.setActive(self._simageshowPic, false)
	end
end

function Act236MainView:getEffectPath(name)
	return "ui/viewres/" .. name .. ".prefab"
end

function Act236MainView:onMoveNextTab()
	local nextIndex = self.curTabIndex

	nextIndex = self.curTabIndex >= self.showContentCount and Act236Enum.FirstShowIndex or nextIndex + 1

	self:showSingleContent(nextIndex)
end

function Act236MainView:onEffectLoadFinish()
	local curName = self.curParam[2]
	local path = self:getEffectPath(curName)
	local effectAsset = self.loader:getAssetItem(path)

	if effectAsset then
		logNormal("load effect: " .. path)

		local effectPrefab = effectAsset:GetResource()

		self.showEffectDic[curName] = gohelper.clone(effectPrefab, self._goeffect, "effect_" .. tostring(curName))

		self:setEffectState(curName)
	end

	self:lockScreen(false)
end

function Act236MainView:setEffectState(curName)
	for name, effectGo in pairs(self.showEffectDic) do
		gohelper.setActive(effectGo, name == curName)
	end
end

function Act236MainView:_getNumStr(num)
	if num < 10 then
		return "0" .. tostring(num)
	end

	return tostring(num)
end

function Act236MainView:refreshProgress()
	local curProgress = self.infoMo.score
	local rewardConfigList = self.rewardConfigList
	local rewardCount = #rewardConfigList

	self.rewardCount = rewardCount

	for id, config in ipairs(rewardConfigList) do
		if curProgress < config.cost then
			rewardCount = config.id

			break
		end
	end

	local curConfig = rewardConfigList[rewardCount]

	self.rewardConfigList = rewardConfigList
	self._txtnum.text = string.format("<size=50><color=%s>%s</color></size>/%s", Act236Enum.Color.ProgressDesc, curProgress, curConfig.cost)

	if curProgress > 0 then
		self._imagefg.fillAmount = math.min(curProgress / curConfig.cost, 1)
	end

	local previousIndex = curConfig.id - 1

	if not Act236Enum.ProgressValue[previousIndex - 1] then
		local previousProgressValue = 1
		local curProgressValue = Act236Enum.ProgressValue[rewardCount - 1]
		local previousConfig = self.rewardConfigList[previousIndex]

		if previousConfig then
			if not previousConfig.cost then
				local needCost = 0
				local addCostProgress = (curProgress - needCost) / (curConfig.cost - needCost)
				local addProgress = addCostProgress * (previousProgressValue - curProgressValue)

				self.progressVector.x = Mathf.Clamp(previousProgressValue - addProgress, 0, 1)
				self._progressCtrl.vector_03 = self.progressVector

				self._progressCtrl:SetProps()
			end
		end
	end
end

function Act236MainView:refreshTime()
	if not self.actId then
		self._txttime.text = luaLang("ended")

		return
	end

	if not ActivityModel.instance:isActOnLine(self.actId) then
		self._txttime.text = luaLang("ended")

		return
	end

	local endTime = ActivityModel.instance:getActEndTime(self.actId) / TimeUtil.OneSecondMilliSecond
	local nowTime = ServerTime.now()

	self._txttime.text = endTime <= nowTime and luaLang("ended") or TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function Act236MainView:refreshReward()
	local rewardConfigList = self.rewardConfigList
	local freeRewardConfig = rewardConfigList[Act236Enum.RewardOffset]
	local isGet = self.infoMo:isRewardGet(freeRewardConfig.id)
	local canGet = freeRewardConfig.cost <= self.infoMo.score
	local param = string.splitToNumber(freeRewardConfig.reward, "#")

	self._txtrewardnum.text = "x" .. tostring(param[3])

	gohelper.setActive(self._gocanget, not isGet and canGet)
	gohelper.setActive(self._goisget, isGet)
	gohelper.setActive(self.txtCanGet, not isGet and canGet)
	gohelper.setActive(self._txtrewardnum, not isGet and not canGet)

	if self.rewardCount > Act236Enum.RewardOffset then
		for i = 1 + Act236Enum.RewardOffset, self.rewardCount do
			local config = rewardConfigList[i]

			self:refreshRewardItem(i, config)
		end
	end
end

function Act236MainView:getRewardItem(index)
	local item

	if not self.rewardItemList[index] then
		item = self:getUserDataTb_()

		local itemGo = gohelper.findChild(self.rewardParentGo, string.format("reward%s", index - Act236Enum.RewardOffset))

		item.itemGo = itemGo
		item.goSelect = gohelper.findChild(itemGo, "#go_select")
		item.txtTarget = gohelper.findChildText(itemGo, "#txt_achieve")
		item.goCanGet = gohelper.findChild(itemGo, "#go_canget")
		item.goIsGet = gohelper.findChild(itemGo, "#go_isget")
		item.btnClick = gohelper.findChildButtonWithAudio(itemGo, "#btn_click", AudioEnum3_7.Act236.play_ui_common_click)
		item.txtName = gohelper.findChildText(itemGo, "#txt_name")
		item.txtCanGet = gohelper.findChildText(itemGo, "txt_canget")
		item.imageNormalBg = gohelper.findChildImage(itemGo, "#go_normalbg")
		self.rewardItemList[index] = item

		item.btnClick:AddClickListener(self.onRewardItemClick, {
			target = self,
			index = index
		})

		return item
	end

	return self.rewardItemList[index]
end

function Act236MainView.onRewardItemClick(param)
	local target = param.target
	local index = param.index

	target:clickRewardItem(index)
end

function Act236MainView:clickRewardItem(index)
	local config = self.rewardConfigList[index]

	if not config then
		return
	end

	if not self.infoMo:isRewardGet(config.id) and self.infoMo.score >= config.cost then
		local rewardList = {}

		if index == Act236Enum.RewardOffset then
			table.insert(rewardList, config.id)
		else
			for i = Act236Enum.RewardOffset + Act236Enum.FirstShowIndex, self.rewardCount do
				local rewardConfig = self.rewardConfigList[i]

				if rewardConfig.cost <= self.infoMo.score and not self.infoMo:isRewardGet(rewardConfig.id) then
					table.insert(rewardList, rewardConfig.id)
				end
			end
		end

		Act236Controller.instance:gainReward(self.actId, true, rewardList)

		return
	end

	if index ~= Act236Enum.FirstShowIndex then
		self:onSelectReward(index)
	end
end

function Act236MainView:refreshRewardItem(index, config)
	local rewardItem = self:getRewardItem(index)
	local canGet = self.infoMo.score >= config.cost
	local isGet = self.infoMo:isRewardGet(config.id)

	gohelper.setActive(rewardItem.goCanGet, canGet and not isGet)
	gohelper.setActive(rewardItem.txtCanGet, canGet and not isGet)
	gohelper.setActive(rewardItem.txtTarget, not canGet or isGet)
	gohelper.setActive(rewardItem.goIsGet, isGet)

	if isGet then
		if not Act236Enum.RewardTextAlpha.HaveGet then
			local alpha = Act236Enum.RewardTextAlpha.Normal

			if isGet then
				if not Act236Enum.RewardBgColor.HaveGet then
					local bgColor = Act236Enum.RewardBgColor.Normal

					if rewardItem.imageNormalBg ~= nil then
						UIColorHelper.set(rewardItem.imageNormalBg, bgColor)
					end

					rewardItem.txtTarget.alpha = alpha
				end
			end
		end
	end
end

function Act236MainView:onClose()
	return
end

function Act236MainView:onDestroyView()
	TaskDispatcher.cancelTask(self.onSwitchAnimPlayEnd, self)
	TaskDispatcher.cancelTask(self.onLockTimeForceEnd, self)
	TaskDispatcher.cancelTask(self.refreshTime, self)
	TaskDispatcher.cancelTask(self.onMoveNextTab, self)

	if self.rewardItemList and next(self.rewardItemList) then
		for _, item in pairs(self.rewardItemList) do
			item.btnClick:RemoveClickListener()
		end
	end

	self.rewardConfigList = nil

	self._simageshowPic:UnLoadImage()
	tabletool.clear(self.pointItemTabList)

	for _, item in ipairs(self.itemTabList) do
		item.btnClick:RemoveClickListener()
	end

	tabletool.clear(self.itemTabList)
	tabletool.clear(self.showEffectDic)

	if self._videoPlayer then
		if not BootNativeUtil.isIOS() then
			self._videoPlayer:stop()
		end

		self._videoPlayer:clear()

		self._videoPlayer = nil
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

return Act236MainView
