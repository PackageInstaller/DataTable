-- chunkname: @modules/logic/playercard/view/PlayerCardBadgeGetView.lua

module("modules.logic.playercard.view.PlayerCardBadgeGetView", package.seeall)

local PlayerCardBadgeGetView = class("PlayerCardBadgeGetView", BaseView)

function PlayerCardBadgeGetView:onInitView()
	self._imagebadge = gohelper.findChildImage(self.viewGO, "root/second/#image_badge")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/second/title/#txt_title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "root/second/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "root/second/#btn_goto")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/second/#btn_close")
	self._toggleoption = gohelper.findChildToggle(self.viewGO, "root/second/#toggle_option")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerCardBadgeGetView:addEvents()
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function PlayerCardBadgeGetView:removeEvents()
	self._btngoto:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function PlayerCardBadgeGetView:_btngotoOnClick()
	PlayerCardController.instance:openPlayerCardView({
		justOpenBadgeView = true,
		userId = PlayerModel.instance:getMyUserId()
	})
end

function PlayerCardBadgeGetView:_btncloseOnClick()
	if self._materials then
		TaskController.instance:getRewardByLine(self._getApproach, ViewName.CommonPropView, self._materials)
	end

	PlayerCardModel.instance:setShowBadgeGetView(not self._toggleoption.isOn)
	self:closeThis()
end

function PlayerCardBadgeGetView:_editableInitView()
	self._goLimitTime = gohelper.findChild(self.viewGO, "root/second/LimitTime")
	self._gofirst = gohelper.findChild(self.viewGO, "root/first")
	self._gosecond = gohelper.findChild(self.viewGO, "root/second")

	gohelper.setActive(self._gofirst, true)
	gohelper.setActive(self._gosecond, false)
end

function PlayerCardBadgeGetView:onUpdateParam()
	self:_refreshView()
end

function PlayerCardBadgeGetView:onOpen()
	local constCo = lua_playercard_const.configDict[4]
	local tasktypeIds = string.splitToNumber(constCo.value2, "#")

	TaskRpc.instance:sendGetTaskInfoRequest(tasktypeIds, self._refreshView, self)

	self._toggleoption.isOn = false
end

function PlayerCardBadgeGetView:_refreshView()
	self._badgeId = self.viewParam.id
	self._getApproach = self.viewParam.getApproach
	self._materials = self.viewParam.materials
	self._badgeMo = PlayerCardModel.instance:getBadgeMoById(self._badgeId)

	if not self._badgeMo then
		return
	end

	self._txttitle.text = self._badgeMo.co.name

	UISpriteSetMgr.instance:setPlayerCard2Sprite(self._imagebadge, self._badgeMo.co.icon)

	local activityId = self._badgeMo:getActivityId()

	if activityId then
		::label_9_0::

		local actMo = ActivityModel.instance:getActMO(activityId)

		if actMo then
			local lang = luaLang("Playercard_badge_limittime")

			self._txtLimitTime.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, actMo:getRemainTimeStr2ByEndTime(true))
		end

		gohelper.setActive(self._goLimitTime, actMo ~= nil)
		gohelper.setActive(self._gosecond, true)
	end
end

function PlayerCardBadgeGetView:onClose()
	return
end

function PlayerCardBadgeGetView:onDestroyView()
	return
end

return PlayerCardBadgeGetView
