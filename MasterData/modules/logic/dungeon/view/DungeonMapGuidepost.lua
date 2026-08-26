-- chunkname: @modules/logic/dungeon/view/DungeonMapGuidepost.lua

module("modules.logic.dungeon.view.DungeonMapGuidepost", package.seeall)

local DungeonMapGuidepost = class("DungeonMapGuidepost", LuaCompBase)

function DungeonMapGuidepost:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapGuidepost:addEvents()
	return
end

function DungeonMapGuidepost:removeEvents()
	return
end

function DungeonMapGuidepost:ctor(scene)
	self._scene = scene
end

function DungeonMapGuidepost:setConfig(config, episodeId)
	self._config = config
	self._episodeId = episodeId

	if not string.nilorempty(self._config.pos) then
		local pos = string.splitToNumber(self._config.pos, "#")

		transformhelper.setLocalPos(self.viewGO.transform, pos[1], pos[2], -5)
	end

	local listStr = DungeonConfig.instance:getElementList(episodeId)
	local list = string.splitToNumber(listStr, "#")

	for i = 1, 3 do
		local id = list[i]
		local go = self._goList[i]

		gohelper.setActive(go, id)

		if id then
			local renderer = go:GetComponent(typeof(UnityEngine.Renderer))
			local anim = gohelper.findChild(go, "click")
			local mat = renderer.material
			local isFinish = DungeonMapModel.instance:elementIsFinished(id)

			if isFinish then
				mat:SetColor("_MainCol", GameUtil.parseColor("#c66030ff"))
			else
				mat:SetColor("_MainCol", GameUtil.parseColor("#ffffff99"))
			end

			gohelper.setActive(anim, isFinish)

			local elementConfig = lua_chapter_map_element.configDict[id]
			local vec4 = mat:GetVector("_Frame")

			vec4.w = DungeonEnum.ElementTypeIconIndex[string.format("%s", elementConfig.type .. (isFinish and 1 or 0))]

			mat:SetVector("_Frame", vec4)
		end
	end
end

function DungeonMapGuidepost.allElementsFinished(episodeId)
	local listStr = DungeonConfig.instance:getElementList(episodeId)
	local list = string.splitToNumber(listStr, "#")

	for i, id in ipairs(list) do
		local isFinish = DungeonMapModel.instance:elementIsFinished(id)

		if not isFinish then
			return false
		end
	end

	return true
end

function DungeonMapGuidepost:_editableInitView()
	self._goList = self:getUserDataTb_()

	self:_initElementGo(gohelper.findChild(self.viewGO, "ani/plane_a"))
	self:_initElementGo(gohelper.findChild(self.viewGO, "ani/plane_b"))
	self:_initElementGo(gohelper.findChild(self.viewGO, "ani/plane_c"))
end

function DungeonMapGuidepost:_initElementGo(go)
	table.insert(self._goList, go)
	DungeonMapElement.addBoxColliderListener(go, self._onDown, self)
end

function DungeonMapGuidepost:_onDown()
	if self._scene:showInteractiveItem() then
		return
	end

	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.Guidepost) then
		return
	end

	DungeonController.instance:openDungeonMapTaskView({
		isMain = true,
		viewParam = self._episodeId
	})
end

function DungeonMapGuidepost:init(go)
	self.viewGO = go

	self:onInitView()
	self:addEvents()
	self:_editableAddEvents()
end

function DungeonMapGuidepost:_editableAddEvents()
	return
end

function DungeonMapGuidepost:_editableRemoveEvents()
	return
end

function DungeonMapGuidepost:onDestroy()
	self:removeEvents()
	self:_editableRemoveEvents()
end

return DungeonMapGuidepost
