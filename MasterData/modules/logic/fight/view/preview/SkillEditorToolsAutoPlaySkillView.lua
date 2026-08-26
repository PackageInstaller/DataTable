-- chunkname: @modules/logic/fight/view/preview/SkillEditorToolsAutoPlaySkillView.lua

module("modules.logic.fight.view.preview.SkillEditorToolsAutoPlaySkillView", package.seeall)

local SkillEditorToolsAutoPlaySkillView = class("SkillEditorToolsAutoPlaySkillView", BaseViewExtended)

function SkillEditorToolsAutoPlaySkillView:onInitView()
	self._go = gohelper.findChild(self.viewGO, "autoPlaySkill")
	self._goHuazhi = gohelper.findChild(self.viewGO, "autoPlaySkill/huazhi")
	self._inp = gohelper.findChildTextMeshInputField(self.viewGO, "autoPlaySkill/inp")
	self._goHuazhiItem = gohelper.findChild(self.viewGO, "autoPlaySkill/huazhi/item")
	self._btnPlay = gohelper.findChildButtonWithAudio(self.viewGO, "autoPlaySkill/play")
	self._btnSelectAll = gohelper.findChildButtonWithAudio(self.viewGO, "autoPlaySkill/selectAll")
	self._btnCancelAll = gohelper.findChildButtonWithAudio(self.viewGO, "autoPlaySkill/cancel")
	self._btnclean = gohelper.findChildButtonWithAudio(self.viewGO, "autoPlaySkill/clean")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "autoPlaySkill/close")
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "autoPlaySkill/scroll")
	self._gocontent = gohelper.findChild(self.viewGO, "autoPlaySkill/scroll/Content")
	self._goitem = gohelper.findChild(self.viewGO, "autoPlaySkill/scroll/Content/item")
	self._selectScrollView = gohelper.findChildScrollRect(self.viewGO, "autoPlaySkill/selectScroll")
	self._goselectcontent = gohelper.findChild(self.viewGO, "autoPlaySkill/selectScroll/Content")
	self._goselectitem = gohelper.findChild(self.viewGO, "autoPlaySkill/selectScroll/Content/item")
	self._btnlist = {}
	self._actionViewGO = gohelper.findChild(self.viewGO, "autoPlaySkill/selectSkin")
	self._itemGOParent = gohelper.findChild(self.viewGO, "autoPlaySkill/selectSkin/scroll/content")
	self._itemGOPrefab = gohelper.findChild(self.viewGO, "autoPlaySkill/selectSkin/scroll/item")
end

function SkillEditorToolsAutoPlaySkillView:addEvents()
	self._inp:AddOnValueChanged(self._onInpValueChanged, self)
	self._btnSelectAll:AddClickListener(self._onClickSelectAll, self)
	self._btnCancelAll:AddClickListener(self._onClickCancelAll, self)
	self._btnPlay:AddClickListener(self._playTimeline, self)
	self._btnclean:AddClickListener(self._onClickClean, self)
	self._btnClose:AddClickListener(self._closeview, self)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._StopAutoPlayFlow2, self._stopFlow, self)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr._OpenAutoPlaySkin, self._showSelectSkin, self)
	SLFramework.UGUI.UIClickListener.Get(self._actionViewGO):AddClickListener(self._hideSelectSkinView, self)
end

function SkillEditorToolsAutoPlaySkillView:removeEvents()
	self._inp:RemoveOnValueChanged()
	self._btnSelectAll:RemoveClickListener()
	self._btnPlay:RemoveClickListener()
	self._btnclean:RemoveClickListener()
	self._btnCancelAll:RemoveClickListener()
	self._btnClose:RemoveClickListener()

	for index, click in ipairs(self._btnlist) do
		click:RemoveClickListener()
	end

	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._StopAutoPlayFlow2, self._stopFlow, self)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr._OpenAutoPlaySkin, self._showSelectSkin, self)
	SLFramework.UGUI.UIClickListener.Get(self._actionViewGO):RemoveClickListener()
end

function SkillEditorToolsAutoPlaySkillView:_playTimeline()
	self._count = 0

	local list = SkillEditorToolAutoPlaySkillSelectModel.instance:getList()

	self.flow = FlowSequence.New()

	self.flow:addWork(FunctionWork.New(self._closeview, self))

	for index, mo in ipairs(list) do
		self.flow:addWork(FunctionWork.New(self.switchEntity, self, mo))
		self.flow:addWork(FunctionWork.New(function()
			local name

			if mo.type == SkillEditorMgr.SelectType.Group then
				local co = mo.co
				local monsterIds = string.splitToNumber(co.monster, "#")
				local monsterCO = lua_monster.configDict[monsterIds[1]]

				for i = 2, #monsterIds do
					if tabletool.indexOf(string.splitToNumber(co.bossId, "#"), monsterIds[i]) then
						monsterCO = lua_monster.configDict[monsterIds[i]]

						break
					end
				end

				name = monsterCO and monsterCO.name
			else
				name = mo.co.name
			end

			local str = mo.co.id .. "\n" .. string.format("当前角色\n%s\n剩余角色%s/%s", name, #list - index, #list)

			SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill, {
				rolestr = str
			})
		end, self))
		self.flow:addWork(SkillEditorPlayTimelineWork.New())
		self.flow:addWork(FunctionWork.New(function()
			self._count = self._count + 1
		end, self))
	end

	self.flow:addWork(FunctionWork.New(self._checkSkillDone, self, #list))
	self.flow:start()
end

function SkillEditorToolsAutoPlaySkillView:_checkSkillDone(count)
	if self._count == count and self.flow then
		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill)
		self.flow:onDone(true)
	end
end

function SkillEditorToolsAutoPlaySkillView:switchEntity(mo)
	local selectType = mo.type
	local side = FightEnum.EntitySide.MySide

	if not SkillEditorHeroSelectModel.instance.stancePosId then
		local stancePosId = 1
		local oldType, info = SkillEditorMgr.instance:getTypeInfo(side)
		local co = mo.co
		local newId = mo.co.id

		if selectType == SkillEditorMgr.SelectType.Group then
			info.ids = {}
			info.skinIds = {}
			info.groupId = newId

			local monsterGroupCO = lua_monster_group.configDict[newId]
			local monsterIds = string.splitToNumber(monsterGroupCO.monster, "#")

			for _, monsterId in ipairs(monsterIds) do
				local monsterCO = lua_monster.configDict[monsterId]

				if monsterCO then
					local skinCO = FightConfig.instance:getSkinCO(monsterCO.skinId)

					if skinCO then
						if string.nilorempty(skinCO.spine) then
							GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, co.skinId or co.id)

							return
						end
					end

					table.insert(info.ids, monsterId)
					table.insert(info.skinIds, monsterCO.skinId)
				end
			end

			self:_onSelectStance(monsterGroupCO.stanceId, true)
		elseif selectType == SkillEditorMgr.SelectType.SubHero then
			SkillEditorMgr.instance:addSubHero(mo.co.id, mo.co.skinId)

			return
		else
			local firstId = info.ids[1]

			if selectType == SkillEditorMgr.SelectType.Hero then
				if not mo.co then
					local co = lua_monster.configDict[newId]
					local skinCO = FightConfig.instance:getSkinCO(mo.skinId)

					if skinCO then
						if string.nilorempty(skinCO.spine) then
							GameFacade.showToast(ToastEnum.SkillEditorHeroSelect, mo.skinId or co.id)

							return
						end

						if stancePosId then
							info.ids[stancePosId] = newId
							info.skinIds[stancePosId] = mo.skinId

							goto label_8_0
						end
					end

					for i, id in ipairs(info.ids) do
						if id == firstId or oldType ~= selectType then
							info.ids[i] = newId
							info.skinIds[i] = mo.skinId
						end
					end

					::label_8_0::

					info.groupId = nil
				end
			end
		end

		SkillEditorMgr.instance:setTypeInfo(side, selectType, info.ids, info.skinIds, info.groupId)
		SkillEditorMgr.instance:refreshInfo(side)
		SkillEditorMgr.instance:rebuildEntitys(side)
		SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr.OnSelectEntity, side)
	end
end

function SkillEditorToolsAutoPlaySkillView:_onSelectStance(stanceId, needRebuild)
	local side = FightEnum.EntitySide.MySide
	local config = lua_stance.configDict[stanceId]

	if not config then
		logError("站位不存在: " .. stanceId)

		return
	end

	SkillEditorMgr.instance.enemy_stance_id = config.id

	local member_num = 0

	for i = 1, 4 do
		if #config["pos" .. i] ~= 0 then
			member_num = member_num + 1
		end
	end

	local _, info = SkillEditorMgr.instance:getTypeInfo(side)

	while member_num < #info.ids do
		local index = #info.ids

		if SkillEditorMgr.instance.cur_select_entity_id == info.ids[index] then
			SkillEditorMgr.instance.cur_select_entity_id = info.ids[index - 1]
		end

		table.remove(info.ids, index)
		table.remove(info.skinIds, index)
	end

	SkillEditorMgr.instance.enemy_stance_count_limit = member_num

	SkillEditorMgr.instance:refreshInfo(side)
	SkillEditorMgr.instance:clearSubHero()

	if needRebuild then
		SkillEditorMgr.instance:rebuildEntitys(side)
	end
end

function SkillEditorToolsAutoPlaySkillView:_onClickSelectAll()
	SkillEditorToolAutoPlaySkillSelectModel.instance:selectAll()
end

function SkillEditorToolsAutoPlaySkillView:_onClickCancelAll()
	SkillEditorToolAutoPlaySkillSelectModel.instance:cancelSelectAll()
end

function SkillEditorToolsAutoPlaySkillView:_onClickClean()
	SkillEditorToolAutoPlaySkillSelectModel.instance:clear()
end

function SkillEditorToolsAutoPlaySkillView:_closeview()
	gohelper.setActive(self._go, false)
end

function SkillEditorToolsAutoPlaySkillView:_onInpValueChanged()
	self:_updateItems()
end

function SkillEditorToolsAutoPlaySkillView:_hideSelectSkinView()
	gohelper.setActive(self._actionViewGO, false)
end

function SkillEditorToolsAutoPlaySkillView:_showSelectSkin(mo)
	gohelper.setActive(self._actionViewGO, true)

	local co = mo.co
	local skin_list = SkinConfig.instance:getCharacterSkinCoList(co.id) or {}

	gohelper.CreateObjList(self, self.OnItemShow, skin_list, self._itemGOParent, self._itemGOPrefab)

	if #skin_list == 0 then
		logError("所选对象没有可选皮肤")
		self:_hideSelectSkinView()
	end
end

function SkillEditorToolsAutoPlaySkillView:OnItemShow(obj, data, index)
	local transform = obj.transform
	local text = transform:Find("Text"):GetComponent(gohelper.Type_TextMesh)

	text.text = data.des

	local obj_button = obj:GetComponent(typeof(SLFramework.UGUI.ButtonWrap))

	self:removeClickCb(obj_button)
	self.addClickCb(self, obj_button, self.OnItemClick, self, data)
end

function SkillEditorToolsAutoPlaySkillView:OnItemClick(config)
	SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._SelectAutoPlaySkin, {
		skinid = config.id,
		roleid = config.characterId
	})
end

function SkillEditorToolsAutoPlaySkillView:_updateItems()
	SkillEditorToolAutoPlaySkillModel.instance:setSelect(self._inp:GetText())
end

function SkillEditorToolsAutoPlaySkillView:onOpen()
	self:_updateItems()
	self:_showData()
end

function SkillEditorToolsAutoPlaySkillView:_showData()
	local list = {
		ModuleEnum.Performance.High,
		ModuleEnum.Performance.Middle,
		ModuleEnum.Performance.Low
	}

	gohelper.CreateObjList(self, self._onItemShow, list, self._goHuazhi, self._goHuazhiItem)
end

function SkillEditorToolsAutoPlaySkillView:_onItemShow(obj, data, index)
	local text = gohelper.findChildText(obj, "txt")
	local str = ""

	if data == ModuleEnum.Performance.High then
		str = "高"
	elseif data == ModuleEnum.Performance.Middle then
		str = "中"
	elseif data == ModuleEnum.Performance.Low then
		str = "低"
	end

	text.text = str

	local click = gohelper.getClick(obj)

	click:AddClickListener(self._onItemClick, self, data)
	table.insert(self._btnlist, click)
end

function SkillEditorToolsAutoPlaySkillView:_onItemClick(data)
	GameGlobalMgr.instance:getScreenState():setLocalQuality(data)
	FightEffectPool.dispose()
end

function SkillEditorToolsAutoPlaySkillView:_stopFlow()
	if self.flow and self.flow.status == WorkStatus.Running then
		local workList = self.flow:getWorkList()
		local curWorkIdx = self.flow._curIndex
		local list = SkillEditorToolAutoPlaySkillSelectModel.instance:getList()

		for i = curWorkIdx, #workList do
			local work = workList[i]

			work:onDone(true)
		end

		if self._count == #list then
			local entityMgr = FightGameMgr.entityMgr
			local list = entityMgr:getTagList(SceneTag.UnitPlayer)

			if list then
				for _, entity in ipairs(list) do
					if entity.skill then
						entity.skill:stopSkill()
					end
				end
			end

			SkillEditorMgr.instance:dispatchEvent(SkillEditorMgr._onSwitchEnityOrSkill)
			self.flow:onDone(true)
		end
	end
end

function SkillEditorToolsAutoPlaySkillView:onClose()
	if self.flow then
		self.flow:stop()

		self.flow = nil
	end
end

function SkillEditorToolsAutoPlaySkillView:onDestroyView()
	return
end

return SkillEditorToolsAutoPlaySkillView
