-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/MaterialDepthDungeonCellComp.lua

module("logic.extensions.dungeon.view.materialdungeon.MaterialDepthDungeonCellComp", package.seeall)

local M = class("MaterialDepthDungeonCellComp", CellBaseComponent)
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._trs = self._go.transform
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self:onInit()
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._imgIndex = registry:findUIElement("resources_level_item_-1745835192", UIComponentType.Image)
	self._imgBanner = registry:findUIElement("resources_level_item_-561220034", UIComponentType.Image)
	self._imgCareerSign = registry:findUIElement("career_1390243743", UIComponentType.Image)
	self._dungeonIndexTxt = registry:findUIElement("resources_level_item_733009178", UIComponentType.Text)
	self._dungeonNameTxt = registry:findUIElement("resources_level_item_192021243", UIComponentType.Text)
	self._rectTrStarRoot = registry:findUIElement("resources_level_item_-1117686782", UIComponentType.RectTransform)
	self._lockGo = registry:findUIElement("resources_level_item_-591557711")
	self._lockTxt = registry:findUIElement("resources_level_item_2082078943", UIComponentType.Text)
	self._btnSelect = registry:findUIElement("resources_level_item_208578668", UIComponentType.ButtonAdapter)

	self._btnSelect:AddClickListener(self._clickSelect, self)

	self._normalPanelGo = registry:findUIElement("resources_level_item_-380535162")
	self._selectGo = registry:findUIElement("resources_level_item_410369376")
	self._imgMask = registry:findUIElement("resources_level_item_-325214839", UIComponentType.Image)
end

function M:_clickSelect()
	if self._clickCallBackFunc then
		self._clickCallBackFunc(self._clickCallBackHandler, self._curIndex)
	end
end

function M:_formatLevel(level)
	local a = math.floor(level / 10)
	local b = level % 10

	return string.format("%s-%s", a, b)
end

function M:setMaskImgColor(color)
	self._imgMask.color = parsecolor(color)
end

function M:setMaskImgAlpha()
	return
end

function M:updateData(data, index, chapterMo)
	self._curIndex = index
	self._dungeonMo = data
	self._career = chapterMo:getCareer()

	self:_refreshView()
end

function M:updateSelect()
	goutil.setActive(self._selectGo, self._curSelectIndex == self._curIndex)
end

function M:setClickCallBack(func, handler)
	self._clickCallBackFunc = func
	self._clickCallBackHandler = handler
end

function M:setSelectIndex(selectIndex)
	self._curSelectIndex = selectIndex
end

function M:_refreshView()
	IconLoader.setSprite(self._imgBanner, IconType.DynSpriteAtlas_ResourcesExplore, self._dungeonMo:getBannerRes())
	IconLoader.setSprite(self._imgIndex, IconType.DynSpriteAtlas_Fight, string.format("resource_explore_num%s", self._curIndex))

	if self._career > 0 then
		IconLoader.setSprite(self._imgCareerSign, IconType.Skinlib, CommEnum.Career2Icon[self._career])
	end

	goutil.setActive(self._imgCareerSign.gameObject, self._career > 0)

	self._dungeonIndexTxt.text = self._dungeonMo:getDifficultyStr()

	goutil.setActive(self._dungeonIndexTxt.gameObject, false)

	self._dungeonNameTxt.text = self._dungeonMo:getName()

	local starCount = self._dungeonMo:getStarCount()

	for i = 0, self._rectTrStarRoot.childCount - 1 do
		local show = starCount >= i + 1
		local tmp = self._rectTrStarRoot:GetChild(i).gameObject

		goutil.setActive(tmp, show)
	end

	goutil.setActive(self._fullStarGo, self._dungeonMo:getStarCount() == 3)
	goutil.setActive(self._lockGo, not self._dungeonMo:getIsUnlock())
	goutil.setActive(self._selectGo, self._curSelectIndex == self._curIndex)

	local preDungeonId = self._dungeonMo:getPreDungeonId()
	local isPrePassed = true

	if preDungeonId then
		local preDungeonMo = DungeonMaterialChapterModel.instance:getDungeonMoById(preDungeonId)

		isPrePassed = preDungeonMo:hasPassed()
	end

	if self._dungeonMo:getIsUnlock() then
		isPrePassed = true
	else
		local unLockLevel = self._dungeonMo:getUnlockLevel()
		local lockDesc

		if isPrePassed and unLockLevel > PlayerModel.instance:getLevel() then
			lockDesc = langF("tip_x_level_open", self:_formatLevel(unLockLevel))
			lockDesc = unLockLevel >= 100 and "" or lockDesc
		end

		self._lockTxt.text = lockDesc
	end

	self._isPrePassed = isPrePassed
end

function M:OnDestroy()
	self._btnSelect:RemoveClickListener()
end

return M
