-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleChangeModelDlg.lua

local strClassName = "CircleBattleChangeModelDlg"
local CircleBattleChangeModelDlg = Class(strClassName, UIControls.Window)

function CircleBattleChangeModelDlg:ctor(...)
	self:initUI()
end

function CircleBattleChangeModelDlg:initUI(...)
	self.btnCancel = UIControls.Button(self, "HeroListPanel/FuncPanel/BtnCancel")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.btnSave = UIControls.Button(self, "HeroListPanel/FuncPanel/BtnSave")

	self.btnSave:addEventClick(self.onBtnSaveClick)

	self.scrollView = UIControls.ScrollViewLoopV(self, "HeroListPanel/CardPanel")

	self.scrollView:addEventCellChanged(self.onHeroCellChanged)

	self._slot4CellSelect = Slot(self.onHeroSelect, self)
	self.gridShowHero = UIControls.HeroCardChild(self, "BgSelect/GridHeroCard", "System/Hero/GridHeroCard", 1, 1, true)
	self.selectedHero = nil
end

function CircleBattleChangeModelDlg:onOpen(...)
	CircleBattleChangeModelDlg.super.onOpen(self)

	self.heros = CurAvatar:getCircleBattleHeroList()
	self.selectedHero = self:getChoosingHero()

	self.scrollView:setTotalCount(#self.heros)
	self:_refreshSelectHero()
end

function CircleBattleChangeModelDlg:getChoosingHero(...)
	if CurAvatar.myCircle then
		local modelData = CurAvatar.myCircle:getMyCircleBattleModelData()

		if modelData then
			local sameHeros = {}

			for i, hero in ipairs(self.heros) do
				if hero.id == modelData.resid then
					table.insert(sameHeros, hero)
				end
			end

			if #sameHeros >= 1 then
				local _hero

				for i, hero in ipairs(sameHeros) do
					if hero.skin == modelData.skin then
						_hero = hero

						if hero.base == modelData.base then
							return hero
						end
					end
				end

				return _hero or sameHeros[1]
			end
		end
	end
end

function CircleBattleChangeModelDlg:onHeroCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = UIControls.HeroCardLoop(sender, "System/Hero/GridHeroCard", newIdx, 0, 0)

		targetCell:setSelectCallback(self._slot4CellSelect)
	else
		targetCell.mIndex = newIdx
	end

	local hero = self.heros[newIdx]

	if hero then
		targetCell:setHero(hero)

		targetCell.isDragTip = false

		targetCell.imgStateIcon:setVisible(false)

		targetCell.showSelect = true

		targetCell:setSelected(self.selectedHero ~= nil and self.selectedHero.gid == hero.gid)
	end
end

function CircleBattleChangeModelDlg:onHeroSelect(sender)
	self.selectedHero = sender.hero

	self:_refreshSelectHero()
end

function CircleBattleChangeModelDlg:_refreshSelectHero(...)
	if not self.selectedHero then
		return
	end

	self.gridShowHero:setHero(self.selectedHero)
	self.scrollView:refreshCells()
end

function CircleBattleChangeModelDlg:onBtnSaveClick(...)
	if not self.selectedHero then
		MsgManager.clientNotice(595)

		return
	end

	local hero = self.selectedHero
	local data = {
		resid = hero.id,
		skin = hero.skin,
		base = hero.base
	}

	CurAvatar:tryCallCircleBattleRpc("clanBattleSetModel", hero.gid, data)
end

function CircleBattleChangeModelDlg:onBtnCancelClick(...)
	self:setVisible(false)
end

return CircleBattleChangeModelDlg
