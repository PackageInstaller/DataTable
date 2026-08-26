-- chunkname: @modules/logic/achievement/view/AchievementNamePlateUnlockView.lua

module("modules.logic.achievement.view.AchievementNamePlateUnlockView", package.seeall)

local AchievementNamePlateUnlockView = class("AchievementNamePlateUnlockView", BaseView)

function AchievementNamePlateUnlockView:onInitView()
	self._goIcon = gohelper.findChild(self.viewGO, "go_icon")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	self:_initLevelItems()

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AchievementNamePlateUnlockView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function AchievementNamePlateUnlockView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function AchievementNamePlateUnlockView:_initLevelItems()
	self.levelItemList = {}

	for i = 1, 3 do
		local item = {}

		item.go = gohelper.findChild(self._goIcon, "deep" .. i)
		item.gobg = gohelper.findChild(item.go, "#simage_bg")
		item.simagetitle = gohelper.findChildSingleImage(item.go, "#simage_title")
		item.txtlevel = gohelper.findChildText(item.go, "#txt_deep_" .. i)

		gohelper.setActive(item.go, false)
		table.insert(self.levelItemList, item)
	end
end

function AchievementNamePlateUnlockView:onOpen()
	self._co = self.viewParam
	self._id = self._co.achievementId

	AudioMgr.instance:trigger(AudioEnum3_1.play_ui_mingdi_success_unlock)
	self:refreshUI()
end

function AchievementNamePlateUnlockView:refreshUI()
	local level = self._co.level
	local item = self.levelItemList[level]
	local bgName, titlebgName

	if self._co.image and not string.nilorempty(self._co.image) then
		local temp = string.split(self._co.image, "#")

		bgName = temp[1]
		titlebgName = temp[2]
	end

	local function callback()
		local go = item._bgLoader:getInstGO()
	end

	item._bgLoader = PrefabInstantiate.Create(item.gobg)

	item._bgLoader:startLoad(AchievementUtils.getBgPrefabUrl(bgName), callback, self)
	item.simagetitle:LoadImage(ResUrl.getAchievementLangIcon(titlebgName))

	local listenerType = self._co.listenerType

	if listenerType and listenerType == "TowerPassLayer" then
		if self._co.listenerParam and not string.nilorempty(self._co.listenerParam) then
			local temp = string.split(self._co.listenerParam, "#")
			local num = temp and temp[3]

			num = num * 10
			item.txtlevel.text = num
		end
	elseif self._co then
		item.txtlevel.text = self._co.maxProgress
	end

	gohelper.setActive(item.go, true)
end

function AchievementNamePlateUnlockView:_btnCloseOnClick()
	self:closeThis()
end

return AchievementNamePlateUnlockView
