-- chunkname: @modules/logic/room/view/critter/RoomCritterTrainDetailItemAttributeItem.lua

module("modules.logic.room.view.critter.RoomCritterTrainDetailItemAttributeItem", package.seeall)

local RoomCritterTrainDetailItemAttributeItem = class("RoomCritterTrainDetailItemAttributeItem")

function RoomCritterTrainDetailItemAttributeItem:init(go)
	self.go = gohelper.cloneInPlace(go)

	gohelper.setActive(self.go, true)

	self._imageicon = gohelper.findChildImage(self.go, "#image_icon")
	self._goiconup = gohelper.findChild(self.go, "#txt_name/iconup")
	self._txtname = gohelper.findChildText(self.go, "#txt_name")
	self._goratelevel = gohelper.findChild(self.go, "go_ratelevel")
	self._txtratelevel = gohelper.findChildText(self.go, "go_ratelevel/#txt_level")
	self._imagelvprogress = gohelper.findChildImage(self.go, "go_ratelevel/ProgressBg/#simage_levelBarValue")
	self._imagelvbar = gohelper.findChildImage(self.go, "go_ratelevel/ProgressBg/#bar_add")
	self._godetail = gohelper.findChild(self.go, "go_detail")
	self._txtnum = gohelper.findChildText(self.go, "go_detail/#txt_num")
	self._imagedetailprogress = gohelper.findChildImage(self.go, "go_detail/ProgressBg/#simage_totalBarValue")
	self._imagedetailbar = gohelper.findChildImage(self.go, "go_detail/ProgressBg/#bar_add")
	self._imagelvbar.fillAmount = 0
	self._imagedetailbar.fillAmount = 0

	self:_addEvents()
end

function RoomCritterTrainDetailItemAttributeItem:_addEvents()
	return
end

function RoomCritterTrainDetailItemAttributeItem:_removeEvents()
	return
end

function RoomCritterTrainDetailItemAttributeItem:hideItem()
	gohelper.setActive(self.go, true)
end

function RoomCritterTrainDetailItemAttributeItem:getAttributeId()
	return self._attributeMO.attributeId
end

function RoomCritterTrainDetailItemAttributeItem:setShowLv(show)
	self._showLv = show
end

function RoomCritterTrainDetailItemAttributeItem:refresh(attributeMO, critterMO)
	self._attributeMO = attributeMO
	self._critterMO = critterMO

	local attValue = 0

	if self._attributeMO.attributeId == CritterEnum.AttributeType.Efficiency then
		attValue = self._critterMO.efficiency
	elseif self._attributeMO.attributeId == CritterEnum.AttributeType.Patience then
		attValue = self._critterMO.patience
	elseif self._attributeMO.attributeId == CritterEnum.AttributeType.Lucky then
		attValue = self._critterMO.lucky
	end

	self._attributeBaseValue = attValue + self._critterMO.trainInfo:getAddAttributeValue(self._attributeMO.attributeId)
	self._trainHeroMO = critterMO and RoomTrainHeroListModel.instance:getById(critterMO.trainInfo.heroId)
	self._heroAddIncrRate = 0

	if self._trainHeroMO and self._trainHeroMO:chcekPrefernectCritterId(self._critterMO:getDefineId()) then
		local cfg = self._trainHeroMO.critterHeroConfig

		if cfg and attributeMO and attributeMO.attributeId == cfg.effectAttribute then
			self._heroAddIncrRate = cfg.addIncrRate
		end
	end

	gohelper.setActive(self.go, true)
	self:refreshUI()
end

local colorList = {
	"#5D8FB3",
	"#6A4B8E",
	"#BAA64D",
	"#BA7841",
	"#E57A3A"
}

function RoomCritterTrainDetailItemAttributeItem:refreshUI()
	gohelper.setActive(self._godetail, not self._showLv)
	gohelper.setActive(self._goratelevel, self._showLv)

	if not self._attributeMO then
		return
	end

	local perHour = self._critterMO:getAddValuePerHourByType(self._attributeMO.attributeId)
	local showAttrValue = math.min(self._attributeBaseValue, CritterConfig.instance:getCritterAttributeMax())

	self._txtnum.text = (self._attributeMO:getIsAddition() or self._heroAddIncrRate > 0) and string.format("%d<color=#65B96F>(+%.02f/h)</color>", math.floor(showAttrValue), perHour) or string.format("%d(+%.02f/h)", math.floor(showAttrValue), perHour)

	local levelCo = CritterConfig.instance:getCritterAttributeLevelCfgByValue(self._attributeBaseValue)
	local nextLevelCo = CritterConfig.instance:getCritterAttributeLevelCfg(levelCo.level + 1)

	if nextLevelCo then
		if not ((self._attributeBaseValue - levelCo.minValue) / (nextLevelCo.minValue - levelCo.minValue)) then
			local startRate = 1

			self._imagedetailprogress.fillAmount = startRate

			SLFramework.UGUI.GuiHelper.SetColor(self._imagedetailprogress, colorList[levelCo.level])
			SLFramework.UGUI.GuiHelper.SetColor(self._imagedetailbar, colorList[levelCo.level])

			self._txtratelevel.text = levelCo.name
			self._imagelvprogress.fillAmount = startRate

			SLFramework.UGUI.GuiHelper.SetColor(self._imagelvprogress, colorList[levelCo.level])
			SLFramework.UGUI.GuiHelper.SetColor(self._imagelvbar, colorList[levelCo.level])
			SLFramework.UGUI.GuiHelper.SetColor(self._txtratelevel, colorList[levelCo.level])

			if self._txtname then
				self._txtname.text = self._attributeMO:getName()
			end

			local var_8_1

			if self._imageicon and not string.nilorempty(self._attributeMO:getIcon()) then
				UISpriteSetMgr.instance:setCritterSprite(self._imageicon, self._attributeMO:getIcon())

				var_8_1 = self._attributeMO:getIsAddition() or self._heroAddIncrRate > 0
			end

			gohelper.setActive(self._goiconup, var_8_1)
		end
	end
end

function RoomCritterTrainDetailItemAttributeItem:playNoLevelUp()
	self._addAttr = false

	local levelCo = CritterConfig.instance:getCritterAttributeLevelCfgByValue(self._attributeBaseValue)
	local nextLevelCo = CritterConfig.instance:getCritterAttributeLevelCfg(levelCo.level + 1)

	if nextLevelCo then
		self._startValue = (self._attributeBaseValue - levelCo.minValue) / (nextLevelCo.minValue - levelCo.minValue) or 1
	end

	self._endValue = self._startValue
	self._txtnum.text = math.min(self._attributeBaseValue, CritterConfig.instance:getCritterAttributeMax())

	TaskDispatcher.runDelay(self._detailFinished, self, 1.5)
end

function RoomCritterTrainDetailItemAttributeItem:playBarAdd(play, attributeMO)
	gohelper.setActive(self._imagelvbar.gameObject, play)
	gohelper.setActive(self._imagedetailbar.gameObject, play)

	if play then
		self._addAttributeMO = attributeMO

		local count = RoomTrainCritterModel.instance:getSelectOptionCount(attributeMO.attributeId)
		local totalValue = self._attributeBaseValue + count * self._addAttributeMO.value
		local levelCo = CritterConfig.instance:getCritterAttributeLevelCfgByValue(self._attributeBaseValue)
		local nextLevelCo = CritterConfig.instance:getCritterAttributeLevelCfg(levelCo.level + 1)

		if nextLevelCo then
			if not ((totalValue - levelCo.minValue) / (nextLevelCo.minValue - levelCo.minValue)) then
				local endValue = 1

				self._imagelvbar.fillAmount = endValue
				self._imagedetailbar.fillAmount = endValue
			end
		end
	else
		self._imagelvbar.fillAmount = 0
		self._imagedetailbar.fillAmount = 0
	end
end

function RoomCritterTrainDetailItemAttributeItem:playLevelUp(attributeMO, isNotAddAttValue)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("attributelevelup")
	TaskDispatcher.cancelTask(self._detailFinished, self)

	self._addAttributeMO = attributeMO
	self._addAttr = true
	self._tweenEndAttrValue = self._attributeBaseValue + self._addAttributeMO.value
	self._tweenStartAttrValue = self._attributeBaseValue

	if isNotAddAttValue == true then
		self._tweenEndAttrValue = self._attributeBaseValue
		self._tweenStartAttrValue = self._attributeBaseValue - self._addAttributeMO.value
		self._addAttributeMO = nil
	end

	local levelCo = CritterConfig.instance:getCritterAttributeLevelCfgByValue(self._tweenStartAttrValue)
	local nextLevelCo = CritterConfig.instance:getCritterAttributeLevelCfg(levelCo.level + 1)

	if nextLevelCo then
		self._endValue = (self._tweenEndAttrValue - levelCo.minValue) / (nextLevelCo.minValue - levelCo.minValue) or 1
	end

	if nextLevelCo then
		self._startValue = (self._tweenStartAttrValue - levelCo.minValue) / (nextLevelCo.minValue - levelCo.minValue) or 1
	end

	self:_clearTween()

	self._fillDetailTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, self._detailFillUpdate, self._detailFinished, self, nil, EaseType.Linear)
end

function RoomCritterTrainDetailItemAttributeItem:_detailFillUpdate(value)
	self._imagedetailprogress.fillAmount = self._startValue + value * (self._endValue - self._startValue)

	local num = self._tweenStartAttrValue + value * (self._tweenEndAttrValue - self._tweenStartAttrValue)
	local showAttrValue = math.min(num, CritterConfig.instance:getCritterAttributeMax())

	self._txtnum.text = string.format("%.02f", showAttrValue)
end

function RoomCritterTrainDetailItemAttributeItem:_detailFinished()
	gohelper.setActive(self._godetail, false)
	gohelper.setActive(self._goratelevel, true)

	if self._addAttributeMO then
		if not self._addAttributeMO.value then
			local addValue = 0

			self._txtnum.text = math.min(self._attributeMO.value + addValue, CritterConfig.instance:getCritterAttributeMax())

			self:_clearTween()

			self._fillLvTweenId = ZProj.TweenHelper.DOTweenFloat(self._startValue, self._endValue, 1.5, self._lvFillUpdate, self._lvFinished, self, nil, EaseType.Linear)
		end
	end
end

function RoomCritterTrainDetailItemAttributeItem:_lvFillUpdate(value)
	self._imagelvprogress.fillAmount = value
end

function RoomCritterTrainDetailItemAttributeItem:_lvFinished()
	UIBlockMgr.instance:endBlock("attributelevelup")

	if self._addAttr then
		RoomController.instance:dispatchEvent(RoomEvent.CritterTrainLevelFinished)
	end
end

function RoomCritterTrainDetailItemAttributeItem:_clearTween()
	if self._fillDetailTweenId then
		ZProj.TweenHelper.KillById(self._fillDetailTweenId)

		self._fillDetailTweenId = nil
	end

	if self._fillLvTweenId then
		ZProj.TweenHelper.KillById(self._fillLvTweenId)

		self._fillLvTweenId = nil
	end
end

function RoomCritterTrainDetailItemAttributeItem:destroy()
	TaskDispatcher.cancelTask(self._detailFinished, self)
	self:_removeEvents()
	self:_clearTween()
end

return RoomCritterTrainDetailItemAttributeItem
