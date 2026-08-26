-- chunkname: @modules/logic/partygame/view/splicingroad/SplicingRoadPlayerAnswerItem.lua

module("modules.logic.partygame.view.splicingroad.SplicingRoadPlayerAnswerItem", package.seeall)

local SplicingRoadPlayerAnswerItem = class("SplicingRoadPlayerAnswerItem", LuaCompBase)

function SplicingRoadPlayerAnswerItem:ctor(param)
	self._index = param.index
end

local wrapIndex = {
	nil,
	4,
	7,
	nil,
	nil,
	8
}

function SplicingRoadPlayerAnswerItem:init(go)
	self._anim = gohelper.findComponentAnim(go)
	self._goselect = gohelper.findChild(go, "select")
	self._btn = gohelper.findButtonWithAudio(go)

	local item = gohelper.findChild(go, "grids/item")

	self._itemSelects = self:getUserDataTb_()

	for i = 1, 9 do
		local cloneItem = gohelper.cloneInPlace(item, "item" .. i)

		self._itemSelects[i] = gohelper.findChild(cloneItem, "select")
	end

	for k, v in pairs(wrapIndex) do
		self._itemSelects[k], self._itemSelects[v] = self._itemSelects[v], self._itemSelects[k]
	end

	gohelper.setActive(item, false)

	self._headIcons = self:getUserDataTb_()
	self._headArrow = self:getUserDataTb_()
	self._headColors = self:getUserDataTb_()
	self._headModels = {}

	local headItem = gohelper.findChild(go, "headitem")

	for i = 1, 2 do
		local root = gohelper.findChild(go, "heads" .. i)

		for j = 1, 2 do
			local newItem = gohelper.clone(headItem, root)
			local index = j + (i - 1) * 2

			self._headIcons[index] = newItem
			self._headArrow[index] = gohelper.findChild(newItem, "arrow")
			self._headColors[index] = gohelper.findChildImage(newItem, "#image_color")
			self._headModels[index] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(newItem, "#image_head/#go_model"), CommonPartyGamePlayerSpineComp)

			self._headModels[index]:enableSpineUpdate(false)
		end
	end

	gohelper.setActive(headItem, false)
end

function SplicingRoadPlayerAnswerItem:addEventListeners()
	self._btn:AddClickListener(self._onSelectItem, self)
end

function SplicingRoadPlayerAnswerItem:removeEventListeners()
	self._btn:RemoveClickListener()
end

function SplicingRoadPlayerAnswerItem:_onSelectItem()
	PartyGameEnum.CommandUtil.CreateButtonCommand(PartyGameEnum.VirtualButtonId["button" .. self._index])
end

function SplicingRoadPlayerAnswerItem:updateAnswer(cfgId)
	if self._cfgId == cfgId then
		return
	end

	self._cfgId = cfgId

	local co = lua_partygame_splicingroad.configDict[cfgId]

	if not co then
		return
	end

	local count = 0

	for num in co.map:gmatch("%d+") do
		count = count + 1

		gohelper.setActive(self._itemSelects[count], num == "1")
	end
end

function SplicingRoadPlayerAnswerItem:updateSelects(selectPlayerMos)
	selectPlayerMos = selectPlayerMos or {}

	local mainPlayerIndex
	local len = #selectPlayerMos

	for k, v in ipairs(selectPlayerMos) do
		if v:isMainPlayer() then
			mainPlayerIndex = k

			break
		end
	end

	if mainPlayerIndex then
		if len > 2 and mainPlayerIndex ~= 3 then
			selectPlayerMos[mainPlayerIndex], selectPlayerMos[3] = selectPlayerMos[3], selectPlayerMos[mainPlayerIndex]
		elseif len <= 2 and mainPlayerIndex ~= 1 then
			selectPlayerMos[mainPlayerIndex], selectPlayerMos[1] = selectPlayerMos[1], selectPlayerMos[mainPlayerIndex]
		end
	end

	for i = 1, 4 do
		gohelper.setActive(self._headIcons[i], selectPlayerMos[i])

		if selectPlayerMos[i] then
			local _, color = selectPlayerMos[i]:getColorName()

			gohelper.setActive(self._headArrow[i], selectPlayerMos[i]:isMainPlayer())
			ZProj.UGUIHelper.SetGrayscale(self._headIcons[i], len > 1)
			self._headModels[i]:initSpine(selectPlayerMos[i].uid)

			self._headColors[i].color = color
		end
	end

	self:updateMainPlayerIndex(mainPlayerIndex)
end

function SplicingRoadPlayerAnswerItem:updateMainPlayerIndex(index)
	if index == self._selectIndex then
		return
	end

	self._selectIndex = index

	self._anim:Play(index and "select" or "unselect")
end

return SplicingRoadPlayerAnswerItem
