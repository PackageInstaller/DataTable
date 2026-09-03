-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeOptionCell.lua

MazeOptionCell = class("MazeOptionCell", legs.Actor)

MazeOptionCell:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {}
local initScale = 0.9

function MazeOptionCell:initialize(model)
	super.initialize(self)

	local resFile = "asset/ui/MazeMainCell.csb"

	self._view = cc.CSLoader:createNode(resFile)
	self._openViewName = model._viewName
	self._model = model
	self._showConfig = ConfigReader:getRecordById("PansLabOptionInfo", self._model:getType())
	self._isSelect = false
	self._index = "0"
end

function MazeOptionCell:dispose()
	super.dispose(self)
end

function MazeOptionCell:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeOptionCell:mapEventListeners()
	return
end

function MazeOptionCell:onRemove()
	super.onRemove(self)
end

function MazeOptionCell:enterWithData(data)
	self:initData()
	self:updateUI()
end

function MazeOptionCell:initData()
	return
end

function MazeOptionCell:setIndex(index)
	self._index = index
end

function MazeOptionCell:getView()
	return self._view
end

function MazeOptionCell:updateUI()
	local view = self:getView()
	local model = self._model
	local cellclone_base = view:getChildByFullName("cellclone")
	local cellclone_boss = view:getChildByFullName("cellclone_boss")
	local cellclone_story = view:getChildByFullName("cellclone_story")
	local cellclone = cellclone_base

	if model:isTypeBoss() then
		cellclone = cellclone_boss
	elseif model:isTypeStory() then
		cellclone = cellclone_story
	end

	cellclone:setPosition(cc.p(0, 0))
	cellclone_base:setVisible(false)
	cellclone_boss:setVisible(false)
	cellclone_story:setVisible(false)
	cellclone:setVisible(true)

	self._cellBg = cellclone:getChildByFullName("bg")

	self._cellBg:setScale(initScale)

	self._touchmask = cellclone:getChildByFullName("touchmask")
	self._desc = cellclone:getChildByFullName("desc")

	self._desc:setVisible(false)

	self._selectFrame = cellclone:getChildByFullName("bg.icon_bg.icon_frame")

	self._selectFrame:setVisible(false)

	self._checkBtn = cellclone:getChildByFullName("checkBtn")

	self._checkBtn:setVisible(false)
	self._checkBtn:addTouchEventListener(function(sender, eventType)
		self:onClickCheckBtn(sender, eventType)
	end)

	self._delBtn = cellclone:getChildByFullName("bg.delBtn")

	self._delBtn:setVisible(false)
	self._delBtn:addTouchEventListener(function(sender, eventType)
		self:onClickDelBtn(sender, eventType)
	end)
	cellclone:getChildByFullName("bg.title"):setString(self:getOptionName())
	cellclone:getChildByFullName("desc"):setString(self:getOptionDesc())
	cellclone:getChildByFullName("checkBtn.Text_3"):setString(self:getOptionBtnName())

	local icontype, icon = self:getOptionIcon()
	local iconbg = cellclone:getChildByFullName("bg.icon_bg.icon")
	local aninode = cellclone:getChildByFullName("bg.icon_bg.aninode")

	if icontype == 1 then
		iconbg:loadTexture(icon, ccui.TextureResType.plistType)
	elseif icontype == 2 then
		iconbg:setVisible(false)

		if model:isTypeBoss() then
			icon:setPosition(0, -20)
		elseif model:isTypeEnemy() then
			icon:setPosition(0, -80)
		end

		icon:setScale(0.8)
		aninode:addChild(icon)
	elseif icontype == 3 then
		iconbg:setVisible(false)
	end

	print("cellclone", cellclone:isVisible())
end

function MazeOptionCell:isCanHandDel()
	local handdellist = ConfigReader:getDataByNameIdAndKey("ConfigValue", "PansLabOptionUnClose", "content")

	for k, v in pairs(handdellist) do
		if self._model:getType() == v then
			return false
		end
	end

	return true
end

function MazeOptionCell:getOptionReward()
	if self._model:isTypeBoss() or self._model:isTypeEnemy() then
		return (ConfigReader:getDataByNameIdAndKey("Reward", self._model._rewardId, "Content"))
	end

	return nil
end

function MazeOptionCell:getOptionName()
	if self._model:isTypeBoss() or self._model:isTypeEnemy() then
		local infodata = ConfigReader:getDataByNameIdAndKey("PansLabOption", self._model:getOptionId(), "Value")
		local nameid = ConfigReader:getDataByNameIdAndKey("PansLabFightPoint", infodata.point, "Name")

		return (Strings:get(nameid))
	elseif self._showConfig then
		return Strings:get(self._showConfig.OptionName)
	end
end

function MazeOptionCell:getOptionIcon()
	local icontype, iconImg

	if self._model:isTypeBoss() or self._model:isTypeEnemy() then
		icontype = 2

		local infodata = ConfigReader:getDataByNameIdAndKey("PansLabOption", self._model:getOptionId(), "Value")
		local masterid = ConfigReader:getDataByNameIdAndKey("PansLabFightPoint", infodata.point, "EnemyMaster")
		local iconid = ConfigReader:getDataByNameIdAndKey("EnemyMaster", masterid, "RoleModel")
		local iconidd = ConfigReader:getDataByNameIdAndKey("RoleModel", iconid, "Model")

		self.roleAnim = self._mazeSystem:createOneMasterAni(iconidd)
		iconImg = self.roleAnim
	elseif self._model:isTypeStory() then
		icontype = 3
		iconImg = nil
	elseif self._showConfig then
		icontype = 1
		iconImg = self._showConfig.Icon .. ".png"
	end

	return icontype, iconImg
end

function MazeOptionCell:getOptionDesc()
	if self._showConfig and self._showConfig.Id == "MasterCure" then
		return Strings:get(self._showConfig.OptionName) .. "\n剩余次数:" .. self._model:getLeftTimes()
	elseif self._showConfig then
		return Strings:get(self._showConfig.OptionName)
	elseif self._model:isTypeBoss() or self._model:isTypeEnemy() then
		local infodata = ConfigReader:getDataByNameIdAndKey("PansLabOption", self._model:getOptionId(), "Value")
		local descid = ConfigReader:getDataByNameIdAndKey("PansLabFightPoint", infodata.point, "Name")

		return (Strings:get(descid))
	end
end

function MazeOptionCell:getOptionBtnName()
	local name = ""

	if self._showConfig then
		name = Strings:get(self._showConfig.BtnName)
	elseif self._model:isTypeBoss() or self._model:isTypeEnemy() then
		local infodata = ConfigReader:getDataByNameIdAndKey("PansLabOption", self._model:getOptionId(), "Value")
		local transid = ConfigReader:getDataByNameIdAndKey("PansLabFightPoint", infodata.point, "BtnName")

		name = Strings:get(transid)
	end

	return name
end

function MazeOptionCell:resetCell()
	self._isSelect = false

	self:updateSelect()
end

function MazeOptionCell:updateSelect()
	self._delBtn:setVisible(self._isSelect and self:isCanHandDel())
	self._checkBtn:setVisible(self._isSelect)

	if self.roleAnim then
		if self._isSelect then
			self.roleAnim:playAnimation(0, "stand", true)
		else
			self.roleAnim:stopAnimation()
		end

		self.roleAnim:setGray(not self._isSelect)
	end

	if self._isSelect then
		self._cellBg:setScale(1)
	else
		self._cellBg:setScale(initScale)
	end

	self._selectFrame:setVisible(self._isSelect)
	self._desc:setVisible(self._isSelect)
end

function MazeOptionCell:getModel()
	return self._model
end

function MazeOptionCell:enterStory()
	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local storyAgent = storyDirector:getStoryAgent()
	local scrpitName = self._model:getStoryScript()

	local function endCallBack()
		local clueId = storyAgent:popAllMazeClue()

		self._mazeSystem:requestMazestStartOption(self._index, {
			clueId = clueId
		}, function()
			self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
		end)
	end

	storyAgent:setSkipCheckSave(true)
	storyAgent:trigger(scrpitName, nil, endCallBack)
end

function MazeOptionCell:onClickCell(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if not self._isSelect then
			self._isSelect = true

			self:updateSelect()
		end
	end
end

function MazeOptionCell:onClickCheckBtn(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local mazeSystem = self._mazeSystem

		mazeSystem:setCurOptionReward(self:getOptionReward())

		if self._model:isTypeBoss() then
			mazeSystem:requestMazeBattleBefor(self._index, function()
				return
			end)
		elseif self._model:isTypeEnemy() then
			mazeSystem:requestMazeBattleBefor(self._index, function()
				return
			end)
		elseif self._model:isTypeStory() then
			self:enterStory()
		elseif self._openViewName then
			local view = self:getInjector():getInstance(self._openViewName)

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, self))
		elseif self._model:isTypeRefreshOption() then
			mazeSystem:setOptionEventName(EVT_MAZE_REFRESH_OPTION_SUC)
			mazeSystem:requestMazestStartOption(self._index, "", function()
				self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
			end)
		else
			mazeSystem:requestMazestStartOption(self._index, "", function()
				self:dispatch(Event:new(EVT_MAZE_UPDATE_OPTION, nil))
			end)
		end
	end
end

function MazeOptionCell:onClickDelBtn(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._mazeSystem:requestDelOneOption(self._mazeSystem._mazeEvent:getConfigId(), self._index)
	end
end
