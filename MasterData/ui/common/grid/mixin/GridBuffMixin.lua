-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridBuffMixin.lua

local GridBuffMixin = {}

function GridBuffMixin:ctorMixin()
	self.mEnableTips = true

	self:initUI()
end

local LayoutElementType = typeof(UnityEngine.UI.LayoutElement)
local MAX_COND_NUM = 3

function GridBuffMixin:initUI()
	self.imgBg = UIControls.Image(self, "Bg")
	self.imgBuff = UIControls.Image(self, "Icon")
	self.textDesc = UIControls.Label(self, "BgTxtDec/TextBuffEffect")
	self.textName = UIControls.Label(self, "TexttBuffName")
	self.textBtnExtend = UIControls.Button(self, "BgTxtDec/BtnExtend")

	self.textBtnExtend:addEventClick(self.onExtend)

	self.textBtnReduce = UIControls.Button(self, "BgTxtDec/BtnReduce")

	self.textBtnReduce:addEventClick(self.onReduce)

	self.panelEfx = UIControls.Panel(self, "Bg/EfxFigure")
	self.panelHead = UIControls.Panel(self, "BgTxtDec/BgFigure")
	self.imgHead = UIControls.Image(self, "BgTxtDec/BgFigure/MaskHead/IconHead")
	self.bgDesc = UIControls.Image(self, "BgTxtDec")
	self.comDescLayout = self.bgDesc:getComObj():GetComponent(LayoutElementType)
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onClickSensor)

	self.panelCondition = UIControls.Panel(self, "BgCondition")
	self.imgCondition = {}

	for index = 1, MAX_COND_NUM do
		local newImage = UIControls.Image(self, "BgCondition/Condition" .. index)

		table.insert(self.imgCondition, newImage)
	end
end

function GridBuffMixin:setBuff(buffData)
	self.buffId = buffData.id
	self.buffData = buffData

	self.textName:setText(self.buffData.name or "")
	self.textDesc:setText(self.buffData.desc or "")

	if self.textDesc:getHeight() > 60 then
		self.textBtnExtend:setVisible(true)
		self.textBtnReduce:setVisible(false)
	else
		self.textBtnExtend:setVisible(false)
		self.textBtnReduce:setVisible(false)
	end

	if self.buffData.icon then
		self.imgBuff:setImage(self.buffData.icon_path, self.buffData.icon)
	else
		self.imgBuff:setImage("Atlas/CommonAtlas/IconAtlas/MazeBuffAtlas/01", "1001")
	end

	self:setSelected(false)

	if buffData.career_icon_path and buffData.career_icon then
		self.panelCondition:setVisible(true)

		local names = utils.splitString(buffData.career_icon, ",")

		if names then
			for index, cell in ipairs(self.imgCondition) do
				if names[index] then
					cell:setVisible(true)
					cell:setImage(buffData.career_icon_path, names[index])
				else
					cell:setVisible(false)
				end
			end
		end
	end

	self:refreshBg()
end

function GridBuffMixin:refreshBg()
	if self.buffData.model_flag then
		self.panelEfx:setVisible(true)
		self.panelHead:setVisible(true)

		local modelPath = UIConst.getModelHeadIconPath(self.buffData.model_flag)

		if modelPath then
			self.imgHead:setImage(modelPath[1], modelPath[2])
		end
	else
		self.panelEfx:setVisible(false)
		self.panelHead:setVisible(false)
	end

	self:_setBG()
end

function GridBuffMixin:_setBG()
	if self.buffData.model_flag then
		self.imgBg:setImage("Atlas/SeasonTowerAtlas/SeasonTowerBuffAtlas01", "BgBuffBack3")
		self.bgDesc:setImage("Atlas/SeasonTowerAtlas/SeasonTowerBuffAtlas01", "BgWordsBack2")
	else
		self.imgBg:setImage("Atlas/SeasonTowerAtlas/SeasonTowerBuffAtlas01", "BgBuffBack2")
		self.bgDesc:setImage("Atlas/SeasonTowerAtlas/SeasonTowerBuffAtlas01", "BgWordsBack1")
	end
end

function GridBuffMixin:onExtend()
	self.textBtnExtend:setVisible(false)
	self.textBtnReduce:setVisible(true)

	self.comDescLayout.enabled = false
end

function GridBuffMixin:onReduce()
	self.textBtnExtend:setVisible(true)
	self.textBtnReduce:setVisible(false)

	self.comDescLayout.enabled = true
end

function GridBuffMixin:setSelected(isSelected)
	if isSelected then
		self.btnSensor:setEnable(false)
	else
		self.btnSensor:setEnable(true)
	end
end

function GridBuffMixin:onClickSensor(sender)
	if self.mEventClick then
		self.mEventClick(self)
	end

	self:openTipsPanel()
end

function GridBuffMixin:openTipsPanel()
	return
end

return GridBuffMixin
