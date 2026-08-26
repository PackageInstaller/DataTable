-- chunkname: @modules/logic/survival/view/map/SurvivalMapSelectView.lua

module("modules.logic.survival.view.map.SurvivalMapSelectView", package.seeall)

local SurvivalMapSelectView = class("SurvivalMapSelectView", SurvivalInitTeamView)

function SurvivalMapSelectView:onInitView()
	SurvivalMapSelectView.super.onInitView(self)

	self._btnnext = gohelper.findChildButtonWithAudio(self._root, "Right/#btn_next")
	self._txttitle = gohelper.findChildTextMesh(self._root, "Right/txt_title")
	self._imagePic = gohelper.findChildSingleImage(self._root, "Right/simage_pic")
	self._txtdesc = gohelper.findChildTextMesh(self._root, "Right/scroll_desc/Viewport/#go_descContent/#txt_desc")
	self._goeffectdesc = gohelper.findChild(self._root, "Right/scroll_desc/Viewport/#go_descContent/go_descitem/#txt_desc")
	self._goeasy = gohelper.findChild(self._root, "Right/#go_difficulty/easy")
	self._gonormal = gohelper.findChild(self._root, "Right/#go_difficulty/normal")
	self._gohard = gohelper.findChild(self._root, "Right/#go_difficulty/hard")
	self._gohardEffect = gohelper.findChild(self.viewGO, "#simage_bghard")
	self._go_recommend = gohelper.findChild(self._root, "Right/#go_recommend")
	self.weather = gohelper.findChild(self._root, "Right/scroll_desc/Viewport/#go_descContent/weather")
	self.go_daytime = gohelper.findChild(self.weather, "#go_daytime")
	self.go_night = gohelper.findChild(self.weather, "#go_night")

	local scrollParam = GameFacade.createSimpleListParam(SurvivalMapSelectDayItem, true)

	self.daySelectList = GameFacade.createSimpleListComp(self.weather, scrollParam, nil, self.viewContainer)

	self.daySelectList:setOnSelectChange(self.onDaySelectSelectChange, self)
	self.daySelectList:addCustomItem(self.go_daytime)
	self.daySelectList:addCustomItem(self.go_night)

	local cfgDic = lua_survival_map_group.configDict

	self.mapName = {
		cfgDic[10000].name,
		cfgDic[20000].name,
		cfgDic[30000].name,
		cfgDic[40000].name,
		cfgDic[50000].name,
		cfgDic[60000].name
	}
	SurvivalMapModel.instance.dayMode = nil
end

function SurvivalMapSelectView:addEvents()
	self._btnnext:AddClickListener(self.onClickNext, self)
end

function SurvivalMapSelectView:removeEvents()
	self._btnnext:RemoveClickListener()
end

function SurvivalMapSelectView:onOpen()
	self._groupMo = SurvivalMapModel.instance:getInitGroup()

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	self._items = {}
	self.maxRichness = nil

	for index = 1, 6 do
		local mapInfo = weekMo.mapInfos[index]

		if mapInfo then
			local groupCo = mapInfo.groupCo

			if self.maxRichness == nil or groupCo.mapRichness > self.maxRichness then
				self.maxRichness = groupCo.mapRichness
			end
		end
	end

	for index = 1, 6 do
		local mapInfo = weekMo.mapInfos[index]
		local go = gohelper.findChild(self._root, "Map/version3.4/#go_map" .. index)

		self._items[index] = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalMapSelectItem, {
			callback = self.onClickMap,
			callobj = self,
			mapInfo = mapInfo,
			index = index,
			maxRichness = self.maxRichness,
			name = self.mapName[index]
		})
	end

	self:onClickMap(self._groupMo.selectMapIndex + 1, true)
	self.daySelectList:setData({
		{},
		{}
	})
	self.daySelectList:setSelect(1)
end

function SurvivalMapSelectView:onDaySelectSelectChange()
	self:_refreshInfo()
end

function SurvivalMapSelectView:onClickMap(index, isFirst)
	if not isFirst and self._groupMo.selectMapIndex == index - 1 then
		return
	end

	if not isFirst then
		self.viewContainer:playAnim("right_out")
		TaskDispatcher.runDelay(self._delayPlayIn, self, 0.1)
		UIBlockHelper.instance:startBlock("SurvivalMapSelectView_switch", 0.1)
	else
		self:_refreshInfo()
	end

	self._groupMo.selectMapIndex = index - 1

	for key, item in ipairs(self._items) do
		item:setIsSelect(key == index)
	end
end

function SurvivalMapSelectView:_delayPlayIn()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_switch)
	self.viewContainer:playAnim("right_in")
	self:_refreshInfo()
end

function SurvivalMapSelectView:_refreshInfo()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()
	local mapInfo = weekMo.mapInfos[self._groupMo.selectMapIndex + 1]
	local mapCo = mapInfo.groupCo

	if not mapCo then
		logError("没有地图组配置" .. mapInfo.mapId)

		return
	end

	self._imagePic:LoadImage(ResUrl.getSurvivalMapIcon("survival_map_pic0" .. mapCo.type))

	self._txttitle.text = mapCo.name

	if mapInfo.taskCo then
		self._txtdesc.text = mapInfo.taskCo.desc2 or ""
	end

	local arr = string.split(mapCo.effectDesc, "|") or {}
	local num = #mapInfo.disasterIds

	if num > 0 then
		for i, disasterCo in ipairs(mapInfo.disasterCos) do
			table.insert(arr, 1, disasterCo.disasterDesc)
		end
	elseif num == 0 then
		local _, desc = SurvivalConfig.instance:getConstValue(SurvivalEnum.ConstId.NoDisasterDesc)

		if not string.nilorempty(desc) then
			table.insert(arr, 1, desc)
		end
	end

	if mapInfo.rainCo then
		table.insert(arr, 1, mapInfo.rainCo.rainDesc)
	end

	local dayMode = self:getDayMode()

	if dayMode == 1 then
		local str = lua_survival_const.configDict[6004].value2

		table.insert(arr, 1, str)
	end

	gohelper.setActive(self._goeasy, mapInfo.level == 1)
	gohelper.setActive(self._gonormal, mapInfo.level == 2)
	gohelper.setActive(self._gohard, mapInfo.level == 3)
	gohelper.setActive(self._gohardEffect, mapInfo.level == 3)
	gohelper.CreateObjList(self, self._createEffectDesc, arr, nil, self._goeffectdesc)
	gohelper.setActive(self._go_recommend, mapInfo.groupCo.mapRichness >= self.maxRichness)
end

function SurvivalMapSelectView:_createEffectDesc(obj, data, index)
	local txt = gohelper.findChildTextMesh(obj, "")

	txt.text = data
end

function SurvivalMapSelectView:onClickNext()
	TaskDispatcher.cancelTask(self._delayPlayIn, self)
	self.viewContainer:playAnim("go_selectmember")

	SurvivalMapModel.instance.dayMode = self:getDayMode()

	self.viewContainer:nextStep()
end

function SurvivalMapSelectView:getDayMode()
	local daySelect = self.daySelectList:getSelect()

	if daySelect == 1 then
		return 0
	else
		return 1
	end
end

function SurvivalMapSelectView:onClose()
	TaskDispatcher.cancelTask(self._delayPlayIn, self)
	SurvivalMapSelectView.super.onClose(self)
end

return SurvivalMapSelectView
