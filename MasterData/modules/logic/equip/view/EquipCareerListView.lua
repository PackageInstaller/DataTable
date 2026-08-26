-- chunkname: @modules/logic/equip/view/EquipCareerListView.lua

module("modules.logic.equip.view.EquipCareerListView", package.seeall)

local EquipCareerListView = class("EquipCareerListView", UserDataDispose)

function EquipCareerListView:onInitView(careerDropGo, itemCallback, itemCallbackObj)
	self:__onInit()

	self.careerGoDrop = careerDropGo
	self.careerDropClick = gohelper.findChildClick(self.careerGoDrop, "clickArea")
	self.careerGoTemplateContainer = gohelper.findChild(self.careerGoDrop, "Template")
	self.careerGoItem = gohelper.findChild(self.careerGoDrop, "Template/Viewport/Content/Item")
	self.txtLabel = gohelper.findChildText(self.careerGoDrop, "Label")
	self.iconLabel = gohelper.findChildImage(self.careerGoDrop, "Icon")

	gohelper.setActive(self.careerGoItem, false)
	self.careerDropClick:AddClickListener(self.onCareerDropClick, self)

	self.showingTemplateContainer = false
	self.careerItemList = {}
	self.itemCallback = itemCallback
	self.itemCallbackObj = itemCallbackObj
	self.rectList = {}

	self:initMoData()
	self.addEventCb(self, GameStateMgr.instance, GameStateEvent.OnTouchScreen, self._onTouch, self)
end

function EquipCareerListView:initMoData()
	self.careerValueList = {
		EquipHelper.CareerValue.All,
		EquipHelper.CareerValue.Rock,
		EquipHelper.CareerValue.Star,
		EquipHelper.CareerValue.Wood,
		EquipHelper.CareerValue.Animal,
		EquipHelper.CareerValue.SAW
	}
	self.careerMoList = {}
	self.careerMoDict = {}

	local careerMo = {}

	careerMo.txt = luaLang("common_all")
	careerMo.iconName = nil
	careerMo.career = self.careerValueList[1]
	self.careerMoDict[self.careerValueList[1]] = careerMo

	table.insert(self.careerMoList, careerMo)

	for i = 2, 6 do
		careerMo = {}
		careerMo.txt = nil
		careerMo.iconName = "career_" .. self.careerValueList[i]
		careerMo.career = self.careerValueList[i]
		self.careerMoDict[self.careerValueList[i]] = careerMo

		table.insert(self.careerMoList, careerMo)
	end
end

function EquipCareerListView:onCareerDropClick()
	self.showingTemplateContainer = not self.showingTemplateContainer

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_admission_open)
	gohelper.setActive(self.careerGoTemplateContainer, self.showingTemplateContainer)
	gohelper.setAsLastSibling(self.careerGoTemplateContainer)
end

function EquipCareerListView:onCareerItemClick(careerMo)
	self:setSelectCareer(careerMo.career)
	self:refreshCareerLabel()
	self:refreshCareerSelect()

	self.showingTemplateContainer = false

	gohelper.setActive(self.careerGoTemplateContainer, false)

	if self.itemCallback then
		if self.itemCallbackObj then
			self.itemCallback(self.itemCallbackObj, careerMo)
		else
			self.itemCallback(careerMo)
		end
	end
end

function EquipCareerListView:initTouchRectList()
	table.insert(self.rectList, self:getRectTransformTouchRect(self.careerDropClick.transform))
	table.insert(self.rectList, self:getRectTransformTouchRect(self.careerGoTemplateContainer.transform))
end

function EquipCareerListView:getRectTransformTouchRect(rectTr)
	local worldCorners = rectTr:GetWorldCorners()
	local camera = CameraMgr.instance:getUICamera()
	local LT = camera:WorldToScreenPoint(worldCorners[0])
	local RT = camera:WorldToScreenPoint(worldCorners[1])
	local RB = camera:WorldToScreenPoint(worldCorners[2])
	local LB = camera:WorldToScreenPoint(worldCorners[3])

	return {
		LT,
		RT,
		RB,
		LB
	}
end

function EquipCareerListView:_onTouch()
	if not next(self.rectList) then
		logWarn("touch area not init")

		return
	end

	local touchPos = GamepadController.instance:getMousePosition()

	for _, rect in ipairs(self.rectList) do
		if GameUtil.checkPointInRectangle(touchPos, rect[1], rect[2], rect[3], rect[4]) then
			return
		end
	end

	self.showingTemplateContainer = false

	gohelper.setActive(self.careerGoTemplateContainer, false)
end

function EquipCareerListView:getCareerMoList()
	return self.careerMoList
end

function EquipCareerListView:setSelectCareer(career)
	self.selectCareer = career
end

function EquipCareerListView:getSelectCareer()
	return self.selectCareer or EquipHelper.CareerValue.All
end

function EquipCareerListView:getSelectCareerMo()
	return self.careerMoDict[self:getSelectCareer()]
end

function EquipCareerListView:refreshCareerSelect()
	for _, item in ipairs(self.careerItemList) do
		item:refreshSelect(self:getSelectCareer())
	end
end

function EquipCareerListView:refreshCareerLabel()
	local careerMo = self:getSelectCareerMo()

	if not careerMo then
		logError("not set selected career, please check code!")

		return
	end

	if careerMo.txt then
		self.txtLabel.text = careerMo.txt

		gohelper.setActive(self.txtLabel.gameObject, true)
	else
		gohelper.setActive(self.txtLabel.gameObject, false)
	end

	if careerMo.iconName then
		UISpriteSetMgr.instance:setCommonSprite(self.iconLabel, careerMo.iconName)
		gohelper.setActive(self.iconLabel.gameObject, true)
	else
		gohelper.setActive(self.iconLabel.gameObject, false)
	end
end

function EquipCareerListView:onOpen()
	self:setSelectCareer(EquipHelper.CareerValue.All)

	local careerItem

	for _, careerMo in ipairs(self.careerMoList) do
		careerItem = EquipCareerItem.New()

		careerItem:onInitView(gohelper.cloneInPlace(self.careerGoItem, "career_" .. careerMo.career), self.onCareerItemClick, self)
		careerItem:onUpdateMO(careerMo)
		table.insert(self.careerItemList, careerItem)
	end

	self:initTouchRectList()
	self:refreshCareerSelect()
	self:refreshCareerLabel()
end

function EquipCareerListView:onDestroyView()
	self.careerDropClick:RemoveClickListener()

	for _, item in ipairs(self.careerItemList) do
		item:onDestroyView()
	end

	self.careerItemList = nil
	self.careerMoList = nil
	self.careerMoDict = nil

	self:__onDispose()
end

return EquipCareerListView
