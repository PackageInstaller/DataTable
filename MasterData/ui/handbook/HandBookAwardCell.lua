-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookAwardCell.lua

local ResRandClient = require("ClientData/ResRandClient")
local HandBookAwardGridHero = require("UI/HandBook/HandBookAwardGridHero")
local strClassName = "HandBookAwardCell"
local HandBookAwardCell = Class(strClassName, UIControls.Child)

function HandBookAwardCell:ctor()
	self:initUI()
end

function HandBookAwardCell:initUI()
	self.imgDone = UIControls.Image(self, "Content/ImgDone")
	self.txtPropgress = UIControls.Label(self, "Content/TextTitle/TextNum")
	self.txtTitle = UIControls.Label(self, "Content/TextTitle")
	self.txtDes = UIControls.Label(self, "Content/TextTitle/TextRule")
	self.efxGrid = UIControls.Panel(self, "Content/GridPanel/EfxGrid")
	self.aniSelf = UIControls.UIAni(self, "")
end

function HandBookAwardCell:setData(data)
	self.data = data
	self.mWindow.cellIsPlayingDic[self.data.id] = nil

	self:refreshAwardGrid()
	self:refreshGridHero()
	self.txtTitle:setText(self.data.title)
	self.txtDes:setText(self.data.des)
	self.aniSelf:clearEventFinish()
	self.aniSelf:startAni("ShowHandBookAwardCell", true)
end

function HandBookAwardCell:refreshAwardGrid()
	local randInfo = ResRandClient[self.data.award_id]
	local fakeItem = BaseObject.GetObject(randInfo.show_ids[1], randInfo.show_nums[1])

	if not self.awardGrid then
		self.awardGrid = UIControls.getGridChild(fakeItem, self, "Content/GridPanel")
	end

	self.awardGrid:setVisible(true)
	self.awardGrid:setObj(fakeItem)

	self.awardGrid.mEventClick = nil
	self.awardGrid.mEnableTips = true
	self.awardGrid.mDisableWays = true

	self.imgDone:setVisible(self.data.status == Const.TASK_STATUS.AWARD_GOT)
	self.awardGrid.imgNew:setVisible(self.data.status == Const.TASK_STATUS.COMPLETE)
	self.efxGrid:setVisible(self.data.status == Const.TASK_STATUS.COMPLETE)

	if self.data.status == Const.TASK_STATUS.COMPLETE then
		self.awardGrid.mEventClick = Slot(self.onGetAward, self)
		self.awardGrid.mEnableTips = false
	end
end

function HandBookAwardCell:onGetAward()
	self.data.status = Const.TASK_STATUS.AWARD_GOT

	self:setData(self.data)

	self.awardGrid.mEnableTips = false

	self.awardGrid:flyToCommonFuncEntryPanel()
	RPC.bookTaskGetAward(self.data.id)
	self.aniSelf:addEventFinish(Slot(self.hideEndCallBack, self))
	self.aniSelf:startAni("HideHandBookAwardCell", true)

	self.mWindow.cellIsPlayingDic[self.data.id] = 1
end

function HandBookAwardCell:hideEndCallBack()
	self.mWindow.cellIsPlayingDic[self.data.id] = nil

	if utils.getTableElemCount(self.mWindow.cellIsPlayingDic) == 0 then
		self.mWindow:refreshShow()
	end
end

function HandBookAwardCell:refreshGridHero()
	if not self.gridHeroList then
		self.gridHeroList = {}
	end

	local heros = self.data.heroIds
	local getCount = 0

	for i, id in ipairs(heros) do
		if not self.gridHeroList[i] then
			self.gridHeroList[i] = HandBookAwardGridHero(self, "Content/GridHeroPanel", "System/HandBook/GridHeroHandBookCell", 0, 0, true)
		end

		local hero = BaseObject.GetObject(id)

		self.gridHeroList[i]:setHero(hero)

		if CurAvatar.handBookHeroDic[hero.id] then
			getCount = getCount + 1
		end
	end

	if #self.gridHeroList > #heros then
		for i = #heros + 1, #self.gridHeroList do
			self.gridHeroList[i]:destroy()

			self.gridHeroList[i] = nil
		end
	end

	self.txtPropgress:setText(getCount .. "/" .. #heros)
end

return HandBookAwardCell
