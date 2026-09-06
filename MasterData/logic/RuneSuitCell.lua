-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/rune/RuneSuitCell.lua

module("logic.extensions.material.proxy.rune.RuneSuitCell", package.seeall)

local RuneSuitCell = class("RuneSuitCell", MaterialCell)

function RuneSuitCell:ctor(target)
	RuneSuitCell.super.ctor(self, target)

	self.btnBg = goutil.findChild(self.target, "btnBg")
	self.imgBg = goutil.findChild(self.target, "imgBg")
	self.itemrune = goutil.findChild(self.target, "itemrune")
	self.runeLine = goutil.findChild(self.target, "runeLine")
	self._script = self.itemrune:GetComponent("TestRecordPos")
	self._scriptLine = self.runeLine:GetComponent("TestRecordPos")
	self.items = {}

	for i = 1, 30 do
		local item = goutil.findChild(self.target, "itemrune/star_" .. i)

		if item then
			table.insert(self.items, item)
		end
	end

	self.lastSelected = nil

	GameUtil.addClickHandler(self.btnBg, self._OnClick, self)
end

function RuneSuitCell:setItemView(idx, data)
	local container = self.items[idx]

	if container then
		local position = self.cfg.position
		local type = position[idx]
		local img = goutil.findChild(container, "img")
		local imgState = GameUtil.getUIImageSpriteChange(img)

		GameUtil.SetActive(img, false)

		local star = goutil.findChild(container, "star")
		local item = goutil.findChild(container, "star/item")
		local temIcon = goutil.findChildImageComponent(container, "star/item/icon")
		local iconState = GameUtil.getUIImageSpriteChange(temIcon)
		local txtLevel = goutil.findChildTextComponent(container, "star/txtLevel")
		local btnAdd = goutil.findChild(container, "star/btnAdd")
		local icon = goutil.findChild(container, "star/icon")

		GameUtil.addClickHandler(container, GameUtil.handler(self.onClickItem, self, idx, data, container))
		GameUtil.SetActive(btnAdd, true)
		GameUtil.SetActive(txtLevel, true)
		GameUtil.SetActive(item, true)
		GameUtil.SetActive(icon, true)

		if data then
			GameUtil.SetActive(btnAdd, false)
			GameUtil.SetActive(item, false)
			MaterialMgr.setIcon(icon, MatType.Rune, data:getDefineId())

			txtLevel.text = data.level
		else
			imgState:SetState(0)

			if type == -1 or type == nil then
				iconState:SetState(0)
			else
				iconState:SetState(type)
			end

			GameUtil.SetActive(icon, false)
			GameUtil.SetActive(txtLevel, false)
		end
	end
end

function RuneSuitCell:setData(data)
	RuneSuitCell.super.setData(self, data)

	local slots = data.slots

	for k, v in pairs(slots) do
		local posId = v.posId + 1
		local mo = v:getRuneMo()

		self:setItemView(posId, mo)
	end
end

function RuneSuitCell:setCfgData(cfg)
	RuneSuitCell.super.setCfgData(self, cfg)
	self._script:LoadPlan(checknumber(cfg.suitId) - 1)
	self._scriptLine:LoadPlan(checknumber(cfg.suitId) - 1)
	uGuiUtil.setSpriteToImage(self.imgBg.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getXinshenIconUrl(cfg.suitId))

	for i, v in ipairs(self.items) do
		self:setItemView(i, nil)
	end
end

function RuneSuitCell:setClickItemCallBack(cb)
	self.clickItemCallback = cb
end

function RuneSuitCell:onClickItem(posIdx, data, container)
	GameUtil.callBack(self.clickItemCallback, posIdx, data, container)
end

function RuneSuitCell:showSelected(posIdx, view)
	if self.lastSelected then
		self:clearEff()
	end

	self.lastSelected = posIdx

	local container = self.items[posIdx]

	if container then
		local effPath = "fx_ui_zhuangbeijiemian/fx_ui_zhuangbeijiemian_quan.prefab"

		self.attrEff = self:playCellEffect(effPath, container, function(finishHandlerTarget, eff)
			eff:setScale(3)
		end)
	end
end

function RuneSuitCell:clearEff()
	if self.attrEff then
		UIEffectManager.instance:stopEffect(self.attrEff)

		self.attrEff = nil
	end
end

function RuneSuitCell:_OnClick()
	GameUtil.callBack(self.callback, self)
end

function RuneSuitCell:setAllItemActive(boo)
	for k, container in pairs(self.items) do
		local img = goutil.findChild(container, "img")
		local star = goutil.findChild(container, "star")

		GameUtil.SetActive(star, checkbool(boo))
		GameUtil.SetActive(img, not checkbool(boo))
	end
end

function RuneSuitCell:getItemsCallBack(callBack)
	GameUtil.callBack(callBack, self.items)
end

function RuneSuitCell:dispose()
	RuneSuitCell.super.dispose(self)
	self:setAllItemActive(true)
	self:clearEff()
	uGuiUtil.clearImage(self.imgBg)

	self.clickItemCallback = nil
	self.lastSelected = nil
end

return RuneSuitCell
