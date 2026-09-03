-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/maze/view/MazeChapterCell.lua

MazeChapterCell = class("MazeChapterCell", legs.Actor)

MazeChapterCell:has("_mazeSystem", {
	is = "rw"
}):injectWith("MazeSystem")

local kBtnHandlers = {}

function MazeChapterCell:initialize(data, ms)
	super.initialize(self)

	local resFile = "asset/ui/MazeChapterCell.csb"

	self._view = cc.CSLoader:createNode(resFile)

	if data._viewName then
		self._openViewName = data._viewName
	end

	self._data = data
	self._mazeSystem = ms
	self._config = ConfigReader:getRecordById("PansLabChapter", self._data)
	self._isSelect = false
	self._index = ""

	self:initViews()
end

function MazeChapterCell:dispose()
	super.dispose(self)
end

function MazeChapterCell:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MazeChapterCell:mapEventListeners()
	return
end

function MazeChapterCell:onRemove()
	super.onRemove(self)
end

function MazeChapterCell:enterWithData(data)
	self:initData()
	self:initViews()
end

function MazeChapterCell:initData()
	return
end

function MazeChapterCell:initViews()
	self._cellclone = self:getView():getChildByFullName("cellclone")
	self._touchmask = self:getView():getChildByFullName("cellclone.touchmask")
	self._checkBtn = self._cellclone:getChildByFullName("checkBtn")
	self._cellBg = self._cellclone:getChildByFullName("bg")
	self._delBtn = self._cellclone:getChildByFullName("bg.delBtn")
	self._iconbg = self._cellclone:getChildByFullName("bg.icon_bg")

	self._delBtn:setVisible(false)
	self._checkBtn:setVisible(false)
	self._delBtn:addTouchEventListener(function(sender, eventType)
		self:onClickDelBtn(sender, eventType)
	end)
end

function MazeChapterCell:setChapterIndex(index)
	self._index = index
end

function MazeChapterCell:getView()
	return self._view
end

function MazeChapterCell:isCanHandDel()
	local handdellist = ConfigReader:getDataByNameIdAndKey("ConfigValue", "PansLabOptionUnClose", "content")

	for k, v in pairs(handdellist) do
		if self._data:getType() == v then
			return false
		end
	end

	return true
end

function MazeChapterCell:getOptionReward()
	if self._data:getType() == "Boss" or self._data:getType() == "Enemy" then
		return (ConfigReader:getDataByNameIdAndKey("Reward", self._data._rewardId, "Content"))
	end
end

function MazeChapterCell:getChapterName()
	return Strings:get(self._config.Name)
end

function MazeChapterCell:getChapterIcon()
	return ""
end

function MazeChapterCell:getChapterIndex()
	return self._index
end

function MazeChapterCell:getChapterDesc()
	return Strings:get(self._config.BtnDesc)
end

function MazeChapterCell:getChapterBtnName()
	return "进入"
end

function MazeChapterCell:resetCell()
	self._isSelect = false

	self:updateSelect()
end

function MazeChapterCell:updateSelect()
	self._checkBtn:setVisible(self._isSelect)

	if self._isSelect then
		self._cellBg:setScale(1.117)
	else
		self._cellBg:setScale(1)
	end
end

function MazeChapterCell:onClickCell(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		if not self._isSelect then
			self._isSelect = true

			self:updateSelect()
		end
	end
end

function MazeChapterCell:onClickDelBtn(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
		self._mazeSystem:requestDelOneOption(self._mazeSystem._mazeChapter._chapterType, self._index)
	end
end
