-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/course/widgets/CourseHeroCollectWidgets.lua

module("logic.extensions.playerinfo.view.course.widgets.CourseHeroCollectWidgets", package.seeall)

local M = class("CourseHeroCollectWidgets", PlayerCourseWidgets)

function M:ctor(view)
	self._view = view
	self._editType = GameEnum.DisplayTypeEnum.Hero
end

function M:buildUI()
	local view = self._view

	self._campRateTxt = view:getText("player_course_panel_1791553155")
	self._campRateImg = view:getImage("player_course_panel_1869572953")
	self._campNumTxt = view:getText("player_course_panel_1178665566")

	local heroRoot = view:getGo("player_course_panel_697200986")

	self._heroNumMax = heroRoot.transform.childCount
	self._heroItems = {}

	for i = 1, self._heroNumMax do
		local go = goutil.findChild(heroRoot, string.format("player_course_hero_item%s", i))
		local item = Astral.LuaComponentContainer.Add(go, CourseHeroItem)

		item:AddClickListener(self.onClickHero, self)
		item:AddEditClickListener(self.onClickHeroEdit, self)
		item:setIndex(i)

		self._heroItems[i] = item
	end

	self._campNormalGos = {
		view:getGo("player_course_panel_15108885"),
		view:getGo("player_course_panel_228256025"),
		view:getGo("player_course_panel_690163676"),
		view:getGo("player_course_panel_183207011"),
		view:getGo("player_course_panel_314292324"),
		view:getGo("player_course_panel_1703071113"),
		view:getGo("player_course_panel_1302495427")
	}
	self._campLockGos = {
		view:getGo("player_course_panel_232571506"),
		view:getGo("player_course_panel_518093342"),
		view:getGo("player_course_panel_933778227"),
		view:getGo("player_course_panel_1497004596"),
		view:getGo("player_course_panel_1456700021"),
		view:getGo("player_course_panel_1778369392"),
		view:getGo("player_course_panel_853629183")
	}

	local go = view:getGo("player_course_panel_1558732512")

	self._campGos = {}

	for i = 1, 7 do
		local campGo = goutil.findChild(go, "normal/camp/camp_item" .. i)

		table.insert(self._campGos, campGo)
	end

	return M.super.buildEditUI(self, go)
end

function M:bindEvents()
	GlobalDispatcher:addEventListener(EventType.COURSE_SHOW_REFRESH_VIEW, self.onShowContentChanged, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.COURSE_SHOW_REFRESH_VIEW, self.onShowContentChanged, self)
end

function M:onInit()
	M.super.init(self)

	if not self._locked then
		self:setCampUI()
		self:setHeroUI()
	end
end

function M:setCampUI()
	local data = self._data
	local camps = data:getUnlockCamps()
	local normalGos = self._campNormalGos
	local lockGos = self._campLockGos
	local completeCamp = Astral.LocalStorage.Instance:GetString("COMPLETE_CAMP")

	completeCamp = string.split(completeCamp, ",")

	local recordId = Astral.LocalStorage.Instance:GetString("RECORD_COURSE_ID")
	local isSelf = string.nilorempty(recordId) and true or recordId == PlayerModel.instance:getId()
	local newCompleteCamp = ""
	local tweenAni = DG.Tweening.DOTween.Sequence()

	tweenAni:AppendInterval(0.67)

	for i = 1, #normalGos do
		local isUnlock = camps[i] or false

		goutil.setActive(normalGos[i], isUnlock)
		goutil.setActive(lockGos[i], not isUnlock)

		if isSelf and isUnlock and not TableUtil.contains(completeCamp, tostring(i)) then
			tweenAni:AppendCallback(function()
				local ani = goutil.addComponentOnce(self._campGos[i], ComponentType.Animation)

				ani:Play("player_course_panel_camp_open")
			end)
		end
	end

	for index, _ in pairs(camps) do
		newCompleteCamp = newCompleteCamp .. index .. ","
	end

	Astral.LocalStorage.Instance:SetString("COMPLETE_CAMP", newCompleteCamp)
	Astral.LocalStorage.Instance:SetString("RECORD_COURSE_ID", PlayerModel.instance:getId())

	local num = data:getHeroCollectNum()
	local numMax = CharacterConfig.instance:getAllOnCharacterNum()
	local rate = num / numMax

	self._campNumTxt.text = num .. "/" .. numMax
	self._campRateTxt.text = string.format("%.0f%%", rate * 100)
	self._campRateImg.fillAmount = rate
end

function M:setHeroUI()
	local items = self._heroItems
	local heroInfo = self._data:getDisplayHero()

	self._heroShowCount = #heroInfo

	for i = 1, self._heroShowCount do
		items[i]:setHero(heroInfo[i])
	end

	for i = self._heroShowCount + 1, self._heroNumMax do
		items[i]:showHero(false)
	end
end

function M:onClickHero(heroId, index)
	local heroDetail = self._data:getHeroDetail(heroId)

	if heroDetail then
		CharacterUtil.openCharacterLookoverView(heroDetail, index, self._data:getDisplayHero())
	else
		self._showIndex = index

		GlobalDispatcher:addEventListener(EventType.COURSE_HERO_DETAIL_VIEW, self.showHeroDetail, self)
		PlayerCourseAgent.instance:sendGetHeroDetailInfoRequest(self._userId, heroId)
	end
end

function M:onClickHeroEdit()
	ViewMgr.instance:open(ViewName.PlayerCourseHeroEditView)
end

function M:setIsInEdit(isInEdit)
	M.super.setIsInEdit(self, isInEdit)

	for i = 1, self._heroNumMax do
		self._heroItems[i]:showEdit(isInEdit)
	end
end

function M:showHeroDetail(_, heroInfo)
	GlobalDispatcher:removeEventListener(EventType.COURSE_HERO_DETAIL_VIEW, self.showHeroDetail, self)

	local character = self._data:createHeroDetail(heroInfo)

	CharacterUtil.openCharacterLookoverView(character, self._showIndex, self._data:getDisplayHero())

	self._showIndex = 1
end

function M:onShowContentChanged(_, type)
	if type == self._editType then
		self:setHeroUI()
	end
end

function M:destroyUI()
	M.super.destroyUI(self)

	self._campNormalGos = nil
	self._campLockGos = nil
	self._heroItems = nil
	self._campNumTxt = nil
	self._campRateImg = nil
	self._campRateTxt = nil
end

return M
