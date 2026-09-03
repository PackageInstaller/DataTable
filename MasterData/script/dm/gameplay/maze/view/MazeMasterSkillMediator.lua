-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeMasterSkillMediator.lua

MazeMasterSkillMediator = class("MazeMasterSkillMediator", DmPopupViewMediator, _M)

MazeMasterSkillMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	Button_1 = "onClickCloseBtn"
}

function MazeMasterSkillMediator:initialize()
	super.initialize(self)
end

function MazeMasterSkillMediator:dispose()
	super.dispose(self)
end

function MazeMasterSkillMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeMasterSkillMediator:mapEventListeners()
	return
end

function MazeMasterSkillMediator:dispose()
	super.dispose(self)
end

function MazeMasterSkillMediator:enterWithData(data)
	self:initData()
	self:initViews()
end

function MazeMasterSkillMediator:initData()
	return
end

function MazeMasterSkillMediator:initViews()
	self._main = self:getView()

	local skills = self._mazeSystem:getMasterSkill()

	self._cellclone = self._main:getChildByFullName("cellclone")
	self._celllist = self._main:getChildByFullName("celllist")

	local masterid = self._mazeSystem:getSelectMasterId()
	local master_id = ConfigReader:getDataByNameIdAndKey("EnemyMaster", masterid, "RoleModel")

	masterid = ConfigReader:getDataByNameIdAndKey("RoleModel", master_id, "Model")

	local ani = self._mazeSystem:createOneMasterAni(masterid, false, true)

	ani:setGray(false)
	self._main:getChildByFullName("rolenode"):addChild(ani)

	local count = 1

	for k, v in pairs(skills) do
		local sid = ""
		local level = 1

		if k == "passive" then
			sid = v[1].skillId
			level = v[1].level
		else
			sid = v.skillId
			level = v.level
		end

		local cell = self._cellclone:clone()
		local skillProConfig = ConfigReader:getRecordById("Skill", sid)

		cell:getChildByFullName("name"):setString(Strings:get(skillProConfig.Name))

		local iconNode = cell:getChildByFullName("icon")
		local skillImg = IconFactory:createSkillPic({
			id = skillProConfig.Icon
		})

		skillImg:setScale(0.3)
		skillImg:addTo(iconNode):center(iconNode:getContentSize()):offset(0, 6)

		local desc = ConfigReader:getEffectDesc("Skill", skillProConfig.Desc, sid, level)
		local descNode = cell:getChildByFullName("desc")

		self:createSkillDescPanel(descNode, desc)

		local cellparant = self._main:getChildByFullName("celllist.node_" .. count)

		cell:setPosition(0, 0)
		cellparant:addChild(cell)

		count = count + 1
	end

	self._cellclone:setVisible(false)
end

function MazeMasterSkillMediator:createSkillDescPanel(parentNode, desc)
	local size = parentNode:getContentSize()
	local label = ccui.RichText:createWithXML(desc, {})

	label:renderContent()
	label:ignoreContentAdaptWithSize(false)
	label:setContentSize(size.width - 20, 0)
	label:rebuildElements()
	label:formatText()
	label:setAnchorPoint(cc.p(0, 1))
	label:renderContent()

	local height = label:getContentSize().height

	label:addTo(parentNode)
	label:setPosition(cc.p(4, size.height - 4))

	return label
end

function MazeMasterSkillMediator:onClickCloseBtn(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
