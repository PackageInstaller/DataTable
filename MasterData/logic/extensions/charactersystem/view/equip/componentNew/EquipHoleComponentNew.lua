-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/componentNew/EquipHoleComponentNew.lua

module("logic.extensions.charactersystem.view.equip.componentNew.EquipHoleComponentNew", package.seeall)

local M = class("EquipHoleComponentNew")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)

	self:_buildUI()

	self._view2holesIndex = {}
end

function M:_buildUI()
	self._holeAttrViewList = {}
	self._txtDescList = {}
	self._equipHoleItemViewList = {}
	self._holeAni = {}
	self._qipaoAni = {}

	for index = 1, EquipEnum.MaxDiceCount do
		local equipHoleItemGo = goutil.findChild(self._mainGo, "equip_hole_item" .. index)
		local itemView = Astral.LuaComponentContainer.Add(equipHoleItemGo, EquipHoleItemView)

		itemView:setNoCalibrationIcon(true)
		table.insert(self._equipHoleItemViewList, itemView)
		itemView:setClickCallback(function()
			self:_onClickHole(index)
		end)

		local ani = equipHoleItemGo:GetComponent(ComponentType.Animation)

		table.insert(self._holeAni, ani)

		local qipaoGo = goutil.findChild(self._mainGo, "qipao_" .. index)
		local attrView = Astral.LuaComponentContainer.Add(qipaoGo, EquipHoleAttrViewNew)

		attrView:setClickCallback(function()
			self:_onClickHole(index)
		end)
		table.insert(self._holeAttrViewList, attrView)

		local ani1 = qipaoGo:GetComponent(ComponentType.Animation)

		table.insert(self._qipaoAni, ani1)
	end

	self._holeGunzi = {}
	self._holeGunzi[2] = goutil.findChild(self._mainGo, "ImageHole2")
	self._holeGunzi[3] = goutil.findChild(self._mainGo, "ImageHole3")
	self._holeGunzi[4] = goutil.findChild(self._mainGo, "ImageHole4")

	local imageGo = goutil.findChild(self._mainGo, "imgIcon")

	self._equipModelComponent = Astral.LuaComponentContainer.Add(imageGo, EquipModelComponent)
	self._lvEffectGo = goutil.findChild(self._mainGo, "vfx_echo_view_copy")

	goutil.setActive(self._lvEffectGo, false)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self._equipModelComponent:onEnter()

	for k, v in pairs(self._holeGunzi) do
		goutil.setActive(v, false)
	end
end

function M:onExit()
	removetimer(self._showLvUpGo, self)
	removetimer(self._hideLvUpGo, self)
	goutil.setActive(self._lvEffectGo, false)
	self._equipModelComponent:onExit()

	self._equipMo = nil
end

function M:setVisible(visible)
	self._mainGo:SetActive(visible)
end

function M:refreshView()
	self._equipModelComponent:refreshView()
	self:_refreshHoleView()
	self:_refreshBubblesView()

	local holesNum = self._holeUseNum

	if self._holeGunzi[holesNum] then
		goutil.setActive(self._holeGunzi[holesNum], true)
	end
end

function M:refreshHole()
	self:_refreshHoleView()
	self:_refreshBubblesView()
end

function M:_refreshHoleView()
	local isTimingMax = EquipIntensifyModel.instance:isEquipMaxTimingTimes(self._equipMo)
	local curHoleIndex = EquipIntensifyModel.instance:getTimingHoleIndex()
	local hasOriginalD6 = self._equipMo:hasOriginalD6()
	local viewIndex = 0

	table.clear(self._view2holesIndex)

	local enhances = {}

	for index = 1, EquipEnum.MaxDiceCount do
		local status = self._equipMo:getHoleStatus(index)
		local visible = self:getIsHoleVisible(status)

		if not visible then
			-- block empty
		else
			viewIndex = viewIndex + 1

			local itemView = self._equipHoleItemViewList[viewIndex]

			itemView:setVisible(true)
			itemView:setStatus(status)
			itemView:setSelectGoVisible(false)
			itemView:showGuang(false)
			itemView:closeEnhanceAni()
			itemView:setTimingLockingShow(false)

			if index == 1 then
				if hasOriginalD6 then
					local d6Mo = self._equipMo:getOriginalD6():getEffectAttr()

					itemView:setData(d6Mo)
					itemView:setTimingLockingShow(true)

					if d6Mo:isEnhanced() then
						local enhanceType = d6Mo:getEnhanceType()

						enhances[enhanceType] = {
							viewIndex
						}
					end
				else
					itemView:setData(nil)
				end
			else
				local holeIndex = index - 1
				local isHoldUnlock = self._equipMo:getIsHoleUnlock(holeIndex)

				if isHoldUnlock then
					local fixedD6Mo = self._equipMo:getFixedD6ByHoleIndex(holeIndex)

					if fixedD6Mo then
						local d6Mo = fixedD6Mo:getEffectAttr()

						itemView:setData(d6Mo)
						itemView:setTimingLockingShow(isTimingMax)
						itemView:showGuang(not EquipIntensifyModel.instance:isEquipMaxTimingTimes(self._equipMo))

						if d6Mo:isEnhanced() then
							local enhanceType = d6Mo:getEnhanceType()

							if enhances[enhanceType] then
								table.insert(enhances[enhanceType], viewIndex)
							else
								enhances[enhanceType] = {
									viewIndex
								}
							end
						end
					else
						itemView:setData(nil)
						itemView:showGuang(true)

						if index == 2 then
							itemView:setGoName("new_player_equip_hole_guide")
						end
					end
				end

				itemView:setSelectGoVisible(curHoleIndex and curHoleIndex == holeIndex)
				self._holeAttrViewList[viewIndex]:setSelectGoVisible(curHoleIndex and curHoleIndex == holeIndex)
			end

			table.insert(self._view2holesIndex, index)
		end
	end

	for index = viewIndex + 1, EquipEnum.MaxDiceCount do
		local itemView = self._equipHoleItemViewList[index]

		itemView:setVisible(false)
	end

	for _, v in pairs(enhances) do
		local enhanceNum = #v

		if enhanceNum and enhanceNum > 1 then
			for k, viewind in ipairs(v) do
				local itemView = self._equipHoleItemViewList[viewind]

				itemView:playEnhanceAni(enhanceNum)
			end
		end
	end

	self._holeUseNum = viewIndex
end

function M:_refreshBubblesView()
	if self._isBubblesHided then
		return
	end

	local holesNum = #self._view2holesIndex

	for index, holeIndex in pairs(self._view2holesIndex) do
		local itemView = self._holeAttrViewList[index]
		local equipHoleAttrMo = EquipIntensifyModel.instance:genEquipHoleAttrMo(self._equipMo, holeIndex - 1)

		if itemView then
			itemView:setVisible(true)
			itemView:setEquipHoleAttrMo(equipHoleAttrMo)

			local noCalibration = equipHoleAttrMo.status == EquipEnum.HoleStatus.NoCalibration
			local canTming = equipHoleAttrMo.status == EquipEnum.HoleStatus.Unlock and not EquipIntensifyModel.instance:isEquipMaxTimingTimes(self._equipMo)

			itemView:showGuang(noCalibration or canTming)
		end
	end

	for index = holesNum + 1, EquipEnum.MaxDiceCount do
		local itemView = self._holeAttrViewList[index]

		if itemView then
			itemView:setVisible(false)
		end
	end
end

function M:getIsHoleVisible(holeStatus)
	return holeStatus == EquipEnum.HoleStatus.NoCalibration or holeStatus == EquipEnum.HoleStatus.Unlock or holeStatus == EquipEnum.HoleStatus.Lock or holeStatus == EquipEnum.HoleStatus.Unalterable
end

function M:setEquipData(equipMo)
	self._equipMo = equipMo

	self._equipModelComponent:setEquipData(equipMo)
	self:refreshView()
	self:_setHoleItemsPos()
end

function M:OnDestroy()
	self._equipHoleItemViewList = nil
	self._holeAttrViewList = nil

	self._equipModelComponent:OnDestroy()
end

function M:_setHoleItemsPos()
	local holesNum = #self._view2holesIndex

	if holesNum < 1 then
		return
	end

	local posInfo = self:_getHolePosInfo(holesNum)

	if not posInfo then
		printError("无法找到装备词条位置， 当前词条数", holesNum)

		return
	end

	for index = 1, holesNum do
		local itemView = self._equipHoleItemViewList[index]
		local pos = posInfo.holePos[index]

		if itemView and pos then
			itemView:setPos(pos.x, pos.y)
		end

		itemView = self._holeAttrViewList[index]
		pos = posInfo.qipaoPos[index]

		if itemView and pos then
			itemView:setPos(pos.x, pos.y)
		end
	end
end

function M:hideBubbles(isHide)
	return
end

function M:setEquipModelPos(pos)
	self._equipModelComponent:setModelPos(pos)
end

function M:setHolePos(pos)
	self._holePos = pos
end

function M:_getHolePosInfo(holesNum)
	return self._holePos[holesNum]
end

function M:clearHoleSelect()
	for _index = 1, #self._view2holesIndex do
		local itemView = self._equipHoleItemViewList[_index]

		itemView:setSelectGoVisible(false)
		self._holeAttrViewList[_index]:setSelectGoVisible(_index == index)
	end
end

function M:refreshHoleSelect(holeIndex)
	for _index = 1, #self._view2holesIndex do
		local itemView = self._equipHoleItemViewList[_index]

		itemView:setSelectGoVisible(self._view2holesIndex[_index] == holeIndex)
		self._holeAttrViewList[_index]:setSelectGoVisible(_index == index)
		EquipIntensifyModel.instance:setTuoweiPos(self._view2holesIndex[_index] - 1, itemView:getIconTransPos())
	end
end

function M:_onClickHole(index)
	local holeIndex = self._view2holesIndex[index]

	if not holeIndex or holeIndex == 1 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_timing_origin"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	if not EquipIntensifyModel.instance:isD6Open() then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_timing_not_open"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return false
	end

	holeIndex = holeIndex - 1

	local equipHoleAttrMo = EquipIntensifyModel.instance:genEquipHoleAttrMo(self._equipMo, holeIndex)

	if equipHoleAttrMo.status == EquipEnum.HoleStatus.Unalterable then
		return
	end

	if equipHoleAttrMo.status == EquipEnum.HoleStatus.Lock then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_timing_hole_lv_less"), CommEnum.CharacterTopToastIcon.Fail, 1)

		return
	end

	EquipIntensifyModel.instance:setTimingHoleIndex(holeIndex)

	for _index = 1, #self._view2holesIndex do
		local itemView = self._equipHoleItemViewList[_index]

		itemView:setSelectGoVisible(_index == index)
		self._holeAttrViewList[_index]:setSelectGoVisible(_index == index)
		EquipIntensifyModel.instance:setTuoweiPos(self._view2holesIndex[_index] - 1, itemView:getIconTransPos())
	end

	GlobalDispatcher:dispatchEvent(EventType.EQUIP_UI_STATUS_CHANGED, EquipEnum.MainUIStatus.Retiming, true)
end

function M:checkJumpToTimingView()
	local jumpHoleIndex = EquipIntensifyModel.instance:getTimingJumpHoleInde()

	EquipIntensifyModel.instance:clearTimingJumpHoleInde()

	if jumpHoleIndex then
		local viewIndex = self:getHoleItemViewIndexByHoleIndex(jumpHoleIndex)

		if viewIndex then
			self:_onClickHole(viewIndex)

			return true
		end
	end

	return false
end

function M:_tryOpenEquipTimingView()
	local part = self._equipMo:getPart()

	EquipIntensifyModel.instance:setTimingD6Part(part)
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_UI_STATUS_CHANGED, EquipEnum.MainUIStatus.Retiming)
end

function M:_tryOpenEquipResetView()
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_UI_STATUS_CHANGED, EquipEnum.MainUIStatus.Retiming)
end

function M:playEquipTmingAni()
	local holeIndex = EquipIntensifyModel.instance:getTimingHoleIndex()
	local viewIndex = 1

	for index, hole in ipairs(self._view2holesIndex) do
		if hole - 1 == holeIndex then
			local ani = self._holeAni[index]

			ani:Stop()
			AnimationUtils.ResetAnimation(ani, "left_equip_shengji2")
			ani:Play("left_equip_shengji2")

			local ani1 = self._qipaoAni[index]

			ani1:Stop()
			AnimationUtils.ResetAnimation(ani1, "left_equip_tiaojiao")
			ani1:Play("left_equip_tiaojiao")

			viewIndex = index
		end
	end

	local fixedD6MoNow = self._equipMo:getFixedD6ByHoleIndex(holeIndex)
	local d6MoNow = fixedD6MoNow:getEffectAttr()
	local enhanceIndexs = {}

	if d6MoNow:isEnhanced() then
		local enhanceType = d6MoNow:getEnhanceType()
		local hasOriginalD6 = self._equipMo:hasOriginalD6()

		if hasOriginalD6 then
			local d6MoIn = self._equipMo:getOriginalD6():getEffectAttr()

			if d6MoIn:isEnhanced() and d6MoIn:getEnhanceType() == enhanceType then
				local inViewIndex = self:getHoleItemViewIndexByHoleIndex(1)

				table.insert(enhanceIndexs, inViewIndex)
			end
		end

		for index = 2, EquipEnum.MaxDiceCount do
			local holeIndex = index - 1
			local isHoldUnlock = self._equipMo:getIsHoleUnlock(holeIndex)

			if isHoldUnlock then
				local fixedD6Mo = self._equipMo:getFixedD6ByHoleIndex(holeIndex)

				if fixedD6Mo then
					local d6MoIn = fixedD6Mo:getEffectAttr()

					if d6MoIn:isEnhanced() and d6MoIn:getEnhanceType() == enhanceType then
						local inViewIndex = self:getHoleItemViewIndexByHoleIndex(index)

						table.insert(enhanceIndexs, inViewIndex)
					end
				end
			end
		end
	end

	local enhanceNum = #enhanceIndexs

	if enhanceNum and enhanceNum > 1 then
		for k, viewind in ipairs(enhanceIndexs) do
			local itemView = self._equipHoleItemViewList[viewind]

			itemView:playeEnhanceRollAni(enhanceNum)
		end
	end
end

function M:playEquipLvAni()
	local oldEquip = EquipIntensifyModel.instance:getEquipBeforeUpdate()
	local newEquip = EquipIntensifyModel.instance:getOperatingEquip()
	local oldUnlockHoleCount = oldEquip:getUnlockHoleCount()
	local newUnlockHoleCount = newEquip:getUnlockHoleCount()

	if oldUnlockHoleCount < newUnlockHoleCount then
		for index = oldUnlockHoleCount + 1, newUnlockHoleCount do
			local viewIndex = self:getHoleItemViewIndexByHoleIndex(index + 1)

			if viewIndex then
				local ani = self._holeAni[viewIndex]

				ani:Stop()
				AnimationUtils.ResetAnimation(ani, "left_equip_shengji2")
				ani:Play("left_equip_shengji2")

				local ani1 = self._qipaoAni[viewIndex]

				ani1:Stop()
				AnimationUtils.ResetAnimation(ani1, "left_equip_shengji1")
				ani1:Play("left_equip_shengji1")
			end
		end

		CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqijiedianjiesuo, nil, nil, nil)
	end

	goutil.setActive(self._lvEffectGo, false)
	removetimer(self._showLvUpGo, self)
	removetimer(self._hideLvUpGo, self)
	settimer(0, self._showLvUpGo, self, false)
	settimer(3, self._hideLvUpGo, self, false)
end

function M:_showLvUpGo()
	goutil.setActive(self._lvEffectGo, true)
end

function M:_hideLvUpGo()
	goutil.setActive(self._lvEffectGo, false)
end

function M:getHoleItemViewIndexByHoleIndex(holeIndex)
	for index, hole in ipairs(self._view2holesIndex) do
		if hole == holeIndex then
			return index
		end
	end
end

return M
