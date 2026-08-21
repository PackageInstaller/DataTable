-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleHeadFrameItem.lua

local CircleHeadFrameItem = Class("CircleHeadFrameItem", UIControls.ScrollViewLoopCell)

function CircleHeadFrameItem:ctor(...)
	self:initUI()
end

function CircleHeadFrameItem:initUI()
	self.sensor = UIControls.Button(self, "")

	self.sensor:addEventClick(self.onSensorClick)

	self.imgHeadFrame = UIControls.Image(self, "IconPlayerHeadFrame")
	self.imgSelect = UIControls.Image(self, "ImgSel")
	self.imgState = UIControls.Image(self, "ImgState")
	self.txtState = UIControls.Label(self, "ImgState/Text")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.imgLimit = UIControls.Image(self, "IconLimit")
end

function CircleHeadFrameItem:refreshSelect()
	self.selected = self.id == self.mWindow.selectFrameId

	self.imgSelect:setVisible(self.selected)
	self.sensor:setEnable(not self.selected)
	self.txtState:setText(Lang.get(901))

	if self.mWindow.inited and not self.isEmpty and self.selected and CurAvatar.hintCircleHeadFrameDic[self.circleHeadFrameData.resData.id] then
		CurAvatar.hintCircleHeadFrameDic[self.circleHeadFrameData.resData.id] = nil

		self.imgNew:setVisible(false)
		CurAvatar:hintCircleEditHead()
		self.mWindow:refreshTabHint()
	end
end

function CircleHeadFrameItem:setCircleHeadFrameData(circleHeadFrameData, isEmpty)
	self.circleHeadFrameData = circleHeadFrameData
	self.isEmpty = isEmpty
	self.id = self.isEmpty and 0 or self.circleHeadFrameData.resData.id
	self.isUsing = CurAvatar.myCircle.headFrameId == self.id

	self.imgState:setVisible(self.isUsing)

	if self.isEmpty then
		self.imgHeadFrame:setImage("Atlas/CommonAtlas/HeadFrameAtlas/HeadFrameAtlas01", "HeadFrame00")
	else
		local iconPath = BaseObject.getItemIconPath(self.circleHeadFrameData.resData.item_id)

		if iconPath then
			self.imgHeadFrame:setImage(iconPath[1], iconPath[2])
		end
	end

	if not self.isEmpty then
		self.imgNew:setVisible(CurAvatar.hintCircleHeadFrameDic[self.id] ~= nil)

		local isLimitShow

		if self.circleHeadFrameData.svrData.endTime and self.circleHeadFrameData.svrData.endTime > 0 then
			isLimitShow = true

			if self.circleHeadFrameData.svrData.endTime > ClientUtils.getServerTime() then
				self.imgHeadFrame:setObjGray(false)
				self.imgLimit:setImage("Atlas/CommonAtlas/GridAtlas/GridAtlas", "TxtLimit01")
			else
				self.imgHeadFrame:setObjGray(true)
				self.imgLimit:setImage("Atlas/CommonAtlas/GridAtlas/GridAtlas", "TxtLimit02")
			end
		else
			self.imgHeadFrame:setObjGray(false)

			isLimitShow = false
		end

		if self.imgNew:getVisible() then
			self.imgLimit:setVisible(false)
		else
			self.imgLimit:setVisible(isLimitShow)
		end
	end

	self:refreshSelect()
end

function CircleHeadFrameItem:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function CircleHeadFrameItem:onSensorClick(sender)
	if (self.circleHeadFrameData or self.isEmpty) and self.selectCallback then
		self.selectCallback(self)
	end
end

return CircleHeadFrameItem
