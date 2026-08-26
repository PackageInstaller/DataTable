-- chunkname: @modules/logic/enemyinfo/view/tab/EnemyInfoWeekWalkTabView.lua

module("modules.logic.enemyinfo.view.tab.EnemyInfoWeekWalkTabView", package.seeall)

local EnemyInfoWeekWalkTabView = class("EnemyInfoWeekWalkTabView", UserDataDispose)

function EnemyInfoWeekWalkTabView:onInitView()
	self.goweekwalktab = gohelper.findChild(self.viewGO, "#go_tab_container/#go_weekwalktab")
	self.simagebattlelistbg = gohelper.findChildSingleImage(self.goweekwalktab, "#simage_battlelistbg")
	self.gobattleitem = gohelper.findChild(self.goweekwalktab, "scroll_battle/Viewport/battlelist/#go_battlebtntemplate")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EnemyInfoWeekWalkTabView:addEvents()
	return
end

function EnemyInfoWeekWalkTabView:removeEvents()
	return
end

function EnemyInfoWeekWalkTabView:_editableInitView()
	gohelper.setActive(self.gobattleitem, false)
	self.simagebattlelistbg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))
end

function EnemyInfoWeekWalkTabView:onOpen()
	self._mapId = self.viewParam.mapId

	local info = WeekWalkModel.instance:getInfo()
	local mapInfo = info:getMapInfo(self._mapId)
	local battleIds = mapInfo.battleIds

	if not self.viewParam.selectBattleId then
		self._battleIds = battleIds
		self._mapConfig = WeekWalkConfig.instance:getMapConfig(self._mapId)

		local typeConfig = lua_weekwalk_type.configDict[self._mapConfig.type]

		if typeConfig.showDetail <= 0 and mapInfo.isFinish <= 0 then
			gohelper.setActive(self.goweekwalktab, false)
			self.enemyInfoMo:setShowLeftTab(false)
			self:selectBattleId(self.viewParam.selectBattleId)

			return
		end

		self._btnList = {}
		self._statusList = {}

		local showIndex = 5

		showIndex = math.min(showIndex, #mapInfo.battleInfos)

		local mapMaxStarNum = mapInfo:getStarNumConfig()

		for i = 1, showIndex do
			local container = gohelper.cloneInPlace(self.gobattleitem)
			local go = container.gameObject
			local btn = gohelper.findChildButton(go, "btn")
			local txt = gohelper.findChildText(go, "txt")
			local selectIcon = gohelper.findChild(go, "selectIcon")

			txt.text = "0" .. i

			local battleId = battleIds[i]
			local battleInfo = mapInfo:getBattleInfo(battleId)
			local starGo2 = gohelper.findChild(go, "star2")
			local starGo3 = gohelper.findChild(go, "star3")
			local starGo = mapMaxStarNum <= 2 and starGo2 or starGo3

			gohelper.setActive(starGo2, false)
			gohelper.setActive(starGo3, false)
			gohelper.setActive(starGo, true)

			local transform = starGo.transform
			local itemCount = transform.childCount
			local statusTable = {
				selectIcon,
				txt
			}

			for index = 1, itemCount do
				local child = transform:GetChild(index - 1)
				local image = child:GetComponentInChildren(gohelper.Type_Image)

				UISpriteSetMgr.instance:setWeekWalkSprite(image, index <= battleInfo.star and "star_highlight4" or "star_null4", true)
				table.insert(statusTable, image)
			end

			btn:AddClickListener(self.selectBattleId, self, battleId)
			gohelper.setActive(go, true)
			table.insert(self._statusList, statusTable)
			table.insert(self._btnList, btn)
		end

		gohelper.setActive(self.goweekwalktab, true)
		self.enemyInfoMo:setShowLeftTab(true)
		self:selectBattleId(self.viewParam.selectBattleId)
	end
end

function EnemyInfoWeekWalkTabView:selectBattleId(battleId)
	self.enemyInfoMo:updateBattleId(battleId)

	if not self._statusList then
		return
	end

	for i, v in ipairs(self._battleIds) do
		local isSelected = v == battleId
		local t = self._statusList[i]

		if not t then
			break
		end

		gohelper.setActive(t[1], isSelected)

		if isSelected then
			SLFramework.UGUI.GuiHelper.SetColor(t[2], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(t[3], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(t[4], "#FFFFFF")
		else
			SLFramework.UGUI.GuiHelper.SetColor(t[2], "#6c6f64")
			SLFramework.UGUI.GuiHelper.SetColor(t[3], "#C1C5B6")
			SLFramework.UGUI.GuiHelper.SetColor(t[4], "#C1C5B6")
		end

		if t[5] then
			SLFramework.UGUI.GuiHelper.SetColor(t[5], isSelected and "#FFFFFF" or "#C1C5B6")
		end
	end
end

function EnemyInfoWeekWalkTabView:onClose()
	return
end

function EnemyInfoWeekWalkTabView:onDestroyView()
	self.simagebattlelistbg:UnLoadImage()

	if self._btnList then
		for _, v in ipairs(self._btnList) do
			v:RemoveClickListener()
		end
	end
end

return EnemyInfoWeekWalkTabView
