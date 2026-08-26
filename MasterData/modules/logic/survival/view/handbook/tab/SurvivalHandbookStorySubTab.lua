-- chunkname: @modules/logic/survival/view/handbook/tab/SurvivalHandbookStorySubTab.lua

module("modules.logic.survival.view.handbook.tab.SurvivalHandbookStorySubTab", package.seeall)

local SurvivalHandbookStorySubTab = class("SurvivalHandbookStorySubTab", SimpleListItem)

function SurvivalHandbookStorySubTab:onInit()
	self.go_Selected = gohelper.findChild(self.viewGO, "#go_Selected")
	self.txt_Common = gohelper.findChildTextMesh(self.viewGO, "txt_Common")
	self.txt_Common2 = gohelper.findChildTextMesh(self.viewGO, "#go_Selected/txt_Common")
	self.go_redDot = gohelper.findChild(self.viewGO, "#go_redDot")

	gohelper.setActive(self.go_Selected, false)
end

function SurvivalHandbookStorySubTab:onAddListeners()
	return
end

function SurvivalHandbookStorySubTab:onItemShow(data)
	self.subType = data.subType
	self.type = data.type
	self.tabIndex = data.tabIndex

	gohelper.setActive(self.go_Selected, false)

	local key = "SurvivalHandbookView_Story_" .. self.itemIndex
	local title = luaLang(key)

	self.txt_Common.text = title
	self.txt_Common2.text = title

	local redDot = SurvivalHandbookModel.instance.StoryFragmentRedDot[self.tabIndex]

	RedDotController.instance:addRedDot(self.go_redDot, redDot, self.subType)
end

function SurvivalHandbookStorySubTab:onSelectChange(isSelect)
	gohelper.setActive(self.go_Selected, isSelect)
end

return SurvivalHandbookStorySubTab
