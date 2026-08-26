-- chunkname: @modules/logic/versionactivity3_5/schoolstart/view/V3a5_SchoolStartTaskItem.lua

module("modules.logic.versionactivity3_5.schoolstart.view.V3a5_SchoolStartTaskItem", package.seeall)

local V3a5_SchoolStartTaskItem = class("V3a5_SchoolStartTaskItem", ListScrollCellExtend)

function V3a5_SchoolStartTaskItem:onInitView()
	self._txttaskdes = gohelper.findChildText(self.viewGO, "go_common/txt_taskdes")
	self._gorewards = gohelper.findChild(self.viewGO, "go_common/go_rewards")
	self._btnfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "go_common/btn_finishbg")
	self._btnnotfinishbg = gohelper.findChildButtonWithAudio(self.viewGO, "go_common/btn_notfinishbg")
	self._goget = gohelper.findChild(self.viewGO, "go_common/go_get")
	self._gotag = gohelper.findChild(self.viewGO, "go_common/#go_Tag")
	self._txttag = gohelper.findChildText(self.viewGO, "go_common/#go_Tag/txt_Daily")
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a5_SchoolStartTaskItem:addEvents()
	self._btnfinishbg:AddClickListener(self._btnfinishbgOnClick, self)
	self._btnnotfinishbg:AddClickListener(self._btnnotfinishbgOnClick, self)
end

function V3a5_SchoolStartTaskItem:removeEvents()
	self._btnfinishbg:RemoveClickListener()
	self._btnnotfinishbg:RemoveClickListener()
end

function V3a5_SchoolStartTaskItem:_btnfinishbgOnClick()
	self._animator:Play("finish", 0, 0)
	gohelper.setActive(self._goget, true)
	TaskDispatcher.runDelay(self._onSendTaskFinish, self, 0.67)
end

function V3a5_SchoolStartTaskItem:_btnnotfinishbgOnClick()
	if self._mo.config.jumpId > 0 then
		GameFacade.jump(self._mo.config.jumpId)
	end
end

function V3a5_SchoolStartTaskItem:_onSendTaskFinish()
	TaskRpc.instance:sendFinishTaskRequest(self._mo.id)
end

function V3a5_SchoolStartTaskItem:onUpdateMO(mo)
	self._mo = mo
	self._txttaskdes.text = string.format("%s(%s/%s)", self._mo.config.desc, self._mo.progress, self._mo.config.maxProgress)

	if self._mo.hasFinished then
		gohelper.setActive(self._goget, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._btnfinishbg.gameObject, true)
	elseif self._mo.finishCount > 0 then
		gohelper.setActive(self._goget, true)
		gohelper.setActive(self._btnnotfinishbg.gameObject, false)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
	else
		gohelper.setActive(self._goget, false)
		gohelper.setActive(self._btnnotfinishbg.gameObject, true)
		gohelper.setActive(self._btnfinishbg.gameObject, false)
	end

	local isShowTag = not string.nilorempty(self._mo.config.tag)

	gohelper.setActive(self._gotag, isShowTag)

	if isShowTag then
		self._txttag.text = self._mo.config.tag
	end

	self:refreshRewardItems()
end

function V3a5_SchoolStartTaskItem:refreshRewardItems()
	if not self._mo.config or not self._mo.config.bonus then
		return
	end

	local rewardCo = string.splitToNumber(self._mo.config.bonus, "#")
	local type, id, quantity = rewardCo[1], rewardCo[2], rewardCo[3]

	if not self._rewardComp then
		self._rewardComp = self:getUserDataTb_()
		self._rewardComp = IconMgr.instance:getCommonPropItemIcon(self._gorewards)
	end

	self._rewardComp:setMOValue(type, id, quantity, nil, true)
	self._rewardComp:setCountFontSize(40)
	self._rewardComp:showStackableNum2()
	self._rewardComp:isShowEffect(true)
end

function V3a5_SchoolStartTaskItem:getAnimator()
	return self._animator
end

function V3a5_SchoolStartTaskItem:onSelect(isSelect)
	return
end

function V3a5_SchoolStartTaskItem:onDestroyView()
	return
end

return V3a5_SchoolStartTaskItem
