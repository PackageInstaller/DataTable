-- chunkname: @modules/logic/room/view/RoomSceneTaskDetailView.lua

module("modules.logic.room.view.RoomSceneTaskDetailView", package.seeall)

local RoomSceneTaskDetailView = class("RoomSceneTaskDetailView", BaseView)

function RoomSceneTaskDetailView:onInitView()
	self._gotask1 = gohelper.findChild(self.viewGO, "taskContent/#go_task1")
	self._gotask2 = gohelper.findChild(self.viewGO, "taskContent/#go_task2")
	self._gotask3 = gohelper.findChild(self.viewGO, "taskContent/#go_task3")
	self._gotask4 = gohelper.findChild(self.viewGO, "taskContent/#go_task4")
	self._gotask5 = gohelper.findChild(self.viewGO, "taskContent/#go_task5")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomSceneTaskDetailView:addEvents()
	return
end

function RoomSceneTaskDetailView:removeEvents()
	return
end

RoomSceneTaskDetailView.PageShowNum = 5

function RoomSceneTaskDetailView:_editableInitView()
	self._itemObjs = {}
	self._bgmask = gohelper.findChildSingleImage(self.viewGO, "#bg_mask")
end

function RoomSceneTaskDetailView:onDestroyView()
	for index, itemObj in pairs(self._itemObjs) do
		if not gohelper.isNil(itemObj.btntouch) then
			itemObj.btntouch:RemoveClickListener()
		end

		if not gohelper.isNil(itemObj.simagebonus) then
			itemObj.simagebonus:UnLoadImage()
		end

		if index == 1 then
			itemObj.btnEdit:RemoveClickListener()
			itemObj.btnExpansion:RemoveClickListener()
		end
	end
end

function RoomSceneTaskDetailView:onOpen()
	self._curPage = 1

	self.addEventCb(self, RoomSceneTaskController.instance, RoomEvent.TaskUpdate, self.refreshUI, self)
	self:refreshUI()
end

function RoomSceneTaskDetailView:onClose()
	return
end

function RoomSceneTaskDetailView:refreshUI()
	for i = 1, RoomSceneTaskDetailView.PageShowNum do
		self:refreshItem(i)
	end
end

function RoomSceneTaskDetailView.onClickTask(param)
	local self = param.self
	local index = param.index
	local curIndex = index + (self._curPage - 1) * RoomSceneTaskDetailView.PageShowNum
	local taskCOList = RoomTaskModel.instance:getShowList()
	local taskCO = taskCOList[curIndex]

	if not taskCO then
		return
	end

	local taskMO = RoomTaskModel.instance:tryGetTaskMO(taskCO.id)

	if taskMO and index == 1 then
		self:showMaterialInfoByTaskConfig(taskCO)
	elseif taskCO then
		if RoomSceneTaskController.isTaskOverUnlockLevel(taskCO) then
			GameFacade.showToast(ToastEnum.RoomTaskUnlock)
		else
			GameFacade.showToast(ToastEnum.RoomSceneTaskOpen, taskCO.name)
		end
	end
end

function RoomSceneTaskDetailView:onClickJump()
	local taskCOList = RoomTaskModel.instance:getShowList()

	if taskCOList and #taskCOList > 0 then
		local taskCO = taskCOList[1]
		local taskMO = RoomTaskModel.instance:tryGetTaskMO(taskCO.id)

		if taskMO then
			local needStay = RoomSceneTaskDetailController.instance:goToTask(taskCO)

			if not needStay then
				self:closeThis()
			end
		end
	end
end

function RoomSceneTaskDetailView:showMaterialInfoByTaskConfig(taskCO)
	local bonusArr = string.split(taskCO.bonus, "|")

	if #bonusArr > 0 then
		local bonusArr = string.splitToNumber(bonusArr[1], "#")
		local itemType, itemId = tonumber(bonusArr[1]), tonumber(bonusArr[2])
		local itemCo, icon = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)

		MaterialTipController.instance:showMaterialInfo(itemType, itemId, false, nil, true)
	end
end

function RoomSceneTaskDetailView:getOrCreateItem(index)
	local itemObj = self._itemObjs[index]

	if not itemObj then
		itemObj = self:getUserDataTb_()
		itemObj.go = self["_gotask" .. tostring(index)]
		itemObj.gofinish = gohelper.findChild(itemObj.go, "go_finish")
		itemObj.gounfinish = gohelper.findChild(itemObj.go, "go_unfinish")
		itemObj.golock = gohelper.findChild(itemObj.go, "go_unfinish/go_lock")
		itemObj.txtlock = gohelper.findChildText(itemObj.go, "go_unfinish/go_lock/txt_lock")
		itemObj.gorunning = gohelper.findChild(itemObj.go, "go_running")
		itemObj.goorderbg = gohelper.findChild(itemObj.go, "go_lightbg")
		itemObj.txtid = gohelper.findChildText(itemObj.go, "txt_id")

		if index == 1 then
			itemObj.goJump = gohelper.findChild(itemObj.go, "#go_jump")
			itemObj.txtnum = gohelper.findChildText(itemObj.goJump, "txt_rewardnum")
			itemObj.txtdesc = gohelper.findChildText(itemObj.goJump, "txt_taskdesc")
			itemObj.txtRunningTips = gohelper.findChildText(itemObj.goJump, "txt_rewardtip")
			itemObj.simagebonus = gohelper.findChildSingleImage(itemObj.goJump, "simage_reward")
			itemObj.imagebonus = gohelper.findChildImage(itemObj.goJump, "simage_reward")
			itemObj.btnEdit = gohelper.findChildButtonWithAudio(itemObj.goJump, "btn_edit")
			itemObj.btnExpansion = gohelper.findChildButtonWithAudio(itemObj.goJump, "btn_expansion")
			itemObj.btntouch = gohelper.findChildButtonWithAudio(itemObj.goJump, "btn_touch")

			itemObj.btnEdit:AddClickListener(self.onClickJump, self)
			itemObj.btnExpansion:AddClickListener(self.onClickJump, self)

			local btnTouchOutside = gohelper.findChild(itemObj.go, "btn_touch")

			gohelper.setActive(btnTouchOutside, false)
		else
			itemObj.txtnum = gohelper.findChildText(itemObj.go, "go_unfinish/txt_num")
			itemObj.txtdesc = gohelper.findChildText(itemObj.go, "go_unfinish/txt_desc")
			itemObj.simagebonus = gohelper.findChildSingleImage(itemObj.go, "go_unfinish/simage_build")
			itemObj.imagebonus = gohelper.findChildImage(itemObj.go, "go_unfinish/simage_build")
			itemObj.btntouch = gohelper.findChildButtonWithAudio(itemObj.go, "btn_touch")
		end

		itemObj.btntouch:AddClickListener(self.onClickTask, {
			self = self,
			index = index
		})

		self._itemObjs[index] = itemObj
	end

	return itemObj
end

local _colorLock = Color.New(0.090196, 0.08627451, 0.08627451, 1)
local _colorLockTxt = Color.New(0.8980392, 0.8980392, 0.8980392, 0.5)
local _colorIdLockTxt = Color.New(0.5372549, 0.5215687, 0.5176471, 1)
local _colorIdTxt = Color.New(0.8980392, 0.8980392, 0.8980392, 1)

function RoomSceneTaskDetailView:refreshItem(index)
	local itemObj = self:getOrCreateItem(index)
	local curIndex = index + (self._curPage - 1) * RoomSceneTaskDetailView.PageShowNum
	local taskCOList = RoomTaskModel.instance:getShowList()
	local taskCO = taskCOList[curIndex]
	local taskMO

	if taskCO then
		taskMO = RoomTaskModel.instance:tryGetTaskMO(taskCO.id)
	end

	local showRunning = false

	if taskMO and index == 1 then
		self:refreshWhenRunning(itemObj, taskMO, taskCO)

		showRunning = true
	elseif not taskCO then
		self:refreshWhenFinish(itemObj)
	else
		self:refreshWhenLock(itemObj, taskCO)
	end

	if not gohelper.isNil(itemObj.gorunning) then
		gohelper.setActive(itemObj.gorunning, showRunning)
	end
end

function RoomSceneTaskDetailView:refreshWhenRunning(itemObj, taskMO, taskCO)
	gohelper.setActive(itemObj.gofinish, false)
	gohelper.setActive(itemObj.gounfinish, false)
	gohelper.setActive(itemObj.goJump, true)
	gohelper.setActive(itemObj.golock, false)
	gohelper.setActive(itemObj.goorderbg, true)

	local descStr = taskMO.hasFinished == true and "%s(%s/%s)" or "%s(<color=#b26161>%s</color>/%s)"

	itemObj.txtdesc.text = string.format(descStr, taskCO.desc, taskMO.progress, taskCO.maxProgress)

	self:setRewardIcon(taskCO, itemObj, true)

	local goToExpansion = false
	local goToEdit = false

	if not taskCO.tips then
		local tipsStr = ""

		if taskCO.listenerType == RoomSceneTaskEnum.ListenerType.EditResArea or taskCO.listenerType == RoomSceneTaskEnum.ListenerType.EditHasResBlockCount then
			goToEdit = true
		elseif taskCO.listenerType == RoomSceneTaskEnum.ListenerType.RoomLevel then
			goToExpansion = true

			local levelItemCount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, RoomSceneTaskEnum.RoomLevelUpItem)
			local txtStr = tostring(levelItemCount)

			if not string.nilorempty(tipsStr) then
				tipsStr = string.format(tipsStr, (levelItemCount > 0 or nil) and string.format("<color=#ffffff>%s</color>", levelItemCount))
			end
		end

		if not string.nilorempty(tipsStr) then
			itemObj.txtRunningTips.text = tipsStr

			gohelper.setActive(itemObj.txtRunningTips, true)
		else
			gohelper.setActive(itemObj.txtRunningTips, false)
		end

		gohelper.setActive(itemObj.btnExpansion, goToExpansion)
		gohelper.setActive(itemObj.btnEdit, goToEdit)

		itemObj.imagebonus.color = Color.white
		itemObj.txtdesc.color = Color.white
		itemObj.txtid.color = _colorIdTxt
		itemObj.txtid.text = taskCO.order
	end
end

function RoomSceneTaskDetailView:refreshWhenFinish(itemObj)
	gohelper.setActive(itemObj.gofinish, true)
	gohelper.setActive(itemObj.gounfinish, false)
	gohelper.setActive(itemObj.goorderbg, false)

	if itemObj.goJump then
		gohelper.setActive(itemObj.goJump, false)
	end

	itemObj.txtid.text = ""
end

function RoomSceneTaskDetailView:refreshWhenLock(itemObj, taskCO)
	gohelper.setActive(itemObj.gofinish, false)
	gohelper.setActive(itemObj.gounfinish, true)
	gohelper.setActive(itemObj.golock, true)
	gohelper.setActive(itemObj.goorderbg, false)

	if itemObj.goJump then
		gohelper.setActive(itemObj.goJump, false)
	end

	itemObj.txtdesc.text = taskCO.desc

	if not gohelper.isNil(itemObj.txtlock) then
		itemObj.txtlock.text = RoomSceneTaskController.isTaskOverUnlockLevel(taskCO) and luaLang("room_task_lock_by_task") or string.format(luaLang("room_task_lock_by_level"), RoomSceneTaskController.getTaskUnlockLevel(taskCO.openLimit))
	end

	self:setRewardIcon(taskCO, itemObj, false)

	itemObj.imagebonus.color = _colorLock
	itemObj.txtdesc.color = _colorLockTxt
	itemObj.txtid.color = _colorIdLockTxt
	itemObj.txtid.text = taskCO.order
end

function RoomSceneTaskDetailView:setRewardIcon(taskCO, itemObj, showCount)
	local itemCo, icon, count = RoomSceneTaskController.getRewardConfigAndIcon(taskCO)

	if not string.nilorempty(taskCO.bonusIcon) then
		icon = ResUrl.getRoomTaskBonusIcon(taskCO.bonusIcon)
	end

	if not string.nilorempty(icon) then
		itemObj.simagebonus:LoadImage(icon)
	end

	if count and showCount then
		gohelper.setActive(itemObj.txtnum.gameObject, true)

		itemObj.txtnum.text = tostring(GameUtil.numberDisplay(count))
	else
		gohelper.setActive(itemObj.txtnum.gameObject, false)
	end
end

function RoomSceneTaskDetailView:getMaxPage()
	local showList = RoomTaskModel.instance:getShowList()

	return math.ceil(#showList / RoomSceneTaskDetailView.PageShowNum)
end

return RoomSceneTaskDetailView
