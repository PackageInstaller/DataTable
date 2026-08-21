-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/RedMistBossComp.lua

module("logic.extensions.dungeon.view.equipdungeon.RedMistBossComp", package.seeall)

local M = class("RedMistBossComp", ViewComponent)
local kLightCode = LightName.BattleAdditional
local kFov = 35
local IdleAnims = {
	UnitAnimState.Idle2,
	UnitAnimState.Idle,
	UnitAnimState.Idle1
}

function M:ctor()
	self._heroId = nil
	self._heroCfgInfo = nil
	self._skillItemList = {}
end

function M:buildUI()
	self._textBossName = self:getText("red_mist_chapters_view_-479783373")
	self._transfTagRoot = self:getRectTransform("red_mist_chapters_view_-144555601")
	self._goCareer = self:getGo("1&career_475494592")
	self._textBossLevel = self:getText("red_mist_chapters_view_-295304305")
	self._imgCareerDi = self:getImage("1&career_-1600786498")
	self._imgCareerSign = self:getImage("1&career_1390243743")
	self._textFactionName = self:getText("red_mist_chapters_view_577395212")
	self._canvasGroupHero = self:getUIComponent("red_mist_chapters_view_-1311925216", ComponentType.CanvasGroup)
	self._rawImageHero = self:getUIComponent("red_mist_chapters_view_-1099701998", UIComponentType.RawImage)
	self._goSkillBindGo = self:getGo("red_mist_chapters_view_628210063")
	self._skillLoopList = LoopListHelper.New(self:getGo("red_mist_chapters_view_-601015897"))

	self._skillLoopList:InitListView(0, self._updateBossSkillCell, self)

	self._photoSpace = PhotoSpace.Get(self._rawImageHero.gameObject)

	self._photoSpace:clear()

	self._multiResLoader = MultiResLoader.New()
end

function M:onEnter()
	self:_setEvent(true)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onExit()
	self:_setEvent(false)
	LightMgr.instance:turnOff(kLightCode)
	self:_setProducePosition(false)
	self._photoSpace:clear()

	self._resMap = nil
end

function M:destroyUI()
	if self._photoSpace then
		self._photoSpace:clear()
	end

	self._photoSpace = nil

	self._multiResLoader:clear()
	self._skillLoopList:Dispose()

	self._skillLoopList = nil
	self._skillItemList = nil
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, self._onSkillTipsCloseOrOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SKILL_TIPS_OPEN_OR_CLOSE, self._onSkillTipsCloseOrOpen, self)
	end
end

function M:_refreshView()
	local monsterCO = self._monsterCo

	self._textBossName.text = monsterCO.name
	self._textBossLevel.text = string.format("LV.%s", monsterCO.level)
	self._textFactionName.text = MonsterCOUtil.getFactionName(monsterCO)

	IconLoader.setSprite(self._imgCareerDi, IconType.Skinlib, CommEnum.ColorType2Icon[monsterCO.colorType])
	IconLoader.setSprite(self._imgCareerSign, IconType.Skinlib, CommEnum.Career2Icon[monsterCO.career])
	table.clear(self._skillItemList)

	self._bossSkillList = self:_getBossSkillList()

	self._skillLoopList:SetListItemCount(#self._bossSkillList)
	self._skillLoopList:RefreshAllShownItem()
	self:_refreshBossSign()
end

function M:_refreshBossSign()
	local tags = self._monsterCo.tags or {}
	local root = self._transfTagRoot

	while root.childCount < #tags do
		goutil.cloneAndSetParent(root:GetChild(0).gameObject, root)
	end

	for i = 0, root.childCount - 1 do
		local go = root:GetChild(i).gameObject
		local tag = tags[i + 1]

		if tag then
			local txtName = goutil.findChildTextComponent(go, "txtSign")

			txtName.text = tag
		end

		goutil.setActive(go, tag)
	end
end

function M:_refreshModel(sameBossModel)
	local existModel = self._resMap ~= nil and self:_getResource(self._modelPath) ~= nil or false

	if sameBossModel and existModel then
		return
	end

	self:_showPhoto(false)
	self._multiResLoader:clear()
	self._photoSpace:show(nil, 4, PhotoCacheMgr.SIZE_M2_BLOCK, PhotoCacheMgr.SIZE_M2_BLOCK)
	self._photoSpace:setModelLoadCallback(self._resLoaded, self._modelLoaded, self)
	self._photoSpace:addResList(self._resList)
	self._photoSpace:setCameraTag(SceneTag.RTCamera)
	self._photoSpace:setCameraFov(kFov)
	self._photoSpace:setCameraPostProcessing(true, SceneLayer.Default_Value)
end

function M:_resLoaded(res)
	self._resMap = self._resMap or {}
	self._resMap[res.ResPath] = {
		res = res
	}
end

function M:_modelLoaded()
	local modelResData = self:_getResource(self._modelPath)
	local modelGo = goutil.clone(modelResData.res:GetMainAsset())

	modelResData.go = modelGo

	local pos = self._chapterMo:getBossPos()
	local rot = self._chapterMo:getBossRot()
	local transform = modelGo.transform

	Astral.TransformUtil.SetLocalPos(transform, pos.x, pos.y, pos.z)
	Astral.TransformUtil.SetLocalRotation(transform, rot.x, rot.y, rot.z)
	self._photoSpace:showTarget(modelGo, true)

	self._animName = nil
	self._animationPlayer = AnimationPlayer.Get(modelGo)

	for _, anim in ipairs(IdleAnims) do
		local animPath = self._animationPlayer:GetAnimationPath(anim)

		if not string.nilorempty(animPath) then
			self._animName = anim
			self._idleAnimPath = animPath

			break
		end
	end

	if self._animName == nil then
		printError(string.format("【%s】没有 idle，idle1，idle2 的动画", self._monsterCo.name))

		return
	end

	self._multiResLoader:setResPaths({
		self._idleAnimPath
	})
	self._multiResLoader:load(self._animLoaded, nil, self)
end

function M:_animLoaded()
	if not self._multiResLoader:isAllSuccess() then
		printError(string.format("【%s】的动画【%s】加载失败！", self._monsterCo.name, self._animName))
	end

	local animClip = self._multiResLoader:getResource(self._idleAnimPath):GetMainAsset()

	self._animationPlayer:ReplaceClip(self._animName, animClip)
	self._animationPlayer:Evaluate()
	self._animationPlayer:PlayAnimation(self._animName, true, true)
	self:_showPhoto(true)
end

function M:_showPhoto(active)
	self._canvasGroupHero.alpha = active and 1 or 0
end

function M:_getResource(path)
	return self._resMap[path]
end

function M:_setProducePosition(lightOn)
	local producer = self._photoSpace:getProducer()

	if producer then
		if not lightOn then
			local pos = PhotoUtil.GetPosition(producer.counter)

			GameUtils.setPos(producer.producerContainer, pos.x, pos.y, pos.z)
		else
			GameUtils.setPos(producer.producerContainer, 500, 500, 0)
		end
	end
end

function M:_getBossSkillList()
	local skillIds = {}

	self:_addSkill(skillIds, self._monsterCo.normalSkill)
	self:_addSkill(skillIds, self._monsterCo.specialSkill)
	self:_addSkill(skillIds, self._monsterCo.trumpSkill)
	self:_addSkill(skillIds, self._monsterCo.giftSkill)

	for _, id in ipairs(self._monsterCo.extraSkills or {}) do
		self:_addSkill(skillIds, id)
	end

	return skillIds
end

function M:_addSkill(skillIds, skillId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if skillCOWrapper then
		table.insert(skillIds, skillId)
	end
end

function M:_updateBossSkillCell(index)
	local curIndex = index + 1
	local skillId = self._bossSkillList[curIndex]
	local item = self._skillLoopList:NewListViewItem("skill_item_1")
	local skillIcon = Astral.LuaComponentContainer.Add(item.gameObject, BattleSkillIcon)

	skillIcon:setSkillInfo(self._bossId, skillId, status, nil, entityId)
	skillIcon:setClickListener(self._onClickSkillIcon, self)
	skillIcon:setSelected(false)

	self._skillItemList[skillId] = skillIcon

	return item
end

function M:_onClickSkillIcon(skillInfo, cellGo)
	self._selectedSkillId = skillInfo.skillId
	skillInfo.hangGO = self._goSkillBindGo
	skillInfo.hideEnhanceDetail = false
	skillInfo.hasDispatch = true
	skillInfo.simulateCloseWhenDraging = true
	skillInfo.forceTipsAlignVer = CommEnum.TipsAlignType.Up

	ToolTipsMgr.showBattleSkillTips(skillInfo)
end

function M:_onSkillTipsCloseOrOpen(_, isEnter, viewName)
	for skillId, skillIcon in pairs(self._skillItemList) do
		skillIcon:setSelected(isEnter and skillId == self._selectedSkillId)
	end
end

function M:_refresh(sameBossModel)
	LightMgr.instance:turnOn(kLightCode)
	self:_refreshView()
	self:_refreshModel(sameBossModel)
	self:_setProducePosition(true)
end

function M:setData(bossId, chapterMo, dungeonId)
	self._bossId = bossId
	self._chapterMo = chapterMo
	self._dungeonId = dungeonId
	self._dungeonMo = DungeonEquipExploreChapterModel.instance:getDungeonMoById(self._dungeonId)
	self._monsterCo = MonsterConfig.instance:getMonsterCO(self._bossId, true)
	self._modelCo = ModelConfig.instance:getModelConfig(self._monsterCo.modelId)

	if self._modelCo == nil then
		printError(string.format("模型配置错误!关卡【%s】中Boss【%s】的模型为【%s】", self._dungeonMo:getDungeonBattleCode(), self._bossId, self._monsterCo.modelId))

		return
	end

	local modelPath = ModelCOUtil.getHighModelUrl(self._modelCo)
	local sameBossModel = self._modelPath == modelPath or false

	self._modelPath = modelPath
	self._resList = {
		self._modelPath
	}

	self:_refresh(sameBossModel)
end

return M
