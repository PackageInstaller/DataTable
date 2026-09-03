-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeChapteBossMediator.lua

MazeChapteBossMediator = class("MazeChapteBossMediator", DmPopupViewMediator, _M)

MazeChapteBossMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	["main.checkBtn"] = "onClickClueChek"
}

function MazeChapteBossMediator:initialize()
	super.initialize(self)
end

function MazeChapteBossMediator:dispose()
	super.dispose(self)
end

function MazeChapteBossMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeChapteBossMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_CLUE_SUC, self, self.updateViews)
end

function MazeChapteBossMediator:dispose()
	super.dispose(self)
end

function MazeChapteBossMediator:enterWithData(data)
	self._data = data

	self:initData()
	self:initView()
end

function MazeChapteBossMediator:initData()
	self._selectSuspectId = ""
end

function MazeChapteBossMediator:initView()
	self._suspectPanel = self:getView():getChildByFullName("main.questionList.suspectPanel")
	self._sName = self:getView():getChildByFullName("main.q_desc_name")

	self._suspectPanel:setScrollBarEnabled(false)
	self:createSuspectList()
end

function MazeChapteBossMediator:updateViews()
	self._mazeSystem:getChapter()._nextChapterIds = ConfigReader:getDataByNameIdAndKey("PansLabChapter", self._mazeSystem._mazeChapter._chapterId, "NextChapter") or ""

	if self._mazeSystem:getChapter()._nextChapterIds == "" then
		self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
		self:dispatch(Event:new(EVT_MAZE_SHOW_GP, nil))
		self:close()
		print("显示boss归票界面！！！！")
	else
		self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
		self:close()
	end
end

function MazeChapteBossMediator:showVotesView()
	if not self._mazeSystem._mazeChapter then
		return
	end

	local suspectsdata = self._mazeSystem._mazeChapter._suspectPointList
	local votes = 0

	for k, v in pairs(suspectsdata) do
		votes = votes + v
	end

	self._mazeSystem:getChapter()._nextChapterIds = ConfigReader:getDataByNameIdAndKey("PansLabChapter", self._mazeSystem._mazeChapter._chapterId, "NextChapter") or ""

	local c0 = table.nums(self._mazeSystem._mazeChapter._showOptions)
	local c1 = table.nums(suspectsdata)
	local c2 = self._mazeSystem._mazeChapter._nextChapterIds
	local c3 = table.nums(self._mazeSystem._mazeChapter._leftOptions)

	if c1 > 0 and votes > 0 and c2 == "" and c3 == 0 and c0 == 0 then
		local view = self:getInjector():getInstance("MazeSuspectVotesView")
		local data = {
			suspects = suspectsdata
		}

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, data))
	end
end

function MazeChapteBossMediator:createSuspectList()
	local count = 1
	local starpos = 50

	for k, v in pairs(self._data.suspects) do
		local config = ConfigReader:getRecordById("PansLabSuspects", v)
		local aniid = ConfigReader:getDataByNameIdAndKey("RoleModel", config.Model, "Model")

		print("模型id--->", config.Model)

		if config.Model ~= "Model_YSuo" then
			local ani = self:createOneMasterAni(aniid, false, true)

			ani:setPosition(starpos + (count - 1) * 180, 10)
			ani:setScale(0.7)

			local touchmask = ccui.Layout:create()

			touchmask:setContentSize(cc.size(110, 180))
			touchmask:setTouchEnabled(true)
			touchmask:setSwallowTouches(false)
			touchmask:setPosition(-40, 0)
			touchmask:addTouchEventListener(function(sender, eventType)
				if eventType == ccui.TouchEventType.ended then
					AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
					self:selectSuspect(v)
				end
			end)
			ani:addChild(touchmask)
			self._suspectPanel:addChild(ani)

			count = count + 1
		end
	end

	self._suspectPanel:setInnerContainerSize(cc.size(count * 150, 160))
end

function MazeChapteBossMediator:selectSuspect(id)
	self._selectSuspectId = id

	local snameid = ConfigReader:getDataByNameIdAndKey("PansLabSuspects", id, "Name")

	self._sName:setString(Strings:get(snameid))
end

function MazeChapteBossMediator:createOneMasterAni(modelid, gray, play)
	local modelId = modelid
	local pre = "asset/anim/"

	print("要创建的模型id--->", modelId)

	local jsonFile = pre .. modelId .. ".skel"
	local roleAnim = sp.SkeletonAnimation:create(jsonFile)

	if gray then
		roleAnim:setGray(gray)
		roleAnim:setColor(cc.c3b(0, 0, 0))
	else
		roleAnim:setGray(false)
	end

	if play then
		roleAnim:playAnimation(0, "stand", true)
	end

	return roleAnim
end

function MazeChapteBossMediator:createQuestionCheckBtn(id)
	return
end

function MazeChapteBossMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end
end

function MazeChapteBossMediator:onClickClueChek(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if self._selectSuspectId == "" then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("MAZE_SUSPECT_TIPS")
			}))

			return
		end

		self:checkClue()
	end
end

function MazeChapteBossMediator:checkClue()
	local data = {
		clueId = self._selectSuspectId
	}
	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(data)

	self._mazeSystem:setOptionEventName(EVT_MAZE_CLUE_SUC)
	self._mazeSystem:requestMazestStartOption(self._mazeSystem:getClueOptionIndex(), paramsData)
end
