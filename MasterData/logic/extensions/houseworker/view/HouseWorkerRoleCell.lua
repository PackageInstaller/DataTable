-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseWorkerRoleCell.lua

module("logic.extensions.houseworker.view.HouseWorkerRoleCell", package.seeall)

local M = class("HouseWorkerRoleCell", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._ifShowWorkType = true
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	self._selectBtn = ButtonAdapter.Get(goutil.findChild(self._go, "click"))

	self._selectBtn:AddClickListener(self._onClickSelect, self)

	self._emptyGo = goutil.findChild(self._go, "btnAdd")
	self._heroPanelGo = goutil.findChild(self._go, "Content")
	self._heroIcon = goutil.findChildImageComponent(self._go, "Content/roleMask/imgRole")

	local attr1Img = goutil.findChildImageComponent(self._go, "Content/imgIcon1")
	local attr2Img = goutil.findChildImageComponent(self._go, "Content/imgIcon2")

	self._attrGroup = {}

	table.insert(self._attrGroup, attr1Img)
	table.insert(self._attrGroup, attr2Img)

	self._nameTxt = goutil.findChildTextComponent(self._go, "Content/txtName")
	self._moodIconGo = goutil.findChild(self._go, "Content/mood")
	self._warningGo = goutil.findChild(self._go, "Content/warning")
	self._buffPanelGo = goutil.findChild(self._go, "Content/buffList")
	self._workTypeImg = goutil.findChildImageComponent(self._go, "Content/workType/imgTtpe")

	goutil.setActive(self._workTypeImg.gameObject, false)

	self._workTypeTxt = goutil.findChildTextComponent(self._go, "Content/workType/txtType")
	self._imgSelectGo = goutil.findChild(self._go, "Content/imgSelect")
	self._selectIndexGo = goutil.findChild(self._go, "Content/count")
	self._selectIndexTxt = goutil.findChildTextComponent(self._go, "Content/count/txtCount")
	self._moodCell = Astral.LuaComponentContainer.Add(self._moodIconGo, HouseHeroMoodCell)

	goutil.setActive(self._buffPanelGo, false)
	goutil.setActive(self._imgSelectGo, false)
	goutil.setActive(self._selectIndexGo, false)

	for index, value in ipairs(self._attrGroup) do
		goutil.setActive(value.gameObject, false)
	end
end

function M:setJobCodeAndIndex(jobCode, index)
	self._jobCode = jobCode
	self._index = index

	local jobData = HouseWorkerModel.instance:getScheduleByJobAndIndex(self._jobCode, self._index)

	self._jobData = jobData
	self._hero = jobData and jobData.hero
end

function M:setHero(hero)
	self._hero = hero
end

function M:setClickCallBack(clickCallBackFunc, clickCallBackHandle)
	self._clickCallBackFunc = clickCallBackFunc
	self._clickCallBackHandle = clickCallBackHandle
end

function M:setWorkTypeShowStatus(status)
	self._ifShowWorkType = status

	self:_refreshWorkTypeVisible()
end

function M:_refreshWorkTypeVisible()
	goutil.setActive(self._workTypeTxt.gameObject, self._ifShowWorkType)
end

function M:refreshCell()
	if not self._hero or self._hero == 0 then
		goutil.setActive(self._emptyGo, true)
		goutil.setActive(self._heroPanelGo, false)
	else
		goutil.setActive(self._emptyGo, false)
		goutil.setActive(self._heroPanelGo, true)

		local heroMO = HeroDepotModel.instance:getHeroInfoByID(self._hero)
		local characterCO = heroMO:getCharacterCo()
		local modelCO = heroMO:getModelCo()

		self._nameTxt.text = heroMO:getName()

		local heroFeatureMo = HeroHouseFeatureModel.instance:getFeatureMO(self._hero)

		if heroFeatureMo then
			self._moodCell:updateMood(heroFeatureMo:getMood())
		end

		local workStatus = HouseSceneUtil.getWorkStatusByHeroId(self._hero)

		self._workTypeTxt.text = HouseEnum.WorkStatus2Text[workStatus]

		IconLoader.setSprite(self._heroIcon, IconType.RoleCard, modelCO.halfIconName)
		self:_refreshWorkTypeVisible()

		local skillList = HeroHouseFeatureModel.instance:getFeatureSkillByHeroId(self._hero)

		for i, v in ipairs(self._attrGroup) do
			local show = i <= #skillList

			if show then
				local skill = skillList[i]

				if skill and skill.isUnlock then
					local itemImg = self._attrGroup[i]

					goutil.setActive(itemImg.gameObject, true)

					local skillCO = HouseConfig.instance:getConfigByKey(ConfigName.HouseSkill, skill.skillId)

					if skillCO then
						IconLoader.setSprite(itemImg, IconType.DynSpriteAtlas_Room, string.format("room_peculiarity_%s", skillCO.icon))
					else
						printError(string.format("hero[%s],无法从[%s]找到[%s]的配置", self._hero, ConfigName.HouseSkill, skill.skillId))
					end
				else
					show = false
				end
			end

			goutil.setActive(v.gameObject, show)
		end
	end
end

function M:OnDestroy()
	self._selectBtn:RemoveClickListener()
end

function M:_onClickSelect()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandle, self._jobCode, self._index)
	end
end

function M:setAddStatus(status)
	self._isAdd = status
end

return M
