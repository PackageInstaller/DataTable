-- chunkname: @modules/logic/versionactivity2_5/act186/view/Activity186TaskItem.lua

module("modules.logic.versionactivity2_5.act186.view.Activity186TaskItem", package.seeall)

local Activity186TaskItem = class("Activity186TaskItem", ListScrollCellExtend)

function Activity186TaskItem:onInitView()
	self.txtIndex = gohelper.findChildTextMesh(self.viewGO, "txtIndex")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "txtDesc")
	self.goReward = gohelper.findChild(self.viewGO, "#go_reward")
	self.txtNum = gohelper.findChildTextMesh(self.goReward, "#txt_num")
	self.btnCanget = gohelper.findChildButtonWithAudio(self.goReward, "go_canget")
	self.goReceive = gohelper.findChild(self.goReward, "go_receive")
	self.btnJump = gohelper.findChildButtonWithAudio(self.viewGO, "btnJump")
	self.goDoing = gohelper.findChild(self.viewGO, "goDoing")
	self.goLightBg = gohelper.findChild(self.goReward, "go_lightbg")
	self.anim = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.isOpen = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity186TaskItem:addEvents()
	self.btnCanget:AddClickListener(self.onClickBtnCanget, self)
	self.btnJump:AddClickListener(self.onClickBtnJump, self)
end

function Activity186TaskItem:removeEvents()
	self.btnCanget:RemoveClickListener()
	self.btnJump:RemoveClickListener()
end

function Activity186TaskItem:_editableInitView()
	return
end

function Activity186TaskItem:onClickBtnCanget()
	if not self._mo then
		return
	end

	if not self._mo.canGetReward then
		return
	end

	local config = self._mo.config

	if self._mo.isGlobalTask then
		TaskRpc.instance:sendFinishTaskRequest(config.id)
	else
		Activity186Rpc.instance:sendFinishAct186TaskRequest(config.activityId, config.id)
	end
end

function Activity186TaskItem:onClickBtnJump()
	if not self._mo then
		return
	end

	local config = self._mo.config
	local jumpId = config.jumpId

	if jumpId and jumpId ~= 0 then
		GameFacade.jump(jumpId)
	end
end

function Activity186TaskItem:onUpdateMO(mo)
	self._mo = mo
	self.config = self._mo.config

	self:refreshDesc()
	self:refreshJump()
	self:refreshReward()

	if self.isOpen then
		self.anim:Play("open", 0, 0)
	else
		self.anim:Play("open", 0, 1)
	end

	self.isOpen = false
end

function Activity186TaskItem:refreshDesc()
	self.txtIndex.text = tostring(self._mo.index)

	local progress = Activity173Controller.numberDisplay(self._mo.progress)

	if self.config then
		local maxProgress = Activity173Controller.numberDisplay(self.config.maxProgress or 0)

		self.txtDesc.text = string.format("%s\n(%s/%s)", (self.config or nil) and (self.config.desc or ""), progress, maxProgress)
	end
end

function Activity186TaskItem:refreshJump()
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

function Activity186TaskItem:refreshReward()
	local var_10_1 = GameUtil.splitString2(self.config and self.config.bonus, true)

	if not var_10_1 then
		var_10_1 = {}

		local reward = var_10_1
		local itemCo = reward[1]

		self.txtNum.text = string.format("×%s", (itemCo or nil) and (itemCo[3] or 0))
	end
end

function Activity186TaskItem:onDestroyView()
	return
end

return Activity186TaskItem
