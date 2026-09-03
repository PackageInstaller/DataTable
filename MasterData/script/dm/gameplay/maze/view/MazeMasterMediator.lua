-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeMasterMediator.lua

MazeMasterMediator = class("MazeMasterMediator", DmAreaViewMediator, _M)

MazeMasterMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")
MazeMasterMediator:has("_systemKeeper", {
	is = "rw"
}):injectWith("SystemKeeper")

local kBtnHandlers = {
	entermazebtn = "onClickEnterMaze"
}
local MAZE_TYPE = {
	[1] = "NORMAL",
	[2] = "INFINITY"
}

function MazeMasterMediator:initialize()
	super.initialize(self)
end

function MazeMasterMediator:dispose()
	super.dispose(self)
end

function MazeMasterMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeMasterMediator:mapEventListeners()
	return
end

function MazeMasterMediator:onRemove()
	super.onRemove(self)
end

function MazeMasterMediator:enterWithData(data)
	self._data = data
	self._mazeType = MAZE_TYPE[self._data.selectType]
	self._curRoldListData = {}
	self._masterId = nil

	self:initData()
	self:initViews()
end

function MazeMasterMediator:initData(data)
	self._selectType = self._data.selectType
	self._roleModelList = {}
end

function MazeMasterMediator:initViews()
	self._havepass = self:getView():getChildByFullName("normalpanel.normalCount_1")
	self._allpass = self:getView():getChildByFullName("normalpanel.normalCount_2")

	self._havepass:setString(self._mazeSystem:getNormalChallengeCount())
	self._allpass:setString(self._mazeSystem:getNormalAllTimes())

	self._tips = self:getView():getChildByFullName("Text_5")

	for i = 1, 2 do
		self:getView():getChildByFullName("title_" .. i):setVisible(self._selectType == i)
	end

	dump(self._mazeSystem._masterNormalList)

	if self._selectType == 1 then
		self._curRoldListData = self._mazeSystem._masterNormalList
	elseif self._selectType == 2 then
		self._curRoldListData = self._mazeSystem._masterNormalList
	end

	for k, v in pairs(self._curRoldListData) do
		local modelid = ConfigReader:getDataByNameIdAndKey("MasterBase", v, "RoleModel")
		local rolemodleid = ConfigReader:getDataByNameIdAndKey("RoleModel", modelid, "Model")

		self._roleModelList[k] = self._mazeSystem:createOneMasterAni(rolemodleid)

		self:getView():getChildByFullName("masterPanel.master_" .. k):addChild(self._roleModelList[k])
	end

	self:registRoleTouch()
	self:setupTopInfoWidget()
end

function MazeMasterMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("PansLabNormal")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		title = "",
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickExit, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function MazeMasterMediator:registRoleTouch()
	for i = 1, 3 do
		local touchpanel = self:getView():getChildByFullName("Panel_" .. i - 1)

		touchpanel:addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self._curSelectRoleId = string.split(sender:getName(), "_")[2]

				for k, v in pairs(self._roleModelList) do
					if k == self._curSelectRoleId then
						self._roleModelList[k]:playAnimation(0, "stand", true)
						self._roleModelList[k]:setGray(false)
					else
						self._roleModelList[k]:stopAnimation()
						self._roleModelList[k]:setGray(true)
					end
				end

				self._masterId = self._curRoldListData[self._curSelectRoleId]

				self._mazeSystem:setSelectMaster(self._masterId)

				local id = ConfigReader:getDataByNameIdAndKey("MasterBase", self._masterId, "Name")

				self._tips:setString("选择" .. Strings:find(id) .. "进入迷宫")
			end
		end)
	end
end

function MazeMasterMediator:onClickEnterMaze(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if not self._masterId then
			self:dispatch(ShowTipEvent({
				duration = 0.2,
				tip = Strings:find("MAZE_SELECTMASTER")
			}))

			return
		end

		self._mazeSystem:requestFirstEnterMaze(self._mazeType, self._masterId, function(response)
			self:enterTrialView()
		end)
	end
end

function MazeMasterMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:dismiss()
	end
end

function MazeMasterMediator:enterTrialView()
	self._mazeSystem:setMazeState(0)

	local view = self:getInjector():getInstance("MazeMainView")
	local data = {}

	self:dispatch(ViewEvent:new(EVT_SWITCH_VIEW, view, nil, data))
end
