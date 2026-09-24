-- chunkname: @modules/logic/necrologiststory/game/v4a0/V4A0_RoleStoryQuestionView.lua

module("modules.logic.necrologiststory.game.v4a0.V4A0_RoleStoryQuestionView", package.seeall)

local V4A0_RoleStoryQuestionView = class("V4A0_RoleStoryQuestionView", BaseView)
local ViewState = {
	Result = 2,
	Enter = 0,
	Question = 1
}

function V4A0_RoleStoryQuestionView:onInitView()
	self.anim = gohelper.findComponentAnim(self.viewGO)
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/mask")
	self.goTips = gohelper.findChild(self.viewGO, "root/#go_tips")
	self.goOptions = gohelper.findChild(self.viewGO, "root/#go_options")
	self.goTest = gohelper.findChild(self.viewGO, "root/#go_test")
	self.state = ViewState.Enter
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "root/#go_options/#txt_title")
	self.txtContent = gohelper.findChildTextMesh(self.viewGO, "root/#go_options/ScrollView/Viewport/Content/#txt_desc")
	self.goOptionItem = gohelper.findChild(self.viewGO, "root/#go_options/grid/#btn_option")

	gohelper.setActive(self.goOptionItem, false)

	self.options = {}
	self.txtTestTitle = gohelper.findChildTextMesh(self.viewGO, "root/#go_test/#txt_title")
	self.txtTestContent = gohelper.findChildTextMesh(self.viewGO, "root/#go_test/#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V4A0_RoleStoryQuestionView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickClose, self)
end

function V4A0_RoleStoryQuestionView:removeEvents()
	self:removeClickCb(self.btnClose)
end

function V4A0_RoleStoryQuestionView:_editableInitView()
	return
end

function V4A0_RoleStoryQuestionView:onClickClose()
	if self.state == ViewState.Enter then
		self.state = ViewState.Question

		self:refreshView()

		return
	end

	self:closeThis()
end

function V4A0_RoleStoryQuestionView:onClickOption(optionItem)
	if not optionItem.option then
		return
	end

	self.gameBaseMO:setQuestionOption(self.questionId, optionItem.option)

	self.state = ViewState.Result

	self:refreshView()
end

function V4A0_RoleStoryQuestionView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_gt_yishi_shua)
	self:refreshParam()
	self:refreshView()
end

function V4A0_RoleStoryQuestionView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function V4A0_RoleStoryQuestionView:refreshParam()
	if not self.viewParam then
		local viewParam = {}
		local storyId = viewParam.roleStoryId

		self.questionId = viewParam.questionId
		self.heroStoryId = storyId

		if storyId then
			self.gameBaseMO = NecrologistStoryModel.instance:getGameMO(storyId)
		end
	end
end

function V4A0_RoleStoryQuestionView:refreshView()
	if self.state == ViewState.Enter then
		self.anim:Play("open_tips")
	elseif self.state == ViewState.Question then
		self.anim:Play("open_options")
		self:refreshOptions()
	elseif self.state == ViewState.Result then
		self.anim:Play("open_test")
		self:refreshTest()
	end
end

function V4A0_RoleStoryQuestionView:refreshOptions()
	local config = NecrologistStoryV4A0Config.instance:getQuestionConfig(self.questionId)

	if not config then
		return
	end

	self.txtTitle.text = config.title
	self.txtContent.text = config.content
	self.txtTestTitle.text = config.title

	local options = string.splitToNumber(config.group, "#")

	for i = 1, math.max(#options, #self.options) do
		local optionItem = self:getOptionItem(i)

		self:refreshOptionItem(optionItem, options[i])
	end
end

function V4A0_RoleStoryQuestionView:getOptionItem(index)
	local optionItem = self:getUserDataTb_()

	optionItem.index = index
	optionItem.go = gohelper.cloneInPlace(self.goOptionItem, tostring(index))
	optionItem.goTag = gohelper.findChild(optionItem.go, "#go_tag")
	optionItem.txtOption = gohelper.findChildTextMesh(optionItem.go, "#txt_option")
	optionItem.btnClick = gohelper.findChildButtonWithAudio(optionItem.go, "")

	self.addClickCb(self, optionItem.btnClick, self.onClickOption, self, optionItem)

	return optionItem
end

function V4A0_RoleStoryQuestionView:refreshOptionItem(optionItem, option)
	optionItem.option = option

	gohelper.setActive(optionItem.go, option ~= nil)

	if not option then
		return
	end

	local config = NecrologistStoryV4A0Config.instance:getOptionConfig(option)

	optionItem.txtOption.text = config.content

	local isLastSelect = self.gameBaseMO:getQuestionOption(self.questionId) == option

	gohelper.setActive(optionItem.goTag, isLastSelect)
end

function V4A0_RoleStoryQuestionView:refreshTest()
	local option = self.gameBaseMO:getQuestionOption(self.questionId)

	if not option then
		return
	end

	local config = NecrologistStoryV4A0Config.instance:getOptionConfig(option)

	if not config then
		return
	end

	self.txtTestContent.text = config.result
end

function V4A0_RoleStoryQuestionView:onClose()
	return
end

function V4A0_RoleStoryQuestionView:onDestroyView()
	for _, optionItem in ipairs(self.options) do
		self:removeClickCb(optionItem.btnClick)
	end
end

return V4A0_RoleStoryQuestionView
