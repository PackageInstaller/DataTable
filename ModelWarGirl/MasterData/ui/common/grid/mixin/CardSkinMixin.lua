-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\CardSkinMixin.lua

local GridItemMixin = require("UI/Common/Grid/Mixin/GridItemMixin")
local ResCommonModel = require("ClientData/ResCommonModel")
local CardSkinMixin = {}

function CardSkinMixin:ctorMixin()
	self:initUI()

	self.mEnableTips = true
	self.mTipsConfig = nil
	self.mEventClick = nil
	self.isShowPreviewTips = false
end

function CardSkinMixin:initUI()
	self.btn = UIControls.Button(self, "")

	self.btn:addEventClick(self.onBtnSelect)

	self.imgHero = UIControls.Image(self, "ImgHero")
	self.imgMark = UIControls.Image(self, "ImgMark")
	self.txtName = UIControls.Label(self, "TxtName")
end

function CardSkinMixin:setObj(object)
	self.object = object

	if object == nil then
		self:clear()

		return
	end

	self:_setObj(object)
end

function CardSkinMixin:_setObj(object)
	local iconPath = object:getIconPath()

	if iconPath then
		self.imgHero:setImage(iconPath[1], iconPath[2])
	end

	self.txtName:setText(object.name)
end

function CardSkinMixin:openTipsPanel()
	if self.mEnableTips then
		-- block empty
	end
end

function CardSkinMixin:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function CardSkinMixin:clearSelectCallback(...)
	self.selectCallback = nil
end

function CardSkinMixin:onBtnSelect(sender)
	if self.mEnableTips == true and self.selectCallback then
		self.selectCallback(self)
	end
end

function CardSkinMixin:setSelected(isSelected)
	self.beSelected = isSelected

	if self.showSelect then
		-- block empty
	end
end

function CardSkinMixin:setSkin(skinData)
	self.txtName:setText(skinData.name)

	if skinData.model_id and ResCommonModel[skinData.model_id] then
		local modelInfo = ResCommonModel[skinData.model_id]

		if modelInfo.skin_icon_path then
			self.imgHero:setImage("Atlas/" .. modelInfo.skin_icon_path, modelInfo.skin_icon_name)
		end
	end

	if skinData.quality then
		local skin = BaseObject.GetObject(skinData.item_id)

		if skin then
			local data = skin:getQualityIconPath()

			if data then
				self.imgMark:setImage(data[1], data[2])
			end
		end
	else
		self.imgMark:setVisible(false)
	end
end

return CardSkinMixin
