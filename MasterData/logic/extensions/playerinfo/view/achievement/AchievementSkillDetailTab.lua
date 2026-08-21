-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/achievement/AchievementSkillDetailTab.lua

module("logic.extensions.playerinfo.view.achievement.AchievementSkillDetailTab", package.seeall)

local M = class("AchievementSkillDetailTab")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._imgIcon = goutil.findChildImageComponent(self._mainGo, "mask/icon")
	self._txtName = goutil.findChildTextComponent(self._mainGo, "txtName")
	self._txtLevel = goutil.findChildTextComponent(self._mainGo, "txtLv")
	self._txtNum = goutil.findChildTextComponent(self._mainGo, "txtProgress")
	self._selectGo = goutil.findChild(self._mainGo, "select")
	self._redPoint = goutil.findChild(self._mainGo, "red_point")
	self._btnClick = Astral.ButtonAdapter.Get(self._mainGo)

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClickTab, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:_onClickTab()
	GlobalDispatcher:dispatchEvent(EventType.CHANGE_ACHIEVEMENT_TAB, self._data)
end

function M:updateData(labMo, isSelect)
	self._data = labMo

	local skillMo = self._data:getSkillMo()

	IconLoader.setSprite(self._imgIcon, IconType.AchievementSkill, self._data:getIcon())

	self._txtName.text = self._data:getName()
	self._txtLevel.text = string.format("LV.%s", skillMo:getLevel())

	goutil.setActive(self._selectGo, isSelect)

	local redKey = string.format("%d_%d", GameEnum.RedPointEnum.Achievement, self._data:getId())

	RedDotModel.instance:createDotView({
		dotNode = self._redPoint,
		keyList = {
			redKey
		}
	})
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

return M
