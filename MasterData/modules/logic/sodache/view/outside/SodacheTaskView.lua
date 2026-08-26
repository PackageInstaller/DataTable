-- chunkname: @modules/logic/sodache/view/outside/SodacheTaskView.lua

module("modules.logic.sodache.view.outside.SodacheTaskView", package.seeall)

local SodacheTaskView = class("SodacheTaskView", BaseView)

function SodacheTaskView:onInitView()
	self._goTaskItem = gohelper.findChild(self.viewGO, "root/left/#go_TaskItem")
	self._scrollCategory = gohelper.findChildScrollRect(self.viewGO, "root/left/#scroll_Category")
	self._goCategoryContent = gohelper.findChild(self.viewGO, "root/left/#scroll_Category/Viewport/#go_CategoryContent")
	self._goMainTitle = gohelper.findChild(self.viewGO, "root/left/#scroll_Category/Viewport/#go_CategoryContent/#go_MainTitle")
	self._goMainTaskRoot = gohelper.findChild(self.viewGO, "root/left/#scroll_Category/Viewport/#go_CategoryContent/#go_MainTaskRoot")
	self._goBranchTitle = gohelper.findChild(self.viewGO, "root/left/#scroll_Category/Viewport/#go_CategoryContent/#go_BranchTitle")
	self._goBranchTaskRoot = gohelper.findChild(self.viewGO, "root/left/#scroll_Category/Viewport/#go_CategoryContent/#go_BranchTaskRoot")
	self._scrollTaskInfo = gohelper.findChildScrollRect(self.viewGO, "root/right/#scroll_TaskInfo")
	self._txtName = gohelper.findChildText(self.viewGO, "root/right/#scroll_TaskInfo/Viewport/Content/Name/#txt_Name")
	self._txtTarget = gohelper.findChildText(self.viewGO, "root/right/#scroll_TaskInfo/Viewport/Content/Target/#txt_Target")
	self._txtDesc = gohelper.findChildText(self.viewGO, "root/right/#scroll_TaskInfo/Viewport/Content/Desc/#txt_Desc")
	self._goCurrency = gohelper.findChild(self.viewGO, "root/right/Layout/#go_Currency")
	self._txtCurrency = gohelper.findChildText(self.viewGO, "root/right/Layout/#go_Currency/#txt_Currency")
	self._goCurrencyLight = gohelper.findChild(self.viewGO, "root/right/Layout/#go_Currency/#go_CurrencyLight")
	self._scrollReward = gohelper.findChildScrollRect(self.viewGO, "root/right/Layout/#scroll_Reward")
	self._goCardItem = gohelper.findChild(self.viewGO, "root/right/Layout/#scroll_Reward/Viewport/Content/#go_CardItem")
	self._btnAccept = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_Accept")
	self._btnAbandon = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_Abandon")
	self._btnSubmit = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_Submit")
	self._btnClaim = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#btn_Claim")
	self._goFinish = gohelper.findChild(self.viewGO, "root/right/#go_Finish")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SodacheTaskView:addEvents()
	self._btnAccept:AddClickListener(self._btnAcceptOnClick, self)
	self._btnAbandon:AddClickListener(self._btnAbandonOnClick, self)
	self._btnSubmit:AddClickListener(self._btnSubmitOnClick, self)
	self._btnClaim:AddClickListener(self._btnClaimOnClick, self)
end

function SodacheTaskView:removeEvents()
	self._btnAccept:RemoveClickListener()
	self._btnAbandon:RemoveClickListener()
	self._btnSubmit:RemoveClickListener()
	self._btnClaim:RemoveClickListener()
end

local freshEvt = "refresh content"

function SodacheTaskView:_btnSubmitOnClick()
	if self.refreshing then
		return
	end

	local taskMo = self.taskMos[self.selectIndex]

	if taskMo and self.canSubmit then
		SodacheOutsideRpc.instance:sendSodacheTaskSubmitRequest(taskMo.id)
	end
end

function SodacheTaskView:_btnAcceptOnClick()
	if self.refreshing then
		return
	end

	local taskMo = self.taskMos[self.selectIndex]

	if taskMo then
		SodacheOutsideRpc.instance:sendSodacheTaskAcceptRequest({
			taskMo.id
		})
	end
end

function SodacheTaskView:_btnClaimOnClick()
	if self.refreshing then
		return
	end

	local taskMo = self.taskMos[self.selectIndex]

	if taskMo and taskMo.state == SodacheEnum.TaskState.Finished then
		if SodacheUtil.isInside() then
			GameFacade.showToast(ToastEnum.SodacheToastId373020)

			return
		end

		if taskMo.config.type == SodacheEnum.TaskType.Branch then
			self.findBranch = true
		end

		SodacheOutsideRpc.instance:sendSodacheTaskGainRewardRequest({
			taskMo.id
		})
	end
end

function SodacheTaskView:_btnAbandonOnClick()
	if self.refreshing then
		return
	end

	local taskMo = self.taskMos[self.selectIndex]

	if taskMo and taskMo.config.abandon == 1 then
		SodacheOutsideRpc.instance:sendSodacheTaskAbandonRequest({
			taskMo.id
		})
	end
end

function SodacheTaskView:_editableInitView()
	gohelper.setActive(self._goCurrencyLight, false)

	self._scrollHeight = recthelper.getHeight(self._goCategoryContent.transform.parent)

	gohelper.setActive(self._goCardItem, false)

	self.cardItemList = {}
	self.taskItemList = {}
	self.animRight = gohelper.findChildAnim(self.viewGO, "root/right")
	self.animRightEvent = self.animRight.gameObject:GetComponent(gohelper.Type_AnimationEventWrap)

	self.animRightEvent:AddEventListener(freshEvt, self.onFreshEnd, self)

	self.goCoin = gohelper.findChild(self.viewGO, "#go_topright/currencyview")
	self.currencyComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goCoin, SodacheCurrencyComp, {
		bagType = SodacheEnum.BagType.Outside
	})
end

function SodacheTaskView:onOpen()
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnTaskChange, self.onTaskChange, self)
	self.addEventCb(self, SodacheController.instance, SodacheEvent.OnClickTaskItem, self.onClickTask, self)

	self.taskBox = SodacheModel.instance:getOutsideMo().taskBox
	self.taskMos = self.taskBox:getShowTasks()

	self:refreshTask()
	self:selectTask()
end

function SodacheTaskView:onDestroyView()
	self.animRightEvent:RemoveEventListener(freshEvt)
	TaskDispatcher.cancelTask(self.delayHideLight, self)
	TaskDispatcher.cancelTask(self.delayFresh, self)
end

function SodacheTaskView:refreshTask()
	local hasMain, hasBranch

	for k, mo in ipairs(self.taskMos) do
		local isReceive = mo.state == SodacheEnum.TaskState.Received

		if not isReceive or mo.config.remove ~= 1 then
			local item = self.taskItemList[k]

			if not item then
				local go = gohelper.cloneInPlace(self._goTaskItem, "taskItem" .. k)

				item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheTaskItem, k)
				self.taskItemList[k] = item
			end

			local parent

			if mo.config.type == SodacheEnum.TaskType.Main then
				parent = self._goMainTaskRoot
				hasMain = true
			else
				parent = self._goBranchTaskRoot
				hasBranch = true
			end

			item:setParent(parent)
			item:setData(mo)
			gohelper.setActive(item.go, true)
		end
	end

	for i = #self.taskMos + 1, #self.taskItemList do
		gohelper.setActive(self.taskItemList[i].go, false)
	end

	gohelper.setActive(self._goMainTitle, hasMain)
	gohelper.setActive(self._goBranchTitle, hasBranch)
end

function SodacheTaskView:selectTask(force)
	local selectIndex
	local taskCnt = #self.taskMos

	if self.findBranch then
		for i = 1, taskCnt do
			local mo = self.taskMos[i]

			if mo.config.type == SodacheEnum.TaskType.Branch and mo.state ~= SodacheEnum.TaskState.Received or i == taskCnt then
				selectIndex = i

				break
			end
		end

		self.findBranch = false
	else
		for i = 1, taskCnt do
			local mo = self.taskMos[i]

			if mo.state ~= SodacheEnum.TaskState.Received or i == taskCnt then
				selectIndex = i

				break
			end
		end
	end

	if selectIndex then
		self:onClickTask(selectIndex, force)
	end
end

function SodacheTaskView:onClickTask(index, force)
	if not force and self.selectIndex == index then
		return
	end

	if self.selectIndex then
		self.taskItemList[self.selectIndex]:setSelect(false)
	end

	self.selectIndex = index

	local item = self.taskItemList[index]

	item:setSelect(true)

	if item.isNew then
		local key = PlayerPrefsKey.SodacheTaskItemNewTag .. item.data.id

		GameUtil.playerPrefsSetNumberByUserId(key, 1)
		item:refreshTag()
	end

	self.animRight:Play("refresh", 0, 0)
end

function SodacheTaskView:refreshTaskInfo()
	local taskMo = self.taskMos[self.selectIndex]

	if not taskMo then
		return
	end

	local config = taskMo.config

	self._txtName.text = config.name
	self._txtTarget.text = (taskMo.state == SodacheEnum.TaskState.Processing or taskMo.state == SodacheEnum.TaskState.Finished) and string.format("%s(%s/%s)", config.desc, taskMo.progress, config.maxProgress) or config.desc
	self._txtDesc.text = config.desc1

	local drops = GameUtil.splitString2(config.rewardShow, true, ":", "&")
	local hasCoin = false
	local count = 0

	for _, v in ipairs(drops) do
		local cardMo = SodacheCardMo.Create(v[1])

		if v[1] == SodacheEnum.CurrencyId.Coin then
			hasCoin = true

			if cardMo.serverMo.itemCo then
				if not cardMo.serverMo.itemCo.name then
					local name = ""

					self._txtCurrency.text = name .. luaLang("multiple") .. v[2]
				end
			end
		elseif cardMo.serverMo.itemType == SodacheEnum.ItemType.Card then
			count = count + 1

			local cardItem = self.cardItemList[count]

			if not cardItem then
				local go = gohelper.cloneInPlace(self._goCardItem)

				cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SodacheCardItem)

				cardItem:showInfo()

				self.cardItemList[count] = cardItem
			end

			cardItem:updateMo(cardMo)
			cardItem:setRate(v[2] == 1)
			gohelper.setActive(cardItem.go, true)
		end
	end

	gohelper.setActive(self._goCurrency, hasCoin)
	gohelper.setActive(self._scrollReward, count ~= 0)

	for i = count + 1, #self.cardItemList do
		gohelper.setActive(self.cardItemList[i].go, false)
	end

	gohelper.setActive(self._btnAccept, config.needAccept == 1 and taskMo.state == SodacheEnum.TaskState.Accept)
	gohelper.setActive(self._btnAbandon, config.abandon == 1 and taskMo.state == SodacheEnum.TaskState.Processing)
	gohelper.setActive(self._btnClaim, taskMo.state == SodacheEnum.TaskState.Finished)

	if config.listenerType == "submitItem" and taskMo.state == SodacheEnum.TaskState.Processing then
		local itemId = tonumber(config.listenerParam)
		local needCnt = config.maxProgress
		local hasCnt = SodacheUtil.getItemCount(itemId)

		self.canSubmit = needCnt <= hasCnt
		self._txtTarget.text = string.format("%s(%s/%s)", config.desc, hasCnt, needCnt)

		ZProj.UGUIHelper.SetGrayscale(self._btnSubmit.gameObject, not self.canSubmit)
		gohelper.setActive(self._btnSubmit, true)
	else
		self.canSubmit = false

		gohelper.setActive(self._btnSubmit, false)
	end

	gohelper.setActive(self._goFinish, taskMo.state == SodacheEnum.TaskState.Received)
end

function SodacheTaskView:onTaskChange()
	local newTaskMos = self.taskBox:getShowTasks()

	for index, mo in ipairs(self.taskMos) do
		if not tabletool.indexOf(newTaskMos, mo) then
			self.refreshing = self.refreshing or true

			self.taskItemList[index]:Hide()
		end
	end

	if self.refreshing then
		TaskDispatcher.runDelay(self.delayFresh, self, 0.35)
	else
		self:delayFresh()
	end
end

function SodacheTaskView:delayFresh()
	self.taskMos = self.taskBox:getShowTasks()

	self:refreshTask()
	self:selectTask(true)
	self:checkCoinChange()

	self.refreshing = false
end

function SodacheTaskView:onFreshEnd()
	self:refreshTaskInfo()
end

function SodacheTaskView:delayMove()
	self:moveToTask(self.selectIndex)
end

local titleHeight = 60
local categorySpace = 20
local taskSpace = 15
local taskHeight = 88

function SodacheTaskView:moveToTask(index)
	local targetPixel = 0
	local taskMo = self.taskMos[index]

	targetPixel = taskMo.config.type == SodacheEnum.TaskType.Main and titleHeight + categorySpace + (taskHeight + taskSpace) * (index - 1) - 30 or titleHeight * 2 + categorySpace * 3 - taskSpace + (taskHeight + taskSpace) * (index - 1) - 30

	local contentHeight = recthelper.getHeight(self._goCategoryContent.transform)
	local maxPixel = contentHeight - self._scrollHeight

	targetPixel = GameUtil.clamp(targetPixel, 0, maxPixel)
	self._scrollCategory.verticalNormalizedPosition = GameUtil.saturate(1 - targetPixel / maxPixel)
end

function SodacheTaskView:checkCoinChange()
	local outsideMo = SodacheModel.instance:getOutsideMo()
	local bagMo = outsideMo:getBag(SodacheEnum.BagType.Outside)

	if bagMo.coinChange then
		gohelper.setActive(self._goCurrencyLight, true)
		TaskDispatcher.runDelay(self.delayHideLight, self, 0.5)
		self.currencyComp:playAddAnim(bagMo.coinChange)
		bagMo:clearCoinChange()
	end
end

function SodacheTaskView:delayHideLight()
	gohelper.setActive(self._goCurrencyLight, false)
end

return SodacheTaskView
