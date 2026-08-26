-- chunkname: @modules/logic/survival/view/shelter/SurvivalReportView.lua

module("modules.logic.survival.view.shelter.SurvivalReportView", package.seeall)

local SurvivalReportView = class("SurvivalReportView", BaseView)

function SurvivalReportView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._simagePanelBG = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_PanelBG")
	self._simagePanelBG1 = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_PanelBG1")
	self._simagePanelBG2 = gohelper.findChildSingleImage(self.viewGO, "Panel/#simage_PanelBG2")
	self._scrollcontentlist = gohelper.findChildScrollRect(self.viewGO, "#scroll_contentlist")
	self._txtdec1 = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#txt_dec1")
	self._goNpc = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Npc")
	self._txtNpc = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Npc/#txt_Npc")
	self._goNpcNew = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_NpcNew")
	self._txtNpcNew = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_NpcNew/#txt_NpcNew")
	self._goMonster = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Monster")
	self._txtMonster = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Monster/#txt_Monster")
	self._goBuilding = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Building")
	self._txtBuilding = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Building/#txt_Building")
	self._goTask = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Task")
	self._txtTask = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Task/#txt_Task")
	self._goTaskScore = gohelper.findChild(self.viewGO, "#scroll_contentlist/viewport/content/#go_Task/#go_TaskScore")
	self._txtnpcScore = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#go_Task/#go_TaskScore/#txt_npcScore")
	self._txtdec2 = gohelper.findChildText(self.viewGO, "#scroll_contentlist/viewport/content/#txt_dec2")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SurvivalReportView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SurvivalReportView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function SurvivalReportView:_btncloseOnClick()
	self:closeThis()
end

function SurvivalReportView:_editableInitView()
	return
end

function SurvivalReportView:onUpdateParam()
	return
end

function SurvivalReportView:onClickModalMask()
	self:_btncloseOnClick()
end

function SurvivalReportView:onOpen()
	local report = SurvivalModel.instance:getDailyReport()

	self._report = nil

	if not string.nilorempty(report) then
		self._report = cjson.decode(report)
	end

	SurvivalModel.instance:setDailyReport()
	self:_initView()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
end

function SurvivalReportView:_initView()
	self:_initNpc()
	self:_initMonster()
	gohelper.setActive(self._goBuilding, false)
	self:_initTask()
	self:_initNpcNew()
end

function SurvivalReportView:_initNpc()
	local desc = luaLang("survivalreportview_npc_empty")

	if self._report ~= nil then
		local leaveNpcIds = self._report.leaveNpcIds

		if leaveNpcIds ~= nil and #leaveNpcIds > 0 then
			local count = #leaveNpcIds
			local npcNameStr = ""

			for i = 1, count do
				local npcId = leaveNpcIds[i]
				local npcCo = SurvivalConfig.instance:getNpcConfig(npcId)

				if npcCo then
					local name = npcCo.name

					npcNameStr = i ~= count and npcNameStr .. name .. "," or npcNameStr .. name
				end
			end

			desc = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survivalreportview_npc"), count, npcNameStr)
		end
	end

	self._txtNpc.text = desc
end

function SurvivalReportView:_initNpcNew()
	local npc2Count = self._report.npc2GetCount
	local count = 0

	if npc2Count then
		count = tabletool.len(npc2Count)
	end

	local allTent = SurvivalShelterTentListModel.instance:getShowList()
	local isFull = true

	for _, tent in pairs(allTent) do
		if tent.buildingInfo and tent.buildingInfo:isBuild() and tent.npcNum < tent.npcCount then
			isFull = false

			break
		end
	end

	local showNewTip = count > 0 and isFull

	gohelper.setActive(self._goNpcNew, showNewTip)

	if showNewTip then
		local name = ""
		local index = 0

		for npcId, _ in pairs(npc2Count) do
			index = index + 1

			local npcCo = SurvivalConfig.instance:getNpcConfig(tonumber(npcId))

			if npcCo then
				name = name .. npcCo.name .. (index == count and "" or ",")
			end
		end

		if not string.nilorempty(name) then
			self._txtNpcNew.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalreportview_npc_new"), name)
		end
	end
end

function SurvivalReportView:_initMonster()
	local desc = luaLang("survivalreportview_monster_empty")

	if self._report ~= nil then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local intrudeBox = weekInfo.intrudeBox

		if intrudeBox ~= nil then
			local curDay = weekInfo.day + 1
			local createDay = intrudeBox:getNextBossCreateDay(curDay)

			desc = curDay == createDay and luaLang("survivalreportview_monster_today") or GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalreportview_monster"), createDay - curDay)
		end
	end

	self._txtMonster.text = desc
end

function SurvivalReportView:_initBuilding()
	local desc = luaLang("survivalreportview_build_empty")

	if self._report ~= nil then
		local desBuildingIds = self._report.desBuildingIds
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

		if desBuildingIds ~= nil and #desBuildingIds > 0 then
			local count = #desBuildingIds
			local desBuildingStr = ""

			for i = 1, count do
				local buildId = desBuildingIds[i]
				local buildMo = weekInfo:getBuildingInfo(buildId)

				if buildMo then
					local buildCo = buildMo.baseCo

					if buildCo then
						local name = buildCo.name

						desBuildingStr = i ~= count and desBuildingStr .. name .. "," or desBuildingStr .. name
					end
				end
			end

			if not string.nilorempty(desBuildingStr) then
				desc = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalreportview_build"), desBuildingStr)
			end
		end
	end

	self._txtBuilding.text = desc
end

function SurvivalReportView:_initTask()
	local desc

	if self._report ~= nil then
		local totalScore = self._report.totalScore

		if totalScore ~= nil and totalScore > 0 then
			local itemId2Count = self._report.itemId2Count
			local npc2Count = self._report.npc2GetCount
			local buildItemCount, foodItemCount, equipCount, goldCount, otherCount = 0, 0, 0, 0, 0

			for itemId, count in pairs(itemId2Count) do
				local itemConfig = lua_survival_item.configDict[tonumber(itemId)]

				if itemConfig then
					if itemConfig.type == SurvivalEnum.ItemType.Equip then
						equipCount = equipCount + count
					elseif itemConfig.type == SurvivalEnum.ItemType.Currency then
						if itemConfig.subType == SurvivalEnum.CurrencyType.Gold then
							goldCount = goldCount + count
						elseif itemConfig.subType == SurvivalEnum.CurrencyType.Build then
							buildItemCount = buildItemCount + count
						elseif itemConfig.subType == SurvivalEnum.CurrencyType.Food then
							foodItemCount = foodItemCount + count
						else
							otherCount = otherCount + count
						end
					else
						otherCount = otherCount + count
					end
				end
			end

			local scoreDesc = ""

			local function appendScoreDesc(value, langKey)
				if value > 0 then
					scoreDesc = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("survival_report_score"), scoreDesc, GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(langKey), value))
				end
			end

			appendScoreDesc(buildItemCount, "survivalreportview_score_buildItem")
			appendScoreDesc(foodItemCount, "survivalreportview_score_foodItem")
			appendScoreDesc(equipCount, "survivalreportview_score_equipItem")
			appendScoreDesc(goldCount, "survivalreportview_score_goldItem")
			appendScoreDesc(otherCount, "survivalreportview_score_otherItem")
			appendScoreDesc((npc2Count ~= nil or nil) and tabletool.len(npc2Count), "survivalreportview_score_npc")

			if not string.nilorempty(scoreDesc) then
				desc = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang((SurvivalMapModel.instance.result == SurvivalEnum.MapResult.Win or nil) and "survivalreportview_score_success"), scoreDesc, totalScore)
			end
		end
	end

	if desc ~= nil then
		self._txtTask.text = desc
		self._txtnpcScore.text = self._report.totalScore
	end

	gohelper.setActive(self._goTask, desc ~= nil)
end

function SurvivalReportView:onClose()
	return
end

function SurvivalReportView:onDestroyView()
	return
end

return SurvivalReportView
