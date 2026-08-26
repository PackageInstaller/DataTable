-- chunkname: @modules/logic/versionactivity2_4/pinball/entity/PinballBuildingEntity.lua

module("modules.logic.versionactivity2_4.pinball.entity.PinballBuildingEntity", package.seeall)

local PinballBuildingEntity = class("PinballBuildingEntity", LuaCompBase)

function PinballBuildingEntity:init(go)
	self.go = go
	self.trans = go.transform
	self._effect = gohelper.create3d(go, "effect")

	gohelper.setActive(self._effect, false)

	local loader = PrefabInstantiate.Create(self._effect)

	loader:startLoad("scenes/v2a4_m_s12_ttsz_jshd/prefab/vx_building.prefab")
end

function PinballBuildingEntity:initCo(co)
	self.co = co

	local arr = string.splitToNumber(self.co.pos, "#") or {}

	transformhelper.setLocalPosXY(self.trans, arr[1] or 0, arr[2] or 0)
	self:checkLoadRes(true)
end

function PinballBuildingEntity:setUI(ui)
	self.ui = ui

	local mainCamera = CameraMgr.instance:getMainCamera()
	local uiCamera = CameraMgr.instance:getUICamera()
	local plane = ViewMgr.instance:getUIRoot().transform

	self._uiFollower = gohelper.onceAddComponent(ui, typeof(ZProj.UIFollower))

	self._uiFollower:Set(mainCamera, uiCamera, plane, self.trans, 0, 0, 0, 0, 0)
	self._uiFollower:SetEnable(true)

	self._gonormal = gohelper.findChild(ui, "#go_normal")
	self._gomain = gohelper.findChild(ui, "#go_main")
	self._goopers = gohelper.findChild(ui, "#go_opers")
	self._gocanupgrade = gohelper.findChild(ui, "#go_normal/#go_arrow")
	self._gocanupgrade2 = gohelper.findChild(ui, "#go_opers/#btn_upgrade/go_reddot")
	self._gotalentred = gohelper.findChild(ui, "#go_opers/#btn_talent/go_reddot")
	self._btnRemove = gohelper.findChildButtonWithAudio(ui, "#go_opers/#btn_remove")
	self._btnUpgrade = gohelper.findChildButtonWithAudio(ui, "#go_opers/#btn_upgrade")
	self._btnUpgradeMax = gohelper.findChildButtonWithAudio(ui, "#go_opers/#btn_check")
	self._btnTalent = gohelper.findChildButtonWithAudio(ui, "#go_opers/#btn_talent")
	self._btnClickThis = gohelper.findChildButtonWithAudio(ui, "")
	self._gooperbigbg = gohelper.findChild(ui, "#go_opers/circle_big")
	self._goopersmallbg = gohelper.findChild(ui, "#go_opers/circle_small")
	self._normalLv = gohelper.findChildTextMesh(ui, "#go_normal/#txt_lv")
	self._mainCityLv = gohelper.findChildTextMesh(ui, "#go_main/#txt_lv")
	self._mainCityNum = gohelper.findChildTextMesh(ui, "#go_main/#txt_num")
	self._mainCitySlider0 = gohelper.findChildImage(ui, "#go_main/#go_slider/#go_slider0")
	self._mainCitySlider1 = gohelper.findChildImage(ui, "#go_main/#go_slider/#go_slider1")
	self._mainCitySlider2 = gohelper.findChildImage(ui, "#go_main/#go_slider/#go_slider2")
	self._mainCitySlider3 = gohelper.findChildImage(ui, "#go_main/#go_slider/#go_slider3")
	self._mainCitySlider4 = gohelper.findChildImage(ui, "#go_main/#go_slider/#go_slider4")
	self._goFood = gohelper.findChildAnim(ui, "#go_food")
	self._txtFoodNum = gohelper.findChildTextMesh(ui, "#go_food/#txt_num")
	self._goDialog = gohelper.findChild(ui, "#go_dialog")
	self._txtunlock = gohelper.findChildTextMesh(ui, "#txt_unlock")

	self.addClickCb(self, self._btnRemove, self._onRemoveClick, self)
	self.addClickCb(self, self._btnUpgrade, self._onUpgradeClick, self)
	self.addClickCb(self, self._btnUpgradeMax, self._onUpgradeClick, self)
	self.addClickCb(self, self._btnTalent, self._onTalentClick, self)
	self.addClickCb(self, self._btnClickThis, self._guideClick, self)
	gohelper.setActive(self._gooperbigbg, self.co.size == 4)
	gohelper.setActive(self._goopersmallbg, self.co.size == 1)
	recthelper.setAnchorY(self._txtunlock.transform, self.co.size == 1 and -50 or -78)
	self:_refreshUI()
	self:_onTalentRedChange()
end

function PinballBuildingEntity:_guideClick()
	local index = self:_realClick()

	if index then
		PinballController.instance:dispatchEvent(PinballEvent.OnClickBuilding, index)
	end
end

function PinballBuildingEntity:setUIScale(scale)
	transformhelper.setLocalScale(self.ui.transform, scale, scale, scale)
end

function PinballBuildingEntity:addEventListeners()
	PinballController.instance:registerCallback(PinballEvent.OnClickBuilding, self._onClickBuilding, self)
	PinballController.instance:registerCallback(PinballEvent.AddBuilding, self._buildingUpdate, self)
	PinballController.instance:registerCallback(PinballEvent.UpgradeBuilding, self._buildingUpdate, self)
	PinballController.instance:registerCallback(PinballEvent.RemoveBuilding, self._buildingUpdate, self)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, self._refreshMainCityUI, self)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, self._refreshCanUpgrade, self)
	PinballController.instance:registerCallback(PinballEvent.OnCurrencyChange, self._refreshHoleLock, self)
	PinballController.instance:registerCallback(PinballEvent.EndRound, self._refreshUI, self)
	PinballController.instance:registerCallback(PinballEvent.GetReward, self._onGetReward, self)
	PinballController.instance:registerCallback(PinballEvent.TalentRedChange, self._onTalentRedChange, self)
end

function PinballBuildingEntity:removeEventListeners()
	PinballController.instance:unregisterCallback(PinballEvent.OnClickBuilding, self._onClickBuilding, self)
	PinballController.instance:unregisterCallback(PinballEvent.AddBuilding, self._buildingUpdate, self)
	PinballController.instance:unregisterCallback(PinballEvent.UpgradeBuilding, self._buildingUpdate, self)
	PinballController.instance:unregisterCallback(PinballEvent.RemoveBuilding, self._buildingUpdate, self)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, self._refreshMainCityUI, self)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, self._refreshCanUpgrade, self)
	PinballController.instance:unregisterCallback(PinballEvent.OnCurrencyChange, self._refreshHoleLock, self)
	PinballController.instance:unregisterCallback(PinballEvent.EndRound, self._refreshUI, self)
	PinballController.instance:unregisterCallback(PinballEvent.GetReward, self._onGetReward, self)
	PinballController.instance:unregisterCallback(PinballEvent.TalentRedChange, self._onTalentRedChange, self)
end

function PinballBuildingEntity:_buildingUpdate(index)
	if index ~= self.co.index then
		return
	end

	self:_refreshUI()
	self:checkLoadRes()
end

function PinballBuildingEntity:_refreshUI()
	gohelper.setActive(self._gomain, self:isMainCity())
	gohelper.setActive(self._gonormal, not self:isEmpty() and not self:isMainCity())
	gohelper.setActive(self._btnTalent, self:isTalent())
	gohelper.setActive(self._goopers, false)

	local info = self:getInfo()

	if info then
		if self:isMainCity() then
			self:_refreshMainCityUI()
		else
			self._normalLv.text = info.level
		end

		local uiOffset = info.baseCo.uiOffset
		local dict = GameUtil.splitString2(uiOffset, true) or {}

		recthelper.setAnchor(self._gonormal.transform, dict[1][1], dict[1][2])
		recthelper.setAnchor(self._goopers.transform, dict[2][1], dict[2][2])
		recthelper.setAnchor(self._goFood.transform, dict[3][1], dict[3][2])
		recthelper.setAnchor(self._goDialog.transform, dict[3][1], dict[3][2])
		gohelper.setActive(self._btnRemove, info.co.destory)
		gohelper.setActive(self._goFood, info.food > 0)
		gohelper.setActive(self._goDialog, info.interact > 0)
		gohelper.setActive(self._btnUpgrade, info.nextCo)
		gohelper.setActive(self._btnUpgradeMax, not info.nextCo)

		if info.food > 0 then
			self._txtFoodNum.text = info.food
		end
	else
		gohelper.setActive(self._btnRemove, false)
		gohelper.setActive(self._goFood, false)
		gohelper.setActive(self._goDialog, false)
	end

	self:_refreshCanUpgrade()
	self:_refreshHoleLock()
end

function PinballBuildingEntity:_refreshCanUpgrade()
	local canupgrade = true
	local info = self:getInfo()
	local nextCo = info and info.nextCo

	if nextCo then
		local condition = nextCo.condition

		if not string.nilorempty(condition) then
			local dict = GameUtil.splitString2(condition, true)

			for _, arr in pairs(dict) do
				local type = arr[1]

				if type == PinballEnum.ConditionType.Talent then
					local talentId = arr[2]

					if not PinballModel.instance:getTalentMo(talentId) then
						canupgrade = false

						break
					end
				elseif type == PinballEnum.ConditionType.Score then
					local value = arr[2]

					if value > PinballModel.instance.maxProsperity then
						canupgrade = false

						break
					end
				end
			end
		end

		if canupgrade then
			local cost = nextCo.cost

			if not string.nilorempty(cost) then
				local dict = GameUtil.splitString2(cost, true)

				for _, arr in pairs(dict) do
					if arr[2] > PinballModel.instance:getResNum(arr[1]) then
						canupgrade = false

						break
					end
				end
			end
		end
	else
		canupgrade = false
	end

	gohelper.setActive(self._gocanupgrade, canupgrade)
	gohelper.setActive(self._gocanupgrade2, canupgrade)
end

function PinballBuildingEntity:_onTalentRedChange()
	if not self:isTalent() then
		return
	end

	gohelper.setActive(self._gotalentred, PinballModel.instance:getTalentRed(self:getInfo().baseCo.id))
end

function PinballBuildingEntity:_refreshHoleLock()
	local unLockLv

	if self:isEmpty() then
		local value = self.co.condition

		if value > PinballModel.instance.maxProsperity then
			unLockLv = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, value)
		end
	end

	gohelper.setActive(self._txtunlock, unLockLv)

	if unLockLv then
		self._txtunlock.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("pinball_unlock"), unLockLv)
	end

	if self:isEmpty() then
		self:checkLoadRes(true)
	end
end

function PinballBuildingEntity:getEmptyPath()
	local path
	local isLock = self.co.condition > PinballModel.instance.maxProsperity

	return isLock and (self.co.size == 1 and "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_3.prefab" or "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_4.prefab") or self.co.size == 1 and "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_1.prefab" or "scenes/v2a4_m_s12_ttsz_jshd/prefab/img_jianzaodikuai_2.prefab"
end

function PinballBuildingEntity:_refreshMainCityUI()
	local level, curScore, nextScore = PinballModel.instance:getScoreLevel()
	local score, changeNum = PinballModel.instance:getResNum(PinballEnum.ResType.Score)

	self._mainCityLv.text = level

	local value1, value2, value3 = 0, 0, 0

	if changeNum == score then
		self._mainCityNum.text = string.format("%d/%d", score, nextScore)
		value2 = nextScore == curScore and 1 or (score - curScore) / (nextScore - curScore)
	else
		self._mainCityNum.text = string.format("%d<color=%s>(%+d)</color>/%d", score, score < changeNum and "#BCFF85" or "#FC8A6A", changeNum - score, nextScore)

		if score < changeNum then
			if nextScore == curScore then
				value2 = 1
			else
				value1 = (changeNum - curScore) / (nextScore - curScore)
				value2 = (score - curScore) / (nextScore - curScore)

				if nextScore < changeNum then
					local _, changeBaseScore, changeNextScore = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, changeNum)

					value3 = (changeNum - changeBaseScore) / (changeNextScore - changeBaseScore)
				end
			end
		elseif curScore <= changeNum then
			value1 = (score - curScore) / (nextScore - curScore)
			value2 = (changeNum - curScore) / (nextScore - curScore)
		else
			local _, changeBaseScore, changeNextScore = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, changeNum)

			value1 = 1
			value2 = (changeNum - changeBaseScore) / (changeNextScore - changeBaseScore)
			value3 = (score - curScore) / (nextScore - curScore)
		end
	end

	self._mainCitySlider0.fillAmount = value1
	self._mainCitySlider1.fillAmount = value1
	self._mainCitySlider2.fillAmount = value2
	self._mainCitySlider3.fillAmount = value3
	self._mainCitySlider4.fillAmount = value3

	gohelper.setActive(self._mainCitySlider0, changeNum < score)
	gohelper.setActive(self._mainCitySlider4, changeNum < score)
	gohelper.setActive(self._mainCitySlider1, score < changeNum)
	gohelper.setActive(self._mainCitySlider3, score < changeNum)
end

function PinballBuildingEntity:checkLoadRes(isFirst)
	local loader = PrefabInstantiate.Create(self.go)
	local path = ""

	path = not self:isEmpty() and string.format("scenes/v2a4_m_s12_ttsz_jshd/prefab/%s.prefab", self:getInfo().baseCo.res) or self:getEmptyPath()

	if loader:getPath() == path then
		return
	end

	loader:dispose()
	loader:startLoad(path)

	if not self:isEmpty() and not isFirst then
		gohelper.setActive(self._effect, false)
		gohelper.setActive(self._effect, true)
		TaskDispatcher.cancelTask(self._hideEffect, self)
		TaskDispatcher.runDelay(self._hideEffect, self, 3)
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio4)

		PinballModel.instance.guideHole = self.co.index

		if self:isTalent() then
			PinballController.instance:dispatchEvent(PinballEvent.GuideBuildTalent)
		else
			PinballController.instance:dispatchEvent(PinballEvent.GuideBuildHouse)
		end
	end
end

function PinballBuildingEntity:_hideEffect()
	gohelper.setActive(self._effect, false)
end

function PinballBuildingEntity:_onClickBuilding(index)
	gohelper.setActive(self._goopers, index == self.co.index)

	if index == self.co.index then
		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio2)
	end
end

function PinballBuildingEntity:isMainCity()
	local info = self:getInfo()

	return info and info:isMainCity()
end

function PinballBuildingEntity:isTalent()
	local info = self:getInfo()

	return info and info:isTalent()
end

function PinballBuildingEntity:isEmpty()
	return not self:getInfo()
end

function PinballBuildingEntity:_onRemoveClick()
	PinballController.instance:removeBuilding(self.co.index)
end

function PinballBuildingEntity:_onUpgradeClick()
	ViewMgr.instance:openView(ViewName.PinballUpgradeView, {
		index = self.co.index
	})
end

function PinballBuildingEntity:_onTalentClick()
	if not self:getInfo() then
		return
	end

	ViewMgr.instance:openView(ViewName.PinballTalentView, {
		index = self.co.index,
		info = self:getInfo()
	})
end

function PinballBuildingEntity:_onFoodClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	Activity178Rpc.instance:sendAct178GetReward(VersionActivity2_4Enum.ActivityId.Pinball, 0)
end

function PinballBuildingEntity:_onGetReward(index)
	if index == 0 or index == self.co.index then
		self._goFood:Play("click", 0, 0)
		TaskDispatcher.cancelTask(self._refreshUI, self)
		TaskDispatcher.runDelay(self._refreshUI, self, 1.167)
	end
end

function PinballBuildingEntity:_onDialogClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	Activity178Rpc.instance:sendAct178Interact(VersionActivity2_4Enum.ActivityId.Pinball, self.co.index, self.triggerDialog, self)
end

function PinballBuildingEntity:triggerDialog(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	local info = self:getInfo()

	if not info then
		return
	end

	TipDialogController.instance:openTipDialogView(info.interact)

	info.interact = 0

	self:_refreshUI()
end

function PinballBuildingEntity:getInfo()
	return PinballModel.instance:getBuildingInfo(self.co.index)
end

function PinballBuildingEntity:tryClick(worldpos, mapScale)
	local offset = self.trans.position - worldpos
	local size = 2

	if self.co.size == 4 then
		size = 4
	end

	size = size * mapScale

	if size > math.abs(offset.x) and size > math.abs(offset.y) then
		return self:_realClick()
	end
end

function PinballBuildingEntity:_realClick()
	local info = self:getInfo()

	if self:isMainCity() then
		if info.interact > 0 then
			self:_onDialogClick()
		end

		return
	end

	if self:isEmpty() then
		local value = self.co.condition

		if value > PinballModel.instance.maxProsperity then
			local lv = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, value)

			GameFacade.showToast(ToastEnum.Act178ScoreCondition, lv)

			return
		end

		ViewMgr.instance:openView(ViewName.PinballBuildView, {
			index = self.co.index,
			size = self.co.size
		})
	else
		local selectIndex

		if info.food > 0 then
			self:_onFoodClick()
		elseif info.interact > 0 then
			self:_onDialogClick()
		elseif not self._goopers.activeSelf then
			selectIndex = self.co.index
		end

		return selectIndex
	end
end

function PinballBuildingEntity:onDestroy()
	TaskDispatcher.cancelTask(self._hideEffect, self)
	TaskDispatcher.cancelTask(self._refreshUI, self)
end

return PinballBuildingEntity
