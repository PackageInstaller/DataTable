-- chunkname: @modules/logic/investigate/view/InvestigateView.lua

module("modules.logic.investigate.view.InvestigateView", package.seeall)

local InvestigateView = class("InvestigateView", BaseView)

function InvestigateView:onInitView()
	self._simagefullbg1 = gohelper.findChildSingleImage(self.viewGO, "root/Bg/#simage_fullbg1")
	self._imagetitle = gohelper.findChildImage(self.viewGO, "root/Bg/#image_title")
	self._gorole1 = gohelper.findChild(self.viewGO, "root/Role/#go_role1")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "root/Role/#go_role1/#simage_bg")
	self._gorole2 = gohelper.findChild(self.viewGO, "root/Role/#go_role2")
	self._gorole3 = gohelper.findChild(self.viewGO, "root/Role/#go_role3")
	self._gorole4 = gohelper.findChild(self.viewGO, "root/Role/#go_role4")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_reward")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function InvestigateView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
end

function InvestigateView:removeEvents()
	self._btnreward:RemoveClickListener()
end

function InvestigateView:_btnrewardOnClick()
	InvestigateController.instance:openInvestigateTaskView()
end

function InvestigateView:_editableInitView()
	self:_initRoles()

	local aniGo = gohelper.findChild(self.viewGO, "root/#btn_reward/ani")

	self._animator = aniGo:GetComponent("Animator")
	self._goreddot = gohelper.findChild(self.viewGO, "root/#btn_reward/reddot")

	gohelper.setActive(self._goreddot, true)
	RedDotController.instance:addRedDot(self._goreddot, RedDotEnum.DotNode.InvestigateTask, nil, self._refreshReddot, self)
end

function InvestigateView:_refreshReddot(redDotIcon)
	redDotIcon:defaultRefreshDot()

	local show = redDotIcon.show

	self._animator:Play(show and "loop" or "idle", 0, 0)
end

function InvestigateView:_initRoles()
	local infos = InvestigateConfig.instance:getRoleEntranceInfos()

	for i, v in ipairs(infos) do
		local go = self["_gorole" .. i]
		local list = InvestigateConfig.instance:getRoleGroupInfoList(v.group)

		if #list > 1 then
			local roleItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, InvestigateRoleMultiItem)

			roleItem:onUpdateMO(list)
		else
			local roleItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, InvestigateRoleItem)

			roleItem:onUpdateMO(list[1])
		end
	end
end

function InvestigateView:onUpdateParam()
	return
end

function InvestigateView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Investigate.play_ui_mln_day_night)
end

function InvestigateView:onClose()
	return
end

function InvestigateView:onDestroyView()
	return
end

return InvestigateView
