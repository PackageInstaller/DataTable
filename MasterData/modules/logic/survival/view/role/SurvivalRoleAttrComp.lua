-- chunkname: @modules/logic/survival/view/role/SurvivalRoleAttrComp.lua

module("modules.logic.survival.view.role.SurvivalRoleAttrComp", package.seeall)

local SurvivalRoleAttrComp = class("SurvivalRoleAttrComp", LuaCompBase)

function SurvivalRoleAttrComp:init(go)
	self.viewGO = go
	self.btnClose = gohelper.findChildButtonWithAudio(go, "btnClose")
	self.desc = gohelper.findChild(go, "desc")
	self.layout = gohelper.findChild(self.desc, "layout")
	self.textDesc = gohelper.findChildTextMesh(self.layout, "textDesc")
	self.SurvivalRoleSelectAttrItem = gohelper.findChild(go, "container/SurvivalRoleSelectAttrItem")
	self.Layout1 = gohelper.findChild(go, "container/Layout1")
	self.Layout2 = gohelper.findChild(go, "container/Layout2")

	gohelper.setActive(self.btnClose.gameObject, false)
	gohelper.setActive(self.desc, false)
end

function SurvivalRoleAttrComp:addEventListeners()
	self.addClickCb(self, self.btnClose, self.onClickBtnClose, self)
end

function SurvivalRoleAttrComp:onClickBtnClose()
	gohelper.setActive(self.btnClose.gameObject, false)
	gohelper.setActive(self.desc, false)
end

function SurvivalRoleAttrComp:onClickAttr(item)
	self.onClickAttrId = item.data.id

	self:showTips()
end

function SurvivalRoleAttrComp:setData(layoutType, roleId)
	self.layoutType = layoutType
	self.roleId = roleId
	self.roleCfg = lua_survival_role.configDict[self.roleId]

	self:refresh()
end

function SurvivalRoleAttrComp:refresh()
	gohelper.setActive(self.Layout1, self.layoutType == 1)
	gohelper.setActive(self.Layout2, self.layoutType == 2)

	self.Layout = self["Layout" .. self.layoutType]

	local param = SimpleListParam.New()

	param.cellClass = SurvivalRoleSelectAttrItem
	self.roleAttrList = GameFacade.createSimpleListComp(self.Layout, param, self.SurvivalRoleSelectAttrItem, self.__viewContainer)

	self.roleAttrList:setOnClickItem(self.onClickAttr, self)

	local outSideInfo = SurvivalModel.instance:getOutSideInfo()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local cfg = lua_survival_role.configDict[self.roleId]
	local attrs = string.splitToNumber(cfg.initDisposition, "#")
	local data = {}

	for i, v in ipairs(attrs) do
		table.insert(data, {
			id = i,
			value = (outSideInfo.inWeek and weekInfo or nil) and weekInfo:getAttr(SurvivalEnum.AttrType["RoleAttr" .. i]) + weekInfo:getAttr(SurvivalEnum.AttrType["RoleAttrFix" .. i]),
			context = self
		})
	end

	self.roleAttrList:setData(data)

	local items = self.roleAttrList:getItems()

	for i, v in ipairs(items) do
		local str = "pos" .. i
		local parent = gohelper.findChild(self.Layout, str)

		v.viewGO.transform:SetParent(parent.transform, false)
	end
end

function SurvivalRoleAttrComp:showTips()
	gohelper.setActive(self.btnClose.gameObject, true)
	gohelper.setActive(self.desc, true)

	if self.layoutType == 1 then
		self.textDesc.text = SurvivalRoleConfig.instance:getRoleInitAttrTips(self.roleCfg.id, self.onClickAttrId)
	elseif self.layoutType == 2 then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		self.textDesc.text = weekInfo:getRoleAttrTips(self.onClickAttrId)
	end
end

return SurvivalRoleAttrComp
