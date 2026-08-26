-- chunkname: @modules/logic/survival/view/tech/tab/SurvivalTechTab.lua

module("modules.logic.survival.view.tech.tab.SurvivalTechTab", package.seeall)

local SurvivalTechTab = class("SurvivalTechTab", SimpleListItem)

function SurvivalTechTab:onInit()
	self.select = gohelper.findChild(self.viewGO, "select")
	self.unSelect = gohelper.findChild(self.viewGO, "unSelect")
	self.nodes = {
		self.select,
		self.unSelect
	}

	gohelper.setActive(self.select, false)
	gohelper.setActive(self.unSelect, true)

	self.survivalOutSideTechMo = SurvivalModel.instance:getOutSideInfo().survivalOutSideTechMo
end

function SurvivalTechTab:onAddListeners()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnTechChange, self.onTechChange, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalOutSideTechUnlockReply, self.onTechChange, self)
end

function SurvivalTechTab:onTechChange()
	self:refreshCanUp()
end

function SurvivalTechTab:onItemShow(data)
	self.techId = data.techId

	for i, go in ipairs(self.nodes) do
		local image_commonicon = gohelper.findChild(go, "image_commonicon")
		local image_tabicon = gohelper.findChildImage(go, "image_tabicon")
		local textName = gohelper.findChildTextMesh(go, "textName")

		gohelper.setActive(image_commonicon, self.techId == 0)
		gohelper.setActive(image_tabicon.gameObject, self.techId ~= 0)

		if self.techId ~= 0 then
			local path = SurvivalRoleConfig.instance:getRoleHeadImage(self.techId)

			if not string.nilorempty(path) then
				UISpriteSetMgr.instance:setSurvivalSprite2(image_tabicon, path)
			end
		end

		if self.techId == 0 then
			textName.text = luaLang("SurvivalTechView_3")
		else
			local roleCfg = lua_survival_role.configDict[self.techId]

			textName.text = roleCfg.name
		end
	end

	self:refreshCanUp()
end

function SurvivalTechTab:refreshCanUp()
	for i, go in ipairs(self.nodes) do
		local State_CanUp = gohelper.findChild(go, "State_CanUp")
		local canUp = self.survivalOutSideTechMo:haveCanUp(self.techId)

		gohelper.setActive(State_CanUp, canUp)
	end
end

function SurvivalTechTab:onSelectChange(isSelect)
	gohelper.setActive(self.select, isSelect)
	gohelper.setActive(self.unSelect, not isSelect)
end

return SurvivalTechTab
