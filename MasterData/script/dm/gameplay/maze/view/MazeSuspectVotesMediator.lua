-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeSuspectVotesMediator.lua

MazeSuspectVotesMediator = class("MazeSuspectVotesMediator", DmPopupViewMediator, _M)

MazeSuspectVotesMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	["main.checkBtn"] = "onClickCheck"
}

function MazeSuspectVotesMediator:initialize()
	super.initialize(self)
end

function MazeSuspectVotesMediator:dispose()
	super.dispose(self)
end

function MazeSuspectVotesMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeSuspectVotesMediator:mapEventListeners()
	return
end

function MazeSuspectVotesMediator:dispose()
	super.dispose(self)
end

function MazeSuspectVotesMediator:enterWithData(data)
	self._data = data

	self:initData()
	self:initView()
end

function MazeSuspectVotesMediator:initData()
	self._selectSuspectId = ""
end

function MazeSuspectVotesMediator:initView()
	self:createSuspectList()
end

function MazeSuspectVotesMediator:updateViews()
	self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
	self:close()
end

function MazeSuspectVotesMediator:createSuspectList()
	local count = 1
	local maxVotesName = 0

	for i = 1, 8 do
		local parentNode = self:getView():getChildByFullName("main.cell_" .. i)

		parentNode:setVisible(false)
	end

	for k, v in pairs(self._data.suspects) do
		local parentNode = self:getView():getChildByFullName("main.cell_" .. count)
		local votes = self:getView():getChildByFullName("main.cell_" .. count .. ".votes")
		local name = self:getView():getChildByFullName("q_desc_name")

		votes:setString(v .. "票")

		local ids = ConfigReader:getDataByNameIdAndKey("PansLabSuspects", k, "Model")
		local img = IconFactory:createRoleIconSpriteNew({
			id = ids
		})

		img:setScale(0.7)

		img = IconFactory:addStencilForIcon(img, 2, cc.size(70, 70))

		img:addTo(parentNode):center(parentNode:getContentSize())
		parentNode:setVisible(true)

		if maxVotesName < v then
			maxVotesName = v

			name:setString(Strings:get(ConfigReader:getDataByNameIdAndKey("RoleModel", ids, "Name")))
		end

		count = count + 1
	end
end

function MazeSuspectVotesMediator:createQuestionCheckBtn(id)
	return
end

function MazeSuspectVotesMediator:onClickCheck(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:dispatch(Event:new(EVT_MAZE_FINALL_BOSS_SHOW, nil))
		self:close()
	end
end
