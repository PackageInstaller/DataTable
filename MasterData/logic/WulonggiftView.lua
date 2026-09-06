-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/WulonggiftView.lua

module("logic.extensions.itembag.view.WulonggiftView", package.seeall)

local WulonggiftView = class("WulonggiftView", ViewComponent)

function WulonggiftView:ctor()
	WulonggiftView.super.ctor(self)
end

function WulonggiftView:buildUI()
	WulonggiftView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnSure = self:getGo("btnSure")
	self.txtTitle = self:getTxt("txtTitle")

	local cell = self:getGo("cell")
	local scroll = self:getGo("ScrollView")

	self.scrollGo = goutil.findChildComponent(self.mainGO, "ScrollView", "ScrollRect")
	self.scrollList = ScrollerList.create(scroll, cell, GameUtil.handler(self.updateCell, self), GameUtil.handler(self.clearCell, self))
	self.empty = self:getGo("reward/empty")

	local cell2 = self:getGo("reward/cell")
	local scroll2 = self:getGo("reward/tableview")

	self.rewardScrollList = ScrollerList.create(scroll2, cell2, GameUtil.handler(self.updateRewardCell, self), GameUtil.handler(self.clearRewardCell, self))
end

function WulonggiftView:bindEvents()
	WulonggiftView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnSure, self._onClickSure, self)
end

function WulonggiftView:unbindEvents()
	WulonggiftView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnSure)
end

function WulonggiftView:destroyUI()
	WulonggiftView.super.destroyUI(self)
end

function WulonggiftView:onEnter()
	WulonggiftView.super.onEnter(self)

	self.selectItem = nil
	self._itemData = self._viewPresentor._openParam[1]

	self.scrollList:regReloadFinish(GameUtil.handler(self.reloadEnd, self))
	self:refreshUI()
	self:refreshReward()

	local cfg = self._viewPresentor._openParam[2]

	self.txtTitle.text = lang("奖励选择")

	if cfg and not string.nilorempty(cfg.title) then
		self.txtTitle.text = cfg.title
	end
end

function WulonggiftView:onEnterFinished()
	WulonggiftView.super.onEnterFinished(self)
end

function WulonggiftView:onExit()
	WulonggiftView.super.onExit(self)
	self.scrollList:dispose()
	self.rewardScrollList:dispose()
end

function WulonggiftView:onExitFinished()
	WulonggiftView.super.onExitFinished(self)
end

function WulonggiftView:refreshUI()
	local cfg = MaterialConfig.instance:getCfgByMatAndId(self._itemData.type, self._itemData.id)
	local content = cfg.content
	local arr = string.split(content, ";")

	self.scrollList:reloadData(arr)

	local len = #arr

	self.scrollGo:GetComponent("RectTransform").sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)
	self.scrollGo.viewport.sizeDelta = Vector2.New(math.min(1085, 186 * len), 356)

	GameUtil.setAnchoredPos(self.scrollGo, 0, 50)
end

function WulonggiftView:reloadEnd()
	return
end

function WulonggiftView:clearRewardCell(cell)
	MaterialMgr.resetAll(cell)
end

function WulonggiftView:updateRewardCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell)
end

function WulonggiftView:setModelImg(faceId, con)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(faceId))

	if not modelCo then
		printError("t_model id not exist:" .. faceId)

		return
	end

	uGuiUtil.setSpriteToImage(con.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function WulonggiftView:clearCell(cell)
	local con = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(con)
	GameUtil.rmClickHandler(cell)
end

function WulonggiftView:updateCell(view, cell, data)
	local imgSelect = goutil.findChild(cell, "imgSelect")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local item = goutil.findChild(cell, "mask/item")

	GameUtil.SetActive(imgSelect, self.selectItem == data)

	local temp = string.split(data, "#")
	local petStr = temp[1]

	for i, v in ipairs(temp) do
		local aa = string.split(v, ":")
		local tt = checknumber(aa[1])

		if tt == MatType.Pet then
			petStr = v

			break
		end
	end

	local arr = string.split(petStr, ":")
	local matType = checknumber(arr[1])
	local cfgId = checknumber(arr[2])

	txtName.text = MaterialMgr.getMaterialsName(matType, cfgId)

	self:setModelImg(cfgId, item)
	GameUtil.addClickHandler(cell, GameUtil.handler(self.onItemClick, self, data))
end

function WulonggiftView:onItemClick(data)
	self.selectItem = data

	self.scrollList:refresh()
	self:refreshReward()
end

function WulonggiftView:refreshReward()
	local arr = {}

	if not string.nilorempty(self.selectItem) then
		arr = string.split(self.selectItem, "#")
	end

	self.rewardScrollList:reloadData(arr)
	GameUtil.SetActive(self.empty, #arr == 0)
end

function WulonggiftView:_onClickSure()
	if not string.nilorempty(self.selectItem) then
		local name1 = MaterialMgr.getMaterialsName(self._itemData.type, self._itemData.id)
		local temp = string.split(self.selectItem, "#")
		local narr = {}

		for i, v in ipairs(temp or {}) do
			local arr = string.split(v, ":")
			local matType = checknumber(arr[1])
			local cfgId = checknumber(arr[2])
			local num2 = checknumber(arr[#arr])
			local na = MaterialMgr.getMaterialsName(matType, cfgId)

			table.insert(narr, na .. "x" .. num2)
		end

		local name2 = table.concat(narr, "，")

		TipsFacade.instance:openPopupWindow(lang("tip"), langPara("是否把%s兑换成%s?", name1, name2), GameUtil.handler(self.sendMsg, self))
	else
		TipsFacade.instance:openCommonTips(lang("请先选择你想兑换的精灵"))
	end
end

function WulonggiftView:sendMsg()
	if not string.nilorempty(self.selectItem) then
		local obj = {
			item = self.selectItem
		}
		local num = 1

		MaterialFacade.instance:useItem(self._itemData.type, self._itemData.id, num, GameUtil.jsonToString(obj), GameUtil.handler(self.close, self))
	end
end

return WulonggiftView
