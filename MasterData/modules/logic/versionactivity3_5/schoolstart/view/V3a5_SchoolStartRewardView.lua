-- chunkname: @modules/logic/versionactivity3_5/schoolstart/view/V3a5_SchoolStartRewardView.lua

module("modules.logic.versionactivity3_5.schoolstart.view.V3a5_SchoolStartRewardView", package.seeall)

local V3a5_SchoolStartRewardView = class("V3a5_SchoolStartRewardView", BaseView)

function V3a5_SchoolStartRewardView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "reward/#scroll_reward")
	self._gocontent = gohelper.findChild(self.viewGO, "reward/#scroll_reward/Viewport/#go_content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "reward/#scroll_reward/Viewport/#go_content/#go_rewarditem")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a5_SchoolStartRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V3a5_SchoolStartRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V3a5_SchoolStartRewardView:_btncloseOnClick()
	self:closeThis()
end

function V3a5_SchoolStartRewardView:_editableInitView()
	return
end

function V3a5_SchoolStartRewardView:onUpdateParam()
	return
end

function V3a5_SchoolStartRewardView:onOpen()
	local rewardList = V3a5_SchoolStartModel.instance:getRewardList()

	for index, mo in ipairs(rewardList) do
		local item = self:getUserDataTb_()

		item.go = gohelper.clone(self._gorewarditem, self._gocontent, "index" .. index)
		item.gohaveGet = gohelper.findChild(item.go, "#go_haveGet")

		gohelper.setActive(item.go, true)

		local iconComp = IconMgr.instance:getCommonPropItemIcon(item.go)

		iconComp:setMOValue(tonumber(mo.type), tonumber(mo.id), tonumber(mo.num))

		if mo.state then
			gohelper.setActive(item.gohaveGet, true)
			gohelper.setAsLastSibling(item.gohaveGet)
			iconComp:setGetMask(true)
		else
			gohelper.setActive(item.gohaveGet, false)
		end
	end
end

function V3a5_SchoolStartRewardView:onClose()
	return
end

function V3a5_SchoolStartRewardView:onDestroyView()
	return
end

return V3a5_SchoolStartRewardView
