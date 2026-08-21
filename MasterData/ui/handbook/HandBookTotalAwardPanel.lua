-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookTotalAwardPanel.lua

local ResRandClient = require("ClientData/ResRandClient")
local strClassName = "HandBookTotalAwardPanel"
local HandBookTotalAwardPanel = Class(strClassName, UIControls.Panel)

function HandBookTotalAwardPanel:ctor()
	self:initUI()
end

function HandBookTotalAwardPanel:initUI()
	self.imgGroup = UIControls.Image(self, self.mPath .. "/IconGroup")
	self.imgBigGroup = UIControls.Image(self, self.mPath .. "/BgMask/IconGroupBig")
	self.txtTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.txtProgress = UIControls.Label(self, self.mPath .. "/TextTitle/TextNum")
	self.txtDes = UIControls.Label(self, self.mPath .. "/TextTitle/TextRule")
	self.imgDone = UIControls.Image(self, self.mPath .. "/ImgDone")
	self.imgFront = UIControls.Image(self, self.mPath .. "/BgFront")
	self.efxGrid = UIControls.Panel(self, self.mPath .. "/GridPanel/EfxGrid")
end

function HandBookTotalAwardPanel:setData(data)
	self.data = data

	self:refreshAwardGrid()
	self:refreshInfoPanel()
end

function HandBookTotalAwardPanel:refreshAwardGrid()
	local randInfo = ResRandClient[self.data.award_id]
	local fakeItem = BaseObject.GetObject(randInfo.show_ids[1], randInfo.show_nums[1])

	if not self.awardGrid then
		self.awardGrid = UIControls.getGridChild(fakeItem, self, self.mPath .. "/GridPanel")
	end

	self.awardGrid:setVisible(true)
	self.awardGrid:setObj(fakeItem)

	self.awardGrid.mEventClick = nil
	self.awardGrid.mEnableTips = true

	local taskStatus = CurAvatar.handBookTaskDic[self.data.id] and CurAvatar.handBookTaskDic[self.data.id].status or 0

	self.imgDone:setVisible(taskStatus == Const.TASK_STATUS.AWARD_GOT)
	self.awardGrid.imgNew:setVisible(taskStatus == Const.TASK_STATUS.COMPLETE)
	self.efxGrid:setVisible(taskStatus == Const.TASK_STATUS.COMPLETE)

	if taskStatus == Const.TASK_STATUS.COMPLETE then
		self.awardGrid.mEventClick = Slot(self.onGetAward, self)
		self.awardGrid.mEnableTips = false
	end
end

function HandBookTotalAwardPanel:onGetAward()
	if self.awardGrid then
		self.awardGrid:flyToCommonFuncEntryPanel()
	end

	RPC.bookTaskGetAward(self.data.id)
end

function HandBookTotalAwardPanel:refreshInfoPanel()
	self.txtTitle:setText(self.data.title)
	self.txtDes:setText(self.data.des)

	local progress = CurAvatar.handBookTaskDic[self.data.id] and CurAvatar.handBookTaskDic[self.data.id].progress or "0"

	self.txtProgress:setText(progress .. "/" .. self.data.num)

	local groupSprite = {
		"Atlas/OtherBattleAtlas/EquipTowerAtlas",
		"IconGroupL0" .. self.data.camp
	}

	self.imgGroup:setImage(groupSprite[1], groupSprite[2])
	self.imgBigGroup:setImage(groupSprite[1], groupSprite[2])
	self.imgFront:setImage("Atlas/HandBookAtlas/HandBookAtlas", "ImgFrame" .. self.data.camp)
end

return HandBookTotalAwardPanel
