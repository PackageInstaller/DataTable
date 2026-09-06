-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/RarepropsView.lua

module("logic.extensions.bonus.view.xiaonuobirthday.RarepropsView", package.seeall)

local RarepropsView = class("RarepropsView", ViewComponent)

function RarepropsView:ctor()
	RarepropsView.super.ctor(self)
end

function RarepropsView:unbindEvents()
	RarepropsView.super.unbindEvents(self)
end

function RarepropsView:bindEvents()
	RarepropsView.super.bindEvents(self)
end

function RarepropsView:buildUI()
	RarepropsView.super.buildUI(self)

	self._cellList = {}
	self._itemList = {}

	for i = 1, 100 do
		local cell = self:getGo("cell_" .. i)

		if cell == nil then
			break
		end

		table.insert(self._cellList, cell)
	end
end

function RarepropsView:onExit()
	RarepropsView.super.onExit(self)

	for i, item in ipairs(self._itemList) do
		MaterialMgr.resetAll(item)
	end
end

function RarepropsView:onEnter()
	RarepropsView.super.onEnter(self)

	local list = XiaonuoBirthConfig.instance:getItemsList()

	for i, cell in ipairs(self._cellList) do
		local txtTitle = goutil.findChildTextComponent(cell, "con/txtTitle")
		local goBtn = goutil.findChild(cell, "con/goBtn")
		local data = list[i]

		if data then
			txtTitle.text = data.desc

			GameUtil.addClickHandler(goBtn, function()
				GotoMgr.gotoByString(data.jumpTo)
			end)

			local itemCfgArr = string.split(data.item, "#")

			for i, cfg in ipairs(itemCfgArr) do
				local item = goutil.findChild(cell, "items/item_" .. i)

				MaterialMgr.setCellByCfg(cfg, item)
				table.insert(self._itemList, item)
			end
		end
	end
end

return RarepropsView
