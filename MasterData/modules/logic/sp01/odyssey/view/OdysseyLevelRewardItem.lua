-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyLevelRewardItem.lua

module("modules.logic.sp01.odyssey.view.OdysseyLevelRewardItem", package.seeall)

local OdysseyLevelRewardItem = class("OdysseyLevelRewardItem", ListScrollCellExtend)

function OdysseyLevelRewardItem:onInitView()
	self._goLock = gohelper.findChild(self.viewGO, "title/go_lock")
	self._txtLockLevel = gohelper.findChildText(self.viewGO, "title/go_lock/txt_lockLevel")
	self._goHasGet = gohelper.findChild(self.viewGO, "title/go_hasget")
	self._txtHasGetLevel = gohelper.findChildText(self.viewGO, "title/go_hasget/txt_hasgetLevel")
	self._goCanGet = gohelper.findChild(self.viewGO, "title/go_canget")
	self._txtCanGetLevel = gohelper.findChildText(self.viewGO, "title/go_canget/txt_cangetLevel")
	self._goRewardContent = gohelper.findChild(self.viewGO, "go_rewardContent")
	self._goRewardItem = gohelper.findChild(self.viewGO, "go_rewardContent/go_rewardItem")
	self._goLine = gohelper.findChild(self.viewGO, "go_line")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyLevelRewardItem:addEvents()
	return
end

function OdysseyLevelRewardItem:removeEvents()
	return
end

function OdysseyLevelRewardItem:onRewardItemClick(rewardItem)
	if self.isCanGet then
		local allCanGetIdList = OdysseyTaskModel.instance:getAllCanGetIdList(OdysseyEnum.TaskType.LevelReward)

		if #allCanGetIdList > 1 then
			TaskRpc.instance:sendFinishAllTaskRequest(TaskEnum.TaskType.Odyssey, 0, allCanGetIdList, nil, nil, 0)
		else
			TaskRpc.instance:sendFinishTaskRequest(self.taskId)
		end
	else
		MaterialTipController.instance:showMaterialInfo(rewardItem.rewardData[1], rewardItem.rewardData[2])
	end
end

function OdysseyLevelRewardItem:_editableInitView()
	self.rewardItemTab = self:getUserDataTb_()

	gohelper.setActive(self._goRewardItem, false)

	self.taskList = OdysseyTaskModel.instance:getCurTaskList(OdysseyEnum.TaskType.LevelReward)
end

function OdysseyLevelRewardItem:onUpdateMO(mo)
	if mo == nil then
		return
	end

	self.mo = mo

	self:refreshUI()
end

function OdysseyLevelRewardItem:refreshUI()
	self.taskId = self.mo.id
	self.config = self.mo.config
	self.level = self.config.maxProgress

	gohelper.setActive(self.viewGO, true)

	self._txtLockLevel.text = "LV." .. self.level
	self._txtHasGetLevel.text = "LV." .. self.level
	self._txtCanGetLevel.text = "LV." .. self.level

	gohelper.setActive(self._goLine, self.taskId ~= self.taskList[#self.taskList].id)
	self:refreshReward()
end

function OdysseyLevelRewardItem:refreshReward()
	self.isHasGet = OdysseyTaskModel.instance:isTaskHasGet(self.mo)
	self.isCanGet = OdysseyTaskModel.instance:isTaskCanGet(self.mo)

	local config = self.mo.config
	local rewardList = GameUtil.splitString2(config.bonus, true)

	for index, rewardData in ipairs(rewardList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				go = gohelper.clone(self._goRewardItem, self._goRewardContent, "rewardItem_" .. index)
			}
			rewardItem.imageRare = gohelper.findChildImage(rewardItem.go, "image_rare")
			rewardItem.simageReward = gohelper.findChildSingleImage(rewardItem.go, "simage_reward")
			rewardItem.goCanGet = gohelper.findChild(rewardItem.go, "go_canget")
			rewardItem.goHasGet = gohelper.findChild(rewardItem.go, "go_hasget")
			rewardItem.txtRewardCount = gohelper.findChildText(rewardItem.go, "mask/txt_rewardcount")
			rewardItem.txtRewardCountGrey = gohelper.findChildText(rewardItem.go, "mask/txt_rewardcount_grey")
			rewardItem.btnClick = gohelper.findChildButton(rewardItem.go, "btn_click")

			rewardItem.btnClick:AddClickListener(self.onRewardItemClick, self, rewardItem)

			self.rewardItemTab[index] = rewardItem
		end

		rewardItem.rewardData = rewardData
		rewardItem.config, rewardItem.icon = ItemModel.instance:getItemConfigAndIcon(rewardData[1], rewardData[2], true)

		gohelper.setActive(rewardItem.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(rewardItem.imageRare, "bg_pinjidi_" .. tostring(rewardItem.config.rare), nil)

		if rewardItem.config.subType == ItemEnum.SubType.Portrait then
			rewardItem.simageReward:LoadImage(ResUrl.getPlayerHeadIcon(rewardItem.config.icon), function()
				ZProj.UGUIHelper.SetImageSize(rewardItem.simageReward.gameObject)
			end)
		else
			rewardItem.simageReward:LoadImage(rewardItem.icon, function()
				ZProj.UGUIHelper.SetImageSize(rewardItem.simageReward.gameObject)
			end)
		end

		rewardItem.txtRewardCount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), rewardData[3])
		rewardItem.txtRewardCountGrey.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), rewardData[3])

		gohelper.setActive(rewardItem.goHasGet, self.isHasGet)
		gohelper.setActive(rewardItem.goCanGet, self.isCanGet)
		gohelper.setActive(rewardItem.txtRewardCount, not self.isHasGet)
		gohelper.setActive(rewardItem.txtRewardCountGrey, self.isHasGet)
	end

	for index = #rewardList + 1, #self.rewardItemTab do
		local rewardItem = self.rewardItemTab[index]

		if rewardItem then
			gohelper.setActive(rewardItem.itemIcon.go, false)
		end
	end

	gohelper.setActive(self._goLock, not self.isCanGet and not self.isHasGet)
	gohelper.setActive(self._goHasGet, self.isHasGet)
	gohelper.setActive(self._goCanGet, self.isCanGet)
end

function OdysseyLevelRewardItem:onDestroyView()
	if self.rewardItemTab then
		for _, item in pairs(self.rewardItemTab) do
			item.simageReward:UnLoadImage()
			item.btnClick:RemoveClickListener()
		end

		self.rewardItemTab = nil
	end
end

return OdysseyLevelRewardItem
