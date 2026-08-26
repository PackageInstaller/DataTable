-- chunkname: @modules/logic/survival/view/handbook/tab/SurvivalHandbookViewTab.lua

module("modules.logic.survival.view.handbook.tab.SurvivalHandbookViewTab", package.seeall)

local SurvivalHandbookViewTab = class("SurvivalHandbookViewTab", LuaCompBase)

function SurvivalHandbookViewTab:init(go)
	self.go = go
	self.btnClick = gohelper.findButtonWithAudio(go)
	self.go_unselect = gohelper.findChild(go, "#go_unselect")
	self.unselect_go_unfinish = gohelper.findChild(self.go_unselect, "#go_unfinish")
	self.unselect_go_finished = gohelper.findChild(self.go_unselect, "#go_finished")
	self.unselect_txt_num = gohelper.findChildTextMesh(self.unselect_go_unfinish, "#txt_num")
	self.unselect_go_redDot = gohelper.findChild(self.go_unselect, "#go_redDot")
	self.go_select = gohelper.findChild(go, "#go_select")
	self.select_go_unfinish = gohelper.findChild(self.go_select, "#go_unfinish")
	self.select_go_finished = gohelper.findChild(self.go_select, "#go_finished")
	self.select_txt_num = gohelper.findChildTextMesh(self.select_go_unfinish, "#txt_num")
	self.select_go_redDot = gohelper.findChild(self.go_select, "#go_redDot")

	self:setSelect(false)
end

function SurvivalHandbookViewTab:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClickBtnClick, self)
end

function SurvivalHandbookViewTab:removeEventListeners()
	return
end

function SurvivalHandbookViewTab:onClickBtnClick()
	if self.onClickTabCallBack then
		self.onClickTabCallBack(self.onClickTabContext, self)
	end
end

function SurvivalHandbookViewTab:setData(parma)
	self.type = parma.type
	self.index = parma.index
	self.onClickTabCallBack = parma.onClickTabCallBack
	self.onClickTabContext = parma.onClickTabContext

	local redDot = SurvivalHandbookModel.instance.handbookTypeCfg[self.type].RedDot
	local uid = -1

	if redDot == RedDotEnum.DotNode.SurvivalHandbookStory then
		uid = nil
	end

	if redDot then
		RedDotController.instance:addRedDot(self.unselect_go_redDot, redDot, uid)
		RedDotController.instance:addRedDot(self.select_go_redDot, redDot, uid)
	end

	local info = SurvivalHandbookModel.instance:getProgress(self.type)

	if info then
		self.unselect_txt_num.text = string.format("<#FFFFFF><size=50>%s</size></color>/%s", info.progress, info.amount)
		self.select_txt_num.text = string.format("<size=50>%s</size>/%s", info.progress, info.amount)
	end
end

function SurvivalHandbookViewTab:setSelect(value)
	self.isSelect = value

	gohelper.setActive(self.go_unselect, not self.isSelect)
	gohelper.setActive(self.go_select, self.isSelect)
end

return SurvivalHandbookViewTab
