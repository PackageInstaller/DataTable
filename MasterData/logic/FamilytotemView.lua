-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/family/view/FamilytotemView.lua

module("logic.extensions.family.view.FamilytotemView", package.seeall)

local FamilytotemView = class("FamilytotemView", ViewComponent)

function FamilytotemView:ctor()
	FamilytotemView.super.ctor(self)
end

function FamilytotemView:unbindEvents()
	FamilytotemView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function FamilytotemView:bindEvents()
	FamilytotemView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function FamilytotemView:buildUI()
	FamilytotemView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._goldBarCon = self:getGo("goldBarCon")
	self._scrollview = self:getGo("scrollview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._scrollview, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
end

function FamilytotemView:onExit()
	FamilytotemView.super.onExit(self)
	self._scrollList:dispose()
	self:_removeTimer()
end

function FamilytotemView:onEnter()
	FamilytotemView.super.onEnter(self)
	self:_onRefreshUI()
	FamilyController.instance:sendGetFamilyTotemInfoReq()
	self.addGEvent(self, GlobalNotify.FamilyUpdateTotemInfo, self._onRefreshUI, self)

	local btnList = {
		{
			showAdd = true,
			id = MaterialMgr.createSerName(MatType.Coin, MatType.Coin_Family_Money)
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, btnList)
end

function FamilytotemView:_onRefreshUI()
	self._totemMap = {}

	local totemList = FamilyModel.instance:getAllTotemList() or {}

	for i, v in ipairs(totemList) do
		self._totemMap[v.totemId] = v
	end

	local list = FamilyConfig.instance:getTotemList()

	self._scrollList:reloadData(list)
	self:_removeTimer()
	self:_addTimer()
end

function FamilytotemView:_addTimer()
	settimer(1, self._onTimer, self)
end

function FamilytotemView:_onTimer()
	self._scrollList:refresh()
end

function FamilytotemView:_removeTimer()
	removetimer(self._onTimer, self)
end

function FamilytotemView:clearCell(cell)
	local icon = goutil.findChild(cell, "icon")

	GameUtil.rmClickHandler(cell)
	uGuiUtil.clearImage(icon)
end

function FamilytotemView:_updateCell(view, cell, data, tag)
	local icon = goutil.findChild(cell, "icon")
	local imgActive = goutil.findChild(cell, "imgActive")
	local txt = goutil.findChildTextComponent(cell, "txt")
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local txtActive = goutil.findChildTextComponent(cell, "imgActive/txt")
	local txtCost = MaterialMgr.findGraphicText(cell, "txtCost")
	local txtD = goutil.findChild(cell, "txtD")
	local imgGold = goutil.findChild(cell, "imgGold")

	txt.text = data.desc
	txtTime.text = langPara("持续时间:<color=#0C9729>%s分钟</color>", checknumber(data.effectTimes) / 60)
	txtActive.text = "未激活"
	txtCost.text = ""

	GameUtil.SetActive(txtD, false)
	GameUtil.SetActive(imgGold, false)
	uGuiUtil.setSpriteToImage(icon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("views/jiazu", data.icon))

	local info = self._totemMap[data.totemId]

	if info then
		txtActive.text = "已激活"

		local now = ServerTime.now()
		local left = checknumber(info.expireTime) / 1000 - now
		local time = GameUtil.FormatTimeSymbol(left)

		txtTime.text = langPara("剩余时间:<color=#0C9729>%s</color>", time)
	else
		GameUtil.SetActive(txtD, true)
		GameUtil.SetActive(imgGold, true)

		txtCost.text = "x" .. data.costFamilyMoney
	end

	GameUtil.setUIImageSpriteIdx(imgActive, info ~= nil and 1 or 0)
	GameUtil.addClickHandler(cell, GameUtil.handler(self._onClickTotem, self, data))
end

function FamilytotemView:_onClickTotem(data)
	local info = self._totemMap[data.totemId]

	if info == nil then
		if FamilyModel.instance:isFamilyChief() then
			local icon = MaterialMgr.getContentMatCfg(MatType.Coin, MatType.Coin_Family_Money, 30, -6, MaterialMgr.ICON_TYPE_ICON)
			local content = langPara("是否消耗%sx%s激活该图腾效果\n(开启后持续%s秒)", icon, data.costFamilyMoney, data.effectTimes)

			TipsFacade.instance:openPopupCostMatViewNew(MatType.Coin, MatType.Coin_Family_Money, data.costFamilyMoney, content, function()
				local list = {}

				table.insert(list, data.totemId)
				FamilyController.instance:sendInvokeFamilyTotemInfoReq(list, data.costFamilyMoney)
			end)
		else
			TipsFacade.instance:openCommonTips("请联系族长或副族长激活图腾")
		end
	else
		TipsFacade.instance:openCommonTips("该图腾已激活")
	end
end

return FamilytotemView
