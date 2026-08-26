-- chunkname: @modules/logic/gm/view/FightGMDouQuQuTestSelectItem.lua

module("modules.logic.gm.view.FightGMDouQuQuTestSelectItem", package.seeall)

local FightGMDouQuQuTestSelectItem = class("FightGMDouQuQuTestSelectItem", FightBaseView)

function FightGMDouQuQuTestSelectItem:onInitView()
	self._btnSelect = gohelper.findChildClickWithDefaultAudio(self.viewGO, "btn")
	self._selected = gohelper.findChild(self.viewGO, "select")
	self._text = gohelper.findChildText(self.viewGO, "Text")
end

function FightGMDouQuQuTestSelectItem:addEvents()
	self:com_registClick(self._btnSelect, self._onBtnSelect)
end

function FightGMDouQuQuTestSelectItem:_onBtnSelect()
	local selfIndex = self:getSelfIndex()

	if self.listType == "_enemySelectedList" or self.listType == "_playerSelectedList" then
		self.PARENT_VIEW[self.listType]:removeIndex(selfIndex)

		if self.listType == "_enemySelectedList" then
			if not self.PARENT_VIEW._enemySelectList then
				local list = self.PARENT_VIEW._playerSelectList
				local index = 0

				for i, v in ipairs(list) do
					if v.config.robotId < self.config.robotId then
						index = index + 1
					end
				end

				index = index + 1

				local item = list:addIndex(index, self.config)

				gohelper.setSibling(item.GAMEOBJECT, index - 1)
			end
		end
	else
		if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) then
			local lastIndex = self.ITEM_LIST_MGR.lastSelectIndex

			if lastIndex and lastIndex < #self.ITEM_LIST_MGR and lastIndex > 0 then
				local min = math.min(lastIndex, selfIndex)
				local max = math.max(lastIndex, selfIndex)

				for i = min, max do
					if not self.ITEM_LIST_MGR[i].selecting then
						self.ITEM_LIST_MGR[i].selecting = true

						gohelper.setActive(self.ITEM_LIST_MGR[i]._selected, true)
					end
				end

				self.ITEM_LIST_MGR.lastSelectIndex = selfIndex

				return
			end
		end

		self.selecting = not self.selecting

		gohelper.setActive(self._selected, self.selecting)

		self.ITEM_LIST_MGR.lastSelectIndex = selfIndex
	end
end

function FightGMDouQuQuTestSelectItem:onRefreshItemData(config)
	gohelper.setSibling(self.viewGO, self:getSelfIndex() - 1)

	self.listType = self.ITEM_LIST_MGR.listType
	self.selecting = false

	gohelper.setActive(self._selected, self.selecting)

	self.config = config

	local name = ""

	for i = 1, 4 do
		local id = config["role" .. i]

		if id ~= 0 then
			local cfg = lua_activity174_test_role.configDict[id]

			if i > 1 then
				name = name .. "+"
			end

			if cfg then
				name = name .. cfg.name
			else
				logError("测试人物表 找不到id:" .. id)
			end
		end
	end

	self._text.text = config.robotId .. " " .. name
end

function FightGMDouQuQuTestSelectItem:onDestructor()
	return
end

return FightGMDouQuQuTestSelectItem
