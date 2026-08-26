-- chunkname: @modules/logic/necrologiststory/game/v3a1/V3A1_RoleStoryTicketView.lua

module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStoryTicketView", package.seeall)

local V3A1_RoleStoryTicketView = class("V3A1_RoleStoryTicketView", BaseView)

function V3A1_RoleStoryTicketView:onInitView()
	self.txtPlace = gohelper.findChildTextMesh(self.viewGO, "root/Title/#txt_place")
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "root/Title/#txt_time")
	self.btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "root/Ticket/#btn_confirm")
	self.txtFrom = gohelper.findChildTextMesh(self.viewGO, "root/Ticket/simage_bg/#txt_from")
	self.dropdownOption = gohelper.findChildDropdown(self.viewGO, "root/Ticket/#drop_filter")
	self.txtError = gohelper.findChildTextMesh(self.dropdownOption.gameObject, "Label")
	self.txtCorrectly = gohelper.findChildTextMesh(self.dropdownOption.gameObject, "Correctly")
	self.imageArrow = gohelper.findChildImage(self.dropdownOption.gameObject, "arrow")

	self.dropdownOption:AddOnValueChanged(self.handleDropValueChanged, self)

	self.optionClick = gohelper.getClickWithAudio(self.dropdownOption.gameObject, AudioEnum.UI.UI_Common_Click)
	self.imageWeather = gohelper.findChildImage(self.viewGO, "root/Title/#image_weather")
	self.animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A1_RoleStoryTicketView:addEvents()
	self.addClickCb(self, self.btnConfirm, self.onClickBtnConfirm, self)
	self.addClickCb(self, self.optionClick, self.onClickOption, self)
end

function V3A1_RoleStoryTicketView:removeEvents()
	self:removeClickCb(self.btnConfirm)
	self:removeClickCb(self.optionClick)
end

function V3A1_RoleStoryTicketView:_editableInitView()
	return
end

function V3A1_RoleStoryTicketView:onClickModalMask()
	return
end

function V3A1_RoleStoryTicketView:onClickOption()
	return
end

function V3A1_RoleStoryTicketView:handleDropValueChanged(index)
	self.selectIndex = index

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	self:refreshOption()
end

function V3A1_RoleStoryTicketView:onClickBtnConfirm()
	if self.selectIndex == -1 then
		return
	end

	local option = self.selectIndex + 1

	if self.rightOption == option then
		AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_wulu_build)
		self.gameBaseMO:tryFinishBase(self.curBaseId)
		self.animatorPlayer:Play("correctly", self.onCorrectlyFinished, self)
	end
end

function V3A1_RoleStoryTicketView:onCorrectlyFinished()
	self:closeThis()
end

function V3A1_RoleStoryTicketView:initViewParam()
	local storyId = self.viewParam.roleStoryId

	self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
	self.curBaseId = self.gameBaseMO:getCurBaseId()

	local config = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(self.curBaseId)

	self.options = string.split(config.choose, "#")
	self.rightOption = config.rightChoose
	self.selectIndex = -1
end

function V3A1_RoleStoryTicketView:onOpen()
	self:initViewParam()
	self:refreshView()
end

function V3A1_RoleStoryTicketView:refreshView()
	self:refreshTitle()
	self.dropdownOption:ClearOptions()
	self.dropdownOption:AddOptions(self.options)
	self.dropdownOption:SetValue(self.selectIndex)
	gohelper.setActive(self.btnConfirm, false)
end

function V3A1_RoleStoryTicketView:refreshTitle()
	local curTime = self.gameBaseMO:getCurTime()
	local baseConfig = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(self.curBaseId)
	local displayHour, minute = NecrologistStoryHelper.getTimeFormat2(curTime)

	self.txtTime.text = string.format("%d:%02d", displayHour, minute)
	self.txtPlace.text = baseConfig.name
	self.txtFrom.text = baseConfig.name

	UISpriteSetMgr.instance:setRoleStorySprite(self.imageWeather, string.format("rolestory_weather%s", baseConfig.weather))
end

function V3A1_RoleStoryTicketView:refreshOption()
	local optionId = self.selectIndex + 1
	local isRight = self.rightOption == optionId

	gohelper.setActive(self.btnConfirm, isRight)

	local baseConfig = NecrologistStoryV3A1Config.instance:getFugaorenBaseCo(self.curBaseId)
	local dialogIds = string.splitToNumber(baseConfig.dialogId, "#")

	if isRight then
		if not dialogIds[1] then
			local dialogId = dialogIds[2]

			if dialogId then
				TipDialogController.instance:openTipDialogView(dialogId, self.onDialogFinished, self)
			end

			local optionStr = self.options[optionId]

			if isRight then
				self.txtCorrectly.text = optionStr
				self.txtError.text = ""
			else
				self.txtCorrectly.text = ""
				self.txtError.text = optionStr
			end
		end
	end
end

function V3A1_RoleStoryTicketView:onDialogFinished()
	return
end

function V3A1_RoleStoryTicketView:onDestroyView()
	if self.dropdownOption then
		self.dropdownOption:RemoveOnValueChanged()

		self.dropdownOption = nil
	end
end

return V3A1_RoleStoryTicketView
