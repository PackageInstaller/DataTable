-- chunkname: @modules/logic/critter/view/CritterMoodItem.lua

module("modules.logic.critter.view.CritterMoodItem", package.seeall)

local CritterMoodItem = class("CritterMoodItem", LuaCompBase)

function CritterMoodItem:init(go)
	self.go = go
	self._gohasMood = gohelper.findChild(self.go, "#go_hasMood")
	self._imagemood = gohelper.findChildImage(self.go, "#go_hasMood/#simage_mood")
	self._imagemoodvalue = gohelper.findChildImage(self.go, "#go_hasMood/#simage_progress")
	self._txtMoodValue = gohelper.findChildText(self.go, "#go_hasMood/#txt_mood")
	self._gonoMood = gohelper.findChild(self.go, "#go_noMood")
	self._txtmoodRestore = gohelper.findChildText(self.go, "#txt_moodRestore")
	self._animator = self.go:GetComponent(typeof(UnityEngine.Animator))

	if self._txtmoodRestore then
		gohelper.setActive(self._txtmoodRestore, false)

		self._txtmoodRestore.text = ""
	end
end

function CritterMoodItem:addEventListeners()
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterFeedFood, self._onFeedFood, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onMoodChange, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterUpdateAttrPreview, self._onAttrPreviewUpdate, self)
end

function CritterMoodItem:removeEventListeners()
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterFeedFood, self._onFeedFood, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterInfoPushUpdate, self._onMoodChange, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterUpdateAttrPreview, self._onAttrPreviewUpdate, self)
end

function CritterMoodItem:_onFeedFood(critterUidDict, isFavorite)
	if not self.critterUid or critterUidDict and not critterUidDict[self.critterUid] then
		return
	end

	if self._animator then
		self._animator:Play(isFavorite and "love" or "like", 0, 0)
	end

	self:refreshMood()
end

function CritterMoodItem:_onMoodChange(critterUidDict)
	if not self.critterUid or critterUidDict and not critterUidDict[self.critterUid] then
		return
	end

	self:refreshMood()
end

function CritterMoodItem:_onAttrPreviewUpdate(critterUidDict)
	self:_onMoodChange(critterUidDict)
end

function CritterMoodItem:setCritterUid(critterUid)
	self.critterUid = critterUid

	self:refreshMood()
end

function CritterMoodItem:setShowMoodRestore(isShow)
	self._isNOShowRestore = isShow == false

	gohelper.setActive(self._txtmoodRestore, isShow ~= false)
end

function CritterMoodItem:refreshMood()
	if not self.critterUid then
		logError("CritterMoodItem:refreshMood error,critterUid is nil")

		return
	end

	local mood = 0
	local critterMO = CritterModel.instance:getCritterMOByUid(self.critterUid)

	if critterMO then
		mood = critterMO:getMoodValue()
	end

	local hasMood = mood ~= 0

	gohelper.setActive(self._gohasMood, hasMood)
	gohelper.setActive(self._gonoMood, not hasMood)

	if hasMood then
		local cfgMaxMood = ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)
		local maxMood = tonumber(cfgMaxMood) or 0
		local lowMood = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.LowMood) or 0

		lowMood = tonumber(lowMood)

		local isLowMood = mood <= lowMood

		UISpriteSetMgr.instance:setCritterSprite(self._imagemood, (isLowMood or nil) and "critter_manufacture_heart2")
		SLFramework.UGUI.GuiHelper.SetColor(self._imagemoodvalue, isLowMood and "#B76D79" or "#FDB467")

		self._txtMoodValue.text = mood

		if mood and maxMood and maxMood ~= 0 then
			self._imagemoodvalue.fillAmount = Mathf.Clamp(mood / maxMood, 0, 1)
		end
	end

	if self._isNOShowRestore ~= true and self._txtmoodRestore then
		local value = CritterHelper.getPreViewAttrValue(CritterEnum.AttributeType.MoodRestore, self.critterUid)

		self._txtmoodRestore.text = "+" .. CritterHelper.formatAttrValue(CritterEnum.AttributeType.MoodRestore, value)

		gohelper.setActive(self._txtmoodRestore, value > 0)

		local buildingMoodValue = CritterHelper.getPatienceChangeValue(RoomBuildingEnum.BuildingType.Rest)

		SLFramework.UGUI.GuiHelper.SetColor(self._txtmoodRestore, buildingMoodValue < value and "#D9A06F" or "#D4C399")
	end
end

function CritterMoodItem:onDestroy()
	return
end

return CritterMoodItem
