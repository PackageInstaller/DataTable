-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/stack/ItempetpiecestackView.lua

module("logic.extensions.itembag.stack.ItempetpiecestackView", package.seeall)

local ItempetpiecestackView = class("ItempetpiecestackView", ViewComponent)

function ItempetpiecestackView:ctor()
	ItempetpiecestackView.super.ctor(self)
end

function ItempetpiecestackView:buildUI()
	ItempetpiecestackView.super.buildUI(self)

	self.layoutGroup = self:getGo("info/btnsGrid"):GetComponent("GridLayoutGroup")
	self.layoutGroup.enabled = false
	self._sellButton = self:getBtn("info/btnsGrid/BtnSell")
	self._useButton = self:getBtn("info/btnsGrid/BtnUse")
	self._mergeButton = self:getBtn("info/btnsGrid/BtnMerge")
	self._sourceBtn = self:getBtn("info/btnSource")
	self._nameTxt = self:getTxt("info/txtName")
	self.group = self:getGo("info/txtName"):GetComponent("UIChangeGroup")
	self._descTxt = self:getGo("info/bottom/ScrollView/Viewport/content/txtDesc"):GetComponent("Text")
	self.itemCell = self:getGo("info/icon")
	self.ImgC_Line = self:getGo("info/ImgC_Line")
	self.prize = self:getGo("info/bottom/price")
	self._sellTip = self:getTxt("info/bottom/price/txtPrice")
	self._txtExt = self:getTxt("info/bottom/txtExt")
	self._scroll = self:getGo("info/bottom/ScrollView"):GetComponent("ScrollRect")
	self._viewport = self:getGo("info/bottom/ScrollView/Viewport")
	self.progress = self:getGo("info/progress")

	if self.progress then
		self.imgProgress = goutil.findChildComponent(self.progress, "imgProgress", "Image")
		self.txtProgress = goutil.findChildComponent(self.progress, "txtProgress", "Text")
	end
end

function ItempetpiecestackView:bindEvents()
	ItempetpiecestackView.super.bindEvents(self)
	self._sellButton:AddClickListener(self._onClickSell, self)
	self._useButton:AddClickListener(self._onClickUse, self)
	self._mergeButton:AddClickListener(self._onClickMerge, self)
	self._sourceBtn:AddClickListener(self._onClickSource, self)
end

function ItempetpiecestackView:unbindEvents()
	ItempetpiecestackView.super.unbindEvents(self)
	self._sellButton:RemoveClickListener()
	self._useButton:RemoveClickListener()
	self._mergeButton:RemoveClickListener()
	self._sourceBtn:RemoveClickListener()
end

function ItempetpiecestackView:destroyUI()
	ItempetpiecestackView.super.destroyUI(self)
end

function ItempetpiecestackView:onEnter()
	ItempetpiecestackView.super.onEnter(self)
	self:_refreshList()
	GlobalDispatcher:addListener(ItemBagModel.UPDATE_SELECT_ITEM, self._refreshList, self)
end

function ItempetpiecestackView:onEnterFinished()
	ItempetpiecestackView.super.onEnterFinished(self)
end

function ItempetpiecestackView:onExit()
	ItempetpiecestackView.super.onExit(self)
	MaterialMgr.clearIcon(self.itemCell)
	GlobalDispatcher:removeListener(ItemBagModel.UPDATE_SELECT_ITEM, self._refreshList, self)
end

function ItempetpiecestackView:onExitFinished()
	ItempetpiecestackView.super.onExitFinished(self)
end

function ItempetpiecestackView:_onClickSell()
	local data = ItemBagModel.instance:getCurrItem()

	UIStateManager.instance:open(ViewName.Itemproc, ItemProcView.TYPE_SOLD, data)
end

function ItempetpiecestackView:_onClickUse()
	local data = ItemBagModel.instance:getCurrItem()

	UIStateManager.instance:open(ViewName.Itemproc, ItemProcView.TYPE_USED, data)
end

function ItempetpiecestackView:_onClickMerge()
	local data = ItemBagModel.instance:getCurrItem()

	if data == nil then
		return
	end

	local cfg = MaterialMgr.getMatCfg(data.type, data.id)

	if cfg then
		local curNum = MaterialFacade.instance:getMatNumber(data.type, data.id)
		local needNum = cfg.needPieceNum

		if needNum <= curNum then
			PetAgent.instance:sendPM_CompositePetPiecesReq(data.id, function(msg)
				FloatWordMgr.instance:show(lang("合成成功"))
				self:_refreshList()
			end, self)
		else
			FloatWordMgr.instance:show(lang("碎片不足，不能合成"))
		end
	end
end

function ItempetpiecestackView:_onClickSource()
	local data = ItemBagModel.instance:getCurrItem()

	MaterialMgr.openGetSourceByData(data)
end

function ItempetpiecestackView:_refreshList()
	local data = ItemBagModel.instance:getCurrItem()
	local type = MaterialMgr.getMoType(data)

	if type == MatType.PetPiece then
		self:_refreshTip(data)
	end
end

function ItempetpiecestackView:_refreshTip(data)
	GameUtil.SetActive(self._sourceBtn, false)

	self._txtExt.text = ""
	self._nameTxt.text = ""
	self._descTxt.text = ""

	self.itemCell.gameObject:SetActive(false)
	self.progress.gameObject:SetActive(false)
	GameUtil.SetActive(self.prize, false)
	GameUtil.SetActive(self.ImgC_Line, false)
	self.group:SetState(0)
	self._sellButton.gameObject:SetActive(false)
	self._useButton.gameObject:SetActive(false)
	self._mergeButton.gameObject:SetActive(true)

	self._sellTip.text = ""

	GameUtil.setHeight(self._viewport, 200)

	if data == nil or data.id == nil or data.id < 0 then
		return
	end

	local view

	if data.type == MatType.PetPiece then
		local cfg = MaterialMgr.getMatCfg(data.type, data.id)

		if cfg then
			self.progress.gameObject:SetActive(true)
			self.itemCell.gameObject:SetActive(true)
			MaterialMgr.setIcon(self.itemCell, data.type, data.id)

			self._nameTxt.text = MaterialMgr.getMaterialsName(data.type, data.id)
			self._descTxt.text = cfg.name .. lang("的精灵碎片")

			local rare = CharacterConfig.instance:getRareByAwakenLv(cfg.initAwakenLv, cfg.raceId)

			self.group:SetState(1 + (rare or 0))
			GameUtil.SetActive(self._sourceBtn, true)

			local curPieceNum = MaterialFacade.instance:getMatNumber(MatType.PetPiece, cfg.raceId)
			local needPieceNum = checknumber(cfg.needPieceNum)

			if self.imgProgress then
				if needPieceNum > 0 then
					self.imgProgress.fillAmount = curPieceNum / needPieceNum or 0
				end
			end

			if self.txtProgress then
				self.txtProgress.text = string.format("<size=18>%s/</size>%s", curPieceNum, needPieceNum)
			end
		end
	end

	self._scroll.verticalNormalizedPosition = 1

	self.layoutGroup:CalculateLayoutInputHorizontal()
	self.layoutGroup:CalculateLayoutInputVertical()
	self.layoutGroup:SetLayoutHorizontal()
	self.layoutGroup:SetLayoutVertical()
end

return ItempetpiecestackView
