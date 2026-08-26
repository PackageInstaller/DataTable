-- chunkname: @modules/logic/investigate/view/InvestigateRoleMultiItem.lua

module("modules.logic.investigate.view.InvestigateRoleMultiItem", package.seeall)

local InvestigateRoleMultiItem = class("InvestigateRoleMultiItem", ListScrollCellExtend)

function InvestigateRoleMultiItem:onInitView()
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "role")
	self._btn1click = gohelper.findChildButtonWithAudio(self.viewGO, "role_1/click")
	self._btn2click = gohelper.findChildButtonWithAudio(self.viewGO, "role_2/click")
	self._btn3click = gohelper.findChildButtonWithAudio(self.viewGO, "role_3/click")
	self._btnallclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_fullimg/click")
	self._goprogress = gohelper.findChild(self.viewGO, "progress")
	self._goprogresitem = gohelper.findChild(self.viewGO, "progress/item")
	self._goreddot = gohelper.findChild(self.viewGO, "reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateRoleMultiItem:addEvents()
	self._btn1click:AddClickListener(self._btnclick1OnClick, self)
	self._btn2click:AddClickListener(self._btnclick2OnClick, self)
	self._btn3click:AddClickListener(self._btnclick3OnClick, self)
	self._btnallclick:AddClickListener(self._btnclickallOnClick, self)
end

function InvestigateRoleMultiItem:removeEvents()
	self._btn1click:RemoveClickListener()
	self._btn2click:RemoveClickListener()
	self._btn3click:RemoveClickListener()
	self._btnallclick:RemoveClickListener()
end

function InvestigateRoleMultiItem:_btnclickallOnClick()
	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = self._moList[1],
		moList = self._moList
	})
end

function InvestigateRoleMultiItem:_btnclick3OnClick()
	if not self._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = self._moList[3],
		moList = self._moList
	})
end

function InvestigateRoleMultiItem:_btnclick2OnClick()
	if not self._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = self._moList[2],
		moList = self._moList
	})
end

function InvestigateRoleMultiItem:_btnclick1OnClick()
	if not self._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = self._moList[1],
		moList = self._moList
	})
end

function InvestigateRoleMultiItem:_editableInitView()
	self._gofullimg = gohelper.findChild(self.viewGO, "#go_fullimg")
	self._goUnFinishedBg = gohelper.findChild(self.viewGO, "#simage_bg")

	self.addEventCb(self, InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, self._onLinkedOpinionSuccess, self)

	self._gounlock1 = gohelper.findChild(self.viewGO, "#unlock1")
	self._gounlock2 = gohelper.findChild(self.viewGO, "#unlock2")
	self._gounlock3 = gohelper.findChild(self.viewGO, "#unlock3")

	gohelper.setActive(self._gounlock1, false)
	gohelper.setActive(self._gounlock2, false)
	gohelper.setActive(self._gounlock3, false)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewCall, self)
end

function InvestigateRoleMultiItem:_onCloseViewCall(viewName)
	if viewName == ViewName.InvestigateOpinionTabView then
		-- block empty
	end
end

function InvestigateRoleMultiItem:_isShowRedDot()
	return self._isUnlocked and InvestigateController.showInfoRedDot(self._mo.id)
end

function InvestigateRoleMultiItem:_onLinkedOpinionSuccess()
	self:_initOpinionProgress()
	self:_checkFinish()
end

function InvestigateRoleMultiItem:_editableAddEvents()
	return
end

function InvestigateRoleMultiItem:_editableRemoveEvents()
	return
end

function InvestigateRoleMultiItem:onUpdateMO(list)
	self._moList = list

	self:_checkFinish()

	if not self._roleList then
		self._roleList = self:getUserDataTb_()

		for i = 1, #list do
			local role = gohelper.findChildSingleImage(self.viewGO, string.format("role_%s", i))
			local lock = gohelper.findChild(self.viewGO, string.format("role_%s_locked", i))

			self._roleList[i] = {
				role = role,
				lock = lock
			}
		end
	end

	for i, mo in ipairs(list) do
		local info = self._roleList[i]
		local isUnlocked = mo.episode == 0 or DungeonModel.instance:hasPassLevel(mo.episode)

		gohelper.setActive(info.role, isUnlocked and not self._isAllFinished)
		gohelper.setActive(info.lock, not isUnlocked and not self._isAllFinished)
	end

	self._mo = list[1]
	self._isUnlocked = self._mo.episode == 0 or DungeonModel.instance:hasPassLevel(self._mo.episode)

	if self._isUnlocked and not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, self._mo.id) and not self._isAllFinished then
		gohelper.setActive(self._gounlock1, true)
		gohelper.setActive(self._gounlock2, true)
		gohelper.setActive(self._gounlock3, true)
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, self._mo.id)
	end

	self:_initOpinionProgress()
end

function InvestigateRoleMultiItem:_initOpinionProgress()
	self._progressItemList = self:getUserDataTb_()

	local data_list = {}

	for i, v in ipairs(self._moList) do
		local list = InvestigateConfig.instance:getInvestigateRelatedClueInfos(v.id)

		tabletool.addValues(data_list, list)
	end

	gohelper.CreateObjList(self, self._onItemShow, data_list, self._goprogress, self._goprogresitem)
	self:_updateProgress()
end

function InvestigateRoleMultiItem:_onItemShow(obj, data, index)
	local t = self:getUserDataTb_()

	self._progressItemList[index] = t
	t.unfinished = gohelper.findChild(obj, "unfinished")
	t.finished = gohelper.findChild(obj, "finished")
	t.light = gohelper.findChild(obj, "light")
	t.reddot = gohelper.findChild(obj, "reddot")
	t.config = data
end

function InvestigateRoleMultiItem:_updateProgress()
	for i, v in ipairs(self._progressItemList) do
		local clueId = v.config.id
		local isFinished = InvestigateOpinionModel.instance:getLinkedStatus(clueId)

		gohelper.setActive(v.unfinished, not isFinished)
		gohelper.setActive(v.finished, isFinished)

		local isUnlocked = InvestigateOpinionModel.instance:isUnlocked(clueId) and self._isUnlocked

		gohelper.setActive(v.reddot, isUnlocked and not isFinished)
	end
end

function InvestigateRoleMultiItem:_allFinished()
	if not self._moList then
		return false
	end

	for i, mo in ipairs(self._moList) do
		if not InvestigateOpinionModel.instance:allOpinionLinked(mo.id) then
			return false
		end
	end

	return true
end

function InvestigateRoleMultiItem:_checkFinish()
	self._isAllFinished = self:_allFinished()

	gohelper.setActive(self._gofullimg, self._isAllFinished)
	gohelper.setActive(self._goUnFinishedBg, not self._isAllFinished)
end

function InvestigateRoleMultiItem:onSelect(isSelect)
	return
end

function InvestigateRoleMultiItem:onDestroyView()
	return
end

return InvestigateRoleMultiItem
