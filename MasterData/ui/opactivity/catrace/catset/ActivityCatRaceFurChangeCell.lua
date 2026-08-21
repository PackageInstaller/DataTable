-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\CatSet\\ActivityCatRaceFurChangeCell.lua

local strClassName = "ActivityCatRaceFurChangeCell"
local ActivityCatRaceFurChangeCell = Class(strClassName, UIControls.Child)

function ActivityCatRaceFurChangeCell:ctor()
	self:initUI()
end

function ActivityCatRaceFurChangeCell:initUI()
	self.furPreviewImg = UIControls.Image(self, "ImgPreview")
	self.choosedImg = UIControls.Image(self, "BgChoose")
	self.selectBtn = UIControls.Button(self, "")

	self.selectBtn:addEventClick(self._onBtnSelect)
end

function ActivityCatRaceFurChangeCell:setData(data, selectCallback)
	self.data = data

	self.furPreviewImg:setImage(data.img_path, data.img_name)

	self.selectCallback = selectCallback

	self:setVisible(true)
end

function ActivityCatRaceFurChangeCell:setState(state)
	self.state = state

	self.choosedImg:setVisible(state)
end

function ActivityCatRaceFurChangeCell:_onBtnSelect()
	if self.selectCallback then
		self:selectCallback(self.data)
	end
end

return ActivityCatRaceFurChangeCell
