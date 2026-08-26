-- chunkname: @modules/logic/mail/view/MailCategoryListItem.lua

module("modules.logic.mail.view.MailCategoryListItem", package.seeall)

local MailCategoryListItem = class("MailCategoryListItem", ListScrollCell)

function MailCategoryListItem:init(go)
	self._goselectedBg = gohelper.findChild(go, "#go_cg/bg/#go_selectedBg")
	self._gounselectedBg = gohelper.findChild(go, "#go_cg/bg/#go_unselectedBg")
	self._gohasReadBg = gohelper.findChild(go, "#go_cg/bg/#go_hasReadBg")
	self._gomailSelectIcon = gohelper.findChild(go, "#go_cg/icon/#go_mailSelectIcon")
	self._gomailUnselectIcon = gohelper.findChild(go, "#go_cg/icon/#go_mailUnselectIcon")
	self._gogiftSelectIcon = gohelper.findChild(go, "#go_cg/icon/#go_giftSelectIcon")
	self._gogiftUnselectIcon = gohelper.findChild(go, "#go_cg/icon/#go_giftUnselectIcon")
	self._gogiftHasReceiveIcon = gohelper.findChild(go, "#go_cg/icon/#go_giftHasReceiveIcon")
	self._gomailHasReceiveIcon = gohelper.findChild(go, "#go_cg/icon/#go_mailHasReceiveIcon")
	self._txtmailTitleSelect = gohelper.findChildText(go, "#go_cg/#txt_mailTitleSelect")
	self._txtmailTitleUnSelect = gohelper.findChildText(go, "#go_cg/#txt_mailTitleUnSelect")
	self._txtmailTimeSelect = gohelper.findChildText(go, "#go_cg/#txt_mailTimeSelect")
	self._txtmailTimeUnSelect = gohelper.findChildText(go, "#go_cg/#txt_mailTimeUnSelect")
	self._goreceivedIcon = gohelper.findChild(go, "#go_cg/#go_receivedIcon")
	self._goredTip = gohelper.findChild(go, "#go_cg/#go_redTip")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "#btn_click")
	self._goLock = gohelper.findChild(go, "#go_cg/#go_Lock")
	self._gocg = gohelper.findChildComponent(go, "#go_cg", typeof(UnityEngine.CanvasGroup))
	self._goAnim = go:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(self._btnclick.gameObject, AudioEnum.UI.UI_Mail_switch)
end

function MailCategoryListItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnclick, self)
end

function MailCategoryListItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function MailCategoryListItem:_btnclickOnclick()
	if self._select then
		return
	end

	self._view:selectCell(self._index, true)
end

function MailCategoryListItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshInfo()
	self:_refreshTips()
	self:_refreshBg()
	self:_refreshIcon()
end

function MailCategoryListItem:_refreshInfo()
	gohelper.setActive(self._txtmailTitleSelect.gameObject, self._select)
	gohelper.setActive(self._txtmailTitleUnSelect.gameObject, not self._select)

	if self._select then
		self._txtmailTitleSelect.text = GameUtil.getBriefNameByWidth(self._mo:getLangTitle(), self._txtmailTitleSelect)
	else
		self._txtmailTitleUnSelect.text = GameUtil.getBriefNameByWidth(self._mo:getLangTitle(), self._txtmailTitleUnSelect)
	end

	gohelper.setActive(self._txtmailTimeSelect.gameObject, self._select)
	gohelper.setActive(self._txtmailTimeUnSelect.gameObject, not self._select)

	if self._select then
		self._txtmailTimeSelect.text = TimeUtil.timestampToString3(self._mo.createTime / 1000)
	else
		self._txtmailTimeUnSelect.text = TimeUtil.timestampToString3(self._mo.createTime / 1000)
	end

	gohelper.setActive(self._goLock, self._mo and self._mo.isLock == true)
end

function MailCategoryListItem:_refreshTips()
	if self._mo:haveBonus() then
		if self._mo.state == MailEnum.ReadStatus.Read then
			gohelper.setActive(self._goredTip, false)
			gohelper.setActive(self._goreceivedIcon, true)
		else
			gohelper.setActive(self._goredTip, true)
			gohelper.setActive(self._goreceivedIcon, false)
		end
	elseif self._mo.state == MailEnum.ReadStatus.Read then
		gohelper.setActive(self._goredTip, false)
		gohelper.setActive(self._goreceivedIcon, true)
	else
		gohelper.setActive(self._goredTip, true)
		gohelper.setActive(self._goreceivedIcon, false)
	end

	self:setRead(self._mo.state == MailEnum.ReadStatus.Read)
end

function MailCategoryListItem:_refreshBg()
	gohelper.setActive(self._goselectedBg, false)
	gohelper.setActive(self._gounselectedBg, false)
	gohelper.setActive(self._gohasReadBg, false)

	if self._select then
		gohelper.setActive(self._goselectedBg, true)
		gohelper.setActive(self._goreceivedIcon, false)
	elseif self._mo.state == MailEnum.ReadStatus.Read then
		gohelper.setActive(self._gohasReadBg, true)
		gohelper.setActive(self._gounselectedBg, true)
	else
		gohelper.setActive(self._gounselectedBg, true)

		if self._mo.state == MailEnum.ReadStatus.Read then
			gohelper.setActive(self._goreceivedIcon, true)
		end
	end
end

function MailCategoryListItem:_refreshIcon()
	gohelper.setActive(self._gomailSelectIcon, false)
	gohelper.setActive(self._gomailUnselectIcon, false)
	gohelper.setActive(self._gogiftSelectIcon, false)
	gohelper.setActive(self._gogiftUnselectIcon, false)
	gohelper.setActive(self._gogiftHasReceiveIcon, false)
	gohelper.setActive(self._gomailHasReceiveIcon, false)

	if self._mo:haveBonus() then
		if self._select then
			gohelper.setActive(self._gogiftSelectIcon, true)
		elseif self._mo.state == MailEnum.ReadStatus.Read then
			gohelper.setActive(self._gogiftHasReceiveIcon, true)
		else
			gohelper.setActive(self._gogiftUnselectIcon, true)
		end
	elseif self._select then
		gohelper.setActive(self._gomailSelectIcon, true)
	elseif self._mo.state == MailEnum.ReadStatus.Read then
		gohelper.setActive(self._gomailHasReceiveIcon, true)
	else
		gohelper.setActive(self._gomailUnselectIcon, true)
	end
end

function MailCategoryListItem:getAnimator()
	return self._goAnim
end

function MailCategoryListItem:onSelect(isSelect)
	if not self._select and isSelect then
		MailController.instance:dispatchEvent(MailEvent.UpdateSelectMail, self._mo)
	end

	self._select = isSelect

	self:_refreshInfo()
	self:_refreshTips()
	self:_refreshBg()
	self:_refreshIcon()
end

function MailCategoryListItem:setRead(isRead)
	if isRead and not self._select then
		self._gocg.alpha = 0.7
	end
end

function MailCategoryListItem:onDestroy()
	return
end

return MailCategoryListItem
