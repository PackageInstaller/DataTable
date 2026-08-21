-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\CatSet\\ActivityCatRaceCatSetDlg.lua

local ResOpActivityCatRaceCatDetail = require("ClientData/ResOpActivityCatRaceCatDetail")
local ActivityCatRaceFurChangeCell = require("UI/OpActivity/CatRace/CatSet/ActivityCatRaceFurChangeCell")
local CatRaceConfig = require("UI/OpActivity/CatRace/CatRaceConfig")
local strClassName = "ActivityCatRaceSetDlg"
local ActivityCatRaceCatSetDlg = Class(strClassName, UIControls.Window)

function ActivityCatRaceCatSetDlg:ctor()
	self:initUI()
end

function ActivityCatRaceCatSetDlg:initUI()
	self.catPreviewLive2D = UIControls.LazyLivePlayer(self, "BgPanel/CatReview/CatLive2DPanel")
	self.furChangePanel = UIControls.Panel(self, "BgPanel/CatSetPanel/FurChangeList/Content")
	self.furChangePath = "BgPanel/CatSetPanel/FurChangeList/Content"
	self.furChangePrefabPath = "System/Activity/ActivityCatRace/BtnCatFurChangeCell"
	self.heroChangeBtn = UIControls.Button(self, "BgPanel/CatSetPanel/BtnHero")

	self.heroChangeBtn:setVisible(false)

	self.confirmBtn = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.confirmBtn:addEventClick(self._onBtnConfirm)

	self.closeBtn = UIControls.Button(self, "BgPanel/BtnDeny")

	self.closeBtn:addEventClick(self._onBtnClose)
end

function ActivityCatRaceCatSetDlg:setData(data)
	self.data = data
	self.actID = data.actID
	self.opID = CurAvatar:getActivityObj(self.actID).opId
	self.catList = ResOpActivityCatRaceCatDetail[self.actID]
	self.catCellList = {}
	self.selectCallback = Slot(self._onBtnFurSelected, self)

	for catID, catDetail in ipairs(self.catList) do
		local catCell = ActivityCatRaceFurChangeCell(self, self.furChangePath, self.furChangePrefabPath)

		catCell:setData(catDetail, self.selectCallback)
		table.insert(self.catCellList, catCell)
	end

	self.curSelectedID = data.curSelected

	if self.curSelectedID == 0 then
		self.curSelectedID = CatRaceConfig.CAT_DEFAULT_COLOR
	end

	self.curDetail = self.catList[self.curSelectedID]

	self:previewCat(self.curDetail)

	for index, catCell in ipairs(self.catCellList) do
		if index == self.curSelectedID then
			catCell:setState(CatRaceConfig.CAT_SELECTED)
		else
			catCell:setState(CatRaceConfig.CAT_UNSELECTED)
		end
	end
end

function ActivityCatRaceCatSetDlg:_onBtnFurSelected(sender, data)
	self:previewCat(data)

	self.curSelectedID = data.cat_id

	for _, catCell in pairs(self.catCellList) do
		if catCell == sender then
			catCell:setState(CatRaceConfig.CAT_SELECTED)
		else
			catCell:setState(CatRaceConfig.CAT_UNSELECTED)
		end
	end
end

function ActivityCatRaceCatSetDlg:_onBtnConfirm()
	if self.curSelectedID and self.curSelectedID ~= self.data.curSelected then
		CurAvatar:activityRPC(Functor(RPC.opActCatRaceSetCatInfo, self.opID, self.curSelectedID), self.opID)
	end

	self:setVisible(false)
end

function ActivityCatRaceCatSetDlg:previewCat(data)
	local live2D_path = data.live2D_path

	if live2D_path then
		self.catPreviewLive2D:playLive2DByPath(live2D_path)
		self.catPreviewLive2D:playState(CatRaceConfig.CAT_IDLE_STATE)
	end
end

function ActivityCatRaceCatSetDlg:_onBtnClose()
	self:setVisible(false)
end

return ActivityCatRaceCatSetDlg
