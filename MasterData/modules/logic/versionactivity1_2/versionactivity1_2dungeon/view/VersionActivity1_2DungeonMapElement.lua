-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/VersionActivity1_2DungeonMapElement.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonMapElement", package.seeall)

local VersionActivity1_2DungeonMapElement = class("VersionActivity1_2DungeonMapElement", DungeonMapElement)

function VersionActivity1_2DungeonMapElement:ctor(param)
	self._config = param[1]
	self._mapScene = param[2]
	self._sceneElements = param[3]
end

function VersionActivity1_2DungeonMapElement:getElementId()
	return self._config.id
end

function VersionActivity1_2DungeonMapElement:init(go)
	self._wenhaoGo = self:getUserDataTb_()
	self._finishGo = self:getUserDataTb_()
	self._go = go
	self._transform = go.transform

	local pos = string.splitToNumber(self._config.pos, "#")

	transformhelper.setLocalPos(self._transform, pos[1] or 0, pos[2] or 0, pos[3] or 0)

	if self._resLoader then
		return
	end

	self._resLoader = MultiAbLoader.New()

	self._resLoader:addPath(self._config.res)

	self._effectPath = {}

	if not string.nilorempty(self._config.effect) then
		table.insert(self._effectPath, self._config.effect)
		self._resLoader:addPath(self._config.effect)
	end

	if self._config.type == DungeonEnum.ElementType.Activity1_2Building_Trap then
		local url = "scenes/m_s08_hddt/prefab/lhem_icon_qh.prefab"

		table.insert(self._effectPath, url)
		self._resLoader:addPath(url)
	elseif self._config.type == DungeonEnum.ElementType.Activity1_2Building_Upgrade then
		local url = "scenes/m_s08_hddt/prefab/lhem_icon_ck.prefab"

		table.insert(self._effectPath, url)
		self._resLoader:addPath(url)
	end

	self._resLoader:startLoad(self._onResLoaded, self)
end

function VersionActivity1_2DungeonMapElement:hide()
	gohelper.setActive(self._go, false)
end

function VersionActivity1_2DungeonMapElement:show()
	gohelper.setActive(self._go, true)
end

function VersionActivity1_2DungeonMapElement:hasEffect()
	return self._effectPath
end

function VersionActivity1_2DungeonMapElement:showArrow()
	if self._config.type == DungeonEnum.ElementType.DailyEpisode then
		return self._go.activeInHierarchy
	end

	return self._config.showArrow == 1
end

function VersionActivity1_2DungeonMapElement:isValid()
	return not gohelper.isNil(self._go)
end

function VersionActivity1_2DungeonMapElement:setWenHaoVisible(value)
	if value then
		self:setWenHaoAnim("wenhao_a_001_in")
	else
		local outName = "wenhao_a_001_out"

		if (self._config.type == DungeonEnum.ElementType.Activity1_2Fight or VersionActivity1_2DungeonConfig.instance:getBuildingConfigsByElementID(self._config.id)) and self._sceneElements.curSelectId == self._config.id then
			outName = "click"
			self._sceneElements.curSelectId = nil
		end

		self:setWenHaoAnim(outName)
	end
end

function VersionActivity1_2DungeonMapElement:setWenHaoAnim(name)
	self._wenhaoAnimName = name

	if #self._wenhaoGo > 0 then
		for i, v in ipairs(self._wenhaoGo) do
			if not gohelper.isNil(v) and v.activeInHierarchy then
				SLFramework.AnimatorPlayer.Get(v):Play(name, self._wenHaoAnimDone, self)
			end
		end
	end
end

function VersionActivity1_2DungeonMapElement:_wenHaoAnimDone()
	if self._wenhaoAnimName == "finish" then
		gohelper.destroy(self._go)
		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFinishAndDisposeElement, self._config)
	end
end

function VersionActivity1_2DungeonMapElement:_destroyGo()
	gohelper.destroy(self._go)
end

function VersionActivity1_2DungeonMapElement:_destroyItemGo()
	gohelper.destroy(self._itemGo)
end

function VersionActivity1_2DungeonMapElement:setFinish()
	if #self._wenhaoGo == 0 then
		self:_destroyGo()

		return
	end

	self:removeEventListeners()
	self:setWenHaoAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(self._destroyItemGo, self, 0.77)
	TaskDispatcher.runDelay(self._destroyGo, self, 1.6)
end

function VersionActivity1_2DungeonMapElement:setFinishAndDotDestroy()
	if #self._wenhaoGo == 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)

	if #self._finishGo > 0 then
		for i, v in ipairs(self._finishGo) do
			gohelper.setActive(v, true)

			if v.activeInHierarchy then
				SLFramework.AnimatorPlayer.Get(v):Play(UIAnimationName.Open, self.setFinishAndDotDestroyAnimationDone, self)
			end
		end
	else
		self:dispose()
	end
end

function VersionActivity1_2DungeonMapElement:setFinishAndDotDestroyAnimationDone()
	self.animatorPlayer:Play(UIAnimationName.Idle, function()
		return
	end, self)
	self:dispose()
end

function VersionActivity1_2DungeonMapElement:onDown()
	self:_onDown()
end

function VersionActivity1_2DungeonMapElement:_onDown()
	self._sceneElements:setElementDown(self)
end

function VersionActivity1_2DungeonMapElement:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_building_click)
	self._sceneElements:clickElement(self._config.id)
end

function VersionActivity1_2DungeonMapElement:_onResLoaded()
	local assetItem = self._resLoader:getAssetItem(self._config.res)
	local mainPrefab = assetItem:GetResource(self._config.res)

	self._itemGo = gohelper.clone(mainPrefab, self._go)

	local resScale = self._config.resScale

	if resScale and resScale ~= 0 then
		transformhelper.setLocalScale(self._itemGo.transform, resScale, resScale, 1)
	end

	gohelper.setLayer(self._itemGo, UnityLayer.Scene, true)
	DungeonMapElement.addBoxColliderListener(self._itemGo, self._onDown, self)
	transformhelper.setLocalPos(self._itemGo.transform, 0, 0, -1)

	if #self._effectPath > 0 then
		for i, v in ipairs(self._effectPath) do
			local parentRoot = UnityEngine.GameObject.New("effect" .. i)

			gohelper.addChild(self._go, parentRoot)

			local offsetPos = string.splitToNumber(self._config.tipOffsetPos, "#")

			self._offsetX = offsetPos[1] or 0
			self._offsetY = offsetPos[2] or 0

			local effectPath = self._effectPath[i]
			local assetItem = self._resLoader:getAssetItem(effectPath)
			local mainPrefab = assetItem:GetResource(effectPath)
			local tarObj = gohelper.clone(mainPrefab, parentRoot, "root")

			DungeonMapElement.addBoxColliderListener(tarObj, self._onDown, self)
			transformhelper.setLocalPos(tarObj.transform, self._offsetX, self._offsetY, -3)

			local loopAni = gohelper.findChildComponent(tarObj, "ani", typeof(UnityEngine.Animator))

			if loopAni then
				local random = math.random(0, 100)

				loopAni:Play("lhem_icon_loop", 0, random / 100)
			end

			local finishGo = gohelper.findChild(tarObj, "ani/yuanjian_new_07/gou")

			gohelper.setActive(finishGo, false)

			if finishGo then
				table.insert(self._finishGo, finishGo)
			end

			if self._mapScene:showInteractiveItem() then
				self:setWenHaoVisible(false)
			elseif self._wenhaoAnimName then
				self:setWenHaoAnim(self._wenhaoAnimName)
			end

			if string.find(effectPath, "hddt_front_lubiao_a_002") then
				local plane = gohelper.findChild(tarObj, "ani/plane")
				local renderer = plane:GetComponent(typeof(UnityEngine.Renderer))
				local mat = renderer.material
				local vec4 = mat:GetVector("_Frame")

				vec4.w = DungeonEnum.ElementTypeIconIndex[string.format("%s0", self._config.type)]

				mat:SetVector("_Frame", vec4)
			end

			table.insert(self._wenhaoGo, tarObj)

			for index = 1, 2 do
				local txtObj = gohelper.findChild(tarObj, string.format("ani/icon%d/anim/biaoti/txt", index))

				if txtObj then
					local txt = txtObj:GetComponent(typeof(TMPro.TextMeshPro))

					txt.text = self._config.title

					if self._config.type == DungeonEnum.ElementType.DailyEpisode then
						local episodeConfig = VersionActivity1_2DungeonModel.instance:getDailyEpisodeConfigByElementId(self._config.id)

						if episodeConfig then
							txt.text = episodeConfig.name
						end
					end
				end
			end
		end
	end

	VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.addElementItem, self._config.id)

	local fightParam = FightModel.instance:getFightParam()
	local lastFightEpisodeId = fightParam and fightParam.episodeId

	if lastFightEpisodeId then
		local episodeConfig = DungeonConfig.instance:getEpisodeCO(lastFightEpisodeId)

		if episodeConfig and episodeConfig.chapterId == 12701 then
			return
		end

		if self._config.param == tostring(lastFightEpisodeId) then
			DungeonMapModel.instance.lastElementBattleId = nil

			if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipClickElement) then
				return
			end

			DungeonMapModel.instance.directFocusElement = true

			self:onClick()

			DungeonMapModel.instance.directFocusElement = false
		end
	end
end

function VersionActivity1_2DungeonMapElement:_onSetEpisodeListVisible(value)
	self:setWenHaoVisible(value)
end

function VersionActivity1_2DungeonMapElement:_afterCollectLastShow()
	return
end

function VersionActivity1_2DungeonMapElement:addEventListeners()
	DungeonController.instance:registerCallback(DungeonEvent.OnSetEpisodeListVisible, self._onSetEpisodeListVisible, self)
	self.addEventCb(self, VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.afterCollectLastShow, self._afterCollectLastShow, self)
end

function VersionActivity1_2DungeonMapElement:removeEventListeners()
	DungeonController.instance:unregisterCallback(DungeonEvent.OnSetEpisodeListVisible, self._onSetEpisodeListVisible, self)
end

function VersionActivity1_2DungeonMapElement:onStart()
	return
end

function VersionActivity1_2DungeonMapElement.addBoxCollider2D(go)
	local clickListener = ZProj.BoxColliderClickListener.Get(go)
	local box = gohelper.onceAddComponent(go, typeof(UnityEngine.BoxCollider2D))

	box.enabled = true
	box.size = Vector2(1.5, 1.5)

	clickListener:SetIgnoreUI(true)

	return clickListener
end

function VersionActivity1_2DungeonMapElement.addBoxColliderListener(go, callback, callbackTarget)
	local clickListener = DungeonMapElement.addBoxCollider2D(go)

	clickListener:AddClickListener(callback, callbackTarget)
end

function VersionActivity1_2DungeonMapElement:dispose()
	self._itemGo = nil
	self._go = nil
	self.animatorPlayer = nil

	if self._resLoader then
		self._resLoader:dispose()

		self._resLoader = nil
	end

	TaskDispatcher.cancelTask(self._destroyItemGo, self)
	TaskDispatcher.cancelTask(self._destroyGo, self)
end

function VersionActivity1_2DungeonMapElement:onDestroy()
	if self._itemGo then
		gohelper.destroy(self._itemGo)

		self._itemGo = nil
	end

	if self._wenhaoGo then
		for i, v in ipairs(self._wenhaoGo) do
			gohelper.destroy(v)
		end
	end

	if self._go then
		gohelper.destroy(self._go)

		self._go = nil
	end

	if self._resLoader then
		self._resLoader:dispose()

		self._resLoader = nil
	end

	if self.animatorPlayer then
		self.animatorPlayer = nil
	end

	TaskDispatcher.cancelTask(self._destroyItemGo, self)
	TaskDispatcher.cancelTask(self._destroyGo, self)
end

return VersionActivity1_2DungeonMapElement
