-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Grid\\Mixin\\GridItemMixin.lua

local EventConst = require("EventConst")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local ResEquipTowerCustomEquipEffect = require("ClientData/ResEquipTowerCustomEquipEffect")
local GridChangeCellChild = require("UI/Common/Grid/GridChangeCellChild")
local GridItemMixin = {}

function GridItemMixin:ctorMixin()
	self:initUI()
	self:clear()

	self.mEnableTips = true
	self.mEnableHoldTips = false
	self.mTipsConfig = nil
	self.mEventClick = nil
	self.mEventHold = nil
	self.mEventHoldPointerUp = nil
	self.mDisableWays = nil
end

function GridItemMixin:initUI()
	self.basePath = ""

	if self.mPath then
		self.basePath = self.mPath .. "/"
	end

	if UIControls.checkControlFunc(self, self.basePath .. "MaskIcon") then
		self.imgMask = UIControls.Image(self, self.basePath .. "MaskIcon")
	end

	if UIControls.checkControlFunc(self, self.basePath .. "MaskIcon/Icon") then
		self.imgIcon = UIControls.Image(self, self.basePath .. "MaskIcon/Icon")
	elseif UIControls.checkControlFunc(self, self.basePath .. "Icon") then
		self.imgIcon = UIControls.Image(self, self.basePath .. "Icon")
	end

	self.imgQuality = UIControls.Image(self, self.basePath .. "ImgQuality")

	if UIControls.checkControlFunc(self, self.basePath .. "TextNum") then
		self.textNum = UIControls.Label(self, self.basePath .. "TextNum")
	end

	self.imgSelect = UIControls.Image(self, self.basePath .. "ImgSelect")
	self.imgNew = UIControls.Image(self, self.basePath .. "IconNew")
	self.imgAdd = UIControls.Image(self, self.basePath .. "ImgAdd")

	if UIControls.checkControlFunc(self, self.basePath .. "IconCoating") then
		self.imgCoating = UIControls.Image(self, self.basePath .. "IconCoating")
	end

	self.btnSensor = UIControls.Button(self, self.basePath .. "")

	self.btnSensor:addEventClick(self.onGridClick)
	self.btnSensor:addEventHoldClick(self.onGridHold)
	self.btnSensor:addEventHoldPointerUp(self.onGridHoldPointerUp)

	self.inBag = false

	if UIControls.checkControlFunc(self, self.basePath .. "BgHero/IconHero") then
		self.imgIconHero = UIControls.Image(self, self.basePath .. "BgHero/IconHero")
		self.imgBgHero = UIControls.Image(self, self.basePath .. "BgHero")
	end

	if UIControls.checkControlFunc(self, self.basePath .. "IconChange") then
		self.panelIconChange = UIControls.Panel(self, self.basePath .. "IconChange")
	end

	if UIControls.checkControlFunc(self, self.basePath .. "TextGemLv") then
		self.textGemLv = UIControls.Label(self, self.basePath .. "TextGemLv")
	end

	if UIControls.checkControlFunc(self, self.basePath .. "IconSeason") then
		self.iconSeason = UIControls.Panel(self, self.basePath .. "IconSeason")
	end

	if UIControls.checkControlFunc(self, self.basePath .. "IconHeroWax") then
		self.iconHeroStick = UIControls.Panel(self, self.basePath .. "IconHeroWax")
	end
end

function GridItemMixin:setObj(object)
	self.object = object

	if object == nil then
		self:clear()

		return
	end

	self:_setObj(object)
end

function GridItemMixin:_setObj(object)
	self:RefreshConvertObject()

	local iconPath = object:getIconPath()

	if object.itemType == Const.ITEM_TYPE_PET then
		iconPath = object:getHeadIconPath()
	end

	if iconPath then
		self.imgIcon:setImage(iconPath[1], iconPath[2])
		self.imgIcon:setVisible(true)
	end

	if object.subType == Const.ITEM_STYPE_CIRCLE_HEAD then
		self.imgIcon:setSize(148, 148)
	elseif object.itemType == Const.ITEM_TYPE_ITEM then
		self.imgIcon:setSize(128, 128)
	end

	local qualityPath = object:getQualityPath()

	if qualityPath then
		self.imgQuality:setImage(qualityPath[1], qualityPath[2])
	end

	if self.textNum then
		if object.num and object.num ~= 1 and object.num ~= 0 then
			self.textNum:setText(object:getNumStr(self.inBag == true and RearHouseCommon.isHouseItem(object.id)))
		else
			self.textNum:setText("")
		end
	end

	self.imgNew:setVisible(self.inBag == true and object.resData and object.resData.is_hint and object.resData.is_hint == 1)

	if self.iconSeason then
		self.iconSeason:setVisible(object.subType == Const.ITEM_STYPE_UPGRADE_SKIN)
	end

	if self.iconHeroStick then
		self.iconHeroStick:setVisible(object.subType == Const.ITEM_STYPE_STICK)
	end

	if object.subType == Const.ITEM_STYPE_UPGRADE_SKIN then
		self.imgNew:setVisible(CurAvatar:checkUseItemByHasSkin(self.object))
	end

	if self.imgCoating then
		self.imgCoating:setVisible(object.subType == Const.ITEM_STYPE_HERO_PAINT_MATERIAL)
	end

	if self.imgBgHero then
		self.imgBgHero:setVisible(false)
	end

	if Const.EQUIP_BUILD_OPEN and self.imgIconHero and object.resData.extend_args1 and ResEquipTowerCustomEquipEffect[object.resData.extend_args1] then
		local heroId = ResEquipTowerCustomEquipEffect[object.resData.extend_args1][1].hero_id
		local fakeHero = BaseObject.GetObject(heroId)
		local iconPath = fakeHero:getQIconPath()

		self.imgIconHero:setImage(iconPath[1], iconPath[2])
		self.imgBgHero:setVisible(true)
	end

	if self.textGemLv then
		if object.itemType == Const.ITEM_TYPE_PET_GEM then
			self.textGemLv:setVisible(true)

			if Const.REVIEW_VERSION then
				self.textGemLv:setText(string.format(Lang.get(111361), object.level))
			else
				self.textGemLv:setText(string.format("Lv.%d", object.level))
			end
		else
			self.textGemLv:setVisible(false)
		end
	end
end

function GridItemMixin:SetConvertObject(checkNeedConvertObject)
	self.checkNeedConvertObject = checkNeedConvertObject

	self:RefreshConvertObject()
end

function GridItemMixin:RefreshConvertObject()
	if self.panelIconChange then
		if self.checkNeedConvertObject and BaseObject.checkConvertObject(self.object) then
			if not self.gridChangeCellChild then
				self.gridChangeCellChild = GridChangeCellChild(self, "", "System/Common/GridChangeCell")
			end

			self.gridChangeCellChild:setObj(self.object)
			self.gridChangeCellChild:setVisible(true)
			self.panelIconChange:setVisible(true)
		else
			if self.gridChangeCellChild then
				self.gridChangeCellChild:setVisible(false)
			end

			self.panelIconChange:setVisible(false)
		end
	end
end

function GridItemMixin:hideBgHeroAndShowStar(isHide)
	if self.imgBgHero then
		self.imgBgHero:setVisible(not isHide)
	end

	if self.panelStar then
		self.panelStar:setVisible(isHide)
	end
end

function GridItemMixin:clear()
	self.object = nil

	self.imgIcon:setVisible(false)
end

function GridItemMixin:setClickEnable(isEnable)
	self.btnSensor:setEnable(isEnable)
end

function GridItemMixin:isEmpty()
	return self.object == nil
end

function GridItemMixin:onGridClick(sender)
	if self.mEventClick then
		self.mEventClick(self)
	end

	if self:isEmpty() then
		return
	end

	self:openTipsPanel()

	if self._onGridClick ~= nil then
		self:_onGridClick()
	end
end

function GridItemMixin:onGridHold(sender)
	if self.mEventHold then
		self.mEventHold(self)
	end

	if self:isEmpty() then
		return
	end

	self:openTipsPanel(true)
end

function GridItemMixin:onGridHoldPointerUp(sender)
	if self.mEventHoldPointerUp then
		self.mEventHoldPointerUp(self)
	end

	if self:isEmpty() then
		return
	end

	if self.mEnableHoldTips then
		self:closeTipsPanel()
	end
end

function GridItemMixin:openTipsPanel(fromHold)
	if not fromHold then
		if self.mEnableTips then
			if self.object.itemType == Const.ITEM_TYPE_PET_GEM then
				UIManager.getUI("petGemRandomTips", true):setObj(self.object)
			elseif self.object.subType == Const.ITEM_STYPE_PREVIEW_PKG then
				UIManager.getUI("previewPkgTips"):show(self, self.mTipsConfig)
			else
				UIManager.getUI("itemTips"):show(self, self.mTipsConfig, self.uiConfig, self.checkNeedConvertObject)
			end
		end
	elseif self.mEnableHoldTips then
		if self.object.itemType == Const.ITEM_TYPE_PET_GEM then
			UIManager.getUI("petGemRandomTips", true):setObj(self.object)
		elseif self.object.subType == Const.ITEM_STYPE_PREVIEW_PKG then
			UIManager.getUI("previewPkgTips"):show(self, self.mTipsConfig)
		else
			UIManager.getUI("itemTips"):show(self, self.mTipsConfig, self.uiConfig, self.checkNeedConvertObject)
		end
	end
end

function GridItemMixin:closeTipsPanel()
	if self.object.subType == Const.ITEM_STYPE_PREVIEW_PKG then
		UIManager.tryHideUI("previewPkgTips")
	else
		UIManager.tryHideUI("itemTips")
	end
end

function GridItemMixin:setIconGray(isGray)
	if self.imgIcon and self.imgIcon:getVisible() then
		self.imgIcon:setImageGray(isGray)
	end

	if self.imgQuality and self.imgQuality:getVisible() then
		self.imgQuality:setImageGray(isGray)
	end

	if self.imgStar and self.imgStar:getVisible() then
		self.imgStar:setImageGray(isGray)
	end

	if self.imgCoating and self.imgCoating:getVisible() then
		self.imgCoating:setImageGray(isGray)
	end
end

function GridItemMixin:setTextNumColor(color)
	if self._setTextNumColor then
		self:_setTextNumColor(color)
	end

	if self.textNum then
		self.textNum:setColorByRGBA(color.r / 255, color.g / 255, color.b / 255, color.a / 255)
	end
end

function GridItemMixin:setTextNumCtrlEnable()
	if self._setTextNumCtrlEnable then
		self:_setTextNumCtrlEnable()
	end

	if self.textNum then
		local ctrl = self.textNum:getGameObject().transform:GetComponent("UICustomColor")

		if ctrl then
			UnityEngine.Object.Destroy(ctrl)
		end
	end
end

function GridItemMixin:hideTextNum(isHide)
	if self._hideTextNum then
		self:_hideTextNum(isHide)
	end

	if self.textNum then
		self.textNum:setVisible(not isHide)
	end
end

function GridItemMixin:flyToCommonFuncEntryPanel()
	if self.object and self.imgIcon then
		FlyIconUtils.sendFlyEvent(self.imgIcon, self.object.id, self.object.num)
	end
end

function GridItemMixin:showNewHint(v)
	self.imgNew:setVisible(v)
end

function GridItemMixin:onConfigHideBg()
	if not self.bg then
		self.bg = UIControls.Panel(self, self.basePath .. "Bg")
	end

	self.bg:setVisible(false)
end

function GridItemMixin:onConfigHideQuality()
	self.imgQuality:setVisible(false)
end

function GridItemMixin:showBgHero(heroId)
	if self.imgBgHero then
		self.imgBgHero:setVisible(true)

		local fakeHero = BaseObject.GetObject(heroId)
		local iconPath = fakeHero:getQIconPath()

		self.imgIconHero:setImage(iconPath[1], iconPath[2])
	end
end

return GridItemMixin
