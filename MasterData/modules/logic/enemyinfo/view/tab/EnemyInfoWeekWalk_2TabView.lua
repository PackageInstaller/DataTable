-- chunkname: @modules/logic/enemyinfo/view/tab/EnemyInfoWeekWalk_2TabView.lua

module("modules.logic.enemyinfo.view.tab.EnemyInfoWeekWalk_2TabView", package.seeall)

local EnemyInfoWeekWalk_2TabView = class("EnemyInfoWeekWalk_2TabView", UserDataDispose)

function EnemyInfoWeekWalk_2TabView:onInitView()
	self.goweekwalktab = gohelper.findChild(self.viewGO, "#go_tab_container/#go_weekwalkhearttab")
	self.simagebattlelistbg = gohelper.findChildSingleImage(self.goweekwalktab, "#simage_battlelistbg")
	self.gobattleitem = gohelper.findChild(self.goweekwalktab, "scroll_battle/Viewport/battlelist/#go_battlebtntemplate")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EnemyInfoWeekWalk_2TabView:addEvents()
	return
end

function EnemyInfoWeekWalk_2TabView:removeEvents()
	return
end

function EnemyInfoWeekWalk_2TabView:_editableInitView()
	gohelper.setActive(self.gobattleitem, false)
end

function EnemyInfoWeekWalk_2TabView:onOpen()
	self._mapId = self.viewParam.mapId

	local info = WeekWalk_2Model.instance:getInfo()
	local mapInfo = info:getLayerInfo(self._mapId)
	local battleIds = mapInfo.battleIds

	if not self.viewParam.selectBattleId then
		self._battleIds = battleIds
		self._btnList = {}
		self._statusList = {}

		local showIndex = 5

		showIndex = math.min(showIndex, #mapInfo.battleInfos)

		local mapMaxStarNum = WeekWalk_2Enum.MaxStar

		for i = 1, showIndex do
			local container = gohelper.cloneInPlace(self.gobattleitem)
			local go = container.gameObject
			local btn = gohelper.findChildButton(go, "btn")
			local txt = gohelper.findChildText(go, "txt")
			local selectIcon = gohelper.findChild(go, "selectIcon")

			txt.text = "0" .. i

			local battleId = battleIds[i]
			local battleInfo = mapInfo:getBattleInfoByBattleId(battleId)
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

				image.enabled = false

				local icon1Effect = self.tabParentView:getResInst(self.viewContainer._viewSetting.otherRes.weekwalkheart_star, image.gameObject)

				WeekWalk_2Helper.setCupEffect(icon1Effect, battleInfo:getCupInfo(index))
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

function EnemyInfoWeekWalk_2TabView:selectBattleId(battleId)
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

function EnemyInfoWeekWalk_2TabView:onClose()
	return
end

function EnemyInfoWeekWalk_2TabView:onDestroyView()
	self.simagebattlelistbg:UnLoadImage()

	if self._btnList then
		for _, v in ipairs(self._btnList) do
			v:RemoveClickListener()
		end
	end
end

return EnemyInfoWeekWalk_2TabView
