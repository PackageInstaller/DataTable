-- chunkname: @modules/logic/versionactivity2_4/pinball/view/PinballUpgradeView.lua

module("modules.logic.versionactivity2_4.pinball.view.PinballUpgradeView", package.seeall)

local PinballUpgradeView = class("PinballUpgradeView", BaseView)

function PinballUpgradeView:onInitView()
	self._imageicon = gohelper.findChildSingleImage(self.viewGO, "#image_icon")
	self._txtname = gohelper.findChildTextMesh(self.viewGO, "#txt_buildingname")
	self._txttitle = gohelper.findChildTextMesh(self.viewGO, "#scroll_dec/Viewport/Content/#txt_title")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "#scroll_dec/Viewport/Content/#txt_dec")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnremove = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_remove")
	self._goupgrade = gohelper.findChild(self.viewGO, "#go_upgrade")
	self._btnupgrade = gohelper.findChildButtonWithAudio(self.viewGO, "#go_upgrade/#btn_upgrade")
	self._btnupgradeEffect = gohelper.findChild(self.viewGO, "#go_upgrade/#btn_upgrade/vx_ink")
	self._txtnowlv = gohelper.findChildTextMesh(self.viewGO, "#go_upgrade/#txt_nowLv")
	self._txtnextlv = gohelper.findChildTextMesh(self.viewGO, "#go_upgrade/#txt_nextLv")
	self._gomax = gohelper.findChild(self.viewGO, "#go_max")
	self._txtmaxlv = gohelper.findChildTextMesh(self.viewGO, "#go_max/#txt_lv")
	self._gocostitem = gohelper.findChild(self.viewGO, "#go_upgrade/#go_currency/go_item")
	self._gopreviewitem = gohelper.findChild(self.viewGO, "#go_preview/#go_group/go_item")
	self._gopreviewtitle = gohelper.findChild(self.viewGO, "#go_preview/txt_preview")
	self._topCurrencyRoot = gohelper.findChild(self.viewGO, "#go_topright")
	self._goeffect = gohelper.findChild(self.viewGO, "vx_upgrade")
end

function PinballUpgradeView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
	self._btnremove:AddClickListener(self.removeBuilding, self)
	self._btnupgrade:AddClickListener(self.upgradeBuilding, self)
	PinballController.instance:registerCallback(PinballEvent.UpgradeBuilding, self._buildingUpdate, self)
	PinballController.instance:registerCallback(PinballEvent.RemoveBuilding, self._buildingRemove, self)
end

function PinballUpgradeView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnremove:RemoveClickListener()
	self._btnupgrade:RemoveClickListener()
	PinballController.instance:unregisterCallback(PinballEvent.UpgradeBuilding, self._buildingUpdate, self)
	PinballController.instance:unregisterCallback(PinballEvent.RemoveBuilding, self._buildingRemove, self)
end

function PinballUpgradeView:onClickModalMask()
	self:closeThis()
end

function PinballUpgradeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio3)
	self:createCurrencyItem()
	self:_refreshBuilding()
end

function PinballUpgradeView:_refreshBuilding()
	local buildingInfo = PinballModel.instance:getBuildingInfo(self.viewParam.index)

	if not buildingInfo then
		return
	end

	local curCo = buildingInfo.co
	local nextCo = buildingInfo.nextCo

	self._imageicon:LoadImage(string.format("singlebg/v2a4_tutushizi_singlebg/building/%s.png", buildingInfo.baseCo.icon))

	self._txtname.text = buildingInfo.baseCo.name
	self._txttitle.text = buildingInfo.baseCo.desc
	self._txtdesc.text = buildingInfo.baseCo.desc2

	gohelper.setActive(self._gomax, not nextCo)
	gohelper.setActive(self._goupgrade, nextCo)
	gohelper.setActive(self._gopreviewtitle, nextCo)
	gohelper.setActive(self._btnremove, curCo.destory)

	if nextCo then
		self._txtnowlv.text = curCo.level
		self._txtnextlv.text = nextCo.level

		self:updateCost(nextCo)

		local isGray = self._costNoEnough and true or self:checkLock(nextCo) or false

		ZProj.UGUIHelper.SetGrayscale(self._btnupgrade.gameObject, isGray)
		gohelper.setActive(self._btnupgradeEffect, not isGray)
	else
		self._txtmaxlv.text = curCo.level
	end

	self:updatePreview(curCo, nextCo)
end

function PinballUpgradeView:createCurrencyItem()
	local topCurrency = {
		PinballEnum.ResType.Wood,
		PinballEnum.ResType.Mine,
		PinballEnum.ResType.Stone
	}

	for _, currencyType in ipairs(topCurrency) do
		local go = self:getResInst(self.viewContainer._viewSetting.otherRes.currency, self._topCurrencyRoot)
		local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, PinballCurrencyItem)

		comp:setCurrencyType(currencyType)
	end
end

function PinballUpgradeView:updatePreview(curCo, nextCo)
	local effectArr = {}
	local effect = curCo.effect
	local typeToIndex = {}

	if not string.nilorempty(effect) then
		local dict = GameUtil.splitString2(effect, true)

		for _, arr in pairs(dict) do
			if arr[1] == PinballEnum.BuildingEffectType.AddScore then
				table.insert(effectArr, {
					resType = PinballEnum.ResType.Score,
					value = arr[2]
				})

				typeToIndex[arr[1]] = #effectArr
			elseif arr[1] == PinballEnum.BuildingEffectType.AddFood then
				table.insert(effectArr, {
					resType = PinballEnum.ResType.Food,
					value = arr[2]
				})

				typeToIndex[arr[1]] = #effectArr
			elseif arr[1] == PinballEnum.BuildingEffectType.AddPlay then
				table.insert(effectArr, {
					resType = PinballEnum.ResType.Play,
					value = arr[2]
				})

				typeToIndex[arr[1]] = #effectArr
			elseif arr[1] == PinballEnum.BuildingEffectType.CostFood then
				table.insert(effectArr, {
					resType = PinballEnum.ResType.Food,
					value = arr[2],
					text = luaLang("pinball_food_need")
				})

				typeToIndex[arr[1]] = #effectArr
			elseif arr[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
				table.insert(effectArr, {
					resType = PinballEnum.ResType.Play,
					value = arr[2],
					text = luaLang("pinball_play_need")
				})

				typeToIndex[arr[1]] = #effectArr
			end
		end
	end

	if nextCo then
		effect = nextCo.effect

		if not string.nilorempty(nextCo.effect) then
			local dict = GameUtil.splitString2(effect, true)

			for _, arr in pairs(dict) do
				if arr[1] == PinballEnum.BuildingEffectType.AddScore then
					local index = typeToIndex[arr[1]]

					if index then
						effectArr[index].nextVal = arr[2]
					else
						table.insert(effectArr, {
							resType = PinballEnum.ResType.Score,
							nextVal = arr[2]
						})
					end
				elseif arr[1] == PinballEnum.BuildingEffectType.AddFood then
					local index = typeToIndex[arr[1]]

					if index then
						effectArr[index].nextVal = arr[2]
					else
						table.insert(effectArr, {
							resType = PinballEnum.ResType.Food,
							nextVal = arr[2]
						})
					end
				elseif arr[1] == PinballEnum.BuildingEffectType.AddPlay then
					local index = typeToIndex[arr[1]]

					if index then
						effectArr[index].nextVal = arr[2]
					else
						table.insert(effectArr, {
							resType = PinballEnum.ResType.Play,
							nextVal = arr[2]
						})
					end
				elseif arr[1] == PinballEnum.BuildingEffectType.CostFood then
					local index = typeToIndex[arr[1]]

					if index then
						effectArr[index].nextVal = arr[2]
					else
						table.insert(effectArr, {
							resType = PinballEnum.ResType.Food,
							nextVal = arr[2],
							text = luaLang("pinball_food_need")
						})
					end
				elseif arr[1] == PinballEnum.BuildingEffectType.AddPlayDemand then
					local index = typeToIndex[arr[1]]

					if index then
						effectArr[index].nextVal = arr[2]
					else
						table.insert(effectArr, {
							resType = PinballEnum.ResType.Play,
							nextVal = arr[2],
							text = luaLang("pinball_play_need")
						})
					end
				end
			end
		end
	end

	for _, data in pairs(effectArr) do
		data.haveNext = nextCo
	end

	self._goeffects = self._goeffects or self:getUserDataTb_()

	tabletool.clear(self._goeffects)
	gohelper.CreateObjList(self, self._createEffectItem, effectArr, nil, self._gopreviewitem)
end

function PinballUpgradeView:_createEffectItem(obj, data, index)
	local icon = gohelper.findChildImage(obj, "#image_icon")
	local name = gohelper.findChildTextMesh(obj, "#txt_base")
	local curNum = gohelper.findChildTextMesh(obj, "#txt_curnum")
	local num = gohelper.findChildTextMesh(obj, "#txt_num")
	local effect = gohelper.findChild(obj, "vx_eff")

	table.insert(self._goeffects, effect)

	local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][data.resType]

	if not resCo then
		logError("资源配置不存在" .. data.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(icon, resCo.icon)

	name.text = data.text or resCo.name

	if data.haveNext then
		curNum.text = string.format("%d", data.value or 0)

		local add = (data.nextVal or 0) - (data.value or 0)

		num.text = add >= 0 and string.format("<color=#BCFF85>+%s", add) or string.format("<color=#FC8A6A>%s", add)
	else
		curNum.text = ""
		num.text = string.format("%d", data.value)
	end
end

function PinballUpgradeView:updateCost(data)
	local costArr = {}
	local cost = data.cost

	if not string.nilorempty(cost) then
		local dict = GameUtil.splitString2(cost, true)

		for _, arr in pairs(dict) do
			table.insert(costArr, {
				resType = arr[1],
				value = arr[2]
			})
		end
	end

	self._costNoEnough = nil

	gohelper.CreateObjList(self, self._createCostItem, costArr, nil, self._gocostitem)
end

function PinballUpgradeView:checkLock(nextCo, isToast)
	if not nextCo then
		return
	end

	local condition = nextCo.condition

	if string.nilorempty(condition) then
		return false
	end

	local dict = GameUtil.splitString2(condition, true)

	for _, arr in pairs(dict) do
		local type = arr[1]

		if type == PinballEnum.ConditionType.Talent then
			local talentId = arr[2]

			if not PinballModel.instance:getTalentMo(talentId) then
				if isToast then
					local talentCo = lua_activity178_talent.configDict[VersionActivity2_4Enum.ActivityId.Pinball][talentId]

					GameFacade.showToast(ToastEnum.Act178TalentCondition, talentCo.name)
				end

				return true
			end
		elseif type == PinballEnum.ConditionType.Score then
			local value = arr[2]

			if value > PinballModel.instance.maxProsperity then
				if isToast then
					local lv = PinballConfig.instance:getScoreLevel(VersionActivity2_4Enum.ActivityId.Pinball, value)

					GameFacade.showToast(ToastEnum.Act178ScoreCondition, lv)
				end

				return true
			end
		end
	end

	return false
end

function PinballUpgradeView:_createCostItem(obj, data, index)
	local num = gohelper.findChildTextMesh(obj, "#txt_num")
	local icon = gohelper.findChildImage(obj, "#txt_num/#image_icon")
	local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][data.resType]

	if not resCo then
		logError("资源配置不存在" .. data.resType)

		return
	end

	UISpriteSetMgr.instance:setAct178Sprite(icon, resCo.icon)

	local color = ""

	if data.value > PinballModel.instance:getResNum(data.resType) then
		color = "<color=#FC8A6A>"
		self._costNoEnough = self._costNoEnough or resCo.name
	end

	num.text = string.format("%s-%d", color, data.value)
end

function PinballUpgradeView:removeBuilding()
	PinballController.instance:removeBuilding(self.viewParam.index)
end

function PinballUpgradeView:upgradeBuilding()
	local buildingInfo = PinballModel.instance:getBuildingInfo(self.viewParam.index)

	if not buildingInfo then
		return
	end

	if self._costNoEnough then
		GameFacade.showToast(ToastEnum.DiamondBuy, self._costNoEnough)

		return
	end

	if self:checkLock(buildingInfo.nextCo, true) then
		return
	end

	Activity178Rpc.instance:sendAct178Build(VersionActivity2_4Enum.ActivityId.Pinball, buildingInfo.configId, PinballEnum.BuildingOperType.Upgrade, self.viewParam.index)
end

function PinballUpgradeView:_buildingUpdate(index)
	if index == self.viewParam.index then
		gohelper.setActive(self._goeffect, false)
		gohelper.setActive(self._goeffect, true)

		for _, effect in pairs(self._goeffects) do
			gohelper.setActive(effect, false)
			gohelper.setActive(effect, true)
		end

		AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio34)
		UIBlockMgr.instance:startBlock("PinballUpgradeView_Effect")
		TaskDispatcher.runDelay(self._effectEnd, self, 1)
	end
end

function PinballUpgradeView:_effectEnd()
	UIBlockMgr.instance:endBlock("PinballUpgradeView_Effect")
	self:_refreshBuilding()
end

function PinballUpgradeView:onClose()
	TaskDispatcher.cancelTask(self._effectEnd, self)
	UIBlockMgr.instance:endBlock("PinballUpgradeView_Effect")
end

function PinballUpgradeView:_buildingRemove(index)
	if index == self.viewParam.index then
		self:closeThis()
	end
end

return PinballUpgradeView
