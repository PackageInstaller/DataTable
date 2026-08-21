-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\ContentPanel\\SkinCell.lua

local ResCommonModel = require("ClientData/ResCommonModel")
local SkinCell = Class("SkinCell", UIControls.Child)

function SkinCell:ctor()
	self.btn = UIControls.Button(self, "")
	self.btnJump = UIControls.Button(self, "BtnInfo", "Txt")
	self.txtState = UIControls.Label(self, "TxtDes")
	self.imgUnSel = UIControls.Image(self, "ImgUnsel")
	self.iconNew = UIControls.Image(self, "IconNew")

	self.btnJump:setVisible(false)
	self.imgUnSel:setVisible(true)
	self.txtState:setVisible(false)
	self.btn:addEventClick(Slot(self.onBtnClick, self))
	self.btnJump:addEventClick(Slot(self.onJumpClick, self))

	self.item = UIControls.SkinCardChild(self, "GridSkinPanel", "System/Common/Grid/GridSkinCard")
	self.item.mEnableTips = false

	self.item:setVisible(true)
end

function SkinCell:setData(data, hasGet, onWear)
	self.data = data
	self.hasGet = hasGet
	self.onWear = onWear

	self.item:setSkin(data)

	self.NewSkin = false

	local unlockNewSkin = CurAvatar.unlockNewSkin

	if unlockNewSkin[self.data.hero_id] and self.data.id == unlockNewSkin[self.data.hero_id] then
		self.NewSkin = true
	end

	self.iconNew:setVisible(self.NewSkin)
	self:setGet(hasGet)
	self:setWear(onWear)
end

function SkinCell:setBtnHide(isHide)
	self.btnJump:setVisible(false)
	self.txtState:setVisible(false)
	self.imgUnSel:setVisible(false)
end

function SkinCell:setGet(isGet)
	if isGet == true then
		self.btnJump:setText(Lang.get(545))
		self.txtState:setVisible(true)

		if self.onWear == false then
			self.txtState:setText(Lang.get(891))
		end
	else
		self.btnJump:setText(Lang.get(1242))
		self.txtState:setText("")
		self.txtState:setVisible(false)
	end
end

function SkinCell:setWear(onWear)
	if onWear == true then
		self.txtState:setText(Lang.get(1103))
		self.btnJump:setVisible(false)
	end
end

function SkinCell:setSelected(isSelected)
	self.isSelected = isSelected

	self.imgUnSel:setVisible(not isSelected)
	self.btnJump:setVisible(isSelected)
	self.btn:setEnable(not isSelected)

	if isSelected == true then
		if self.onWear == true then
			self.btnJump:setVisible(false)
		else
			self.txtState:setVisible(false)
		end
	else
		self.txtState:setVisible(true)
	end
end

function SkinCell:onJumpClick()
	if self.mEventClick then
		self:mEventClick(self)
	end
end

function SkinCell:onBtnClick()
	if self.mEventCellClick then
		if self.NewSkin then
			self.NewSkin = false

			self.iconNew:setVisible(false)
			CurAvatar:checkSkinNew()
		end

		self:mEventCellClick(self)
	end
end

return SkinCell
