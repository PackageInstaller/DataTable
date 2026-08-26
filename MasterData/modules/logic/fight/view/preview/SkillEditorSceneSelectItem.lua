-- chunkname: @modules/logic/fight/view/preview/SkillEditorSceneSelectItem.lua

module("modules.logic.fight.view.preview.SkillEditorSceneSelectItem", package.seeall)

local SkillEditorSceneSelectItem = class("SkillEditorSceneSelectItem", ListScrollCell)

function SkillEditorSceneSelectItem:init(go)
	self._text = gohelper.findChildText(go, "Text")
	self._text1 = gohelper.findChildText(go, "imgSelect/Text")
	self._click = SLFramework.UGUI.UIClickListener.Get(go)
	self._selectGO = gohelper.findChild(go, "imgSelect")
end

function SkillEditorSceneSelectItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
end

function SkillEditorSceneSelectItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function SkillEditorSceneSelectItem:onUpdateMO(mo)
	self._mo = mo

	local co = mo.co
	local sceneCO = lua_scene.configDict[co.sceneId]

	self._text.text = ((sceneCO or nil) and (sceneCO.name .. "\n" or "")) .. co.id
	self._text1.text = ((sceneCO or nil) and (sceneCO.name .. "\n" or "")) .. co.id
end

function SkillEditorSceneSelectItem:onSelect(isSelect)
	gohelper.setActive(self._selectGO, isSelect)
end

function SkillEditorSceneSelectItem:_onClickThis()
	local oldId = FightGameMgr.sceneLevelMgr:getCurLevelId()
	local newId = self._mo.co.id

	if oldId ~= newId then
		local index = SkillEditorSceneSelectModel.instance:getIndex(self._mo)

		SkillEditorSceneSelectModel.instance:selectCell(index, true)
		FightGameMgr.sceneLevelMgr:loadScene(nil, newId)
		SkillEditorMgr.instance:setSceneLevelId(newId)
		self:_setCameraOffset(newId)
		FightController.instance:dispatchEvent(FightEvent.OnSkillEditorSceneChange)
	end
end

function SkillEditorSceneSelectItem:_setCameraOffset(levelId)
	local virsualCamerasGO = CameraMgr.instance:getVirtualCameraGO()
	local levelConfig = lua_scene_level.configDict[levelId]
	local cameraOffsetParam = levelConfig and levelConfig.cameraOffset
	local pos

	virsualCamerasGO.transform.localPosition = string.nilorempty(cameraOffsetParam) and Vector3.zero or Vector3.New(unpack(cjson.decode(cameraOffsetParam)))
end

return SkillEditorSceneSelectItem
