-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeQuestionMediator.lua

MazeQuestionMediator = class("MazeQuestionMediator", DmPopupViewMediator, _M)

MazeQuestionMediator:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {
	["answer.Button_1"] = "onClickExitAnswer",
	["main.checkBtn_0"] = "onClickClueA",
	["main.checkBtn_2"] = "onClickClueC",
	["main.checkBtn_1"] = "onClickClueB"
}
local selectPos = {
	{
		"pos_2"
	},
	{
		"pos_4",
		"pos_5"
	},
	{
		"pos_1",
		"pos_2",
		"pos_3"
	}
}

function MazeQuestionMediator:initialize()
	super.initialize(self)
end

function MazeQuestionMediator:dispose()
	super.dispose(self)
end

function MazeQuestionMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function MazeQuestionMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MAZE_CLUE_SUC, self, self.updateViews)
end

function MazeQuestionMediator:dispose()
	super.dispose(self)
end

function MazeQuestionMediator:enterWithData(data)
	self._data = data

	self:initData()
	self:initView()
end

function MazeQuestionMediator:initData()
	self._cluesName = ""
	self._cluesDesc = ""
end

function MazeQuestionMediator:haveUnlock(sid)
	local unlockSuspects = self._mazeSystem._mazeEvent:getSuspects()

	for k, v in pairs(unlockSuspects) do
		if k == sid and v then
			return true
		end
	end

	return false
end

function MazeQuestionMediator:initView()
	local unlockSuspects = self._mazeSystem._mazeEvent:getSuspects()

	dump(unlockSuspects, "已解锁嫌疑人")

	self._answerView = self:getView():getChildByFullName("answer")
	self._questionView = self:getView():getChildByFullName("main")

	self._answerView:setVisible(false)

	self._questionDesc = self:getView():getChildByFullName("main.desc")

	self._questionDesc:setString(self._data.question)

	local option = {
		"A",
		"B",
		"C"
	}
	local count = 1

	for i = 0, 2 do
		self:getView():getChildByFullName("main.quesCell_" .. i):setVisible(false)
		self:getView():getChildByFullName("main.checkBtn_" .. i):setVisible(false)
	end

	for k, v in pairs(self._data.clues) do
		self:getView():getChildByFullName("main.quesCell_" .. k):setVisible(true)
		self:getView():getChildByFullName("main.quesCell_" .. k .. ".q_desc"):setString(option[count] .. ": " .. self._data.clues[k])

		count = count + 1

		local iicon = self:getView():getChildByFullName("main.quesCell_" .. k .. ".icon")
		local key = tostring(k)
		local sid = ConfigReader:getDataByNameIdAndKey("PansLabClue", self._data.cluesid[key], "Suspect")

		for kk, vv in pairs(sid) do
			if self:haveUnlock(kk) then
				local ids = ConfigReader:getDataByNameIdAndKey("PansLabSuspects", kk, "Model")
				local img = IconFactory:createRoleIconSprite({
					clipType = 3,
					id = ids
				})

				img = IconFactory:addStencilForIcon(img, 2, cc.size(70, 70))

				iicon:addChild(img)
				iicon:setVisible(true)
				iicon:setScale(0.7)

				local svalue = vv

				if svalue > 0 then
					self:getView():getChildByFullName("main.quesCell_" .. k .. ".value"):setString("+" .. svalue)
				else
					self:getView():getChildByFullName("main.quesCell_" .. k .. ".value"):setString("" .. svalue)
				end
			end
		end

		self:getView():getChildByFullName("main.checkBtn_" .. k):setVisible(true)

		local num = table.nums(self._data.clues)
		local posname = selectPos[num][k + 1]
		local pos = cc.p(self:getView():getChildByFullName("main." .. posname):getPosition())

		self:getView():getChildByFullName("main.checkBtn_" .. k):setPosition(pos)
	end
end

function MazeQuestionMediator:updateViews()
	self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
	self._questionView:setVisible(false)
	self._answerView:setVisible(true)
	self._answerView:getChildByFullName("cluename"):setString(self._cluesName)
	self._answerView:getChildByFullName("Text_3"):setString(self._cluesDesc)
	self:createSuspectIcon(self._answerView:getChildByFullName("Image_41"), self._cluesId)
	dump(self._data.clues, "线索列表名字")
	dump(self._data.cluesid, "线索列表id")
end

function MazeQuestionMediator:createQuestionCell(id)
	return
end

function MazeQuestionMediator:createQuestionCheckBtn(id)
	return
end

function MazeQuestionMediator:onClickExit(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:close()
	end
end

function MazeQuestionMediator:onClickExitAnswer(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._answerView:setVisible(false)
		self:close()
	end
end

function MazeQuestionMediator:onClickClueChek(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end
end

function MazeQuestionMediator:onClickClueA(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:checkClue(self._data.cluesid[tostring(0)])
	end
end

function MazeQuestionMediator:onClickClueB(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:checkClue(self._data.cluesid[tostring(1)])
	end
end

function MazeQuestionMediator:onClickClueC(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self:checkClue(self._data.cluesid[tostring(2)])
	end
end

function MazeQuestionMediator:checkClue(clueid)
	self._questionView:setVisible(false)

	local data = {
		clueId = clueid
	}

	self._cluesId = clueid
	self._cluesName = Strings:get(ConfigReader:getDataByNameIdAndKey("PansLabClue", clueid, "Name"))
	self._cluesDesc = Strings:get(ConfigReader:getDataByNameIdAndKey("PansLabClue", clueid, "Desc"))

	print("所选选项的线索文本--->", self._cluesName, "--", self._cluesDesc)

	local cjson = require("cjson.safe")
	local paramsData = cjson.encode(data)

	self._mazeSystem:setOptionEventName(EVT_MAZE_CLUE_SUC)
	self._mazeSystem:requestMazestStartOption(self._mazeSystem:getClueOptionIndex(), paramsData)
end

function MazeQuestionMediator:createSuspectIcon(parent, id)
	local sid = ConfigReader:getDataByNameIdAndKey("PansLabClue", id, "Suspect")

	self._answerView:getChildByFullName("cluename_0"):setVisible(false)

	for kk, vv in pairs(sid) do
		local ids = ConfigReader:getDataByNameIdAndKey("PansLabSuspects", kk, "Model")
		local img = IconFactory:createRoleIconSprite({
			clipType = 3,
			id = ids
		})

		img = IconFactory:addStencilForIcon(img, 2, cc.size(70, 70))

		parent:addChild(img)
		parent:setVisible(true)
		parent:setScale(0.7)
		self._answerView:getChildByFullName("cluename_0"):setVisible(true)

		local svalue = vv

		if svalue > 0 then
			self._answerView:getChildByFullName("cluename_0"):setString("+" .. svalue)
		else
			self._answerView:getChildByFullName("cluename_0"):setString(svalue)
		end
	end
end
