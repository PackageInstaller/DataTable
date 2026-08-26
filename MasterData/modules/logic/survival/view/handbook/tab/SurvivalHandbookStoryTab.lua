-- chunkname: @modules/logic/survival/view/handbook/tab/SurvivalHandbookStoryTab.lua

module("modules.logic.survival.view.handbook.tab.SurvivalHandbookStoryTab", package.seeall)

local SurvivalHandbookStoryTab = class("SurvivalHandbookStoryTab", SimpleListItem)

function SurvivalHandbookStoryTab:onInit()
	self._btnClickItem = gohelper.findChildButtonWithAudio(self.viewGO, "Role")
	self.go_Selected = gohelper.findChild(self.viewGO, "Role/#go_Selected")
	self.go_unSelect = gohelper.findChild(self.viewGO, "Role/#go_unSelect")
	self.go_Lock = gohelper.findChild(self.viewGO, "Role/#go_Lock")
	self.txt_Common = gohelper.findChildTextMesh(self.viewGO, "Role/#go_unSelect/txt_Common")
	self.txt_Common2 = gohelper.findChildTextMesh(self.viewGO, "Role/#go_Selected/txt_Common")
	self.txt_Common3 = gohelper.findChildTextMesh(self.viewGO, "Role/#go_Lock/txt_Common")
	self.image_role = gohelper.findChildImage(self.viewGO, "Role/#go_unSelect/image_role")
	self.image_role2 = gohelper.findChildImage(self.viewGO, "Role/#go_Selected/image_role")
	self.image_role3 = gohelper.findChildImage(self.viewGO, "Role/#go_Lock/image_role")
	self.go_redDot = gohelper.findChild(self.viewGO, "Role/#go_redDot")
end

function SurvivalHandbookStoryTab:onAddListeners()
	return
end

function SurvivalHandbookStoryTab:onItemShow(data)
	gohelper.setActive(self.go_Selected, false)
	gohelper.setActive(self.go_unSelect, true)

	self.onSubTabSelectChangeFunc = data.onSubTabSelectChangeFunc
	self.onSubTabSelectChangeContext = data.onSubTabSelectChangeContext
	self.subTypes = data.subTypes
	self.roleId = data.roleId

	local redDot = SurvivalHandbookModel.instance.StoryTabRedDot[self.itemIndex]

	RedDotController.instance:addRedDot(self.go_redDot, redDot)

	local cfg = lua_survival_role.configDict[self.roleId]
	local name = cfg.name

	self.txt_Common.text = name
	self.txt_Common2.text = name
	self.txt_Common3.text = name

	local path = SurvivalRoleConfig.instance:getRoleHeadImage(self.roleId)

	if not string.nilorempty(path) then
		UISpriteSetMgr.instance:setSurvivalSprite2(self.image_role, path)
		UISpriteSetMgr.instance:setSurvivalSprite2(self.image_role2, path)
		UISpriteSetMgr.instance:setSurvivalSprite2(self.image_role3, path)
	end
end

function SurvivalHandbookStoryTab:onSelectChange(isSelect)
	gohelper.setActive(self.go_Selected, isSelect)
	gohelper.setActive(self.go_unSelect, not isSelect)
end

return SurvivalHandbookStoryTab
