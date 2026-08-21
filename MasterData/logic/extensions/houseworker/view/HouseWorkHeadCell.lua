-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseWorkHeadCell.lua

module("logic.extensions.houseworker.view.HouseWorkHeadCell", package.seeall)

local M = class("HouseWorkHeadCell")

function M:ctor(comContainer)
	self._go = comContainer.gameObject

	self:_onInit()

	self._ifShowWorkType = true
end

function M:_onInit()
	self._bgGo = goutil.findChild(self._go, "imgDi")
	self._noneGo = goutil.findChild(self._go, "none")
	self._headIconImg = goutil.findChildImageComponent(self._go, "headMask/headIcon")
	self._moodPanelGo = goutil.findChild(self._go, "mood2")
	self._workTypeImg = goutil.findChildImageComponent(self._go, "workType")
	self._moodCell = Astral.LuaComponentContainer.Add(self._moodPanelGo, HouseHeroMoodCell)
	self._addBtn = Astral.ButtonAdapter.Get(goutil.findChild(self._go, "btnAdd"))
end

function M:updatePanel(schedule)
	if schedule and schedule.hero and schedule.hero ~= 0 then
		goutil.setActive(self._noneGo, false)
		goutil.setActive(self._addBtn.gameObject, false)
		goutil.setActive(self._bgGo, true)
		goutil.setActive(self._headIconImg.gameObject.transform.parent.gameObject, true)
		goutil.setActive(self._moodPanelGo, true)
		goutil.setActive(self._workTypeImg.gameObject, self._ifShowWorkType)
		self:refreshHero(schedule.hero)

		local timeInfo = ServerTime.nowDateServerLook()
		local workStatus = schedule.schedule[timeInfo.hour + 1]

		IconLoader.setSprite(self._workTypeImg, IconType.DynSpriteAtlas_Room, HouseEnum.WorkStatus2SignRes[workStatus])
	else
		goutil.setActive(self._noneGo, not self._canAdd)
		goutil.setActive(self._addBtn.gameObject, self._canAdd)
		goutil.setActive(self._bgGo, false)
		goutil.setActive(self._headIconImg.gameObject.transform.parent.gameObject, false)
		goutil.setActive(self._moodPanelGo, false)
		goutil.setActive(self._workTypeImg.gameObject, false)
	end
end

function M:refreshHero(heroId)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)
	local modelCO = heroMO:getModelCo()

	IconLoader.setSprite(self._headIconImg, IconType.HeadIcon, modelCO.headIconName)

	local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(heroId)

	if heroFeatureMo then
		self._moodCell:updateMood(heroFeatureMo:getMood())
	end
end

function M:setWorkTypeShowStatus(status)
	self._ifShowWorkType = status

	goutil.setActive(self._workTypeImg.gameObject, status)
end

function M:setCanAdd(status)
	self._canAdd = status
end

function M:setVisible(visible)
	goutil.setActive(self._go, visible)
end

return M
