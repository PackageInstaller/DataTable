-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characteranchor/view/ComposeItemView.lua

module("logic.extensions.characteranchor.view.ComposeItemView", package.seeall)

local M = class("ComposeItemView", ViewComponent)

function M:buildUI()
	self._pieceIcon = self:getImage("complex_contract_tips_795635541")
	self._pieceNumTxt = self:getText("complex_contract_tips_686811011")
	self._pieceBtn = self:getBtn("complex_contract_tips_874720850")
	self._itemIcon = self:getImage("complex_contract_tips_425623306")
	self._itemNumTxt = self:getText("complex_contract_tips_988342030")
	self._itemBtn = self:getBtn("complex_contract_tips_833158010")
	self._reduceBtn = self:getBtn("complex_contract_tips_705943468")
	self._addBtn = self:getBtn("complex_contract_tips_1415410205")
	self._inputFiled = self:getInput("complex_contract_tips_-1656326600")
	self._composeBtn = self:getBtn("complex_contract_tips_-514232796")
end

function M:bindEvents()
	self._inputFiled:AddOnValueChanged(self._onInputValueChange, self)
	self._pieceBtn:AddClickListener(self._onClickPieceBtn, self)
	self._itemBtn:AddClickListener(self._onClickItemBtn, self)
	self._addBtn:AddClickListener(self._onClickAddBtn, self)
	self._reduceBtn:AddClickListener(self._onClickReduceBtn, self)
	self._composeBtn:AddClickListener(self._onClickComposeBtn, self)
end

function M:unbindEvents()
	self._inputFiled:RemoveOnValueChanged()
	self._pieceBtn:RemoveClickListener()
	self._itemBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._composeBtn:RemoveClickListener()
end

function M:_onInputValueChange()
	local count = tonumber(self._inputFiled:GetText())

	count = count or self._composeCount

	if count * self._needPieceCount > self._pieceData:getCount() then
		self._composeCount = math.floor(self._pieceData:getCount() / self._needPieceCount)
	elseif count <= 0 then
		-- block empty
	else
		self._composeCount = count
	end

	self:_refreshComposePanel()
end

function M:_onClickPieceBtn()
	return
end

function M:_onClickItemBtn()
	return
end

function M:_onClickComposeBtn()
	ContractAgent.instance:sendHeroComposeRequest(self._pieceId, self._composeCount)
	self:back()
end

function M:_onClickAddBtn()
	if self._pieceData:getCount() >= self._needPieceCount * (self._composeCount + 1) then
		self._composeCount = self._composeCount + 1
	else
		FloatWordMgr.instance:show(lang("tip_lack_of_debris"))
	end

	self:_refreshComposePanel()
end

function M:_onClickReduceBtn()
	if self._composeCount > 1 then
		self._composeCount = self._composeCount - 1
	end

	self:_refreshComposePanel()
end

function M:onEnter()
	self._pieceId = self:getFirstParam()
	self._pieceData = ItemModel.instance:getItemsByItemId(self._pieceId)[1]
	self._itemId = tonumber(self._pieceData:getExtrInfo())
	self._itemData = ItemModel.instance:getItemsByItemId(self._itemId)[1]

	if not self._itemData then
		self._itemData = ItemData.New({
			count = 0,
			itemId = self._itemId
		})
	end

	self._heroId = self._itemData:getItemInfo().heroId

	printWarn("self._heroId", self._heroId, self._itemId)

	self._heroData = HeroDepotModel.instance:getHeroInfoByID(self._heroId)

	local heroPieceCO = HeroPieceConfig.instance:getInfo(self._heroData:getQuality())

	if heroPieceCO then
		self._needPieceCount = heroPieceCO.pieceNum
	end

	IconLoader.setSprite(self._pieceIcon, IconType.ItemIcon, self._pieceData:getIcon())
	IconLoader.setSprite(self._itemIcon, IconType.ItemIcon, self._itemData:getIcon())

	self._composeCount = 1

	self:_refreshComposePanel()
end

function M:_refreshComposePanel()
	self._pieceNumTxt.text = string.format("%d/%d", self._needPieceCount * self._composeCount, self._pieceData:getCount())

	self._inputFiled:SetText(self._composeCount)

	self._itemNumTxt.text = self._composeCount
end

return M
