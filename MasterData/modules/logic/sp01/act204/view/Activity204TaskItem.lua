-- chunkname: @modules/logic/sp01/act204/view/Activity204TaskItem.lua

module("modules.logic.sp01.act204.view.Activity204TaskItem", package.seeall)

local Activity204TaskItem = class("Activity204TaskItem", ListScrollCellExtend)

function Activity204TaskItem:onInitView()
	self.txtIndex = gohelper.findChildTextMesh(self.viewGO, "txtIndex")
	self.scrollDesc = gohelper.findChild(self.viewGO, "#scroll_Desc"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "#scroll_Desc/Viewport/Content/txt_Desc")
	self.goReward = gohelper.findChild(self.viewGO, "#go_reward")
	self.txtNum = gohelper.findChildTextMesh(self.goReward, "#txt_num")
	self.btnCanget = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_canget")
	self.goReceive = gohelper.findChild(self.viewGO, "btn/#go_finished")
	self.btnJump = gohelper.findChildButtonWithAudio(self.viewGO, "btn/#btn_jump")
	self.goDoing = gohelper.findChild(self.viewGO, "btn/#go_doing")
	self.goLightBg = gohelper.findChild(self.goReward, "go_lightbg")
	self.gotime = gohelper.findChild(self.viewGO, "time")
	self.txttime = gohelper.findChildText(self.viewGO, "time/#txt_time")
	self.gosecretbg = gohelper.findChild(self.viewGO, "#go_SecretBG")
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.isOpen = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity204TaskItem:addEvents()
	self.btnCanget:AddClickListener(self.onClickBtnCanget, self)
	self.btnJump:AddClickListener(self.onClickBtnJump, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenViewFinish, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullViewFinish, self._onCloseViewFinish, self)
end

function Activity204TaskItem:removeEvents()
	self.btnCanget:RemoveClickListener()
	self.btnJump:RemoveClickListener()
end

function Activity204TaskItem:_editableInitView()
	return
end

function Activity204TaskItem:onClickBtnCanget()
	if not self._mo or not self._mo.canGetReward then
		return
	end

	self.anim:Play("close", 0, 0)

	if self._mo.isGlobalTask then
		TaskRpc.instance:sendFinishTaskRequest(self.config.id)
	else
		Activity204Rpc.instance:sendFinishAct204TaskRequest(self.config.activityId, self.config.id)
	end
end

function Activity204TaskItem:onClickBtnJump()
	if not self._mo then
		return
	end

	local config = self._mo.config
	local jumpId = config.jumpId

	if jumpId and jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end
end

function Activity204TaskItem:onUpdateMO(mo)
	self.scrollDesc.parentGameObject = self._view._csListScroll.gameObject

	if self.isOpen then
		self.anim:Play("open", 0, 0)
	else
		self.anim:Play("open", 0, 1)
	end

	self.isOpen = false
	self._mo = mo
	self.config = self._mo.config

	self:refreshDesc()
	self:refreshJump()
	self:refreshReward()
	self:refreshSecretTask()
	self:refreshRemainTime()
end

function Activity204TaskItem:refreshDesc()
	self.txtIndex.text = string.format("%02d", self._mo.index)

	local progress = Activity173Controller.numberDisplay(self._mo.progress)

	if self.config then
		local maxProgress = Activity173Controller.numberDisplay(self.config.maxProgress or 0)

		self.txtDesc.text = string.format("%s\n(%s/%s)", (self.config or nil) and (self.config.desc or ""), progress, maxProgress)
	end
end

function Activity204TaskItem:refreshSecretTask()
	self._isSecretTask = not self._mo.isGlobalTask and self.config.secretornot ~= 0
	self._isNewSecretTask = self._isSecretTask and Activity204Controller.instance:getPlayerPrefs(self:_getSecretTaskEffectKey(), 0) == 0

	gohelper.setActive(self.gosecretbg, self._isSecretTask)
	gohelper.setActive(self.txtIndex.gameObject, not self._isSecretTask)
	self:tryPlaySecretEffect()
end

function Activity204TaskItem:_getSecretTaskEffectKey()
	return string.format("%s#%s", PlayerPrefsKey.Activity204SecretTaskEffect, self.config.id)
end

function Activity204TaskItem:tryPlaySecretEffect()
	if not self._isNewSecretTask then
		return
	end

	self.anim:Play("close", 0, 1)

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.Activity204TaskView) then
		return
	end

	self.anim:Play("open_secret", 0, 0)

	self._isNewSecretTask = false

	Activity204Controller.instance:setPlayerPrefs(self:_getSecretTaskEffectKey(), 1)
end

function Activity204TaskItem:refreshJump()
	local canGetReward = self._mo.canGetReward
	local hasGetReward = self._mo.hasGetBonus

	gohelper.setActive(self.btnCanget, canGetReward)
	gohelper.setActive(self.goLightBg, canGetReward)
	gohelper.setActive(self.goReceive, hasGetReward)

	local config = self._mo.config
	local jumpId = config.jumpId
	local canShowJump = jumpId and jumpId ~= 0 and not canGetReward and not hasGetReward

	gohelper.setActive(self.btnJump, canShowJump)

	local isDoing = not canGetReward and not hasGetReward and not canShowJump

	gohelper.setActive(self.goDoing, isDoing)
end

function Activity204TaskItem:refreshReward()
	local var_13_1 = GameUtil.splitString2(self.config and self.config.bonus, true)

	if not var_13_1 then
		var_13_1 = {}

		local reward = var_13_1
		local itemCo = reward[1]

		self.txtNum.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), (itemCo or nil) and (itemCo[3] or 0))
	end
end

function Activity204TaskItem:refreshRemainTime()
	TaskDispatcher.runRepeat(self.tickUpdateTaskRemainTime, self, 1)
	self:tickUpdateTaskRemainTime()
end

function Activity204TaskItem:tickUpdateTaskRemainTime()
	if not self._mo.expireTime then
		local expireTime = 0
		local remainSec = expireTime / 1000 - ServerTime.now()
		local isExpired = remainSec <= 0

		if self._mo.config.durationHour then
			local isLimitTimeTask = self._mo.config.durationHour ~= 0
			local showLimitTime = not isExpired and not self._mo.hasGetBonus and isLimitTimeTask

			gohelper.setActive(self.gotime, showLimitTime)

			if not showLimitTime then
				TaskDispatcher.cancelTask(self.tickUpdateTaskRemainTime, self)

				return
			end

			self.txttime.text = TimeUtil.secondToRoughTime3(remainSec)
		end
	end
end

function Activity204TaskItem:_onOpenViewFinish()
	self:tryPlaySecretEffect()
end

function Activity204TaskItem:_onCloseViewFinish()
	self:tryPlaySecretEffect()
end

function Activity204TaskItem:onDestroyView()
	TaskDispatcher.cancelTask(self.tickUpdateTaskRemainTime, self)
end

return Activity204TaskItem
