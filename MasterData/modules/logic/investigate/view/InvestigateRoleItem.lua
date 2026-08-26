-- chunkname: @modules/logic/investigate/view/InvestigateRoleItem.lua

module("modules.logic.investigate.view.InvestigateRoleItem", package.seeall)

local InvestigateRoleItem = class("InvestigateRoleItem", ListScrollCellExtend)

function InvestigateRoleItem:onInitView()
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "role")
	self._golocked = gohelper.findChild(self.viewGO, "locked")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "clickarea")
	self._goprogress = gohelper.findChild(self.viewGO, "progress")
	self._goprogresitem = gohelper.findChild(self.viewGO, "progress/item")
	self._goreddot = gohelper.findChild(self.viewGO, "reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateRoleItem:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function InvestigateRoleItem:removeEvents()
	self._btnclick:RemoveClickListener()
end

function InvestigateRoleItem:_btnclickOnClick()
	if not self._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = self._mo
	})
end

function InvestigateRoleItem:_editableInitView()
	self._gounlockEffect = gohelper.findChild(self.viewGO, "#unlock")

	self.addEventCb(self, InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, self._onLinkedOpinionSuccess, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewCall, self)
end

function InvestigateRoleItem:_onCloseViewCall(viewName)
	if viewName == ViewName.InvestigateOpinionTabView then
		-- block empty
	end
end

function InvestigateRoleItem:_isShowRedDot()
	return self._isUnlocked and InvestigateController.showInfoRedDot(self._mo.id)
end

function InvestigateRoleItem:_onLinkedOpinionSuccess()
	self:_updateProgress()
end

function InvestigateRoleItem:_editableAddEvents()
	return
end

function InvestigateRoleItem:_editableRemoveEvents()
	return
end

function InvestigateRoleItem:onUpdateMO(mo)
	self._mo = mo
	self._isUnlocked = mo.episode == 0 or DungeonModel.instance:hasPassLevel(mo.episode)

	gohelper.setActive(self._simagerole, self._isUnlocked)
	gohelper.setActive(self._golocked, not self._isUnlocked)

	if self._isUnlocked and not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, self._mo.id) then
		gohelper.setActive(self._gounlockEffect, self._isUnlocked)
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, self._mo.id)
	end

	if self._isUnlocked then
		self._simagerole:LoadImage(mo.icon)
	end

	self:_initOpinionProgress()
end

function InvestigateRoleItem:_initOpinionProgress()
	self._progressItemList = self:getUserDataTb_()

	local data_list = InvestigateConfig.instance:getInvestigateRelatedClueInfos(self._mo.id)

	gohelper.CreateObjList(self, self._onItemShow, data_list, self._goprogress, self._goprogresitem)
	self:_updateProgress()
end

function InvestigateRoleItem:_onItemShow(obj, data, index)
	local t = self:getUserDataTb_()

	self._progressItemList[index] = t
	t.unfinished = gohelper.findChild(obj, "unfinished")
	t.finished = gohelper.findChild(obj, "finished")
	t.light = gohelper.findChild(obj, "light")
	t.reddot = gohelper.findChild(obj, "reddot")
	t.config = data
end

function InvestigateRoleItem:_updateProgress()
	for i, v in ipairs(self._progressItemList) do
		local clueId = v.config.id
		local isFinished = InvestigateOpinionModel.instance:getLinkedStatus(clueId)

		gohelper.setActive(v.unfinished, not isFinished)
		gohelper.setActive(v.finished, isFinished)

		local isUnlocked = InvestigateOpinionModel.instance:isUnlocked(clueId) and self._isUnlocked

		gohelper.setActive(v.reddot, isUnlocked and not isFinished)
	end
end

function InvestigateRoleItem:onSelect(isSelect)
	return
end

function InvestigateRoleItem:onDestroyView()
	return
end

return InvestigateRoleItem
