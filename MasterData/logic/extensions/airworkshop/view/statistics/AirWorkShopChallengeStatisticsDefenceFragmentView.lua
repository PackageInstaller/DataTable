-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/statistics/AirWorkShopChallengeStatisticsDefenceFragmentView.lua

module("logic.extensions.airworkshop.view.statistics.AirWorkShopChallengeStatisticsDefenceFragmentView", package.seeall)

local M = class("AirWorkShopChallengeStatisticsDefenceFragmentView", StaticFragmentView)

M.LoopLstTyp = {
	Kill = 2,
	BeKill = 3,
	DefenceHero = 1
}

function M:ctor(mainGO, viewPresentor)
	M.super.ctor(self, mainGO)

	self._viewPresentor = viewPresentor
end

function M:buildUI()
	self._loopLst = {}
	self._loopLst[self.LoopLstTyp.DefenceHero] = LoopListHelper.New(self:getGo("challenge_schema_statistics_tips_39681044"))

	self._loopLst[self.LoopLstTyp.DefenceHero]:InitListView(0, self._onCellUpdate, self)

	self._loopLst[self.LoopLstTyp.Kill] = LoopListHelper.New(self:getGo("challenge_schema_statistics_tips_841243585"))

	self._loopLst[self.LoopLstTyp.Kill]:InitListView(0, self._onCellKillUpdate, self)

	self._loopLst[self.LoopLstTyp.BeKill] = LoopListHelper.New(self:getGo("challenge_schema_statistics_tips_293775065"))

	self._loopLst[self.LoopLstTyp.BeKill]:InitListView(0, self._onCellShutDownUpdate, self)
end

function M:destroyUI()
	for typ, loopLst in pairs(self._loopLst or {}) do
		loopLst:Dispose()

		loopLst = nil
	end

	self._loopLst = nil

	for _, comps in pairs(self._cellComps or {}) do
		if comps.btnClick then
			comps.btnClick:RemoveClickListener()
		end
	end

	self._cellComps = nil
	self._cellCompsKill = nil
	self._cellCompsShutDown = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:refreshView()
end

function M:onExit()
	self:setDefLastSelectedIndex(nil)
end

function M:getMainGO()
	return self.mainGO
end

function M:getLoopLst(typ)
	return self._loopLst[typ]
end

function M:getDataLst(typ, index)
	index = index and index or 0

	local len = self._dataLst and #self._dataLst or 0
	local dataLst

	if len == 0 then
		return dataLst
	end

	if typ == self.LoopLstTyp.DefenceHero then
		dataLst = self._dataLst
	elseif typ == self.LoopLstTyp.Kill then
		dataLst = self._dataLst[index] and self._dataLst[index].kill or nil
	elseif typ == self.LoopLstTyp.BeKill then
		dataLst = self._dataLst[index] and self._dataLst[index].beKill or nil
	end

	return dataLst
end

function M:setData(defDataLst)
	self._dataLst = defDataLst
end

function M:getDefLastSelectedIndex()
	return self._selectDefenceHeroDataIndex
end

function M:setDefLastSelectedIndex(index, refreshLoopLst)
	self._selectDefenceHeroDataIndex = index

	if refreshLoopLst then
		self:refreshLoopLst(self.LoopLstTyp.DefenceHero)
		self:refreshLoopLst(self.LoopLstTyp.Kill)
		self:refreshLoopLst(self.LoopLstTyp.BeKill)
	end
end

function M:refreshView()
	local len = self._dataLst and #self._dataLst or 0

	self:setDefLastSelectedIndex(len > 0 and 1 or nil, true)
end

function M:refreshLoopLst(typ)
	local loopLst = self:getLoopLst(typ)

	if not loopLst then
		printError(string.format("无法找到[%s]的loopLst", typ))

		return
	end

	local lastSelectedIndex = self:getDefLastSelectedIndex() or 0
	local dataLst = self:getDataLst(typ, lastSelectedIndex)
	local len = dataLst and #dataLst or 0

	if len > 0 and lastSelectedIndex > 0 then
		loopLst:SetListItemCount(len, true)
		loopLst:RefreshAllShownItem()
	else
		loopLst:ClearCells()
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local typ = self.LoopLstTyp.DefenceHero
	local loopLst = self:getLoopLst(typ)
	local dataLst = self:getDataLst(typ, self:getDefLastSelectedIndex())
	local data = dataLst[curIndex]
	local prefabName = "item1"
	local item = loopLst:NewListViewItem(prefabName)

	self:_writeData(item.gameObject, curIndex, data)

	return item
end

function M:_onCellKillUpdate(curIndex)
	curIndex = curIndex + 1

	local typ = self.LoopLstTyp.Kill
	local loopLst = self:getLoopLst(typ)
	local dataLst = self:getDataLst(typ, self:getDefLastSelectedIndex())
	local data = dataLst[curIndex]
	local prefabName = "item2"
	local item = loopLst:NewListViewItem(prefabName)

	self:_writeDataKill(item.gameObject, data)

	return item
end

function M:_onCellShutDownUpdate(curIndex)
	curIndex = curIndex + 1

	local typ = self.LoopLstTyp.BeKill
	local loopLst = self:getLoopLst(typ)
	local dataLst = self:getDataLst(typ, self:getDefLastSelectedIndex())
	local data = dataLst[curIndex]
	local prefabName = "item3"
	local item = loopLst:NewListViewItem(prefabName)

	self:_writeDataShutDown(item.gameObject, data)

	return item
end

function M:_writeData(go, curIndex, data)
	if not self._cellComps then
		self._cellComps = {}
	end

	local instanceId = go:GetInstanceID()
	local shower = self._cellComps[instanceId]

	if not shower then
		shower = {
			imgHero = goutil.findChildImageComponent(go, "head_item/mask/headIcon"),
			txtHero = goutil.findChildTextComponent(go, "txtPlayerName"),
			goSelect = goutil.findChild(go, "imgSelect").gameObject,
			btnClick = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnClick").gameObject)
		}

		shower.btnClick:AddClickListener(function()
			self:_onClickDefenceHero(shower)
		end, self)

		self._cellComps[instanceId] = shower
	end

	shower.index = curIndex

	self:_setUpHeroInfo(data.heroId, shower.txtHero, shower.imgHero)

	local lastSelectedIndex = self:getDefLastSelectedIndex() or 0

	goutil.setActive(shower.goSelect, curIndex == lastSelectedIndex)
end

function M:_onClickDefenceHero(shower)
	local dataIndex = shower.index
	local lastSelected = self:getDefLastSelectedIndex()

	if lastSelected and lastSelected == dataIndex then
		return
	end

	self:setDefLastSelectedIndex(dataIndex, true)
end

function M:_writeDataKill(go, data)
	if not self._cellCompsKill then
		self._cellCompsKill = {}
	end

	local instanceId = go:GetInstanceID()
	local shower = self._cellCompsKill[instanceId]

	if not shower then
		shower = {
			imgHero = goutil.findChildImageComponent(go, "head_item/mask/headIcon"),
			txtHero = goutil.findChildTextComponent(go, "txtKillName"),
			txtKillNum = goutil.findChildTextComponent(go, "txtkillNums")
		}
		self._cellCompsKill[instanceId] = shower
	end

	shower.txtKillNum.text = data.count

	self:_setUpHeroInfo(data.heroId, shower.txtHero, shower.imgHero)
end

function M:_writeDataShutDown(go, data)
	if not self._cellCompsShutDown then
		self._cellCompsShutDown = {}
	end

	local instanceId = go:GetInstanceID()
	local shower = self._cellCompsShutDown[instanceId]

	if not shower then
		shower = {
			imgHero = goutil.findChildImageComponent(go, "head_item/mask/headIcon"),
			txtHero = goutil.findChildTextComponent(go, "txtDieName"),
			txtShutDown = goutil.findChildTextComponent(go, "txtDieNums")
		}
		self._cellCompsShutDown[instanceId] = shower
	end

	shower.txtShutDown.text = data.count

	self:_setUpHeroInfo(data.heroId, shower.txtHero, shower.imgHero)
end

function M:_setUpHeroInfo(heroId, txtName, imgIcon)
	heroId = heroId and heroId or 0

	local heroName, heroIcon

	if heroId > 0 then
		local heroIntroCfg = PastInfoConfig.instance:getCharacterInfo(heroId)

		if not heroIntroCfg then
			printError(string.format("无法从[t_%s]获取[%s]的配置", ConfigName.CharacterInfo, heroId))
		end

		heroName = heroIntroCfg and heroIntroCfg.name or ""

		local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

		if not cfgCharacter then
			printError(string.format("无法从[t_%s]获取[%s]的配置", ConfigName.Character, heroId))
		end

		heroIcon = cfgCharacter and CharacterCOUtil.getIcon(cfgCharacter) or ""
	end

	if imgIcon and not string.nilorempty(heroIcon) then
		IconLoader.setSprite(imgIcon, IconType.HeadIcon, heroIcon)
	end

	if txtName then
		txtName.text = heroName
	end
end

return M
