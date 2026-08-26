-- chunkname: @modules/logic/turnback/view/turnback3/Turnback3RewardDetailView.lua

module("modules.logic.turnback.view.turnback3.Turnback3RewardDetailView", package.seeall)

local Turnback3RewardDetailView = class("Turnback3RewardDetailView", BaseView)

function Turnback3RewardDetailView:onInitView()
	self._btnclosebtn = gohelper.findChildButtonWithAudio(self.viewGO, "root/bg/#btn_closebtn")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/#simage_title")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_reward")
	self._gorewarditemcontent = gohelper.findChild(self.viewGO, "root/#scroll_reward/viewport/content")
	self._gorewarditem = gohelper.findChild(self.viewGO, "root/#scroll_reward/viewport/content/#go_rewarditem")
	self._goremaintime = gohelper.findChildText(self.viewGO, "root/go_time/#txt_remainTime")
	self.rewardList = {}

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback3RewardDetailView:addEvents()
	self._btnclosebtn:AddClickListener(self._btnclosebtnOnClick, self)
end

function Turnback3RewardDetailView:removeEvents()
	self._btnclosebtn:RemoveClickListener()
end

function Turnback3RewardDetailView:_btnclosebtnOnClick()
	self:closeThis()
end

function Turnback3RewardDetailView:_editableInitView()
	return
end

function Turnback3RewardDetailView:onUpdateParam()
	return
end

function Turnback3RewardDetailView:onOpen()
	self._turnbackId = TurnbackModel.instance:getCurTurnbackId()
	self._config = TurnbackConfig.instance:getTurnbackCo(self._turnbackId)
	self._goremaintime.text = TurnbackController.instance:refreshRemainTime()

	local bonusCoList = GameUtil.splitString2(self._config.bonusList, true)

	for i, bonusCo in ipairs(bonusCoList) do
		local rewardItem = self.rewardList[i]

		if not rewardItem then
			local type, id, num = bonusCo[1], bonusCo[2], bonusCo[3]

			rewardItem = self:getUserDataTb_()
			rewardItem.go = gohelper.clone(self._gorewarditem, self._gorewarditemcontent, "item" .. i)

			gohelper.setActive(rewardItem.go, true)

			rewardItem.goIcon = gohelper.findChild(rewardItem.go, "itemicon")
			rewardItem.itemIcon = IconMgr.instance:getCommonPropItemIcon(rewardItem.goIcon)

			rewardItem.itemIcon:setMOValue(type, id, num, nil, true)
			table.insert(self.rewardList, rewardItem)
		end
	end
end

function Turnback3RewardDetailView:onClose()
	return
end

function Turnback3RewardDetailView:onDestroyView()
	return
end

return Turnback3RewardDetailView
