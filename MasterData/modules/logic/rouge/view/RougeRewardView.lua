-- chunkname: @modules/logic/rouge/view/RougeRewardView.lua

module("modules.logic.rouge.view.RougeRewardView", package.seeall)

local RougeRewardView = class("RougeRewardView", BaseView)

function RougeRewardView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goRewardNodeContent = gohelper.findChild(self.viewGO, "Lv/#scroll_RewardNode/Viewport/content")
	self._goRewardNodeScroll = gohelper.findChild(self.viewGO, "Lv/#scroll_RewardNode")
	self._goRewardNode = gohelper.findChild(self.viewGO, "Lv/#scroll_RewardNode/Viewport/content/#go_RewardNode")
	self._goRewardLayout = gohelper.findChild(self.viewGO, "Left/Reward/Layout/#go_RewardLayout")
	self._simageRightBG = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_RightBG")
	self._simageRightBGDec = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_RightBGDec")
	self._goRight = gohelper.findChild(self.viewGO, "Right")
	self._animator = self._goRight:GetComponent(typeof(UnityEngine.Animator))
	self._goRewardSign = gohelper.findChild(self.viewGO, "Right/RewardSign")
	self._goReward = gohelper.findChild(self.viewGO, "Right/RewardNode")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#btn_Claim")
	self._goClaimBg = gohelper.findChild(self.viewGO, "Right/#btn_Claim/ClaimBG")
	self._goClaimGreyBg = gohelper.findChild(self.viewGO, "Right/#btn_Claim/greybg")
	self._goClaimedAll = gohelper.findChild(self.viewGO, "#go_ClaimedAll")
	self._txtTips = gohelper.findChildText(self.viewGO, "#go_ClaimedAll/#txt_Tips")
	self._goHasGet = gohelper.findChild(self.viewGO, "Right/#go_hasget")
	self._btnPreview = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_preview")
	self._btnEmpty = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_empty")
	self._txtCoin = gohelper.findChildText(self.viewGO, "Top/coin/#txt_coin")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "Top/coin/#btn_click")
	self._gotoprighttips = gohelper.findChild(self.viewGO, "Top/tips")
	self._txttoprighttips = gohelper.findChildText(self.viewGO, "Top/tips/#txt_tips")
	self._goBigRewardList = {}
	self._rewardNodeList = {}
	self._layoutList = {}
	self._startPosY = 12
	self._itemHeight = 100
	self._itemSpace = 80

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeRewardView:addEvents()
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
	self._btnPreview:AddClickListener(self._btnPreviewOnClick, self)
	self._btnEmpty:AddClickListener(self._btnEmptyOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, self.refreshView, self)
	self.addEventCb(self, RougeController.instance, RougeEvent.OnClickBigReward, self._onClickBigReward, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)
end

function RougeRewardView:removeEvents()
	self._btnClaim:RemoveClickListener()
	self._btnPreview:RemoveClickListener()
	self._btnEmpty:RemoveClickListener()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, self.refreshView, self)
	self.removeEventCb(self, RougeController.instance, RougeEvent.OnClickBigReward, self._onClickBigReward, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewFinish, self)

	if self._skinClick then
		self._skinClick:RemoveClickListener()
	end

	if self._rewardClick then
		self._rewardClick:RemoveClickListener()
	end

	if self._skinClick2 then
		self._skinClick2:RemoveClickListener()
	end
end

function RougeRewardView:_btnClaimOnClick()
	if RougeRewardModel.instance:checkCanGetBigReward(self._currentSelectStage) then
		local co = RougeRewardConfig.instance:getBigRewardConfigByStage(self._currentSelectStage)
		local season = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeReceivePointBonusRequest(season, co.id)
	end
end

function RougeRewardView:_btnclickOnClick()
	self._isopentips = not self._isopentips

	gohelper.setActive(self._gotoprighttips, self._isopentips)
end

function RougeRewardView:_btnPreviewOnClick()
	ViewMgr.instance:openView(ViewName.RougeRewardNoticeView)
end

function RougeRewardView:_btnEmptyOnClick()
	if #self._layoutList <= 0 then
		return
	end

	for _, layout in ipairs(self._layoutList) do
		layout.comp:hideExchangeBtn()
	end
end

function RougeRewardView:_editableInitView()
	return
end

function RougeRewardView:onUpdateParam()
	return
end

function RougeRewardView:onOpen()
	self._seasonParam = self.viewParam and self.viewParam.season
	self._stageParam = self.viewParam and self.viewParam.stage
	self._season = self._seasonParam or RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(self._season)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRewardView)
	RougeOutsideRpc.instance:sendRougeMarkBonusNewStageRequest(self._season)
	self:_initRewardNode()
	self:_initRewardLayout()
	self:_initBigReward()

	self._txtCoin.text = RougeRewardModel.instance:getRewardPoint()

	local maxStage = RougeRewardModel.instance:getLastOpenStage()
	local maxRewardpoint = RougeRewardConfig.instance:getPointLimitByStage(self._season, maxStage)
	local getAllPoint = RougeRewardModel.instance:getHadGetRewardPoint()
	local param = {
		getAllPoint,
		maxRewardpoint
	}

	self._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_rewardview_pointlimit"), param)

	local spacetime = 0.03

	TaskDispatcher.runDelay(self._onEnterAnim, self, spacetime)
end

function RougeRewardView:_onEnterAnim()
	TaskDispatcher.cancelTask(self._onEnterAnim, self)
	self._animator:Update(0)
	self._animator:Play("in", 0, 0)
	gohelper.setActive(self._goReward, false)

	local spacetime = 0.05

	TaskDispatcher.runDelay(self._afterAnim, self, spacetime)
end

function RougeRewardView:_afterAnim()
	TaskDispatcher.cancelTask(self._afterAnim, self)
	self:refreshView()
end

function RougeRewardView:_onSwitchAnim()
	self._animator:Update(0)
	self._animator:Play("out", 0, 0)

	local delayTime = 0.167

	TaskDispatcher.runDelay(self._onEnterAnim, self, delayTime)
end

function RougeRewardView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CommonPropView then
		local layoutnum = RougeRewardConfig.instance:getStageLayoutCount(self._currentSelectStage) or 1
		local num = self._beforeNum

		for i = 1, num do
			local item = self._goSignList[i]

			gohelper.setActive(item.img, true)
		end

		if layoutnum - num - 1 > 0 then
			for i = num + 1, layoutnum do
				gohelper.setActive(self._goSignList[i].img, false)
			end
		end

		for i = 1, layoutnum do
			local item = self._goSignList[i]

			gohelper.setActive(item.vxlight, item.isShowAnim)
		end

		local canRecive = RougeRewardModel.instance:checkCanGetBigReward(self._currentSelectStage)

		gohelper.setActive(self._goClaimBg, canRecive)
		gohelper.setActive(self._goClaimGreyBg, not canRecive)
	end
end

function RougeRewardView:_initRewardNode()
	local var_15_0 = self._stageParam

	if not self._stageParam then
		var_15_0 = RougeRewardModel.instance:getLastUnlockStage()
		var_15_0 = var_15_0 or 1
	end

	self._currentSelectStage = var_15_0

	local coList = RougeRewardConfig.instance:getRewardDict()

	for index, value in pairs(coList) do
		local item = self._rewardNodeList[index]

		if not item then
			item = self:getUserDataTb_()

			local go = gohelper.cloneInPlace(self._goRewardNode, "rewardNode" .. index)

			gohelper.setActive(go, true)

			item.go = go
			item.stage = index
			item.co = value
			item.goNoraml = gohelper.findChild(go, "#go_RewardNormal")
			item.txtNoramlNum = gohelper.findChildText(go, "#go_RewardNormal/#txt_Num")
			item.goCurrent = gohelper.findChild(go, "#go_RewardCurrent")
			item.imgCurrent = gohelper.findChildImage(go, "#go_RewardCurrent")
			item.txtCurrentNum = gohelper.findChildText(go, "#go_RewardCurrent/#txt_Num")
			item.goLock = gohelper.findChild(go, "#go_Locked")
			item.goClaimd = gohelper.findChild(go, "#go_Claimed")
			item.btn = gohelper.findChildButtonWithAudio(go, "btn", AudioEnum.UI.RewardCommonClick)

			item.btn:AddClickListener(self._btnRewardNodeOnClick, self, item)
			gohelper.setActive(go, true)
			table.insert(self._rewardNodeList, item)
		end

		item.txtNoramlNum.text = GameUtil.getRomanNums(index)
		item.txtCurrentNum.text = GameUtil.getRomanNums(index)

		self:refreshRewardNode()
	end

	local contentHeight = self._startPosY + self._currentSelectStage * self._itemHeight + (self._currentSelectStage - 1) * self._itemSpace
	local scrollHeight = recthelper.getHeight(self._goRewardNodeScroll.transform)
	local posY = Mathf.Clamp(contentHeight - scrollHeight, 0, contentHeight - scrollHeight)
	local transform = self._goRewardNodeContent.transform

	recthelper.setAnchorY(transform, posY)
end

function RougeRewardView:refreshRewardNode()
	local finishColor = GameUtil.parseColor("#A6A6A6")
	local normalColor = GameUtil.parseColor("#FFFFFF")

	for _, item in ipairs(self._rewardNodeList) do
		if not item then
			return
		end

		local isSelect = item.stage == self._currentSelectStage
		local isStageOpen = RougeRewardModel.instance:isStageOpen(item.stage)

		if not isStageOpen then
			gohelper.setActive(item.go, false)
		end

		local isUnLock = RougeRewardModel.instance:isStageUnLock(item.stage)
		local isClear = RougeRewardModel.instance:isStageClear(item.stage)

		gohelper.setActive(item.goLock, not isUnLock)
		gohelper.setActive(item.goNoraml, not isSelect)
		gohelper.setActive(item.goCurrent, isSelect)
		gohelper.setActive(item.goClaimd, isClear and not isSelect)

		item.imgCurrent.color = isClear and isSelect and finishColor or normalColor
	end
end

function RougeRewardView:_btnRewardNodeOnClick(item)
	if self._currentSelectStage ~= item.stage then
		self._currentSelectStage = item.stage
		self._beforeNum = nil

		self:_onSwitchAnim()
		self:refreshRewardLayout()
	end
end

function RougeRewardView:_onClickBigReward(bigRewardId)
	self._openStage = RougeRewardModel.instance:checkOpenStage(bigRewardId)

	if self._openStage and self._openStage ~= self._currentSelectStage then
		self._currentSelectStage = self._openStage
		self._beforeNum = nil

		self:_onSwitchAnim()
		self:refreshRewardLayout()
	end

	local contentHeight = self._startPosY + self._openStage * self._itemHeight + (self._openStage - 1) * self._itemSpace
	local scrollHeight = recthelper.getHeight(self._goRewardNodeScroll.transform)
	local posY = Mathf.Clamp(contentHeight - scrollHeight, 0, contentHeight - scrollHeight)
	local transform = self._goRewardNodeContent.transform

	recthelper.setAnchorY(transform, posY)
end

function RougeRewardView:_initRewardLayout()
	local layoutnum = RougeRewardConfig.instance:getStageLayoutCount(self._currentSelectStage) or 1

	for i = 1, layoutnum do
		local layout = self._layoutList[i]

		if not layout then
			layout = self:getUserDataTb_()
			layout.go = gohelper.cloneInPlace(self._goRewardLayout, "rewardLayout" .. i)

			gohelper.setActive(layout.go, true)

			layout.comp = MonoHelper.addNoUpdateLuaComOnceToGo(layout.go, RougeRewardLayout)

			table.insert(self._layoutList, layout)
		end

		local config = RougeRewardConfig.instance:getStageToLayourConfig(self._currentSelectStage, i)

		layout.comp:initcomp(layout.go, config, i, self._currentSelectStage)
	end
end

function RougeRewardView:_initBigReward()
	self:_initRewardSign()
	self:_initBigRewardNode()
	self:refreshBigReward()
end

function RougeRewardView:_initRewardSign()
	self._goSignList = self:getUserDataTb_()

	local transform = self._goRewardSign.transform
	local itemCount = transform.childCount

	for i = 1, itemCount do
		local item = self:getUserDataTb_()
		local child = transform:GetChild(i - 1)
		local img = gohelper.findChild(child.gameObject, "image_SignFG")
		local vxlight = gohelper.findChild(child.gameObject, "image_SignFG/vx_light")

		item.child = child
		item.img = img
		item.vxlight = vxlight
		item.isShowAnim = false

		gohelper.setActive(img, false)
		gohelper.setActive(vxlight, false)
		table.insert(self._goSignList, item)
	end
end

function RougeRewardView:_initBigRewardNode()
	for i = 1, 6 do
		local rewardnode = self:getUserDataTb_()

		rewardnode.go = gohelper.findChild(self.viewGO, "Right/RewardNode/#go_Reward" .. i)
		rewardnode.bg = gohelper.findChildSingleImage(rewardnode.go, "bg")

		if i == RougeEnum.BigRewardType.Double or i == RougeEnum.BigRewardType.Triple then
			local count = i == RougeEnum.BigRewardType.Double and 2 or 3

			rewardnode.nodeList = {}

			for j = 1, count do
				local node = {}

				node.go = gohelper.findChild(rewardnode.go, "reward" .. j)
				node.simge = gohelper.findChildSingleImage(node.go, "img_reward")
				node.img = gohelper.findChildImage(node.go, "img_reward")
				node.txt = gohelper.findChildText(node.go, "txt_reward")
				node.defultposx, node.defultposy = recthelper.getAnchor(node.txt.transform)

				table.insert(rewardnode.nodeList, node)
			end
		else
			rewardnode.name = gohelper.findChildText(rewardnode.go, "name")
		end

		table.insert(self._goBigRewardList, rewardnode)
	end
end

function RougeRewardView:refreshView()
	self:refreshRewardNode()
	self:refreshBigReward()
	self:refreshRewardLayout()

	self._txtCoin.text = RougeRewardModel.instance:getRewardPoint()

	local maxStage = RougeRewardModel.instance:getLastOpenStage()
	local maxRewardpoint = RougeRewardConfig.instance:getPointLimitByStage(self._season, maxStage)
	local getAllPoint = RougeRewardModel.instance:getHadGetRewardPoint()
	local param = {
		getAllPoint,
		maxRewardpoint
	}

	self._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_rewardview_pointlimit"), param)

	local isUnLock = RougeRewardModel.instance:isStageUnLock(self._currentSelectStage)

	gohelper.setActive(self._goClaimedAll, not isUnLock)

	if not isUnLock then
		local config = RougeRewardConfig.instance:getStageRewardConfigById(self._season, self._currentSelectStage)
		local preStage = config.preStage

		self._txtTips.text = formatLuaLang("rogue_rewardview_block", GameUtil.getRomanNums(preStage))
	end
end

function RougeRewardView:refreshRewardLayout()
	local layoutnum = RougeRewardConfig.instance:getStageLayoutCount(self._currentSelectStage) or 1

	for i = 1, layoutnum do
		local layout = self._layoutList[i]

		if not layout then
			return
		end

		local config = RougeRewardConfig.instance:getStageToLayourConfig(self._currentSelectStage, i)

		layout.comp:refreshcomp(config)
	end
end

function RougeRewardView:refreshBigReward()
	gohelper.setActive(self._goReward, true)

	self._showAnim = false

	local config = RougeRewardConfig.instance:getCurStageBigRewardConfig(self._currentSelectStage)
	local rewardType = config.rewardType
	local icon = "reward/" .. config.icon

	for index, rewardNode in ipairs(self._goBigRewardList) do
		if index ~= rewardType then
			gohelper.setActive(rewardNode.go, false)
		end
	end

	local rewardNode = self._goBigRewardList[rewardType]

	if not rewardNode then
		return
	end

	gohelper.setActive(rewardNode.go, true)

	local function func()
		rewardNode.bg.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	end

	rewardNode.bg:LoadImage(ResUrl.getRougeIcon(icon), func, self)

	if rewardType == RougeEnum.BigRewardType.Double or rewardType == RougeEnum.BigRewardType.Triple then
		local rewardtab = string.split(config.value, "|")
		local nametab = string.split(config.rewardName, "|")
		local postab

		if not string.nilorempty(config.offset) then
			postab = GameUtil.splitString2(config.offset, true)
		end

		local namedic = {}

		for _, name in ipairs(nametab) do
			local temp = string.split(name, "#")
			local tab = {}

			tab.name = temp[1]
			tab.icon = temp[2]
			tab.hideConfigIcon = temp[3]
			tab.hideNumber = temp[4]

			table.insert(namedic, tab)
		end

		for index, co in ipairs(rewardtab) do
			local rewardco = string.splitToNumber(co, "#")
			local type = rewardco[1]
			local id = rewardco[2]
			local number = rewardco[3]
			local go = rewardNode.nodeList[index]
			local namedicco = namedic[index]

			if not namedicco then
				break
			end

			if type == MaterialEnum.MaterialType.Equip then
				local hasIcon = not string.nilorempty(namedic[index].icon)

				gohelper.setActive(go.simge.gameObject, hasIcon)
				gohelper.setActive(go.img.gameObject, hasIcon)

				if hasIcon then
					go.simge:LoadImage(ResUrl.getRougeIcon("reward/" .. namedic[index].icon))
				end

				go.txt.text = not namedic[index].hideNumber and number > 1 and namedic[index].name .. "×" .. number or namedic[index].name
			elseif type == MaterialEnum.MaterialType.Item then
				local itemConfig, itemicon = ItemModel.instance:getItemConfigAndIcon(type, id, true)
				local showIcon = false

				showIcon = string.nilorempty(namedic[index].icon) and namedic[index].hideConfigIcon or true

				gohelper.setActive(go.simge.gameObject, showIcon)
				gohelper.setActive(go.img.gameObject, showIcon)

				if not string.nilorempty(namedic[index].icon) then
					go.simge:LoadImage(namedic[index].icon)
				elseif not namedic[index].hideConfigIcon then
					go.simge:LoadImage(itemicon)
				end

				go.txt.text = not namedic[index].hideNumber and number > 1 and namedic[index].name .. "×" .. number or namedic[index].name
			end

			if postab and #postab > 0 then
				local pos = postab[index]

				recthelper.setAnchor(go.txt.transform, pos[1], pos[2])
			else
				recthelper.setAnchor(go.txt.transform, go.defultposx, go.defultposy)
			end
		end
	else
		rewardNode.name.text = config.rewardName

		gohelper.setActive(rewardNode.bg.gameObject, true)

		rewardNode.click = gohelper.getClick(rewardNode.bg.gameObject)

		if rewardNode.click then
			rewardNode.click:RemoveClickListener()
		end

		local func

		if rewardType == RougeEnum.BigRewardType.Role then
			local value = string.splitToNumber(config.value, "#")
			local heroId = value[2]
			local heroDetailId = SummonConfig.instance:getSummonDetailIdByHeroId(heroId)

			rewardNode.click:AddClickListener(function()
				ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
					id = heroDetailId,
					heroId = heroId
				})
				AudioMgr.instance:trigger(AudioEnum.UI.RewardCommonClick)
			end, self)
		elseif rewardType == RougeEnum.BigRewardType.Skin then
			if config.offset then
				local pos = string.splitToNumber(config.offset, "#")

				recthelper.setAnchor(rewardNode.name.transform, pos[1], pos[2])
			end
		elseif self._currentSelectStage == 2 then
			rewardNode.click:AddClickListener(self._onClickRewardIcon, self)
		end
	end

	local num = RougeRewardModel.instance:getLastRewardCounter(self._currentSelectStage) or 0
	local layoutnum = RougeRewardConfig.instance:getStageLayoutCount(self._currentSelectStage) or 1
	local addNum

	if not self._beforeNum then
		self._beforeNum = num
	elseif self._beforeNum and num > self._beforeNum then
		for i = 1, num - self._beforeNum do
			local newItemIndex = self._beforeNum + i

			self._goSignList[newItemIndex].isShowAnim = true
		end

		self._beforeNum = num
		self._showAnim = true
	else
		for i = 1, layoutnum do
			self._goSignList[i].isShowAnim = false
		end
	end

	if num > 0 then
		for i = 1, num do
			local item = self._goSignList[i]

			if not item.isShowAnim then
				gohelper.setActive(item.img, true)
			end
		end

		if layoutnum - num - 1 >= 0 then
			for i = num + 1, layoutnum do
				gohelper.setActive(self._goSignList[i].img, false)
			end
		end
	else
		for i = 1, layoutnum do
			gohelper.setActive(self._goSignList[i].img, false)
		end
	end

	if not self._showAnim then
		local canRecive = RougeRewardModel.instance:checkCanGetBigReward(self._currentSelectStage)

		gohelper.setActive(self._goClaimBg, canRecive)
		gohelper.setActive(self._goClaimGreyBg, not canRecive)
	end

	local isClear = RougeRewardModel.instance:isStageClear(self._currentSelectStage)

	gohelper.setActive(self._btnClaim.gameObject, not isClear)
	gohelper.setActive(self._goHasGet, isClear)
end

function RougeRewardView:_onClickRewardIcon()
	local config = RougeRewardConfig.instance:getCurStageBigRewardConfig(self._currentSelectStage)

	if config.rewardType == RougeEnum.BigRewardType.RoomItem then
		ViewMgr.instance:openView(ViewName.RougerewardThemeTipView, config)
		AudioMgr.instance:trigger(AudioEnum.UI.RewardCommonClick)
	end
end

function RougeRewardView:onClose()
	for index, item in ipairs(self._rewardNodeList) do
		item.btn:RemoveClickListener()
	end

	for _, item in ipairs(self._goBigRewardList) do
		if item.click then
			item.click:RemoveClickListener()
		end
	end

	TaskDispatcher.cancelTask(self._onEnterAnim, self)
	TaskDispatcher.cancelTask(self._afterAnim, self)
	TaskDispatcher.cancelTask(self._onSwitchAnim, self)
end

function RougeRewardView:onDestroyView()
	return
end

return RougeRewardView
